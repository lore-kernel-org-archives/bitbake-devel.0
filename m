Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SJC5B-0004J4-Dg for bitbake-devel@lists.openembedded.org;
	Sun, 15 Apr 2012 01:08:41 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3EMxISC017502;
	Sat, 14 Apr 2012 23:59:18 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16758-07; Sat, 14 Apr 2012 23:59:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3EMxA4w017496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Apr 2012 23:59:11 +0100
Message-ID: <1334444350.8545.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Sat, 14 Apr 2012 23:59:10 +0100
In-Reply-To: <cover.1334429179.git.shane.wang@intel.com>
References: <cover.1334429179.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Hob fixes
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
X-List-Received-Date: Sat, 14 Apr 2012 23:08:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-04-15 at 02:58 +0800, Shane Wang wrote:
> The fixes include:
>  - remember settings and layers between Hob sessions.
>  - continue to fix another case to forget user selection when settings are changed.
> 
> The following changes since commit 276b86509ba29046828d283f15ae44ae0850d1d0:
> 
>   Hob: Use BB_DEFAULT_TASK as build task instead of hardcoded "build" (2012-04-14 14:43:24 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob_0413
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob_0413
> 
> Shane Wang (2):
>   Hob: remember layers and settings between Hob sessions
>   Hob: reset user recipe selection and package selection after settings
>     are changed
> 
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   16 +-
>  bitbake/lib/bb/ui/crumbs/builder.py                |  170 ++++++++++++-------
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    1 -
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    4 +-
>  bitbake/lib/bb/ui/crumbs/template.py               |   24 +++-
>  5 files changed, 136 insertions(+), 79 deletions(-)

Merged to master, thanks.

Richard



