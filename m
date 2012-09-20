Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TEdI6-0005rX-GP for bitbake-devel@lists.openembedded.org;
	Thu, 20 Sep 2012 11:43:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8K9UgFM010877;
	Thu, 20 Sep 2012 10:30:42 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01232-07; Thu, 20 Sep 2012 10:30:37 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8K9UVg6010866
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Sep 2012 10:30:32 +0100
Message-ID: <1348133430.25163.34.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Constantin Musca <constantinx.musca@intel.com>
Date: Thu, 20 Sep 2012 10:30:30 +0100
In-Reply-To: <1347616733-27180-1-git-send-email-constantinx.musca@intel.com>
References: <1347616733-27180-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: rename 'View log' to 'Open log'
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
X-List-Received-Date: Thu, 20 Sep 2012 09:43:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-09-14 at 12:58 +0300, Constantin Musca wrote:
> Rename all the 'View log' buttons to 'Open log' for
> consistency.
> 
> [YOCTO #3045]
> ---
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   12 ++++++------
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)


Merged to master, thanks.

Richard



