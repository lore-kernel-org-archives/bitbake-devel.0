Return-Path: <valentin.popa@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 797F861005
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2013 10:27:05 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 27 Sep 2013 03:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,991,1371106800"; 
	d="scan'208,217";a="384346272"
Received: from vpopa-desktop.rb.intel.com (HELO [10.237.105.58])
	([10.237.105.58])
	by orsmga001.jf.intel.com with ESMTP; 27 Sep 2013 03:27:05 -0700
Message-ID: <52455DE0.3020303@intel.com>
Date: Fri, 27 Sep 2013 13:28:48 +0300
From: Valentin Popa <valentin.popa@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: "cristiana.voicu" <cristiana.voicu@intel.com>
References: <1380107900-4395-1-git-send-email-valentin.popa@intel.com>
	<1380107900-4395-2-git-send-email-valentin.popa@intel.com>
	<52453FA8.5040304@intel.com>
In-Reply-To: <52453FA8.5040304@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] GUI error dialog for bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 27 Sep 2013 10:27:06 -0000
Content-Type: multipart/alternative;
	boundary="------------090307030000060005040104"

--------------090307030000060005040104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/27/2013 11:19 AM, cristiana.voicu wrote:
> Hi Valentin,
>
> I have some comments on this patch:
>
> On 09/25/2013 02:18 PM, Valentin Popa wrote:
>> When the user starts HOB, he/she expects to see some GUI.
>> If bitbake signals an erros before HOB starts the error will
>> be visible only in console and hob script will terminate.
>> This patch allows bitbake to report errors inside a GUI dialog
>> when the user wants to use HOB.
>> WebHOB starts before bitbake's launch and  a common solution
>> for this problem that applies to both HOB and WebHOB is not so obvious.
>>
>> Signed-off-by: Valentin Popa <valentin.popa@intel.com>
>> ---
>>   bitbake/lib/bb/ui/show_error_dialog | 62 
>> +++++++++++++++++++++++++++++++++++++
> The new file doesn't have the extension .py
>> scripts/hob                         |  9 +++++-
>>   2 files changed, 70 insertions(+), 1 deletion(-)
>>   create mode 100755 bitbake/lib/bb/ui/show_error_dialog
>>
>> diff --git a/bitbake/lib/bb/ui/show_error_dialog 
>> b/bitbake/lib/bb/ui/show_error_dialog
>> new file mode 100755
>> index 0000000..09d0c5c
>> --- /dev/null
>> +++ b/bitbake/lib/bb/ui/show_error_dialog
>> @@ -0,0 +1,62 @@
>> +#!/usr/bin/env python
>> +#
>> +# BitBake graphical error reporting dialog used by hob script
>> +#
>> +# Copyright (C) 2013        Intel Corporation
>> +#
>> +# Authored by Valentin Popa <valentin.popa@lintel.com>
>> +# Authored by Andrei Dinu <andrei.adrianx.dinu@intel.com>
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License version 2 as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License 
>> along
>> +# with this program; if not, write to the Free Software Foundation, 
>> Inc.,
>> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> +
>> +import sys
>> +import os
>> +requirements = "FATAL: Gtk+ 2.20.0 or higher & PyGtk 2.21.0 or 
>> higher is required"
>> +try:
>> +    import gtk
>> +    import pygtk
>> +    pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
>> +    gtkver = gtk.gtk_version
>> +    pygtkver = gtk.pygtk_version
>> +    if gtkver  < (2, 20, 0) or pygtkver < (2, 21, 0):
>> +        sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." % (requirements,
>> +                ".".join(map(str, gtkver)),
>> +                ".".join(map(str, pygtkver))))
>> +except ImportError as exc:
>> +    sys.exit("%s (%s)." % (requirements, str(exc)))
>> +
>> +try:
>> +    import crumbs
>> +except RuntimeError as exc:
>> +    sys.exit(str(exc))
>> +sys.path.insert(0, 
>> os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
>> +
>> +from crumbs.hig.crumbsmessagedialog import CrumbsMessageDialog
>> +from crumbs.hobwidget import HobButton
>> +
>> +class HobError(gtk.Window):
>> +
>> +    def __init__(self, error_log_file):
>> +        message = open(error_log_file).readlines()
>> +        label = "<b>Hob found an error</b>"
>> +        dialog = CrumbsMessageDialog(self, label, gtk.MESSAGE_ERROR, 
>> "".join(message))
>> +        button = dialog.add_button("Close", gtk.RESPONSE_OK)
>> +        HobButton.style_button(button)
>> +        button.connect("clicked", lambda w:sys.exit())
>> +        dialog.run()
>> +        dialog.destroy()
>> +
>> +if __name__ == "__main__":
>> +    HobError(sys.argv[1])
>> +
>> diff --git a/scripts/hob b/scripts/hob
>> index 8d33ab1..bbb2366 100755
>> --- a/scripts/hob
>> +++ b/scripts/hob
>> @@ -1,6 +1,13 @@
>>   #!/usr/bin/env bash
>>   export BB_ENV_EXTRAWHITE="DISABLE_SANITY_CHECKS $BB_ENV_EXTRAWHITE"
>> -DISABLE_SANITY_CHECKS=1 bitbake -u hob $@
>> +ERROR_LOG=$BUILDDIR/tmp/log/saved_errors.log
> Instead of $BUILDDIR/tmp you should use $TMPDIR
     I'll try to store the error log in /tmp (using mktemp, as Laurentiu 
suggested)
>> +DISABLE_SANITY_CHECKS=1 bitbake -u hob $@ > $ERROR_LOG
>>     ret=$?
>> +
>> +if (( $ret == 1 )); then #there is an error and hob didn't start
>> +    $BUILDDIR/../bitbake/lib/bb/ui/show_error_dialog $ERROR_LOG
> The path to show_error_dialog is hardcoded. For example, my poky 
> directory is somewhere else.
     I'll move show_error_dialog in scripts. Thank you for the comments.
>> +    rm $ERROR_LOG
>> +fi
>> +
>>   exit $ret
> Cristiana


--------------090307030000060005040104
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 09/27/2013 11:19 AM, cristiana.voicu
      wrote:<br>
    </div>
    <blockquote cite="mid:52453FA8.5040304@intel.com" type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div class="moz-text-flowed" style="font-family: -moz-fixed;
        font-size: 12px;" lang="x-western">Hi Valentin, <br>
        <br>
        I have some comments on this patch: <br>
        <br>
        On 09/25/2013 02:18 PM, Valentin Popa wrote: <br>
        <blockquote type="cite" style="color: #000000;">When the user
          starts HOB, he/she expects to see some GUI. <br>
          If bitbake signals an erros before HOB starts the error will <br>
          be visible only in console and hob script will terminate. <br>
          This patch allows bitbake to report errors inside a GUI dialog
          <br>
          when the user wants to use HOB. <br>
          WebHOB starts before bitbake's launch and&nbsp; a common solution <br>
          for this problem that applies to both HOB and WebHOB is not so
          obvious. <br>
          <br>
          Signed-off-by: Valentin Popa <a moz-do-not-send="true"
            class="moz-txt-link-rfc2396E"
            href="mailto:valentin.popa@intel.com">&lt;valentin.popa@intel.com&gt;</a>
          <br>
          --- <br>
          &nbsp; bitbake/lib/bb/ui/show_error_dialog | 62
          +++++++++++++++++++++++++++++++++++++ <br>
        </blockquote>
        The new file doesn't have the extension .py <br>
        <blockquote type="cite" style="color: #000000;">&nbsp;
          scripts/hob&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 +++++- <br>
          &nbsp; 2 files changed, 70 insertions(+), 1 deletion(-) <br>
          &nbsp; create mode 100755 bitbake/lib/bb/ui/show_error_dialog <br>
          <br>
          diff --git a/bitbake/lib/bb/ui/show_error_dialog
          b/bitbake/lib/bb/ui/show_error_dialog <br>
          new file mode 100755 <br>
          index 0000000..09d0c5c <br>
          --- /dev/null <br>
          +++ b/bitbake/lib/bb/ui/show_error_dialog <br>
          @@ -0,0 +1,62 @@ <br>
          +#!/usr/bin/env python <br>
          +# <br>
          +# BitBake graphical error reporting dialog used by hob script
          <br>
          +# <br>
          +# Copyright (C) 2013&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Intel Corporation <br>
          +# <br>
          +# Authored by Valentin Popa <a moz-do-not-send="true"
            class="moz-txt-link-rfc2396E"
            href="mailto:valentin.popa@lintel.com">&lt;valentin.popa@lintel.com&gt;</a>
          <br>
          +# Authored by Andrei Dinu <a moz-do-not-send="true"
            class="moz-txt-link-rfc2396E"
            href="mailto:andrei.adrianx.dinu@intel.com">&lt;andrei.adrianx.dinu@intel.com&gt;</a>
          <br>
          +# <br>
          +# This program is free software; you can redistribute it
          and/or modify <br>
          +# it under the terms of the GNU General Public License
          version 2 as <br>
          +# published by the Free Software Foundation. <br>
          +# <br>
          +# This program is distributed in the hope that it will be
          useful, <br>
          +# but WITHOUT ANY WARRANTY; without even the implied warranty
          of <br>
          +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See
          the <br>
          +# GNU General Public License for more details. <br>
          +# <br>
          +# You should have received a copy of the GNU General Public
          License along <br>
          +# with this program; if not, write to the Free Software
          Foundation, Inc., <br>
          +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
          <br>
          + <br>
          +import sys <br>
          +import os <br>
          +requirements = "FATAL: Gtk+ 2.20.0 or higher &amp; PyGtk
          2.21.0 or higher is required" <br>
          +try: <br>
          +&nbsp;&nbsp;&nbsp; import gtk <br>
          +&nbsp;&nbsp;&nbsp; import pygtk <br>
          +&nbsp;&nbsp;&nbsp; pygtk.require('2.0') # to be certain we don't have gtk+
          1.x !?! <br>
          +&nbsp;&nbsp;&nbsp; gtkver = gtk.gtk_version <br>
          +&nbsp;&nbsp;&nbsp; pygtkver = gtk.pygtk_version <br>
          +&nbsp;&nbsp;&nbsp; if gtkver&nbsp; &lt; (2, 20, 0) or pygtkver &lt; (2, 21, 0): <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." %
          (requirements, <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ".".join(map(str, gtkver)), <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ".".join(map(str, pygtkver)))) <br>
          +except ImportError as exc: <br>
          +&nbsp;&nbsp;&nbsp; sys.exit("%s (%s)." % (requirements, str(exc))) <br>
          + <br>
          +try: <br>
          +&nbsp;&nbsp;&nbsp; import crumbs <br>
          +except RuntimeError as exc: <br>
          +&nbsp;&nbsp;&nbsp; sys.exit(str(exc)) <br>
          +sys.path.insert(0,
          os.path.dirname(os.path.dirname(os.path.dirname(__file__)))) <br>
          + <br>
          +from crumbs.hig.crumbsmessagedialog import
          CrumbsMessageDialog <br>
          +from crumbs.hobwidget import HobButton <br>
          + <br>
          +class HobError(gtk.Window): <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; def __init__(self, error_log_file): <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message = open(error_log_file).readlines() <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label = "&lt;b&gt;Hob found an error&lt;/b&gt;" <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dialog = CrumbsMessageDialog(self, label,
          gtk.MESSAGE_ERROR, "".join(message)) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; button = dialog.add_button("Close", gtk.RESPONSE_OK)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HobButton.style_button(button) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; button.connect("clicked", lambda w:sys.exit()) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dialog.run() <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dialog.destroy() <br>
          + <br>
          +if __name__ == "__main__": <br>
          +&nbsp;&nbsp;&nbsp; HobError(sys.argv[1]) <br>
          + <br>
          diff --git a/scripts/hob b/scripts/hob <br>
          index 8d33ab1..bbb2366 100755 <br>
          --- a/scripts/hob <br>
          +++ b/scripts/hob <br>
          @@ -1,6 +1,13 @@ <br>
          &nbsp; #!/usr/bin/env bash <br>
          &nbsp; export BB_ENV_EXTRAWHITE="DISABLE_SANITY_CHECKS
          $BB_ENV_EXTRAWHITE" <br>
          -DISABLE_SANITY_CHECKS=1 bitbake -u hob $@ <br>
          +ERROR_LOG=$BUILDDIR/tmp/log/saved_errors.log <br>
        </blockquote>
        Instead of $BUILDDIR/tmp you should use $TMPDIR <br>
      </div>
    </blockquote>
    &nbsp;&nbsp;&nbsp; I'll try to store the error log in /tmp (using mktemp, as
    Laurentiu suggested)<br>
    <blockquote cite="mid:52453FA8.5040304@intel.com" type="cite">
      <div class="moz-text-flowed" style="font-family: -moz-fixed;
        font-size: 12px;" lang="x-western">
        <blockquote type="cite" style="color: #000000;">+DISABLE_SANITY_CHECKS=1

          bitbake -u hob $@ &gt; $ERROR_LOG <br>
          &nbsp; &nbsp; ret=$? <br>
          + <br>
          +if (( $ret == 1 )); then #there is an error and hob didn't
          start <br>
          +&nbsp;&nbsp;&nbsp; $BUILDDIR/../bitbake/lib/bb/ui/show_error_dialog
          $ERROR_LOG <br>
        </blockquote>
        The path to show_error_dialog is hardcoded. For example, my poky
        directory is somewhere else. <br>
      </div>
    </blockquote>
    &nbsp;&nbsp;&nbsp; I'll move show_error_dialog in scripts. Thank you for the
    comments.<br>
    <blockquote cite="mid:52453FA8.5040304@intel.com" type="cite">
      <div class="moz-text-flowed" style="font-family: -moz-fixed;
        font-size: 12px;" lang="x-western">
        <blockquote type="cite" style="color: #000000;">+&nbsp;&nbsp;&nbsp; rm
          $ERROR_LOG <br>
          +fi <br>
          + <br>
          &nbsp; exit $ret <br>
        </blockquote>
        Cristiana <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------090307030000060005040104--
