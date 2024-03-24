use practical_project;
DELIMITER //

CREATE FUNCTION get_student_course_info(student_id_in INT) RETURNS VARCHAR(500)
DETERMINISTIC
BEGIN
    DECLARE student_info VARCHAR(500);

    SELECT 
        CONCAT('Student Name: ', 
               (SELECT student_name FROM students WHERE student_id = student_id_in),
               ', Course Code: ', 
               (SELECT course_id FROM enrollments WHERE student_id = student_id_in),
               ', Course Name: ', 
               (SELECT course_name FROM courses WHERE course_id = (SELECT course_id FROM enrollments WHERE student_id = student_id_in))
              ) INTO student_info;

    IF student_info IS NULL THEN
        RETURN 'Student not found';
    ELSE
        RETURN student_info;
    END IF;
END //

DELIMITER ;

SELECT get_student_course_info(2);