Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T1e3U-0007sm-6h for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 15:54:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FDghRZ001630;
	Wed, 15 Aug 2012 14:42:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00424-05; Wed, 15 Aug 2012 14:42:38 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FDgbqP001624
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 Aug 2012 14:42:38 +0100
Message-ID: <1345038156.538.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 15 Aug 2012 14:42:36 +0100
In-Reply-To: <86c6fef246be4e70f22d24754abbc920470d5997.1344564039.git.liezhi.yang@windriver.com>
References: <cover.1344564039.git.liezhi.yang@windriver.com>
	<86c6fef246be4e70f22d24754abbc920470d5997.1344564039.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] bitbake.conf: add BB_STAMPS_DIR for constructing STAMP
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
X-List-Received-Date: Wed, 15 Aug 2012 13:54:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-08-10 at 10:02 +0800, Robert Yang wrote:
> Add BB_STAMPS_DIR for constructing STAMP, the defination of STAMP
> before:
> 
> STAMP = "${TMPDIR}/stamps/${MULTIMACH_TARGET_SYS}/${PF}
> 
> We can only change the TMPDIR if we want to change the STAMP's location,
> but the cache would be regenerated if TMPDIR changed, so add
> BB_STAMPS_DIR for constructing it, and add it to the BB_ENV_EXTRAWHITE,
> this is very usefull for the "bitbake -S", since then it can be run by:
> 
> BB_STAMPS_DIR=<path> bitbake -S <recipe>
> 
> which will avoid putting the stamps to ${TMPDIR}/stamps.
> 
> BTW, break the too long BB_ENV_EXTRAWHITE into several lines.
> 
> [YOCTO #1659]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  meta/conf/bitbake.conf       | 3 ++-
>  scripts/oe-buildenv-internal | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

BB_ is a prefix for variables bitbake specifically uses for
configuration. It doesn't fit in this context since its metadata defined
and doesn't actually influence or is used by bitbake itself.

We therefore need to use a different name for this.

Cheers,

Richard



