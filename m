Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBFYt-0002H4-4x
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 02:14:31 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Mar 2012 18:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132600630"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2012 18:05:33 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <1610b4255cfc036137dfe731499105569399156c.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<1610b4255cfc036137dfe731499105569399156c.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 09:03:22 +0800
Message-ID: <1332551002.1849.18.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 6/9] lib/bb/ui/crumbs/persistenttooltip: layout tweaks
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
X-List-Received-Date: Sat, 24 Mar 2012 01:14:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> The design documents have the close button vertically aligned with the
> tooltip contents - reorganise the interal widget layout to achieve this.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/persistenttooltip.py |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
> index 8ba0043..e184062 100644
> --- a/lib/bb/ui/crumbs/persistenttooltip.py
> +++ b/lib/bb/ui/crumbs/persistenttooltip.py
> @@ -76,9 +76,7 @@ class PersistentTooltip(gtk.Window):
>          # Draw our label and close buttons
>          hbox = gtk.HBox(False, 0)
>          hbox.show()
> -        vbox = gtk.VBox(False, 0)
> -        vbox.show()
> -        vbox.pack_start(hbox, True, True, 0)
> +        self.add(hbox)
>  
>          img = gtk.Image()
>          img.set_from_stock(gtk.STOCK_CLOSE, gtk.ICON_SIZE_BUTTON)
> @@ -89,18 +87,21 @@ class PersistentTooltip(gtk.Window):
>          self.button.set_can_default(True)
>          self.button.grab_focus()
>          self.button.show()
> +        vbox = gtk.VBox(False, 0)
> +        vbox.show()
> +        vbox.pack_start(self.button, False, False, 0)
>          if __button_right:
> -            hbox.pack_end(self.button, False, False, 0)
> +            hbox.pack_end(vbox, True, True, 0)
>          else:
> -            hbox.pack_start(self.button, False, False, 0)
> +            hbox.pack_start(vbox, True, True, 0)
>  
>          self.set_default(self.button)
>  
> -        hbox = gtk.HBox(True, 6)
> -        hbox.set_border_width(6)
> -        hbox.show()
> -        vbox.pack_end(hbox, True, True, 6)
> +        bin = gtk.HBox(True, 6)
> +        bin.set_border_width(6)
> +        bin.show()
>          self.label = gtk.Label()
> +        self.label.set_line_wrap(True)
>          # We want to match the colours of the normal tooltips, as dictated by
>          # the users gtk+-2.0 theme, wherever possible - on some systems this
>          # requires explicitly setting a fg_color for the label which matches the
> @@ -119,12 +120,11 @@ class PersistentTooltip(gtk.Window):
>                  break # we only care for the tooltip_fg_color
>          self.label.set_markup(markup)
>          self.label.show()
> -        hbox.pack_end(self.label, True, True, 6)
> +        bin.add(self.label)
> +        hbox.pack_end(bin, True, True, 6)
>  
>          self.connect("key-press-event", self._catch_esc_cb)
>  
> -        self.add(vbox)
> -
>      """
>      Callback when the PersistentTooltip's close button is clicked.
>      Hides the PersistentTooltip.




