Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TGrB7-0008UH-20
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 14:57:25 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Sep 2012 05:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,490,1344236400"; d="scan'208";a="213549999"
Received: from unknown (HELO helios.localnet) ([10.252.122.36])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2012 05:44:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Wed, 26 Sep 2012 13:44:32 +0100
Message-ID: <6275450.dtSHCTgVYP@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9.1 (Linux/3.2.0-31-generic-pae; KDE/4.9.1; i686; ; )
In-Reply-To: <1348648854-4588-1-git-send-email-cristiana.voicu@intel.com>
References: <1348648854-4588-1-git-send-email-cristiana.voicu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/builddetailspage: change branch field
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
X-List-Received-Date: Wed, 26 Sep 2012 12:57:25 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristiana,

On Wednesday 26 September 2012 11:40:54 Cristiana Voicu wrote:
> When a user makes a build from a tarball, it shows fatal error in branch
> field. Now it not complains as a fatal error. It is a normal message.
> 
> [YOCTO #3114]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py index a927c21..816ffde
> 100755
> --- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> +++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
> @@ -99,6 +99,8 @@ class BuildConfigurationTreeView(gtk.TreeView):
>              import os, os.path
>              if os.path.exists(path):
>                  branch = bb.process.run('cd %s; git branch | grep "^* " |
> tr -d "* "' % path)[0] +                if branch.startswith("fatal: Not a
> git repository"): +                    branch = branch[7:]
>                  if branch:
>                      branch = branch.strip('\n')
>                      vars.append(self.set_vars("Branch:", branch))

I'd rather we just show "(unknown)" here if it fails rather than "not a git 
repository..." - could you change it to do that?

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


