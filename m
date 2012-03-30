Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDeer-0007Wo-R4 for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 18:26:38 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2UGHV9w014723;
	Fri, 30 Mar 2012 17:17:31 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14492-03; Fri, 30 Mar 2012 17:17:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2UGHLI0014717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Mar 2012 17:17:22 +0100
Message-ID: <1333124241.18082.96.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Fri, 30 Mar 2012 17:17:21 +0100
In-Reply-To: <cover.1333098599.git.shane.wang@intel.com>
References: <cover.1333098599.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Hob: bug fixes
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
X-List-Received-Date: Fri, 30 Mar 2012 16:26:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-30 at 17:12 +0800, Shane Wang wrote:
> Fixes include:
>  - a fix on build detail screen
>  - a fix for finish_now() in runqueue.py
> 
> The following changes since commit bcd4d14425cadc5bd6296f59f14733e8c39c49dd:
> 
>   libc-packgae.bbclass: Add i686 support in locale_arch_options (2012-03-29 22:57:30 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob
> 
> Liming An (1):
>   Hob: In building log page, fixed the issue about 'endpath' not clear
>     when next to start build
> 
> Shane Wang (1):
>   runqueue: wait and deal with those <defunct> sub-processes as soon as
>     they are os.killed() when "Force stop"

Merged to master, thanks.

Richard



