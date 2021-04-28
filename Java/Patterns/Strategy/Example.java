interface HashingStrategy {
	String hash(String in);
}

class SHA1Strategy implements HashingStrategy {
	public String hash(String in) {
		// ...
	}
}

class SHA256Strategy implements HashingStrategy {
	public String hash(String in) {
		// ...
	}
}

class MD5Strategy implements HashingStrategy {
	public String hash(String in) {
		// ...
	}
}

class Client {
	private HashingStrategy hasher;

	public Client(HashingStrategy hasher) {
		this.hasher = hasher;
	}

	public String hashWithStrategy(String text) {
		return this.hasher.hash(text);
	}
}
