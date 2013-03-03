package newapp.models;

import java.util.ArrayList;
import java.util.HashMap;

public class User extends Model {
	public String name;
	public String password;
	public static String myClassName = "User";
	
	public User(String name, String password) {
		super();
		this.name = name;
		this.password = password;
	}
	
	public User(int id, String name, String password) {
		super(id);
		this.name = name;
		this.password = password;
	}
	
	public static User login(String name, String password) {
		HashMap<String, Comparable<Object>> parameters = new HashMap<String, Comparable<Object>>();
		parameters.put("name", (Comparable)name);
		parameters.put("password", (Comparable)password);
		ArrayList<Model> usersFound = User.find(User.class, parameters);
		if(usersFound.size() == 0) {
			return null;
		} else {
			return (User)usersFound.get(0);
		}
	}
	
	// REIMPLEMENT IN SUBCLASSES FROM STUFF IN MODEL
	public static ArrayList<Model> getAll() {
		return Model.getAll(User.class);
	}
	
	public User delete() {
		return (User)Model.delete(this.id, User.class);
	}
	
	public static ArrayList<Model> find(Class theClass, HashMap<String, Comparable<Object>> parameters) {
		return Model.find(User.class, parameters);
	}
}
