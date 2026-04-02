namespace Inheritance2
{
    internal class Water
    {
        public bool Flow;
        public string Length;

       //siis on DoSomething meetod, mida siis viidatakse River classi all.
       //see võib olla virtual ja pea panema override kuna tead kirjutatakse üle 

        public virtual void DomSomthing()
        {
            Console.WriteLine("Do Something method");
        }

    }

}
