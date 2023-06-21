import 'package:aleteo_arquetipo/modules/cat/ui/widgets/url_list_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets('Test UrlListWidget', (WidgetTester tester) async {
    await tester.pumpWidget(UrlListWidget());
    expect(find.text('https://www.example.com'), findsOneWidget);
  });

}