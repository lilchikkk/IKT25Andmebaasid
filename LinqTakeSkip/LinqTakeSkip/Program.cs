namespace LinqTakeSkip
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Kutsume esile LINQ meetodi");
            Console.WriteLine("1. Skip ");
            Console.WriteLine("2. SkipWhile ");
            Console.WriteLine("3. TakeWhile ");
            Console.WriteLine("4. FirstOrDefault ");
            Console.WriteLine("5. AvarageLINQ ");
            Console.WriteLine("6. CountLINQ ");
            Console.WriteLine("7. Sum ");
            Console.WriteLine("8. Max ");
            Console.WriteLine("9. Min ");
            //siin kasutada switchi ja peab saama Skip meetodoi esile kutsuda 
            int choice = int.Parse(Console.ReadLine());

            switch (choice)
            {
                case 1:
                    Skip();
                    break;

                case 2:
                    SkipWhile();
                    break;

                case 3:
                    TakeWhile();
                    break;

                case 4:
                    FirstOrDefault();
                    break;

                case 5:
                    AvarageLINQ();
                    break;

                case 6:
                    CountLINQ();
                    break;

                case 7:
                    Sum();
                    break;
               
                case 8:
                    MaxLinq();
                    break;
               
                case 9:
                    MinLinq();
                    break;

                default:
                    Console.WriteLine("vale valik");
                    break;

            }
        }

        public static void Skip()
        {

            Console.WriteLine("------------Skip------------");
            //kasuta skip ja jätta kolm tükki vahele
            var skip = PeopleList.people.Skip(3);

            foreach (var item in skip)
            {
                Console.WriteLine(item.Name);
            }
        }

        //teete uue meetodi, aga kasutame SkipWhile ja vanemad, kui 18 peab olema tingimus
        public static void SkipWhile()
        {

            Console.WriteLine("------------SkipWhile------------");
            //mis tähendab: => . See tähendab lambda märki
            //abil saab kasutada pikkema classi asemel lühendit
            //koos oleva muutujaga, mis antud juhul on x .
            var SkipWhile = PeopleList.people.SkipWhile(x => x.Age > 18);

            foreach (var item in SkipWhile)
            {
                Console.WriteLine(item.Id + " " + item.Name + " " + item.Age);
            }
            //SkipWhile jätab loendis nii kaua vahele ridu kuni vastab tingimustele
            //e antud juhul jätab read vahele kuni leiab 18 a isiku ja
            //peale seda hakkab infot jälle kuvama olemata vanuse tingimusest 
        }
        //kasutada TakeWhile ja kutsuda see esile Switchis
        //tingimus on Age > 18

        //vooskeem teha TakeWhile meetodist
        public static void TakeWhile()
        {

            Console.WriteLine("------------TakeWhile------------");

            var takeWhileResult = PeopleList.people.TakeWhile(x => x.Age > 18);

            foreach (var item in takeWhileResult)
            {
                Console.WriteLine(item.Id + " " + item.Name + " " + item.Age);
            }
            //TakeWhile näitab isikud kuni vastab tingimustele
            //e antud juhul näitab andmeid kuni  leiab 18 a. isiku ja
            //peale seda enam ei näita andmeid 
        }
        public static void FirstOrDefault()
        {
            //Õpetaja vajrant:

            //peate kasutama Name'i ja Lenght'i. Nimi peab olema vähemalt 5
            //tähemärki pikk

            //kuvab esimese elemedni, mis järjestuses vastab tingimusetele
            string firstLongName = PeopleList.people
            .FirstOrDefault(x => x.Name.Length >= 5).Name;

            Console.WriteLine("The first long name is: '{0}'.", firstLongName);

            //Minu varjant:

            //string firstLongName = PeopleList.people.First().Name;

            //Console.WriteLine("The first long name is: " + "'" + firstLongName + "'");
        }
        //kasutame Avarage Linq
        //muutujaks on Age
        public static void AvarageLINQ()
        {
            Console.WriteLine("-------[ Average ]--------");

            var average = PeopleList.people
                .Average(x => x.Age);

            Console.WriteLine("Keskmine vanus on: " + average);

        }

        public static void CountLINQ()
        {
            var totalPersons = PeopleList.people.Count();

            Console.WriteLine("Inimesi on kokku: " + totalPersons);
            Console.WriteLine("------------------------------- ");

            var adultPerson = PeopleList.people.Count(x => x.Age >= 18);
            Console.WriteLine("Täiskasvanuid inimesi on kokku: " + adultPerson);
        }

        //kasutame summat e Sum
        public static void Sum()
        {
            var sumAge = PeopleList.people.Sum(x => x.Age);
            Console.WriteLine("Koondvanus on: " + sumAge);

            Console.WriteLine("------------------------------- ");

            var sumAdults = 0;
            var numAdults = PeopleList.people.Sum(x =>
            {
                if (x.Age > 0)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            });
            Console.WriteLine("Täiealiste isikute koondarv: " + numAdults);
        }
        //kasutad Max
        public static void MaxLinq()
        {
            var oldestPerson = PeopleList.people
                .Max(x => x.Age);
            
            Console.WriteLine("Kõige vanem isik on: " + oldestPerson);
        }
        //kasutad Min
        public static void MinLinq()
        {
            var youngestPerson = PeopleList.people
                .Min(x => x.Age);

            Console.WriteLine("Kõige noorem isik on: " + youngestPerson);
        }
    }
}
