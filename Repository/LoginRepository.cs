using System.Data.SqlClient;
using System.Data;

namespace Estrrado_Machine_Test.Repository
{
    public class LoginRepository : ILoginRepository
    {
        private readonly string _connectionString;

        public LoginRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("ConnectionMVCWin");
        }

        public bool ValidateUser(string username, string password)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_ValidateUser", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();
                    int result = Convert.ToInt32(cmd.ExecuteScalar());

                    return result == 1;
                }
            }
        }
    }
}
