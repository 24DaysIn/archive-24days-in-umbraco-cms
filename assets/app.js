"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); Object.defineProperty(Constructor, "prototype", { writable: false }); return Constructor; }

(function () {
  // Global app object 
  var KEY_SHIFT, MAC_ANIM_CLASS, TwentyFourDaysController;
  window.app || (window.app = {});
  KEY_SHIFT = 16;
  MAC_ANIM_CLASS = "ooOOhh"; // Main controller for the page's functions

  TwentyFourDaysController = /*#__PURE__*/function () {
    function TwentyFourDaysController() {
      _classCallCheck(this, TwentyFourDaysController);

      this.setupKeyHandlers();
      this.fixPuzzleDarkMode();
    } // @signalDone()


    _createClass(TwentyFourDaysController, [{
      key: "setMacAnimation",
      value: function setMacAnimation() {
        var state = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : true;
        return document.documentElement.classList.toggle(MAC_ANIM_CLASS, state === true);
      }
    }, {
      key: "setupKeyHandlers",
      value: function setupKeyHandlers() {
        var _this = this;

        document.addEventListener("keyup", function (event) {
          if (event.keyCode === KEY_SHIFT) {
            return _this.setMacAnimation(false);
          }
        });
        return document.addEventListener("keydown", function (event) {
          if (event.keyCode === KEY_SHIFT) {
            return _this.setMacAnimation(true);
          }
        });
      }
    }, {
      key: "fixPuzzleDarkMode",
      value: function fixPuzzleDarkMode() {
        var host, style;
        host = document.querySelector(".ipuzzle-embed ipuzzler-puzzle");

        if (host != null) {
          style = document.createElement("style");
          style.textContent = "input { color: black; }\n@media (prefers-color-scheme: dark) {\n\tdiv.ipuzzler section.puzzle-clue-list ol li.highlighted,\n\tdiv.ipuzzler div#buttons div#grid-buttons button { background-color: #9cf5 !important; color: #fff; }\n}";
          return host.shadowRoot.appendChild(style);
        }
      }
    }, {
      key: "signalDone",
      value: function signalDone() {
        return console.info("All done and ready.");
      }
    }]);

    return TwentyFourDaysController;
  }(); // Start everything when the page is ready


  window.addEventListener("DOMContentLoaded", function () {
    return app.controller = new TwentyFourDaysController();
  });
}).call(void 0);

//# sourceMappingURL=app.js.map
