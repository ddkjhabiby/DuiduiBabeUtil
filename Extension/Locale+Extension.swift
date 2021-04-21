//
//  Locale+Extension.swift
//  Bobo
//
//  Created by ddkj on 2019/8/16.
//  Copyright © 2019 duiud. All rights reserved.
//

import Foundation

public extension Locale {
//    fileprivate static let countryDictionary = [
//        "AF" : "93",    "AL" : "355",   "DZ" : "213",   "AS" : "1",     "AD" : "376",   "AO" : "244",
//        "AI" : "1",     "AG" : "1",     "AR" : "54",    "AM" : "374",   "AW" : "297",   "AU" : "61",
//        "AT" : "43",    "AZ" : "994",   "BS" : "1",     "BH" : "973",   "BD" : "880",   "BB" : "1",
//        "BY" : "375",   "BE" : "32",    "BZ" : "501",   "BJ" : "229",   "BM" : "1",     "BT" : "975",
//        "BA" : "387",   "BW" : "267",   "BR" : "55",    "IO" : "246",   "BG" : "359",   "BF" : "226",
//        "BI" : "257",   "KH" : "855",   "CM" : "237",   "CA" : "1",     "CV" : "238",   "KY" : "345",
//        "CF" : "236",   "TD" : "235",   "CL" : "56",    "CN" : "86",    "CX" : "61",    "CO" : "57",    "COM" : "269",
//        "KM" : "269",   "CG" : "242",   "CK" : "682",   "CR" : "506",   "HR" : "385",   "CU" : "53",
//        "CY" : "537",   "CZ" : "420",   "DK" : "45",    "DJ" : "253",   "DM" : "1",     "DO" : "1",
//        "EC" : "593",   "EG" : "20",    "SV" : "503",   "GQ" : "240",   "ER" : "291",   "EE" : "372",
//        "ET" : "251",   "FO" : "298",   "FJ" : "679",   "FI" : "358",   "FR" : "33",    "GF" : "594",
//        "PF" : "689",   "GA" : "241",   "GM" : "220",   "GE" : "995",   "DE" : "49",    "GH" : "233",
//        "GI" : "350",   "GR" : "30",    "GL" : "299",   "GD" : "1",     "GP" : "590",   "GU" : "1",
//        "GT" : "502",   "GN" : "224",   "GW" : "245",   "GY" : "595",   "HT" : "509",   "HN" : "504",
//        "HU" : "36",    "IS" : "354",   "IN" : "91",    "ID" : "62",    "IQ" : "964",   "IE" : "353",
//        "IL" : "972",   "IT" : "39",    "JM" : "1",     "JP" : "81",    "JO" : "962",   "KZ" : "77",
//        "KE" : "254",   "KI" : "686",   "KW" : "965",   "KG" : "996",   "LV" : "371",   "LB" : "961",
//        "LS" : "266",   "LR" : "231",   "LI" : "423",   "LT" : "370",   "LU" : "352",   "MG" : "261",
//        "MW" : "265",   "MY" : "60",    "MV" : "960",   "ML" : "223",   "MT" : "356",   "MH" : "692",
//        "MQ" : "596",   "MR" : "222",   "MU" : "230",   "YT" : "262",   "MX" : "52",    "MC" : "377",
//        "MN" : "976",   "ME" : "382",   "MS" : "1",     "MA" : "212",   "MM" : "95",    "MRT": "222",    "NA" : "264",
//        "NR" : "674",   "NP" : "977",   "NL" : "31",    "AN" : "599",   "NC" : "687",   "NZ" : "64",
//        "NI" : "505",   "NE" : "227",   "NG" : "234",   "NU" : "683",   "NF" : "672",   "MP" : "1",
//        "NO" : "47",    "OM" : "968",   "PK" : "92",    "PW" : "680",   "PA" : "507",   "PG" : "675",
//        "PY" : "595",   "PE" : "51",    "PH" : "63",    "PL" : "48",    "PT" : "351",   "PR" : "1",
//        "QA" : "974",   "RO" : "40",    "RW" : "250",   "WS" : "685",   "SM" : "378",   "SA" : "966",
//        "SN" : "221",   "RS" : "381",   "SC" : "248",   "SL" : "232",   "SG" : "65",    "SK" : "421",
//        "SI" : "386",   "SB" : "677",   "ZA" : "27",    "GS" : "500",   "ES" : "34",    "LK" : "94",
//        "SD" : "249",   "SR" : "597",   "SZ" : "268",   "SE" : "46",    "CH" : "41",    "TJ" : "992",
//        "TH" : "66",    "TG" : "228",   "TK" : "690",   "TO" : "676",   "TT" : "1",     "TN" : "216",
//        "TR" : "90",    "TM" : "993",   "TC" : "1",     "TV" : "688",   "UG" : "256",   "UA" : "380",
//        "AE" : "971",   "GB" : "44",    "US" : "1",     "UY" : "598",   "UZ" : "998",   "VU" : "678",
//        "WF" : "681",   "YE" : "967",   "ZM" : "260",   "ZW" : "263",   "BO" : "591",   "BN" : "673",
//        "CC" : "61",    "CD" : "243",   "CI" : "225",   "FK" : "500",   "GG" : "44",    "VA" : "379",
//        "HK" : "852",   "IR" : "98",    "IM" : "44",    "JE" : "44",    "KP" : "850",   "KR" : "82",
//        "LA" : "856",   "LY" : "218",   "MO" : "853",   "MK" : "389",   "FM" : "691",   "MD" : "373",
//        "MZ" : "258",   "PS" : "970",   "PN" : "872",   "RE" : "262",   "RU" : "7",     "BL" : "590",
//        "SH" : "290",   "KN" : "1",     "LC" : "1",     "MF" : "590",   "PM" : "508",   "VC" : "1",
//        "ST" : "239",   "SO" : "252",   "SJ" : "47",    "SY" : "963",   "TZ" : "255",
//        "TL" : "670",   "VE" : "58",    "VN" : "84",    "VG" : "284",   "VI" : "340"]
//
//    fileprivate static let countryFlagDictionary = [ "AD" : "🇦🇩",    "AE" : "🇦🇪",    "AF" : "🇦🇫",    "AG" : "🇦🇬",    "AI" : "🇦🇮",    "AL" : "🇦🇱",    "AM" : "🇦🇲",    "AO" : "🇦🇴",    "AQ" : "🇦🇶",    "AR" : "🇦🇷",    "AS" : "🇦🇸",    "AT" : "🇦🇹",    "AU" : "🇦🇺",    "AW" : "🇦🇼",    "AX" : "🇦🇽",    "AZ" : "🇦🇿",    "BA" : "🇧🇦",    "BB" : "🇧🇧",    "BD" : "🇧🇩",    "BE" : "🇧🇪",    "BF" : "🇧🇫",    "BG" : "🇧🇬",    "BH" : "🇧🇭",    "BI" : "🇧🇮",    "BJ" : "🇧🇯",    "BL" : "🇧🇱",    "BM" : "🇧🇲",    "BN" : "🇧🇳",    "BO" : "🇧🇴",    "BQ" : "🇧🇶",    "BR" : "🇧🇷",    "BS" : "🇧🇸",    "BT" : "🇧🇹",    "BV" : "🇳🇴",    "BW" : "🇧🇼",    "BY" : "🇧🇾",    "BZ" : "🇧🇿",    "CA" : "🇨🇦",    "CC" : "🇨🇨",    "CD" : "🇨🇩",    "CF" : "🇨🇫",    "CG" : "🇨🇬",    "CH" : "🇨🇭",    "CI" : "🇨🇮",    "CK" : "🇨🇰",    "CL" : "🇨🇱",    "CM" : "🇨🇲",    "CN" : "🇨🇳",    "CO" : "🇨🇴",    "COM" : "🇰🇲",    "CR" : "🇨🇷",    "CU" : "🇨🇺",    "CV" : "🇨🇻",    "CW" : "🇨🇼",    "CX" : "🇨🇽",    "CY" : "🇨🇾",    "CZ" : "🇨🇿",    "DE" : "🇩🇪",    "DJ" : "🇩🇯",    "DK" : "🇩🇰",    "DM" : "🇩🇲",    "DO" : "🇩🇴",    "DZ" : "🇩🇿",    "EC" : "🇪🇨",    "EE" : "🇪🇪",    "EG" : "🇪🇬",    "EH" : "🇪🇭",    "ER" : "🇪🇷",    "ES" : "🇪🇸",    "ET" : "🇪🇹",    "FI" : "🇫🇮",    "FJ" : "🇫🇯",    "FK" : "🇫🇰",    "FM" : "🇫🇲",    "FO" : "🇫🇴",    "FR" : "🇫🇷",    "GA" : "🇬🇦",    "GB" : "🇬🇧",    "GD" : "🇬🇩",    "GE" : "🇬🇪",    "GF" : "🇬🇫",    "GG" : "🇬🇬",    "GH" : "🇬🇭",    "GI" : "🇬🇮",    "GL" : "🇬🇱",    "GM" : "🇬🇲",    "GN" : "🇬🇳",    "GP" : "🇬🇵",    "GQ" : "🇬🇶",    "GR" : "🇬🇷",    "GS" : "🇬🇸",    "GT" : "🇬🇹",    "GU" : "🇬🇺",    "GW" : "🇬🇼",    "GY" : "🇬🇾",    "HK" : "🇭🇰",    "HM" : "🇦🇺",    "HN" : "🇭🇳",    "HR" : "🇭🇷",    "HT" : "🇭🇹",    "HU" : "🇭🇺",    "ID" : "🇮🇩",    "IE" : "🇮🇪",    "IL" : "🇮🇱",    "IM" : "🇮🇲",    "IN" : "🇮🇳",    "IO" : "🇮🇴",    "IQ" : "🇮🇶",    "IR" : "🇮🇷",    "IS" : "🇮🇸",    "IT" : "🇮🇹",    "JE" : "🇯🇪",    "JM" : "🇯🇲",    "JO" : "🇯🇴",    "JP" : "🇯🇵",    "KE" : "🇰🇪",    "KG" : "🇰🇬",    "KH" : "🇰🇭",    "KI" : "🇰🇲",    "KM" : "🇰🇲",    "KN" : "🇰🇳",    "KP" : "🇰🇵",    "KR" : "🇰🇷",    "KW" : "🇰🇼",    "KY" : "🇰🇾",    "KZ" : "🇰🇿",    "LA" : "🇱🇦",    "LB" : "🇱🇧",    "LC" : "🇱🇨",    "LI" : "🇱🇮",    "LK" : "🇱🇰",    "LR" : "🇱🇷",    "LS" : "🇱🇸",    "LT" : "🇱🇹",    "LU" : "🇱🇺",    "LV" : "🇱🇻",    "LY" : "🇱🇾",    "MA" : "🇲🇦",    "MC" : "🇲🇨",    "MD" : "🇲🇩",    "ME" : "🇲🇪",    "MF" : "🇫🇷",    "MG" : "🇲🇬",    "MH" : "🇲🇭",    "MK" : "🇲🇰",    "ML" : "🇲🇱",    "MM" : "🇲🇲",    "MN" : "🇲🇳",    "MO" : "🇲🇴",    "MP" : "🇲🇵",    "MQ" : "🇲🇶",    "MR" : "🇲🇷",    "MRT" : "🇲🇷",    "MS" : "🇲🇸",    "MT" : "🇲🇹",    "MU" : "🇲🇺",    "MV" : "🇲🇻",    "MW" : "🇲🇼",    "MX" : "🇲🇽",    "MY" : "🇲🇾",    "MZ" : "🇲🇿",    "NA" : "🇳🇦",    "NC" : "🇳🇨",    "NE" : "🇳🇪",    "NF" : "🇳🇫",    "NG" : "🇳🇬",    "NI" : "🇳🇮",    "NL" : "🇳🇱",    "NO" : "🇳🇴",    "NP" : "🇳🇵",    "NR" : "🇳🇷",    "NU" : "🇳🇺",    "NZ" : "🇳🇿",    "OM" : "🇴🇲",    "PA" : "🇵🇦",    "PE" : "🇵🇪",    "PF" : "🇵🇫",    "PG" : "🇵🇬",    "PH" : "🇵🇭",    "PK" : "🇵🇰",    "PL" : "🇵🇱",    "PM" : "🇵🇲",    "PN" : "🇵🇳",    "PR" : "🇵🇷",    "PS" : "🇵🇸",    "PT" : "🇵🇹",    "PW" : "🇵🇼",    "PY" : "🇵🇾",    "QA" : "🇶🇦",    "RE" : "🇷🇪",    "RO" : "🇷🇴",    "RS" : "🇷🇸",    "RU" : "🇷🇺",    "RW" : "🇷🇼",    "SA" : "🇸🇦",    "SB" : "🇸🇧",    "SC" : "🇸🇨",    "SD" : "🇸🇩",    "SE" : "🇸🇪",    "SG" : "🇸🇬",    "SH" : "🇸🇭",    "SI" : "🇸🇮",    "SJ" : "🇳🇴",    "SK" : "🇸🇰",    "SL" : "🇸🇱",    "SM" : "🇸🇲",    "SN" : "🇸🇳",    "SO" : "🇸🇴",    "SR" : "🇸🇷",    "SS" : "🇸🇸",    "ST" : "🇸🇹",    "SV" : "🇸🇻",    "SX" : "🇸🇽",    "SY" : "🇸🇾",    "SZ" : "🇸🇿",    "TC" : "🇹🇨",    "TD" : "🇹🇩",    "TF" : "🇹🇫",    "TG" : "🇹🇬",    "TH" : "🇹🇭",    "TJ" : "🇹🇯",    "TK" : "🇹🇰",    "TL" : "🇹🇱",    "TM" : "🇹🇲",    "TN" : "🇹🇳",    "TO" : "🇹🇴",    "TR" : "🇹🇷",    "TT" : "🇹🇹",    "TV" : "🇹🇻",    "TZ" : "🇹🇿",    "UA" : "🇺🇦",    "UG" : "🇺🇬",    "UM" : "🇺🇸",    "US" : "🇺🇸",    "UY" : "🇺🇾",    "UZ" : "🇺🇿",    "VA" : "🇻🇦",    "VC" : "🇻🇨",    "VE" : "🇻🇪",    "VG" : "🇻🇬",    "VI" : "🇻🇮",    "VN" : "🇻🇳",    "VU" : "🇻🇺",    "WF" : "🇼🇫",    "WS" : "🇼🇸",    "YE" : "🇾🇪",    "YT" : "🇾🇹",    "ZA" : "🇿🇦",    "ZM" : "🇿🇲",    "ZW" : "🇿🇼",    "AN" : "🇨🇼"]
//
//    static func countryName(_ code: String?, languageCode: String) -> String {
//        guard let code = code else {
//            return ""
//        }
//        return (Locale(identifier: languageCode) as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: code) ?? ""
//    }
//
//    static func selectableCountryCode() -> Array<String> {
//        let array1 = Array<String>(Locale.countryDictionary.keys)
//        let array2 = Locale.hotCountryCode()
//        let set1 = Set(array1)
//        let set2 = Set(array2)
//        let set3 = set1.symmetricDifference(set2)
//        return Array(set3)
//    }
//
//    static func hotCountryCode() -> Array<String> {
//        return ["SA", "IQ", "EG", "DZ", "MA"]
//    }
//
//    static func phoneCode(_ countryCode: String) -> String {
//        return countryDictionary[countryCode.uppercased()] ?? ""
//    }
//
//    static func flag(_ countryCode: String?) -> String {
//        guard let countryCode = countryCode else {
//            return ""
//        }
//        return countryFlagDictionary[countryCode.uppercased()] ?? ""
//    }
//
//    func countryCode(_ languageCode: String) -> String {
//        return (Locale(identifier: languageCode) as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
//    }
//
//    func countryName(_ languageCode: String) -> String {
//        return Locale.countryName(countryCode(languageCode), languageCode: languageCode)
//    }
//
//    func countryPhoneCode(_ languageCode: String) -> String {
//        return Locale.phoneCode(countryCode(languageCode))
//    }
//
//    var code: String? {
//        if let country = Locale.current.identifier.components(separatedBy: "_").last {
//            return country.subStringTo(index: 1)
//        }
//        return nil
//    }
}
