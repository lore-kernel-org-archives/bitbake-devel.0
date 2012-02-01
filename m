Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rsbwr-0007Wd-R1 for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:18:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q11FAH2u023270;
	Wed, 1 Feb 2012 15:10:17 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22959-04; Wed,  1 Feb 2012 15:10:13 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q11FABKK023264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Feb 2012 15:10:11 GMT
Message-ID: <1328109015.13744.74.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 01 Feb 2012 15:10:15 +0000
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] bitbake-layers improvements
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
X-List-Received-Date: Wed, 01 Feb 2012 15:18:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-01-30 at 16:25 +0000, Paul Eggleton wrote:
> Make some significant improvements to bitbake-layers that should provide
> more information about what files each layer is overlaying as well as
> making the utility easier to use.
> 
> The following changes (against Poky, but apply cleanly with -p2 against
> bitbake master) are available in the git repository at:
>   git://git.yoctoproject.org/poky-contrib paule/bitbake-layers-fix5
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-fix5
> 
> Paul Eggleton (6):
>   bitbake-layers: add copyright notice
>   bitbake-layers: use dashes in subcommands
>   bitbake-layers: use directory name as layer name
>   bitbake-layers: improve show-overlayed output
>   bitbake-layers: add show-recipes subcommand
>   bitbake-layers: list overlayed classes in show-overlayed

Merged to master, thanks.

Richard



