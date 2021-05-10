public class Client {
	private Fork fork;
	private Knife knife;

	public Client(Fork fork, Knife knife) {
		this.fork = fork;
		this.knife = knife;
	}

	public String eat(String food) {
		return this.knife.cutFood(food)
			+ "\n"
			+ this.fork.stabFood(food)
			+ "\nNom";
	}
}
