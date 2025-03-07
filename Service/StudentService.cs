using Estrrado_Machine_Test.Models;
using Estrrado_Machine_Test.Repository;

namespace Estrrado_Machine_Test.Service
{
    public class StudentService : IStudentService
    {
        private readonly IStudentRepository _studentRepository;

        public StudentService(IStudentRepository studentRepository)
        {
            _studentRepository = studentRepository;
        }

        public void RegisterStudent(Student student)
        {
            student.StudentId = GenerateStudentId();
            _studentRepository.AddStudent(student);
        }

        private string GenerateStudentId()
        {
            return "STU_" + new Random().Next(1000, 9999);
        }
    }
}
