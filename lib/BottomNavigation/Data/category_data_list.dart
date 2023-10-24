List<String> getSubcategories(int category) {
  if (category == 0) {
    return ['First Aid', 'Health Care', 'Mens Care', 'Womens Care'];
  } else if (category == 1) {
    return ['100 mg', '200 mg', '500 mg', '1000 mg'];
  } else {
    return ['Sexual Wellness', 'Others'];
  }
}
