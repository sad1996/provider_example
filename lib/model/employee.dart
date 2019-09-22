class Employee {
  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String the6;
  String the7;
  String the8;
  String the9;
  String the10;
  String the11;
  String the12;
  String customerId;
  String firstName;
  String lastName;
  String company;
  String address;
  String city;
  String state;
  String country;
  String postalCode;
  String phone;
  String fax;
  String email;
  String supportRepId;

  Employee({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.the10,
    this.the11,
    this.the12,
    this.customerId,
    this.firstName,
    this.lastName,
    this.company,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.phone,
    this.fax,
    this.email,
    this.supportRepId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"],
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    the11: json["11"],
    the12: json["12"],
    customerId: json["CustomerId"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    company: json["Company"],
    address: json["Address"],
    city: json["City"],
    state: json["State"],
    country: json["Country"],
    postalCode: json["PostalCode"],
    phone: json["Phone"],
    fax: json["Fax"],
    email: json["Email"],
    supportRepId: json["SupportRepId"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9,
    "10": the10,
    "11": the11,
    "12": the12,
    "CustomerId": customerId,
    "FirstName": firstName,
    "LastName": lastName,
    "Company": company,
    "Address": address,
    "City": city,
    "State": state,
    "Country": country,
    "PostalCode": postalCode,
    "Phone": phone,
    "Fax": fax,
    "Email": email,
    "SupportRepId": supportRepId,
  };
}
