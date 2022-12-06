# Movies CLicks

Movies Clicks is free android application for findig movies with details like rating and votecount with categories and movie production companies.

[![Portfolio](https://ankitgautam.vercel.app/asset/images/logo.ico)](https://ankitgautam.vercel.app/)

### Building

- Install dependencies `flutter pub get`
- GET TMDB api key and create .env file

- env file exmple
  TMDB_BASE_URL="https://api.themoviedb.org/3"
  TMDB_IMAGE_BASE_URL="https://image.tmdb.org/t/p/w500"
  TMDB_IMAGE_BASE_URL_DESKTOP="https://image.tmdb.org/t/p/original"
  TMDB_API_KEY=your api key

```sh
flutter run
```

Make sure you have all the tools required for building the skia libraries (XCode, Ninja, CMake, Android NDK / build tools).

If you have Android Studio installed, make sure `$ANDROID_NDK` is available.
`ANDROID_NDK=/Users/username/Library/Android/sdk/ndk/<version>` for instance.

If the NDK is not installed, you can install it via Android Studio by going to the menu _File > Project Structure_.

And then the _SDK Location_ section. It will show you the NDK path, or the option to Download it if you don't have it installed.
