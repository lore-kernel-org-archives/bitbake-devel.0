Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0zpy-0007cf-LJ for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 19:25:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1OIHLtY010311;
	Fri, 24 Feb 2012 18:17:21 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09722-05; Fri, 24 Feb 2012 18:17:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1OIHBgv010304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Feb 2012 18:17:12 GMT
Message-ID: <1330107431.9617.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Fri, 24 Feb 2012 18:17:11 +0000
In-Reply-To: <cover.1330004101.git.dongxiao.xu@intel.com>
References: <cover.1330004101.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1][PULL] Hob2: A new implementation for Human Oriented Builder
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
X-List-Received-Date: Fri, 24 Feb 2012 18:25:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-02-23 at 21:48 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This pull request is a new implementation for Human Oriented Builder, please help to review and pull.
> 
> Changes from previous pull requests:
>  - Re-implemented a lot of code according to Belen's new GUI design.
> 
> Note that this pull request depends on the following pull requests:
>  - hob2-bitbake-changes
>  - hob2-oecore-changes
> 
> Thanks,
> Dongxiao
> 
> 
> The following changes since commit cec8b6e6c33582be660dd35c6050efc3f28e6baa:
> 
>   runqueue: fire sceneQueueTaskStarted event when a setscene queue starts (2012-02-23 21:04:49 +0800)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob2
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2
> 
> Dongxiao Xu (1):
>   Hob: A new implemetation for Human Oriented Builder

I just merged this branch however there are some things I need to make
clear, particularly why I've done it and why this should never happen
again.

Having everything as one huge monster patch effectively means its
impossible to review. I've taken it since it would probably take weeks
to split into changesets and I'm not sure that would be productive work.
At least if its in master, people can test it out and send
patches/incremental improvements from now on so I have taken it on this
basis. I want to make it clear this is a one time exception and isn't
going to be acceptable in future.

Secondly, I merged the patch but didn't realise it was corrupt, some
files had the prefix "bitbake/" and some did not. I've corrected this
but it caused me quite a bit of confusion.

Joshua's reply in this thread also has some valid questions I'd like to
see answered. 

I'd also like to stress the Human Oriented Builder name needs to die
(sorry Dave), I removed it from the commit message.

All the above isn't to say I don't love the progress we're making with
the UI btw, we just also need to keep an eye on the housekeeping stuff
too.

Cheers,

Richard




