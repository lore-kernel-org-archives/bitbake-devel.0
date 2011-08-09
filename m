Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QqnFW-00007h-EL for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 16:25:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p79ELBgO014241;
	Tue, 9 Aug 2011 15:21:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14206-01; Tue,  9 Aug 2011 15:21:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p79EL5GG014235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Aug 2011 15:21:06 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <cover.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
Date: Tue, 09 Aug 2011 15:20:33 +0100
Message-ID: <1312899633.14274.304.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Bug fixes for hob
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
X-List-Received-Date: Tue, 09 Aug 2011 14:25:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-08-08 at 18:18 -0700, Joshua Lock wrote:
> Here are some more bug fixes (and more on the way).
> 
> Thanks,
> Joshua
> 
> The following changes since commit 5cacdc4f1641eda1b5707c96f7c40924a9db6174:
> 
>   bb/cooker: mark parsed conf files as potential cache invalidators (2011-08-04 15:40:51 -0700)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Jessica Zhang (1):
>   bb/ui/hob: Restore toolchain relevant preference settings for build
> 
> Joshua Lock (3):
>   bb/ui/crumbs/tasklistmodel: prevent hang when removing item
>   bb/ui/hob: move some code around to avert a race

I've merged these three to master.

>   bb/cooker: only emit ConfigFilePathFound for files which were parsed

This needs a little tweak.

Cheers,

Richard



