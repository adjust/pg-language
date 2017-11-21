/*
 * code automatically generated with make and build_lang.sh
 */

#ifndef LANG_FWD_H
#define LANG_FWD_H

#include "language.h"

static inline char *
create_string(const char *chars)
{
    char *str = (char *) palloc(3 * sizeof(char));
    memcpy(str, chars, 2 * sizeof(char));
    str[3] = '\0';
    return str;
}

static inline char *
language_to_str(language_code c)
{
    switch (c)
    {
        case 1: return create_string("aa");
        case 2: return create_string("ab");
        case 3: return create_string("ae");
        case 4: return create_string("af");
        case 5: return create_string("ak");
        case 6: return create_string("am");
        case 7: return create_string("an");
        case 8: return create_string("ar");
        case 9: return create_string("as");
        case 10: return create_string("av");
        case 11: return create_string("ay");
        case 12: return create_string("az");
        case 13: return create_string("ba");
        case 14: return create_string("be");
        case 15: return create_string("bg");
        case 16: return create_string("bh");
        case 17: return create_string("bi");
        case 18: return create_string("bm");
        case 19: return create_string("bn");
        case 20: return create_string("bo");
        case 21: return create_string("br");
        case 22: return create_string("bs");
        case 23: return create_string("ca");
        case 24: return create_string("ce");
        case 25: return create_string("ch");
        case 26: return create_string("co");
        case 27: return create_string("cr");
        case 28: return create_string("cs");
        case 29: return create_string("cu");
        case 30: return create_string("cv");
        case 31: return create_string("cy");
        case 32: return create_string("da");
        case 33: return create_string("de");
        case 34: return create_string("dv");
        case 35: return create_string("dz");
        case 36: return create_string("ee");
        case 37: return create_string("el");
        case 38: return create_string("en");
        case 39: return create_string("eo");
        case 40: return create_string("es");
        case 41: return create_string("et");
        case 42: return create_string("eu");
        case 43: return create_string("fa");
        case 44: return create_string("ff");
        case 45: return create_string("fi");
        case 46: return create_string("fj");
        case 47: return create_string("fo");
        case 48: return create_string("fr");
        case 49: return create_string("fy");
        case 50: return create_string("ga");
        case 51: return create_string("gd");
        case 52: return create_string("gl");
        case 53: return create_string("gn");
        case 54: return create_string("gu");
        case 55: return create_string("gv");
        case 56: return create_string("ha");
        case 57: return create_string("he");
        case 58: return create_string("hi");
        case 59: return create_string("ho");
        case 60: return create_string("hr");
        case 61: return create_string("ht");
        case 62: return create_string("hu");
        case 63: return create_string("hy");
        case 64: return create_string("hz");
        case 65: return create_string("ia");
        case 66: return create_string("id");
        case 67: return create_string("ie");
        case 68: return create_string("ig");
        case 69: return create_string("ii");
        case 70: return create_string("ik");
        case 71: return create_string("io");
        case 72: return create_string("is");
        case 73: return create_string("it");
        case 74: return create_string("iu");
        case 75: return create_string("ja");
        case 76: return create_string("jv");
        case 77: return create_string("ka");
        case 78: return create_string("kg");
        case 79: return create_string("ki");
        case 80: return create_string("kj");
        case 81: return create_string("kk");
        case 82: return create_string("kl");
        case 83: return create_string("km");
        case 84: return create_string("kn");
        case 85: return create_string("ko");
        case 86: return create_string("kr");
        case 87: return create_string("ks");
        case 88: return create_string("ku");
        case 89: return create_string("kv");
        case 90: return create_string("kw");
        case 91: return create_string("ky");
        case 92: return create_string("la");
        case 93: return create_string("lb");
        case 94: return create_string("lg");
        case 95: return create_string("li");
        case 96: return create_string("ln");
        case 97: return create_string("lo");
        case 98: return create_string("lt");
        case 99: return create_string("lu");
        case 100: return create_string("lv");
        case 101: return create_string("mg");
        case 102: return create_string("mh");
        case 103: return create_string("mi");
        case 104: return create_string("mk");
        case 105: return create_string("ml");
        case 106: return create_string("mn");
        case 107: return create_string("mr");
        case 108: return create_string("ms");
        case 109: return create_string("mt");
        case 110: return create_string("my");
        case 111: return create_string("na");
        case 112: return create_string("nb");
        case 113: return create_string("nd");
        case 114: return create_string("ne");
        case 115: return create_string("ng");
        case 116: return create_string("nl");
        case 117: return create_string("nn");
        case 118: return create_string("no");
        case 119: return create_string("nr");
        case 120: return create_string("nv");
        case 121: return create_string("ny");
        case 122: return create_string("oc");
        case 123: return create_string("oj");
        case 124: return create_string("om");
        case 125: return create_string("or");
        case 126: return create_string("os");
        case 127: return create_string("pa");
        case 128: return create_string("pi");
        case 129: return create_string("pl");
        case 130: return create_string("ps");
        case 131: return create_string("pt");
        case 132: return create_string("qu");
        case 133: return create_string("rm");
        case 134: return create_string("rn");
        case 135: return create_string("ro");
        case 136: return create_string("ru");
        case 137: return create_string("rw");
        case 138: return create_string("sa");
        case 139: return create_string("sc");
        case 140: return create_string("sd");
        case 141: return create_string("se");
        case 142: return create_string("sg");
        case 143: return create_string("si");
        case 144: return create_string("sk");
        case 145: return create_string("sl");
        case 146: return create_string("sm");
        case 147: return create_string("sn");
        case 148: return create_string("so");
        case 149: return create_string("sq");
        case 150: return create_string("sr");
        case 151: return create_string("ss");
        case 152: return create_string("st");
        case 153: return create_string("su");
        case 154: return create_string("sv");
        case 155: return create_string("sw");
        case 156: return create_string("ta");
        case 157: return create_string("te");
        case 158: return create_string("tg");
        case 159: return create_string("th");
        case 160: return create_string("ti");
        case 161: return create_string("tk");
        case 162: return create_string("tl");
        case 163: return create_string("tn");
        case 164: return create_string("to");
        case 165: return create_string("tr");
        case 166: return create_string("ts");
        case 167: return create_string("tt");
        case 168: return create_string("tw");
        case 169: return create_string("ty");
        case 170: return create_string("ug");
        case 171: return create_string("uk");
        case 172: return create_string("ur");
        case 173: return create_string("uz");
        case 174: return create_string("ve");
        case 175: return create_string("vi");
        case 176: return create_string("vo");
        case 177: return create_string("wa");
        case 178: return create_string("wo");
        case 179: return create_string("xh");
        case 180: return create_string("yi");
        case 181: return create_string("yo");
        case 182: return create_string("za");
        case 183: return create_string("zh");
        case 184: return create_string("zu");
        case 185: return create_string("zz");
    default: elog(ERROR, "internal language representation unknown: %u", c);
    }
}
#endif
