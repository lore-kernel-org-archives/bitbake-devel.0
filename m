Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBF5I-0001ZN-2u
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:43:56 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2012 17:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121098687"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:34:58 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <06186ae494fd5e84bbf27e07f45bcaed9e6fbdd6.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<06186ae494fd5e84bbf27e07f45bcaed9e6fbdd6.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 08:32:47 +0800
Message-ID: <1332549167.1849.13.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/9] lib/bb/ui/crumbs/builddetailspage: fix label on 'Back' button
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
X-List-Received-Date: Sat, 24 Mar 2012 00:43:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> The buttons taking the user back to image configuration should be prefixed
> with '<<'.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/builddetailspage.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
> index 5f1524f..59d5525 100755
> --- a/lib/bb/ui/crumbs/builddetailspage.py
> +++ b/lib/bb/ui/crumbs/builddetailspage.py
> @@ -80,7 +80,7 @@ class BuildDetailsPage (HobPage):
>          self.builder.handler.build.model.connect_after("row-changed", self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(), self.build_tv)
>  
>          self.button_box = gtk.HBox(False, 6)
> -        self.back_button = HobAltButton("Back to image configuration")
> +        self.back_button = HobAltButton("<< Back to image configuration")
>          self.back_button.connect("clicked", self.back_button_clicked_cb)
>          self.button_box.pack_start(self.back_button, expand=False, fill=False)
>  




