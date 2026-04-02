namespace LinqAllAny
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello LINQ");
            Console.WriteLine("1.All");
            Console.WriteLine("2.Any");
            Console.WriteLine("3.JoinLinq");

            int choice = int.Parse(Console.ReadLine());

            switch (choice)
            {
                case 1:
                    AllLinq();
                    break;

                case 2:
                    AnyLinq();
                    break;

                case 3:
                    JoinLinq();
                    break;

                default:
                    Console.WriteLine("ERROR");

                    break;


            }
        }
        public static void AllLinq()
        {
            //kasutate All 
            //kontrollite, kas on vanemaid, kui 12 ja nooremaid, kui 20
            int[] ages = { 13, 21, 18, 20, 15 };
            bool result = StudentData.students.All(x => x.Age > 12 && x.Age < 20);
            Console.WriteLine("kas on vanemaid, kui 12 ja nooremaid, kui 20 ?");
            Console.WriteLine(result);
        }

        //teeme uuue meetodi nimega AnyLinq 
        //kasutada Any-t 
        //vastus on true
        //kasutad amuutuja Age

        public static void AnyLinq()
        {
            bool result = StudentData.students.Any(x => x.Age > 12 && x.Age < 20);
            Console.WriteLine(result);
        }
        //teha meetodi nimega JoinLinq
        //kasutada Join-i
        //kasutada Foreach
        public static void JoinLinq()
        {
            var innerJoin = StudentData.students
                .Join
                (

                StandartData.standart,
                students => students.StandartId,
                standartId => standartId.StandartId,
                (students, standartsId) => new
                {
                    Name = students.Name,
                    standart  = students.StandartId,
                }


                );

            foreach (var item in innerJoin)
            {
                Console.WriteLine("{0} - {1}", item.Name, item.standart);
            }
        }
    }
}
