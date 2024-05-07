USE SportsShop
--1--
CREATE TRIGGER MyTrigger1 ON WareHouse
AFTER UPDATE
AS
BEGIN
    INSERT INTO LastProduct (ProductName, PRICE)
    SELECT inserted.ProductName,inserted.PRICE  FROM inserted,deleted WHERE inserted.Id=deleted.Id
END

--FOR TO CHECK--

UPDATE WareHouse
SET Quantity=Quantity-1
WHERE Quantity=2

SELECT*
FROM WareHouse

SELECT*
FROM LastProduct


--2--

CREATE TRIGGER MyTrigger2 ON WareHouse
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NewProduct NVARCHAR(100)=(SELECT WareHouse.ProductName FROM inserted,WareHouse WHERE WareHouse.ProductName=inserted.ProductName)
	IF @NewProduct IS NOT NULL
	BEGIN
    UPDATE WareHouse
    SET Quantity = WareHouse.Quantity + inserted.Quantity
    FROM WareHouse 
    JOIN inserted  ON WareHouse.ProductName = inserted.ProductName AND WareHouse.PRICE=inserted.PRICE
	END
END

--FOR TO CHECK--
INSERT INTO WareHouse(ProductName,Quantity,PRICE) VALUES('Pullover Hoodie',2,$74.99)

SELECT*
FROM WareHouse

--3--
CREATE TRIGGER MyTrigger3 ON Employees
AFTER DELETE 
AS
BEGIN
  INSERT INTO EmployeeArchive(EmployeesFullName,EmployeesCategory)
  SELECT CONCAT(deleted.FirstName,' ',deleted.LastName), EmployeeCategory FROM deleted JOIN Categories ON deleted.CategoryId=Categories.Id
END

 --FOR TO CHECK--

DELETE 
FROM Employees
WHERE Id=3

SELECT*
FROM Employees

SELECT*
FROM EmployeeArchive

--4--

CREATE TRIGGER MyTrigger4 ON Employees
INSTEAD OF INSERT
AS
BEGIN
   IF (SELECT COUNT(Employees.Id) FROM Employees WHERE Employees.CategoryId=1) < 6
   BEGIN
     INSERT INTO Employees( Employees.FirstName,Employees.LastName,Employees.CategoryId)
	 SELECT inserted.FirstName,inserted.LastName,inserted.CategoryId FROM inserted
   END
END

--FOR TO CHECK--

INSERT INTO Employees(FirstName,LastName,CategoryId) VALUES('David','Beckham',1)
INSERT INTO Employees(FirstName,LastName,CategoryId) VALUES('Victoria','Beckham',1)
INSERT INTO Employees(FirstName,LastName,CategoryId) VALUES('James','Beckham',1)
INSERT INTO Employees(FirstName,LastName,CategoryId) VALUES('Cruz','Beckham',1)

SELECT*
FROM Employees

--5--

CREATE TRIGGER MyTrigger5 ON WareHouse
INSTEAD OF INSERT
AS
 BEGIN
  DECLARE @ProductName NVARCHAR(100)=(SELECT inserted.ProductName FROM inserted WHERE ProductName IN ('Scooter', 'Skateboard', 'Hoverboard'))
  IF @ProductName IS NULL
  BEGIN
   INSERT INTO  WareHouse(ProductName,Quantity,PRICE)
   SELECT inserted.ProductName,inserted.Quantity,inserted.PRICE FROM inserted
  END
 END
 --FOR TO CHECK--

INSERT INTO WareHouse(ProductName,Quantity,PRICE) VALUES('Skateboard',1,$31.37)
INSERT INTO WareHouse(ProductName,Quantity,PRICE) VALUES('Pickleball',1,$50.99)

SELECT*
FROM WareHouse

--6--

CREATE TRIGGER MyTrigger6 ON WareHouse
AFTER UPDATE 
AS
BEGIN
   INSERT INTO ProductArchive(ProductName,Price)
   SELECT WareHouse.ProductName,WareHouse.PRICE FROM WareHouse  WHERE Quantity=1
END

--FOR TO CHECK--

UPDATE WareHouse
SET Quantity=Quantity-1
WHERE Id=6

SELECT*
FROM ProductArchive

 
