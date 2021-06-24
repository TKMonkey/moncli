import 'package:moncli/src/models/templates/asset/asset_file.dart';
import 'package:test/test.dart';

void main() {
  group("AssetFile", () {
    group("assetsFolder ending with /", () {
      test("with custom prefix, without postfix", () {
        // Act
        final assetsFile = AssetsFile.init("assets/",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png", "prefix", "");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "prefix_Screen Shot 2021-05-10 at 9.13.39 PM");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });

      test("with custom prefix, with custom postfix", () {
        final assetsFile = AssetsFile.init(
            "assets/",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png",
            "prefix",
            "postfix");

        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "prefix_Screen Shot 2021-05-10 at 9.13.39 PM_postfix");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });

      test("without prefix, with custom postfix", () {
        // Act
        final assetsFile = AssetsFile.init("assets/",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png", "", "postfix");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "Screen Shot 2021-05-10 at 9.13.39 PM_postfix");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });
    });

    group("assetsFolder ending without /", () {
      test("with custom prefix, without postfix", () {
        // Act
        final assetsFile = AssetsFile.init("assets",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png", "prefix", "");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "prefix_Screen Shot 2021-05-10 at 9.13.39 PM");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });

      test("with custom prefix, with custom postfix", () {
        final assetsFile = AssetsFile.init(
            "assets",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png",
            "prefix",
            "postfix");

        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "prefix_Screen Shot 2021-05-10 at 9.13.39 PM_postfix");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });

      test("without prefix, with custom postfix", () {
        // Act
        final assetsFile = AssetsFile.init("assets",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png", "", "postfix");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "Screen Shot 2021-05-10 at 9.13.39 PM_postfix");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });
    });

    group("predefined prefix", () {
      test("folder_name prefix", () {
        // Act
        final assetsFile = AssetsFile.init(
            "assets/",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png",
            "folder_name",
            "postfix");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "assets_Screen Shot 2021-05-10 at 9.13.39 PM_postfix");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });

      test("type_file prefix", () {
        // Act
        final assetsFile = AssetsFile.init(
            "assets/",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png",
            "type_file",
            "postfix");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "png_Screen Shot 2021-05-10 at 9.13.39 PM_postfix");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });
    });

    group("predefined postfix", () {
      test("folder_name postfix", () {
        // Act
        final assetsFile = AssetsFile.init(
            "assets/",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png",
            "prefix",
            "folder_name");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "prefix_Screen Shot 2021-05-10 at 9.13.39 PM_assets");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });

      test("type_file postfix", () {
        // Act
        final assetsFile = AssetsFile.init(
            "assets/",
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png",
            "prefix",
            "type_file");

        // Assert
        expect(assetsFile.path, "assets/");
        expect(assetsFile.outputVar,
            "prefix_Screen Shot 2021-05-10 at 9.13.39 PM_png");
        expect(assetsFile.outputPath,
            "assets/Screen Shot 2021-05-10 at 9.13.39 PM.png");
      });
    });
  });
}
