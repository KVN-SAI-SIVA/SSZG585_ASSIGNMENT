# Quick Start Guide - Task Admin App

## ⚡ Fast Setup (5 Minutes)

### Step 1: Get Back4App Credentials (2 minutes)
1. Visit [back4app.com](https://www.back4app.com/)
2. Sign up (or login)
3. Create new app: "Task Admin"
4. Go to: App Settings → Security & Keys
5. Copy: Application ID, Client Key

### Step 2: Configure App (1 minute)
1. Open: `lib/services/back4app_config.dart`
2. Replace:
   ```dart
   static const String appId = 'YOUR_APP_ID_HERE';
   static const String clientKey = 'YOUR_CLIENT_KEY_HERE';
   ```
3. Save file

### Step 3: Install Dependencies (1 minute)
```bash
flutter pub get
```

### Step 4: Run App (1 minute)
```bash
flutter run
```

That's it! 🎉

---

## 📱 First Time Usage

### Register
1. Click "Register" on login screen
2. Enter:
   - Username (min 3 chars)
   - Email (student email)
   - Password (min 6 chars)
3. Tap "Register"

### Create Your First Task
1. Tap "+ Add Task" button
2. Enter title and description
3. Tap "Create Task"

### Manage Tasks
- ✅ **Mark Complete:** Tap checkbox
- ✏️ **Edit:** Tap task card
- 🗑️ **Delete:** Tap delete icon
- 🔍 **Search:** Use search bar

---

## 🐛 Troubleshooting

### Build Error?
```bash
flutter clean
flutter pub get
flutter run
```

### Connection Failed?
- Check Back4App credentials
- Verify internet connection
- Check `back4app_config.dart`

### Login Failed?
- Verify email format
- Password must be 6+ characters
- Check if user already exists

---

## 📚 Need More Help?

- **Full Setup:** See [BACK4APP_SETUP.md](BACK4APP_SETUP.md)
- **Project Guide:** See [PROJECT_GUIDE.md](PROJECT_GUIDE.md)
- **Main README:** See [README.md](README.md)

---

## 🎯 Assignment Checklist

Before submission:

- [ ] App runs without errors
- [ ] Can register new user
- [ ] Can login
- [ ] Can create tasks
- [ ] Can edit tasks
- [ ] Can delete tasks
- [ ] Can toggle completion
- [ ] Can logout
- [ ] Data persists in Back4App
- [ ] Video recorded (2 min)
- [ ] GitHub repo created
- [ ] PPT prepared
- [ ] Screenshots added
- [ ] Submitted on Taxila

---

**Total Setup Time:** ~5 minutes  
**Ready to code:** ✅  
**Happy Task Managing!** 🚀
