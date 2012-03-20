Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S9s6x-00005l-0y
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 06:59:59 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 19 Mar 2012 22:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="122770611"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 19 Mar 2012 22:51:05 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <99b9fe836c07c12a36a9944331f89bbba4d46280.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
	<99b9fe836c07c12a36a9944331f89bbba4d46280.1332202341.git.josh@linux.intel.com>
Date: Tue, 20 Mar 2012 13:49:01 +0800
Message-ID: <1332222541.1848.15.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/6] ui/crumbs/hobpage: no need to force a Toolbar button type
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
X-List-Received-Date: Tue, 20 Mar 2012 05:59:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-19 at 17:18 -0700, Joshua Lock wrote:
> This uses a more concise API that will be more flexible whent he Toolbar
> style is updated to match the visual design.
> 

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/crumbs/hobpages.py |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/hobpages.py b/lib/bb/ui/crumbs/hobpages.py
> index 8137c0d..baf250b 100755
> --- a/lib/bb/ui/crumbs/hobpages.py
> +++ b/lib/bb/ui/crumbs/hobpages.py
> @@ -81,7 +81,5 @@ class HobPage (gtk.VBox):
>          pix_buffer = gtk.gdk.pixbuf_new_from_file(icon_display)
>          icon.set_from_pixbuf(pix_buffer)
>          tip_text = tip
> -        button = toolbar.append_element(gtk.TOOLBAR_CHILD_RADIOBUTTON, None,
> -                     buttonname, tip_text, "Private text", icon,
> -                     cb, None)
> +        button = toolbar.append_item(buttonname, tip, None, icon, cb)
>          return button




