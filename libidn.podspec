Pod::Spec.new do |s|
  s.name             = "libidn"
  s.version          = "1.32"
  s.summary          = "Encode/decode i18n domains using Stringprep, Punycode and IDNA."
  s.description      = <<-DESC
  GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA specifications. Libidn's purpose is to encode and decode internationalized domain names. The native C, C# and Java libraries are available under the GNU Lesser General Public License version 2.1 or later.

The library contains a generic Stringprep implementation. Profiles for Nameprep, iSCSI, SASL, XMPP and Kerberos V5 are included. Punycode and ASCII Compatible Encoding (ACE) via IDNA are supported. A mechanism to define Top-Level Domain (TLD) specific validation tables, and to compare strings against those tables, is included. Default tables for some TLDs are also included.

The Stringprep API consists of two main functions, one for converting data from the system's native representation into UTF-8, and one function to perform the Stringprep processing. Adding a new Stringprep profile for your application within the API is straightforward. The Punycode API consists of one encoding function and one decoding function. The IDNA API consists of the ToASCII and ToUnicode functions, as well as an high-level interface for converting entire domain names to and from the ACE encoded form. The TLD API consists of one set of functions to extract the TLD name from a domain string, one set of functions to locate the proper TLD table to use based on the TLD name, and core functions to validate a string against a TLD table, and some utility wrappers to perform all the steps in one call.

The library is used by, e.g., GNU SASL and Shishi to process user names and passwords. Libidn can be built into GNU Libc to enable a new system-wide getaddrinfo flag for IDN processing.

Libidn is developed for the GNU/Linux system, but runs on over 20 Unix platforms (including Solaris, IRIX, AIX, and Tru64) and Windows. The library is written in C and (parts of) the API is also accessible from C++, Emacs Lisp, Python and Java. A native Java and C# port is included.

Also included is a command line tool, several self tests, code examples, and more, all licensed under the GNU General Public License version 3.0 or later.
                       DESC

  s.homepage         = "https://www.gnu.org/software/libidn/"
  s.license          = { :type => 'LGPL', :file => 'COPYING' }
  s.author           = { "Simon Josefsson" => "simon@josefsson.org" }
  s.social_media_url = 'https://twitter.com/fsf'
  s.source = { :http => 'https://ftp.gnu.org/gnu/libidn/libidn-1.32.tar.gz',
               :sha256 => 'ba5d5afee2beff703a34ee094668da5c6ea5afa38784cebba8924105e185c4f5' }
  # We need to generate 'config.h', 'idn-int.h', 'unistr.h', 'unitypes.h', 'string.h'
  s.prepare_command = <<-CMD
          sh ./configure --disable-dependency-tracking
          echo '#include <stdint.h>' > lib/idn-int.h
          mv lib/gl/unistr.in.h lib/gl/unistr.h
          mv lib/gl/unitypes.in.h lib/gl/unitypes.h
          echo 'int strverscmp (const char *s1, const char *s2);\n#include_next <string.h>' > lib/gl/string.h
     CMD

  s.platform     = :ios, '7.0', :osx, '10.8'
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.8"
  s.requires_arc = true

  s.source_files = 'lib/**/*.{c,h}', 'config.h', 'build-aux/snippet/unused-parameter.h'
  s.public_header_files = 'lib/idn-int.h', 'lib/idna.h', 'lib/pr29.h', 'lib/punycode.h', 'lib/stringprep.h', 'lib/tld.h'
  s.exclude_files = 'lib/idn-free.{c,h}', 'lib/gltests'
  s.compiler_flags = '-DHAVE_CONFIG_H', '-DLIBIDN_BUILDING', '-DLOCALEDIR=\"/usr/share/locale\"'
  s.library = 'iconv'
  s.xcconfig = { :HEADER_SEARCH_PATHS => "$(inherited) ${SRCROOT} ${SRCROOT}/lib ${SRCROOT}/lib/gl"}
end
