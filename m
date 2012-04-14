Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SJ0G3-0008G5-Ll for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 12:31:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3EALi9N012931;
	Sat, 14 Apr 2012 11:21:45 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12528-03; Sat, 14 Apr 2012 11:21:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3EALb49012925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Apr 2012 11:21:37 +0100
Message-ID: <1334398898.7309.97.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Date: Sat, 14 Apr 2012 11:21:38 +0100
In-Reply-To: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
References: <1334325973-15760-1-git-send-email-enrico.scholz@informatik.tu-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] fetcher: quote filenames given in commands
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
X-List-Received-Date: Sat, 14 Apr 2012 10:31:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-04-13 at 16:06 +0200, Enrico Scholz wrote:
> Filenames were given as-is to shell commands. This causes problems
> when names contain characters which have a special meaning. E.g. when
> having a local systemd unit
> 
> | SRC_URI = "file://etc-machine\20id.mount"
> 
> the fetcher failed with
> 
> | NOTE: Unpacking .../etc-machine\20id.mount to ...
> | cp: cannot stat `.../etc-machine20id.mount': No such file or directory
> 
> Patch uses the pipes.quote() function to apply shell escaping.  These
> changes are not really complete; they are modifying __init__.py only
> but most fetchers need similar adaptations too.
> 
> Signed-off-by: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
> ---
>  lib/bb/fetch2/__init__.py |   38 +++++++++++++++++++++-----------------
>  1 files changed, 21 insertions(+), 17 deletions(-)

Whilst I understand what you're trying to fix, I'm afraid I don't like
the patch. I'd prefer to have one way of building these commands, rather
than two different ones with the shell=isinstance(cmd, basestring)
check.

We're stabilising for release at the moment and I don't have enough
confidence in these patches at this point in the cycle, particularly
since you change runfetchcmd but not other users in other fetch methods
other than git. I'm planning to hold off these until after that and even
then, I'd like to find a cleaner approach that doesn't involve
runfetchcmd2.

Cheers,

Richard



