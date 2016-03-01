exec AddSchool
@SchoolName = 'information school',
@SchoolDescr = 'very popular'
select * from SCHOOL

exec AddDepartment
@DeptName = 'informatics',
@DSchoolName = 'information school',
@DeptAbbName = 'info'
select * from DEPARTMENT


exec AddQuarter
@QuarterName = 'summer',
@QuarterDescr = null
select * from QUARTER

exec AddCourse
@CourseName = '200',
@DeptName = 'informatics'
SELECT * FROM COURSE


exec AddInstructor
@InstructoRFName = 'greg',
@InstructorLNmae = 'hay'
SELECT * FROM INSTRUCTOR


exec AddClass
@QuarterName = 'summer',
@CourseName = '200'
SELECT * FROM CLASS


exec AddSection
@InFName = 'greg',
@InLName = 'hay',
@Section = 'a',
@YEAR = 2015
SELECT * FROM SECTION


exec AddLogin
@Name = 'yangf6',
@Password ='MIEmie940416',
@Reminder ='MIEmie940416'


exec AddStudent
@StudentFName = 'fan',
@StudentLName = 'yang'

exec AddReveiw_Rating
@RatingA = '3.5',
@RatingB = '4.0',
@RatingC = '3.5',
@Descr = 'generally good'

exec AddReview
@LoginName = 'yangf6',
@Quarter = 'summer',
@Course = '200',
@Section = 'a',
@Year = 2015,
@DeptName = 'informatics',
@InstrcutorFName ='greg',
@InstructorLName = 'hay'
SELECT * FROM REVIEW
