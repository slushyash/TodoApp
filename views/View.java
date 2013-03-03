package newapp.views;

import newapp.*;
import javax.swing.*;

import newapp.Demo;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;

abstract class View extends JPanel {
	// have some buttons here and textlabels and other UI elements
	
	//abstract void generateLayout();
	public View(LayoutManager layout) {
		super(layout, true);
	}
	public View() {
		super(true);
	}
	abstract void fillVariables(HashMap<String, String> parameters);
	public void show() {
		Demo.myMainFrame.myFrame.add(this);
		Demo.myMainFrame.myFrame.validate();
	}
	public void hide() {
		Demo.myMainFrame.myFrame.remove(this);
		Demo.myMainFrame.myFrame.validate();
	}
	
	abstract void handleEvents();
}