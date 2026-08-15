-- Creating Tables -- Books, Customers, Orders 
-- Books Table

DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10, 2),
	Stock INT
);

--Customers Table

DROP TABLE IF EXISTS Cutomers;
CREATE TABLE Customers (
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

--Orders Table

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
)

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



---Importing Data From CSV Files

---Import Data Into Books Data

--This was imported in psql because it wasn't running here 

 \copy Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) FROM 'C:/Users/mohdf/Downloads/Books.csv' DELIMITER ',' CSV HEADER;

-- Now running these queries to check and confirm

SELECT * FROM Books;

SELECT * FROM Books LIMIT 10;

SELECT COUNT(*) FROM Books;



---Import Data Into Customers Data

--This was imported in psql because it wasn't running here 

\copy Customers(Customer_ID, Name, Email, Phone, City, Country) FROM 'C:/Users/mohdf/Downloads/Customers.csv' DELIMITER ',' CSV HEADER;

-- Now running these queries to check and confirm

SELECT * FROM Customers;

SELECT * FROM Customers LIMIT 10;

SELECT COUNT(*) FROM Customers;



---Import Data Into Orders Data

--This was imported in psql because it wasn't running here 

\copy Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) FROM 'C:/Users/mohdf/Downloads/Orders.csv' DELIMITER ',' CSV HEADER;

-- Now running these queries to check and confirm


SELECT * FROM Orders;

SELECT * FROM Orders LIMIT 10;

SELECT COUNT(*) FROM Orders;


--- Till Here All Three Tables In The Database "Online_Bookstore" Has Been Created
---And We Have Imported Data In These 3 Tables Through SQL SHELL(psql)
---And We Modified The File Path After Copying Using Front Slash i.e "/"
---We Executed The "\copy" with file name and path in a single line only
---The Orders Data OR Table Has Customer_ID and Book_ID Because..
---Tables Must Have At Least One Common Column With Same Column Name And Data Type
---This Is Neccessary To Establish Joins
--- _ID SERIAL PRIMARY KEY,- We Took "SERIAL" Here Because Our Data Is In Serial Wise, We Can Take "INT" Also If We Want
---We Have Assigned Foriegn_Key Using 
---"Customer_ID INT REFERENCES Customers(Customer_ID)
---Book_ID INT REFERENCES Books(Book_ID),"
--REFERENCES Showing That We Have Customer_Id And Book_Id In Customer And Book Table
--- Before Creating These 2 Table We Cannot Give Reference and After Giving Reference If We Try DROP These 2 Tables It Wont Be DROPPED And It Will Throw An ERROR
--- When Deleting Table We Need To Delete The Reference Table First Then We Can Delete The Other Tables And Likewise

---QUERIES

-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 2) Find books published after the year 1950;=:

SELECT * FROM Books
WHERE Published_year>1950;

-- 3) List all the customers from Canada:

SELECT * FROM Customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023:

SELECT * FROM Orders
WHERE  order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:

SELECT SUM (stock) AS total_stock
FROM Books;

-- 6) Find the details of the most expensive book:

SELECT * FROM Books ORDER BY price DESC LIMIT 1;

---WE CAN ALSO GET TOP 2,3 EXPENSIVE BOOKS USING THIS QUERY

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders
WHERE quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Orders
WHERE total_amount>20;

---WE CAN ALSO RETRIEVE AMOUNT BETWEEN 20 AND 50 OR OTHER USING THE "BETWEEN" AND "AND" OPERATOR

SELECT * FROM Orders
WHERE total_amount BETWEEN 20 AND 50;

--9) List all genres available in the books table:

SELECT DISTINCT genre FROM Books;

--10) Find the books with the highest and lowest stock:

SELECT * FROM Books ORDER BY stock DESC;
SELECT * FROM Books ORDER BY stock ASC;

--BY LIMIT AND FORMAT

SELECT * FROM Books
ORDER BY stock DESC
LIMIT 1;

SELECT * FROM Books 
ORDER BY stock ASC
LIMIT 1;

--11) Calculate the total revenue generated from all books:

SELECT SUM(total_amount) AS revenue FROM Orders;


----ADVANCE QUESTIONS AND QUERIES

--- FROM HERE WE WILL BE DOING SOME COMPLEX QUERIES IN THIS PROJECT


-- 1) Retrieve the total number of books sold for each genre:


SELECT * FROM Orders;


-- The QUANTITY in orders table is the quantity sold not the qauntity available
--Here we dont have "genre" in orders but we have link with the table in which genre is available i.e "book_id"
-- Now we will use JOINS
-- We will add Abbrevations to books like "b.genre"

SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.genre;

---o.book_id = b.book_id- these 2 cols are common in both tables
---we assigned o to orders table and b to books table
--- In this question we want to see total books sold by each genre so we use GROUP BY clause and SUM of the quantity

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS average_price
FROM Books
WHERE genre = 'Fantasy';


-- 3) List customers who have placed atleast 2 orders:

SELECT customer_id, COUNT(order_id) AS order_count
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 2;

--IF WE WANT TO PRINT CUSTOMER NAMES WITH ORDER COUNT

SELECT o.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(order_id) >= 2;



---IF WE WANT TO RETRIEVE AUTHOR AND THE BOOK WHICH THEY WROTE WITH THEIR BOOK ID USING JOIN AND GROUP BY

SELECT o.book_id, b.author, b.title
FROM Orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.author, b.title;


-- 4)Find the most frequently ordered book:

SELECT book_id, COUNT(order_id) AS  order_count
FROM Orders
GROUP BY book_id
ORDER BY order_count DESC LIMIT 1;

---IF WE WANT THE BOOK NAME ALSO SO WE CAN WRITE IT AS

SELECT o.book_id, b.title, COUNT(o.order_id) AS  order_count
FROM Orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY order_count DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of "Fantasy" genre:

SELECT * FROM books
WHERE genre = 'Fantasy' 
ORDER BY price DESC LIMIT 3;

--- LEAST EXPENSIVE OR CHEAP

SELECT * FROM books
WHERE genre = 'Fantasy' 
ORDER BY price ASC LIMIT 3;

-- WE CAN EXTRACT ALL OTHER GENRES USING THE SAME QUERIES

SELECT * FROM books
WHERE genre = 'Romance' 
ORDER BY price DESC LIMIT 3;

--- LEAST EXPENSIVE OR CHEAP

SELECT * FROM books
WHERE genre = 'Romance' 
ORDER BY price ASC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS total_books_sold
FROM ORDERS o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.author;

---IT IS ALMOST SAME AS WE DID IN OUR FIRST ADVANCE QUERY AND WE CAN SEE THAT BELOW

SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM Orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;

---here we are using "DISTINCT" TO MAKE SURE IT DOES NOT SHOW US REPEATED CITIES, NAME AND ID'S

--IF WE WANT CUSTOMER NAAME AS WELL AS ID WE CAN WRITE THIS

SELECT DISTINCT c.city, c.name, c.customer_id, total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 100;

---Here we are using "DISTINCT" IN BOTH TO MAKE SURE IT DOES NOT SHOW US REPEATED CITIES, NAME AND ID'S
--IN THIS IT IS NOT MENTIONED TO SHOW US THE TOTAL AMOUNT BUT TO SHOW THE AMOUNT WE NEED TO INCLUDE THE "total_amount" COLUMN

-- 8) Find the customer who spent the most on orders:
-- We can take it as "BEST CUSTOMER" TO LIST THE BEST CUSTOMER

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 1;


-- 8) Find the customer who spent the LEAST on orders:
-- We can take it as "LEAST SPENT CUSTOMER"

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent ASC LIMIT 1;

---WE CAN ASLO GET TOP 5 MOST AND LEAST SPENT CUSTOMERS
--MOST SPENT
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 5;

--LEAST SPENT

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent ASC LIMIT 10;

-- 9) Calculate the stock remaining after fulfilling all orders:
--It Means after delivering the orders beacuse it is a online bookstore so here fulfilling means delivering or completing all the orders:
--STOCK AVAILABLE - ORDERS = REMAINING STOCK

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS ordered_quantity,  
		b.stock - COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM books b
LEFT JOIN Orders o ON o.book_id = b.book_id
GROUP BY b.book_id
ORDER BY b.book_id;


-- 10) Find Books Priced Above the Average Book Price using Subquery

SELECT DISTINCT
    book_id, 
    title, 
    author, 
    price
FROM Books
WHERE price > (SELECT AVG(price) FROM Books)
ORDER BY price DESC;

--OR

SELECT DISTINCT 
    book_id,
    title,
    author,
    ROUND(price, 2) AS price
FROM Books
WHERE price > (SELECT AVG(price) FROM Books)
ORDER BY price DESC;

---we can write both ways


-- 11) Find Top 5 Customers by Total Spending using Window Function

SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS rank_position
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY rank_position
LIMIT 5;


---THIS IS JUST TO EASILY RETREIVE THE DATA WHENEVER NEEDED

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;




