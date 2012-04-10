Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHk0o-0000qT-RB for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 00:58:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMmkoN001446;
	Tue, 10 Apr 2012 23:48:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00840-09; Tue, 10 Apr 2012 23:48:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMmbrv001440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Apr 2012 23:48:38 +0100
Message-ID: <1334098116.10826.79.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Tue, 10 Apr 2012 23:48:36 +0100
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Hob tweaks
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
X-List-Received-Date: Tue, 10 Apr 2012 22:58:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-04-06 at 16:18 -0700, Joshua Lock wrote:
> A series of minor tweaks based on feedback from design in bug #2182
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=2182
> 
> Cheers,
> Joshua
> 
> The following changes since commit d49db15badb77855cef855ee73430fcbc16b6916:
> 
>   Hob: a minor fix on pmake (2012-04-05 18:47:37 +0100)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> 
> Joshua Lock (4):
>   lib/bb/ui/crumbs: only display one 'Brought in by' item in Hob trees
>   lib/bb/ui/crumbs/recipeselectionpage: include 'Group' in 'Included'
>     view
>   lib/bb/ui/crumbs/[recipe|package]selectionpage: fixed width Included
>     col
>   selectionpage: show persistent tooltips on click

Merged to master, thanks.

Richard



