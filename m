Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDM0m-00009Q-Rg for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 22:32:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKMtpQ004722;
	Thu, 29 Mar 2012 21:22:55 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04256-05; Thu, 29 Mar 2012 21:22:51 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKMeB7004716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Mar 2012 21:22:45 +0100
Message-ID: <1333052557.18082.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Thu, 29 Mar 2012 21:22:37 +0100
In-Reply-To: <cover.1332952559.git.shane.wang@intel.com>
References: <cover.1332952559.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Hob: bug fixes
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
X-List-Received-Date: Thu, 29 Mar 2012 20:32:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-29 at 00:36 +0800, Shane Wang wrote:
> Fix bug 2163 and some words
> 
> The following changes since commit bbef66e4005def54d70d3720ec131fa7edc22e2a:
> 
>   Hob: allow users to setup the proxies (2012-03-28 15:57:39 +0800)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob-fixes-2
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-2
> 
> Shane Wang (5):
>   Hob: add Templates and Settings on image details screen
>   Hob: change some words for build configurations on build details
>     screen
>   Hob: change some words on image configuration screen to make them
>     consistent
>   Hob: change some words on recipes screen and package screen to make
>     them consistent
>   Hob: change some words in settings dialog to make them consistent

Merged to master, thanks.

Richard



