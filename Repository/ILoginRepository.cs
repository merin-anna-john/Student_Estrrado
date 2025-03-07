namespace Estrrado_Machine_Test.Repository
{
    public interface ILoginRepository
    {
        bool ValidateUser(string username, string password);
    }
}
