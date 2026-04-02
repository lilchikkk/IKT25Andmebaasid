using System.Drawing;
using System.Reflection.Emit;

namespace EnumProject
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enum");

            //kasutate enumit Weekdays ja tahaks näha Friday
            Console.WriteLine(Weekdays.Friday);

            //tahame näha Friday numbrilist väärtust
            Console.WriteLine((int)Weekdays.Friday);
            Console.WriteLine("---------------------------------");
            //(int) - castimine e teisendab teiseks andmetüübiks
            //juhul kui info võib kaduma minna ja ei näita soovitud tulemust
            Console.WriteLine((int)Colors.Blue);
            Console.WriteLine(Colors.Blue);
            //tehke uus enum Colors 
            //väärtused on 
            //Red = 3,
            //Green = 10,
            //Blue= 13,
            //Yellow= 5,
            //Black = 1,
            //White = 8,
            //ühe värvi nimetus peab konsoolis ära näitama 
        }

        enum Weekdays
        {
            Monday,
            Tuesday,
            Wednesday,
            Thursday,
            Friday,
            Saturday,
            Sunday,
        }

        enum Colors
        {
            Red = 3,
            Green = 10,
            Blue = 13,
            Yellow = 5,
            Black = 1,
            White = 8,
        }
    }
}
