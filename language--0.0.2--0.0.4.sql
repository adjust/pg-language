CREATE OR REPLACE  FUNCTION language_lt(language, language)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charlt';
CREATE OR REPLACE  FUNCTION language_le(language, language)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charle';
CREATE OR REPLACE  FUNCTION language_eq(language, language)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'chareq';
CREATE OR REPLACE  FUNCTION language_neq(language, language)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charne';
CREATE OR REPLACE  FUNCTION language_ge(language, language)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charge';
CREATE OR REPLACE  FUNCTION language_gt(language, language)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'chargt';
CREATE OR REPLACE  FUNCTION hash_language(language)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'hashchar';
