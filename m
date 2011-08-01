Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QnumO-0006Jd-Hc for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 17:51:44 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p71FlKFh008394;
	Mon, 1 Aug 2011 16:47:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 07326-10; Mon,  1 Aug 2011 16:47:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p71FlAqZ008388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Aug 2011 16:47:11 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1311876523.git.josh@linux.intel.com>
References: <cover.1311876523.git.josh@linux.intel.com>
Date: Mon, 01 Aug 2011 16:46:57 +0100
Message-ID: <1312213617.2344.503.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Hob preference fixes
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
X-List-Received-Date: Mon, 01 Aug 2011 15:51:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-07-28 at 11:10 -0700, Joshua Lock wrote:
> Fixes some Yocto bugs reported agains the preferences window.
> 
> The following changes since commit eea5ff9f34bb9b2e29f5fa43deb80d4aa6ef7ddc:
> 
>   bitbake/providers: list PREFERRED_VERSION candidates when unavailable (2011-07-27 16:53:47 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (2):
>   hob: more reliable disabling of GPLv3 packages
>   hob: fix save/restore of toolchain preferences
> 
>  lib/bb/ui/crumbs/configurator.py    |   25 +++++++++++++++++++++--
>  lib/bb/ui/crumbs/hobeventhandler.py |   10 +-------
>  lib/bb/ui/crumbs/hobprefs.py        |   36 +++++++++++++++++++++++++++++-----
>  lib/bb/ui/hob.py                    |   11 +++++++++-
>  4 files changed, 64 insertions(+), 18 deletions(-)

Merged to master, thanks.

I did notice a load of other commits on this branch. Since they weren't
mentioned in the pull request I didn't take them though.

Cheers,

Richard



