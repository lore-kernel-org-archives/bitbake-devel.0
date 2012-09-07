Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T9z66-0007Vj-2B for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 15:59:50 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87DlMZO029935;
	Fri, 7 Sep 2012 14:47:22 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29414-04; Fri,  7 Sep 2012 14:47:18 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87DlDDu029929
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Sep 2012 14:47:14 +0100
Message-ID: <1347025633.7493.67.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Fri, 07 Sep 2012 14:47:13 +0100
In-Reply-To: <1347019211-24363-1-git-send-email-cristiana.voicu@intel.com>
References: <1347019211-24363-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: print message when DISPLAY is not set
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
X-List-Received-Date: Fri, 07 Sep 2012 13:59:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-09-07 at 15:00 +0300, Cristiana Voicu wrote:
> If DISPLAY wasn't set, launching hob has printed a traceback
> difficult to understand. Now, the exception is caught and it
> shows a human message.
> 
> [YOCTO #2596]
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Merged to master, thanks.

> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index 7de4798..f9e54a8 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -1334,4 +1341,4 @@ class Builder(gtk.Window):
>              format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
>              self.consolelog.setFormatter(format)
>  
> -            self.logger.addHandler(self.consolelog)
> \ No newline at end of file
> +            self.logger.addHandler(self.consolelog)

I keep seeing this piece in your patches which doesn't seem to want to
apply and the line ending looks correct in the main repository. Can you
see if there is some problem locally?

Cheers,

Richard




