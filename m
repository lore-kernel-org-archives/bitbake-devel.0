Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4AfD-0008Mm-Pq for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 15:08:04 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCtvoQ003176;
	Wed, 22 Aug 2012 13:55:57 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02180-09; Wed, 22 Aug 2012 13:55:52 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCtljU003169
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2012 13:55:48 +0100
Message-ID: <1345640148.3907.111.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristian Iorga <cristian.iorga@intel.com>
Date: Wed, 22 Aug 2012 13:55:48 +0100
In-Reply-To: <1345562483-973-1-git-send-email-cristian.iorga@intel.com>
References: <1345562483-973-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Hob wizard-like reorganization
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
X-List-Received-Date: Wed, 22 Aug 2012 13:08:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-08-21 at 18:21 +0300, Cristian Iorga wrote:
> Hob is now more context-sensitive regarding
> user changes/options. Also, the workflow have been
> streamlined and resembles more of a wizard.
> Beautified some hardcoded values.
> Fixed typo.
> New streamlined Image Configuration page.
> Build and/or Edit image buttons presence
> is context sensitive.
> Recipes and packages tabs selected automatically
> based on custom image or pre-defined target image
> (included or all).
> Context sensitive Back button.
> 
> Fixes [YOCTO 2165]
> 
> Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py       |    2 +-
>  bitbake/lib/bb/ui/crumbs/builder.py                |   23 +++++--
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    5 +-
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   68 +++++++-------------
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   16 +++--
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   15 +++--
>  6 files changed, 69 insertions(+), 60 deletions(-)

Thanks, merged to master.

Cheers,

Richard



