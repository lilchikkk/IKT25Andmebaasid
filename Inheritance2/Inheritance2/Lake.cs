namespace Inheritance2
{
     class Lake : Water
    {
        //tehke sama asi, mis Riveri-ga ja kutsuge see Programm classis Main meetodis  esile 

        public override void DomSomthing()
        {
            Console.WriteLine("Lake This method and it has " + Flow + " is and " + Length + " is in maters ");
        }

    }
}
