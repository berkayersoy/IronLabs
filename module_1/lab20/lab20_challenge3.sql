INSERT INTO Cars (VIN,Manufacturer,Model,Year,Color)
VALUES ("3K096I98581DHSNUP","Volkswagen","Tiguan",2019,"Blue"),
("ZM8G7BEUQZ97IH46V","Peugeot","Rifter",2019,"Red"),
("RKXVNNIHLVVZOUB4M","Ford","Fusion",2018,"White");

INSERT INTO Customers (Name,Phone,Email,Adress,City,State,Country,Postal)
VALUES ("Pablo Picasso", "+34 636 17 63 82", null, "Paseo de la Chopera, 14" ,"Madrid", "Madrid", "Spain", 28045),
("Abraham Lincoln", "+1 305 907 7086", null, "120 SW 8th St", "Miami", "Florida", "United States", 33130);

INSERT INTO Salespersons (Name,Store)
VALUES ("Petey Cruiser","Madrid"),
("Anna Sthesia","Barcelona"),
("Paul Molive","Berlin"),
("Gail Forcewind","Paris"),
("Paige Turner","Mimia");

INSERT INTO Invoices (InvoiceNumber, Date, VIN, CustomerID, StaffID)
VALUES (852399038,'2018-08-22',"3K096I98581DHSNUP",1,2),
(731166526,'2018-05-30',"ZM8G7BEUQZ97IH46V",2,3);