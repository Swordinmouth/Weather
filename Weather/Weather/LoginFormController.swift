//
//  LoginFormController.swift
//  Weather
//
//  Created by Valery on 02.08.2021.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var loginInputTextField: UITextField!
    @IBOutlet weak var passwordInputTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //Присваеваем его к UIScrollView
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //Подписываемся на уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        //Второе - когда она пропадает
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHiden(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func checkLoginInfo() -> Bool {
        let login = loginInputTextField.text!
        let password = passwordInputTextField.text!

        if login == "admin" && password == "123456" {
            print("успешная авторизация")
            return true
        } else {
            print("неуспешная авторизация")
            return false
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            if checkLoginInfo() {
                return true
            } else {
                showLoginError()
                return false
            }
        }
        return true
    }

    private func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    //Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        //Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

        //Добавляем отступ внизу ранвый размеру клавиатуры
        self.scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    //Когда клавиатура исчезает
    @objc func keyboardWillBeHiden(notification: Notification) {
        //Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }

    //Исчезновение клавиатуры при клике по пустому месту на экране и метод, который будет вызываться при клике.
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}
