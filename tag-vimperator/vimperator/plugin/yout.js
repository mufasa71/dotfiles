/* {{{
Copyright (c) 2008-2010, anekos.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
    3. The names of the authors may not be used to endorse or promote products
       derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.


###################################################################################
# http://sourceforge.jp/projects/opensource/wiki/licenses%2Fnew_BSD_license       #
###################################################################################

}}} */

// PLUGIN_INFO {{{
//
let PLUGIN_INFO = xml`
<VimperatorPlugin>
  <name>{NAME}</name>
  <description>Write a link to the specified file.</description>
  <version>1.0.0</version>
  <author mail="***REMOVED***" homepage="http://***REMOVED***.github.com">***REMOVED***</author>
  <license>new BSD License (Please read the source code comments of this plugin)</license>
  <minVersion>2.0pre</minVersion>
  <maxVersion>2.4</maxVersion>
  <detail><![CDATA[
    == Usage ==
      :yout:
        write link to the specified file.
  ]]></detail>
</VimperatorPlugin>`;
// }}}

(function () {
  let localfilepath = io.expandPath(liberator.globalVariables.yout_watch_list);
  let charset = 'UTF-8';

  function filepath () {
    let result = Cc["@mozilla.org/file/local;1"].createInstance(Ci.nsILocalFile);
    result.initWithPath(localfilepath);
    return result;
  }

  function puts (line) {
    line += "\n";
    let out = Cc["@mozilla.org/network/file-output-stream;1"].createInstance(Ci.nsIFileOutputStream);
    let conv = Cc['@mozilla.org/intl/converter-output-stream;1'].
                            createInstance(Ci.nsIConverterOutputStream);
    out.init(filepath(), 0x02 | 0x10 | 0x08, 0664, 0);
    conv.init(out, charset, line.length,
              Components.interfaces.nsIConverterInputStream.DEFAULT_REPLACEMENT_CHARACTER);
    conv.writeString(line);
    conv.close();
    out.close();
  }

  function gets () {
    let file = Cc['@mozilla.org/network/file-input-stream;1'].createInstance(Ci.nsIFileInputStream);
    file.init(filepath(), 1, 0, false);
    let conv = Cc['@mozilla.org/intl/converter-input-stream;1'].createInstance(Ci.nsIConverterInputStream);
    conv.init(file, charset, file.available(), conv.DEFAULT_REPLACEMENT_CHARACTER);
    let result = {};
    conv.readString(file.available(), result);
    conv.close();
    file.close();
    return result.value;
  }

  commands.addUserCommand(
    ['yout'],
    'Write youtube link',
    function (arg) {
      if (arg.literalArg) {
        puts(arg.literalArg);
      } else {
        let links = gets().split(/\n/).reverse();
        let list = (links.length <= 0) ? `<div>No entries</div>` : `<dl>
          ${liberator.modules.template.map(links, function(link) xml`<li>${link}</li>`)}
        </dl>`;
        liberator.echo(list, true);
      }
    },
    {
      literal: 0,
      completer: function (context) {
        context.completions = [ [buffer.URL, 'Current URL'] ];
      }
    },
    true
  );
})();
