Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SFmXF-0003xI-HQ for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 15:15:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35D6Kng025750;
	Thu, 5 Apr 2012 14:06:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24887-09; Thu,  5 Apr 2012 14:06:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35D6Alb025743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Apr 2012 14:06:13 +0100
Message-ID: <1333631169.6300.17.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Thu, 05 Apr 2012 14:06:09 +0100
In-Reply-To: <cover.1333379931.git.shane.wang@intel.com>
References: <cover.1333379931.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Continue Hob fixes
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
X-List-Received-Date: Thu, 05 Apr 2012 13:15:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-04-02 at 23:22 +0800, Shane Wang wrote:
> The patches is to continue Shane Wang's previous submission to fix Hobs.
> They include:
>  - Replace an icon
>  - Add logs and allow users to retrieve the logs after successful build
>  - Misc fixes when testing
> 
> The following changes since commit f4b102cdf2cd021a0b5acacb034dd568a8e73817:
> 
>   Hob: a minor fix on pmake (2012-04-02 16:25:56 +0800)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob-fixes-1
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-1
> 
> Shane Wang (4):
>   Hob: add the "info" indication icon for "information" in the dialogs.

>   Hob: remove grab_default() for deploy button
>   Hob: reset issue indication and build status before build starts on
>     build details screen

Merged to master, thanks.

>  Hob: log for Hob and allow users to show logs after successful build

This has discussion so I've not merged it for now.

Cheers,

Richard



