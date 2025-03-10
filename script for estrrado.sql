USE [Student_estrrado]
GO
/****** Object:  Table [dbo].[Qualification]    Script Date: 07-03-2025 12:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qualification](
	[QualificationId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseName] [varchar](100) NOT NULL,
	[Percentage] [decimal](5, 2) NULL,
	[YearOfPassing] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QualificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 07-03-2025 12:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Age] [int] NULL,
	[DOB] [date] NOT NULL,
	[Gender] [varchar](10) NULL,
	[EmailId] [varchar](100) NOT NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 07-03-2025 12:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Student] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Qualification]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([StudentId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Qualification]  WITH CHECK ADD CHECK  (([Percentage]>=(0) AND [Percentage]<=(100)))
GO
ALTER TABLE [dbo].[Qualification]  WITH CHECK ADD CHECK  (([YearOfPassing]>=(1900) AND [YearOfPassing]<=datepart(year,getdate())))
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD CHECK  (([Age]>(0)))
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD CHECK  (([Gender]='Other' OR [Gender]='Female' OR [Gender]='Male'))
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllStudents]    Script Date: 07-03-2025 12:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetAllStudents]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        StudentId, 
        FirstName, 
        LastName, 
        Age, 
        DOB, 
        Gender, 
        Email, 
        PhoneNumber
    FROM Students;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertStudent]    Script Date: 07-03-2025 12:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertStudent]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Age INT,
    @DOB DATE,
    @Gender NVARCHAR(10),
    @EmailId NVARCHAR(100),  -- Fixed: Changed Email to EmailId
    @PhoneNumber NVARCHAR(15),
    @Username NVARCHAR(50),
    @PasswordHash NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Prevent duplicate username or email
    IF EXISTS (SELECT 1 FROM Student WHERE Username = @Username OR EmailId = @EmailId)
    BEGIN
        PRINT 'Error: Username or Email already exists!';
        RETURN;
    END

    -- Insert student without StudentId (auto-generated)
    INSERT INTO Student (FirstName, LastName, Age, DOB, Gender, EmailId, PhoneNumber, Username, PasswordHash)
    VALUES (@FirstName, @LastName, @Age, @DOB, @Gender, @EmailId, @PhoneNumber, @Username, @PasswordHash);

    PRINT 'Student inserted successfully!';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUser]    Script Date: 07-03-2025 12:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidateUser]
    @UserName NVARCHAR(50),
    @Password NVARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE Username = @UserName AND PasswordHash = @Password)
        SELECT 1; -- User exists
    ELSE
        SELECT NULL; -- User not found
END
GO
