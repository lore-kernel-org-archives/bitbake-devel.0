Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T9wXF-0003eV-N5 for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 13:15:41 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87B3EP4028320;
	Fri, 7 Sep 2012 12:03:14 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27778-05; Fri,  7 Sep 2012 12:03:10 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87B35fu028314
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Sep 2012 12:03:06 +0100
Message-ID: <1347015786.7493.51.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ioana Grigoropol <ioanax.grigoropol@intel.com>
Date: Fri, 07 Sep 2012 12:03:06 +0100
In-Reply-To: <1346665866-12697-1-git-send-email-ioanax.grigoropol@intel.com>
References: <1346665866-12697-1-git-send-email-ioanax.grigoropol@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] [Yocto #3011] - Button theme is taken from host
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
X-List-Received-Date: Fri, 07 Sep 2012 11:15:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-09-03 at 12:51 +0300, Ioana Grigoropol wrote:
> -All buttons in the interface inherit a BaseHobButton that use the gtk settings for buttons from the host;
> -Removed 'or' label between actions on image details page
> 
> Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobwidget.py        |   36 ++++++++++++++------------
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    8 +++---
>  2 files changed, 23 insertions(+), 21 deletions(-)

I've merged this but in future please put a something indicating the
area the patch touches at the start of the commit summary (like
"hobwidget:" and put the bug number in the body of the commit message.
If you don't, when I apply it, git swallows the [] encased data, just
like [PATCH].

Cheers,

Richard



