using System.Linq;

namespace MinMaxSum
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("List numbrites");

            int[] numbers = new int[10] { 2, 10, 15, 6, 8, 22, 3, 35, 67, 34 };
            
            //Max
            Console.WriteLine(numbers.Max());
            
            //Min
            Console.WriteLine(numbers.Min());
           
            //Sum
            Console.WriteLine(numbers.Sum());

            //Average
            Console.WriteLine(numbers.Average());
            
            Console.WriteLine("---------------------------------------------");
            Console.WriteLine("Sorteerib numbrid alates väiksemast suuremani");
            Console.WriteLine("\n");
           
            //Peate kasutama Array ja Sort ning foreachi
            Array.Sort(numbers);
            
            foreach (int i in numbers)
            {
                Console.WriteLine(i);
            }
            //sorteerib numbrid alates suuremast väiksemani
            Console.WriteLine("---------------------------------------------");
            Console.WriteLine("sorteerib numbrid alates suuremast väiksemani");
            
            Console.WriteLine("\n");
            Array.Sort(numbers);
            Array.Reverse(numbers);
            foreach (int i in numbers)
            {
                Console.WriteLine(i);
            }
            Console.WriteLine("---------------------------------------------");
            //kasutate binarySearch-i
            //kirjuta lühidalt, mis see tähendab
            Console.WriteLine(Array.BinarySearch(numbers, 5));
        
        }
    }
}
