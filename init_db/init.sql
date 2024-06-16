-- Create Users table
CREATE TABLE IF NOT EXISTS Users (
    u_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    is_seller BOOLEAN NOT NULL,
    address VARCHAR(255),
    mob_no VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Notes table
CREATE TABLE IF NOT EXISTS Notes (
    note_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT NOT NULL,
    subject_id INT NOT NULL,
    note TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES Users(u_id),
    FOREIGN KEY (subject_id) REFERENCES Users(u_id)
);

-- Create Purchases table
CREATE TABLE IF NOT EXISTS Purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    time DATETIME NOT NULL,
    buyer_id INT NOT NULL,
    seller_id INT NOT NULL,
    qty FLOAT NOT NULL,
    total_price FLOAT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_id) REFERENCES Users(u_id),
    FOREIGN KEY (seller_id) REFERENCES Users(u_id)
);

-- Create Milk Prices table
CREATE TABLE IF NOT EXISTS MilkPrices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    time DATETIME NOT NULL,
    seller_id INT NOT NULL,
    price FLOAT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES Users(u_id)
);

-- Additional indexes can be created if necessary, for example on time columns
CREATE INDEX idx_purchase_time ON Purchases(time);
CREATE INDEX idx_milkprice_time ON MilkPrices(time);
