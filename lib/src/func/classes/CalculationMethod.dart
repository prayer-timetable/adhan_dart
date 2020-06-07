import 'package:prayer_calc/src/func/classes/CalculationParameters.dart';

const CalculationMethod = {
    // Muslim World League
    MuslimWorldLeague: function() {
        let params = new CalculationParameters("MuslimWorldLeague", 18, 17);
        params.methodAdjustments = { dhuhr: 1 };
        return params;
    },

    // Egyptian General Authority of Survey
    Egyptian: function() {
        let params = new CalculationParameters("Egyptian", 19.5, 17.5);
        params.methodAdjustments = { dhuhr: 1 };
        return params;
    },

    // University of Islamic Sciences, Karachi
    Karachi: function() {
        let params = new CalculationParameters("Karachi", 18, 18);
        params.methodAdjustments = { dhuhr: 1 };
        return params;
    },

    // Umm al-Qura University, Makkah
    UmmAlQura: function() {
        return new CalculationParameters("UmmAlQura", 18.5, 0, 90);
    },

    // Dubai
    Dubai: function() {
        let params = new CalculationParameters("Dubai", 18.2, 18.2);
        params.methodAdjustments = { sunrise: -3, dhuhr: 3, asr: 3, maghrib: 3 };
        return params;
    },

    // Moonsighting Committee
    MoonsightingCommittee: function() {
        let params = new CalculationParameters("MoonsightingCommittee", 18, 18);
        params.methodAdjustments = { dhuhr: 5, maghrib: 3 };
        return params;
    },

    // ISNA
    NorthAmerica: function() {
        let params = new CalculationParameters("NorthAmerica", 15, 15);
        params.methodAdjustments = { dhuhr: 1 };
        return params;
    },

    // Kuwait
    Kuwait: function() {
        return new CalculationParameters("Kuwait", 18, 17.5);
    },

    // Qatar
    Qatar: function() {
        return new CalculationParameters("Qatar", 18, 0, 90);
    },

    // Singapore
    Singapore: function() {
        let params = new CalculationParameters("Singapore", 20, 18);
        params.methodAdjustments = { dhuhr: 1 };
        return params;
    },

    // Institute of Geophysics, University of Tehran
    Tehran: function() {
        let params = new CalculationParameters("Tehran", 17.7, 14, 0, 4.5);
        return params;
    },

    // Dianet
    Turkey: function() {
        let params = new CalculationParameters("Turkey", 18, 17);
        params.methodAdjustments = { sunrise: -7, dhuhr: 5, asr: 4, maghrib: 7 };
        return params;
    },

    // Moroccan ministry of Habous and Islamic Affairs
    Morocco: function(){
        let params = new CalculationParameters("Morocco", 19, 17);
        params.methodAdjustments = {sunrise: -3, dhuhr: 5, maghrib: 5 };
        return params;
    },

    // Other
    Other: function() {
        return new CalculationParameters("Other", 0, 0);
    }
};

export default CalculationMethod;