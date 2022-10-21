USE MASTER 
GO

DROP DATABASE if exists eRecruitment
go 

CREATE DATABASE eRecruitment
go 

use eRecruitment
go

-- 1
CREATE TABLE [Role]
(
	[role_id] int Identity(1,1) PRIMARY KEY NOT NULL,
	[role_name] NVARCHAR(100) NOT NULL

)
GO

INSERT INTO [Role]
VALUES
(N'Admin'),(N'HR Staff'),(N'Interviewer'), (N'Candidate'), (N'Member')
GO

-- 2
CREATE TABLE [User]
(
	[email] NVARCHAR(60) PRIMARY KEY NOT NULL,
	[name] NVARCHAR(60) NOT NULL,
	[role_id] int FOREIGN KEY REFERENCES dbo.[Role] DEFAULT(5) not null,
	[phone] varchar(11),
	[address] nvarchar(200)
)
GO

CREATE TABLE [Notification]
(
	[nId] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] not null,
	[title] NVARCHAR(100) not null,
	[content] text not null,
	[link] NVARCHAR(200),
	[date] datetime not null,
	[isRead] bit DEFAULT (0) not null
)
GO

/*
INSERT INTO [Users]
VALUES
(),
GO
*/

-- 3
CREATE TABLE [Major]
(
	[major_id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[major_name] NVARCHAR(100) NOT NULL,
)
GO



INSERT INTO [Major]
VALUES
('Marketing'),('Logistic'),('Data Science and Analytics'),('Information Technology'),('Graphic Design'),
('Engineering'),('Risk Manager'),('Economic Finance'),('Business Intelligence and Development'),
('Operations')
GO


-- 4
CREATE TABLE [Interviewer]
(
	[inter_id] CHAR(3) PRIMARY KEY NOT NULL, --I00
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] NOT NULL ,
	[major_id] int FOREIGN KEY REFERENCES dbo.[Major] NOT NULL,
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

CREATE TABLE [Level]
(
	[level_id]  int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[level_name] NVARCHAR(10)  NOT NULL
)
GO

INSERT INTO [Level]
VALUES
('Intern'),('Fresher'),('Junior'),('Seninor'),('Manager'),('Leader')


-- 6 
CREATE TABLE [Job]
(
	[job_id] CHAR(4) PRIMARY KEY NOT NULL, --J000
	[job_name] NVARCHAR(50) NOT NULL,
	[major_id] int FOREIGN KEY REFERENCES dbo.[Major] NOT NULL,
	[job_vacancy] int NOT NULL,
	[job_description] text,
	[level_id] int FOREIGN KEY REFERENCES dbo.[Level] NOT NULL,
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
CREATE TABLE [Saved_job]
(
	[job_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Job] NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] NOT NULL,
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
CREATE TABLE [Candidate]
(

	[can_id] CHAR(4) PRIMARY KEY NOT NULL, --C000
	[job_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Job] NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] NOT NULL,
	[can_cv] NVARCHAR(50) NOT NULL,-- comment 
	[score] FLOAT,
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

/*
CREATE TABLE [Skill]
(
	[skill_id] int Identity(1,1) PRIMARY KEY NOT NULL,
	[skill_name] NVARCHAR(100) UNIQUE NOT NULL,
	[skill_description] text
)
GO

INSERT INTO [Skill] ([skill_name])
VALUES
('JavaSript'),('Java'),('Python'),('C++'),('C#'),('UI/UX'),('HTML'),('Testing'),('React Native'),('Angular'),('Mobile Develope'),('Ruby'),('Rust'),('Golang'),('TypeScript'),('BrainFuck'),
('PHP'),('Unity'),('Unreal Engine'),
('Data Visualization'),('Data Cleaning'),('MATLAB'),('SQL and NoSQL'),('Machine Learning'),('Linear Algebra and Calculus'),('Microsoft Excel'),('Critical Thinking')
GO
*/

-- 10
CREATE TABLE [Job_skill]
(

	[skill_id] int Identity(1,1) PRIMARY KEY NOT NULL,
	[job_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Job] NOT NULL,
	[detail] NVARCHAR(200) not null,
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

CREATE TABLE [Candidate_skill]
(
	[can_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Candidate] NOT NULL,
	[skill_id] int FOREIGN KEY REFERENCES dbo.[Job_skill] NOT NULL,
	UNIQUE([can_id],[skill_id])
)
GO
/*
INSERT INTO [Member_skills]
VALUES
(),
GO
*/
-- 12
CREATE TABLE [Question]
(
	[q_id] CHAR(4) PRIMARY KEY NOT NULL, --Q000
	[questiontxt] text NOT NULL,
	[major_id] int FOREIGN KEY REFERENCES dbo.[Major] NOT NULL,
)
GO

/*
INSERT INTO [Questions]
VALUES
(),
GO
*/
-- 13
CREATE TABLE [Option]
(
	[op_id] int Identity(1,1) PRIMARY KEY NOT NULL, 
	[q_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Question] NOT NULL,
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
CREATE TABLE [Exam]
(
	[exam_id] CHAR(3) PRIMARY KEY NOT NULL, --E00
	[exam_name] NVARCHAR(30) UNIQUE NOT NULL,
	[major_id] int FOREIGN KEY REFERENCES dbo.[Major] NOT NULL
)
GO

/*
INSERT INTO [Exams]
VALUES
(),
GO
*/

-- 15
CREATE TABLE [Exam_question]
(
	[exam_id] CHAR(3) FOREIGN KEY REFERENCES dbo.[Exam] NOT NULL,
	[q_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Question] NOT NULL,
	UNIQUE([exam_id],[q_id])
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
	[exam_id] CHAR(3) FOREIGN KEY REFERENCES dbo.[Exam] NOT NULL,
	[can_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Candidate] NOT NULL,
	UNIQUE ([exam_id],[can_id])
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
	[inter_id] CHAR(3) FOREIGN KEY REFERENCES dbo.[Interviewer] NOT NULL,
	[can_id] CHAR(4) FOREIGN KEY REFERENCES dbo.[Candidate] NOT NULL,
	[date] DATETIME not null,
	[location] NVARCHAR(100) NOT NULL,
	[inter_score] INT,
	[inter_comment] text,
	UNIQUE ([inter_id],[can_id])
)
GO

/*
INSERT INTO [Examsination]
VALUES
(),
GO
*/