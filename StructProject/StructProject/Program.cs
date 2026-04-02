using System.Drawing;
using System.Xml.Linq;

namespace StructProject
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello Struct");


            Coordinate point = new Coordinate(3, 5);
            Console.WriteLine(point.X);
            Console.WriteLine(point.Y);


            Console.WriteLine("-------------");
            IntAndString intAndString = new IntAndString();
            Console.WriteLine(intAndString.Age);
            Console.WriteLine(intAndString.Name);
            
            
            Console.WriteLine("-------------");
            InsertedIntAndString insertedIntAndString = new InsertedIntAndString();
            Console.WriteLine(insertedIntAndString.PostalCode);
            Console.WriteLine(insertedIntAndString.City);
            Console.WriteLine();
        }
    }
    //Mis on struct????
    //See on väärtustüüp(valu type), mis sarnaneb klassile 
    struct Coordinate
    {
        public int X;
        public int Y;

        //teha konstruktor
        public Coordinate(int x, int y)
        {
            X = x;
            Y = y;
        }
    }

    //Teha struct nimega IntAndString
    //string Name ja int on Aeg 
    //kutsuda see struct Main-s välja

    struct IntAndString
    {
        public string Name;
        public int Age;

        public IntAndString(string name, int age)
        {
            Name = name;
            Age = age;
        }
    }

    //Teha struct nimega InsertedIntAndString
    //string City ja int on PostalCode 
    //kutsuda sees tuleb sellele anda juba väärtuse 

    struct InsertedIntAndString
    {
        public string City;
        public int PostalCode;

        public InsertedIntAndString(string city, int postalCode)
        {
            City = "Asd";
            PostalCode = 123;
           

        }
    }
}
