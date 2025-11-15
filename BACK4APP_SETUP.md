# Task Admin App - Back4App Setup Guide

## Step-by-Step Back4App Configuration

### 1. Create Back4App Account

1. Go to [https://www.back4app.com/](https://www.back4app.com/)
2. Click "Sign Up" and create a free account
3. Verify your email address

### 2. Create New Application

1. After logging in, click "Build a new app"
2. Choose "Parse" as the backend type
3. Enter your app name: `Task Admin`
4. Select your preferred region (closest to your location)
5. Click "Create"

### 3. Get Application Credentials

1. In your app dashboard, click on "App Settings" (gear icon)
2. Navigate to "Security & Keys" section
3. You'll find three important values:
   - **Application ID** (e.g., `abc123def456...`)
   - **Client Key** (e.g., `xyz789uvw012...`)
   - **Server URL** (usually `https://parseapi.back4app.com`)

### 4. Configure Your Flutter App

1. Open the file: `lib/services/back4app_config.dart`
2. Replace the placeholder values with your credentials:

```dart
class Back4AppConfig {
  static const String appId = 'YOUR_APPLICATION_ID_HERE';
  static const String clientKey = 'YOUR_CLIENT_KEY_HERE';
  static const String serverUrl = 'https://parseapi.back4app.com';
  
  // ... rest of the code
}
```

### 5. Database Schema (Automatically Created)

When you run the app and create your first task, Back4App will automatically create the necessary database tables:

#### User Table (Built-in)
- Automatically created by Parse
- Fields: username, email, password (encrypted)

#### Task Table (Auto-created on first task)
The app will create this table with:
- `title` (String)
- `description` (String)
- `isCompleted` (Boolean)
- `createdBy` (Pointer to User)
- `createdAt` (DateTime) - auto
- `updatedAt` (DateTime) - auto

### 6. Set Up Security (Optional but Recommended)

1. In Back4App Dashboard, go to "App Settings" > "Security & Keys"
2. Enable "Require authentication for all requests"
3. Set up Class Level Permissions for the Task class:
   - Read: Authenticated users only
   - Write: Authenticated users only
   - Delete: Owner only

### 7. Testing Your Connection

1. Run your Flutter app: `flutter run`
2. Try to register a new user
3. If successful, you'll see the user in Back4App Dashboard under "Database" > "User" class

### 8. View Your Data in Back4App

1. Go to "Database" in the left sidebar
2. You'll see two classes:
   - **User**: All registered users
   - **Task**: All created tasks
3. You can view, edit, or delete records directly from here

### 9. Monitoring and Analytics

Back4App provides:
- **Analytics**: View app usage statistics
- **Logs**: Check API requests and errors
- **Push Notifications**: (Can be added later)
- **Cloud Code**: Run server-side functions (optional)

### 10. Troubleshooting

#### Common Issues:

**Issue 1: Connection Failed**
- Solution: Check if appId and clientKey are correct
- Verify internet connection
- Check if server URL is correct

**Issue 2: Authentication Error**
- Solution: Ensure email format is valid
- Password must be at least 6 characters
- Check if user already exists

**Issue 3: Task Not Saving**
- Solution: Make sure user is logged in
- Check Back4App logs for errors
- Verify class permissions

### 11. Free Tier Limits

Back4App Free Plan includes:
- ✅ 25,000 requests/month
- ✅ 1GB database storage
- ✅ Unlimited users
- ✅ Real-time queries
- ✅ Push notifications

This is more than enough for development and testing!

### 12. Additional Resources

- [Back4App Documentation](https://www.back4app.com/docs/)
- [Parse SDK Documentation](https://docs.parseplatform.org/)
- [Flutter Parse SDK](https://pub.dev/packages/parse_server_sdk_flutter)

### 13. Security Best Practices

⚠️ **Important Security Notes:**

1. **Never commit credentials to Git**
   - Add `back4app_config.dart` to `.gitignore` if sharing publicly
   - Use environment variables for production

2. **Use secure passwords**
   - Enforce strong password requirements
   - Consider adding password reset functionality

3. **Enable SSL**
   - Always use HTTPS (Back4App uses it by default)

4. **Set proper permissions**
   - Configure Class Level Permissions in Back4App
   - Implement Access Control Lists (ACLs)

---

## Quick Start Checklist

- [ ] Created Back4App account
- [ ] Created new Parse app
- [ ] Copied Application ID
- [ ] Copied Client Key
- [ ] Updated `back4app_config.dart` with credentials
- [ ] Ran `flutter pub get`
- [ ] Tested app by registering a user
- [ ] Verified user appears in Back4App database
- [ ] Created a test task
- [ ] Verified task appears in Back4App database

---

## Support

If you encounter any issues:
1. Check Back4App logs in the dashboard
2. Review Flutter console output
3. Verify all credentials are correct
4. Check Back4App community forum
5. Contact Back4App support (they're very responsive!)

**Happy Coding! 🚀**
