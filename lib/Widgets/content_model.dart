class unboardingContent {
  late String image;
  late String title;
  late String description;

  unboardingContent(
      {required this.image, required this.title, required this.description});
}

List<unboardingContent> contents = [
  unboardingContent(
      image: 'images/screen1.png',
      title: 'Select from Our \n       Best Menu',
      description: 'Pick your food from menu \n         More than 35 times'),
  unboardingContent(
      image: 'images/screen2.png',
      title: 'Easily and Online Payment ',
      description:
          'You  can pay cash on delivery and \n     Card payment is avilable'),
  unboardingContent(
      image: 'images/screen3.png',
      title: 'Quick Deliver at \n  your Doorstep',
      description: 'Deliver your food at  \n     your Doorstep')
];
