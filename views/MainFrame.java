package newapp.views;

import java.awt.GridLayout;

import javax.swing.*;

public class MainFrame {
	public JFrame myFrame;
	private String appName = "Name of App";
	
	public MainFrame() {
		myFrame = new JFrame(appName); // FIXME put in configuration file
		myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		myFrame.setSize(600, 600);
		myFrame.setLayout(new GridLayout(1, 1));
	}
	
	public void show() {
		myFrame.setVisible(true);
	}
	
	public void hide() {
		myFrame.setVisible(false);
	}
}
