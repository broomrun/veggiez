class QuizQuestion {
  final String? image;
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    this.image,
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

final List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    image: 'assets/images/spinach.png',
    question: 'Which nutrient in spinach helps prevent anemia?',
    options: ['Iron', 'Vitamin A', 'Fiber', 'Zinc'],
    correctIndex: 0,
  ),
  QuizQuestion(
    image: 'assets/images/carrot2.png',
    question: 'Carrots are known for improving vision because they contain what compound?',
    options: ['Vitamin C', 'Beta-carotene', 'Folic acid', 'Omega-3'],
    correctIndex: 1,
  ),
  QuizQuestion(
    image: 'assets/images/brocolli.png',
    question: 'Broccoli is a good source of which vitamin that supports bone health?',
    options: ['Vitamin D', 'Vitamin K', 'Vitamin E', 'Vitamin B12'],
    correctIndex: 1,
  ),
  QuizQuestion(
    image: 'assets/images/tomato.png',
    question: 'The red pigment in tomatoes that acts as an antioxidant is called what?',
    options: ['Carotene', 'Chlorophyll', 'Lycopene', 'Anthocyanin'],
    correctIndex: 2,
  ),
  QuizQuestion(
    image: 'assets/images/garlic.png',
    question: 'Garlic contains a compound called allicin, which helps with what?',
    options: [
      'Lowering blood pressure',
      'Improving eyesight',
      'Strengthening bones',
      'Boosting calcium absorption',
    ],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Which vegetable has the highest water content?',
    options: ['Corn', 'Broccoli', 'Tomato', 'Cucumber'],
    correctIndex: 3,
  ),
  QuizQuestion(
    question: 'Which vegetable is rich in Vitamin C and helps boost immunity?',
    options: ['Bell pepper', 'Potato', 'Garlic', 'Cabbage'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Which mineral in vegetables helps maintain healthy blood pressure?',
    options: ['Magnesium', 'Sodium', 'Calcium', 'Potassium'],
    correctIndex: 3,
  ),
  QuizQuestion(
    question: 'Which vegetable contains folate, important for cell growth?',
    options: ['Spinach', 'Corn', 'Onion', 'Pumpkin'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Which compound in beetroot helps improve blood flow?',
    options: ['Protein', 'Iron', 'Nitrates', 'Chlorophyll'],
    correctIndex: 2,
  ),
];
