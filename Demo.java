package newapp;
import newapp.models.*;
import newapp.controllers.*;
import newapp.views.*;

public class Demo {

	public static MainFrame myMainFrame = new MainFrame();
	
	private Demo()	{
		myMainFrame.show();
		Database.retrieveStoredData();
		new User("sidd", "siddthekid").save();
		new User("yash", "yashieslushie").save();
		User.delete(0, User.class);
		System.out.println(User.getAll().get(1));
		DefaultController.index();
		//User.getCurrentModel();
	}
	
	public static void main(String[] args) {
		new Demo();
	}

}
