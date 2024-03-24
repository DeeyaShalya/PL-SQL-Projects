use practical_project;
DROP PROCEDURE IF EXISTS enroll_student_in_course;
DELIMITER //
CREATE PROCEDURE enroll_student_in_course(
    IN student_id_in INT,
    IN course_id_in INT
)
BEGIN
    DECLARE v_course_name VARCHAR(100);
    DECLARE v_enrollment_date DATE;

    -- Get the course name based on the provided course_id
    SELECT course_name INTO v_course_name
    FROM courses
    WHERE course_id = course_id_in;

    -- Get the enrollment date for the student and course
    SELECT enrollment_date INTO v_enrollment_date
    FROM enrollments
    WHERE student_id = student_id_in
    AND course_id = course_id_in;

    -- Check if enrollment exists and display the course name and enrollment date
    IF v_course_name IS NOT NULL AND v_enrollment_date IS NOT NULL THEN
        SELECT CONCAT('Course Name: ', v_course_name, ', Enrollment Date: ', v_enrollment_date) INTO @message;
    ELSE
        SELECT 'Error: Enrollment not found.' INTO @message;
    END IF;
END //
DELIMITER ;

CALL enroll_student_in_course(1, 101);
SELECT @message;