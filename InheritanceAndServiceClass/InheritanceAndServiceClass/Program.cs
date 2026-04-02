using System;
using InheritanceAndServiceClass.AppServices.Services;
using InheritanceAndServiceClass.Core.ServiceInterface;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace InheritanceAndServiceClass
{
    internal class Program
    {
        private readonly ICarServices _carServices;

        public Program
            (
            ICarServices carServices
            )

        {
            _carServices = carServices;
        }
        static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddScoped<ICarServices, CarServices>();

            Console.WriteLine("Hello, World Switch!");
            int choice = int.Parse(Console.ReadLine());

            switch (choice)
            {
                case 1:
                    var app = builder.Build();
                    using (var scope = app.Services.CreateScope())
                    {
                        var carServices = scope.ServiceProvider.GetRequiredService<ICarServices>();
                        var program = new Program(carServices);
                        program.GetAsync();
                    }
                    break;

                case 2:
                    var app2 = builder.Build();
                    using (var scope = app2.Services.CreateScope())
                    {
                        var carServices = scope.ServiceProvider.GetRequiredService<ICarServices>();
                        var program = new Program(carServices);
                        program.EraseData();
                    }
                    break;

                case 3:
                    var app3 = builder.Build();
                    using (var scope = app3.Services.CreateScope())
                    {
                        var carServices = scope.ServiceProvider.GetRequiredService<ICarServices>();
                        var program = new Program(carServices);
                        program.UpdateData();
                    }
                    break;

                case 4:
                    var app4 = builder.Build();
                    using (var scope = app4.Services.CreateScope())
                    {
                        var carServices = scope.ServiceProvider.GetRequiredService<ICarServices>();
                        var program = new Program(carServices);
                        program.EraseData();
                    }
                    break;


                default:
                    Console.WriteLine("Error");
                    break;
            }
        }
        public IActionResult GetAsync()
        {
            _carServices.GetData();
            return View();
        }
        public IActionResult SaveAsync()
        {
            _carServices.PostData();

            return View();
        }

        public IActionResult UpdateData()
        {
            _carServices.PutData();

            return View();
        }

        public IActionResult EraseData()
        {
            _carServices.DeleteData();

            return View();
        }
        private IActionResult View()
        {
            throw new NotImplementedException();
        }
    }
}

