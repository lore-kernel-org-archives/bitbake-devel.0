Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S9sGl-0000ZN-Nj
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 07:10:07 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 19 Mar 2012 23:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119384047"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 19 Mar 2012 23:01:14 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <82586a6a712fb5413e3f8698f6e0794c45676144.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
	<82586a6a712fb5413e3f8698f6e0794c45676144.1332202341.git.josh@linux.intel.com>
Date: Tue, 20 Mar 2012 13:59:09 +0800
Message-ID: <1332223149.1848.16.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/6] ui/crumbs/persistenttooltip: try to reflect WM close button position
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
X-List-Received-Date: Tue, 20 Mar 2012 06:10:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-19 at 17:18 -0700, Joshua Lock wrote:
> When the user is running a desktop where the close button is on the left we
> try to detect that and position the tooltip close button appropriately.
> Where we can't easily determine this we default to placing the close button
> on the right.
> 
> Tested on Ubuntu/Unity and Fedora/Gnome Shell.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/persistenttooltip.py |   24 +++++++++++++++++++++++-
>  1 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
> index 0167363..bae697e 100644
> --- a/lib/bb/ui/crumbs/persistenttooltip.py
> +++ b/lib/bb/ui/crumbs/persistenttooltip.py
> @@ -20,6 +20,10 @@
>  
>  import gobject
>  import gtk
> +try:
> +    import gconf
> +except:
> +    pass
>  
>  class PersistentTooltip(gtk.Window):
>  	"""
> @@ -34,6 +38,21 @@ class PersistentTooltip(gtk.Window):
>  	def __init__(self, markup):
>  		gtk.Window.__init__(self, gtk.WINDOW_POPUP)
>  
> +		# The placement of the close button on the tip should reflect how the
> +		# window manager of the users system places close buttons. Try to read
> +		# the metacity gconf key to determine whether the close button is on the
> +		# left or the right.
> +		# In the case that we can't determine the users configuration we default
> +		# to close buttons being on the right.
> +		__button_right = True
> +		try:
> +		    client = gconf.client_get_default()
> +		    order = client.get_string("/apps/metacity/general/button_layout")
> +		    if order and order.endswith(":"):
> +		        __button_right = False
> +		except NameError:
> +			pass
> +
>  		# We need to ensure we're only shown once
>  		self.shown = False
>  
> @@ -65,7 +84,10 @@ class PersistentTooltip(gtk.Window):
>  		self.button.set_can_default(True)
>  		self.button.grab_focus()
>  		self.button.show()
> -		hbox.pack_end(self.button, False, False, 0)
> +		if __button_right:
> +		    hbox.pack_end(self.button, False, False, 0)
> +		else:
> +		    hbox.pack_start(self.button, False, False, 0)
>  
>  		self.set_default(self.button)
>  




