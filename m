Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id E9E7D60EA8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Sep 2013 07:28:36 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 30 Sep 2013 00:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1006,1371106800"; d="scan'208";a="301166670"
Received: from cvoicu-vostro-460.rb.intel.com (HELO [10.237.105.65])
	([10.237.105.65])
	by AZSMGA002.ch.intel.com with ESMTP; 30 Sep 2013 00:28:37 -0700
Message-ID: <52492928.8030900@intel.com>
Date: Mon, 30 Sep 2013 10:32:56 +0300
From: "cristiana.voicu" <cristiana.voicu@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130804 Thunderbird/17.0.8
MIME-Version: 1.0
To: Valentin Popa <valentin.popa@intel.com>
References: <1380280646-11708-1-git-send-email-valentin.popa@intel.com>
In-Reply-To: <1380280646-11708-1-git-send-email-valentin.popa@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH_V2] GUI error dialog for bitbake
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
X-List-Received-Date: Mon, 30 Sep 2013 07:28:38 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/27/2013 02:17 PM, Valentin Popa wrote:
> When the user starts HOB, he/she expects to see some GUI.
> If bitbake signals an erros before HOB starts the error will
> be visible only in console and hob script will terminate.
> This patch allows bitbake to report errors inside a GUI dialog
> when the user wants to use HOB.
> WebHOB starts before bitbake's launch and  a common solution
> for this problem that applies to both HOB and WebHOB is not so obvious.
>
> Signed-off-by: Valentin Popa <valentin.popa@intel.com>
> ---
>   scripts/hob               |  9 ++++++-
>   scripts/show_error_dialog | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 71 insertions(+), 1 deletion(-)
>   create mode 100755 scripts/show_error_dialog
>
> diff --git a/scripts/hob b/scripts/hob
> index 8d33ab1..406765f 100755
> --- a/scripts/hob
> +++ b/scripts/hob
> @@ -1,6 +1,13 @@
>   #!/usr/bin/env bash
>   export BB_ENV_EXTRAWHITE="DISABLE_SANITY_CHECKS $BB_ENV_EXTRAWHITE"
> -DISABLE_SANITY_CHECKS=1 bitbake -u hob $@
> +SAVED_ERRORS="$(mktemp)"
> +DISABLE_SANITY_CHECKS=1 bitbake -u hob $@ > $SAVED_ERRORS
>   
>   ret=$?
> +
> +if (( $ret == 1 )); then #there is an error and hob didn't start
> +    show_error_dialog $SAVED_ERRORS
> +fi
> +rm $SAVED_ERRORS
> +
>   exit $ret
> diff --git a/scripts/show_error_dialog b/scripts/show_error_dialog
> new file mode 100755
> index 0000000..beb7cb3
> --- /dev/null
> +++ b/scripts/show_error_dialog
> @@ -0,0 +1,63 @@
> +#!/usr/bin/env python
> +#
> +# BitBake graphical error reporting dialog used by hob script
> +#
> +# Copyright (C) 2013        Intel Corporation
> +#
> +# Authored by Valentin Popa <valentin.popa@lintel.com>
> +# Authored by Andrei Dinu <andrei.adrianx.dinu@intel.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +import sys
> +import os
> +requirements = "FATAL: Gtk+ 2.20.0 or higher & PyGtk 2.21.0 or higher is required"
> +try:
> +    import gtk
> +    import pygtk
> +    pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
> +    gtkver = gtk.gtk_version
> +    pygtkver = gtk.pygtk_version
> +    if gtkver  < (2, 20, 0) or pygtkver < (2, 21, 0):
> +        sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." % (requirements,
> +                ".".join(map(str, gtkver)),
> +                ".".join(map(str, pygtkver))))
> +except ImportError as exc:
> +    sys.exit("%s (%s)." % (requirements, str(exc)))
> +
> +sys.path.insert(0, os.path.dirname(os.path.dirname(__file__))+"/bitbake/lib")
> +
> +try:
> +    import bb
> +except RuntimeError as exc:
> +    sys.exit(str(exc))
> +
> +from bb.ui.crumbs.hig.crumbsmessagedialog import CrumbsMessageDialog
> +from bb.ui.crumbs.hobwidget import HobButton
> +
> +class HobError(gtk.Window):
> +
> +    def __init__(self, error_log_file):
> +        message = open(error_log_file).readlines()
> +        label = "<b>Hob found an error</b>"
> +        dialog = CrumbsMessageDialog(self, label, gtk.MESSAGE_ERROR, "".join(message))
> +        button = dialog.add_button("Close", gtk.RESPONSE_OK)
> +        HobButton.style_button(button)
> +        button.connect("clicked", lambda w:sys.exit())
> +        dialog.run()
> +        dialog.destroy()
> +
> +if __name__ == "__main__":
> +    HobError(sys.argv[1])
> +
This is OK now. Just to inform, this patch is depending on the [PATCH 
1/2] HOB: HIG compliant message dialogs, in order to work.
Cristiana

