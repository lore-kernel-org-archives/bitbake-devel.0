Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBFZK-0002Io-TH
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 02:14:59 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 23 Mar 2012 18:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="144409050"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2012 18:06:00 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <e750e728f211db865fcd1740cc1fa19a23485128.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<e750e728f211db865fcd1740cc1fa19a23485128.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 09:03:50 +0800
Message-ID: <1332551030.1849.19.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 7/9] lib/bb/ui/crumbs/persistenttooltip: ensure a reasonable minimum size
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
X-List-Received-Date: Sat, 24 Mar 2012 01:14:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:23 -0700, Joshua Lock wrote:
> The persistent tooltip looks a little weird when it's too small, request
> that the toolkit and WM give it a reasonable minimum size.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/persistenttooltip.py |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
> index e184062..69e059b 100644
> --- a/lib/bb/ui/crumbs/persistenttooltip.py
> +++ b/lib/bb/ui/crumbs/persistenttooltip.py
> @@ -73,6 +73,9 @@ class PersistentTooltip(gtk.Window):
>          self.set_position(gtk.WIN_POS_MOUSE)
>          self.set_opacity(0.95)
>  
> +        # Ensure a reasonable minimum size
> +        self.set_geometry_hints(self, 100, 50)
> +
>          # Draw our label and close buttons
>          hbox = gtk.HBox(False, 0)
>          hbox.show()




