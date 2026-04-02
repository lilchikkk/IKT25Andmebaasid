namespace ListLINQ
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("List and LINQ");
            Console.WriteLine("--------------");
            //teeme "andmebaasist"
            //ja selleks on vaja luua class nimega Person
            IList<Person> person = new List<Person>()
            {
               new Person() {Id = 1, Name = "Juku", Age = 10},
               new Person() {Id = 2, Name = "Johanna", Age = 16},
               new Person() {Id = 3, Name = "Liliia", Age = 16},
               new Person() {Id = 4, Name = "Aksel", Age = 11},
            };
            //nääd kasutame person muutuja uue muutuja all
            //mille nimeks on person
            var persons = from p in person
                          select new
                          {
                              Id = p.Id,
                              Name = p.Name,
                              Age = p.Age,
                          };

            //kasutame muutujate persons, et näidata konsoolis tulemust 
            foreach (var item in person)
            {
                Console.WriteLine("Id on " + item.Id + " ja nimi on " + item.Name);
            }

            Console.WriteLine("----------------------------------------");
            Console.WriteLine("Kasutame LINQ Selecti ehk teine variant");
           //siin koondame kogu info result muutuja sisse 

            var result = person
              //Whre-ga saab teha konkreetse päringu, et vastab mingi tingimustele
                .Where(p => p.Id == 1 || p.Age == 9)
                .OrderBy(p => p.Name) //järjestab isikud nime järgi
                .Select(x => new
                {
                    Id = x.Id,
                    Name = x.Name,
                    Age = x.Age
                });
          
            //kasutame result muutuja ja teeme ta lahti rea kaupa 
            //läbi muutuja item
            foreach (var item in result)
            {
                Console.WriteLine("Id on " + item.Id + " ja nimi on " + item.Name);
            }
            Console.WriteLine("Gruppide kaupa sorteerimine");
            var groupBy = person
                .GroupBy(p => p.Age);
            //kuvab gruppide kaupa ja antud juhul paneb vanused gruppides 
            //e tulemuseks on kolm rida andmei kuna kaks isikut on 9 a
                 
            foreach (var item in groupBy)
            {
                Console.WriteLine("vanuse grupp on: {0}",  item.Key);
            }

        }
    }
}
