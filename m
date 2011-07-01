Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QcgzO-0001If-V5 for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 18:54:47 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p61Gp0Eo013132;
	Fri, 1 Jul 2011 17:51:00 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13068-01; Fri,  1 Jul 2011 17:50:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p61GorGm013126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2011 17:50:53 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Darren Hart <dvhart@linux.intel.com>
In-Reply-To: <4E0DF94E.5010301@linux.intel.com>
References: <4E0DF94E.5010301@linux.intel.com>
Date: Fri, 01 Jul 2011 17:50:31 +0100
Message-ID: <1309539031.20015.532.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fix typo in bitbake
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
X-List-Received-Date: Fri, 01 Jul 2011 16:54:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-01 at 09:43 -0700, Darren Hart wrote:
> Patch from the car over 3g hotspot... quick, before it goes down...
> please feel free to cleanup, change the comment, whatever.

I've already pushed something similar, thanks.

Somehow the patch manipulation tools broke the patch. The correct
version made it into bitbake :/.

Cheers,

Richard

> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> ---
>  bitbake/bin/bitbake |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
> index 2564e97..c71c2d4 100755
> --- a/bitbake/bin/bitbake
> +++ b/bitbake/bin/bitbake
> @@ -202,7 +202,7 @@ Default BBFILES are the .bb files in the current
> directory.""")
>      # of the UIs (e.g. for DISPLAY, etc.)
>      bb.utils.clean_environment()
> 
> -    server = server.BitBakeServer(
> +    server = server.BitBakeServer()
> 
>      server.initServer()
>      idle = server.getServerIdleCB()
> -- 
> 1.7.1




