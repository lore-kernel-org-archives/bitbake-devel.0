Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rBo-00039o-Mh
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:36:01 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112978837"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:27:30 -0800
Message-ID: <4F4E9842.8080604@linux.intel.com>
Date: Wed, 29 Feb 2012 13:27:30 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<ae624884c7f563ab23e901900659676f2112cc43.1330523904.git.shane.wang@intel.com>
In-Reply-To: <ae624884c7f563ab23e901900659676f2112cc43.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 05/32] Hob: include hddimg and iso into image types.
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
X-List-Received-Date: Wed, 29 Feb 2012 21:36:01 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 29/02/12 06:15, Shane Wang wrote:
> For image types, so far we don't include hddimg and iso. Then those files can not be deployed because they are filtered out in the image selection dialog.
> This patch is to include hddimg and iso (which are "live" in image types).
>
> Again, we have a TODO in the code for the future, that is to retrieve image types from the bitbake server instead of to use the walkaround.
>
> Signed-off-by: Shane Wang<shane.wang@intel.com>

Could use a more useful comment in the code, see below, but other than that:

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/builder.py         |    4 ++--
>   bitbake/lib/bb/ui/crumbs/hig.py             |    9 +++++----
>   bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    9 ++++-----
>   bitbake/lib/bb/ui/crumbs/hobwidget.py       |   27 +++++++++++++++++++++++++++
>   4 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 0071673..eb38819 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -758,8 +758,8 @@ class Builder(gtk.Window):
>               flags = gtk.DIALOG_MODAL
>                       | gtk.DIALOG_DESTROY_WITH_PARENT
>                       | gtk.DIALOG_NO_SEPARATOR,
> -            buttons = ("Close", gtk.RESPONSE_NO,
> -                       "Make usb image", gtk.RESPONSE_YES))
> +            buttons = ("Make usb image", gtk.RESPONSE_YES,
> +                       "Close", gtk.RESPONSE_NO))
>           response = dialog.run()
>           dialog.destroy()
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
> index 74f4f7b..cbad899 100644
> --- a/bitbake/lib/bb/ui/crumbs/hig.py
> +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> @@ -28,7 +28,7 @@ import re
>   import subprocess
>   import shlex
>   from bb.ui.crumbs.hobcolor import HobColors
> -from bb.ui.crumbs.hobwidget import HobViewTable
> +from bb.ui.crumbs.hobwidget import hcc, HobViewTable
>   from bb.ui.crumbs.progressbar import HobProgressBar
>
>   """
> @@ -1083,9 +1083,10 @@ class ImageSelectionDialog (gtk.Dialog):
>               dirs[:] = []
>               for f in files:
>                   for image_type in self.image_types:
> -                    if f.endswith('.' + image_type):
> -                        imageset.add(f.rsplit('.' + image_type)[0])
> -                        self.image_list.append(f)
> +                    for real_image_type in hcc.SUPPORTED_IMAGE_TYPES[image_type]:
> +                        if f.endswith('.' + real_image_type):
> +                            imageset.add(f.rsplit('.' + real_image_type)[0])
> +                            self.image_list.append(f)
>
>           for image in imageset:
>               self.image_store.set(self.image_store.append(), 0, image, 1, False)
> diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> index b071ad4..2bf4ed8 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
> @@ -22,6 +22,7 @@
>   import gobject
>   import logging
>   from bb.ui.crumbs.runningbuild import RunningBuild
> +from bb.ui.crumbs.hobwidget import hcc
>
>   class HobHandler(gobject.GObject):
>
> @@ -450,10 +451,8 @@ class HobHandler(gobject.GObject):
>           params["incompat_license"] = self.server.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"]) or ""
>           params["sdk_machine"] = self.server.runCommand(["getVariable", "SDKMACHINE"]) or self.server.runCommand(["getVariable", "SDK_ARCH"]) or ""
>
> -        #params["image_types"] = self.server.runCommand(["getVariable", "IMAGE_TYPES"]) or ""
>           params["image_fstypes"] = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]) or ""
> -        """
> -        A workaround
> -        """
> -        params["image_types"] = "jffs2 sum.jffs2 cramfs ext2 ext2.gz ext2.bz2 ext3 ext3.gz ext2.lzma btrfs live squashfs squashfs-lzma ubi tar tar.gz tar.bz2 tar.xz cpio cpio.gz cpio.xz cpio.lzma"
> +
> +        # walkaround

It's nice that you point this out but you don't really tell us what 
you're working around.

> +        params["image_types"] = " ".join(hcc.SUPPORTED_IMAGE_TYPES.keys()).lstrip(" ")
>           return params
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index 664bf25..9afbfdb 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -50,6 +50,33 @@ class hic:
>       ICON_INDI_CONFIRM_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/confirmation.png'))
>       ICON_INDI_ERROR_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/error.png'))
>
> +class hcc:
> +
> +    SUPPORTED_IMAGE_TYPES = {
> +        "jffs2"         : ["jffs2"],
> +        "sum.jffs2"     : ["sum.jffs2"],
> +        "cramfs"        : ["cramfs"],
> +        "ext2"          : ["ext2"],
> +        "ext2.gz"       : ["ext2.gz"],
> +        "ext2.bz2"      : ["ext2.bz2"],
> +        "ext3"          : ["ext3"],
> +        "ext3.gz"       : ["ext3.gz"],
> +        "ext2.lzma"     : ["ext2.lzma"],
> +        "btrfs"         : ["btrfs"],
> +        "live"          : ["hddimg", "iso"],
> +        "squashfs"      : ["squashfs"],
> +        "squashfs-lzma" : ["squashfs-lzma"],
> +        "ubi"           : ["ubi"],
> +        "tar"           : ["tar"],
> +        "tar.gz"        : ["tar.gz"],
> +        "tar.bz2"       : ["tar.bz2"],
> +        "tar.xz"        : ["tar.xz"],
> +        "cpio"          : ["cpio"],
> +        "cpio.gz"       : ["cpio.gz"],
> +        "cpio.xz"       : ["cpio.xz"],
> +        "cpio.lzma"     : ["cpio.lzma"],
> +    }
> +
>   class HobViewTable (gtk.VBox):
>       """
>       A VBox to contain the table for different recipe views and package view

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


