package newapp.models;
import java.io.*;
import java.lang.*;
import java.util.*;

import com.cedarsoftware.util.io.*;

public class Database {
	public static HashMap<String, ArrayList<Model>> data = new HashMap<String, ArrayList<Model>>();

	public static int save(String myClass, Model model) {
		if(!data.containsKey(myClass)) {
			data.put(myClass, new ArrayList<Model>());
		}
		ArrayList<Model> items = data.get(myClass);
		if(model.id < 0) {
			int indexOfNewItem = items.size() - 1;
			items.add(model);
			data.put(myClass, items);
			writeToFile();
			return indexOfNewItem;
		} else {
			items.set(model.id, model);
			data.put(myClass, items);
			writeToFile();
			return model.id;
		}
	}
	
	public static void writeToFile() {
		String json = "";
		try {
			json = JsonWriter.objectToJson(data);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			PrintWriter out = new PrintWriter(new FileWriter("database.txt"));
			out.print(json);
			out.close();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void retrieveStoredData() {
		Scanner scanner;
		String rawData = "";
		try {
			scanner = new Scanner(new File("database.txt"));
			while(scanner.hasNextLine()) {
				rawData += scanner.nextLine();
			}
			HashMap<String, ArrayList<Model>> retrievedData = (HashMap<String, ArrayList<Model>>) JsonReader.jsonToJava(rawData);
			data = retrievedData;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
