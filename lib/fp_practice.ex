defmodule FpPractice do
  def student_staff_name_group(classes) do
    gt_30 = fn x -> x.age >= 30 end
    get_full_name = fn x -> x.first_name <> " " <> x.last_name end
    get_first_name = fn n -> List.first(String.split(n, " ")) end

    cc = classes
    |> Enum.map(fn %{teacher: t, assistants: a, students: s} -> %{staff: List.wrap(t) ++ List.wrap(a), students: List.wrap(s)} end)
    |> Enum.map(fn %{staff: sf, students: st} -> %{staff: Enum.filter(sf, gt_30), students: Enum.filter(st, gt_30)} end)
    |> Enum.map(fn %{staff: sf, students: st} -> %{staff: Enum.map(sf, get_full_name), students: Enum.map(st, get_full_name)}end)
    |> Enum.reduce(fn %{staff: sf, students: st}, accu -> %{staff: accu.staff ++ sf, students: accu.students ++ st} end)

    if %{staff: sf, students: st} = cc do
      %{staff: Enum.group_by(sf, get_first_name), students: Enum.group_by(st, get_first_name)}
    end
  end

  def test_classes do
    [
      %{
        name: "1A",
        teacher: %{
          age: 28,
          first_name: "Tricia",
          last_name: "Garrett"
        },
        assistants: %{
          age: 38,
          first_name: "Liliana",
          last_name: "Kidd"
        },
        students: [
          %{
            age: 46,
            first_name: "Luz",
            last_name: "Casey"
          },
          %{
            age: 38,
            first_name: "Rosemary",
            last_name: "Barber"
          }
        ]
      },
      %{
        name: "1B",
        teacher: %{
          age: 43,
          first_name: "Ollie",
          last_name: "Matthews"
        },
        assistants: nil,
        students: [
          %{
            age: 45,
            first_name: "Ollie",
            last_name: "Sandoval"
          },
          %{
            age: 27,
            first_name: "Gale",
            last_name: "Coleman"
          }
        ]
      },
      %{
        name: "2A",
        teacher: %{
          age: 49,
          first_name: "Liza",
          last_name: "Vega"
        },
        assistants: %{
          age: 48,
          first_name: "Tricia",
          last_name: "Brewer"
        },
        students: [
          %{
            age: 24,
            first_name: "Ophelia",
            last_name: "Roy"
          },
          %{
            age: 40,
            first_name: "Ophelia",
            last_name: "Sears"
          },
          %{
            age: 37,
            first_name: "Gale",
            last_name: "Strong"
          }
        ]
      },
      %{
        name: "2B",
        teacher: %{
          age: 24,
          first_name: "Rochelle",
          last_name: "Wilcox"
        },
        assistants: [
          %{
            age: 32,
            first_name: "Gale",
            last_name: "Christensen"
          },
          %{
            age: 46,
            first_name: "Luz",
            last_name: "Crawford"
          },
          %{
            age: 38,
            first_name: "Rosemary",
            last_name: "Casey"
          }
        ],
        students: [
          %{
            age: 42,
            first_name: "Gale",
            last_name: "Joseph"
          },
          %{
            age: 38,
            first_name: "Ophelia",
            last_name: "Crawford"
          },
          %{
            age: 45,
            first_name: "Gale",
            last_name: "Bowers"
          }
        ]
      }
    ]
  end
end
