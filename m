Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TBBD7-0003VF-5K for bitbake-devel@lists.openembedded.org;
	Mon, 10 Sep 2012 23:08:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8AKtQls003638;
	Mon, 10 Sep 2012 21:55:26 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01454-10; Mon, 10 Sep 2012 21:55:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8AKtJgH003630
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Sep 2012 21:55:20 +0100
Message-ID: <1347310520.31154.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 10 Sep 2012 21:55:20 +0100
In-Reply-To: <1347298006-29868-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1347298006-29868-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: rename task -> packagegroup in recipe selection
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
X-List-Received-Date: Mon, 10 Sep 2012 21:08:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-09-10 at 18:26 +0100, Paul Eggleton wrote:
> This changes the filtering to use the inheritance of
> packagegroup.bbclass to determine if a recipe is a package group.
> 
> Also makes the tab tooltip text generic; these recipes could come from
> any enabled layer, not just the default ones.
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py        |    4 ++--
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |   14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Merged to master, thanks (along with the other two patches).

Richard



