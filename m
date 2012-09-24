Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TG6oj-00009A-IY for bitbake-devel@lists.openembedded.org;
	Mon, 24 Sep 2012 13:27:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OBEKtj028109;
	Mon, 24 Sep 2012 12:14:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27845-02; Mon, 24 Sep 2012 12:14:15 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8OBEC9l028103
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Sep 2012 12:14:14 +0100
Message-ID: <1348485253.8662.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Constantin Musca <constantinx.musca@intel.com>
Date: Mon, 24 Sep 2012 12:14:13 +0100
In-Reply-To: <1348223323-22195-1-git-send-email-constantinx.musca@intel.com>
References: <1348223323-22195-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: The title of the packages screen depends on the screen you arrive from
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
X-List-Received-Date: Mon, 24 Sep 2012 11:27:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-09-21 at 13:28 +0300, Constantin Musca wrote:
> - If you arrive to the packages screen from the recipes screen, the title
> should say: 'Step 2 of 2: Edit packages'
> - If you arrive to the packages screen from the image details screen, the
> title should say: 'Edit packages'
> - The title of the recipes screen should say 'Step 1 of 2: Edit recipes'
> 
> [YOCTO #2982]
> 
> Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py             |    2 ++
>  bitbake/lib/bb/ui/crumbs/hobpages.py            |    9 ++++++---
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)

Merged to master, thanks.

Richard



