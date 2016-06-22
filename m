Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E316D601B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2016 09:55:40 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 22 Jun 2016 02:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,509,1459839600"; d="scan'208";a="1002911919"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga002.jf.intel.com with ESMTP; 22 Jun 2016 02:55:40 -0700
Message-ID: <1466589339.6738.2.camel@linux.intel.com>
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2016 12:55:39 +0300
In-Reply-To: <1463563901-3979-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1463563901-3979-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Subject: Re: [PATCH] fetch2/git: allow using 'HEAD' as a branch name
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 Jun 2016 09:55:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Ping! I haven't seen any comments regarding this one, and, it hasn't
been merged, either.
  - Markus


On Wed, 2016-05-18 at 12:31 +0300, Markus Lehtonen wrote:
> This change makes it possible to e.g. build a currently checked out
> revision of a local Git repository and use AUTOREV. It will be
> possible
> to build HEAD of remote repositories, too, of course, but this is
> probably not that practical.
> 
> In order to use this one must also use the nobranch parameter, i.e.
> have
> 'branch=HEAD;nobranch=1' in the SRC_URI, because 'HEAD' is really not
> a
> Git branch as such. The wording in "branch=HEAD;nobranch=1" is
> probably a
> bit counter-intuitive and illogical but this seems to be the only
> easy
> way to make this work without complicating the fetcher even further.
> Another solution would be e.g. to introduce an alternative 'ref'
> parameter which could be used in place of 'branch' to give any ref.
> The
> effect would basically be the same (with better wording) with yet a
> bit
> more complex fetcher code.
> 
> [YOCTO #9351]
> 
> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
> ---
>  lib/bb/fetch2/git.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 526668b..99d7dc1 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -344,12 +344,15 @@ class Git(FetchMethod):
>          output = self._lsremote(ud, d, "")
>          # Tags of the form ^{} may not work, need to fallback to
> other form
>          if ud.unresolvedrev[name][:5] == "refs/":
> -            head = ud.unresolvedrev[name]
> -            tag = ud.unresolvedrev[name]
> +            search_list = [ud.unresolvedrev[name],
> +                           ud.unresolvedrev[name] + "^{}"]
> +        elif ud.unresolvedrev[name] == 'HEAD':
> +            search_list = ['HEAD']
>          else:
>              head = "refs/heads/%s" % ud.unresolvedrev[name]
>              tag = "refs/tags/%s" % ud.unresolvedrev[name]
> -        for s in [head, tag + "^{}", tag]:
> +            search_list = [head, tag + "^{}", tag]
> +        for s in search_list:
>              for l in output.split('\n'):
>                  if s in l:
>                      return l.split()[0]
> -- 
> 2.6.6
> 


