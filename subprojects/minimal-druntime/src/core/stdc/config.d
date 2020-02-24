///Types not avail from original core.stdc.config for bare-metal
module core.stdc.config;

alias int8_t =  byte;
alias int16_t = short;
alias int32_t = int;
alias int64_t = long;

alias uint8_t =  ubyte;
alias uint16_t = ushort;
alias uint32_t = uint;
alias uint64_t = ulong;

version (ARM)
{
    alias size_t = uint;

    alias c_long = int;
    alias c_ulong = uint;

    alias wchar_t = dchar;

    alias fpos_t = c_long;

    //TODO: rework:
    alias int_least8_t =  byte;
    alias int_least16_t = short;
    alias int_least32_t = int;
    alias int_least64_t = long;

    alias uint_least8_t =  ubyte;
    alias uint_least16_t = ushort;
    alias uint_least32_t = uint;
    alias uint_least64_t = ulong;

    alias int_fast8_t =  byte;
    alias int_fast16_t = short;
    alias int_fast32_t = int;
    alias int_fast64_t = long;

    alias uint_fast8_t =  ubyte;
    alias uint_fast16_t = ushort;
    alias uint_fast32_t = uint;
    alias uint_fast64_t = ulong;
}

alias time_t = int;

struct tm;
