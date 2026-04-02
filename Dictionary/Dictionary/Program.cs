namespace Dictionary
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Dictionary ja foreach");


            //var on muutuja 
            var domains = new Dictionary<string, string>()
            {
               {"fi", "Findland"},
               {"se", "Sweden"},
               {"de", "Germany"},
               {"fr", "France"},
               {"es", "Spain"},
            };
            //kasutate foreachi ja juurde tuleb lisada kolme rida 
            int i = 1;
             foreach (var domain in domains)
            {
                Console.WriteLine($"{domain.Key} - {domain.Value} - {i}");
                 i++;
            }  
           
        }
    }
}
