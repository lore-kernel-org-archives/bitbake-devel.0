Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7FD2675C49
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 16:54:49 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 09 Jul 2015 09:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,441,1432623600"; d="scan'208";a="761368124"
Received: from lkpandey-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.4.112])
	by orsmga002.jf.intel.com with ESMTP; 09 Jul 2015 09:54:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Thu, 09 Jul 2015 17:54:48 +0100
Message-ID: <4577144.KC5lOY8eR9@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.0.6-200.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <f4363d0889b1e45cdbde18bd6ae94115f783b82f.1436426161.git.liezhi.yang@windriver.com>
References: <cover.1436426161.git.liezhi.yang@windriver.com>
	<f4363d0889b1e45cdbde18bd6ae94115f783b82f.1436426161.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] git.py: create a branch when checkout
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
X-List-Received-Date: Thu, 09 Jul 2015 16:54:52 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 09 July 2015 00:18:01 Robert Yang wrote:
> * Create a branch and named as upstream branch when checkout source
> * Set the branch to track remote branch.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 2e53882..afa3d0a 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -279,8 +279,15 @@ class Git(FetchMethod):
>              if subdir != "":
>                  runfetchcmd("%s read-tree %s%s" % (ud.basecmd,
> ud.revisions[ud.names[0]], readpathspec), d) runfetchcmd("%s checkout-index
> -q -f -a" % ud.basecmd, d) 
> +            elif not ud.nobranch:
> +                branchname =  ud.branches[ud.names[0]]
> +                runfetchcmd("%s checkout -B %s %s" % (ud.basecmd,
> branchname, \ 
> +                            ud.revisions[ud.names[0]]), d)
> +                runfetchcmd("%s branch --set-upstream %s origin/%s" %
> (ud.basecmd, branchname, \ 
> +                            branchname), d)

Doesn't git checkout support a --track option so we could do this in one 
command rather than two?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

