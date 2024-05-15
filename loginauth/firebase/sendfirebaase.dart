import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendFirebase {
  const SendFirebase({
    required this.Categories,
    required this.Name,
    required this.Age,
    required this.Birth,
    required this.Height,
    required this.Email,
    required this.Phone,
    required this.Address,
    required this.ExperienceAsk,
    required this.Experience,
    required this.YearExperience,
    required this.Intrested,
    required this.Gender,
    required this.Job,
    required this.State,
    required this.Country,
  });
  final Name;
  final Age;
  final Birth;
  final Height;
  final Email;
  final Phone;
  final Address;
  final Categories;
  final ExperienceAsk;
  final Experience;
  final YearExperience;
  final Intrested;
  final Gender;
  final Job;
  final State;
  final Country;

  void goingToRTDB() {
    final _formKey = GlobalKey<FormState>();
    final url = Uri.https('ifilm-auth-default-rtdb.firebaseio.com',
        'auditionsubmittedform.json'); //url of myhe weside// that link , directory.json

    http.post(
      url,
      headers: {'Content-Type': ' application/json'},
      body: json.encode(
        {
          "Name": Name,
          "Age": Age,
          "Birth": Birth,
          "Height": Height,
          "Gender": Gender,
          "State": State,
          "Country": Country,
          "Email": Email,
          "Phone": Phone,
          "Address": Address,
          "Category": Categories,
          "ExperienceAsked": ExperienceAsk,
          "Experience": Experience,
          "YearOfExperience": YearExperience,
          "IntrestedRole": Intrested,
          "Job": Job,
        },
      ),
    );
  }

  void goingToFirestone() {
    final _formKey = GlobalKey<FormState>();
    final url = Uri.https('ifilm-auth-default-rtdb.firebaseio.com',
        'auditionsubmittedform.json'); //url of myhe weside// that link , directory.json

    http.post(
      url,
      headers: {'Content-Type': ' application/json'},
      body: json.encode(
        {
          'Name': Name,
          "Age": Age,
          "Birth": Birth,
          "Height": Height,
          "Gender": Gender,
          "State": State,
          "Country": Country,
          "Email": Email,
          "Phone": Phone,
          "Address": Address,
          "Category": Categories,
          "ExperienceAsked": ExperienceAsk,
          "Experience": Experience,
          "YearOfExperience": YearExperience,
          "IntrestedRole": Intrested,
          "Job": Job,
        },
      ),
    );
  }
}
