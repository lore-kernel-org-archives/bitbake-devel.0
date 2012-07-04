Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SmQ4B-0002La-2g for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jul 2012 15:56:27 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64DjNue023867;
	Wed, 4 Jul 2012 14:45:23 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23521-04; Wed,  4 Jul 2012 14:45:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64DjB1b023855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2012 14:45:14 +0100
Message-ID: <1341409510.3906.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Wed, 04 Jul 2012 14:45:10 +0100
In-Reply-To: <1341136320-6242-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
References: <1341136320-6242-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: try PREMIRRORS when calculating latest_revision
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
X-List-Received-Date: Wed, 04 Jul 2012 13:56:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-07-01 at 11:52 +0200, Enrico Scholz wrote:
> Since support for native git mirrors was added in recent bitbake, it
> is possible to use local mirrors for calculating ${AUTOREV}.  This is
> very useful for development: recipes SRCREV can be overridden locally
> by 'SRCREV_pn-<recipe> = ${AUTOREV}' and a PREMIRROR which refers to a
> local repository can be added for the SRC_URI .
> 
> Patch checks PREMIRRORS only but not normal MIRRORS because:
> 
> a) it can break things when upstream is temporarily unavailable while
>    calling latest_revision() (--> MIRRORS will be consulted) but comes
>    back when fetching source.
> 
> b) it makes the error reporting more complicated (only errors for
>    upstream should be shown to user, not the MIRROR's ones).
> 
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  lib/bb/fetch2/__init__.py |   25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

I'm torn over this one. If you want to refer to local changes wouldn't
it make more sense just to totally override SRC_URI in cases like this,
then things are specific.

I'm worried that here, upstream revisions may just get ignored for
example with just a premirror copy being consulted and this wouldn't be
the expected behaviour a user would want.

Cheers,

Richard



