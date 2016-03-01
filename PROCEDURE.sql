CREATE PROCEDURE AddSchool
@SchoolName VARCHAR(80),
@SchoolDescr VARCHAR(100)
AS
BEGIN
INSERT INTO SCHOOL(SchoolName,SchoolDescr)
VALUES(@SchoolName,@SchoolDescr)
END

CREATE PROCEDURE AddDepartment
@DeptName VARCHAR(70),
@DSchoolName VARCHAR(70),
@DeptAbbName VARCHAR(10)
AS 
BEGIN
DECLARE @SchoolID INT
SET @SchoolID = (SELECT SchoolID FROM SCHOOL S
                 WHERE S.SchoolName = @DSchoolName)
INSERT INTO DEPARTMENT(SchoolID, DeptName,DeptFullName)
VALUES (@SchoolID, @DeptName,@DeptAbbName)
END

CREATE PROCEDURE AddQuarter
@QuarterName VARCHAR(70),
@QuarterDescr VARCHAR(70)
AS
BEGIN
INSERT INTO QUARTER(QuarterName,QuarterDescr)
VALUES (@QuarterName,@QuarterDescr)
END

CREATE PROCEDURE AddCourse
@CourseName VARCHAR(70),
@DeptName VARCHAR(70)
AS 
BEGIN
DECLARE @DeptID INT = 0
SET @DeptID = (SELECT DeptID FROM DEPARTMENT 
               WHERE DeptName = @DeptName)
INSERT INTO COURSE(DeptID,CourseName)
VALUES (@DeptID,@CourseName)
END


CREATE PROCEDURE AddInstructor
@InstructoRFName VARCHAR(70),
@InstructorLNmae VARCHAR(70)
AS 
BEGIN
INSERT INTO INSTRUCTOR(InstructorFName,InstructorLName)
VALUES (@InstructoRFName,@InstructorLNmae)
END


CREATE PROCEDURE AddClass
@QuarterName VARCHAR(70),
@CourseName VARCHAR(70)
AS 
DECLARE @CourseID INT 
DECLARE @QuarterID INT
SET @CourseID = (SELECT CourseID from COURSE 
                 WHERE CourseName = @CourseName)
SET @QuarterID = (SELECT QuarterID FROM QUARTER
                 WHERE QuarterName = @QuarterName)
BEGIN
INSERT INTO CLASS(CourseID,QuarterID)
VALUES(@CourseID,@QuarterID)
END

CREATE PROCEDURE AddSection
@InFName VARCHAR(80),
@InLName VARCHAR(80),
@Section VARCHAR(10),
@YEAR DATETIME
AS
BEGIN
DECLARE @ClassID INT
DECLARE @InstructorID INT
SET @ClassID = (IDENT_CURRENT('CLASS'))
SET @InstructorID = (SELECT InstructorID FROM INSTRUCTOR I 
                     WHERE I.InstructorFName = @InFName AND
					 I.InstructorLName = @InLName)
INSERT INTO SECTION(ClassID, InstructorID,Section,YEAR)
VALUES (@ClassID,@InstructorID,@Section,@YEAR)
END

CREATE PROCEDURE AddLogin
@Name VARCHAR(80),
@Password VARCHAR(200),
@Reminder VARCHAR(200)
AS
BEGIN
INSERT INTO LOGIN(LoginName,LoginPassward,LoginReminder)
VALUES (@Name,@Password,@Reminder)
END
DROP PROCEDURE AddStudent

CREATE PROCEDURE AddStudent
@StudentFName VARCHAR(80),
@StudentLName VARCHAR(80)
AS 
DECLARE @LoginID INT
SET @LoginID = IDENT_CURRENT('LOGIN')
BEGIN
INSERT INTO STUDENT(LoginID,StudentFNmae,StudentLName)
VALUES (@LoginID,@StudentFName,@StudentLName)
END

DROP PROCEDURE AddRating
CREATE PROCEDURE AddReveiw_Rating
@RatingA VARCHAR(3),
@RatingB VARCHAR(3),
@RatingC VARCHAR(3),
@Descr VARCHAR(1000)
AS
BEGIN
INSERT INTO RATING(RatingA, RatingB, RatingC, ReviewDescr)
VALUES (@RatingA,@RatingB,@RatingC,@Descr)
END

CREATE PROCEDURE AddReview
@LoginName VARCHAR(80),
@Quarter VARCHAR(80),
@Course VARCHAR(80),
@Section VARCHAR(80),
@Year DATETIME,
@DeptName VARCHAR(80),
@InstrcutorFName VARCHAR(80),
@InstructorLName VARCHAR(80)
AS 
BEGIN
DECLARE @StudentID INT
DECLARE @RatingID INT
DECLARE @SectionID INT
DECLARE @InstructorID INT
DECLARE @ClassID INT
SET @RatingID = IDENT_CURRENT('RATING')
SET @StudentID = (SELECT StudentID FROM STUDENT S
                  JOIN LOGIN L ON L.LoginID = S.LoginID
				  WHERE L.LoginName = @LoginName)
SET @ClassID = (SELECT CL.ClassID FROM CLASS CL
                JOIN COURSE CO ON CL.CourseID = CO.CourseID
				JOIN QUARTER QU ON QU.QuarterID = CL.QuarterID
				JOIN DEPARTMENT DE ON DE.DeptID = CO.DeptID
				WHERE DE.DeptName = @DeptName
				AND CO.CourseName = @Course 
				AND QU.QuarterName = @Quarter)
SET @InstructorID = (SELECT InstructorID FROM INSTRUCTOR I
                     WHERE I.InstructorFName = @InstrcutorFName
					 AND I.InstructorLName = @InstructorLName)
SET @SectionID = (SELECT S.SectionID from SECTION S
                  WHERE S.ClassID = @ClassID
				  AND S.InstructorID = @InstructorID
				  AND S.Section = @Section
				  AND S.YEAR = @Year)
INSERT INTO REVIEW(RatingID,StudentID,SectionID,DateTi)
VALUES(@RatingID,@StudentID,@SectionID,GETDATE())
END


DROP PROCEDURE AddReview