/**
 * Represents a button widget in the application interface, derived from the Widget class.
 * Inherits properties and methods from the Widget class and adds button-specific functionality.
 */
class WidgetButton extends Widget {

  /**
   * Constructs a new WidgetButton object with specified position, size, and roundness.
   *
   * @param xpos The x-coordinate of the button.
   * @param ypos The y-coordinate of the button.
   * @param W The width of the button.
   * @param H The height of the button.
   * @param R The roundness of the button.
   */
  WidgetButton(int xpos, int ypos, int W, int H, int R) {
    super(xpos, ypos, W, H, R); // Calls the constructor of the superclass (Widget) to initialize properties
  }

  /**
   * Checks if the button is clicked by determining if the mouse cursor is over it.
   *
   * @return true if the button is clicked, otherwise false.
   */
  boolean isClicked() {
    return (isMouseover());
  }

  /**
   * Renders the button on the screen.
   * The button's appearance depends on its active state.
   */
  void render() {
    if (active) {
      fill(screen.BUTTON_ON); // Sets the fill color to BUTTON_ON if the button is active
    } else {
      fill(screen.BUTTON_OFF); // Sets the fill color to BUTTON_OFF if the button is inactive
    }
    rect(xpos, ypos, wide, high, roundness); // Draws the button rectangle
  }

  /**
   * Checks a group of buttons to ensure only the clicked button is active.
   *
   * @param buttonGroup An ArrayList containing all buttons in the group.
   *                    After a button is clicked, it ensures only the clicked button remains active.
   */
  void linkedListCheck(ArrayList<WidgetButton> buttonGroup) {
    for (int i = 0; i < buttonGroup.size(); i++) {
      if (buttonGroup.get(i) != this) {
        buttonGroup.get(i).active = false; // Sets the active state of other buttons to false
      }
    }
  }
}
