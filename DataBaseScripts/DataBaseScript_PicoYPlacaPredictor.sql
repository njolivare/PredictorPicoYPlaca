USE [master]
GO

CREATE DATABASE [PicoyPlacaPredictor]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PicoyPlacaPredictor', FILENAME = N'd:\MSSQL12.MSSQLSERVER\MSSQL\DATA\PicoyPlacaPredictor.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PicoyPlacaPredictor_log', FILENAME = N'd:\MSSQL12.MSSQLSERVER\MSSQL\DATA\PicoyPlacaPredictor_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [PicoyPlacaPredictor] SET COMPATIBILITY_LEVEL = 120
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PicoyPlacaPredictor].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [PicoyPlacaPredictor] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET ARITHABORT OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET  DISABLE_BROKER 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET RECOVERY FULL 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET  MULTI_USER 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [PicoyPlacaPredictor] SET DB_CHAINING OFF 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [PicoyPlacaPredictor] SET  READ_WRITE 
GO

USE [PicoyPlacaPredictor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DayOfWeek](
	[Id] [int] NOT NULL,
	[DayName] [nvarchar](20) NULL,
 CONSTRAINT [PK_DayOfWeek] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PicoYPlaca](
	[Id] [int] NOT NULL,
	[LicensePlateNumber] [int] NOT NULL,
	[IdDayOfWeek] [int] NOT NULL,
 CONSTRAINT [PK_PicoYPlaca] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PicoYPlaca]  WITH CHECK ADD  CONSTRAINT [FK_PicoYPlaca_DayOfWeek] FOREIGN KEY([IdDayOfWeek])
REFERENCES [dbo].[DayOfWeek] ([Id])
GO

ALTER TABLE [dbo].[PicoYPlaca] CHECK CONSTRAINT [FK_PicoYPlaca_DayOfWeek]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Schedule](
	[Id] [int] NOT NULL,
	[ScheduleName] [nvarchar](10) NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO [dbo].[DayOfWeek]([Id],[DayName]) VALUES (1,'Monday')
INSERT INTO [dbo].[DayOfWeek]([Id],[DayName]) VALUES (2,'Tuesday')
INSERT INTO [dbo].[DayOfWeek]([Id],[DayName]) VALUES (3,'Wednesday')
INSERT INTO [dbo].[DayOfWeek]([Id],[DayName]) VALUES (4,'Thursday')
INSERT INTO [dbo].[DayOfWeek]([Id],[DayName]) VALUES (5,'Friday')
INSERT INTO [dbo].[DayOfWeek]([Id],[DayName]) VALUES (6,'Saturday')
INSERT INTO [dbo].[DayOfWeek]([Id],[DayName]) VALUES (7,'Sunday')
GO
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (1,	1,	1)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (2,	2,	1)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (3,	3,	2)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (4,	4,	2)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (5,	5,	3)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (6,	6,	3)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (7,	7,	4)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (8,	8,	4)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (9,	9,	5)
INSERT INTO [dbo].[PicoYPlaca]([Id],[LicensePlateNumber],[IdDayOfWeek]) VALUES (10,	0,	5)
GO
INSERT INTO [dbo].[Schedule]([Id],[ScheduleName],[StartTime],[EndTime]) VALUES (1,'Morming','07:30','09:30')
INSERT INTO [dbo].[Schedule]([Id],[ScheduleName],[StartTime],[EndTime]) VALUES (2,'Afternoon','16:00','19:30')