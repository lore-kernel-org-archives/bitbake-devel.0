Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDM0T-00008L-Hw for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 22:31:41 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKMZbw004712;
	Thu, 29 Mar 2012 21:22:35 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03712-09; Thu, 29 Mar 2012 21:22:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKMOPI004705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Mar 2012 21:22:26 +0100
Message-ID: <1333052543.18082.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Thu, 29 Mar 2012 21:22:23 +0100
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Hob tweaks & fixes
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
X-List-Received-Date: Thu, 29 Mar 2012 20:31:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-03-28 at 17:30 -0700, Joshua Lock wrote:
> Here are some more minor fixes for Hob, please review and consider for inclusion.
> 
> Regards,
> Joshua
> 
> The following changes since commit f9cf2671c0ecad153db11bca1aebe151213bfb42:
> 
>   bb.build: use relative log links, not absolute (2012-03-28 22:28:00 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> 
> Joshua Lock (6):
>   lib/bb/ui/crumbs/hobwidget: add padding to HobImageButton
>   lib/bb/ui/crumbs/imageconfigurationpage: add extra space between
>     widgets
>   lib/bb/ui/crumbs/hobwidget: change text sizes in HobImageButton
>   lib/bb/ui/crumbs/builder: allow user to cancel Layer selection
>     dialogue
>   lib/bb/ui/crumbs: hob progress bar should not be red when user stops
>     build
>   lib/bb/ui/crumbs/hig: fix layers_changed test

Merged to master, thanks.

Richard



