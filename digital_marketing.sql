/* I give the table a temporary name and then rename it at the end of the
script. This way, if the code is interrupted/encounters an error, the previous 
day's table is not dropped until today's is ready to replace it. */

DROP TABLE IF EXISTS marketing.temp_ad_table;

CREATE TABLE marketing.temp_ad_table AS
SELECT
	g.date,
    'google' AS ad_source,
    g.campaign,
    g.impressions,
    g.clicks,
    -- Convert currency micro units to dollars
    ROUND((g.cost_micros/1000000),2) AS cost
FROM marketing.google_ads g

UNION

SELECT
	/* Bing Ads uses dd/mm/yyyy, which must be converted to YYYY-MM-DD to 
    match the format from Google and Facebook */
	DATE_FORMAT(b.date,'%Y-%m-%d') AS `date`,
    'bing' AS ad_source,
    -- Clean campaign name strings
    REGEXP_REPLACE(b.campaignname, 'bing_', '') AS campaign,
    b.impressions,
    b.clicks,
    b.spend AS cost
FROM marketing.bing_ads b

UNION

SELECT
	f.date_start AS `date`,
    'facebook' AS ad_source,
    -- Clean campaign name strings
	REGEXP_REPLACE(f.campaign_name, 'fb_', '') AS campaign,
    f.impressions,
    f.clicks,
    f.spend AS cost
FROM marketing.facebook_ads f;

DROP TABLE IF EXISTS martketing.digital_ad_performance;

RENAME TABLE marketing.temp_ad_table TO martketing.digital_ad_performance;
