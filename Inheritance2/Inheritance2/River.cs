namespace Inheritance2
{
    //River on antud juhul alamklass ja viitab Waterile e peamisele classile
    class River : Water
    { 
       //kui kirjutan override, siis kirjutab Water meetodis oleva DoSomething meetodi üle 
       //kui panen siia public virtual void, siis ei kirjuta Water meetodi DoSomething-t üle
        
        public override void DomSomthing()
        {
            //WaterProp waterProp = new WaterProp();
            //Water classis on olemas muutujad Flow ja Lenght ja sellepärast ei pea neid siin uuesti defineerima 
            Console.WriteLine("River This method and it has " + Flow + " is and " + Length + " is in maters ");
        }
    }
}