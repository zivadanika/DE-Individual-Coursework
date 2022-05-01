create schema wine_database;
set schema 'wine_database';

drop table if exists wine cascade;
drop table if exists grapes cascade;
drop table if exists winery cascade;
drop table if exists price cascade;

CREATE TABLE "wine" (
  "wine_id" int PRIMARY KEY,
  "name" text,
  "winery_id" text,
  "vintage" int,
  "bottle_size" int,
  "grapes" text,
  "rating" float
);

CREATE TABLE "winery" (
  "winery_id" text PRIMARY KEY,
  "winery_name" text,
  "company_name" text,
  "address" text,
  "city" text,
  "country" text,
  "year_of_foundation" int
);

CREATE TABLE "price" (
  "wine_id" int,
  "name" text,
  "price" float,
  "discount" float
);

CREATE TABLE "grapes" (
  "grape_id" text PRIMARY KEY,
  "grape" text,
  "primary_flavours" text,
  "taste_profile" text,
  "food_pairing" text,
  "temperature" text,
  "glass_type" text,
  "decant" text,
  "cellar" text
);

ALTER TABLE "price" ADD FOREIGN KEY ("wine_id") REFERENCES "wine" ("wine_id");

ALTER TABLE "wine" ADD FOREIGN KEY ("winery_id") REFERENCES "winery" ("winery_id");

ALTER TABLE "wine" ADD FOREIGN KEY ("grapes") REFERENCES "grapes" ("grape_id");
