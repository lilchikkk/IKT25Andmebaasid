namespace LINQ2
{
    public class PeopleList
    {
        public static readonly List<People> peoples = new List<People>
        {
          new People()
          {
              Id = 1,
              Name = "Johanna",
              Age = 31,
              GenderId = Guid.Parse("02817625-76dc-4a1c-b0e6-52dc9d2e974a")
          },
          new People()
          {
              Id = 2,
              Name = "Johanna",
              Age = 21,
              GenderId = Guid.Parse("6c77277c-a31d-481d-ac1d-434acc998949")
          },
          new People()
          {
              Id = 3,
              Name = "Ron",
              Age = 18,
              GenderId = Guid.Parse("bdd2a54f-57af-4012-b38d-117165021c6c")
          },
          new People()
          {
              Id = 4,
              Name = "Anna",
              Age = 25,
              GenderId = Guid.Parse("45ae3a5e-8349-4e79-8508-e61c6ab65844")
          },
          new People()
          {
              Id = 5,
              Name = "Mari",
              Age = 19,
              GenderId = Guid.Parse("8b0e43d7-1ad8-49c5-aaa3-dbb871512617")
          },
          new People()
          {
              Id = 6,
              Name = "Mari",
              Age = 28,
              GenderId = Guid.Parse("480f38c0-1262-49db-bb38-470fe852dc76")
          },
        };
    }
}
