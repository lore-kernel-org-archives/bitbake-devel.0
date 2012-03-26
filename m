Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SC7kc-00018P-Rn for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 13:06:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2QAvEBO024486;
	Mon, 26 Mar 2012 11:57:14 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17410-08; Mon, 26 Mar 2012 11:57:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2QAv5SU024480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Mar 2012 11:57:06 +0100
Message-ID: <1332759424.28414.102.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Date: Mon, 26 Mar 2012 11:57:04 +0100
In-Reply-To: <1332729531.1849.67.camel@dongxiao-osel>
References: <cover.1332589589.git.dongxiao.xu@intel.com>
	<1332673644.28414.74.camel@ted>
	<1332729531.1849.67.camel@dongxiao-osel>
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
X-List-Received-Date: Mon, 26 Mar 2012 11:06:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-26 at 10:38 +0800, Xu, Dongxiao wrote:
> On Sun, 2012-03-25 at 12:07 +0100, Richard Purdie wrote:
> > On Sat, 2012-03-24 at 19:49 +0800, Dongxiao Xu wrote:
> > > Hi Richard,
> > > 
> > > This is the third pull request for Hob bug fixes, please help to review and pull.
> > > 
> > > Changes from v2:
> > > 1) Change the logic in set_distro(), that is, if defaultsetup is selected in Hob advanced setting dialog, we should leave DISTRO variable not set in bitbake server.
> > > 2) Add a new patch to avoid hardcode TMPDIR when executing runqemu.
> > > 
> > > Thanks,
> > > Dongxiao
> > > 
> > > The following changes since commit 0348ef08db9ac425d83126d2e6eb465adc28b110:
> > > 
> > >   Hob: Change the descriptions for view_recipe_button and view_package_button (2012-03-23 16:09:35 +0000)
> > > 
> > > are available in the git repository at:
> > >   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
> > >   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> > > 
> > > Dongxiao Xu (9):
> > >   Hob: Remove unnecessary PARSE_BBFILES command
> > >   Hob: Cleanup for hobeventhandler.py
> > >   Hob: Initial an empty label in recipeselectionpage.py
> > >   Hob: Change the Hob initialization process
> > >   Hob: Fix the workaround to get image types
> > >   Hob: Add a supported image type "vmdk"
> > >   Hob: runqemu and deployment functionality filter
> > >   Hob: Set empty DISTRO if "defaultsetup" is selected
> > >   Hob: Avoid getting TMPDIR in hardcode
> > 
> > Merged to master, thanks.
> > 
> > I do have some concerns around the "runqemu and deployment functionality
> > filter" in that I'd prefer it if we treated the
> > RUNNABLE_MACHINE_PATTERNS as a proper regexp and matched it against
> > MACHINE rather than the image name. I'd prefer to see if behave like
> > COMPATIBLE_MACHINE for example.
> 
> We can change the RUNNABLE_MACHINE_PATTERNS to be regexp style, but
> maybe we still need to match it with image name, since we will have two
> ways to access to the image details page:
> 1) Through a normal build, where we are able to get the MACHINE
> variable.
> 2) Through clicking "My images" button and load an already built image,
> from which we could not get the MACHINE variable but only image name.

Ok, that is a good point, thanks.

Can we reliably extract the machine name from the image name? I'm
thinking if regexps are involved they could use the start/end markers (^
$) which could get confusing if its matching the whole image name...

> BTW, to implement the filter functionality, we still have a pending
> patch for OE-Core that is not in master yet, see:
> 
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=dxu4/hob-bugfix-oecore&id=10968f8c0cf425011983ef7e0fe4c14b7da5ef74

That is on my to merge list, thanks.

Richard



