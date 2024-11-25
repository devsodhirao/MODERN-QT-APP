//.pragma library

function getMapImage() {
      if (selectedMapImage !== "") {
          return imagePath + selectedMapImage;
      }
      return "";
  }

  function getScale(width, height) {
      var scale = Math.min(
        width / rootId.appWidth,
        height / rootId.appHeight
      );
      rootId.scale = scale;
  }

  function dp(pixelSize) {
      return pixelSize * rootId.scale;
  }
