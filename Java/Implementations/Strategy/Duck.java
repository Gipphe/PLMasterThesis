public class Duck {
	private String name;
	private Movement movement;
	private Position position;

	public Duck(String name, Movement movement) {
		this.name = name;
		this.movement = movement;
		this.position = new Position(0, 0);
	}

	public void moveTo(Position dest) {
		System.out.println(this.name +  " " + this.movement.moveTo(this.position, dest) + ".");
		this.position = dest;
	}
}
