Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SC00U-0004vW-BJ
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 04:50:06 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 25 Mar 2012 19:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145270447"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2012 19:41:05 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1332673644.28414.74.camel@ted>
References: <cover.1332589589.git.dongxiao.xu@intel.com>
	<1332673644.28414.74.camel@ted>
Date: Mon, 26 Mar 2012 10:38:51 +0800
Message-ID: <1332729531.1849.67.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
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
X-List-Received-Date: Mon, 26 Mar 2012 02:50:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-03-25 at 12:07 +0100, Richard Purdie wrote:
> On Sat, 2012-03-24 at 19:49 +0800, Dongxiao Xu wrote:
> > Hi Richard,
> > 
> > This is the third pull request for Hob bug fixes, please help to review and pull.
> > 
> > Changes from v2:
> > 1) Change the logic in set_distro(), that is, if defaultsetup is selected in Hob advanced setting dialog, we should leave DISTRO variable not set in bitbake server.
> > 2) Add a new patch to avoid hardcode TMPDIR when executing runqemu.
> > 
> > Thanks,
> > Dongxiao
> > 
> > The following changes since commit 0348ef08db9ac425d83126d2e6eb465adc28b110:
> > 
> >   Hob: Change the descriptions for view_recipe_button and view_package_button (2012-03-23 16:09:35 +0000)
> > 
> > are available in the git repository at:
> >   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
> >   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> > 
> > Dongxiao Xu (9):
> >   Hob: Remove unnecessary PARSE_BBFILES command
> >   Hob: Cleanup for hobeventhandler.py
> >   Hob: Initial an empty label in recipeselectionpage.py
> >   Hob: Change the Hob initialization process
> >   Hob: Fix the workaround to get image types
> >   Hob: Add a supported image type "vmdk"
> >   Hob: runqemu and deployment functionality filter
> >   Hob: Set empty DISTRO if "defaultsetup" is selected
> >   Hob: Avoid getting TMPDIR in hardcode
> 
> Merged to master, thanks.
> 
> I do have some concerns around the "runqemu and deployment functionality
> filter" in that I'd prefer it if we treated the
> RUNNABLE_MACHINE_PATTERNS as a proper regexp and matched it against
> MACHINE rather than the image name. I'd prefer to see if behave like
> COMPATIBLE_MACHINE for example.

We can change the RUNNABLE_MACHINE_PATTERNS to be regexp style, but
maybe we still need to match it with image name, since we will have two
ways to access to the image details page:
1) Through a normal build, where we are able to get the MACHINE
variable.
2) Through clicking "My images" button and load an already built image,
from which we could not get the MACHINE variable but only image name.

BTW, to implement the filter functionality, we still have a pending
patch for OE-Core that is not in master yet, see:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=dxu4/hob-bugfix-oecore&id=10968f8c0cf425011983ef7e0fe4c14b7da5ef74

Thanks,
Dongxiao

> 
> This is a detail we can fix in subsequent patches though.
> 
> Cheers,
> 
> Richard
> 




