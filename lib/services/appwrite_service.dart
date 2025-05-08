import 'package:appwrite/appwrite.dart';

class AppwriteService {
  late final Client client;
  late final Account account;

  AppwriteService() {
    client = Client()
      ..setEndpoint('https://fra.cloud.appwrite.io/v1') // Senin endpoint
      ..setProject('681ce992002ed42aaf42') // Senin projectId
      ..setSelfSigned(status: true);

    account = Account(client);
  }

  Future<void> createUser({required String email, required String password}) async {
    await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
    );
  }
}
