namespace SortedList_Tuple
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Vali meetod:");
            Console.WriteLine("1 - SortedList");
            Console.WriteLine("2 - Tuple"); 
            Console.WriteLine("------------------------"); 

            string choice = Console.ReadLine();

            switch (choice)
            {
                case "1":
                    KasutaSortedList();
                    break;
                
                case "2":
                    KasutaTuple();
                    break;
                default:
                    Console.WriteLine("Vale Valik!");
                    break;
            }
        }
        static void KasutaSortedList()
        {
            //SortedList hoiab Vüti väärtus paare ja sorteerib need automaatselt võtme järgi.
            SortedList<int, string> autod = new SortedList<int, string>();
            autod.Add(1, "BMW");
            autod.Add(2, "Audi");
            autod.Add(3, "Tesla");

            Console.WriteLine("SortedList (sorteeritud võtme järgi):");
            foreach (var auto in autod)
            {
                Console.WriteLine($"ID: {auto.Key}, Karl: {auto.Value}");
            }
        }
        static void KasutaTuple()
        {
            // Tuple on andmestruktuur, mis grupeerib eri tüüpi väärtusi üheks objektiks.
            var autoAndmed = Tuple.Create(1, "Audi", 2022, "Must");
           
            Console.WriteLine("Tuple andmed");
            Console.WriteLine($"ID: {autoAndmed.Item1}");
            Console.WriteLine($"Karl: {autoAndmed.Item2}");
            Console.WriteLine($"Aasta: {autoAndmed.Item3}");
            Console.WriteLine($"Värv:  {autoAndmed.Item4}");


        }
    }
}
