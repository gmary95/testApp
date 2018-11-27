import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var actionCountTextField: UITextField!
    
    var actionCount: Int64 = 0
    var dormitoryArray: [Dormitory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionCountTextField.text = actionCount.description
    }

    @IBAction func startBuhich(_ sender: UIButton) {
        actionCount = Int64(actionCountTextField.text ?? "0")!
        print(actionCount)
        if actionCount > 0 {
          let studentArray = Array<Student>(repeating: Student(totalMoney: ModelSettings.initStudentCash, totalBear: ModelSettings.initStudentBeer, buhichedAmount: 0), count: ModelSettings.dormitoryStudentCapacity)
            dormitoryArray = Array<Dormitory>(repeating: Dormitory(studentArray: studentArray), count: ModelSettings.numberOfDormitory)
        }
    }
    
}

