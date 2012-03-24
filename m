Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBFaM-0002KQ-MH
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 02:16:02 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 23 Mar 2012 18:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="122663532"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 23 Mar 2012 18:07:04 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4ff611f179da4d3c8953222c053d9cce62505277.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<4ff611f179da4d3c8953222c053d9cce62505277.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 09:04:54 +0800
Message-ID: <1332551094.1849.20.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 8/9] lib/bb/ui/crumbs: use a PersistentTooltip for the Brought in by information
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
X-List-Received-Date: Sat, 24 Mar 2012 01:16:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/builder.py |   12 +++++++-----
>  lib/bb/ui/crumbs/hig.py     |   23 -----------------------
>  2 files changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> index 2fe67d9..4eb374c 100755
> --- a/lib/bb/ui/crumbs/builder.py
> +++ b/lib/bb/ui/crumbs/builder.py
> @@ -33,9 +33,10 @@ from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
>  from bb.ui.crumbs.builddetailspage import BuildDetailsPage
>  from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
>  from bb.ui.crumbs.hobwidget import hwc
> -from bb.ui.crumbs.hig import CrumbsMessageDialog, BinbDialog, \
> +from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
>                               AdvancedSettingDialog, LayerSelectionDialog, \
> -                             DeployImageDialog, ImageSelectionDialog
> +                             DeployImageDialog
> +from bb.ui.crumbs.persistenttooltip import PersistentTooltip
>  
>  class Configuration:
>      '''Represents the data structure of configuration.'''
> @@ -659,9 +660,10 @@ class Builder(gtk.Window):
>          self.switch_page(self.FAST_IMAGE_GENERATING)
>  
>      def show_binb_dialog(self, binb):
> -        binb_dialog = BinbDialog("Brought in by:", binb, self)
> -        binb_dialog.run()
> -        binb_dialog.destroy()
> +        markup = "<b>Brought in by:</b>\n%s" % binb
> +        ptip = PersistentTooltip(markup)
> +
> +        ptip.show()
>  
>      def show_layer_selection_dialog(self):
>          dialog = LayerSelectionDialog(title = "Layers",
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index 3a66e7c..6ae682b 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -92,29 +92,6 @@ class CrumbsMessageDialog(CrumbsDialog):
>          first_row.add(self.label)
>  
>  #
> -# Brought-in-by Dialog
> -#
> -class BinbDialog(CrumbsDialog):
> -    """
> -    A dialog widget to show "brought in by" info when a recipe/package is clicked.
> -    """
> -
> -    def __init__(self, title, content, parent=None):
> -        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, ("Close", gtk.RESPONSE_CLOSE))
> -
> -        self.set_position(gtk.WIN_POS_MOUSE)
> -        self.set_resizable(False)
> -        self.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.DARK))
> -
> -        label = gtk.Label(content)
> -        label.set_alignment(0, 0)
> -        label.set_line_wrap(True)
> -        label.modify_fg(gtk.STATE_NORMAL, gtk.gdk.Color(HobColors.WHITE))
> -
> -        self.vbox.pack_start(label, expand=True, fill=True, padding=10)
> -        self.vbox.show_all()
> -
> -#
>  # AdvancedSettings Dialog
>  #
>  class AdvancedSettingDialog (CrumbsDialog):




