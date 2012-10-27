Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TS2Pm-0006AZ-Iz for bitbake-devel@lists.openembedded.org;
	Sat, 27 Oct 2012 11:10:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9R8vBAQ005950;
	Sat, 27 Oct 2012 09:57:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04807-03; Sat, 27 Oct 2012 09:57:06 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9R8v3dH005943
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 27 Oct 2012 09:57:04 +0100
Message-ID: <1351328223.22340.218.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristian Iorga <cristian.iorga@intel.com>
Date: Sat, 27 Oct 2012 09:57:03 +0100
In-Reply-To: <1351243459-12926-1-git-send-email-cristian.iorga@intel.com>
References: <1351243459-12926-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/hig: Hob doesn't save properly proxy settings
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
X-List-Received-Date: Sat, 27 Oct 2012 09:10:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-10-26 at 12:24 +0300, Cristian Iorga wrote:
> User introduced proxy settings were not saved
> when a proxy details input dialog was opened.
> The proxy settings were lost upon return, and
> restored from the previously stored one.
> 
> Also:
> Code cleanup:
> details_cb() function duplicate definition
> removed
> 
> Fixes [YOCTO #3240]
> 
> Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hig.py |   17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)

Merged to master, thanks.

Richard



