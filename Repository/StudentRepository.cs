using Estrrado_Machine_Test.Models;
using System.Data;
using System.Data.SqlClient;

namespace Estrrado_Machine_Test.Repository
{
    public class StudentRepository : IStudentRepository
    {
        private readonly string _connectionString;

        public StudentRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("ConnectionMVCWin");
        }

        public void AddStudent(Student student)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_InsertStudent", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@StudentId", student.StudentId);
                    cmd.Parameters.AddWithValue("@FirstName", student.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", student.LastName);
                    cmd.Parameters.AddWithValue("@Age", student.Age);
                    cmd.Parameters.AddWithValue("@DOB", student.DOB);
                    cmd.Parameters.AddWithValue("@Gender", student.Gender);
                    cmd.Parameters.AddWithValue("@Email", student.Email);
                    cmd.Parameters.AddWithValue("@PhoneNumber", student.PhoneNumber);
                    cmd.Parameters.AddWithValue("@Username", student.Username);
                    cmd.Parameters.AddWithValue("@PasswordHash", student.PasswordHash);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
