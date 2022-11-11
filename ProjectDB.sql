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
/****** Object:  Table [dbo].[Candidate]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidate](
	[can_id] [char](4) NOT NULL,
	[job_id] [char](4) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[can_cv] [nvarchar](200) NOT NULL,
	[score] [float] NULL,
	[isStatus] [int] NOT NULL,
	[apply] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[can_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[job_id] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Candidate_skill]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidate_skill](
	[can_id] [char](4) NOT NULL,
	[skill_id] [int] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[can_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[exam_id] [char](3) NOT NULL,
	[exam_name] [nvarchar](30) NOT NULL,
	[major_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[exam_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam_question]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam_question](
	[exam_id] [char](3) NOT NULL,
	[q_id] [char](4) NOT NULL,
UNIQUE NONCLUSTERED 
(
	[exam_id] ASC,
	[q_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Examination]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Examination](
	[exam_id] [char](3) NOT NULL,
	[can_id] [char](4) NOT NULL,
	[status] [bit] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[exam_id] ASC,
	[can_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[subject] [nvarchar](150) NOT NULL,
	[detail] [nvarchar](400) NOT NULL,
	[date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interviewer]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interviewer](
	[inter_id] [char](3) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[major_id] [int] NOT NULL,
	[isAvailable] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[inter_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interviewing]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interviewing](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[inter_id] [char](3) NOT NULL,
	[can_id] [char](4) NOT NULL,
	[date] [datetime] NOT NULL,
	[location] [nvarchar](100) NOT NULL,
	[inter_score] [int] NULL,
	[inter_comment] [text] NULL,
	[isStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[inter_id] ASC,
	[can_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job](
	[job_id] [char](4) NOT NULL,
	[job_name] [nvarchar](50) NOT NULL,
	[major_id] [int] NOT NULL,
	[job_vacancy] [int] NOT NULL,
	[job_description] [text] NULL,
	[level_id] [int] NOT NULL,
	[salary] [float] NOT NULL,
	[post_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job_skill]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_skill](
	[skill_id] [int] IDENTITY(1,1) NOT NULL,
	[job_id] [char](4) NOT NULL,
	[detail] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[job_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[nId] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[content] [text] NOT NULL,
	[link_title] [nvarchar](100) NULL,
	[link] [nvarchar](200) NULL,
	[date] [datetime] NOT NULL,
	[isRead] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Option]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Option](
	[op_id] [int] IDENTITY(1,1) NOT NULL,
	[q_id] [char](4) NOT NULL,
	[content] [text] NOT NULL,
	[isCorrect] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[op_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Q&A_answer]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Q&A_answer](
	[aId] [char](5) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[qId] [char](4) NOT NULL,
	[detail] [text] NOT NULL,
	[datetime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[aId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Q&A_question]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Q&A_question](
	[qId] [char](4) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[detail] [text] NOT NULL,
	[datetime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[qId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[q_id] [char](4) NOT NULL,
	[questiontxt] [text] NOT NULL,
	[major_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[q_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[r_id] [int] IDENTITY(1,1) NOT NULL,
	[reason] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[r_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report_list]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report_list](
	[Q&A_id] [char](5) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[r_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Saved_job]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Saved_job](
	[job_id] [char](4) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
UNIQUE NONCLUSTERED 
(
	[job_id] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[email] [nvarchar](60) NOT NULL,
	[name] [nvarchar](60) NOT NULL,
	[role_id] [int] NOT NULL,
	[phone] [varchar](11) NULL,
	[address] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_cv]    Script Date: 11/11/2022 1:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_cv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](60) NOT NULL,
	[can_cv] [nvarchar](200) NOT NULL,
	[date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Candidate] ADD  DEFAULT ((0)) FOR [isStatus]
GO
ALTER TABLE [dbo].[Candidate] ADD  DEFAULT ((0)) FOR [apply]
GO
ALTER TABLE [dbo].[Examination] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Interviewer] ADD  DEFAULT ((0)) FOR [isAvailable]
GO
ALTER TABLE [dbo].[Interviewing] ADD  DEFAULT ((0)) FOR [isStatus]
GO
ALTER TABLE [dbo].[Notification] ADD  DEFAULT ((0)) FOR [isRead]
GO
ALTER TABLE [dbo].[Option] ADD  DEFAULT ((0)) FOR [isCorrect]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((5)) FOR [role_id]
GO
ALTER TABLE [dbo].[Candidate]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
ALTER TABLE [dbo].[Candidate]  WITH CHECK ADD FOREIGN KEY([job_id])
REFERENCES [dbo].[Job] ([job_id])
GO
ALTER TABLE [dbo].[Candidate_skill]  WITH CHECK ADD FOREIGN KEY([can_id])
REFERENCES [dbo].[Candidate] ([can_id])
GO
ALTER TABLE [dbo].[Candidate_skill]  WITH CHECK ADD FOREIGN KEY([skill_id])
REFERENCES [dbo].[Job_skill] ([skill_id])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([major_id])
REFERENCES [dbo].[Major] ([major_id])
GO
ALTER TABLE [dbo].[Exam_question]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[Exam_question]  WITH CHECK ADD FOREIGN KEY([q_id])
REFERENCES [dbo].[Question] ([q_id])
GO
ALTER TABLE [dbo].[Examination]  WITH CHECK ADD FOREIGN KEY([can_id])
REFERENCES [dbo].[Candidate] ([can_id])
GO
ALTER TABLE [dbo].[Examination]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[Interviewer]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
ALTER TABLE [dbo].[Interviewer]  WITH CHECK ADD FOREIGN KEY([major_id])
REFERENCES [dbo].[Major] ([major_id])
GO
ALTER TABLE [dbo].[Interviewing]  WITH CHECK ADD FOREIGN KEY([can_id])
REFERENCES [dbo].[Candidate] ([can_id])
GO
ALTER TABLE [dbo].[Interviewing]  WITH CHECK ADD FOREIGN KEY([inter_id])
REFERENCES [dbo].[Interviewer] ([inter_id])
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD FOREIGN KEY([level_id])
REFERENCES [dbo].[Level] ([level_id])
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD FOREIGN KEY([major_id])
REFERENCES [dbo].[Major] ([major_id])
GO
ALTER TABLE [dbo].[Job_skill]  WITH CHECK ADD FOREIGN KEY([job_id])
REFERENCES [dbo].[Job] ([job_id])
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
ALTER TABLE [dbo].[Option]  WITH CHECK ADD FOREIGN KEY([q_id])
REFERENCES [dbo].[Question] ([q_id])
GO
ALTER TABLE [dbo].[Q&A_answer]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
ALTER TABLE [dbo].[Q&A_answer]  WITH CHECK ADD FOREIGN KEY([qId])
REFERENCES [dbo].[Q&A_question] ([qId])
GO
ALTER TABLE [dbo].[Q&A_question]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD FOREIGN KEY([major_id])
REFERENCES [dbo].[Major] ([major_id])
GO
ALTER TABLE [dbo].[Report_list]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
ALTER TABLE [dbo].[Report_list]  WITH CHECK ADD FOREIGN KEY([r_id])
REFERENCES [dbo].[Report] ([r_id])
GO
ALTER TABLE [dbo].[Saved_job]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
ALTER TABLE [dbo].[Saved_job]  WITH CHECK ADD FOREIGN KEY([job_id])
REFERENCES [dbo].[Job] ([job_id])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO
ALTER TABLE [dbo].[User_cv]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[User] ([email])
GO
