USE MASTER 
GO

DROP DATABASE if exists eRecruitment
go 

CREATE DATABASE eRecruitment
go 

use eRecruitment
go

-- 1
CREATE TABLE [Roles]
(
	[role_id] int Identity(1,1) PRIMARY KEY NOT NULL,
	[role_name] NVARCHAR(100) NOT NULL

)
GO

INSERT INTO [Roles]
VALUES
(N'Admin'),(N'HR Staff'),(N'Interviewers'), (N'Candidate'), (N'Member'),
GO

-- 2
CREATE TABLE [Userss]
(
	[email] NVARCHAR(60) PRIMARY KEY NOT NULL,
	[name] NVARCHAR(60) NOT NULL,
	[role_id] int FOREIGN KEY REFERENCES dbo.[Role] DEFAULT(5) not null,
	[phone] varchar(11),
	[address] nvarchar(200)
)
GO

CREATE TABLE [Notify]
(
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[Users] not null,
	[title] NVARCHAR(100) not null,
	[content] text,
	[link] NVARCHAR(200),
	[date] datetime
)
GO

/*
INSERT INTO [Users]
VALUES
(),
GO
*/

-- 3
CREATE TABLE [Majors]
(
	[major_id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[major_name] NVARCHAR(100) NOT NULL,
)
GO



INSERT INTO [Majors]
VALUES
('Marketing'),('Logistic'),('Data Science and Analytics'),('Information Technology'),('Graphic Design'),
('Engineering'),('Risk Manager'),('Economic Finance'),('Business Intelligence and Development'),
('Operations')
GO


-- 4
CREATE TABLE [Interviewers]
(
	[inter_id] CHAR(3) PRIMARY KEY NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[Users] NOT NULL ,
	[major_id] int FOREIGN KEY REFERENCES dbo.[Majors] NOT NULL,
	[isAvailable] bit DEFAULT (0) NOT NULL
)
GO

/*
INSERT INTO [Interviewers]
VALUES
(),
GO
*/

-- 5
CREATE TABLE [HR_Staffs]
(
	[hr_id] CHAR(3) PRIMARY KEY NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[Users] NOT NULL
)
GO

/*
INSERT INTO [HR_Staffs]
VALUES
(),
GO
*/


CREATE TABLE [Levels]
(
	[level_id]  int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[level_name] NVARCHAR(10)  NOT NULL
)
GO

INSERT INTO [Levels]
VALUES
('Intern'),('Fresher'),('Junior'),('Seninor'),('Manager'),('Leader')


-- 6
CREATE TABLE [Jobs]
(
	[job_id] CHAR(4) PRIMARY KEY NOT NULL,
	[job_name] NVARCHAR(50) NOT NULL,
	[major_id] int FOREIGN KEY REFERENCES dbo.[Majors] NOT NULL,
	[job_vacancy] int NOT NULL,
	[job_description] text,
	[level_id] int FOREIGN KEY REFERENCES dbo.[Levels] NOT NULL,
	[salary] FLOAT not null,
	[post_date] DATE not null
)
GO

/*
INSERT INTO [Jobs]
VALUES
(),
GO
*/

-- 7
CREATE TABLE [Saved_jobs]
(
	[job_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Jobs] NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[Users] NOT NULL,
	UNIQUE([job_id],[email])
)
GO

/*
INSERT INTO [Saved_jobs]
VALUES
(),
GO
*/

-- 8
CREATE TABLE [Candidates]
(
	[can_id] CHAR(4) PRIMARY KEY NOT NULL,
	[job_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Jobs] NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[Users] NOT NULL,
	[can_cv] NVARCHAR(50) NOT NULL,-- comment 
	[isStatus] int DEFAULT (0) NOT NULL,
	/*	Note: 
		0 : HR hasn't accepted
		1 : HR had accepted
		2 : has Tested
		3 : has scheduled
		4 : has been Interviewed
		5 : Accepted
	*/
	UNIQUE([job_id],[email])
)
GO

/*
INSERT INTO [Member]
VALUES
(),
GO
*/

-- 9
CREATE TABLE [Skills]
(
	[skill_id] int Identity(1,1) PRIMARY KEY NOT NULL,
	[skill_name] NVARCHAR(100) UNIQUE NOT NULL,
	[skill_description] text
)
GO


INSERT INTO [Skills] ([skill_name])
VALUES
('JavaSript'),('Java'),('Python'),('C++'),('C#'),('UI/UX'),('HTML'),('Testing'),('React Native'),('Angular'),('Mobile Develope'),('Ruby'),('Rust'),('Golang'),('TypeScript'),('BrainFuck'),
('PHP'),('Unity'),('Unreal Engine'),
('Data Visualization'),('Data Cleaning'),('MATLAB'),('SQL and NoSQL'),('Machine Learning'),('Linear Algebra and Calculus'),('Microsoft Excel'),('Critical Thinking')
GO


-- 10
CREATE TABLE [Job_skills]
(
	[job_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Jobs] NOT NULL,
	[skill_id] int FOREIGN KEY REFERENCES dbo.[Skills] NOT NULL,
	UNIQUE([job_id],[skill_id])
)
GO

/*
INSERT INTO [Skills]
VALUES
(),
GO
*/

-- 11

CREATE TABLE [Member_skills]
(
	[memSkill_id] INT Identity(1,1) PRIMARY KEY NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[Skills] NOT NULL,
	[skill_id] int FOREIGN KEY REFERENCES dbo.[Skills] NOT NULL,
	UNIQUE([mem_id],[skill_id])
)
GO

/*
INSERT INTO [Member_skills]
VALUES
(),
GO
*/

-- 12
CREATE TABLE [Questions]
(
	[q_id] CHAR(4) PRIMARY KEY NOT NULL,
	[questiontxt] text NOT NULL,
	[major_id] int FOREIGN KEY REFERENCES dbo.[Majors] NOT NULL,
)
GO

/*
INSERT INTO [Questions]
VALUES
(),
GO
*/

-- 13
CREATE TABLE [Options]
(
	[op_id] int Identity(1,1) PRIMARY KEY NOT NULL,
	[q_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Questions] NOT NULL,
	[content] text not null,
	[isCorrect] bit DEFAULT(0) NOT NULL
)
GO

/*
INSERT INTO [Options]
VALUES
(),
GO
*/

-- 14
CREATE TABLE [Exams]
(
	[exam_id] CHAR(3) PRIMARY KEY NOT NULL,
	[exam_name] NVARCHAR(30) UNIQUE NOT NULL
)
GO

/*
INSERT INTO [Exams]
VALUES
(),
GO
*/

-- 15
CREATE TABLE [Exam_questions]
(
	[examQ_id] CHAR(4) PRIMARY KEY NOT NULL,
	[q_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Questions] NOT NULL,
	[exam_id] CHAR(3) FOREIGN KEY REFERENCES dbo.[Exams] NOT NULL,
	UNIQUE([q_id],[exam_id])
)
GO

/*
INSERT INTO [Exam_questions]
VALUES
(),
GO
*/

-- 16
CREATE TABLE [Examination]
(
	[exam_id] CHAR(4) PRIMARY KEY NOT NULL,
	[can_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Candidates] NOT NULL,
	[job_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Jobs] NOT NULL,
	[score] FLOAT ,
	UNIQUE ([can_id])
)
GO

/*
INSERT INTO [Examsination]
VALUES
(),
GO
*/

-- 17


CREATE TABLE [Interviewing]
(
	[id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[inter_id] CHAR(3) FOREIGN KEY REFERENCES dbo.[Interviewers] NOT NULL,
	[can_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Candidates] NOT NULL,
	[date] DATETIME not null,
	[location] NVARCHAR(100) NOT NULL,
	[inter_score] INT,
	UNIQUE ([inter_id],[can_id])
)
GO

/*
INSERT INTO [Examsination]
VALUES
(),
GO
*/