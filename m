Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qe5wL-0005sU-Ps for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 15:45:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65DfZgV031712;
	Tue, 5 Jul 2011 14:41:35 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31539-04; Tue,  5 Jul 2011 14:41:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65DfSGt031704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jul 2011 14:41:28 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1309560728.git.josh@linux.intel.com>
References: <cover.1309560728.git.josh@linux.intel.com>
Date: Tue, 05 Jul 2011 14:40:56 +0100
Message-ID: <1309873256.20015.711.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Hob - BitBake GUI (v2)
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
X-List-Received-Date: Tue, 05 Jul 2011 13:45:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-01 at 15:58 -0700, Joshua Lock wrote:
> Since the first revision the groundwork patches have been merged and I fixed
> a couple of issues noticed today. Namely:
> 1) The wording in the "Build Complete" dialog no longer matched the buttons
> 2) The recipe writing code now handles images with a base image outside of
> the oe-core metadata
> 
> To see just these two changes look to the top two patches on:
> https://github.com/incandescant/bitbake/commits/hob-work
> 
> As noted in the v1 pull request images are built by first using the
> buildTargets command to build all of the target dependencies then creating a
> recipe file and using the buildFile command to handle the build.
> The problem is that if you have a clean build directory, perfectly reasonable
> with such a tool, the buildFile command does not handle the native
> dependencies added by the image class.
> 
> Richard has suggested I modify the GUI to insert a path into BBPATH and then
> I can rely on buildTasks. I'm working on this now but didn't want to send a
> half baked patch.
> 
> Cheers,
> Joshua
> 
> The following changes since commit a8246ae5400c23df0d3ee29c36f4d9f257d1e6d1:
> 
>   bitbake: add -R option for loading configuration files after bitbake.conf (2011-07-01 17:03:03 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (1):
>   hob: re-designed interaction and implementation
> 
>  lib/bb/ui/crumbs/configurator.py    |  278 +++++++++++
>  lib/bb/ui/crumbs/hig.py             |   61 +++
>  lib/bb/ui/crumbs/hobeventhandler.py |  218 +++++++--
>  lib/bb/ui/crumbs/hobprefs.py        |  293 +++++++++++
>  lib/bb/ui/crumbs/layereditor.py     |  136 +++++
>  lib/bb/ui/crumbs/runningbuild.py    |   12 +-
>  lib/bb/ui/crumbs/tasklistmodel.py   |  326 ++++++++++---
>  lib/bb/ui/hob.py                    |  924 +++++++++++++++++++++++-----------
>  8 files changed, 1824 insertions(+), 424 deletions(-)
>  create mode 100644 lib/bb/ui/crumbs/configurator.py
>  create mode 100644 lib/bb/ui/crumbs/hig.py
>  create mode 100644 lib/bb/ui/crumbs/hobprefs.py
>  create mode 100644 lib/bb/ui/crumbs/layereditor.py

Merged to master, thanks!

Richard



