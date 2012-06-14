Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sf9km-00057i-B0 for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 15:06:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5ECtlXA001133;
	Thu, 14 Jun 2012 13:55:47 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00731-04; Thu, 14 Jun 2012 13:55:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5ECtdHC001125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 13:55:39 +0100
Message-ID: <1339678538.24333.74.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Thu, 14 Jun 2012 13:55:38 +0100
In-Reply-To: <cover.1339653356.git.kai.kang@windriver.com>
References: <cover.1339653356.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/3] Update for Yocto 2388
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
X-List-Received-Date: Thu, 14 Jun 2012 13:06:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-14 at 18:10 +0800, Kang Kai wrote:
> Hi,
> 
> These are 3 updates of 
> Yocto 2388: [Hob] Separate the hob image writer into a separate application
> Two of them are strings update, and the other one is for simplify code.
> 
> Regards,
> Kai
> 
> The following changes since commit 5ed855d12cddf2de535c3f6d05d3dfe85d69d99d:
> 
>   openjade-native: Ensure we reautoconf the package (2012-06-12 16:34:30 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib kangkai/distro
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/distro
> 
> Kang Kai (3):
>   ui/crumbs/hig.py: tweak strings
>   ui/crumbs/hig.py: simplify subprocess call
>   image-writer: tweak some strings

Merged to master, thanks.

Richard



