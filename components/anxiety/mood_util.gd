extends Node

const NORMAL_COLOR = Color("fcff00")
const FAST_COLOR = Color("f92900")
const SLOW_COLOR = Color("246ded")
const INCREASE_COLOR = Color("06ad00")

func mood_color(mood: float) -> Color:
	if mood < 0:
		return INCREASE_COLOR
	elif mood < .9 :
		return SLOW_COLOR
	elif mood > 1.1:
		return FAST_COLOR
	return NORMAL_COLOR
