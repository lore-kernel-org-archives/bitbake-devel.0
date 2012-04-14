Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ0uw-0000fh-4z
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 13:13:22 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 14 Apr 2012 04:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141684055"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 14 Apr 2012 04:03:58 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
In-Reply-To: <cover.1334400003.git.dongxiao.xu@intel.com>
References: <cover.1334400003.git.dongxiao.xu@intel.com>
Date: Sat, 14 Apr 2012 19:01:08 +0800
Message-ID: <1334401268.27917.39.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Subject: Re: [PATCH 0/4][PULL] Hob: Bug fixes
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
X-List-Received-Date: Sat, 14 Apr 2012 11:13:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-04-14 at 18:42 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This pull request contains some Hob related bug fixes, please help to review and pull.

Please ignore this request because it missed some critical change, I
will send an update one.

Thanks,
Dongxiao

> 
> Thanks,
> Dongxiao
> 
> The following changes since commit 434fdb3913cc78e2e9cdeede4c4fa7f1c8ef8892:
> 
>   Hob: Added required packages for toolchain. (2012-04-13 12:00:12 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> 
> Dongxiao Xu (4):
>   Hob: A minor fix on tooltip
>   Hob: Save the original image name into template
>   Hob: Build selected image if not customized
>   Hob: Use BB_DEFAULT_TASK as build task instead of hardcoded "build"
> 
>  lib/bb/ui/crumbs/builder.py         |   34 +++++++++++++++++++++-------------
>  lib/bb/ui/crumbs/hig.py             |    5 ++++-
>  lib/bb/ui/crumbs/hobeventhandler.py |   22 +++++++++++++---------
>  3 files changed, 38 insertions(+), 23 deletions(-)
> 




