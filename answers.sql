-- Question 1: Transforming ProductDetail table to 1NF
-- Original table violates 1NF by having multiple values in Products column

-- Step 1: Create normalized table structure
CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Step 2: Insert decomposed records (one product per row)
INSERT INTO OrderProducts_1NF (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Verify 1NF table
SELECT * FROM OrderProducts_1NF;

-- Question 2: Transforming OrderDetails table to 2NF
-- Original table violates 2NF with partial dependency (CustomerName depends only on OrderID)

-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderItems table (contains only full dependencies)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Populate normalized tables
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Verify 2NF structure
SELECT * FROM Orders;
SELECT * FROM OrderItems;
