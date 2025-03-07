using Estrrado_Machine_Test.Repository;

namespace Estrrado_Machine_Test.Service
{
    public class LoginService : ILoginService
    {
        private readonly ILoginRepository _loginRepository;

        public LoginService(ILoginRepository loginRepository)
        {
            _loginRepository = loginRepository;
        }

        public bool AuthenticateUser(string username, string password)
        {
            return _loginRepository.ValidateUser(username, password);
        }
    }
}
