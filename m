Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RQHgn-0004Ds-Fc for bitbake-devel@lists.openembedded.org;
	Tue, 15 Nov 2011 13:00:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAFBsAl0024832;
	Tue, 15 Nov 2011 11:54:10 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24447-05; Tue, 15 Nov 2011 11:54:06 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAFBs1W9024826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Nov 2011 11:54:01 GMT
Message-ID: <1321358044.26881.166.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Tue, 15 Nov 2011 11:54:04 +0000
In-Reply-To: <1321036695-937-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1321036695-937-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] lib/bb/runqueue: avoid marking runtime dependencies as covered
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
X-List-Received-Date: Tue, 15 Nov 2011 12:00:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-11-11 at 18:38 +0000, Paul Eggleton wrote:
> The code which populates setscene_covered list was adding a task to the
> covered list if all of the tasks that depend upon it were also covered;
> however, this means that tasks that would have installed "runtime"
> dependencies were being marked as covered also, e.g. gmp-native and
> mpfr-native are needed by gcc-cross at runtime since they are shared
> libraries that gcc links to, but their do_populate_sysroot tasks were
> being marked as covered, resulting in failures later on if gcc-cross was
> available from sstate but mpfr-native and gmp-native weren't.
> 
> Since we currently have no real way to handle runtime dependencies for
> native packages, add a workaround which avoids marking tasks as covered
> if one or more of their revdeps are from a different recipe.
> 
> Fixes [YOCTO #1536].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  lib/bb/runqueue.py |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Applied to master, thanks.

I have some concerns about this change in that it will cause more "work"
in some cases even where it isn't needed. I'd rather that than the
current situation where we don't install enough of the sstate packages
though.

We're going to have to revisit this at some point but it makes sense to
apply this right now.

Cheers,

Richard



