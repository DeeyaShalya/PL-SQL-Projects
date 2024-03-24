use practical_project;
DROP PROCEDURE IF EXISTS display_enrollments;
DELIMITER //

CREATE PROCEDURE display_enrollments()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_student_id INT;
    DECLARE v_course_id INT;
    DECLARE v_enrollment_date DATE;
    DECLARE cur CURSOR FOR 
        SELECT student_id, course_id, enrollment_date FROM enrollments;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;

    enrollments_loop: LOOP
        FETCH cur INTO v_student_id, v_course_id, v_enrollment_date;
        IF done THEN
            LEAVE enrollments_loop;
        END IF;
        
        -- Display Enrollment Details
        SELECT CONCAT('Student ID: ', v_student_id, ', Course ID: ', v_course_id, ', Enrollment Date: ', 
        v_enrollment_date) AS Enrollment_Details;
    END LOOP;
    CLOSE cur;
END //

DELIMITER ;

CALL display_enrollments();