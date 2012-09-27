Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1THGSb-0000tg-96 for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 17:57:10 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFiEDO000362;
	Thu, 27 Sep 2012 16:44:14 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32240-09; Thu, 27 Sep 2012 16:44:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8RFi4UE000356
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 16:44:05 +0100
Message-ID: <1348760645.11186.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
Date: Thu, 27 Sep 2012 16:44:05 +0100
In-Reply-To: <1348667997-7165-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1348667997-7165-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] [hob] Add sanity check progress screen
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
X-List-Received-Date: Thu, 27 Sep 2012 15:57:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-26 at 16:59 +0300, Bogdan Marinescu wrote:
> This patch adds a sanity check progress screen to hob. The screen
> is displayed when Hob executes the sanity check procedure. The screen
> is displayed for at least 5 seconds. If a network error is detected,
> a special dialog is displayed which lets the user open the proxy
> configuration page directly.
> Note that currently bitbake triggers the network tests only when
> the value of its TMPDIR variable changes, which happens fairly rare
> on my system. This is the subject of another bug (#3026).
> Version 2 of the patch splits the changes in two parts (sanity.bbclass
> belongs to oe-core).
> 
> [YOCTO #3025]
> 
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> ---
>  bitbake/lib/bb/event.py                     |    3 +-
>  bitbake/lib/bb/ui/crumbs/builder.py         |  124 ++++++++++++++++++++++++---
>  bitbake/lib/bb/ui/crumbs/hig.py             |    5 ++
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 +-
>  bitbake/lib/bb/ui/crumbs/sanitycheckpage.py |   85 ++++++++++++++++++
>  5 files changed, 205 insertions(+), 17 deletions(-)
>  create mode 100644 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py


Merged to master, thanks.

Richard



