Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R0ek4-0001yt-Lc for bitbake-devel@lists.openembedded.org;
	Mon, 05 Sep 2011 21:22:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p85JGwCN000902;
	Mon, 5 Sep 2011 20:16:58 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29956-10; Mon,  5 Sep 2011 20:16:54 +0100 (BST)
Received: from [192.168.1.40] (dynamic10.rpnet.com [192.168.1.40])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p85JGsg3000896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2011 20:16:54 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
Date: Mon, 05 Sep 2011 20:16:54 +0100
Message-ID: <1315250214.1243.4.camel@ted>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] hob changes for Yocto 1.1
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
X-List-Received-Date: Mon, 05 Sep 2011 19:22:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-09-02 at 17:17 -0700, Joshua Lock wrote:
> This series addresses issues for the looming Yocto 1.1 code freeze. This
> means that the series contains a 3 genuine patches followed by 3
> hide my shame patches to disable features which either a) weren't implmented
> in time or b) weren't deemed to be stable enough for inclusion in the 1.1
> release.
> 
> Regards,
> Joshua
> 
> The following changes since commit 639db8c766cada7180f9447f51303f9b30d7e817:
> 
>   fetch2/git: Allow to specify the name of the checkout directory (2011-09-02 14:23:43 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (6):
>   hob: use both pre and post files for hob configuration
>   hob: reflect defaultsetup being default distro
>   hob: add a test to ensure hob is run with the required pre and post
>     files
>   ui/crumbs/hobprefs: disable 'build toolchain with headers'
>   ui/crumbs/runningbuild: mask run_buildstats failure
>   hob: disable removal of packages

Merged to master, thanks.

Richard




