class AddressModel {
  String name;
  String contactNumber;
  String address;
  String city;
  String state;
  String postcode;

  AddressModel(
      {this.name,
        this.contactNumber,
        this.address,
        this.city,
        this.state,
        this.postcode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contactNumber = json['contactNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contactNumber'] = this.contactNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    return data;
  }
}
