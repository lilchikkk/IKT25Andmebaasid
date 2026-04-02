using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LINQ.NewFolder;

namespace LINQ
{
    class PeopleData
    {
        public static readonly List<PeopleList> peoples = new List<PeopleList>
        {
          new PeopleList()
          {
              Id = 1,
              Name = "Johanna",
              Age = 31,
              GenderId = Guid.Parse("02817625-76dc-4a1c-b0e6-52dc9d2e974a")
          },
          new PeopleList()
          {
              Id = 2,
              Name = "Johanna",
              Age = 21,
              GenderId = Guid.Parse("6c77277c-a31d-481d-ac1d-434acc998949")
          },
          new PeopleList()
          {
              Id = 3,
              Name = "Ron",
              Age = 18,
              GenderId = Guid.Parse("bdd2a54f-57af-4012-b38d-117165021c6c")
          },
          new PeopleList()
          {
              Id = 4,
              Name = "Anna",
              Age = 25,
              GenderId = Guid.Parse("45ae3a5e-8349-4e79-8508-e61c6ab65844")
          },
          new PeopleList()
          {
              Id = 5,
              Name = "Mari",
              Age = 19,
              GenderId = Guid.Parse("8b0e43d7-1ad8-49c5-aaa3-dbb871512617")
          },
          new PeopleList()
          {
              Id = 6,
              Name = "Mari",
              Age = 28,
              GenderId = Guid.Parse("480f38c0-1262-49db-bb38-470fe852dc76")
          },
          new PeopleList()
          {
              Id = 7,
              Name = "Bill",
              Age = 21,
              GenderId = Guid.Parse("f429b707-c90e-42e0-8879-b00f9bd3bd9a")
          },
        };
    }      
}
