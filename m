Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T3oOE-0005KC-Nj for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 15:21:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7LD8w8b013087;
	Tue, 21 Aug 2012 14:08:58 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12527-01; Tue, 21 Aug 2012 14:08:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7LD8pqV013081
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Aug 2012 14:08:52 +0100
Message-ID: <1345554532.3907.76.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 21 Aug 2012 14:08:52 +0100
In-Reply-To: <2caf68f6aa334948840a647d7c34a59f0405d11b.1344482807.git.liezhi.yang@windriver.com>
References: <cover.1344482807.git.liezhi.yang@windriver.com>
	<2caf68f6aa334948840a647d7c34a59f0405d11b.1344482807.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] fetch2/__init__.py: add an "auto" policy for BB_SRCREV_POLICY
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
X-List-Received-Date: Tue, 21 Aug 2012 13:21:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-08-09 at 16:56 +0800, Robert Yang wrote:
> The newly added "auto" policy is used for the SRCREV="${AUTOREV}" recipe,
> the current BB_SRCREV_POLICY are: "clear" (default) and "cache":
> 
> * When "clear", the "AUTOREV" recipe will not be cached in bb_cache.dat
> 
> * When "cache", the "AUTOREV" would be cached in bb_cache.dat, but it
>   doesn't try to get the latest revision.
> 
> The "auto" policy is much like the "cache" except that it will try to
> get the latest revision.
> 
> [YOCTO #2920]
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)

I've been asked why I've not taken this. The simple answer is that I
can't figure out why we need to do this. The commit message above says
what was done but not why.

I also strongly dislike "auto" as a name for this mode. "clear" and
"cache" are at least descriptions of the behaviour, "auto" is not.

So can you please explain why we need this change? What use case does it
fix or improve or how is it useful? At the very least the commit message
needs rewriting and the option renaming.

> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 12ebce2..27b73c0 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -249,8 +249,8 @@ def fetcher_init(d):
>      Calls before this must not hit the cache.
>      """
>      # When to drop SCM head revisions controlled by user policy
> -    srcrev_policy = d.getVar('BB_SRCREV_POLICY', True) or "clear"
> -    if srcrev_policy == "cache":
> +    srcrev_policy = get_srcrev_policy(d)
> +    if srcrev_policy == "cache" or srcrev_policy == "auto":
>          logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
>      elif srcrev_policy == "clear":
>          logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
> @@ -384,9 +384,13 @@ def subprocess_setup():
>      # SIGPIPE errors are known issues with gzip/bash
>      signal.signal(signal.SIGPIPE, signal.SIG_DFL)
>  
> +def get_srcrev_policy(d):
> +    return d.getVar('BB_SRCREV_POLICY', True) or "auto"
> +
>  def get_autorev(d):
>      #  only not cache src rev in autorev case
> -    if d.getVar('BB_SRCREV_POLICY', True) != "cache":
> +    srcrev_policy = get_srcrev_policy(d)
> +    if srcrev_policy != "cache" and srcrev_policy != "auto":
>          d.setVar('__BB_DONT_CACHE', '1')

This looks highly suspect. If you do this, it won't check the upstream
revision at each invocation of bitbake which is how AUTOINC is meant to
behave.

Now if you want that behaviour, fine, but calling it "auto" is rather
misleading. It also seems to contradict your statement above that you
want the latest revision since with this you won't always get it.

Cheers,

Richard

>      return "AUTOINC"
>  
> @@ -1048,6 +1052,8 @@ class FetchMethod(object):
>  
>          revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
>          key = self.generate_revision_key(url, ud, d, name)
> +        if get_srcrev_policy(d) == "auto":
> +            revs[key] = self._latest_revision(url, ud, d, name)
>          try:
>              return revs[key]
>          except KeyError:




