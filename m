Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SAClX-0003M0-AR
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 05:03:15 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 20 Mar 2012 20:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119837795"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 20:54:20 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Shane Wang <shane.wang@intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1332302662.git.shane.wang@intel.com>
References: <cover.1332302662.git.shane.wang@intel.com>
Date: Wed, 21 Mar 2012 11:52:14 +0800
Message-ID: <1332301934.10433.2.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Some small fixes for Hob
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
X-List-Received-Date: Wed, 21 Mar 2012 04:03:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Richard,

Could you hold this change for a moment?
I also have some changes which may have patching conflict with this one.

I will merge Shane's change together and send them out in all.

Thanks,
Dongxiao

On Wed, 2012-03-21 at 12:05 +0800, Shane Wang wrote:
> These are small fixes for Hob. Please review.
> 
> The following changes since commit 224ff370b4636cdd33c47c1e6341ef43a67e0227:
> 
>   xserver-kdrive: compile xserver without dtrace support (2012-03-20 15:21:39 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob2-v0.71
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob2-v0.71
> 
> Shane Wang (5):
>   Hob: Change window title from HOB to Hob
>   Hob: Change "View Packages" description
>   Hob: In the recipe view, change the headings
>   Hob: In the package view, change the headings
>   Hob: Change the titles for recipe view and package view
> 
>  bitbake/lib/bb/ui/crumbs/builder.py                |    2 +-
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +++---
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   12 ++++++------
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    8 ++++----
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 




