class OnBoardingData {
  final String title;
  final String image;
  final String description;

  OnBoardingData({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<OnBoardingData> contents = [
  OnBoardingData(
    title: "Ignite Quick and Fiery Conversations",
    image: "images/image1.png",
    description: "Engage in fast-paced chats and exchange thoughts with like-minded individuals.",
  ),
  OnBoardingData(
    title: "Keep it Short and Snappy",
    image: "images/image2.png",
    description: "Embrace the challenge of concise communication with character-limited messages.",
  ),
  OnBoardingData(
    title: "Discover a World of Diverse Topics",
    image: "images/image3.png",
    description: "Explore a wide range of chat rooms covering various interests and current events.",
  ),
];