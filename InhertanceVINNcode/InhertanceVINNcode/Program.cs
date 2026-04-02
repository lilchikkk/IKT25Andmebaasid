namespace InhertanceVINcode
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Teha pärilus 
            //On olemas class nimega Machine 
            //See pärib Cars classi 
            //Saab sisestada masina number 
            //konsool annab vastuse: Edukalt sisetatud 
            //VIN kood: VIN koodi nr

            Console.WriteLine("Sisesta VIN kood:");
            int vinCode = Convert.ToInt32(Console.ReadLine());

            Machine machine = new Machine();
            machine.SetVinCode(vinCode);

            Console.WriteLine("VIN code is: " + machine.GetVinCode);

        }
    }


    class Car
    {
        public void SetVinCode(int vinCode)
        {
            vin = vinCode;
        }

        protected int vin;
    }


    class Machine : Car
    {
        public int GetVinCode()
        {
            return vin;
        }
    }
}

