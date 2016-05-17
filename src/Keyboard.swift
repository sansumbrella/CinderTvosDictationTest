
import UIKit
import Foundation

///
/// Simple keyboard view controller.
///
class KeyboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show keyboard when the "menu" button is pressed.
        let menuRecognizer = UITapGestureRecognizer(target: self, action: #selector(displayTextField))
        menuRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Menu.rawValue)]
        self.view.addGestureRecognizer(menuRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayTextField() {
        let textSearch = UITextField()
        textSearch.keyboardAppearance = UIKeyboardAppearance.Dark
        textSearch.keyboardType = UIKeyboardType.WebSearch
        
        self.view.addSubview(textSearch)
        textSearch.becomeFirstResponder()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(handleTextFieldResponse(_:)), name: UITextFieldTextDidEndEditingNotification, object: textSearch)
        
    }
    
    func handleTextFieldResponse(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().removeObserver(self)

        let textField = notification.object as! UITextField
        textField.removeFromSuperview()

        if let text = textField.text {
            print("Text entered into keyboard: ", text);
            if let vc = presentingViewController as? RootViewController {
                vc.setText(text)
            }
        }
    }
    
    
}