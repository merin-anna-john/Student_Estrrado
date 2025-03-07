using Estrrado_Machine_Test.Models;
using Estrrado_Machine_Test.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Estrrado_Machine_Test.Controllers
{
    public class StudentController : Controller
    {
        private readonly IStudentService _studentService;

        public StudentController(IStudentService studentService)
        {
            _studentService = studentService;
        }

        [HttpGet]
        public IActionResult Register()
        {
            //if (HttpContext.Session.GetString("UserSession") == null)
            //{
            //    return RedirectToAction("Index", "Home"); // Redirect to login if session is missing
            //}

            return View();
        }

        [HttpPost]
        public IActionResult Register(Student student)
        {
            if (ModelState.IsValid)
            {
                _studentService.RegisterStudent(student);
               // return RedirectToAction("ListStudents");
            }
            return View(student);
        }
    }
}