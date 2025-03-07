using System.ComponentModel.DataAnnotations;

namespace Estrrado_Machine_Test.Models
{
    public class Student
    {
        [Key]
        public string StudentId { get; set; }

        [Required]
        public string FirstName { get; set; }

        public string LastName { get; set; }

        [Required]
        public int Age { get; set; }

        [Required]
        public DateTime DOB { get; set; }

        [Required]
        public string Gender { get; set; }

        [Required, EmailAddress]
        public string Email { get; set; }

        [Required, Phone]
        public string PhoneNumber { get; set; }

        [Required]
        public string Username { get; set; }

        [Required]
        public string PasswordHash { get; set; }

        public List<Qualification> Qualifications { get; set; }
    }

    public class Qualification
    {
        [Key]
        public int QualificationId { get; set; }

        public string StudentId { get; set; }

        [Required]
        public string CourseName { get; set; }

        [Required]
        public string University { get; set; }

        [Required]
        public int YearOfPassing { get; set; }

        [Required]
        public decimal Percentage { get; set; }
    }
}

