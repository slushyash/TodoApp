package newapp.views;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;

import javax.swing.*;

import newapp.Demo;
import newapp.controllers.LoginController;

public class LoginView extends View {
	
	private JTextField login = new JTextField("username");
	private JPasswordField password = new JPasswordField("password");
	private JButton loginButton = new JButton("submit");
	
	public LoginView() {
		super(new FlowLayout());
		this.add(login);
		this.add(password);
		this.add(loginButton);
		this.handleEvents();
	}


	public void fillVariables(HashMap<String, String> parameters) {
		login.setText(parameters.get("login"));
	}
	
	public void handleEvents() {
		loginButton.addActionListener(new AbstractAction() {
			public void actionPerformed(ActionEvent e) {
				LoginController.submit(login.getText(), String.valueOf(password.getPassword()), e);
			}
		});
	}
}
