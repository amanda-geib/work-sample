CREATE SCHEMA IF NOT EXISTS salesforce;
CREATE SCHEMA IF NOT EXISTS website_data;
CREATE SCHEMA IF NOT EXISTS old_system;

-- salesforce.leads, salesforce.qualified_leads, salesforce.contacts
-- website_data.survey
-- old_system.legacy_data


/* LEADS */

DROP TABLE IF EXISTS salesforce.leads;

CREATE TABLE IF NOT EXISTS salesforce.leads (
    lead_id VARCHAR(255) PRIMARY KEY,
    qualified_lead_id VARCHAR(255),
    survey_id VARCHAR(255),
    product VARCHAR(255),
    milestone1_timestamp TIMESTAMP,
    milestone2_timestamp TIMESTAMP,
    deal_status VARCHAR(255),
    deal_value DECIMAL,
    partner_id VARCHAR(255)
    );
	
    INSERT INTO 
		salesforce.leads(lead_id,qualified_lead_id,survey_id,product,
						milestone1_timestamp,milestone2_timestamp,
                        deal_status, deal_value, partner_id)
		VALUES
			('00Q01',NULL,NULL,'A','2014-02-21 19:28:27','2014-03-08 12:03:50','LOST','25000','00C04'),
            ('00Q02',NULL,NULL,'B','2017-05-30 20:05:00','2017-06-15 08:34:19','LOST','25000','00C04')
		;
        
    SELECT * FROM salesforce.leads ORDER BY milestone1_timestamp DESC;
    
    /* QUALIFIED LEADS */
	
    DROP TABLE IF EXISTS salesforce.qualified_leads;
    
    CREATE TABLE IF NOT EXISTS salesforce.qualified_leads(
		qualified_lead_id VARCHAR(255) PRIMARY KEY,
        old_system_id VARCHAR(255),
        milestone3_timestamp TIMESTAMP,
        milestone4_timestamp TIMESTAMP,
        milestone5_timestamp TIMESTAMP,
        deal_status VARCHAR(255),
        deal_value DECIMAL
    );
    
    SELECT * FROM salesforce.qualified_leads;
    
    /*CONTACTS*/
    DROP TABLE IF EXISTS salesforce.contacts;
    
    CREATE TABLE IF NOT EXISTS salesforce.contacts (
		partner_id VARCHAR(255) PRIMARY KEY,
        partner_name VARCHAR(255),
        city VARCHAR(255),
        state VARCHAR(255)
		);
        
	INSERT INTO 
		salesforce.contacts(partner_id, partner_name, city, state)
        
        VALUES 
			('00C01','Smith Co.','New York','NY'),
            ('00C02','Weston Inc.', 'Seattle', 'WA'),
            ('00C03','Sunshine Realty','Tampa','FL')
            ;
            
	SELECT * FROM salesforce.contacts;
    
    /* WEB SURVEY*/
    DROP TABLE IF EXISTS website_data.survey;
    
    CREATE TABLE IF NOT EXISTS website_data.survey(
		survey_id VARCHAR(255) PRIMARY KEY,
        survey_timestamp TIMESTAMP,
        ad_source VARCHAR(255)
    );
    
    INSERT INTO 
		website_data.survey(survey_id,survey_timestamp,ad_source)
        
        VALUES
			('S001', '2019-01-01 07:03:25', 'google'),
			('S002', '2019-05-06 12:20:49', 'bing'),
			('S003', '2020-09-05 15:50:37', 'google'),
			('S004', '2020-09-17 08:29:19', 'facebook'),
			('S005', '2021-04-28 05:36:07', 'bing'),
			('S006', '2021-11-02 12:08:11', 'facebook')
            ;
            
	SELECT * FROM website_data.survey;