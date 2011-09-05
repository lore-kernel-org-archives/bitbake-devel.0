Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R0egq-0001vS-4l for bitbake-devel@lists.openembedded.org;
	Mon, 05 Sep 2011 21:18:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p85JDc89000866;
	Mon, 5 Sep 2011 20:13:38 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29956-09; Mon,  5 Sep 2011 20:13:34 +0100 (BST)
Received: from [192.168.1.40] (dynamic10.rpnet.com [192.168.1.40])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p85JDW4o000859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2011 20:13:32 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1315225427.git.paul.eggleton@linux.intel.com>
References: <cover.1315225427.git.paul.eggleton@linux.intel.com>
Date: Mon, 05 Sep 2011 20:13:32 +0100
Message-ID: <1315250012.1243.2.camel@ted>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Hob second build fixes
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
X-List-Received-Date: Mon, 05 Sep 2011 19:18:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-09-05 at 13:30 +0100, Paul Eggleton wrote:
> The following two patches fix problems running the second build within
> a single session of the hob UI.
> 
> The patches (against Poky, but apply cleanly with -p2 against BitBake
> master) are  available in the git repository at:
>   git://git.pokylinux.org/poky-contrib paule/hob-fixes
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/hob-fixes
> 
> Paul Eggleton (2):
>   hob: clear out temporary file list after deleting
>   hob: fix segfault on second build
> 
>  bitbake/lib/bb/ui/crumbs/runningbuild.py |    5 +++++
>  bitbake/lib/bb/ui/hob.py                 |    3 ++-
>  2 files changed, 7 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



