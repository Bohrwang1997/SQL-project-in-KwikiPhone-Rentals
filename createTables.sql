CREATE TABLE PhoneModel (
  modelNumber TEXT,
  modelName TEXT,
  storage INTEGER,
  colour TEXT,
  baseCost REAL,
  dailyCost REAL,
  UNIQUE(modelNumber, modelName),
  PRIMARY KEY (modelNumber));

CREATE TABLE Customer (
  customerId INTEGER PRIMARY KEY,
  customerName TEXT,
  customerEmail TEXT);
CREATE TABLE Phone (
  modelNumber TEXT,
  modelName TEXT,
  IMEI TEXT PRIMARY KEY CHECK (LENGTH(IMEI) = 15
  AND ((CAST(SUBSTR(IMEI, 1, 1) AS INT) +
        2 * CAST(SUBSTR(IMEI, 2, 1) AS INT) / 10 +
        2 * CAST(SUBSTR(IMEI, 2, 1) AS INT) % 10 +
        CAST(SUBSTR(IMEI, 3, 1) AS INT) +
        2 * CAST(SUBSTR(IMEI, 4, 1) AS INT) / 10 +
        2 * CAST(SUBSTR(IMEI, 4, 1) AS INT) % 10 +
        CAST(SUBSTR(IMEI, 5, 1) AS INT) +
        2 * CAST(SUBSTR(IMEI, 6, 1) AS INT) / 10 +
        2 * CAST(SUBSTR(IMEI, 6, 1) AS INT) % 10 +
        CAST(SUBSTR(IMEI, 7, 1) AS INT) +
        2 * CAST(SUBSTR(IMEI, 8, 1) AS INT) / 10 +
        2 * CAST(SUBSTR(IMEI, 8, 1) AS INT) % 10 +
        CAST(SUBSTR(IMEI, 9, 1) AS INT) +
        2 * CAST(SUBSTR(IMEI, 10, 1) AS INT) / 10 +
        2 * CAST(SUBSTR(IMEI, 10, 1) AS INT) % 10 +
        CAST(SUBSTR(IMEI, 11, 1) AS INT) +
        2 * CAST(SUBSTR(IMEI, 12, 1) AS INT) / 10 +
        2 * CAST(SUBSTR(IMEI, 12, 1) AS INT) % 10 +
        CAST(SUBSTR(IMEI, 13, 1) AS INT) +
        2 * CAST(SUBSTR(IMEI, 14, 1) AS INT) / 10 +
        2 * CAST(SUBSTR(IMEI, 14, 1) AS INT) % 10 +
        CAST(SUBSTR(IMEI, 15, 1) AS INT)) % 10 = 0)),
  FOREIGN KEY (modelNumber, modelName) REFERENCES PhoneModel(modelNumber, modelName));


CREATE TABLE rentalContract (
  customerId INTEGER,
  IMEI TEXT,
  dateOut TEXT PRIMARY KEY,
  dateBack TEXT,
  rentalCost REAL,
  FOREIGN KEY (customerId) REFERENCES Customer(customerId),
  FOREIGN KEY (IMEI) REFERENCES Phone(IMEI) ON DELETE SET NULL);