

-- Since January 1st, how many impressions and clicks has each campaign
-- generated across all platforms? How much has each campaign cost?
SELECT
	campaign,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(cost) AS cost
FROM marketing.digital_ad_performance
WHERE `date` >= '2022-01-01'
GROUP BY campaign;


-- What is the daily cost per click for each platform, 
-- over all campaigns?
SELECT
	`date`,
	ad_source,
    ROUND(SUM(cost)/SUM(clicks),2) AS cost_per_click
FROM marketing.digital_ad_performance
GROUP BY `date`, ad_source
ORDER BY `date` DESC;


SELECT
*
FROM marketing.digital_ad_performance;

