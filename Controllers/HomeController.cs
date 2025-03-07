using Estrrado_Machine_Test.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Linq;
using System.Diagnostics;
using System.Data.SqlClient;
using Estrrado_Machine_Test.Service;

namespace Estrrado_Machine_Test.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILoginService _loginService;

        public HomeController(ILoginService loginService)
        {
            _loginService = loginService;
        }

        [HttpGet]
        public IActionResult Index()
        {
            return View(new LoginViewModel());
        }

        [HttpPost]
        public IActionResult Index(LoginViewModel model)
        {
           // if (ModelState.IsValid)
            {
                if (_loginService.AuthenticateUser(model.Username, model.Password))
                {
                    //HttpContext.Session.SetString("UserSession", model.Username);
                    return RedirectToAction("Register", "Student");
                }
                model.ErrorMessage = "Invalid username or password.";
            }
            return View(model);
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }
    }
}