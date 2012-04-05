Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SFmUF-0003uo-6R for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 15:12:27 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35D3ELT025661;
	Thu, 5 Apr 2012 14:03:14 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24887-07; Thu,  5 Apr 2012 14:03:10 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35D34dm025650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Apr 2012 14:03:08 +0100
Message-ID: <1333630983.6300.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Thu, 05 Apr 2012 14:03:03 +0100
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/10][PULL] Hob: Bug fixes
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
X-List-Received-Date: Thu, 05 Apr 2012 13:12:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-04-01 at 20:14 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This is the hob related bug fixes, please help to review and pull.
> 
> This version contains 5 commits that have been sent last time with no comments, and remove the two commits that Josh commented on.
> Also there are another 5 commits for other bug fixes.
> 
> For the two patches that we are discussing, I didn't add them in this series. I will send a separate pull request for it after the decision is finalized.
> 
> Thanks,
> Dongxiao
> 
> The following changes since commit 035e146ff92236a3eda71ad71e8389737f91753b:
> 
>   Hob: In building log page, fixed the issue about 'endpath' not clear when next to start build (2012-03-30 17:19:35 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> 
> Dongxiao Xu (10):
>   Hob: Fix MACHINE setting
>   Hob: Update the cache when setting changed
>   Hob: Remove some calling of initiate_new_build()
>   Hob: Remove duplication for certain bitbake variables
>   Hob: Set stop button sensitive after task started
>   Hob: Remove the recipe/task type for multilib
>   Hob: Fix toolchain build
>   Hob: Check "dummy" image while update_image_combo
>   Hob: fix IMAGE_INSTALL setting while save template

I merged these, thanks.

>  Hob: Change base image to "Create your own image" if customized

There was a discussion on this one so I left it for now.

Cheers,

Richard



