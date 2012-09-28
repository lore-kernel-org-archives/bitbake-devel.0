Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THcum-0002Pr-4Q for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 17:55:44 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8SFgk3i012600;
	Fri, 28 Sep 2012 16:42:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12304-03; Fri, 28 Sep 2012 16:42:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8SFgbdT012594
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Sep 2012 16:42:38 +0100
Message-ID: <1348846959.15753.54.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristian Iorga <cristian.iorga@intel.com>
Date: Fri, 28 Sep 2012 16:42:39 +0100
In-Reply-To: <1348844753-7604-1-git-send-email-cristian.iorga@intel.com>
References: <1348844753-7604-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: Error reports are done in a clearer way
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
X-List-Received-Date: Fri, 28 Sep 2012 15:55:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-09-28 at 18:05 +0300, Cristian Iorga wrote:
> For long errors (bigger than 200 letters),
> the text box is scrollable and resizable
> and text is selectable.
> 
> Additionaly, all message dialogs are modal.
> Otherwise, a user could still interact with hob
> even in an error case, leading to potential problems.
> 
> See design details in related bugs.
> 
> Fixes [YOCTO #2960], [YOCTO #2983]
> 
> Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builder.py |    5 ++-
>  bitbake/lib/bb/ui/crumbs/hig.py     |   59 ++++++++++++++++++++++++++---------
>  2 files changed, 46 insertions(+), 18 deletions(-)

Merged to master, thanks.

Richard



