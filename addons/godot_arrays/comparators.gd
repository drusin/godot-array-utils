class_name Comparators
extends RefCounted


static func NUMBER(left, right) -> int:
	return left - right


static func STR_CASE(left: String, right: String) -> int:
	return left.casecmp_to(right)


static func STR_NO_CASE(left: String, right: String) -> int:
	return left.nocasecmp_to(right)


static func STR_NATURAL_CASE(left: String, right: String) -> int:
	return left.naturalcasecmp_to(right)


static func STR_NATURAL_NO_CASE(left: String, right: String) -> int:
	return left.naturalnocasecmp_to(right)


static func for_field(field_name: String, comparator: Callable) -> Callable:
	return func (left, right):
		comparator.call(left[field_name], right[field_name])
