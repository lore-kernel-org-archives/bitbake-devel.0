Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SDM4R-0000C6-Fq for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 22:35:47 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKQgkR004780;
	Thu, 29 Mar 2012 21:26:42 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04256-06; Thu, 29 Mar 2012 21:26:37 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2TKQYwl004762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Mar 2012 21:26:35 +0100
Message-ID: <1333052793.18082.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Thu, 29 Mar 2012 21:26:33 +0100
In-Reply-To: <cover.1333025490.git.shane.wang@intel.com>
References: <cover.1333025490.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/8] Hob: bug fixes
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
X-List-Received-Date: Thu, 29 Mar 2012 20:35:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-29 at 20:54 +0800, Shane Wang wrote:
> This patchset includes the several Hob fixes:
>   - fix the icons to be consistent on the whole GUI
>   - fix the color style of the HobTabBar per visual design
>   - add more checks before being used to avoid bitbake exception
>   - fix the button label, etc.
> 
> The following changes since commit 0057d7fde8315694307637c4d23fd414a4a200f9:
> 
>   lib/bb/ui/crumbs/hig: fix layers_changed test (2012-03-29 10:44:54 +0800)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob
> 
> Liming An (2):
>   Hob: fixed the 'error' icon source picture and adjusted corresponding
>     showed icon size
>   Hob: in build details page, change error icon to denied icon
> 
> Shane Wang (6):
>   Hob: clear the building state after a successful build, as a failed
>     build does
>   Hob: Change icon to error because parsing error is an error
>   Hob: Change "Just bake" to "Build image" as required
>   Hob: make ORANGE to be the same as the color on the dialog
>   runqueue.py: check results[0] in keys of build_pids before being used
>     to avoid exceptions
>   Hob: some color style changes to make HobTabBar more close to visual
>     design

Merged to master apart from the runqueue change which I've commented on.

Cheers,

Richard



