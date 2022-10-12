class FormValidation {
  static String? EmailVeledetion(val) {
    print(val);
    var validemailadat = val.contains('@');
    var isEmaildort = val.contains('.');
    if (validemailadat == true && isEmaildort == true) {
      var newvale = val.length;
      var lveleded = val[newvale - 1].contains(RegExp(r'[a-z]'));
      if (lveleded == true) {
        return null;
      } else {
        return 'Please enter a valid email';
      }
    } else {
      return 'Please enter a valid email';
    }
  }

  static String? validateMobile(value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    // else if (value.runtimeType != int)
    //   return "Please enter a valid number";
    else
      return null;
  }

  static String? validateZipCode(value) {
    print("========================");
    print(value.runtimeType);
    print("my intor not");
// Uk zip code are of 7 digit only
    if (value.length != 6)
      return 'Invalid PIN Code';
    // else if (value.length >= 8)
    //   return 'Invalid Post Code';
    else
      return null;
  }

  static String? checkEmptyValidator(String? value) {
    if (value!.isEmpty) return 'Please provide this value';
    return null;
  }

// Validation
  static String? passwordValidation(val) {
    print(val);
    if (val.isEmpty) {
      return "This field is required";
    } else if (val != val) {
      return "This field is required";
    } else {
      return null;
    }
  }
}
