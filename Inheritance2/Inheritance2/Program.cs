namespace Inheritance2
{
    internal class Program
    {
        static void Main()
        {
            Console.WriteLine("Inheritance 2");
            //kui siin on Water class, siis kuvatakse seal olevat DoSomething meetodi sisu 
            Water water = new Water();

            //kui panna Water water  = new River(); , siis kuvataks Riveri classis olevat DoSomethinga
            //meetodi sisu.
            Water water2 = new River();
            water2.Flow = true;
            water2.Length = "123";

            Water water3 = new Lake();
            water3.Flow = false;
            water3.Length = "987";
          
            //kutsume soovitud meetodi esile.
            water.DomSomthing();
            water2.DomSomthing();
            water3.DomSomthing();
        }
    }
}
