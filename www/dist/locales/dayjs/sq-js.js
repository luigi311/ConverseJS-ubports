(self["webpackChunkconverse_js"] = self["webpackChunkconverse_js"] || []).push([[8603],{

/***/ 2749:
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

!function (e, t) {
   true ? module.exports = t(__webpack_require__(8570)) : 0;
}(this, function (e) {
  "use strict";

  function t(e) {
    return e && "object" == typeof e && "default" in e ? e : {
      default: e
    };
  }

  var _ = t(e),
      n = {
    name: "sq",
    weekdays: "E Diel_E Hënë_E Martë_E Mërkurë_E Enjte_E Premte_E Shtunë".split("_"),
    months: "Janar_Shkurt_Mars_Prill_Maj_Qershor_Korrik_Gusht_Shtator_Tetor_Nëntor_Dhjetor".split("_"),
    weekStart: 1,
    weekdaysShort: "Die_Hën_Mar_Mër_Enj_Pre_Sht".split("_"),
    monthsShort: "Jan_Shk_Mar_Pri_Maj_Qer_Kor_Gus_Sht_Tet_Nën_Dhj".split("_"),
    weekdaysMin: "D_H_Ma_Më_E_P_Sh".split("_"),
    ordinal: function (e) {
      return e;
    },
    formats: {
      LT: "HH:mm",
      LTS: "HH:mm:ss",
      L: "DD/MM/YYYY",
      LL: "D MMMM YYYY",
      LLL: "D MMMM YYYY HH:mm",
      LLLL: "dddd, D MMMM YYYY HH:mm"
    },
    relativeTime: {
      future: "në %s",
      past: "%s më parë",
      s: "disa sekonda",
      m: "një minutë",
      mm: "%d minuta",
      h: "një orë",
      hh: "%d orë",
      d: "një ditë",
      dd: "%d ditë",
      M: "një muaj",
      MM: "%d muaj",
      y: "një vit",
      yy: "%d vite"
    }
  };

  return _.default.locale(n, null, !0), n;
});

/***/ })

}]);
//# sourceMappingURL=sq-js.js.map