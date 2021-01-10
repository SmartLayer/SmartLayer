# math-friendly-xkb

This repo contains a modified variation of the "English (intl., with
AltGr dead keys)" layout. It's modified from the
`/usr/share/X11/xkb/symbols/us` file shipped with Ubuntu. The repo
updates at every Ubuntu LTS release.

The major changes are:

- Replacing 'currency' symbol with Thai_baht symbol which is used for
  Bitcoin. Use <alt> + <4> to get ฿.

- Similarly, adding Ξ for Ether (currency of Ethereum). It's <shift> +
  <alt> + <x>.

- Adding a <super> key level for every letter in English alphabet
  which produces an Italic variant in Unicode, often used in
  mathematical expressions.

- Adding <super> key level for every digit which produces a subscript
  digit.  This turned out to be less frequently used than I
  anticipated.

- Adding <shift> + <super> level for superscript numbers and
  superscript arithmetic operators. <shift> + <super> + <4> gives you
  ⁴, so does every number from 4 to 0. This again turned out to be
  less used.

- The super script of 1, 2 and 3 can be produced with <alt> + <shift>
  + <1>, <alt> + <shift> + <2>, <alt> + <shift> + <3>. This is per
  original "English (intl., with AltGr dead keys)" layout.

- <shift> + <super> + <1> and <shift> + <super> + <2> produces ⁽ and ⁾.

- <shift> + <super> + <-> and <shift> + <super> + <+> produces ⁻ and ⁺.

- Adding <shift> + <super> level for every letter in English alphabet
  which produces a superscript letter if there exists one.

- Adding division slash and fraction slash.

- Adding the first 4 of the traditional order oef note symbols in
  English:

https://en.wikipedia.org/wiki/Note_(typography)

## Very small (63 keys) keyboards

On these keyboards, often the uppwer-left key is ESC instead of tilde. In my
case tilde is more desirable because they are used in vim for going to marked
locations, and in commandline for home directory. To change that key back to
Tilde, add this to the section "English (intl., with AltGr dead keys)"

    key <ESC> { [    grave, asciitilde,  dead_grave,   dead_tilde, Escape ] };
