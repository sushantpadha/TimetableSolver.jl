# this file is executed for building a custom system image of this project

using TimetableSolver

C9 = Division(9, 3)
D10 = Division(10, 4)

ajay = Teacher("Ajay Magotra", "AJA", ["MATH",], [9, 10])
kotwal = Teacher("Kotwal Singh", "KOT", ["MATH",], [9,])
deepika = Teacher("Deepika Ibikunle", "DPK", ["ENG",], [9, 10])
ganguly = Teacher("Ganguly A", "GNG", ["SPORTS",], [9,])
sanjay = Teacher("Sanjay Pandey", "SNJ", ["SCIENCE",], [10,])

subjectcounts_C9 = OrderedDict(
    "MATH"=>2, "ENG"=>2, "SPORTS"=>1
)
subjectcounts_D10 = OrderedDict(
    "MATH"=>2, "ENG"=>1, "SCIENCE"=>2
)

tt_C9 = Timetable(
    [3, 2],
    subjectcounts_C9,
    [ajay, kotwal, deepika, ganguly],
    C9
)
tt_D10 = Timetable(
    [3, 2],
    subjectcounts_D10,
    [ajay, deepika, sanjay],
    D10
)

schedule = Schedule(tt_C9, tt_D10)

vardata = get_data(schedule)
m, modelvars = get_model(vardata)

vardata = get_data(schedule)
model, modelvars = get_model(vardata)
rawsolution, status = get_solution(model, modelvars, vardata)
solution = convertsolution(rawsolution, vardata)
applysolution!(schedule, solution)
solution, status = solve!(schedule)
