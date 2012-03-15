Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S88Dw-0000Ia-1W for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 11:48:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2FAa3ZQ020022;
	Thu, 15 Mar 2012 10:36:03 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18276-06; Thu, 15 Mar 2012 10:35:59 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2FAZu0C020016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Mar 2012 10:35:57 GMT
Message-ID: <1331807755.18586.71.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Thu, 15 Mar 2012 10:35:55 +0000
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/12 v2][PULL] Hob: Functionality and GUI Fixes
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
X-List-Received-Date: Thu, 15 Mar 2012 10:48:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-15 at 16:29 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This is the second pull request for Hob functionality and GUI fixes, please help to review and pull.
> 
> Changes from v1:
> 1) Modify the Box padding according to Josh's comments.
> 2) Add a new patch which fixes all Box's padding values in Hob code.
> 
> Thanks,
> Dongxiao
> 
> The following changes since commit 2d56dc7b1f0d186e14c4c8a949b280b6b3fc31de:
> 
>   codeparser: Call intern over the set contents for better cache performance (2012-03-12 02:22:34 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> 
> Dongxiao Xu (12):
>   Hob: add "Close" button to "BinbDialog"
>   Hob: Disable the handling of "NoProvider" event
>   cooker: add package rdepends and rrecommends info
>   Hob: Fix the image installation dependency
>   Hob: Remove the reset button in recipe/package selection page
>   Hob: Remove the indication in machine/base image combobox
>   Hob: Remove the recipe/package populated signal
>   Hob: Show recipe/package editing button after base image is selected
>   Hob: Emit command-failed signal even if error msg is None
>   Hob: Add stop button for parsing progress
>   Hob: improve recipe/package selection performance
>   Hob: Change Box's padding value

These look good to me, merged to master, thanks.

Richard



