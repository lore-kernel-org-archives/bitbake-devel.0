Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TS2Pd-0006AN-8S for bitbake-devel@lists.openembedded.org;
	Sat, 27 Oct 2012 11:10:38 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9R8v0nM005940;
	Sat, 27 Oct 2012 09:57:00 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05673-02; Sat, 27 Oct 2012 09:56:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9R8uqdp005934
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 27 Oct 2012 09:56:53 +0100
Message-ID: <1351328210.22340.217.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristian Iorga <cristian.iorga@intel.com>
Date: Sat, 27 Oct 2012 09:56:50 +0100
In-Reply-To: <1351179450-17508-1-git-send-email-cristian.iorga@intel.com>
References: <1351179450-17508-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: hob/builder: Hob crashes because of bad init
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
X-List-Received-Date: Sat, 27 Oct 2012 09:10:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-10-25 at 18:37 +0300, Cristian Iorga wrote:
> Image selection is not properly initialized to none,
> and it used before having a chance to have a value.
> Due to dynamic nature of Python, variable is used before
> it exists, in this case. This causes a crash.
> Bug introduced during the fix of [YOCTO #3228]
> 
> Fixes [YOCTO #3334]
> 
> Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py |    1 +
>  1 file changed, 1 insertion(+)

Merged to master, thanks.

Richard



