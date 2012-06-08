Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Sd0uF-0001LZ-Gf
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 17:15:20 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 08 Jun 2012 08:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="153565659"
Received: from unknown (HELO envy.home) ([10.255.12.197])
	by azsmga001.ch.intel.com with ESMTP; 08 Jun 2012 08:04:28 -0700
Message-ID: <4FD21435.7020001@linux.intel.com>
Date: Fri, 08 Jun 2012 08:03:17 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: Kang Kai <kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
	<d9ee1c96083aa60e2251e1fca5f8fa7f46ff2b76.1338976258.git.kai.kang@windriver.com>
In-Reply-To: <d9ee1c96083aa60e2251e1fca5f8fa7f46ff2b76.1338976258.git.kai.kang@windriver.com>
X-Enigmail-Version: 1.4.2
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: Re: [PATCH 6/6] hob2: create a standalone deploy image tool
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
X-List-Received-Date: Fri, 08 Jun 2012 15:15:20 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 06/06/2012 02:52 AM, Kang Kai wrote:
> [Yocto 2388]
> 
> Create a deploy image tool using the existing dialog including
> DeployImageDialog and ImageSelectionDialog.
> 
> This tool writes bootable images to USB devices, and it can be run
> directly without hob.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  bitbake/bin/image-writer |  120 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 120 insertions(+), 0 deletions(-)
>  create mode 100755 bitbake/bin/image-writer
> 
> diff --git a/bitbake/bin/image-writer b/bitbake/bin/image-writer
> new file mode 100755
> index 0000000..3f9f5c1
> --- /dev/null
> +++ b/bitbake/bin/image-writer
> @@ -0,0 +1,120 @@
> +#!/usr/bin/env python
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
> +sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname( \
> +                                    os.path.abspath(__file__))), 'lib'))
> +try:
> +    import bb
> +except RuntimeError as exc:
> +    sys.exit(str(exc))
> +
> +import gtk
> +import optparse
> +import pygtk
> +
> +from bb.ui.crumbs.hig import DeployImageDialog, ImageSelectionDialog, CrumbsMessageDialog
> +from bb.ui.crumbs.hobwidget import HobAltButton, HobButton
> +
> +# I put all the fs bitbake supported here. Need more test.
> +DEPLOYABLE_IMAGE_TYPES = ["jffs2", "cramfs", "ext2", "ext3", "btrfs", "squashfs", "ubi", "vmdk"]
> +Title = "USB Image Maker"

Writer is probably a more apt name than Maker.

> +
> +class DeployWindow(gtk.Window):
> +    def __init__(self, image_path=''):
> +        super(DeployWindow, self).__init__()
> +
> +        if len(image_path) > 0:
> +            valid = True
> +            if not os.path.exists(image_path):
> +                valid = False
> +                lbl = "<b>Invalid image file path: %s.</b>\nPress <b>Select Image</b> button to select an image." % image_path

I commented on this text in the last review. If you are going to leave
the word "button" in there, then you need an article prior to "Select
Image" (the). I would recommend using "Select Image" as a proper noun,
and drop the term "button".

> +            else:
> +                image_path = os.path.abspath(image_path)
> +                extend_name = os.path.splitext(image_path)[1][1:]
> +                if extend_name not in DEPLOYABLE_IMAGE_TYPES:
> +                    valid = False
> +                    lbl = "<b>Undeployable imge type: %s</b>\nPress <b>Select Image</b> button to select an image." % extend_name

Same here.

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
> +                                        | gtk.DIALOG_NO_SEPARATOR, None, standalone=True)
> +        close_button = self.deploy_dialog.add_button("Close", gtk.RESPONSE_NO)
> +        HobAltButton.style_button(close_button)
> +        close_button.connect('clicked', gtk.main_quit)
> +
> +        make_button = self.deploy_dialog.add_button("Make USB image", gtk.RESPONSE_YES)

"Write" is probably more descriptive than "Make"

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
> +                lbl = "<b>No selections made</b>\nClicked the radio button to select a image."
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
> +%prog writes bootable images to USB devices. You can
> +provide the image file on the command line or select it using the GUI.""")
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

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


