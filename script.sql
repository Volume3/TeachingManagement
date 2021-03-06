USE [master]
GO
/****** Object:  Database [DB_TeachingMS]    Script Date: 2020/6/14 20:39:20 ******/
CREATE DATABASE [DB_TeachingMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_TeachingMS', FILENAME = N'D:\FORREVENGE!\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_TeachingMS.mdf' , SIZE = 8192KB , MAXSIZE = 102400KB , FILEGROWTH = 2048KB ), 
 FILEGROUP [jwGroup] 
( NAME = N'DB_TeachingMSfile', FILENAME = N'D:\FORREVENGE!\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_TeachingMSfile.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_TeachingMS_log', FILENAME = N'D:\FORREVENGE!\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_TeachingMS.ldf' , SIZE = 8192KB , MAXSIZE = 102400KB , FILEGROWTH = 2048KB )
GO
ALTER DATABASE [DB_TeachingMS] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_TeachingMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_TeachingMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_TeachingMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_TeachingMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_TeachingMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_TeachingMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_TeachingMS] SET  MULTI_USER 
GO
ALTER DATABASE [DB_TeachingMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_TeachingMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_TeachingMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_TeachingMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_TeachingMS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB_TeachingMS', N'ON'
GO
ALTER DATABASE [DB_TeachingMS] SET QUERY_STORE = OFF
GO
USE [DB_TeachingMS]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DB_TeachingMS]
GO
/****** Object:  User [Teacher]    Script Date: 2020/6/14 20:39:21 ******/
CREATE USER [Teacher] FOR LOGIN [LAPTOP-S647VSIJ\Teacher] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Student]    Script Date: 2020/6/14 20:39:21 ******/
CREATE USER [Student] FOR LOGIN [Student] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [Teachers]    Script Date: 2020/6/14 20:39:21 ******/
CREATE ROLE [Teachers]
GO
ALTER ROLE [Teachers] ADD MEMBER [Teacher]
GO
/****** Object:  Schema [Sch_Reader]    Script Date: 2020/6/14 20:39:21 ******/
CREATE SCHEMA [Sch_Reader]
GO
/****** Object:  Schema [Teachers]    Script Date: 2020/6/14 20:39:21 ******/
CREATE SCHEMA [Teachers]
GO
/****** Object:  UserDefinedFunction [dbo].[StuGradeQuery]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[StuGradeQuery](@stuName char(10))
	returns int as
	begin
		Return
		(select sum(TB_Course.CourseGrade)
		from TB_Grade,TB_Course,TB_Student
		where TB_Student.StuID = TB_Grade.StuID
		and TB_Course.CourseID = TB_Grade.CourseID
		and TB_Grade.TotalScore >= 60
		and TB_Student.StuName = @stuName)
	end
GO
/****** Object:  Table [dbo].[TB_Admin]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Admin](
	[AdminID] [nchar](10) NULL,
	[APassword] [nchar](10) NULL,
	[AdminName] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Class]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Class](
	[ClassID] [char](6) NOT NULL,
	[ClassName] [char](20) NOT NULL,
	[DeptID] [char](2) NOT NULL,
	[TeacherID] [char](6) NOT NULL,
	[ClassNumber] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Course]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Course](
	[CourseID] [char](6) NOT NULL,
	[CourseName] [varchar](32) NOT NULL,
	[DeptID] [char](2) NOT NULL,
	[CourseGrade] [real] NOT NULL,
	[LessonTime] [smallint] NOT NULL,
	[CourseOutline] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CourseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_CourseClass]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_CourseClass](
	[CourseClassID] [char](10) NOT NULL,
	[CourseID] [char](6) NOT NULL,
	[TeacherID] [char](6) NOT NULL,
	[TeachingYearID] [char](4) NOT NULL,
	[TermID] [char](2) NOT NULL,
	[TeachingPlace] [nvarchar](16) NOT NULL,
	[TeachingTime] [nvarchar](32) NOT NULL,
	[CommonPart] [tinyint] NOT NULL,
	[MiddlePart] [tinyint] NOT NULL,
	[LastPart] [tinyint] NOT NULL,
	[MaxNumber] [smallint] NOT NULL,
	[SelectedNumber] [smallint] NOT NULL,
	[FullFlag] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Dept]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Dept](
	[DeptID] [char](2) NOT NULL,
	[DeptName] [char](20) NOT NULL,
	[DeptSetDate] [smalldatetime] NOT NULL,
	[DeptScript] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Grade]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Grade](
	[GradeSeedID] [int] IDENTITY(1,1) NOT NULL,
	[StuID] [char](8) NOT NULL,
	[ClassID] [char](6) NOT NULL,
	[CourseClassID] [char](10) NOT NULL,
	[CourseID] [char](6) NOT NULL,
	[CommonScore] [real] NOT NULL,
	[MiddleScore] [real] NOT NULL,
	[LastScore] [real] NOT NULL,
	[TotalScore] [real] NOT NULL,
	[RetestScore] [real] NULL,
	[LockFlag] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GradeSeedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SelectCourse]    Script Date: 2020/6/14 20:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SelectCourse](
	[StuID] [char](8) NOT NULL,
	[CourseClassID] [char](10) NOT NULL,
	[SelectDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_StuID_CourseClassID] PRIMARY KEY CLUSTERED 
(
	[StuID] ASC,
	[CourseClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Spec]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Spec](
	[SpecID] [char](4) NOT NULL,
	[SpecName] [char](20) NOT NULL,
	[DeptID] [char](2) NOT NULL,
	[SpecScript] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Student]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Student](
	[StuID] [char](8) NOT NULL,
	[StuName] [char](8) NOT NULL,
	[EnrollYear] [char](4) NOT NULL,
	[GradYear] [char](4) NOT NULL,
	[DeptID] [char](2) NOT NULL,
	[ClassID] [char](6) NOT NULL,
	[Sex] [char](1) NOT NULL,
	[Birthday] [smalldatetime] NOT NULL,
	[SPassword] [varchar](32) NOT NULL,
	[StuAddress] [varchar](64) NOT NULL,
	[ZipCode] [char](6) NOT NULL,
	[TotalGrade] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[StuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Teacher]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Teacher](
	[TeacherID] [char](6) NOT NULL,
	[TeacherName] [char](8) NOT NULL,
	[DeptID] [char](2) NOT NULL,
	[Sex] [char](1) NOT NULL,
	[Birthday] [smalldatetime] NOT NULL,
	[TPassword] [varchar](32) NOT NULL,
	[TitleID] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_TeachingYear]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_TeachingYear](
	[TeachingYearID] [char](4) NOT NULL,
	[TeachingYearName] [nchar](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TeachingYearID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Term]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Term](
	[TermID] [char](2) NOT NULL,
	[TermName] [char](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TermID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Title]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Title](
	[TitleID] [char](2) NOT NULL,
	[TitleName] [char](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TitleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sch_Reader].[Tb_Book]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sch_Reader].[Tb_Book](
	[bookID] [char](10) NOT NULL,
	[bookName] [char](15) NOT NULL,
	[author] [char](8) NOT NULL,
	[price] [real] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[bookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sch_Reader].[Tb_Reader]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sch_Reader].[Tb_Reader](
	[rdId] [char](15) NOT NULL,
	[rdpassword] [char](20) NOT NULL,
	[times] [char](8) NOT NULL,
	[bookNum] [real] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[rdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_Class] ADD  DEFAULT ((0)) FOR [ClassNumber]
GO
ALTER TABLE [dbo].[TB_Course] ADD  DEFAULT ((0)) FOR [CourseGrade]
GO
ALTER TABLE [dbo].[TB_Course] ADD  DEFAULT ((0)) FOR [LessonTime]
GO
ALTER TABLE [dbo].[TB_CourseClass] ADD  DEFAULT ((10)) FOR [CommonPart]
GO
ALTER TABLE [dbo].[TB_CourseClass] ADD  DEFAULT ((20)) FOR [MiddlePart]
GO
ALTER TABLE [dbo].[TB_CourseClass] ADD  DEFAULT ((70)) FOR [LastPart]
GO
ALTER TABLE [dbo].[TB_CourseClass] ADD  DEFAULT ((60)) FOR [MaxNumber]
GO
ALTER TABLE [dbo].[TB_CourseClass] ADD  DEFAULT ((0)) FOR [SelectedNumber]
GO
ALTER TABLE [dbo].[TB_CourseClass] ADD  DEFAULT ('U') FOR [FullFlag]
GO
ALTER TABLE [dbo].[TB_Grade] ADD  DEFAULT ((0)) FOR [CommonScore]
GO
ALTER TABLE [dbo].[TB_Grade] ADD  DEFAULT ((0)) FOR [MiddleScore]
GO
ALTER TABLE [dbo].[TB_Grade] ADD  DEFAULT ((0)) FOR [LastScore]
GO
ALTER TABLE [dbo].[TB_Grade] ADD  DEFAULT ((0)) FOR [TotalScore]
GO
ALTER TABLE [dbo].[TB_Grade] ADD  DEFAULT ((0)) FOR [RetestScore]
GO
ALTER TABLE [dbo].[TB_Grade] ADD  DEFAULT ('U') FOR [LockFlag]
GO
ALTER TABLE [dbo].[TB_SelectCourse] ADD  DEFAULT (getdate()) FOR [SelectDate]
GO
ALTER TABLE [dbo].[TB_Student] ADD  DEFAULT ('M') FOR [Sex]
GO
ALTER TABLE [dbo].[TB_Student] ADD  DEFAULT ('123456') FOR [SPassword]
GO
ALTER TABLE [dbo].[TB_Teacher] ADD  DEFAULT ('M') FOR [Sex]
GO
ALTER TABLE [dbo].[TB_Teacher] ADD  DEFAULT ('123456') FOR [TPassword]
GO
ALTER TABLE [dbo].[TB_Class]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[TB_Dept] ([DeptID])
GO
ALTER TABLE [dbo].[TB_Class]  WITH CHECK ADD FOREIGN KEY([TeacherID])
REFERENCES [dbo].[TB_Teacher] ([TeacherID])
GO
ALTER TABLE [dbo].[TB_Course]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[TB_Dept] ([DeptID])
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[TB_Course] ([CourseID])
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD FOREIGN KEY([TeacherID])
REFERENCES [dbo].[TB_Teacher] ([TeacherID])
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD FOREIGN KEY([TeachingYearID])
REFERENCES [dbo].[TB_TeachingYear] ([TeachingYearID])
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD FOREIGN KEY([TermID])
REFERENCES [dbo].[TB_Term] ([TermID])
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD FOREIGN KEY([ClassID])
REFERENCES [dbo].[TB_Class] ([ClassID])
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD FOREIGN KEY([CourseClassID])
REFERENCES [dbo].[TB_CourseClass] ([CourseClassID])
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[TB_Course] ([CourseID])
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD  CONSTRAINT [FK__TB_Grade__StuID__2FCF1A8A] FOREIGN KEY([StuID])
REFERENCES [dbo].[TB_Student] ([StuID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TB_Grade] CHECK CONSTRAINT [FK__TB_Grade__StuID__2FCF1A8A]
GO
ALTER TABLE [dbo].[TB_SelectCourse]  WITH CHECK ADD FOREIGN KEY([CourseClassID])
REFERENCES [dbo].[TB_CourseClass] ([CourseClassID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TB_SelectCourse]  WITH CHECK ADD FOREIGN KEY([StuID])
REFERENCES [dbo].[TB_Student] ([StuID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TB_Spec]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[TB_Dept] ([DeptID])
GO
ALTER TABLE [dbo].[TB_Student]  WITH CHECK ADD  CONSTRAINT [FK__TB_Studen__Class__09A971A2] FOREIGN KEY([ClassID])
REFERENCES [dbo].[TB_Class] ([ClassID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TB_Student] CHECK CONSTRAINT [FK__TB_Studen__Class__09A971A2]
GO
ALTER TABLE [dbo].[TB_Student]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[TB_Dept] ([DeptID])
GO
ALTER TABLE [dbo].[TB_Teacher]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[TB_Dept] ([DeptID])
GO
ALTER TABLE [dbo].[TB_Teacher]  WITH CHECK ADD FOREIGN KEY([TitleID])
REFERENCES [dbo].[TB_Title] ([TitleID])
GO
ALTER TABLE [dbo].[TB_Course]  WITH CHECK ADD CHECK  (([CourseID] like 'C[0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TB_Course]  WITH CHECK ADD CHECK  (([CourseGrade]>=(0)))
GO
ALTER TABLE [dbo].[TB_Course]  WITH CHECK ADD CHECK  (([LessonTime]>=(0)))
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD CHECK  (([CommonPart]>=(0)))
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD CHECK  (([CourseClassID] like 'T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD CHECK  (([FullFlag]='U' OR [FullFlag]='F'))
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD CHECK  (([LastPart]>=(0)))
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD CHECK  (([MaxNumber]>=(0)))
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD CHECK  (([MiddlePart]>=(0)))
GO
ALTER TABLE [dbo].[TB_CourseClass]  WITH CHECK ADD  CONSTRAINT [CK_SumOfParts] CHECK  (((([CommonPart]+[MiddlePart])+[LastPart])=(100)))
GO
ALTER TABLE [dbo].[TB_CourseClass] CHECK CONSTRAINT [CK_SumOfParts]
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD CHECK  (([CommonScore]>=(0) AND [CommonScore]<=(100)))
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD CHECK  (([LastScore]>=(0) AND [LastScore]<=(100)))
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD CHECK  (([LockFlag]='L' OR [LockFlag]='U'))
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD CHECK  (([MiddleScore]>=(0) AND [MiddleScore]<=(100)))
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD CHECK  (([RetestScore]>=(0) AND [RetestScore]<=(100)))
GO
ALTER TABLE [dbo].[TB_Grade]  WITH CHECK ADD CHECK  (([TotalScore]>=(0) AND [TotalScore]<=(100)))
GO
ALTER TABLE [dbo].[TB_Student]  WITH CHECK ADD CHECK  (([EnrollYear] like '[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TB_Student]  WITH CHECK ADD CHECK  (([GradYear] like '[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TB_Student]  WITH CHECK ADD CHECK  (([StuID] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TB_Student]  WITH CHECK ADD CHECK  (([ZipCode] like '[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TB_Student]  WITH CHECK ADD CHECK  (([Sex]='F' OR [Sex]='M'))
GO
ALTER TABLE [dbo].[TB_Teacher]  WITH CHECK ADD CHECK  (([TeacherID] like 'T[0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[TB_Teacher]  WITH CHECK ADD CHECK  (([Sex]='F' OR [Sex]='M'))
GO
/****** Object:  StoredProcedure [dbo].[AutoGetStuID]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AutoGetStuID] @ClassID CHAR(6),@NewStuID CHAR(8) 
OUTPUT
AS
--定义变量--
DECLARE @MaxStuID CHAR(8),@CharTwoStuID CHAR(2),@IntTwoStuID INT
--获取班级中已有学生中最大学号--
	SET @MaxStuID = (SELECT MAX(StuID)FROM TB_Student
	WHERE ClassID = @ClassID)
	--SELECT @MaxStuID--
	IF @MaxStuID IS NULL
		SET @NewStuID = @ClassID + '01'
	ELSE
		BEGIN
			--从最大学号中获取班级编码和最后两位流水号--
			SET @CharTwoStuID = SUBSTRING(@MaxStuID,7,2)
			--SELECT @CharTwoStuID
			--最后两位流水号转换为数值型，然后加1，再转换成字符型--
			SET @IntTwoStuID = CONVERT(INT,@CharTwoStuID)+1
			--SELECT @IntTwoStuID
			SET @CharTwoStuID = CONVERT(CHAR,@IntTwoStuID)
			-- SELECT @CharTwoStuID
			--如果转换成字符型的流水号是位，则在它前面添加字符'0'--
			IF LEN(@CharTwoStuID) = 1
				SET @CharTwoStuID = '0'+@CharTwoStuID
			--将班级编码与获取的新流水号相连接，得到新学号--
			SET @NewStuID = @ClassID+@CharTwoStuID
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_CourseClassGradeQuery]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CourseClassGradeQuery] @CourseClassID CHAR(10)
AS
	SELECT GradeSeedID, TG.StuID,StuName,CommonScore,MiddleScore,LastScore,TotalScore,LockFlag
	FROM TB_Grade TG,TB_Student TS
	WHERE TG.StuID=TS.StuID AND CourseClassID=@CourseClassID
GO
/****** Object:  StoredProcedure [dbo].[SP_CourseClassQuery]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CourseClassQuery] @TeacherID CHAR(6)
AS
	SELECT CourseClassID,CourseName+'|'+TeachingTime+'|'+TeachingPlace AS CCName
	FROM TB_CourseClass TCC,TB_Course TC
	WHERE TCC.CourseID=TC.CourseID AND TeacherID=@TeacherID
GO
/****** Object:  StoredProcedure [dbo].[SP_GradeProc]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GradeProc] @CourseClassID CHAR(10) 
AS
------定义课程考试比例系数变量并获取相应的值-------
DECLARE @CPart REAL,@MPart REAL,@LPart REAL
SELECT @CPart=CommonPart,@MPart=MiddlePart,@LPart=LastPart
FROM TB_CourseClass
WHERE CourseClassID=@CourseClassID
------定义用来存放平时、期中、期末、总评成绩变量-------
DECLARE @CScore REAL,@MScore REAL,@LScore REAL,@TotalScore REAL
------------------声明游标------------------
DECLARE CUR_GradeProc CURSOR FOR
SELECT CommonScore,MiddleScore,LastScore FROM TB_Grade
WHERE CourseClassID=@CourseClassID ORDER BY StuID
GO
/****** Object:  StoredProcedure [dbo].[SP_MakeGradeSheet]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_MakeGradeSheet] @CourseClassID CHAR(10)
AS
    INSERT INTO TB_Grade (StuID,ClassID,CourseClassID,CourseID)
    SELECT TSC.StuID,ClassID,TSC.CourseClassID,CourseID
    FROM TB_SelectCourse TSC,TB_Student TS,TB_CourseClass TCC
 WHERE TSC.StuID=TS.StuID AND 
 TSC.CourseClassID=TCC.CourseClassID 
 AND TSC.CourseClassID=@CourseClassID
GO
/****** Object:  StoredProcedure [dbo].[SP_SelectCourse]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SelectCourse] @StuID CHAR(8),@CourseClassIDs VARCHAR(100) 
AS
DECLARE @CourseClassID CHAR(10),@Position TINYINT
SET @Position=1
WHILE @Position<LEN(@CourseClassIDs)
BEGIN
--取单个课程班的编码
SET @CourseClassID=SUBSTRING(@CourseClassIDs,@Position,10)
--将选择的某个课程班插入选课信息表中
INSERT INTO TB_SelectCourse (StuID,CourseClassID)
VALUES(@StuID,@CourseClassID)
--字符位置重新定位
SET @Position=@Position+11
END
GO
/****** Object:  StoredProcedure [dbo].[SP_StuCourseClass]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_StuCourseClass] @StuID CHAR(8)
AS
	SELECT CourseClassID,CourseName,TeacherName,TeachingPlace,TeachingTime,MaxNumber,SelectedNumber
	FROM TB_CourseClass TCC,TB_Course TC,TB_Teacher TT
	WHERE TCC.CourseID=TC.CourseID AND TCC.TeacherID=TT.TeacherID AND FullFlag='U' AND CourseClassID NOT IN
	(SELECT CourseClassID FROM TB_SelectCourse WHERE StuID = @StuID)
GO
/****** Object:  StoredProcedure [dbo].[SP_StuSelectedCourse]    Script Date: 2020/6/14 20:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_StuSelectedCourse] @StuID CHAR(8)
AS
SELECT TSC.CourseClassID,CourseName,TeacherName,
TeachingPlace,TeachingTime
FROM TB_SelectCourse TSC,TB_CourseClass TCC,TB_Course TC, TB_Teacher TT
WHERE TSC.CourseClassID=TCC.CourseClassID AND TCC.CourseID=TC.CourseID AND TCC.TeacherID=TT.TeacherID AND StuID=@StuID
GO
USE [master]
GO
ALTER DATABASE [DB_TeachingMS] SET  READ_WRITE 
GO
