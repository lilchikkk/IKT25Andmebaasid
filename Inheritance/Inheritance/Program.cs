namespace Inheritance
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Insert to numbers: ");
            Console.WriteLine("Frist number: ");
            int fristNr = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Second number: ");
            int secondNr = Convert.ToInt32(Console.ReadLine());

            Rectangle rectangle = new Rectangle();
            rectangle.SetWidth(fristNr);
            rectangle.SetHeight(secondNr);
            Console.WriteLine("Total area: {0}", rectangle.GetArea());
        }
    }

    class Shape
    {
        public void SetWidth(int w)
        {
            width = w;
        }

        protected int width;
        protected int height;
        public void SetHeight(int h)
        {
            height = h;
        }

        protected int Width;
        protected int Height;
    }
    
    //koolon tähendab pärimist
    //läbi pärimise saame kasutada muutujaid width ja height, mis asuvad Shape classis
    //ning neid ei pea siis defineerima Rectangle classis
    class Rectangle : Shape
    {
        public int GetArea()
        {
            //return tagastab infot selles meetodis toimunud loogika kohta
            return (width * height);
        }
    }
}


