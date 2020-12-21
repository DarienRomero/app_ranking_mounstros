part of 'helpers.dart';

mostrarLoading( BuildContext context ) {

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: ( _ ) => AlertDialog(
      title: Text('Espere...'),
      content: LinearProgressIndicator(),
    )
  );

}
mostrarAlert( BuildContext context, String titulo, String mensaje, VoidCallback callback ) {

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: ( _ ) => AlertDialog(
      title: Text( titulo ),
      content: Text( mensaje ),
      actions: [
        MaterialButton(
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop()
        ),
      ],
    )
  );

}