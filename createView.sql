CREATE VIEW CustomerSummary AS
SELECT r.customerId, pm.modelName,
    round(SUM(julianday(r.dateBack) - julianday(r.dateOut) + 1),2) AS daysRented,
    CASE WHEN strftime('%m', dateBack) >= '07' AND strftime('%m', dateBack) <= '12'
        THEN CAST(strftime('%Y', dateBack) AS INTEGER) || '/' || substr((strftime('%Y', dateBack, '+1 year')), 3, 2)
        ELSE (CAST(strftime('%Y', dateBack) AS INTEGER) - 1) || '/' || substr((strftime('%Y', dateBack)), 3, 2)
    END AS taxYear,
    SUM(r.rentalCost) AS rentalCost
FROM rentalContract r
LEFT OUTER JOIN Phone p ON r.IMEI = p.IMEI
LEFT OUTER JOIN PhoneModel pm ON p.modelNumber = pm.modelNumber AND p.modelName = pm.modelName
WHERE r.dateBack IS NOT NULL AND r.IMEI IS NOT NULL
GROUP BY r.customerId, taxYear, pm.modelName
UNION
SELECT r.customerId,
    CASE WHEN r.IMEI IS NULL THEN pm.modelName is NULL ELSE pm.modelName END AS modelName,
    round(SUM(julianday(r.dateBack) - julianday(r.dateOut) + 1),2) AS daysRented,
    CASE WHEN strftime('%m', dateBack) >= '07' AND strftime('%m', dateBack) <= '12'
         THEN CAST(strftime('%Y', dateBack) AS INTEGER) || '/' || substr((strftime('%Y', dateBack, '+1 year')), 3, 2)
         ELSE (CAST(strftime('%Y', dateBack) AS INTEGER) - 1) || '/' || substr((strftime('%Y', dateBack)), 3, 2)
    END AS taxYear,
    SUM(r.rentalCost) AS rentalCost
from rentalContract r
LEFT OUTER JOIN Phone p ON r.IMEI = p.IMEI
LEFT OUTER JOIN PhoneModel pm ON p.modelNumber = pm.modelNumber AND p.modelName = pm.modelName
WHERE r.dateBack IS NOT NULL AND r.IMEI IS NULL
GROUP BY r.customerId, taxYear, pm.modelName