using Encapsulation.Servisce;

namespace Encapsulation
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Encapsilation e kapseldamine");

            //ligipääs classile Student ei ole piiratud kuna 
            //asub samas projektis 
            Student student = new Student();

            //miks on error ???
            //Student ei tohi teha public classiks
            //koodi ei tohi parandada, aga pead aru saama, miks on viga
            //miks internal class ei saa viidata teises projektis,
            //aga samas projektis olevat saab?
            //kui on tegemist internal classiga, siis ei saa teisest 
            //projektist neid esile kutsuda
            // Student2 student2 = new Student2();

            student.Id = 101;
            student.Name = "Test";
            student.Email = "Test@test.com";

            Console.WriteLine("Id = " + student.Id);
            Console.WriteLine("Name = " + student.Name);
            Console.WriteLine("Email = " + student.Email);


            //kasutame ProtectedStudent classi
            ProtectedStudent protectedStudent = new ProtectedStudent();
            //protectedStudent.DoSomething();
            //ei saa kasutada kuna asub teises classis, aga samas projektis
            //teha Proagram.cs classi meetos nimega DoSomthingInProgramClass
            //ja kutsuda see esile Program meetodis
            Console.WriteLine("------------------------------------");
            Program program = new Program();
            program.DoSomthingInProgramClass();

            //kutsuda PrivateProtectedInProgramClass esile
            Console.WriteLine("---PrivateProtectedInProgramClass---");

            Program pp = new Program();
            Console.WriteLine(pp.PrivateProtectedInProgramClass =
                "PrivateProtectedInProgramClass");

            //soovime kasutada PrivateProtectedStudent classis olevat
            //meetodi ja kutsuda see esile Main meetodis.

            var privateProtectedStudent = new PrivateProtectedStudent();
            //kui asub samas classis, siis saab kasutada, 
            //aga teises classis ei saa
            //privateProtectedStudent.PrivateProtectedStudent1 = "asdasd";


            //sealed classi kasutamine 
            Console.WriteLine("---- Sealed Class ----");
            //
            var sc = new SealedStudent();
            sc.Id = 123;
            sc.Name = "Test";
            sc.Email = "seledTesr@sealed.com";

           //$ - strinf formaat e saan kasutada stringiväliseid muutujaid

           Console.WriteLine($"Id on {sc.Id}, Name on {sc.Name}, Email on {sc.Email}");
        }
        protected void DoSomthingInProgramClass()
        {
            Console.WriteLine("DoSomthingInProgramClass");
        }

        private protected string PrivateProtectedInProgramClass =
            "DoSomthingInProgramClass";



    }
}
