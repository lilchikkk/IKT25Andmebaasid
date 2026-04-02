namespace ArraySortNames
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("------------------------");
            Console.WriteLine("Kasutame Array ja sort-i");
            Console.WriteLine("------------------------");
          
            string[] animals = { "cat", "alligator", "fox", 
                "donkey", "bear", "elephant", "goat" };
            //tuleb kasutada foreachi ja näidata kõiki loomi 
            //paneb kõik tähestikulisse järjekorda
            //Array.Sort(animals);
            foreach (string animal in animals)
            {
                Console.WriteLine(animal);
            }
            Console.WriteLine("--------------------------------------------");
            Console.WriteLine("Kolm esimest sõna tähestikulises järjestuses");
            Console.WriteLine("--------------------------------------------");
            //järjesta kolm esimest sõna tähestikulises järjestuses
            //vaadake sort meetodit ja mitu overload sel on 


            Array.Sort(animals, 0, 3);
            foreach (string animal in animals)
            {
                Console.WriteLine(animal);      
            }
           
            Console.WriteLine("-----------------------------");
            Console.WriteLine("Kordustete vältimine(Numbrid)");
            Console.WriteLine("-----------------------------");
            int [] numbers  = { 1, 2, 3, 4, 3, 55, 23, 2 };
            //Tuleb välistada korduseid 
            //Mida teha, et numbrid ei korduks ???

            int[] uniqueNumbers = numbers.Distinct().ToArray();
            Array.Sort(uniqueNumbers);
            foreach (int number in uniqueNumbers)
            {
                Console.WriteLine(number);
            }
        }
    }
}
