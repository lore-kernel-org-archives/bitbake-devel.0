Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SmQ2f-0002JF-DQ for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jul 2012 15:54:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64Dhk1U023834;
	Wed, 4 Jul 2012 14:43:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23521-03; Wed,  4 Jul 2012 14:43:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64Dhbjx023822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2012 14:43:39 +0100
Message-ID: <1341409417.3906.26.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Liming An <limingx.l.an@intel.com>
Date: Wed, 04 Jul 2012 14:43:37 +0100
In-Reply-To: <cover.1341313886.git.limingx.l.an@intel.com>
References: <cover.1341313886.git.limingx.l.an@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Hob: bug-fixes
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
X-List-Received-Date: Wed, 04 Jul 2012 13:54:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-07-03 at 19:15 +0800, Liming An wrote:
> Due in my mistake there has a high level bug, so fixed it, please to review.
> Thanks!
> 
> The following changes since commit 644ad4bf1e30fcee4b9d5abb819046d1f2193d27:
> 
>   documentation/bsp-guide/bsp.xml: Yocto term paring (2012-07-02 16:47:45 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue
> 
> Liming An (1):
>   Hob: fixed some variables not clean bug in detail page

Merged to master, thanks.

Richard



