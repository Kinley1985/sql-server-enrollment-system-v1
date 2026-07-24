/*
======================================================================

Database Name : ES_db
Project       : Enrollment System

Purpose:
    - Stores student information.
    - Stores teacher information.
    - Stores subject information.
    - Records student enrollments.

Learning Objectives:
    - Learn Primary Keys.
    - Learn Foreign Keys.
    - Understand table relationships.
    - Practice SQL Server database design.
    - Prepare a strong SQL foundation for Data Engineering.

======================================================================
*/

USE master;

GO

-- Create Database

IF DB_ID ('ES_db') IS NULL

BEGIN
CREATE DATABASE
    ES_db;

END;

GO

USE ES_db;

GO


/*  ==============================================================

        Table Name: Students
    ===============================================================
       
       Purpose:
            - Store student information 
            - Each student has a unique Student ID
            - student_id is the Primary Key

        Note: 
            This table serves as the parent table and is referenced
            by the enrollment table through a Foreign Key.
          
    ==================================================================
 */ 




IF OBJECT_ID('dbo.students', 'U') IS NULL


BEGIN

CREATE TABLE
    students(
        student_id VARCHAR(10) NOT NULL,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        gender VARCHAR(10) CHECK(gender IN('Male','Female')) NOT NULL,
        CONSTRAINT pk_students PRIMARY KEY(student_id)  
    );

END;

GO

-- Insert Student information

INSERT INTO  
    students (student_id,first_name, last_name, gender)
VALUES
             ('ST001', 'Juan', 'Dela Cruz', 'Male'),
             ('ST002', 'Maria', 'Santos', 'Female'),
             ('ST003', 'Pedro', 'Reyes', 'Male'),
             ('ST004', 'Ana', 'Cruz', 'Female'),
             ('ST005', 'Carlo', 'Garcia', 'Male')


GO

/*  ==============================================================

        Table Name: Teachers
    ===============================================================
       
       Purpose:
            - Store teacher information 
            - Each teacher has a unique Teacher ID
            - teacher_id is the Primary Key

        Note: 
            
        This table serves as the parent table and is referenced
        by the subjects table through a Foreign Key.

        One teacher can handle multiple subjects.       
    ==================================================================
 */ 

IF OBJECT_ID('dbo.teachers', 'U') IS NULL

BEGIN

CREATE TABLE
    teachers(
        teacher_id VARCHAR(10) NOT NULL,
        teacher_name VARCHAR(100) NOT NULL,
        department VARCHAR(100) NOT NULL,
        CONSTRAINT pk_teachers 
        PRIMARY KEY(teacher_id)
    
    );

END;

GO

-- Insert teacher information

INSERT INTO 
    teachers(teacher_id, teacher_name, department)
VALUES
            ('T001', 'Mr. Santos', 'Mathematics'),
            ('T002', 'Ms. Reyes', 'English'),
            ('T003', 'Mr. Gracia', 'Science'),
            ('T004', 'Mr. Cayabyab', 'Music'),
            ('T005', 'Ms. Ferriols', 'Values')


GO 

/*  ==============================================================

        Table Name: Subjects
    ===============================================================
       
       Purpose:
            - Store subject information 
            - Each subject has a unique Subject ID
            - subject_id is the Primary Key

        Note: 

        Each subject is assigned to one teacher.

        This table is referenced by the enrollment and grades
        tables through Foreign Keys.
            
    ==================================================================
 */ 

IF OBJECT_ID('dbo.subjects','U') IS NULL

BEGIN

CREATE TABLE 
    subjects(
        subject_id VARCHAR(10) NOT NULL,
        subject_name VARCHAR(100) NOT NULL,
        units INT NOT NULL, 
        teacher_id VARCHAR(10) NOT NULL,
        CONSTRAINT pk_subjects
        PRIMARY KEY(subject_id),
        CONSTRAINT fk_subjects_teachers
        FOREIGN KEY(teacher_id)
        REFERENCES teachers(teacher_id)
    );

END;

GO

-- Insert subject information

INSERT INTO 
    subjects (subject_id, subject_name, units, teacher_id)
VALUES
             ('SUB001', 'College Algebra', 3, 'T001'),
             ('SUB002', 'English 1', 3, 'T002'),
             ('SUB003', 'General Science', 4, 'T003'),
             ('SUB004', 'Statistics', 3, 'T001'),
             ('SUB005', 'Music & Arts', 3, 'T004'),
             ('SUB006', 'Values Education', 3, 'T005');



GO

/*  ==============================================================

        Table Name: Grades
    ===============================================================
       
       Purpose:
            - Store grade information 
            - Each grade has a unique Grade ID
            - grade_id is the Primary Key

        Note: 

        This table stores the final grade of each student
        for every enrolled subject.

        It references the students and subjects tables
        through Foreign Keys.
                       
    ==================================================================
 */ 

IF OBJECT_ID('dbo.grades', 'U') IS NULL

BEGIN
CREATE TABLE
	grades(
		grade_id VARCHAR(10) NOT NULL,
		student_id VARCHAR(10) NOT NULL,
		subject_id VARCHAR(10) NOT NULL,
		final_grades DECIMAL(10,2) NOT NULL,
		created_at DATETIME2 DEFAULT  GETDATE(),

		CONSTRAINT pk_grades 
		PRIMARY KEY(grade_id),

		CONSTRAINT fk_grades_students
		FOREIGN KEY(student_id)
		REFERENCES students(student_id),

		CONSTRAINT fk_grades_subjects
		FOREIGN KEY(subject_id)
		REFERENCES subjects(subject_id)
	);

END;

GO

--Insert grade information

INSERT INTO 
	grades(grade_id, student_id, subject_id, final_grades)
VALUES
		('G001', 'ST001', 'SUB001', 89.27),
		('G002', 'ST001', 'SUB002', 81.05),
		('G003', 'ST001', 'SUB003', 78.01),
		('G004', 'ST001', 'SUB004', 74.22),
		('G005', 'ST001', 'SUB005', 79.29),
		('G006', 'ST001', 'SUB006', 75.12),
		('G007', 'ST002', 'SUB001', 91.23),
		('G008', 'ST002', 'SUB002', 87.05),
		('G009', 'ST002', 'SUB003', 89.01),
		('G0010', 'ST002', 'SUB004', 92.22),
		('G0011', 'ST002', 'SUB005', 91.29),
		('G0012', 'ST002', 'SUB006', 95.12),
		('G0013', 'ST003', 'SUB001', 79.15),
		('G0014', 'ST003', 'SUB002', 81.05),
		('G0015', 'ST003', 'SUB003', 87.01),
		('G0016', 'ST003', 'SUB004', 73.22),
		('G0017', 'ST003', 'SUB005', 79.29),
		('G0018', 'ST003', 'SUB006', 78.12),
		('G0019', 'ST004', 'SUB001', 77.11),
		('G0020', 'ST004', 'SUB002', 81.05),
		('G0021', 'ST004', 'SUB003', 78.01),
		('G0022', 'ST004', 'SUB004', 74.22),
		('G0023', 'ST004', 'SUB005', 71.29),
		('G0024', 'ST004', 'SUB006', 72.12),
		('G0025', 'ST005', 'SUB001', 93.27),
		('G0026', 'ST005', 'SUB002', 92.05),
		('G0027', 'ST005', 'SUB003', 95.01),
		('G0028', 'ST005', 'SUB004', 91.22),
		('G0029', 'ST005', 'SUB005', 95.29),
		('G0030', 'ST005', 'SUB006', 96.12)
		
GO


/*  ==============================================================

        Table Name: Enrollment
    ===============================================================
       
       Purpose:
            - Store enrollment information 
            - Each enrollment has a unique Enrollment ID
            - enrollment_id is the Primary Key

        Note: 

        This table records the subjects enrolled by each student
        for a specific semester and school year.

        It references the students and subjects tables
        through Foreign Keys.
            
       
    ==================================================================
 */ 


IF OBJECT_ID('dbo.enrollment', 'U') IS NULL

BEGIN
CREATE TABLE
    enrollment(
        enrollment_id VARCHAR(10) NOT NULL,
        student_id VARCHAR(10) NOT NULL,
        subject_id VARCHAR(10) NOT NULL,
        semester VARCHAR(20) CHECK (semester IN('1st_Sem', '2nd_Sem')) NOT NULL,
        school_year VARCHAR(10) NOT NULL,
        year_level VARCHAR(50) CHECK (year_level  IN('1st_year', '2nd_year', '3rd_year', '4th_year')) NOT NULL,
        units INT CHECK(units > 0) NOT NULL,
        amount_per_unit DECIMAL(10,2) NOT NULL,
        date_enrolled DATE NOT NULL,
        status VARCHAR(50) CHECK (status IN('Enrolled', 'Pending')) DEFAULT 'Pending',
        created_at DATETIME2 DEFAULT GETDATE(),

        CONSTRAINT pk_enrollment
        PRIMARY KEY(enrollment_id),

        CONSTRAINT fk_enrollment_students
        FOREIGN KEY(student_id)
        REFERENCES students(student_id),

        CONSTRAINT fk_enrollment_subjects
        FOREIGN KEY(subject_id)
        REFERENCES subjects(subject_id)        
    
    );


END;


GO

-- Insert enrollment information

INSERT INTO 
    enrollment(enrollment_id, student_id, subject_id,semester, school_year, year_level, units, amount_per_unit,date_enrolled, status)
VALUES
              ('EN001','ST001', 'SUB001', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN002','ST001', 'SUB002', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN003','ST001', 'SUB003', '1st_Sem','2026-2027', '1st_year', 4, 490.75,'2026-07-26', 'Enrolled'),
              ('EN004','ST001', 'SUB004', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN005','ST001', 'SUB005', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN006','ST001', 'SUB006', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN007','ST002', 'SUB001', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN008','ST002', 'SUB002', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN009','ST002', 'SUB003', '1st_Sem','2026-2027', '1st_year', 4, 490.75,'2026-07-26', 'Enrolled'),
              ('EN010','ST002', 'SUB004', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN011','ST002', 'SUB005', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN012','ST002', 'SUB006', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN013','ST003', 'SUB001', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN014','ST003', 'SUB002', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN015','ST003', 'SUB003', '1st_Sem','2026-2027', '1st_year', 4, 490.75,'2026-07-26', 'Enrolled'),
              ('EN016','ST003', 'SUB004', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN017','ST003', 'SUB005', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN018','ST003', 'SUB006', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN019','ST004', 'SUB001', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN020','ST004', 'SUB002', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN021','ST004', 'SUB003', '1st_Sem','2026-2027', '1st_year', 4, 490.75,'2026-07-26', 'Enrolled'),
              ('EN022','ST004', 'SUB004', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN023','ST004', 'SUB005', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN024','ST004', 'SUB006', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN025','ST005', 'SUB001', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN026','ST005', 'SUB002', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN027','ST005', 'SUB003', '1st_Sem','2026-2027', '1st_year', 4, 490.75,'2026-07-26', 'Enrolled'),
              ('EN028','ST005', 'SUB004', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN029','ST005', 'SUB005', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled'),
              ('EN030','ST005', 'SUB006', '1st_Sem','2026-2027', '1st_year', 3, 490.75,'2026-07-26', 'Enrolled')


