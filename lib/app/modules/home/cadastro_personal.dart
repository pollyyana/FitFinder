import 'package:fit_finder/app/models/personal_model.dart';
import 'package:fit_finder/app/modules/home/widgets/card_widget.dart';
import 'package:fit_finder/app/pages/controllers/personal_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroPersonal extends StatefulWidget {
  final PersonalModel? personal;
  const CadastroPersonal({super.key, this.personal});

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

    // Preenche os campos se estiver editando
    if (widget.personal != null) {
      _controllers['name']!.text = widget.personal!.name;
      _controllers['bio']!.text = widget.personal!.bio;
      _controllers['photoUrl']!.text = widget.personal!.photoUrl ?? '';
      _controllers['whatsapp']!.text = widget.personal!.whatsapp;
      _controllers['price']!.text = widget.personal!.price.toString();
    }

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
      final personal = PersonalModel(
        id: widget.personal?.id ?? 0,
        name: _controllers['name']!.text,
        bio: _controllers['bio']!.text,
        photoUrl: _controllers['photoUrl']?.text ?? '',
        whatsapp: _controllers['whatsapp']!.text,
        price: double.tryParse(_controllers['price']!.text) ?? 0,
        rating: widget.personal?.rating ?? 0,
        specialties: widget.personal?.specialties ?? [],
      );

      final controller = Provider.of<PersonalController>(
        context,
        listen: false,
      );

      if (widget.personal != null) {
        // Editando
        controller.updatePersonal(personal);
      } else {
        // Criando novo
        controller.addPersonal(personal);
      }

      Navigator.pop(context);
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
      appBar: AppBar(
        title: Text(
          widget.personal != null ? 'Editar Personal' : 'Novo Personal',
        ),
      ),
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

              Cardt(
                personal: PersonalModel(
                  id: 0,
                  name: _controllers['name']!.text,
                  bio: _controllers['bio']!.text,
                  photoUrl: _controllers['photoUrl']?.text ?? '',
                  whatsapp: _controllers['whatsapp']!.text,
                  price: double.tryParse(_controllers['price']!.text) ?? 0,
                  rating: 0,
                  specialties: [],
                ),
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
