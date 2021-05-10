/**
 * A pointy stick.
 */
public class PrimitiveFork extends Fork {
	public PrimitiveFork() {
		super(1, 25);
	}

	public void stickFood(String food) {
		System.out.println(
			"You force the stick into the "
			+ food
			+ ", mildly squishing the "
			+ food
			+ " in the process."
		);
	}
}
