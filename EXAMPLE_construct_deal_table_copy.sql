/*
This code constructs a table called deal_pipeline using five source tables.
	- an initial web survey (optional)
    - first stage in Salesforce (required)
    - second stage in Salesforce (optional)
    - legacy system info (optional but only included if deal has reached second stage)
    - contact info for company partner associated with deal (optional)
    
Each row corresponds to an individual deal from when the customer starts the
application process to when the final sale is made. 

It first creates two intermediate tables, then joins them together with
some calculated fields for business reporting. 
*/

DROP TABLE IF EXISTS reporting_schema.temp1;

CREATE TABLE reporting_scehma.temp1 AS
	SELECT
		survey.survey_id,
        first_stage.first_stage_id,
        first_stage.second_stage_id,
        contacts.partner_id,
        
        first_stage.product,
        survey.ad_source,
        first_stage.deal_status,
        
        survey.survey_timestamp,
        first_stage.milestone1_timestamp,
        first_stage.milestone2_timestamp,
        
        contacts.partner_name,
        UPPER(contacts.state) AS partner_state
    FROM salesforce.first_stage
    LEFT JOIN website_data.survey
    ON first_stage.survey_id = survey.survey_id
    LEFT JOIN salesforce.contacts
    ON first_stage.partner_id = contacts.partner_id;
    
DROP TABLE IF EXISTS reporting_schema.temp2;

CREATE TABLE reporting_schema.temp2 AS
	SELECT
		second_stage.second_stage_id,
        legacy_data.customer_id AS old_system_id,
        
        second_stage.milestone3_timestamp,
        second_stage.milestone4_timestamp,
        second_stage.deal_status,
        second_stage.deal_amount,
        
        legacy_data.loan_type,
        legacy_data.interest_rate
    FROM salesforce.second_stage
    LEFT JOIN old_system.legacy_data
    ON second_stage.old_system_id = legacy_data.customer_id;
    
/*To make the final table, I join together temp1 and temp2. The table
 deal_pipeline is constructed as temp3 first and renamed, so that if
 the code is interrupted/encounters an error the
 previous day's table is not dropped.
*/ 
DROP TABLE IF EXISTS reporting_schema.temp3;

CREATE TABLE reporting_schema.temp3 AS
	SELECT
    -- ID columns
		t1.survey_id,
        t1.first_stage_id,
        t2.second_stage_id,
        t1.partner_id,
        t2.old_system_id,
        
	-- Deal information
		t1.product,
        t1.ad_source,
        COALESCE(second_stage.deal_status, first_stage.deal_status) AS deal_status,
        t2.deal_amount,
        t2.loan_type,
        t2.interest_rate,
        t1.partner_name,
        t1.partner_state,
        
    -- Timestamps
		FROM_UNIXTIME(t1.survey_timestamp) AS survey_timestamp,
        t1.milestone1_timestamp,
        t1.milestone2_timestamp,
        t2.milestone3_timestamp,
        t2.milestone4_timestamp
    FROM reporting_schema.temp1 t1
    LEFT JOIN reporting_schema.temp2 t2
    ON temp1.second_stage_id = temp2.second_stage_id;
    
DROP TABLE IF EXISTS reporting_schema.deal_pipeline;

RENAME TABLE reporting_schema.temp3 TO reporting_schema.deal_pipeline;