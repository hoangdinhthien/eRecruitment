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

CREATE TABLE [User_cv]
(
	[id] int identity(1,1) PRIMARY KEY,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] NOT NULL,
	[can_cv] NVARCHAR(200) NOT NULL,
	[date] Date NOT NULL
)
GO

CREATE TABLE [Notification]
(
	[nId] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] not null,
	[title] NVARCHAR(100) not null,
	[content] text not null,
	[link_title] NVARCHAR(100),
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
	[can_cv] NVARCHAR(200) NOT NULL,-- comment 
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
	[exam_name] NVARCHAR(30) NOT NULL,
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
	[status] bit DEFAULT (0) not null,
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
	[isStatus] int DEFAULT (0) not null,
	UNIQUE ([inter_id],[can_id])
)
GO

/*
INSERT INTO [Examsination]
VALUES
(),
GO
*/

CREATE TABLE [Feedback]
(
	[id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[email] NVARCHAR(60) NOT NULL,
	[subject] NVARCHAR (150) NOT NULL,
	[detail] NVARCHAR(400) NOT NULL,
	[date] date not null
)
GO
CREATE TABLE [Q&A_question]
(
	[qId] char(4) PRIMARY KEY NOT NULL,--Q000
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] NOT NULL,
	[detail] text NOT NULL,
	[datetime] datetime NOT NULL,
)
GO
CREATE TABLE [Q&A_answer]
(
	[aId] char(5) PRIMARY KEY NOT NULL,--A0000
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] NOT NULL,
	[qId] char(4) FOREIGN KEY REFERENCES dbo.[Q&A_question] NOT NULL,
	[detail] text NOT NULL,
	[datetime] datetime NOT NULL,
)
GO
CREATE TABLE [Report]
(
	[r_id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[reason] NVARCHAR(100) NOT NULL,
)
GO
INSERT INTO [Report] ([reason])
VALUES
('Unwanted commercial content or spam'),
('Pornography or sexually explicit material'),
('Child abuse'),
('Hate speech or graphic violence'),
('Promotes terrorism'),
('Harassment or bullying'),
('Suicide or self injury'),
('Misinformation')


CREATE TABLE [Report_list]
(
	[Q&A_id] char(5) not null,
	[email] NVARCHAR(60) FOREIGN KEY REFERENCES dbo.[User] NOT NULL,
	[r_id] int FOREIGN KEY REFERENCES dbo.[Report] NOT NULL,
)

GO
-- Data

USE [eRecruitment]
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'126.thienphuc@gmail.com', N'Thiện Nguyễn', 5, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'do@gmail.com', N'Xuân Tóc Đỏ', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'duy@gmail.com', N'Đàm Xuân Duy', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'hieu@gmail.com', N'Nguyễn Minh Hiếu', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'hieunmse162040@fpt.edu.vn', N'Nguyen Minh Hieu (K16 HCM)', 5, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'hoang@gmail.com', N'Đinh Thiên Hoàng', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'hoangthse162042@fpt.edu.vn', N'Thai Huy Hoang (K16 HCM)', 5, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'hrstaff126@gmail.com', N'Anh HR May Mắn', 2, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'huy@gmail.com', N'Nguyễn Quốc Huy', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'interviewer126@gmail.com', N'Interviewer Số 1', 3, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'interviewer326@gmail.com', N'Interviewer Số 3', 3, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'nam@gmail.com', N'Nguyễn Tuấn Nam', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'nguyenhuuthien12a2@gmail.com', N'Nguyễn Hữu Thiện', 5, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'nguyenhuuthien9a1nbk@gmail.com', N'thien', 1, N'0332221765', NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'niem.huu.thien@gmail.com', N'Interviewer Số 2', 3, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'thai@gmail.com', N'Nguyễn Thái', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'thiennhse162041@fpt.edu.vn', N'Nguyen Huu Thien (K16 HCM)', 5, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'tuan@gmail.com', N'Nguyễn Anh Tuấn', 4, NULL, NULL)
GO
INSERT [dbo].[User] ([email], [name], [role_id], [phone], [address]) VALUES (N'vang@gmail.com', N'Cậu Vàng', 4, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[User_cv] ON 
GO
INSERT [dbo].[User_cv] ([id], [email], [can_cv], [date]) VALUES (1, N'thiennhse162041@fpt.edu.vn', N'1.pdf', CAST(N'2022-11-11' AS Date))
GO
INSERT [dbo].[User_cv] ([id], [email], [can_cv], [date]) VALUES (3, N'126.thienphuc@gmail.com', N'1.pdf', CAST(N'2022-11-11' AS Date))
GO
SET IDENTITY_INSERT [dbo].[User_cv] OFF
GO
SET IDENTITY_INSERT [dbo].[Notification] ON 
GO
INSERT [dbo].[Notification] ([nId], [email], [title], [content], [link_title], [link], [date], [isRead]) VALUES (1, N'thiennhse162041@fpt.edu.vn', N'Accepted Resume', N'<p>Your Resume already accepted.</p>', NULL, NULL, CAST(N'2022-11-11T13:19:16.000' AS DateTime), 0)
GO
INSERT [dbo].[Notification] ([nId], [email], [title], [content], [link_title], [link], [date], [isRead]) VALUES (2, N'thiennhse162041@fpt.edu.vn', N'Accepted Resume', N'<p>Your Resume already accepted.</p>', NULL, NULL, CAST(N'2022-11-11T13:34:40.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[Notification] OFF
GO
INSERT [dbo].[Interviewer] ([inter_id], [email], [major_id], [isAvailable]) VALUES (N'I01', N'interviewer126@gmail.com', 1, 1)
GO
INSERT [dbo].[Interviewer] ([inter_id], [email], [major_id], [isAvailable]) VALUES (N'I02', N'niem.huu.thien@gmail.com', 1, 1)
GO
INSERT [dbo].[Interviewer] ([inter_id], [email], [major_id], [isAvailable]) VALUES (N'I03', N'interviewer326@gmail.com', 1, 1)
GO
INSERT [dbo].[Job] ([job_id], [job_name], [major_id], [job_vacancy], [job_description], [level_id], [salary], [post_date]) VALUES (N'C001', N'Game Developer', 1, 12, N'Video game developers, also known as game developers, are responsible for designing and developing video games for PC, console, and mobile applications. Their job is to code the base engine from the ideas of the design team. They may also be involved in character design, level design, animation, and unit testing.', 3, 1200, CAST(N'2022-11-04' AS Date))
GO
INSERT [dbo].[Job] ([job_id], [job_name], [major_id], [job_vacancy], [job_description], [level_id], [salary], [post_date]) VALUES (N'C002', N'Web Developer', 1, 21, N'The web developer, also called a web designer or webmaster, is the person who builds, adjusts, and/or maintains it. Web developers may work for small companies, large corporations, or as freelancers, using technical and creative skills to create functional websites.', 4, 5000, CAST(N'2022-11-04' AS Date))
GO
INSERT [dbo].[Job] ([job_id], [job_name], [major_id], [job_vacancy], [job_description], [level_id], [salary], [post_date]) VALUES (N'C003', N'Oracle Developer', 1, 30, N'Oracle developer tasks are to perform the design and development of Oracle applications permitting to project requirements. Typically, the design, code, and sustain the Oracle systems based on established standards.', 3, 2500, CAST(N'2022-11-04' AS Date))
GO
INSERT [dbo].[Job] ([job_id], [job_name], [major_id], [job_vacancy], [job_description], [level_id], [salary], [post_date]) VALUES (N'C004', N'Java Developer', 1, 10, N'A Java Developer is responsible for designing, implementing, and maintaining Java-based software and applications, contributing to all stages of the software development lifecycle. They thoroughly analyze user requirements, envision system features, and define application functionality.', 4, 10000, CAST(N'2022-11-10' AS Date))
GO
INSERT [dbo].[Job] ([job_id], [job_name], [major_id], [job_vacancy], [job_description], [level_id], [salary], [post_date]) VALUES (N'C005', N'IOS Developer', 5, 21, N'iOS developers design and build applications for mobile devices running Apple''s iOS operating software. They are responsible for designing and coding the base application, ensuring the quality of the application, fixing application bugs, maintaining the code, and implementing application updates.', 5, 20000, CAST(N'2022-11-10' AS Date))
GO
INSERT [dbo].[Job] ([job_id], [job_name], [major_id], [job_vacancy], [job_description], [level_id], [salary], [post_date]) VALUES (N'C007', N'Python Developer', 4, 0, N'Python developers are computer programmers who specialize in writing server-side web application logic. Their job is to use the Python programming language to develop, debug, and implement application projects.', 3, 2000, CAST(N'2022-11-11' AS Date))
GO
INSERT [dbo].[Job] ([job_id], [job_name], [major_id], [job_vacancy], [job_description], [level_id], [salary], [post_date]) VALUES (N'C015', N'SQL Developer', 9, 5, N'SQL developers are responsible for all aspects of designing, creating and maintaining databases, including: Building databases and validating their stability and efficiency. Creating program views, functions and stored procedures.', 6, 50000, CAST(N'2022-11-11' AS Date))
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C001', N'C001', N'hoangthse162042@fpt.edu.vn', N'1.pdf', 6, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C002', N'C001', N'126.thienphuc@gmail.com', N'2.pdf', 4, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C003', N'C001', N'nguyenhuuthien12a2@gmail.com', N'3.pdf', 9, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C005', N'C001', N'tuan@gmail.com', N'5.pdf', 8, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C006', N'C001', N'nam@gmail.com', N'6.pdf', 7, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C007', N'C001', N'huy@gmail.com', N'7.pdf', 6, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C008', N'C001', N'hieu@gmail.com', N'8.pdf', 4, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C009', N'C001', N'hoang@gmail.com', N'9.pdf', 7, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C010', N'C001', N'duy@gmail.com', N'10.pdf', 7, 2)
GO
INSERT [dbo].[Candidate] ([can_id], [job_id], [email], [can_cv], [score], [isStatus]) VALUES (N'C012', N'C015', N'thiennhse162041@fpt.edu.vn', N'1.pdf', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Report] ON 
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (1, N'Unwanted commercial content or spam')
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (2, N'Pornography or sexually explicit material')
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (3, N'Child abuse')
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (4, N'Hate speech or graphic violence')
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (5, N'Promotes terrorism')
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (6, N'Harassment or bullying')
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (7, N'Suicide or self injury')
GO
INSERT [dbo].[Report] ([r_id], [reason]) VALUES (8, N'Misinformation')
GO
SET IDENTITY_INSERT [dbo].[Report] OFF
GO
SET IDENTITY_INSERT [dbo].[Job_skill] ON 
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (1, N'C001', N'Creativity.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (2, N'C001', N'A passion for video games.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (3, N'C002', N'Java')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (4, N'C002', N'C')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (5, N'C003', N'Teamwork and collaborative skills.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (6, N'C003', N'Verbal and written communication.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (7, N'C004', N'Proficiency in Java, with a good understanding of its ecosystems.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (8, N'C004', N'Sound knowledge of Object-Oriented Programming (OOP) Patterns and Concepts.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (9, N'C005', N'Work experience as an app developer.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (10, N'C005', N'Experience in Objective-C, Swift, Xcode, and Cocoa Touch.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (31, N'C015', N'Proficiency in SQL.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (32, N'C015', N'Problem solving skills.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (39, N'C007', N'CSS, HTML and JavaScript.')
GO
INSERT [dbo].[Job_skill] ([skill_id], [job_id], [detail]) VALUES (40, N'C007', N'Python Frameworks.')
GO
SET IDENTITY_INSERT [dbo].[Job_skill] OFF
GO
INSERT [dbo].[Exam] ([exam_id], [exam_name], [major_id]) VALUES (N'E01', N'Test 1', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q001', N'Which of the following statements is correct?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q002', N'The term marketing refers to:', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q003', N'What is a person who uses business products called?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q004', N'What activity is geared around understanding and communicating with the customer to help in the design, development, delivery, and determination of the value inherent in the offering?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q005', N'According to Leone and Shultz (1980), the law-like generalization 1 explains that ___________ has a direct and positive influence on total industry (market) sales.', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q006', N'What is about how the offering''s benefits and features are communicated to the potential buyer?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q007', N'In relationship marketing firms focus on __________ relationships with __________.', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q008', N'What is about the concern with creating superior value by continuously developing and redeveloping offerings to meet customer needs?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q009', N'Joint creation of value, in which customers take part in an active dialogue and co-construct personalized experiences, is referred to as:', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q010', N'According to the Charted Institute of Marketing, which of the following is not a professional marketing competency?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q011', N'Which of the following is not an element of the marketing mix?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q012', N'The term ''marketing mix'' describes:', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q013', N'Newsletters, catalogues, and invitations to organization-sponsored events are most closely associated with the marketing mix activity of:', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q014', N'The way in which the product is delivered to meet the customers'' needs refers to:', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q015', N'The ______________is concerned with ideas of the ''marketing mix'' and the 4Ps:', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q016', N'In public sector markets, the ____________ is bound by strict legal guidelines for contracts valued over a set amount.', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q017', N'The ____________ delivers to us a wide array of offerings, either directly or indirectly, through business markets, to serve our wants and needs.', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q018', N'A market orientation recognizes that:', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q019', N'Four competing philosophies strongly influence the role of marketing and marketing activities within an organization. Which if the following is not a component of market orientation?', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q020', N'In order for exchange to occur: ', 1)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q021', N'The warehousing function that combines the logistical flow of several small shipments to a specific market area is', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q022', N'The transportation model coordinated between railways and roadways is', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q023', N'The transportation system that is an outcome of the combination of air and roadways is', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q024', N'Booking of shipping space in advance is helpful to an exporter in', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q025', N'A mate’s receipt is', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q026', N'According to the Multimodal Transportation of Goods Act, a multimodal transport document cannot be', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q027', N'The following incoterm cannot be used for contracts providing for transportation of goods by sea', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q028', N'The incoterm providing or least responsibility to seller is', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q029', N'The group of incoterms under which the seller’s responsibility is to obtain freight paid transport document for the main carriage is', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q030', N'The price quoted by the seller for the product', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q031', N'Packaging performs two functions. ___________ and logistics.', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q032', N'The outcome of the independent business function era was', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q033', N'The outcome of limited integrated business function was', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q034', N'The outcome of internally integrated business function was', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q035', N'The outcome of externally integrated business function was', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q036', N'The period of existence of independent business function was', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q037', N'The non -logistical component of logistics mission', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q038', N'The service mission of logistics', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q039', N'Marketing and sales is ___________ in the generic value chain of logistics.', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q040', N'A well defined corporate vision', 2)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q041', N'Identify the language which is used in data science?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q042', N'Choose the correct components of data science.', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q043', N'Which of the following is not a part of the data science process?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q044', N'Total groups in which data can be characterized is?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q045', N'Choose whether the following statement is true or false:  Unstructured data is not organized', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q046', N'A column is a  _________- representation of data.', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q047', N'Choose whether the following statement is true or false: A data frame is an unstructured representation of data', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q048', N'Among the following identify the one in which dimensionality reduction reduces.', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q049', N'Machine learning is a subset of which of the following.', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q050', N'FIND-S algorithm ignores?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q051', N'Full form of PAC is _________________', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q052', N'Total types of layer in radial basis function neural networks is ______', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q053', N'Choose whether true or false:  Decision tree cannot be used for clustering', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q054', N'Procedural Domain Knowledge in a rule-based system, is in the form of?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q055', N'Which of the following architecture is also known as systolic arrays?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q056', N'Machines running LISP are also called?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q057', N'A hybrid Bayesian Network consists of?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q058', N'Identify the key data science skills among the following', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q059', N'Raw data should be processed only one time. Is the following statement true or false?', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q060', N'Identify the revision control system on the following.', 3)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q061', N'What is the process at the most detailed level of the data flow diagrams known as?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q062', N'Total bits used by the IPv6 address is ________', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q063', N'Identify the language which is mainly used for Artificial Intelligence', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q064', N'Why is a firewall used in a computer?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q065', N'The full form of DOM is?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q066', N'How many levels are there in the architecture of the database?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q067', N'Among the following which is not a database management software', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q068', N'Identify the total standard color names that HTML supports.', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q069', N'Choose the port number of FTP.', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q070', N'Total number of layers in OSI model is ___________', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q071', N'UNIX is written in which language?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q072', N'Identify the different features of Big Data Analytics.', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q073', N'Which of the following is an extension of image file?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q074', N'Dbase III is?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q075', N'The main memory of a computer system is?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q076', N'Identify among the following servers which allow LAN users to share data.', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q077', N'URL stands for _______________', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q078', N'SSLstands for _______________', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q079', N'Which of the following is not a SQL command?', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q080', N'Identify the range of byte data types in JavaScript', 4)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q081', N'______ is an ancient Greek ideal ratio that can be expressed in numbers as 0.618034:1', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q082', N'________ is a false visual perception seeing something other than what is really there', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q083', N'Which one shows the pattern?', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q084', N'_______is the process of organizing and composing words and images to create a message', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q085', N' _____ a technique in which a design is incised in a plate of metal, wood, or plastic. a print is then made from the plate', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q086', N' ____that indicates areas between,around, above,below, or within something', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q087', N'______ is the area of a picture or design that appears to be closest to the viewer', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q088', N'______is a closed 2 dimension area', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q089', N'______ refers to 2 dynamics in a work of art that parts of things within a work of art are the right size in relationship to another.', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q090', N'______ is a visual journey along a page created by the careful placement of lines, shapes or forms, and colors', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q091', N'____ is a color scheme that uses colors that sit side by side on the color wheel and have a common hue', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q092', N'____ is a basic element repeated to create a pattern', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q093', N'______durable metal type invented by Johann Gutenberg, made from a combination of lead, tin, and antimony', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q094', N'______the characterization of a color as either warm or cool', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q095', N'_____is a the element of art that descries or refer to the relative between space is a the element of art that refers to the emptiness of the area between around or above below or with objects', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q096', N'______line, shape, form, color, value, space, and texture', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q097', N'______are the rules for dynamical that are used to help organize the elements of art the principle', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q098', N'Creates a very causal or natural effect is ______?', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q099', N'_____ is the act of organizing the elements of an artwork into a harmoniously unified whole', 5)
GO
INSERT [dbo].[Question] ([q_id], [questiontxt], [major_id]) VALUES (N'Q100', N'____ are simple signatures carved in wood, dipped in ink, and pressed onto paper or canvas – to identify their work', 5)
GO
SET IDENTITY_INSERT [dbo].[Option] ON 
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (1, N'Q001', N'Marketing is the term used to refer only to the sales function within a firm.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (2, N'Q001', N'Marketing managers don''t usually get involved in production or distribution decisions.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (3, N'Q001', N'Marketing is an activity that considers only the needs of the organization; not the needs of society as a whole.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (4, N'Q001', N'Marketing is the activity, set of institutions, and processes for creating, communicating, delivering, and exchanging offerings that have value for customers, clients, partners, and society at large.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (5, N'Q002', N'new product concepts and improvements.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (6, N'Q002', N'advertising and promotion activities.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (7, N'Q002', N'a philosophy that stresses customer value and satisfaction.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (8, N'Q002', N'planning sales campaigns.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (9, N'Q003', N'Customer.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (10, N'Q003', N'Agency.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (11, N'Q003', N'Consumer.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (12, N'Q003', N'Wrecker.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (13, N'Q004', N'production ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (14, N'Q004', N'sales', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (15, N'Q004', N'finance', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (16, N'Q004', N'marketing', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (17, N'Q005', N'increased consumer demand.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (18, N'Q005', N'advertising', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (19, N'Q005', N'increase in urbanization. ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (20, N'Q005', N'elasticity ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (21, N'Q006', N'product', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (22, N'Q006', N'place', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (23, N'Q006', N'price', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (24, N'Q006', N'promtion', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (25, N'Q007', N'short-term; customers and stakeholders ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (26, N'Q007', N'long-term; customers and stakeholders ', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (27, N'Q007', N'short-term; customers', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (28, N'Q007', N'long-term; customers ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (29, N'Q008', N'interfunctional coordination ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (30, N'Q008', N'competitor orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (31, N'Q008', N'production orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (32, N'Q008', N'customer orientation', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (33, N'Q009', N'interactive marketing. ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (34, N'Q009', N'co-creation experience.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (35, N'Q009', N'relationship marketing.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (36, N'Q009', N'organization marketing.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (37, N'Q010', N'Brand.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (38, N'Q010', N'Sales tactics.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (39, N'Q010', N'Digital Integration.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (40, N'Q010', N'Customer Experience', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (41, N'Q011', N'Promotion.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (42, N'Q011', N'Product.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (43, N'Q011', N'Target market.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (44, N'Q011', N'Pricing.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (45, N'Q012', N'a composite analysis of all environmental factors inside and outside the firm.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (46, N'Q012', N'a series of business decisions that aid in selling a product.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (47, N'Q012', N'the relationship between a firm''s marketing strengths and its business weaknesses.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (48, N'Q012', N'a blending of four strategic elements to satisfy specific target markets.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (49, N'Q013', N'Pricing', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (50, N'Q013', N'Distribution', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (51, N'Q013', N'Product development', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (52, N'Q013', N'Promotion', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (53, N'Q014', N'new product concepts and improvements.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (54, N'Q014', N'selling.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (55, N'Q014', N'advertising and promotion activities.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (56, N'Q014', N'place or distribution activities.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (57, N'Q015', N'consumer services perspective.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (58, N'Q015', N'business-to-business perspective.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (59, N'Q015', N'societal perspective.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (60, N'Q015', N'consumer goods perspective.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (61, N'Q016', N'promotional mix.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (62, N'Q016', N'logistics function.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (63, N'Q016', N'procurement process.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (64, N'Q016', N'aggregate marketing system.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (65, N'Q017', N'aggregate marketing system', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (66, N'Q017', N'planning excellence', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (67, N'Q017', N'a quality rift', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (68, N'Q017', N'a value line', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (69, N'Q018', N'price is the most important variable for customers.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (70, N'Q018', N'market intelligence relating to current and future customer needs is important.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (71, N'Q018', N'selling and marketing are essentially the same things.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (72, N'Q018', N'sales depend predominantly on an aggressive sales force.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (73, N'Q019', N'Customer orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (74, N'Q019', N'Profitability orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (75, N'Q019', N'Marketing orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (76, N'Q019', N'Competitor orientation.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (77, N'Q020', N'a complex societal system must be involved.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (78, N'Q020', N'organized marketing activities must also occur.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (79, N'Q020', N'a profit-oriented organization must be involved.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (80, N'Q020', N'each party must have something of value to the other party.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (81, N'Q021', N'Break bulk function.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (82, N'Q021', N'Operational function.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (83, N'Q021', N'Stockpiling function.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (84, N'Q021', N'Consolidation function.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (85, N'Q022', N'Transship.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (86, N'Q022', N'Airtruck.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (87, N'Q022', N'Piggyback.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (88, N'Q022', N'Fishyback.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (89, N'Q023', N'Transship.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (90, N'Q023', N'Airtruck.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (91, N'Q023', N'Piggyback.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (92, N'Q023', N'Fishyback.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (93, N'Q024', N'Saving in freight charges.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (94, N'Q024', N'Availing bank finance.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (95, N'Q024', N'Getting priority on inland movement of cargo by all.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (96, N'Q024', N'None of the above.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (97, N'Q025', N'A draft bill of lading.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (98, N'Q025', N'A substitute bill of lading.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (99, N'Q025', N'Bill of lading evidencing goods carried on deck.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (100, N'Q025', N'None of the above.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (101, N'Q026', N'A bearer instrument.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (102, N'Q026', N'An order instrument.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (103, N'Q026', N'A non-negotiable instrument.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (104, N'Q026', N'None of the above.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (105, N'Q027', N'CFR.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (106, N'Q027', N'DDP.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (107, N'Q027', N'DES.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (108, N'Q027', N'DEQ.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (109, N'Q028', N'EXW.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (110, N'Q028', N'DDP.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (111, N'Q028', N'FOB.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (112, N'Q028', N'CIF.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (113, N'Q029', N'E terms.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (114, N'Q029', N'C terms.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (115, N'Q029', N'D terms.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (116, N'Q029', N'F terms.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (117, N'Q030', N'Will vary depending upon the incoterm chosen.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (118, N'Q030', N'Is irrespective of the incoterm.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (119, N'Q030', N'Will be the base price.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (120, N'Q030', N'None of the above.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (121, N'Q031', N'Distribution.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (122, N'Q031', N'Store keeping.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (123, N'Q031', N'Material handling.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (124, N'Q031', N'Marketing.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (125, N'Q032', N'aggressive preaching skill.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (126, N'Q032', N'price -based competition.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (127, N'Q032', N'customer value and harmonious relation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (128, N'Q032', N'increased productivity, profitability and market share.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (129, N'Q033', N'aggressive preaching skill.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (130, N'Q033', N'price based competition.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (131, N'Q033', N'customer value and harmonious relation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (132, N'Q033', N'increased productivity, profitability and market share.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (133, N'Q034', N'aggressive preaching skill.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (134, N'Q034', N'price based competition.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (135, N'Q034', N'customer value and harmonious relation.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (136, N'Q034', N'increased productivity, profitability and market share.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (137, N'Q035', N'aggressive preaching skill.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (138, N'Q035', N'price based competition.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (139, N'Q035', N'customer value and harmonious relation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (140, N'Q035', N'increased productivity, profitability and market share.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (141, N'Q036', N'till 1950s.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (142, N'Q036', N'1960s to 1970s.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (143, N'Q036', N'1980s.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (144, N'Q036', N'1990s.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (145, N'Q037', N'reflect the vision of top management.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (146, N'Q037', N'deal with basic services required for delivering of goods.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (147, N'Q037', N'refers to the value-added services offered.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (148, N'Q037', N'reflects the ability of firm to exploit market.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (149, N'Q038', N'reflects the ability of firm to exploit market.ment.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (150, N'Q038', N'deal with basic services required for delivering of goods.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (151, N'Q038', N'refers to the value-added services offered.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (152, N'Q038', N'reflect the vision of top manage.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (153, N'Q039', N'the only activity.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (154, N'Q039', N'a primary activity.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (155, N'Q039', N'not an activity.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (156, N'Q039', N'a support activity.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (157, N'Q040', N'reflects the capability of the management to think beyond the current way.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (158, N'Q040', N'reflects the extent of use of logistical component for competitive advantage.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (159, N'Q040', N'ensures effective implementation of logistics strategy.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (160, N'Q040', N'deals with managing change.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (161, N'Q041', N'C++', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (162, N'Q041', N'R', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (163, N'Q041', N'Java', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (164, N'Q041', N'Ruby', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (165, N'Q042', N'domain expertise', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (166, N'Q042', N'data engineering', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (167, N'Q042', N'advanced computing', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (168, N'Q042', N'all of the above', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (169, N'Q043', N'ommunication building', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (170, N'Q043', N'operationalize', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (171, N'Q043', N'model planning', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (172, N'Q043', N'Discovery', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (173, N'Q044', N'1', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (174, N'Q044', N'2', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (175, N'Q044', N'3', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (176, N'Q044', N'4', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (177, N'Q045', N'True', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (178, N'Q045', N'False', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (179, N'Q045', N'maybe true or false', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (180, N'Q045', N'cannot be determined', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (181, N'Q046', N'Diagonal', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (182, N'Q046', N'Vertical', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (183, N'Q046', N'Top', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (184, N'Q046', N'Horizontal', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (185, N'Q047', N'True', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (186, N'Q047', N'False', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (187, N'Q048', N'Performance', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (188, N'Q048', N'Entropy', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (189, N'Q048', N'Stochastics', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (190, N'Q048', N'Collinearity', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (191, N'Q049', N'Artificial intelligencec', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (192, N'Q049', N'Deep learning', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (193, N'Q049', N'Data learning', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (194, N'Q049', N'None of the above', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (195, N'Q050', N'Positive', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (196, N'Q050', N'Negative', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (197, N'Q050', N'Both', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (198, N'Q050', N'None', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (199, N'Q051', N'Probably Approx Cost', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (200, N'Q051', N'Probably Approximate Correct', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (201, N'Q051', N'Probability Approx Communication', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (202, N'Q051', N'Probably Approximate Computation', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (203, N'Q052', N'1', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (204, N'Q052', N'2', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (205, N'Q052', N'3', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (206, N'Q052', N'4', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (207, N'Q053', N'True', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (208, N'Q053', N'False', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (209, N'Q054', N'Meta-Rules', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (210, N'Q054', N'Control Rules', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (211, N'Q054', N'Production Rules', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (212, N'Q054', N'None of the above', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (213, N'Q055', N'MISD', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (214, N'Q055', N'SISD', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (215, N'Q055', N'SIMD', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (216, N'Q055', N'None of the above', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (217, N'Q056', N'A1 Workstations', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (218, N'Q056', N'Time-Sharing Terminals', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (219, N'Q056', N'Both A and B', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (220, N'Q056', N'None of the above', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (221, N'Q057', N'Discrete Variables', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (222, N'Q057', N'Continuous Variables', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (223, N'Q057', N'Both A and B', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (224, N'Q057', N'None of the above', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (225, N'Q058', N'data visualization', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (226, N'Q058', N'machine learning', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (227, N'Q058', N'Statistics', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (228, N'Q058', N'all of the above', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (229, N'Q059', N'True', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (230, N'Q059', N'False', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (231, N'Q060', N'Scipy', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (232, N'Q060', N'Numpy', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (233, N'Q060', N'Git', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (234, N'Q060', N'Slidify', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (235, N'Q061', N'interfaces', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (236, N'Q061', N'functional primitives', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (237, N'Q061', N'data flow', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (238, N'Q061', N'transform descriptions', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (239, N'Q062', N'64 bit', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (240, N'Q062', N'256 bit', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (241, N'Q062', N'128 bit', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (242, N'Q062', N'32 bit', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (243, N'Q063', N'Java', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (244, N'Q063', N'J2EE', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (245, N'Q063', N'Prolog', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (246, N'Q063', N'C', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (247, N'Q064', N'Monitoring', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (248, N'Q064', N'Data transmission', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (249, N'Q064', N'Authentication', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (250, N'Q064', N'Security', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (251, N'Q065', N'Document-oriented memory', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (252, N'Q065', N'Document object model', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (253, N'Q065', N'Document object memory', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (254, N'Q065', N'None', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (255, N'Q066', N'2', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (256, N'Q066', N'3', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (257, N'Q066', N'4', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (258, N'Q066', N'5', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (259, N'Q067', N'MySQL', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (260, N'Q067', N'COBOL', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (261, N'Q067', N'Sybase', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (262, N'Q067', N'Oracle', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (263, N'Q068', N'30', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (264, N'Q068', N'70', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (265, N'Q068', N'140', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (266, N'Q068', N'120', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (267, N'Q069', N'23', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (268, N'Q069', N'21', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (269, N'Q069', N'110', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (270, N'Q069', N'143', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (271, N'Q070', N'5', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (272, N'Q070', N'7', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (273, N'Q070', N'9', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (274, N'Q070', N'11', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (275, N'Q071', N'C#', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (276, N'Q071', N'C++', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (277, N'Q071', N'C', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (278, N'Q071', N'.Net', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (279, N'Q072', N'Open source', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (280, N'Q072', N'Data recovery', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (281, N'Q072', N'Scalability', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (282, N'Q072', N'All of the above', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (283, N'Q073', N'.mkv', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (284, N'Q073', N'.gif', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (285, N'Q073', N'.txt', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (286, N'Q073', N'.vdf', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (287, N'Q074', N'Hardware', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (288, N'Q074', N'Firmware', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (289, N'Q074', N'Application software', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (290, N'Q074', N'operating system', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (291, N'Q075', N'Non-volatile', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (292, N'Q075', N'Volatile', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (293, N'Q075', N'Restricted', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (294, N'Q075', N'Unrestricted', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (295, N'Q076', N'Communication server', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (296, N'Q076', N'Point server', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (297, N'Q076', N'Data server', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (298, N'Q076', N'File server', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (299, N'Q077', N'Uninterrupted data locator', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (300, N'Q077', N'Uninterrupted record locator', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (301, N'Q077', N'Uniform record locator', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (302, N'Q077', N'Uniform resource locator', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (303, N'Q078', N'secure socket layer', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (304, N'Q078', N'secure secret level', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (305, N'Q078', N'secure system level', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (306, N'Q078', N'section security layer', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (307, N'Q079', N'DELETE', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (308, N'Q079', N'ORDER BY', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (309, N'Q079', N'SELECT', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (310, N'Q079', N'WHERE', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (311, N'Q080', N'-10 to 9', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (312, N'Q080', N'-128 to 127', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (313, N'Q080', N'-32768 to 32767', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (314, N'Q080', N'-2147483648 to 2147483647', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (315, N'Q081', N'intensity', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (316, N'Q081', N'golden Section', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (317, N'Q081', N'color scheme', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (318, N'Q081', N'proportion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (319, N'Q082', N'porportion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (320, N'Q082', N'illusion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (321, N'Q082', N'Graphic design', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (322, N'Q082', N'optical illusion', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (323, N'Q083', N'template', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (324, N'Q083', N'tonility', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (325, N'Q083', N'texture', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (326, N'Q083', N'temperature', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (327, N'Q084', N'optical illusion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (328, N'Q084', N'expression', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (329, N'Q084', N'illusion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (330, N'Q084', N'graphic design', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (331, N'Q085', N'haramony', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (332, N'Q085', N'engravings', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (333, N'Q085', N'insignia', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (334, N'Q085', N'branding', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (335, N'Q086', N'space', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (336, N'Q086', N'hue', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (337, N'Q086', N'value', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (338, N'Q086', N'balance', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (339, N'Q087', N'porportion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (340, N'Q087', N'foreground', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (341, N'Q087', N'form', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (342, N'Q087', N'background', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (343, N'Q088', N'value', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (344, N'Q088', N'shape', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (345, N'Q088', N'space', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (346, N'Q088', N'shade', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (347, N'Q089', N'porportion', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (348, N'Q089', N'color', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (349, N'Q089', N'composition', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (350, N'Q089', N'expression', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (351, N'Q090', N'visual path', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (352, N'Q090', N'template', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (353, N'Q090', N'Gestalt', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (354, N'Q090', N'space', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (355, N'Q091', N'Color scheme', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (356, N'Q091', N'Triad color scheme', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (357, N'Q091', N'Monochromatic color scheme', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (358, N'Q091', N'Analogous color scheme', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (359, N'Q092', N'shape', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (360, N'Q092', N'form', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (361, N'Q092', N'motif', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (362, N'Q092', N'hue', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (363, N'Q093', N'movable type', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (364, N'Q093', N'logotype', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (365, N'Q093', N'value', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (366, N'Q093', N'tonility', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (367, N'Q094', N'template', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (368, N'Q094', N'temperature', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (369, N'Q094', N'trademark', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (370, N'Q094', N'texture', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (371, N'Q095', N'value', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (372, N'Q095', N'space', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (373, N'Q095', N'shade', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (374, N'Q095', N'line', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (375, N'Q096', N'The elements of art', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (376, N'Q096', N'Temperature', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (377, N'Q096', N'3 Components of color', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (378, N'Q096', N'The elements of art/design', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (379, N'Q097', N'Principles of design', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (380, N'Q097', N'The elements of art/design', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (381, N'Q097', N'Graphic design', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (382, N'Q097', N'optical illusion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (383, N'Q098', N'Asymmetry balance', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (384, N'Q098', N'balance', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (385, N'Q098', N'after image', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (386, N'Q098', N'Primary colors', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (387, N'Q099', N'expression', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (388, N'Q099', N'composition', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (389, N'Q099', N'motif', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (390, N'Q099', N'porportion', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (391, N'Q100', N'watermark', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (392, N'Q100', N'trademark', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (393, N'Q100', N'closure', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (394, N'Q100', N'chop marks', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (395, N'Q001', N'Marketing is the term used to refer only to the sales function within a firm.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (396, N'Q001', N'Marketing managers don''t usually get involved in production or distribution decisions.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (397, N'Q001', N'Marketing is an activity that considers only the needs of the organization; not the needs of society as a whole.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (398, N'Q001', N'Marketing is the activity, set of institutions, and processes for creating, communicating, delivering, and exchanging offerings that have value for customers, clients, partners, and society at large.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (399, N'Q002', N'new product concepts and improvements.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (400, N'Q002', N'advertising and promotion activities.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (401, N'Q002', N'a philosophy that stresses customer value and satisfaction.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (402, N'Q002', N'planning sales campaigns.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (403, N'Q003', N'Customer.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (404, N'Q003', N'Agency.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (405, N'Q003', N'Consumer.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (406, N'Q003', N'Wrecker.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (407, N'Q004', N'production ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (408, N'Q004', N'sales', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (409, N'Q004', N'finance', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (410, N'Q004', N'marketing', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (411, N'Q005', N'increased consumer demand.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (412, N'Q005', N'advertising', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (413, N'Q005', N'increase in urbanization. ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (414, N'Q005', N'elasticity ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (415, N'Q006', N'product', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (416, N'Q006', N'place', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (417, N'Q006', N'price', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (418, N'Q006', N'promtion', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (419, N'Q007', N'short-term; customers and stakeholders ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (420, N'Q007', N'long-term; customers and stakeholders ', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (421, N'Q007', N'short-term; customers', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (422, N'Q007', N'long-term; customers ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (423, N'Q008', N'interfunctional coordination ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (424, N'Q008', N'competitor orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (425, N'Q008', N'production orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (426, N'Q008', N'customer orientation', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (427, N'Q009', N'interactive marketing. ', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (428, N'Q009', N'co-creation experience.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (429, N'Q009', N'relationship marketing.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (430, N'Q009', N'organization marketing.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (431, N'Q010', N'Brand.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (432, N'Q010', N'Sales tactics.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (433, N'Q010', N'Digital Integration.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (434, N'Q010', N'Customer Experience', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (435, N'Q011', N'Promotion.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (436, N'Q011', N'Product.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (437, N'Q011', N'Target market.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (438, N'Q011', N'Pricing.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (439, N'Q012', N'a composite analysis of all environmental factors inside and outside the firm.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (440, N'Q012', N'a series of business decisions that aid in selling a product.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (441, N'Q012', N'the relationship between a firm''s marketing strengths and its business weaknesses.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (442, N'Q012', N'a blending of four strategic elements to satisfy specific target markets.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (443, N'Q013', N'Pricing', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (444, N'Q013', N'Distribution', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (445, N'Q013', N'Product development', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (446, N'Q013', N'Promotion', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (447, N'Q014', N'new product concepts and improvements.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (448, N'Q014', N'selling.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (449, N'Q014', N'advertising and promotion activities.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (450, N'Q014', N'place or distribution activities.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (451, N'Q015', N'consumer services perspective.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (452, N'Q015', N'business-to-business perspective.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (453, N'Q015', N'societal perspective.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (454, N'Q015', N'consumer goods perspective.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (455, N'Q016', N'promotional mix.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (456, N'Q016', N'logistics function.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (457, N'Q016', N'procurement process.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (458, N'Q016', N'aggregate marketing system.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (459, N'Q017', N'aggregate marketing system', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (460, N'Q017', N'planning excellence', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (461, N'Q017', N'a quality rift', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (462, N'Q017', N'a value line', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (463, N'Q018', N'price is the most important variable for customers.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (464, N'Q018', N'market intelligence relating to current and future customer needs is important.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (465, N'Q018', N'selling and marketing are essentially the same things.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (466, N'Q018', N'sales depend predominantly on an aggressive sales force.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (467, N'Q019', N'Customer orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (468, N'Q019', N'Profitability orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (469, N'Q019', N'Marketing orientation.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (470, N'Q019', N'Competitor orientation.', 1)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (471, N'Q020', N'a complex societal system must be involved.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (472, N'Q020', N'organized marketing activities must also occur.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (473, N'Q020', N'a profit-oriented organization must be involved.', 0)
GO
INSERT [dbo].[Option] ([op_id], [q_id], [content], [isCorrect]) VALUES (474, N'Q020', N'each party must have something of value to the other party.', 1)
GO
SET IDENTITY_INSERT [dbo].[Option] OFF
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q001')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q002')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q005')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q006')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q008')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q010')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q013')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q014')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q017')
GO
INSERT [dbo].[Exam_question] ([exam_id], [q_id]) VALUES (N'E01', N'Q020')

GO

