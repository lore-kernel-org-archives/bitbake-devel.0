Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1SbyAU-0001OV-CV
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 20:07:46 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 05 Jun 2012 10:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="161361560"
Received: from unknown (HELO envy.home) ([10.255.12.60])
	by fmsmga001.fm.intel.com with ESMTP; 05 Jun 2012 10:56:13 -0700
Message-ID: <4FCE47F8.6000307@linux.intel.com>
Date: Tue, 05 Jun 2012 10:55:04 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Kang Kai <kai.kang@windriver.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
In-Reply-To: <df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
X-Enigmail-Version: 1.4.1
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: Re: [PATCH 2/2] hob2: create a standalone deploy image tool
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 05 Jun 2012 18:07:46 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 06/04/2012 08:37 PM, Kang Kai wrote:
> [Yocto 2388]
> 
> Create a standalone deploy image tool using the existing dialog
> including DeployImageDialog and ImageSelectionDialog.
> 
> Duplicate the gtk and pygtk versions check in the hob.py because this
> will be run separately.
> 
> Update ui/crumbs/utils.py that it needs to 'import bb' when run this
> tool.

Should be a separate patch as it's independent of the image writer.

> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/bin/bitbake-deployimage   |  135 +++++++++++++++++++++++++++++++++++++
>  bitbake/lib/bb/ui/crumbs/utils.py |    1 +
>  2 files changed, 136 insertions(+), 0 deletions(-)
>  create mode 100755 bitbake/bin/bitbake-deployimage
> 
> diff --git a/bitbake/bin/bitbake-deployimage b/bitbake/bin/bitbake-deployimage
> new file mode 100755
> index 0000000..8fdd21b
> --- /dev/null
> +++ b/bitbake/bin/bitbake-deployimage

A shorter name might be appropriate. Since this really doesn't involve
bitbake, maye we can drop that from the name? I would also suggest
avoiding the term "deploy" as it has a very specific meaning for
bitbake. Consider:

write-image
gddimage
hob-image
hob-dd

I don't love any of these, just thinking out loud.


> @@ -0,0 +1,135 @@
> +#!/usr/bin/python

This should be:

#!/usr/bin/env python



> +
> +# Copyright (c) 2012 Wind River Systems, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +# See the GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> +
> +import os
> +import sys
> +import optparse
> +
> +requirements = "FATAL: Gtk+ 2.20.0 or higher, PyGtk version 2.22.0 or higher and PyGobject are required to use Hob"

But this isn't Hob, right? What is required to run just this script? I
think the requirements check is a good idea, but let's not unnecessarily
fail to run with overly strict requirement.s

> +try:
> +    import gtk
> +    import pygtk
> +
> +    pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
> +    gtkver = gtk.gtk_version
> +    pygtkver = gtk.pygtk_version
> +    if gtkver  < (2, 20, 0) or pygtkver < (2, 22, 0):
> +        sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." % (requirements,
> +                    ".".join(map(str, gtkver)),
> +                    ".".join(map(str, pygtkver))))
> +
> +except ImportError as exc:
> +    sys.exit("%s (%s)." % (requirements, str(exc)))
> +
> +sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname( \
> +                                    os.path.abspath(__file__))), 'lib'))
> +try:
> +    import bb
> +except RuntimeError as exc:
> +    sys.exit(str(exc))
> +
> +from bb.ui.crumbs.hig import DeployImageDialog, ImageSelectionDialog, CrumbsMessageDialog
> +from bb.ui.crumbs.hobwidget import HobAltButton, HobButton
> +
> +# I put all the fs bitbake supported here. Need more test.
> +DEPLOYABLE_IMAGE_TYPES = ["jffs2", "cramfs", "ext2", "ext3", "btrfs", "squashfs", "ubi", "vmdk"]
> +Title = "Usb Image Maker"

s/Usb/USB/

Probably shouldn't be USB only in the future.

> +
> +class DeployWindow(gtk.Window):
> +    def __init__(self, image_path=''):
> +        super(DeployWindow, self).__init__()
> +
> +        if len(image_path) > 0:
> +            valid = True
> +            if not os.path.exists(image_path):
> +                valid = False
> +                lbl = "<b>Invalid image file path</b>\nYou could use <b>Select Image</b> button to select image"

Missing punctuation and articles:

"<b>Invalid image file path.</b>\nYou can use the <b>Select Image</b>
button to select an image."

Or

"<b>Invalid image file path: %s.</b>\nPress <b>Select Image</b> to
select an image." % (image_path)


> +            else:
> +                image_path = os.path.abspath(image_path)
> +                extend_name = os.path.splitext(image_path)[1][1:]
> +                if extend_name not in DEPLOYABLE_IMAGE_TYPES:
> +                    valid = False
> +                    lbl = "<b>Undeployable imge</b>\nYou could use <b>Select Image</b> button to select image"

Typo, missing articles and punctuation. Consider:

"<b>Undeployable image type: %s</b>\nPress <b>Select Image</b> to select
an image." % (extend_name)

> +
> +            if not valid:
> +                image_path = ''
> +                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> +                button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
> +                HobButton.style_button(button)
> +                crumbs_dialog.run()
> +                crumbs_dialog.destroy()
> +
> +        self.deploy_dialog = DeployImageDialog(Title, image_path, self,
> +                                        gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT
> +                                        | gtk.DIALOG_NO_SEPARATOR, None, singleton=True)

Are you creating a proper singleton, or is this just used to indicate
"stand alone" ? Just curious as singleton's are quite difficult to do
properly in Python.

> +        close_button = self.deploy_dialog.add_button("Close", gtk.RESPONSE_NO)
> +        HobAltButton.style_button(close_button)
> +        close_button.connect('clicked', gtk.main_quit)
> +
> +        make_button = self.deploy_dialog.add_button("Make USB image", gtk.RESPONSE_YES)
> +        HobAltButton.style_button(make_button)
> +
> +        self.deploy_dialog.connect('select_image_clicked', self.select_image_clicked_cb)
> +        self.deploy_dialog.connect('destroy', gtk.main_quit)
> +        response = self.deploy_dialog.show()
> +
> +    def select_image_clicked_cb(self, dialog):
> +        cwd = os.getcwd()
> +        dialog = ImageSelectionDialog(cwd, DEPLOYABLE_IMAGE_TYPES, Title, self, gtk.FILE_CHOOSER_ACTION_SAVE )
> +        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
> +        HobAltButton.style_button(button)
> +        button = dialog.add_button("Open", gtk.RESPONSE_YES)
> +        HobAltButton.style_button(button)
> +        response = dialog.run()
> +
> +        if response == gtk.RESPONSE_YES:
> +            if not dialog.image_names:
> +                lbl = "<b>No selections made</b>\nYou have not made any selections"

This string is a bit redundant. The other strings in the app give
instructions to resolve the failure, should this as well?

> +                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
> +                button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
> +                HobButton.style_button(button)
> +                crumbs_dialog.run()
> +                crumbs_dialog.destroy()
> +                dialog.destroy()
> +                return
> +
> +            # get the full path of image
> +            image_path = os.path.join(dialog.image_folder, dialog.image_names[0])
> +            self.deploy_dialog.set_image_text_buffer(image_path)
> +            self.deploy_dialog.set_image_path(image_path)
> +
> +        dialog.destroy()
> +
> +def main():
> +    parser = optparse.OptionParser(
> +                usage = """%prog [-h] [image_file]
> +
> +This deploy image tool try to deploy the bitbake images to USB devices.
> +You could provides the image file from command line or select it use the
> +GUI tool.""")

bitbake-deployimage writes bootable images to USB devices. You can
provide the image file on the command line or select it using the GUI.

> +
> +    options, args = parser.parse_args(sys.argv)
> +    image_file = args[1] if len(args) > 1 else ''
> +    dw = DeployWindow(image_file)
> +
> +if __name__ == '__main__':
> +    try:
> +        main()
> +        gtk.main()
> +    except Exception:
> +        import traceback
> +        traceback.print_exc(3)
> diff --git a/bitbake/lib/bb/ui/crumbs/utils.py b/bitbake/lib/bb/ui/crumbs/utils.py
> index cd01a04..939864f 100644
> --- a/bitbake/lib/bb/ui/crumbs/utils.py
> +++ b/bitbake/lib/bb/ui/crumbs/utils.py
> @@ -22,6 +22,7 @@
>  # bitbake which will allow more flexibility.
>  
>  import os
> +import bb

separate patch.

>  
>  def which_terminal():
>      term = bb.utils.which(os.environ["PATH"], "xterm")

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


