import 'package:flutter/material.dart';

String? _defaultFunction(String val) {
  return null;
}

class CustomAutoCompleteInputWidget extends StatefulWidget {
  const CustomAutoCompleteInputWidget(
      {required this.onEditingValueFunction,
      super.key,
      this.label = '',
      this.suggestList,
      this.initialData = '',
      this.placeholder = '',
      this.onEditingValidateFunction = _defaultFunction,
      this.icondata,
      this.textInputType = TextInputType.text});

  final List<String>? suggestList;
  final String initialData;
  final String placeholder, label;
  final void Function(String val) onEditingValueFunction;
  final String? Function(String val) onEditingValidateFunction;
  final IconData? icondata;
  final TextInputType textInputType;

  @override
  CustomAutoCompleteInputWidgetState createState() =>
      CustomAutoCompleteInputWidgetState();
}

class CustomAutoCompleteInputWidgetState
    extends State<CustomAutoCompleteInputWidget> {
  late TextEditingController _controller;
  String? _errorText;
  late String _selectedValue;
  bool _isStarted = false;
  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialData;
    _controller = TextEditingController(text: _selectedValue);
    _onValidate(_selectedValue);
  }

  void _onValidate(String val) {
    _errorText = widget.onEditingValidateFunction(val);
    if (_errorText == null) {
      widget.onEditingValueFunction(val);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return widget.suggestList!.where(
            (String word) => word
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()),
          );
        }
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Material(
          elevation: 4,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              final String option = options.elementAt(index);
              return ListTile(
                title: Text(option),
                onTap: () {
                  _selectedValue = option;
                  _controller.text = _selectedValue;
                  _onValidate(_selectedValue);
                  onSelected(option);
                  FocusScope.of(context).unfocus();
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: options.length,
          ),
        );
      },
      onSelected: (String selectedString) {
        _controller.text = selectedString;
        _onValidate(selectedString);
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        void Function() onEditingComplete,
      ) {
        if (_isStarted == false) {
          controller.text = _selectedValue;
          _isStarted = true;
        }
        return TextField(
          keyboardType: widget.textInputType,
          controller: controller,
          focusNode: focusNode,
          onChanged: _onValidate,
          decoration: InputDecoration(
            prefixIcon: widget.icondata != null ? Icon(widget.icondata) : null,
            label: widget.label.isNotEmpty ? Text(widget.label) : null,
            errorText: _errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange),
            ),
          ),
        );
      },
    );
  }
}
