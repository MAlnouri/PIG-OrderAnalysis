--loads orders data and stores columns
A = LOAD 'orders.csv' using PigStorage(',') AS
(id:chararray, cdID: int, dayPurch: int, hourPurch: int, pricePaid: int, salesPersonID: int, storeID: int);

--creates subset containing only relevant columns
B = FOREACH A GENERATE hourPurch, pricePaid, storeID;

--groups all purchases by their hours
C = GROUP B by hourPurch;

--counts number of purchases in any given hour
D = FOREACH C GENERATE group, COUNT(B) as Hour;

--orders the hours by lowest number of sales
E = ORDER D BY Hour ASC;

--picks top 5 highest selling hours
F = LIMIT E 5;

--stores data into file
STORE F INTO 'output2';



DUMP F
