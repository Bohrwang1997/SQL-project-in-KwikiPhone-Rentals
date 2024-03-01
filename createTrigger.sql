CREATE TRIGGER jisuancostdezuoye
AFTER UPDATE ON rentalContract
WHEN OLD.dateBack IS NULL 
AND NEW.dateBack IS NOT NULL 
AND NEW.rentalCost IS NULL
AND NOT EXISTS (SELECT 1402
 FROM rentalContract
 WHERE IMEI = NEW.IMEI
 AND customerId != NEW.customerId
 AND date(dateOut) = date(NEW.dateBack))
BEGIN UPDATE rentalContract
SET rentalCost = (SELECT round(((julianday(NEW.dateBack) - julianday(NEW.dateOut) + 1) *
                 (pm.dailyCost) + pm.baseCost), 2)
FROM PhoneModel pm
JOIN Phone p ON pm.modelNumber = p.modelNumber
WHERE p.IMEI = NEW.IMEI)
WHERE IMEI = NEW.IMEI AND dateOut = OLD.dateOut;
END;