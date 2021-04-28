interface Strategy {
	U call(T arg);
}

class ConcreteStrategy1 implements Strategy {
	public U call(T arg) {}
}

class ConcreteStrategy2 implements Strategy {
	public U call(T arg) {}
}
