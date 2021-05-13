public class Encrypter {
	private Crypt crypt;

	public Encrypter(Crypt crypt) {
		this.crypt = crypt;
	}

	public void setCrypt(Crypt crypt) {
		this.crypt = crypt;
	}

	public void printEncrypted(String in) {
		System.out.println("Original: " + in + "\nEncrypted: " + this.crypt.encrypt(in));
	}
}
