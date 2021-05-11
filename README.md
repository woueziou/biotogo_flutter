# ecom

Stripe : https://stripe.com/docs/payments/accept-a-payment
stripe with firebase : https://medium.com/@hamza39460/stripe-payments-in-flutter-cb2f9cb053d1
A new Flutter application.


# For project customization 

- [Project Docx](https://applipie.com/docs/)





# Ignore it

WCFM code replacement but not this
app name 
login screen apple package login .
setting screen rate app ids

Widget specialWCFMHeader() {
return Container(
  padding: EdgeInsets.all(10),
  color: themeTextColor.withAlpha(60),
  alignment: Alignment.centerLeft,
  height: 150.0,
  child: FadeAnimatedTextKit(
      onTap: () {
      },
      text: [
        "WooFlux !",
        "Weekly tag sales",
        "Dokan & WCFM"
      ],
      textStyle: TextStyle(
          color: themeBG,
          fontSize: 22.0,
          fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
      alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
);
}