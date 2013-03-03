package newapp.controllers;

import java.awt.event.ActionEvent;
import java.util.HashMap;

import newapp.models.User;
import newapp.views.*;
import newapp.*;

public class LoginController {
	public static LoginView loginPage = new LoginView();
	
	public static void index() {
		//loginPage.generateLayout();
		loginPage.show();
	}

	public static void submit(String username, String password, ActionEvent e) {
		User user = User.login(username, password);
		if(user != null) {
			System.out.println("implement login");
		} else {
			HashMap<String, String> data = new HashMap<String, String>();
			data.put("login", "invalid login");
			loginPage.fillVariables(data);
		}
		
	}
}
