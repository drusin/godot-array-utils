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
		ArrayUtils.sort(input, Comparators.NUMBER)
		assert(input == [1, 2, 3, 4, 5, 6]),
	
	"test int desc" = func () -> void:
		var input := [4, 2, 6, 1, 3, 5]
		ArrayUtils.sort(input, Comparators.NUMBER, ArrayUtils.DESC)
		assert(input == [6, 5, 4, 3, 2, 1]),
	
	"test str asc" = func () -> void:
		var input := ["Beate", "Arnold", "Vincent", "Gregory", "Mike"]
		ArrayUtils.sort(input, Comparators.STR_NO_CASE)
		assert(input == ["Arnold", "Beate", "Gregory", "Mike", "Vincent"]),
	
	"test str desc" = func () -> void:
		var input := ["Beate", "Arnold", "Vincent", "Gregory", "Mike"]
		ArrayUtils.sort(input, Comparators.STR_NO_CASE, ArrayUtils.DESC)
		assert(input == ["Vincent", "Mike", "Gregory", "Beate", "Arnold"]),
	
	"test stable asc" = func () -> void:
		var input := _dict_array_input()
		var comparator := _dict_array_comparator()
		ArrayUtils.sort(input, comparator)
		var names = input.map(func (val): return val["name"])
		assert(names == ["One", "Three1", "Three2", "Three3", "Five"]),
	
	"test stable desc" = func () -> void:
		var input = _dict_array_input()
		var comparator := _dict_array_comparator()
		ArrayUtils.sort(input, comparator, ArrayUtils.DESC)
		var names = input.map(func (val): return val["name"])
		assert(names == ["Five", "Three1", "Three2", "Three3", "One"]),
	
	"test for_field" = func () -> void:
		var input := _dict_array_input()
		var comparator = Comparators.for_field("number", Comparators.NUMBER)
		ArrayUtils.sort(input, comparator)
		var names = input.map(func (val): return val["name"])
		assert(names == ["One", "Three1", "Three2", "Three3", "Five"]),
	
}


func _dict_array_input() -> Array[Dictionary]:
	return [
		{ "name" = "Five", "number" = 5 },
		{ "name" = "One", "number" = 1 },
		{ "name" = "Three1", "number" = 3 },
		{ "name" = "Three2", "number" = 3 },
		{ "name" = "Three3", "number" = 3 },
	]

func _dict_array_comparator() -> Callable:
	var num_comparator := Comparators.NUMBER
	return func (left, right) -> int:
		return num_comparator.call(left["number"], right["number"])
