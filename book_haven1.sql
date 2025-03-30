-- Tạo database
DROP DATABASE IF EXISTS book_haven;
CREATE DATABASE book_haven;
USE book_haven;

-- Tạo bảng users	
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('admin', 'customer') DEFAULT 'customer'
);

-- Tạo bảng Supplier
CREATE TABLE Supplier (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
);

-- Tạo bảng Product_Category
CREATE TABLE Product_Category (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Created_Date DATE,
    Updated_Date DATE
);

-- Tạo bảng Product
CREATE TABLE Product (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name NVARCHAR(255),
    Price DECIMAL(10,2),
    Stock INT,
    Product_Description TEXT,
    Product_Category_ID INT,
    Supplier_ID INT,
    Product_img NVARCHAR(255),
    Author NVARCHAR(255),
    FOREIGN KEY (Product_Category_ID) REFERENCES Product_Category(Category_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(ID)
);

-- Tạo bảng Shopping_Cart
CREATE TABLE Shopping_Cart (
    Cart_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Quantity INT DEFAULT 1,
    Created_Date DATE DEFAULT (CURRENT_DATE),
    Updated_Date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (Customer_ID) REFERENCES users(id),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Tạo bảng Discount_Code
CREATE TABLE Discount_Code (
    Discount_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Discount_Percentage DECIMAL(5,2) NOT NULL,
    Is_Used BOOLEAN DEFAULT FALSE,
    Created_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Expiry_Date DATETIME NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES users(id)
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Order_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total_Amount DECIMAL(10, 2) NOT NULL,
    Order_Notes TEXT,
    Coupon_Code VARCHAR(50),
    Discount_Amount DECIMAL(10, 2) DEFAULT 0,
    Payment_Method VARCHAR(50) NOT NULL,
    Status ENUM('Pending', 'Processing', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (Customer_ID) REFERENCES users(id),
    FOREIGN KEY (Coupon_Code) REFERENCES Discount_Code(Code)
);

-- Tạo bảng Order_Details
CREATE TABLE Order_Details (
    Order_Detail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT CHECK (Quantity > 0),
    Unit_Price DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (Quantity * Unit_Price) STORED,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Tạo trigger để cập nhật Stock
DELIMITER //

CREATE TRIGGER UpdateStockOnOrder
AFTER INSERT ON Order_Details
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Lấy số lượng tồn kho hiện tại của sản phẩm
    SELECT Stock INTO current_stock
    FROM Product
    WHERE Product_ID = NEW.Product_ID;

    -- Kiểm tra số lượng tồn kho
    IF current_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sản phẩm không tồn tại.';
    ELSEIF current_stock < NEW.Quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng tồn kho không đủ để thực hiện đơn hàng.';
    ELSE
        -- Cập nhật số lượng tồn kho
        UPDATE Product
        SET Stock = Stock - NEW.Quantity
        WHERE Product_ID = NEW.Product_ID;
    END IF;
END //

DELIMITER ;

-- Tạo bảng Payment
CREATE TABLE Payment (
    Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT,
    Customer_ID INT,
    Amount DECIMAL(10,2),
    Method VARCHAR(50),
    Payment_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Customer_ID) REFERENCES users(id)
);

-- Tạo bảng Reviews
CREATE TABLE Reviews (
    Review_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
    Comment TEXT NOT NULL,
    Review_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES users(id)
);

-- Chèn dữ liệu vào bảng users
INSERT INTO users (name, email, password, Address, role) VALUES
('Nguyen Van A', 'a.nguyen@example.com', 'password123', '123 Đường Sách, Quận 1, TP.HCM', 'customer'),
('Tran Thi B', 'b.tran@example.com', 'password456', '456 Đường Văn, Quận 2, TP.HCM', 'customer'),
('Le Van Admin', 'admin1@example.com', 'adminpass1', '789 Đường Quản Lý, Quận 3, TP.HCM', 'admin'),
('Pham Thi Admin', 'admin2@example.com', 'adminpass2', '101 Đường Hành Chính, Quận 4, TP.HCM', 'admin'),
('admin', 'admin@gmail.com', 'admin', '101 Đường Hành Chính, Quận 4, TP.HCM', 'admin');

-- Chèn dữ liệu vào bảng Supplier
INSERT INTO Supplier (Name, Phone, Email) VALUES
('NXB Kim Đồng', '0123456789', 'kimdong@nxb.com'),
('NXB Trẻ', '0987654321', 'tre@nxb.com'),
('NXB Văn Học', '0912345678', 'vanhoc@nxb.com'),
('NXB Tổng Hợp', '0932145678', 'tonghop@nxb.com');

-- Chèn dữ liệu vào bảng Product_Category
INSERT INTO Product_Category (Name, Created_Date, Updated_Date) VALUES
('Tiểu thuyết', '2025-01-01', '2025-01-01'),
('Khoa học', '2025-01-01', '2025-01-01'),
('Trẻ em', '2025-01-01', '2025-01-01'),
('Lịch sử', '2025-01-01', '2025-01-01'),
('Self-help', '2025-01-01', '2025-01-01');

-- Chèn dữ liệu vào bảng Product
INSERT INTO Product (Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img, Author) VALUES
('Đắc Nhân Tâm', 120000.00, 50, 'Cuốn sách kinh điển về kỹ năng giao tiếp và ứng xử.', 5, 1, 'img/product/temp-12.jpg', 'Dale Carnegie'),
('Nhà Giả Kim', 95000.00, 30, 'Hành trình theo đuổi giấc mơ của một chàng chăn cừu.', 1, 2, 'img/product/temp-1.jpg', 'Paulo Coelho'),
('Dế Mèn Phiêu Lưu Ký', 75000.00, 100, 'Cuốn sách thiếu nhi nổi tiếng của Tô Hoài.', 3, 1, 'img/product/temp-2.jpg', 'Tô Hoài'),
('Sapiens: Lược Sử Loài Người', 220000.00, 20, 'Lịch sử loài người từ thời tiền sử đến hiện đại.', 4, 3, 'img/product/temp-3.jpg', 'Yuval Noah Harari'),
('Tư Duy Nhanh Và Chậm', 180000.00, 25, 'Khám phá cách con người ra quyết định.', 5, 4, 'img/product/temp-4.jpg', 'Daniel Kahneman'),
('Bí Mật Tư Duy Triệu Phú', 110000.00, 40, 'Học cách tư duy để đạt được thành công tài chính.', 5, 2, 'img/product/temp-5.jpg', 'T. Harv Eker'),
('Hoàng Tử Bé', 85000.00, 60, 'Câu chuyện ý nghĩa về tình bạn và cuộc sống.', 3, 1, 'img/product/temp-6.jpg', 'Antoine de Saint-Exupéry'),
('Lược Sử Thời Gian', 150000.00, 15, 'Khám phá vũ trụ qua ngòi bút của Stephen Hawking.', 2, 3, 'img/product/temp-7.jpg', 'Stephen Hawking'),
('Cây Cam Ngọt Của Tôi', 90000.00, 35, 'Câu chuyện cảm động về tuổi thơ và tình yêu.', 1, 2, 'img/product/temp-8.jpg', 'José Mauro de Vasconcelos'),
('Hài Hước Một Chút Thế Giới Sẽ Khác Đi', 65000.00, 80, 'Tuyển tập truyện ngắn hài hước và sâu sắc.', 1, 4, 'img/product/temp-9.jpg', 'Fish Saucy'),
('Hài Hước Một Chút Thế Giới Sẽ Khác Đi', 65000.00, 80, 'Tuyển tập truyện ngắn hài hước và sâu sắc.', 1, 4, 'img/product/temp-9.jpg', 'Fish Saucy'),
('Hài Hước Một Chút Thế Giới Sẽ Khác Đi', 65000.00, 80, 'Tuyển tập truyện ngắn hài hước và sâu sắc.', 1, 4, 'img/product/temp-9.jpg', 'Fish Saucy'),
('Hài Hước Một Chút Thế Giới Sẽ Khác Đi', 65000.00, 80, 'Tuyển tập truyện ngắn hài hước và sâu sắc.', 1, 4, 'img/product/temp-9.jpg', 'Fish Saucy'),
('Hài Hước Một Chút Thế Giới Sẽ Khác Đi', 65000.00, 80, 'Tuyển tập truyện ngắn hài hước và sâu sắc.', 1, 4, 'img/product/temp-9.jpg', 'Fish Saucy'),
('Hài Hước Một Chút Thế Giới Sẽ Khác Đi', 65000.00, 80, 'Tuyển tập truyện ngắn hài hước và sâu sắc.', 1, 4, 'img/product/temp-9.jpg', 'Fish Saucy');

-- Chèn dữ liệu vào bảng Shopping_Cart
INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date, Updated_Date) VALUES
(1, 1, 2, '2025-03-12', '2025-03-22'),
(1, 2, 1, '2025-03-12', '2025-03-22'),
(2, 3, 3, '2025-03-12', '2025-03-22'),
(2, 4, 2, '2025-03-12', '2025-03-22'),
(3, 5, 4, '2025-03-14', '2025-03-22'),
(3, 6, 1, '2025-03-14', '2025-03-22'),
(1, 7, 2, '2025-03-15', '2025-03-23'),
(2, 8, 1, '2025-03-16', '2025-03-23'),
(3, 9, 3, '2025-03-16', '2025-03-23'),
(1, 10, 2, '2025-03-18', '2025-03-23');

-- Chèn dữ liệu vào bảng Discount_Code
INSERT INTO Discount_Code (Customer_ID, Code, Discount_Percentage, Is_Used, Expiry_Date) VALUES
(1, 'SAVE10', 10.00, FALSE, '2025-04-30'),
(2, 'SPRING20', 20.00, FALSE, '2025-05-15'),
(3, 'WELCOME15', 15.00, TRUE, '2025-03-31');

-- Chèn dữ liệu vào bảng Orders
INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Order_Notes, Coupon_Code, Discount_Amount, Payment_Method, Status) VALUES
(1, '2025-03-02', 250000.00, 'Giao hàng vào buổi sáng', NULL, 0.0, 'Cash', 'Pending'),
(2, '2025-03-05', 180000.00, 'Giao hàng nhanh', 'SAVE10', 18000.0, 'Credit Card', 'Processing'),
(3, '2025-03-05', 300000.00, 'Kiểm tra hàng trước khi nhận', NULL, 0.0, 'Online Banking', 'Delivered'),
(1, '2025-03-10', 220000.00, 'Liên hệ trước khi giao', 'SPRING20', 44000.0, 'Debit Card', 'Delivered'),
(2, '2025-03-13', 320000.00, 'Hàng dễ vỡ, xin nhẹ tay', NULL, 0.0, 'PayPal', 'Processing'),
(1, '2025-03-13', 200000.00, 'Giao vào buổi chiều', 'WELCOME15', 30000.0, 'Cash', 'Pending'),
(2, '2025-03-19', 280000.00, 'Yêu cầu kiểm tra kỹ', NULL, 0.0, 'Credit Card', 'Delivered'),
(3, '2025-03-20', 350000.00, 'Hàng dễ vỡ', NULL, 0.0, 'Online Banking', 'Processing'),
(1, '2025-03-23', 240000.00, 'Liên hệ sau 3h chiều', NULL, 0.0, 'Debit Card', 'Delivered'),
(2, '2025-03-24', 400000.00, 'Hàng cần gấp', 'SPRING20', 80000.0, 'PayPal', 'Pending');

-- Chèn dữ liệu vào bảng Order_Details
INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Unit_Price) VALUES
(1, 1, 2, 120000.00),  -- Đắc Nhân Tâm
(1, 2, 1, 95000.00),   -- Nhà Giả Kim
(2, 3, 3, 75000.00),   -- Dế Mèn Phiêu Lưu Ký
(3, 4, 1, 220000.00),  -- Sapiens
(4, 2, 2, 95000.00),   -- Nhà Giả Kim
(5, 1, 1, 120000.00),  -- Đắc Nhân Tâm
(6, 3, 2, 75000.00),   -- Dế Mèn Phiêu Lưu Ký
(7, 5, 1, 180000.00),  -- Tư Duy Nhanh Và Chậm
(8, 4, 2, 220000.00),  -- Sapiens
(9, 2, 3, 95000.00);   -- Nhà Giả Kim

-- Chèn dữ liệu vào bảng Payment
INSERT INTO Payment (Order_ID, Customer_ID, Amount, Method) VALUES
(1, 1, 250000.00, 'Cash'),
(2, 2, 162000.00, 'Credit Card'),
(3, 3, 300000.00, 'Online Banking'),
(4, 1, 176000.00, 'Debit Card'),
(5, 2, 320000.00, 'PayPal');

-- Chèn dữ liệu vào bảng Reviews
INSERT INTO Reviews (Product_ID, Customer_ID, Rating, Comment) VALUES
(1, 1, 5, 'Sách rất hay, đáng đọc!'),
(2, 1, 4, 'Câu chuyện ý nghĩa, nhưng giao hàng hơi chậm.'),
(3, 2, 3, 'Sách dành cho trẻ em, nội dung ổn.'),
(4, 3, 5, 'Cuốn sách tuyệt vời về lịch sử loài người!'),
(5, 1, 2, 'Nội dung không như kỳ vọng.');

-- Kiểm tra dữ liệu
SELECT * FROM users;
SELECT * FROM Supplier;
SELECT * FROM Product_Category;
SELECT * FROM Product;
SELECT * FROM Shopping_Cart;
SELECT * FROM Discount_Code;
SELECT * FROM Orders;
SELECT * FROM Order_Details;
SELECT * FROM Payment;
SELECT * FROM Reviews;

-- Kiểm tra Stock sau khi trigger chạy
SELECT Product_ID, Name, Stock FROM Product;

-- Kiểm tra truy vấn lấy danh sách sách
SELECT 
    p.Product_ID,
    p.Name,
    p.Price,
    p.Stock,
    p.Product_Description,
    pc.Name AS Category_Name,
    s.Name AS Supplier_Name,
    p.Product_img,
    p.Author
FROM Product p
LEFT JOIN Product_Category pc ON p.Product_Category_ID = pc.Category_ID
LEFT JOIN Supplier s ON p.Supplier_ID = s.ID;

ALTER TABLE shopping_cart DROP FOREIGN KEY shopping_cart_ibfk_2;
ALTER TABLE shopping_cart ADD CONSTRAINT shopping_cart_ibfk_2 
FOREIGN KEY (Product_ID) REFERENCES product(Product_ID) 
ON DELETE CASCADE;

ALTER TABLE order_details DROP FOREIGN KEY order_details_ibfk_2;
ALTER TABLE order_details ADD CONSTRAINT order_details_ibfk_2
FOREIGN KEY (Product_ID) REFERENCES product(Product_ID) ON DELETE CASCADE;

ALTER TABLE reviews DROP FOREIGN KEY reviews_ibfk_1;
ALTER TABLE reviews ADD CONSTRAINT reviews_ibfk_1
FOREIGN KEY (Product_ID) REFERENCES product(Product_ID) ON DELETE CASCADE;