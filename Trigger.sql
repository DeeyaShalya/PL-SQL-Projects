use practical_project;
CREATE TABLE IF NOT EXISTS course_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255),
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //

CREATE TRIGGER course_added_trigger AFTER INSERT ON courses
FOR EACH ROW
BEGIN
    INSERT INTO course_logs (message)
    VALUES (CONCAT('New course added: ', NEW.course_name, ' (ID: ', NEW.course_id, ')'));
END;
//

DELIMITER ;

SELECT * FROM course_logs;
INSERT INTO course_logs (message) VALUES ('Testing course log entry');