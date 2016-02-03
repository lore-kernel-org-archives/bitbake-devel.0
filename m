Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ED79C77155
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Feb 2016 16:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u13GqYQN026628; Wed, 3 Feb 2016 16:52:47 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4c95BMX0bC1v; Wed,  3 Feb 2016 16:52:47 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u13Gqks4026682
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Feb 2016 16:52:47 GMT
Message-ID: <1454518366.27087.204.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Markus Lehtonen <markus.lehtonen@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Wed, 03 Feb 2016 16:52:46 +0000
In-Reply-To: <1454495619-15453-3-git-send-email-markus.lehtonen@linux.intel.com>
References: <1454495619-15453-1-git-send-email-markus.lehtonen@linux.intel.com>
	<1454495619-15453-3-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] data_smart: handle '\x7d' in python parsing
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 03 Feb 2016 16:52:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-02-03 at 12:33 +0200, Markus Lehtonen wrote:
> At least ncurses recipe uses a workaround (for former bitbake python
> parser) where closing curly bracket inside a python string was
> replaced
> by '\x7d' ascii code. The previous "curly bracket matching" patch
> broke
> parsing of constructs like this as bitbake wouldn't correctly find
> the
> closing bracket. This patch fixes this by accepting '\x7d' as a
> closing
> bracket.
> 
> Hopefully, this patch could be reverted (and the python regexp thus
> simplified) in the future after making sure that no recipes use the
> '\x7d' workaround, anymore.
> 
> [YOCTO #8849]
> 
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> ---
>  lib/bb/data_smart.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

To be honest, the number of recipes which do this is hopefully very
very small and we should just go and fix them now?

I'm not sure we want to go ahead and support this.

Cheers,

Richard



