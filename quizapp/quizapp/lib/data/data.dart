import 'package:quizapp/model/model.dart';

class Data {
  static List<Category> categories = [
    Category(
      name: 'Eventos',
      image: 'assets/Flutter.png',
      quizSets: [
        QuizSet(
          name: 'Quiz Set 1',
          questions: [
            Question(
              'Alguns abafadores/fone de ouvidos são ótimos, mas outros dependendo das suas necessidades podem ser limitados \n no vídeo de dicas. Foi citado um modelo que atende muito bem a maioria das pessoas com TEA, qual foi:',
              [
                'SoundCore Q20, da Anker',
                'Hv-h2232d , da Havit',
                'KZ EDX Pro, da fone',
                'Tune 720BT, da JBL'
              ],
              0,
            ),
            Question(
              'Sobre esse abafador/fone de ouvido, ele tem uma função NC que significa:',
              [
                'Noise Cancellation, cancelamento de ruído.',
                'Noise Control, controle de barulho/redutor de ruído.',
                'Neutralization Control, controle de neutralização.',
                'Sound Compression, compressão de som.'
              ],
              1,
            ),
            Question(
              'Embora o abafador anterior seja ótimo por conta da sua função NC e seu conforto \n em viagens e no trabalho, pode acabar incomodando a pessoa com TEA devido:',
              [
                'Pressão excessiva nas orelhas.',
                'Interferência com outros dispositivos eletrônicos.',
                'Dificuldade em ouvir sons importantes, como alarmes.',
                'Chamar bastante atenção devido ao tamanho.'
              ],
              3,
            ),
            Question(
              'No vídeo, a pessoa com TEA fala que trabalha com Eventos como fotógrafa e que o \n abafador/fone tampão de ouvido IMEBOBO 2, comprado na Shopee, possui algumas vantagens:',
              [
                'O preço, o tamanho e também ele abafa muito bem o som, em momentos complicados como o das palmas.',
                'O design discreto que não chama atenção.',
                'A capacidade de amplificar sons baixos.',
                'A função de conexão Bluetooth para ouvir música.'
              ],
              0,
            ),
            Question(
              'Uma opção de abafador/fone mais barata é:',
              [
                'Protetor Auditivo 3M 1100, vendido em lojas de materiais de construção.',
                'Protetor Auricular de Silicone Mack’s - disponível em lojas de esportes.',
                'Nexcare, vendido na farmácia.',
                'Fortrek G Pro - vendido em lojas de eletrônicos.'
              ],
              2,
            ),
            Question(
              'Uma vantagem do Nexcare é:',
              [
                'Além do preço, tamanho e empresas que têm pessoas com TEA podem ter vários desses.',
                'É resistente à água, permitindo o uso durante o banho.',
                'Tem uma remoção suave e sem dor.',
                'Permite que a pele respire, evitando infecções por umidade.'
              ],
              0,
            ),
            Question(
              'Desvantagens do Nexcare é:',
              [
                'Pode causar irritação em peles sensíveis.',
                'É eficaz em ambientes extremamente barulhentos.',
                'É fácil de ajustar corretamente.',
                'Desconfortável, abafa pouco o ruído e só deve ser usado se não tiver outro melhor no momento em questão.'
              ],
              3,
            ),
          ],
        ),
        QuizSet(
          name: 'Quiz Set 2',
          questions: [
            // Adicione perguntas para o Quiz Set 2 de Eventos
          ],
        ),
        // Adicione mais quiz sets para a categoria Eventos
      ],
    ),
    Category(
      name: 'Social',
      image: 'assets/React Native.png',
      quizSets: [
        QuizSet(
          name: 'Quiz Set 1',
          questions: [
            // Adicione perguntas para o Quiz Set 1 de React Native
          ],
        ),
        QuizSet(
          name: 'Quiz Set 2',
          questions: [
            // Adicione perguntas para o Quiz Set 2 de React Native
          ],
        ),
        QuizSet(
          name: 'Quiz Set 3',
          questions: [
            // Adicione perguntas para o Quiz Set 3 de React Native
          ],
        ),
      ],
    ),
    Category(
      name: 'Trabalho',
      image: 'assets/Python.png',
      quizSets: [
        QuizSet(
          name: 'Quiz Set 1',
          questions: [
            // Adicione perguntas para o Quiz Set 1 de Python
          ],
        ),
        QuizSet(
          name: 'Quiz Set 2',
          questions: [
            // Adicione perguntas para o Quiz Set 2 de Python
          ],
        ),
        QuizSet(
          name: 'Quiz Set 3',
          questions: [
            // Adicione perguntas para o Quiz Set 3 de Python
          ],
        ),
      ],
    ),
    Category(
      name: 'Random',
      image: 'assets/C#.png',
      quizSets: [
        QuizSet(
          name: 'Quiz Set 1',
          questions: [
            // Adicione perguntas para o Quiz Set 1 de Random
          ],
        ),
        QuizSet(
          name: 'Quiz Set 2',
          questions: [
            // Adicione perguntas para o Quiz Set 2 de Random
          ],
        ),
        QuizSet(
          name: 'Quiz Set 3',
          questions: [
            // Adicione perguntas para o Quiz Set 3 de Random
          ],
        ),
      ],
    ),
    // Adicione mais categorias com quiz sets e perguntas
  ];
}
