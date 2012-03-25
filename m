Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SBlXl-0004zB-C9 for bitbake-devel@lists.openembedded.org;
	Sun, 25 Mar 2012 13:23:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2PBEThi015415;
	Sun, 25 Mar 2012 12:14:29 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14767-04; Sun, 25 Mar 2012 12:14:25 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2PBEIqx015408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Mar 2012 12:14:19 +0100
Message-ID: <1332674058.28414.77.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Sun, 25 Mar 2012 12:14:18 +0100
In-Reply-To: <cover.1332518429.git.shane.wang@intel.com>
References: <cover.1332518429.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Hob: fix 2098
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
X-List-Received-Date: Sun, 25 Mar 2012 11:23:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-03-24 at 00:01 +0800, Shane Wang wrote:
> This patch is to fix bug 2098 to make the build progress clear.
> 
> The following changes since commit 8350c03eeca3f5d70984797ef784f29c71cbbb3b:
> 
>   gst-plugins: remove obsolete orcc hack (2012-03-23 12:13:09 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob-fixes-1
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-1
> 
> Shane Wang (1):
>   Hob: add build status labels in the build details screen to make it
>     more close to the visual design

Merged to master, thanks.

Richard



