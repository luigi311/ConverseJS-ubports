(self["webpackChunkconverse_js"] = self["webpackChunkconverse_js"] || []).push([[9095],{

/***/ 1504:
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

!function (e, a) {
   true ? module.exports = a(__webpack_require__(8570)) : 0;
}(this, function (e) {
  "use strict";

  function a(e) {
    return e && "object" == typeof e && "default" in e ? e : {
      default: e
    };
  }

  var t = a(e),
      s = {
    name: "ms",
    weekdays: "Ahad_Isnin_Selasa_Rabu_Khamis_Jumaat_Sabtu".split("_"),
    weekdaysShort: "Ahd_Isn_Sel_Rab_Kha_Jum_Sab".split("_"),
    weekdaysMin: "Ah_Is_Sl_Rb_Km_Jm_Sb".split("_"),
    months: "Januari_Februari_Mac_April_Mei_Jun_Julai_Ogos_September_Oktober_November_Disember".split("_"),
    monthsShort: "Jan_Feb_Mac_Apr_Mei_Jun_Jul_Ogs_Sep_Okt_Nov_Dis".split("_"),
    weekStart: 1,
    formats: {
      LT: "HH.mm",
      LTS: "HH.mm.ss",
      L: "DD/MM/YYYY",
      LL: "D MMMM YYYY",
      LLL: "D MMMM YYYY HH.mm",
      LLLL: "dddd, D MMMM YYYY HH.mm"
    },
    relativeTime: {
      future: "dalam %s",
      past: "%s yang lepas",
      s: "beberapa saat",
      m: "seminit",
      mm: "%d minit",
      h: "sejam",
      hh: "%d jam",
      d: "sehari",
      dd: "%d hari",
      M: "sebulan",
      MM: "%d bulan",
      y: "setahun",
      yy: "%d tahun"
    },
    ordinal: function (e) {
      return e + ".";
    }
  };
  return t.default.locale(s, null, !0), s;
});

/***/ })

}]);
//# sourceMappingURL=ms-js.js.map