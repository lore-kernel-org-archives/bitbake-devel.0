Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SBlR3-0004tQ-OR for bitbake-devel@lists.openembedded.org;
	Sun, 25 Mar 2012 13:16:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2PB7WJB015354;
	Sun, 25 Mar 2012 12:07:32 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14767-03; Sun, 25 Mar 2012 12:07:28 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2PB7OME015346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Mar 2012 12:07:25 +0100
Message-ID: <1332673644.28414.74.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Sun, 25 Mar 2012 12:07:24 +0100
In-Reply-To: <cover.1332589589.git.dongxiao.xu@intel.com>
References: <cover.1332589589.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/9 v3][PULL] Hob: Bug fixes: image_types, runqemu/deploy functionality filter, and DISTRO setting
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
X-List-Received-Date: Sun, 25 Mar 2012 11:16:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-03-24 at 19:49 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This is the third pull request for Hob bug fixes, please help to review and pull.
> 
> Changes from v2:
> 1) Change the logic in set_distro(), that is, if defaultsetup is selected in Hob advanced setting dialog, we should leave DISTRO variable not set in bitbake server.
> 2) Add a new patch to avoid hardcode TMPDIR when executing runqemu.
> 
> Thanks,
> Dongxiao
> 
> The following changes since commit 0348ef08db9ac425d83126d2e6eb465adc28b110:
> 
>   Hob: Change the descriptions for view_recipe_button and view_package_button (2012-03-23 16:09:35 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> 
> Dongxiao Xu (9):
>   Hob: Remove unnecessary PARSE_BBFILES command
>   Hob: Cleanup for hobeventhandler.py
>   Hob: Initial an empty label in recipeselectionpage.py
>   Hob: Change the Hob initialization process
>   Hob: Fix the workaround to get image types
>   Hob: Add a supported image type "vmdk"
>   Hob: runqemu and deployment functionality filter
>   Hob: Set empty DISTRO if "defaultsetup" is selected
>   Hob: Avoid getting TMPDIR in hardcode

Merged to master, thanks.

I do have some concerns around the "runqemu and deployment functionality
filter" in that I'd prefer it if we treated the
RUNNABLE_MACHINE_PATTERNS as a proper regexp and matched it against
MACHINE rather than the image name. I'd prefer to see if behave like
COMPATIBLE_MACHINE for example.

This is a detail we can fix in subsequent patches though.

Cheers,

Richard



