
using AutoMapper;
using Microsoft.Extensions.Logging;

namespace Mapping
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Mapper");


            Employee emp = new Employee();

            emp.Id = 11;
            emp.Name = "Name1";
            emp.Title = "Title1";
            emp.Description = "Description1";


            //mappimine algab pihta 
            EmployeesDto dto = new EmployeesDto();


            //mappinine on see kus mõlema klassi muutujad viiakse omavahel kokku
            //protsess kus muudatakse andmete ühist formaadist, struktuurist või 
            //süsteemi teiseks 

            //kasutakse väärtuste ja muutmiste abil et ühenduda andmebaasi
            //olevate tabelitega 
            dto.Id = emp.Id;
            dto.Name = emp.Name;
            dto.Title = emp.Title;
            dto.Description = emp.Description;

            Console.WriteLine(dto.Id + " " + dto.Name + " " + dto.Title + " " + dto.Description);

            Console.WriteLine("---------------------------------");
            Console.WriteLine("AutorMapper");

            var loggerFactory = LoggerFactory.Create(builder => { });


            var config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<Employee, EmployeesDto>();
            }, loggerFactory);

            IMapper mapper = config.CreateMapper();

            var emp2 = new Employee
            {
                Id = 12,
                Name = "Name2",
                Title = "Title2",
                Description = "Description2",

            };
            var dto2 = mapper.Map<EmployeesDto>(emp2);
            Console.WriteLine(dto2.Id + " " + dto2.Name + " " + dto2.Title + " " + dto2.Description);
            
            
            Console.WriteLine("---------------------------------");
            Console.WriteLine("Car");
            //var loggerFactory = LoggerFactory.Create(builder => { });


            //var config = new MapperConfiguration(cfg =>
            //{
            //    cfg.CreateMap<Employee, EmployeesDto>();
            //}, loggerFactory);

            //IMapper mapper = config.CreateMapper();

            //var emp2 = new Employee
            //{
            //    Id = 12,
            //    Name = "Name2",
            //    Title = "Title2",
            //    Description = "Description2",

            //};
            //var dto2 = mapper.Map<EmployeesDto>(emp2);
            //Console.WriteLine(dto2.Id + " " + dto2.Name + " " + dto2.Title + " " + dto2.Description);


        }
        //Tehke üks mappimine juurde ja teemasks on autod 
        //peate kaks classi tegema nimega Car ja CarsDto 

    }

    //program.cs ot tegemist failiga, kus on program class ja 
    //nüüd oleme lisanud juurde Employee classi 
    //kindlasti tuleb järgida, et class ei oleks classi sees
    public class Employee
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;

    }
    //miks panakse classi nimetuse taha dto?
    //Dto tähendab data transfer object 
    //neid classe kasutakse andmete edastamiseks 
    public class EmployeesDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
    }
}


