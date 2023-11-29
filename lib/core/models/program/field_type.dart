enum FieldType {
  date,
  select,
  input,
  radio,
  phone,
  email,
  textArea,
  title,
  delimetr,
  number,
  unknown,
}

extension FieldTypeConverter on FieldType {
  static FieldType fromString(String str) {
    switch (str.toLowerCase()) {
      case 'date':
        return FieldType.date;
      case 'select':
        return FieldType.select;
      case 'input':
        return FieldType.input;
      case 'radio':
        return FieldType.radio;
      case 'phone':
        return FieldType.phone;
      case 'email':
        return FieldType.email;
      case 'textarea':
        return FieldType.textArea;
      case 'title':
        return FieldType.title;
      case 'delimetr':
        return FieldType.delimetr;
      case 'number':
        return FieldType.number;
      default:
        return FieldType.unknown;
    }
  }
}
