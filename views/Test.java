package newapp.views;

import java.util.HashMap;

import javax.swing.JPanel;
import javax.swing.JTextPane;

public class Test extends JPanel {
	private JTextPane mainText;

	/**
	 * Create the panel.
	 */
	public Test() {
		super();
		setLayout(null);
		
		mainText = new JTextPane();
		mainText.setEditable(false);
		mainText.setText("HELLO WORLD this is my app");
		mainText.setBounds(137, 108, 210, 48);
		add(mainText);

	}
	public JTextPane getTxtpnHelloWorld() {
		return mainText;
	}
}
