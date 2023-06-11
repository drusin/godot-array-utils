extends Node

func _ready() -> void: test_run()

func test_run() -> void:
	for key in test_suite.keys():
		print("Running " + key)
		test_suite[key].call()
	print("test run successfull!")
	get_tree().quit()


var test_suite := {
	"test int asc" = func () -> void:
		var input := [4, 2, 6, 1, 3, 5]
		Arrays.sort(input, Comparators.which(Comparators.NUMBER))
		assert(input == [1, 2, 3, 4, 5, 6]),
	
	"test int desc" = func () -> void:
		var input := [4, 2, 6, 1, 3, 5]
		Arrays.sort(input, Comparators.which(Comparators.NUMBER), Arrays.DESC)
		assert(input == [6, 5, 4, 3, 2, 1]),
	
	"test str asc" = func () -> void:
		var input := ["Beate", "Arnold", "Vincent", "Gregory", "Mike"]
		Arrays.sort(input,Comparators.which(Comparators.STR_NO_CASE))
		assert(input == ["Arnold", "Beate", "Gregory", "Mike", "Vincent"]),
	
	"test str desc" = func () -> void:
		var input := ["Beate", "Arnold", "Vincent", "Gregory", "Mike"]
		Arrays.sort(input,Comparators.which(Comparators.STR_NO_CASE), Arrays.DESC)
		assert(input == ["Vincent", "Mike", "Gregory", "Beate", "Arnold"]),
	
	"test stable asc" = func () -> void:
		var input := _dict_array_input()
		var comparator := _dict_array_comparator()
		Arrays.sort(input, comparator)
		var names = input.map(func (val): return val["name"])
		assert(names == ["First", "Second", "Third", "Fourth", "Fifth"]),
	
	"test stable desc" = func () -> void:
		var input = _dict_array_input()
		var comparator := _dict_array_comparator()
		Arrays.sort(input, comparator, Arrays.DESC)
		var names = input.map(func (val): return val["name"])
		assert(names == ["Fifth", "Second", "Third", "Fourth", "First"])
}


func _dict_array_input() -> Array[Dictionary]:
	return [
		{ "name" = "Fifth", "number" = 5 },
		{ "name" = "First", "number" = 1 },
		{ "name" = "Second", "number" = 3 },
		{ "name" = "Third", "number" = 3 },
		{ "name" = "Fourth", "number" = 3 },
	]

func _dict_array_comparator() -> Callable:
	var num_comparator = Comparators.which(Comparators.NUMBER)
	return func (left, right) -> int:
		return num_comparator.call(left["number"], right["number"])
