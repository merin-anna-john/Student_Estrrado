using System.ComponentModel.DataAnnotations;

namespace Estrrado_Machine_Test.Models
{
    public class LoginViewModel
    {
        [Required]
        public string Username { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        public string ErrorMessage { get; set; }
    }
}
