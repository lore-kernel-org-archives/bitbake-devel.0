Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBF0B-0001UH-IC
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:38:39 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2012 17:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132593419"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2012 17:29:41 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <45f156daf8e6423f035a1d8bb3450b149d3096f0.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<45f156daf8e6423f035a1d8bb3450b149d3096f0.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 08:27:30 +0800
Message-ID: <1332548850.1849.7.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/9] lib/bb/ui/crumbs/hobwidget: HobAltButton different visual when insensitive
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
X-List-Received-Date: Sat, 24 Mar 2012 00:38:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> Use an alternative, grey, colour when the button is insensitive so that
> the insensitivity is easily noticed.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/hobwidget.py |   27 +++++++++++++++++++++++++--
>  1 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
> index 020c5e2..6b8fc1b 100644
> --- a/lib/bb/ui/crumbs/hobwidget.py
> +++ b/lib/bb/ui/crumbs/hobwidget.py
> @@ -221,9 +221,32 @@ class HobAltButton(gtk.Button):
>      A gtk.Button subclass which has no relief, and so is more discrete
>      """
>      def __init__(self, label):
> -        gtk.Button.__init__(self, "<span color='%s'><b>%s</b></span>" % (HobColors.PALE_BLUE, gobject.markup_escape_text(label)))
> -        self.child.set_use_markup(True)
> +        gtk.Button.__init__(self)
> +        self.text = label
> +        self.set_text()
>          self.set_relief(gtk.RELIEF_NONE)
> +        self.connect("state-changed", self.desensitise_on_state_change_cb)
> +
> +    """
> +    A callback for the state-changed event to ensure the text is displayed
> +    differently when the widget is not sensitive
> +    """
> +    def desensitise_on_state_change_cb(self, widget, state):
> +        if widget.get_state() == gtk.STATE_INSENSITIVE:
> +            self.set_text(False)
> +        else:
> +            self.set_text(True)
> +
> +    """
> +    Set the button label with an appropriate colour for the current widget state
> +    """
> +    def set_text(self, sensitive=True):
> +        if sensitive:
> +            colour = HobColors.PALE_BLUE
> +        else:
> +            colour = HobColors.LIGHT_GRAY
> +        self.set_label("<span color='%s'><b>%s</b></span>" % (colour, gobject.markup_escape_text(self.text)))
> +        self.child.set_use_markup(True)
>  
>  class HobImageButton(gtk.Button):
>      """




