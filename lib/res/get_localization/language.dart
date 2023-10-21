import 'package:get/get_navigation/get_navigation.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //Login Page
          'email_hint': 'Email',
          'passwords': 'Password',
          "forget_password": 'Forget Password?',
          "sign_on": 'Sign On',
          "save_user": 'Save UserName',
          "new_user": 'New User?',
          'enroll': "Enroll",
          //enroll
          //1
          "first_name": 'First Name',
          "middle_name": 'Middle Name (Optional)',
          "last_name": 'Last Name',
          "dob": 'Date Of Birth',

          //2

          "phone_number": 'Phone Number',
          "zip_code": 'Zip Code',
          "home_address": 'Home Address 1',
          "home_address_2": 'Home Address (Optional)',

          //3

          'ssn': "Social Security Number",
          'itin': "individual Tax indentification Number\n (ITIN)",

          //4
          'id_number': "ID Number",
          'expiration_date': "Expiration Date",
          'issued_date': "Issued Date",

          //all enroll Button
          'continue': "Continue",

          'internet_exceptions':
              "We are unable to show results\n Please check your data\n Conntection",
          'general_exceptions':
              "We are unable to process your request\n Please try again",
          'welcome_back': "Welcome to My App",
          "login": 'Login Page',
          "logout": 'Logout',
          "logout_message": 'Are you sure you want to logout?',
          "ok": "OK",
          "cancel": "Cancel",
          "register": 'Register Page',
          "reset_password": '<PASSWORD>',
          "home": 'Home Page',
          "profile": 'Profile Page',
        }
      };
}
