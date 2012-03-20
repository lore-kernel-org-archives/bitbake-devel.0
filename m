Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S9sLc-0000fA-Md
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 07:15:08 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 19 Mar 2012 23:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120934932"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 19 Mar 2012 23:06:14 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "Barros Pena, Belen"
	<belen.barros.pena@intel.com>, Giulia Piu <giulia@closertag.com>
In-Reply-To: <4efa2980aa09953bf53ab4da08a0ad50000d4da0.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
	<4efa2980aa09953bf53ab4da08a0ad50000d4da0.1332202341.git.josh@linux.intel.com>
Date: Tue, 20 Mar 2012 14:04:10 +0800
Message-ID: <1332223450.1848.19.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 5/6] ui/crumbs/builder: remove OK/Cancel buttons on Layer dialog. Use Close.
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
X-List-Received-Date: Tue, 20 Mar 2012 06:15:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-19 at 17:18 -0700, Joshua Lock wrote:
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/crumbs/builder.py |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> index 1d255ac..9e85e72 100755
> --- a/lib/bb/ui/crumbs/builder.py
> +++ b/lib/bb/ui/crumbs/builder.py
> @@ -668,8 +668,7 @@ class Builder(gtk.Window):
>                       flags = gtk.DIALOG_MODAL
>                           | gtk.DIALOG_DESTROY_WITH_PARENT
>                           | gtk.DIALOG_NO_SEPARATOR,
> -                     buttons = (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
> -                                gtk.STOCK_OK, gtk.RESPONSE_YES))
> +                     buttons = (gtk.STOCK_CLOSE, gtk.RESPONSE_YES))

If users did some trial operations, for example deleted some layers, is
it better that we provide a "cancel" button for users to ignore their
changes?

Need comments from Belen and Giulia.

Thanks,
Dongxiao

>          response = dialog.run()
>          if response == gtk.RESPONSE_YES:
>              self.configuration.layers = dialog.layers




