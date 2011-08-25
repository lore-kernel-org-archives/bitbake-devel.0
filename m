Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QwPog-0004Do-3Z for bitbake-devel@lists.openembedded.org;
	Thu, 25 Aug 2011 04:37:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7P2WPWF026233;
	Thu, 25 Aug 2011 03:32:25 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26102-02; Thu, 25 Aug 2011 03:32:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7P2WD9c026227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Aug 2011 03:32:16 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <e76e1c04b606616d34997c6cc44899832ff200ec.1314216131.git.josh@linux.intel.com>
References: <cover.1314216131.git.josh@linux.intel.com>
	<e76e1c04b606616d34997c6cc44899832ff200ec.1314216131.git.josh@linux.intel.com>
Date: Wed, 24 Aug 2011 19:32:11 -0700
Message-ID: <1314239531.5939.174.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bb/fetch2/git: add checkstatus command
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
X-List-Received-Date: Thu, 25 Aug 2011 02:37:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-08-24 at 13:04 -0700, Joshua Lock wrote:
> Use git ls-remote to implement checkstatus command for the git fetcher.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/fetch2/git.py |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 25c2c51..97bf086 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -298,3 +298,11 @@ class Git(FetchMethod):
>          buildindex = "%s" % output.split()[0]
>          logger.debug(1, "GIT repository for %s in %s is returning %s revisions in rev-list before %s", url, ud.clonedir, buildindex, rev)
>          return buildindex
> +
> +    def checkstatus(self, uri, ud, d):
> +        fetchcmd = "%s ls-remote %s" % (ud.basecmd, uri)
> +        try:
> +            runfetchcmd(fetchcmd, d, quiet=True)
> +            return True
> +        except FetchError:
> +            return False

Merged to master, thanks.

Richard




