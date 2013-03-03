package newapp.models;

import java.util.*;
import java.util.Map.Entry;

abstract class Model {
	public Integer id;
	//public static String myClassName;
	
	public Model(int id) {
		this.id = id;
	}
	
	public Model() {
		this.id = -1;
	}
	
	// TODO this is gross; rewrite to use java exceptions
	public String save() {
		String isValidatedOrMessage = this.validate();
		if(isValidatedOrMessage == "valid") {
			int id = Database.save(this.getClass().getSimpleName(), this);
			this.id = id;
			return "saved";
		} else {
			return isValidatedOrMessage;
		}		
	}
	
	// this should be overriden in your model
	public String validate() {
		return "valid";
	}
	
	public static ArrayList<Model> getAll(Class theClass) {
		return Database.data.get(theClass.getSimpleName());
	}
	
	public static <T extends Model> T delete(int id, Class<T> theClass) {
		return theClass.cast(getAll(theClass).set(id, null));
	}
	
	public static ArrayList<Model> find(Class theClass, HashMap<String, Comparable<Object>> parameters) {
		// TODO hasone, hasmany, etc
		// TODO optimize for ID
		ArrayList<Model> matches = new ArrayList<Model>();
		ArrayList<Model> allItems = getAll(theClass);
		Set<Entry<String, Comparable<Object>>> entries = parameters.entrySet();
		Iterator<Entry<String, Comparable<Object>>> iterator = entries.iterator();
		
		for(int i = 0; i < allItems.size(); i++) {
			Model potentialMatch = allItems.get(i);
			Class classOfPotentialMatch = potentialMatch.getClass();
			boolean stillAPotentialMatch = true;
			while(stillAPotentialMatch && iterator.hasNext()) {
				Entry<String, Comparable<Object>> entry = iterator.next();
				Comparable<Object> value = entry.getValue();
				String[] fieldNameAndComparator = entry.getKey().split(".");
				System.out.println(fieldNameAndComparator.length); //DEBUG
				System.out.println(entry.getKey()); //DEBUG
				String fieldName;
				String comparator;
				Object valueOfActualField;
				int comparison;
				
				if(fieldNameAndComparator.length == 0) {
					comparator = "eql";
					fieldName = entry.getKey();
				} else {
					fieldName = fieldNameAndComparator[0];
					comparator = fieldNameAndComparator[1];
				}
				
				try {
					valueOfActualField = classOfPotentialMatch.getField(fieldName).get(potentialMatch);
					comparison = value.compareTo(valueOfActualField);
				} catch (Exception e) { // pokemon exception handling fixme maybe
					e.printStackTrace();
					stillAPotentialMatch = false;
					continue;
				}
				
				if(comparator.equals("eql")) {
					stillAPotentialMatch = comparison == 0;
				} else if(comparator.equals("lt")) {
					stillAPotentialMatch = comparison < 0;
				} else if(comparator.equals("lte")) {
					stillAPotentialMatch = comparison <= 0;
				} else if(comparator.equals("gt")) {
					stillAPotentialMatch = comparison > 0;
				} else if(comparator.equals("gte")) {
					stillAPotentialMatch = comparison >= 0;
				} else {
					stillAPotentialMatch = false;
					System.out.println("not a supported comparator string \"" + comparator + "\"");
				}	
			}
			if(stillAPotentialMatch) matches.add(potentialMatch);
		}
		return matches;
	}
}