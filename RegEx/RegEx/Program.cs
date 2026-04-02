using System.Text.RegularExpressions;

namespace RegEx
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Teeme Regular Expression harjutuse");
            Console.WriteLine("----------------------------------");
            string word = "#CD5K5C";
            Console.WriteLine("Hex code: " + word); 
            Console.WriteLine("Kas on Regex: " + RegExTest(word));

            //Tee regex, mis on false tulemusega 
            //Põhjenda ära, et miks  on false
        }
       public static bool RegExTest(string word) 
       { 
       //Regular Expression kontrollib, kas sisestav string
       //vastab nõuatele
            return Regex.IsMatch(word, @"[#][0-9A-Fa-f]{6}\b");
        
       }
    }
}
