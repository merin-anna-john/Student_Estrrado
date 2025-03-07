namespace Estrrado_Machine_Test.Service
{
    public interface ILoginService
    {
        bool AuthenticateUser(string username, string password);
    }
}
