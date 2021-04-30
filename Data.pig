A = LOAD 'orders.csv' using PigStorage(',') AS
(id:chararray, cdID: int, dayPurch: int, hourPurch: int, pricePaid: int, salesPerson: int, storeID: int);

B = FOREACH A GENERATE pricePaid, salesPerson, storeID;

C = FILTER B by pricePaid == 14;

D = GROUP C by salesPerson;

E = FOREACH D GENERATE group, COUNT(C) AS High;

F = ORDER E BY High DESC;

G = LIMIT F 5;

STORE G INTO 'output';



DUMP G
