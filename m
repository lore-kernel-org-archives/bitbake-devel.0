Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDM0D-00007Q-01 for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 22:31:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKMJmp004702;
	Thu, 29 Mar 2012 21:22:19 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04256-04; Thu, 29 Mar 2012 21:22:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKM8hF004695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Mar 2012 21:22:10 +0100
Message-ID: <1333052527.18082.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Thu, 29 Mar 2012 21:22:07 +0100
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/14][PULL] Hob: Bugfix and feature enhancement
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
X-List-Received-Date: Thu, 29 Mar 2012 20:31:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-29 at 20:01 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This pull request contains Hob related bug fixes and enhancement.
> Please help to review and pull.
> 
> Thanks,
> Dongxiao
> 
> The following changes since commit f9cf2671c0ecad153db11bca1aebe151213bfb42:
> 
>   bb.build: use relative log links, not absolute (2012-03-28 22:28:00 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> 
> Dongxiao Xu (14):
>   Hob: Remove un-used signal and functions
>   Hob: Fix adding duplicated meta-hob layer
>   Hob: Define a variable to store the image name and toolchain
>   Hob: Improve the matching for runnable machine type
>   command.py: Move triggerEvent to command async class
>   Hob: Improve for init a new build
>   Hob: Inherit image_types.bbclass in set_user_config()
>   Hob: Update configuration after parsing
>   Hob: Remember user settings when reparse config
>   Hob: Change the format to store image_fstype variable
>   Hob: Fix the setting hash calculation
>   Hob: Replace "local.conf" in error message

I merged these, thanks.

>  Hob: Fix MACHINE setting
>   Hob: Update the cache when setting changed

These didn't apply so please send an updated patch against master.

Cheers,

Richard



