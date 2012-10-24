Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TR7V1-000176-7S for bitbake-devel@lists.openembedded.org;
	Wed, 24 Oct 2012 22:24:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKAqUL007350;
	Wed, 24 Oct 2012 21:10:52 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06391-07; Wed, 24 Oct 2012 21:10:46 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKAigm007343
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2012 21:10:45 +0100
Message-ID: <1351109444.22340.127.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristian Iorga <cristian.iorga@intel.com>
Date: Wed, 24 Oct 2012 21:10:44 +0100
In-Reply-To: <1350377558-26471-1-git-send-email-cristian.iorga@intel.com>
References: <1350377558-26471-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: hob/hobwidget: "Brought in by" column is now displayed correctly
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
X-List-Received-Date: Wed, 24 Oct 2012 20:24:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-10-16 at 11:52 +0300, Cristian Iorga wrote:
> In "Edit Recipes" and "Edit packages" pages, the "Brought in by"
> column is displayed correctly, with the right number of additional
> packages and a proper title.
> 
> Fixes [YOCTO #2195].
> 
> Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hobwidget.py            |   10 ++++++++--
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
>  3 files changed, 10 insertions(+), 4 deletions(-)

Merged to master, thanks.

Richard



