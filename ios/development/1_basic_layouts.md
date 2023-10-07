# Basic Layouts

Like many UI toolkits/frameworks, iOS seems to also be heavily based on a MVC-like pattern.
The goal here is the keep things modular and abstracted from other parts, therefore
models, views, and controllers have a separation of concerns.

- Model: The class that encapsulates data (e.g "UserModel", "MessageModel")
- View: The UI of the applications, mostly representing the "Model" data
- Controller: The logic/in-between that communicates events from the Model to the View and vice versa.

It should be noted that all of these things are objects, hence communication is done through methods.
Now this definitely conflicts with modern-day UI frameworks, such as React, Svelte, Flutter, etc..
Any framework that supports this "declarative UI" as opposed to the "imperative" call-a-method-and-update
style. I believe Swift UI is the respective framework for this.

Most of my UI work is done in the `Interface Builder`, where you create views.
`Action`s are the methods you define within your `view controller` that act as triggers/callbacks
when an event occurs on the corresponding view within the UI, therefore the view object really
calls the action that is defined within the view controller.
 	View --> Event --> ViewController --> Action()

The opposite is the `Outlet`, which allows the view controller to access a view (instance).
Technically put, the outlet is an instance variable referencing the view, held within the view controller.
This would allow you to update, say, the view's properties, such as the ImageView's image or the UILabel's
actual label text, background color, etc..

```swift
class ViewController: UIViewController {

	// Outlet - reference to the view instance 
	@IBOutlet weak var counter: UILabel!
	...

	// Action - function/callback in response to an event
	@IBAction func updateCount(_ sender: Any) {
		// update `counter` 
		counter.text = "blah"
	}
}