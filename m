Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SBlWD-0004xX-UI for bitbake-devel@lists.openembedded.org;
	Sun, 25 Mar 2012 13:21:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2PBCsuA015396;
	Sun, 25 Mar 2012 12:12:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12598-10; Sun, 25 Mar 2012 12:12:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2PBClvt015389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Mar 2012 12:12:48 +0100
Message-ID: <1332673967.28414.76.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Sun, 25 Mar 2012 12:12:47 +0100
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/9] Hob visual refinements to more closely match design
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
X-List-Received-Date: Sun, 25 Mar 2012 11:21:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:22 -0700, Joshua Lock wrote:
> This series of patches is developed to make the Hob GUI look more like the proposed
> visual design.
> 
> The series includes two significant changes:
> 
> * a set of changes to change all dialogue buttons to the primary/secondary action
> styling (big orange buttons that draw users in for the primary action help the
> user feel guided through the GUI, blue subtle link-like buttons for secondary
> actions).
> 
> * using the PersistentTooltip widget for the 'Brought in by' dialogues to more
> closely match the design.
> 
> These can both be seen in the screenshot here:
> https://wiki.yoctoproject.org/wiki/File:Hob2-visual-preview-230312.png
> 
> Cheers,
> 
> Joshua
> 
> The following changes since commit 0348ef08db9ac425d83126d2e6eb465adc28b110:
> 
>   Hob: Change the descriptions for view_recipe_button and view_package_button (2012-03-23 16:09:35 +0000)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> 
> Joshua Lock (9):
>   lib/bb/ui/crumbs/hig: sort layers in Layer Selection dialogue
>   lib/bb/ui/crumbs/hobwidget: HobAltButton different visual when
>     insensitive
>   lib/bb/ui/crumbs/builddetailspage: fix label on 'Back' button
>   lib/bb/ui/crumbs/hobwidget: convert button styling logic to static
>     methods
>   lib/bb/ui/crumbs/persistenttooltip: layout tweaks
>   lib/bb/ui/crumbs/persistenttooltip: ensure a reasonable minimum size
>   lib/bb/ui/crumbs: use a PersistentTooltip for the Brought in by
>     information

I merged these, thanks.

>  lib/bb/ui/crumbs/recipeselectionpage: add 'Build image' button per
>     design 
>   lib/bb/ui/crumbs: apply primary/secondary dialogue button styling

There were comments and I wasn't sure what I was supposed to do with
these so I've left them.

Cheers,

Richard



