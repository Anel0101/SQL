#1задание

SELECT t.ID_client,
DATE_FORMAT(t.date_new, '%Y-%m') AS month_year,
COUNT(*) AS num_transactions,
SUM(t.Sum_payment) AS total_sum
FROM transactions t
WHERE t.date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY t.ID_client, month_year;

SELECT ID_client, 
COUNT(*) AS total_transactions
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY ID_client;

SELECT ID_client, 
ROUND(SUM(Sum_payment) / COUNT(*), 2) AS avg_check
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY ID_client;

#2задание

SELECT DATE_FORMAT(date_new, '%Y-%m') AS month_year,
ROUND(SUM(Sum_payment) / COUNT(*), 2) AS avg_check_per_month
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY month_year
ORDER BY month_year;

SELECT DATE_FORMAT(date_new, '%Y-%m') AS month_year,
ROUND(COUNT(*) / 12, 2) AS avg_transactions_per_month
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY month_year
ORDER BY month_year;

SELECT DATE_FORMAT(date_new, '%Y-%m') AS month_year,
COUNT(DISTINCT ID_client) AS unique_clients_per_month
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY month_year
ORDER BY month_year;

SELECT DATE_FORMAT(date_new, '%Y-%m') AS month_year,
COUNT(*) AS transactions_per_month,
ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM transactions 
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'), 2) AS transactions_share
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY month_year
ORDER BY month_year;

SELECT DATE_FORMAT(date_new, '%Y-%m') AS month_year,
SUM(Sum_payment) AS total_sum_per_month,
ROUND(SUM(Sum_payment) * 100 / (SELECT SUM(Sum_payment) FROM transactions 
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'), 2) AS sum_share
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY month_year
ORDER BY month_year;

SELECT DATE_FORMAT(t.date_new, '%Y-%m') AS month_year, c.Gender,
COUNT(*) AS transactions_count,
ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (PARTITION BY DATE_FORMAT(t.date_new, '%Y-%m')), 2) AS transactions_share,
SUM(t.Sum_payment) AS total_spent,
ROUND(SUM(t.Sum_payment) * 100 / SUM(SUM(t.Sum_payment)) OVER (PARTITION BY DATE_FORMAT(t.date_new, '%Y-%m')), 2) AS spending_share
FROM transactions t
JOIN customers c 
ON t.ID_client = c.Id_client
WHERE t.date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY month_year, c.gender
ORDER BY month_year, c.gender;

#3заданиеalter

SELECT 
    CASE 
        WHEN c.age IS NULL THEN 'Unknown'
        WHEN c.age < 20 THEN '10-19'
        WHEN c.age < 30 THEN '20-29'
        WHEN c.age < 40 THEN '30-39'
        WHEN c.age < 50 THEN '40-49'
        WHEN c.age < 60 THEN '50-59'
        WHEN c.age < 70 THEN '60-69'
        ELSE '70+' 
    END AS age_group,
    YEAR(t.date_new) AS year,
    QUARTER(t.date_new) AS quarter,
    
COUNT(*) AS total_transactions,
SUM(t.Sum_payment) AS total_sum,
    
ROUND(AVG(t.Sum_payment), 2) AS avg_check,
ROUND(COUNT(*) / COUNT(DISTINCT t.ID_client), 2) AS avg_transactions_per_client,

ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions), 2) AS transaction_share,
ROUND(SUM(t.Sum_payment) * 100.0 / (SELECT SUM(Sum_payment) FROM transactions), 2) AS spending_share

FROM transactions t
JOIN customers c 
ON t.ID_client = c.ID_client
GROUP BY age_group, year, quarter
ORDER BY year, quarter, age_group;












