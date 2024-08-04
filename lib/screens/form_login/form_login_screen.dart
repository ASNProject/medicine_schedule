import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_schedule/routers/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormLoginScreen extends StatelessWidget {
  const FormLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormLoginScreenContent();
  }
}

class FormLoginScreenContent extends StatefulWidget {
  const FormLoginScreenContent({super.key});

  @override
  State<FormLoginScreenContent> createState() => _FormLoginScreenContentState();
}

class _FormLoginScreenContentState extends State<FormLoginScreenContent> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String? getUsername;
  String? getPassword;
  String? _username;
  String? _password;

  String user = '';

  bool? _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _checkLogin(context);
  }

  void _fetchData() async {
    DatabaseEvent event = await _databaseReference.child('user').once();
    final data = event.snapshot.value as Map<dynamic, dynamic>;
    setState(() {
      getUsername = data['username'];
      getPassword = data['password'];
    });
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String userData = prefs.getString('user') ?? '';
    setState(() {
      user = userData;
    });
  }

  _savedLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', '1');
  }

  void _checkLogin(BuildContext context) async  {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user == '1') {
      if (context.mounted) {
        GoRouter.of(context)
            .pushReplacement(AppConstanst.dashboardScreen);
      }
    } else {
      _loadUser();
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/icons/logo.png'),
                const Text(
                  'Masukkan Nama Pengguna',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0)),
                  width: double.infinity,
                  height: 40,
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Nama Pengguna',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _username = value;
                        });
                      },
                    ),
                  ),
                ),
                const Gap(8.0),
                const Text(
                  'Masukkan Kata Sandi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0)),
                  width: double.infinity,
                  height: 40,
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Kata Sandi',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onChanged: (String? value) {
                        _password = value;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Ingat Saya',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Checkbox(
                      activeColor: Colors.lightBlue,
                      value: _rememberMe,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _rememberMe = newValue ?? false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () {
                      if (getUsername == _username &&
                          getPassword == _password) {
                        GoRouter.of(context)
                            .pushReplacement(AppConstanst.dashboardScreen);
                        if (_rememberMe == true) {
                          _savedLogin();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Gagal Login, silahkan periksa nama pengguna atau password!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
