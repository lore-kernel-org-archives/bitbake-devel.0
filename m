Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TgdWv-0006tg-LL for bitbake-devel@lists.openembedded.org;
	Thu, 06 Dec 2012 16:38:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB6FNwvO030160;
	Thu, 6 Dec 2012 15:23:58 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29127-08; Thu,  6 Dec 2012 15:23:54 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB6FNmxD030153
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Dec 2012 15:23:50 GMT
Message-ID: <1354807419.12928.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Thu, 06 Dec 2012 15:23:39 +0000
In-Reply-To: <alpine.DEB.2.02.1212051341001.24855@oneiric>
References: <alpine.DEB.2.02.1212051341001.24855@oneiric>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: is there a reason a bitbake "git" clone will hang while regular git works?
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
X-List-Received-Date: Thu, 06 Dec 2012 15:38:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-12-05 at 13:49 -0500, Robert P. J. Day wrote:
> since the git fetcher code is part of bitbake, i figured i'd ask
> here.  on more than one occasion now, when i've configured a build and
> start fetching, the git fetch of the corresponding kernel source will
> simply hang.
> 
>   for example, right now, i'm fetching for a dm814x-evm (using the
> meta-ti layer), and the dir under git2 in the downloads directory
> currently looks like this:
> 
> $ du -s *
> 4	branches
> 4	config
> 4	description
> 4	HEAD
> 40	hooks
> 8	info
> 12	objects
> 12	refs
> $
> 
> and it hasn't changed for well over 10 minutes. the relevant part of
> the recipe file:
> 
> SRC_URI +=
> "git://arago-project.org/git/projects/linux-omap3.git;protocol=git;branch=ti81xx-master \
> file://0001-ti814x-added-code-for-disabling-the-least-significan.patch \
>             file://defconfig"
> 
>   however, as a test that git was still working properly, i simply
> started a git clone of that SRC_URI and it's chugging away as i type.
> and this has happened before -- that is, while the bitbake fetch/git
> clone hangs almost immediately, i can generally use "git clone" from
> the command line for that SRC_URI no problem.
> 
>   does that even make sense?  are the git options being used by
> bitbake perhaps causing this?

Is it running a git clone or is it fetching a tarball from the source
mirror?

The options used by bitbake shouldn't be different in operation to the
ones you use on the commandline. You could poke around /proc/xxx/cmdline
to take a look...

Cheers,

Richard



