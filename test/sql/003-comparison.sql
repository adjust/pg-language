SELECT 'ts' :: language <  'tt' :: language;

SELECT 'ts' :: language <= 'tt' :: language;

SELECT 'ts' :: language >  'tt' :: language;

SELECT 'tt' :: language >  'ts' :: language;

SELECT 'tt' :: language >= 'ts' :: language;

SELECT 'tt' :: language >  'tt' :: language;

SELECT 'tt' :: language >= 'tt' :: language;

SELECT 'tt' :: language =  'ts' :: language;

SELECT 'tt' :: language != 'ts' :: language;

SELECT 'tt' :: language != 'tt' :: language;

SELECT 'tt' :: language =  'tt' :: language;
