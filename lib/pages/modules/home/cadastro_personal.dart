import 'package:fit_finder/core/controllers/personal_controller.dart';
import 'package:fit_finder/models/personal_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Certifique-se de que Cardt esteja importado ou definido no mesmo arquivo
import 'home_screen.dart';

class CadastroPersonal extends StatefulWidget {
  const CadastroPersonal({super.key});

  @override
  State<CadastroPersonal> createState() => _CadastroPersonalState();
}

class _CadastroPersonalState extends State<CadastroPersonal> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'bio': TextEditingController(),
    'photoUrl': TextEditingController(),
    'whatsapp': TextEditingController(),
    'price': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    // Atualiza o Card preview em tempo real
    for (var controller in _controllers.values) {
      controller.addListener(() {
        setState(() {}); // atualiza preview
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _savePersonal() {
    if (_formKey.currentState!.validate()) {
      final newPersonal = PersonalModel(
        id: 0,
        name: _controllers['name']!.text,
        bio: _controllers['bio']!.text,
        photoUrl: _controllers['photoUrl']?.text ?? '',
        whatsapp: _controllers['whatsapp']!.text,
        price: double.tryParse(_controllers['price']!.text) ?? 0,
        rating: 0,
        specialties: [],
      );

      Provider.of<PersonalController>(
        context,
        listen: false,
      ).addPersonal(newPersonal);

      Navigator.pop(context); // volta para a HomeScreen
    }
  }

  Widget _textField({
    required String keyName,
    required String label,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    double spacing = 10,
    bool isMultiline = false, // novo parâmetro
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _controllers[keyName],
          decoration: InputDecoration(labelText: label),
          keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
          minLines: isMultiline ? 3 : 1,
          maxLines: isMultiline ? null : 1,
          validator: (value) => isRequired && (value == null || value.isEmpty)
              ? 'Campo obrigatório'
              : null,
        ),
        SizedBox(height: spacing),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Personal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _textField(keyName: 'name', label: 'Nome', isRequired: true),

              _textField(keyName: 'bio', label: 'Bio'),
              _textField(keyName: 'photoUrl', label: 'URL da Foto (opcional)'),
              _textField(keyName: 'whatsapp', label: 'WhatsApp'),
              _textField(
                keyName: 'price',
                label: 'Preço por hora',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              const Text(
                'Preview do Card',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Cardt preview
              Cardt(
                nome: _controllers['name']!.text,
                telefone: _controllers['whatsapp']!.text,
                imagem: _controllers['photoUrl']?.text ?? '',
                bio: _controllers['bio']!.text,
                rating: 0,
                price:
                    double.tryParse(_controllers['price']!.text)?.toInt() ?? 0,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePersonal,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
