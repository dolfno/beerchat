-- -----------------------------------------------------
-- Table reporting.datapoints
-- -----------------------------------------------------
CREATE TABLE "reporting"."datapoints"(
    "id" serial PRIMARY KEY,
    "timestamp" timestamp NOT NULL,
    "name" varchar NOT NULL,
    "value" int8 NOT NULL,
    "opco" varchar DEFAULT NULL,
    "site" varchar DEFAULT NULL,
    "work_center" varchar DEFAULT NULL
);

