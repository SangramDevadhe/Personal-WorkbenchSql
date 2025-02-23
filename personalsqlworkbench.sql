-- 1. Users Table (Stores user information)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert records into Users table
INSERT INTO Users (username, email, password) VALUES
('user1', 'user1@example.com', 'password1'),
('user2', 'user2@example.com', 'password2'),
('user3', 'user3@example.com', 'password3'),
('user4', 'user4@example.com', 'password4'),
('user5', 'user5@example.com', 'password5');

-- 2. Databases Table (Stores database connection information)
CREATE TABLE Databases (
    db_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    db_type VARCHAR(50) NOT NULL,
    host VARCHAR(100),
    port INT,
    db_name VARCHAR(100) NOT NULL,
    username VARCHAR(50),
    password VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert records into Databases table
INSERT INTO Databases (user_id, db_type, host, port, db_name, username, password) VALUES
(1, 'SQLite', '', 0, 'test.db', '', ''),
(2, 'MySQL', 'localhost', 3306, 'test_db', 'root', 'root'),
(3, 'PostgreSQL', 'localhost', 5432, 'test_db', 'postgres', 'postgres'),
(4, 'SQLite', '', 0, 'sample.db', '', ''),
(5, 'MySQL', 'localhost', 3306, 'sample_db', 'root', 'root');

-- 3. Queries Table (Stores SQL queries executed by users)
CREATE TABLE Queries (
    query_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    db_id INT,
    query_text TEXT NOT NULL,
    execution_time FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (db_id) REFERENCES Databases(db_id)
);

-- Insert records into Queries table
INSERT INTO Queries (user_id, db_id, query_text, execution_time) VALUES
(1, 1, 'SELECT * FROM Users;', 0.01),
(2, 2, 'SELECT * FROM Databases;', 0.02),
(3, 3, 'SELECT * FROM Queries;', 0.03),
(4, 4, 'SELECT * FROM QueryResults;', 0.04),
(5, 5, 'SELECT * FROM SyntaxHighlighting;', 0.05);

-- 4. QueryResults Table (Stores results of executed queries)
CREATE TABLE QueryResults (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    query_id INT,
    result_format VARCHAR(50) NOT NULL,
    result_data TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (query_id) REFERENCES Queries(query_id)
);

-- Insert records into QueryResults table
INSERT INTO QueryResults (query_id, result_format, result_data) VALUES
(1, 'CSV', 'user_id,username,email,password,created_at\n1,user1,user1@example.com,password1,2025-02-23 00:00:00\n2,user2,user2@example.com,password2,2025-02-23 00:00:00'),
(2, 'JSON', '[{"db_id":1,"user_id":1,"db_type":"SQLite","host":"","port":0,"db_name":"test.db","username":"","password":"","created_at":"2025-02-23 00:00:00"}]'),
(3, 'Excel', '...'), -- Excel data would be binary, represented here as '...'
(4, 'CSV', 'result_id,query_id,result_format,result_data,created_at\n1,1,CSV,...'),
(5, 'JSON', '[{"rule_id":1,"language":"SQL","pattern":"SELECT","style":"keyword","created_at":"2025-02-23 00:00:00"}]');

-- 5. SyntaxHighlighting Table (Stores syntax highlighting rules)
CREATE TABLE SyntaxHighlighting (
    rule_id INT AUTO_INCREMENT PRIMARY KEY,
    language VARCHAR(50) NOT NULL,
    pattern VARCHAR(100) NOT NULL,
    style VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert records into SyntaxHighlighting table
INSERT INTO SyntaxHighlighting (language, pattern, style) VALUES
('SQL', 'SELECT', 'keyword'),
('SQL', 'FROM', 'keyword'),
('SQL', 'WHERE', 'keyword'),
('SQL', 'INSERT', 'keyword'),
('SQL', 'UPDATE', 'keyword');

-- 6. AutoCompletion Table (Stores auto-completion suggestions)
CREATE TABLE AutoCompletion (
    suggestion_id INT AUTO_INCREMENT PRIMARY KEY,
    language VARCHAR(50) NOT NULL,
    suggestion VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert records into AutoCompletion table
INSERT INTO AutoCompletion (language, suggestion) VALUES
('SQL', 'SELECT'),
('SQL', 'FROM'),
('SQL', 'WHERE'),
('SQL', 'INSERT'),
('SQL', 'UPDATE');