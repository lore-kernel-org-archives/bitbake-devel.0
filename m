Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id C55226076F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Aug 2017 15:02:31 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga105.fm.intel.com with ESMTP; 25 Aug 2017 08:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,426,1498546800"; d="scan'208";a="144541860"
Received: from lsandov1-mobl2.zpn.intel.com ([10.219.128.134])
	by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2017 08:02:32 -0700
Message-ID: <1503673898.23732.3.camel@linux.intel.com>
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
To: "GUAN Ben (ST-FIR/ENG1-Zhu)" <Ben.Guan@cn.bosch.com>
Date: Fri, 25 Aug 2017 10:11:38 -0500
In-Reply-To: <3770d520be40403793f4021194082856@SGPMBX1024.APAC.bosch.com>
References: <3770d520be40403793f4021194082856@SGPMBX1024.APAC.bosch.com>
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: "Jonas Mark \(ST-FIR/ENG1\)" <Mark.Jonas@de.bosch.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: How to detect change on a repo manifest.git and rebuild the recipe with "repo://"
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
X-List-Received-Date: Fri, 25 Aug 2017 15:02:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2017-08-25 at 02:06 +0000, GUAN Ben (ST-FIR/ENG1-Zhu) wrote:
> The source code of my SW consist of multiple components from different
> repository, which is managed by a repo manifest repository. So I want
> to use “repo://” for the repo manifest repository instead of multiple
> “git://” to include all repositories in the SRC_URI.
>  
> I add the following to MyRecipe_git.bb:
> ```
> SRC_URI =
> “repo://git@<MY_HOST>/manifest.git;protocol=ssh;branch=master”
>  
> S = “${WORKDIR}/repo/MyRecipe”
> ```
>  
> And in my local.conf, I add the following:
> ```
> # Use this setting because I don’t have internet connection to
> external Android repo.git, I mirror one in the internal host
> REPO_URL = “git@<My_HOST>/repo.git”
> # Use “repo” command in the host
> HOSTTOOLS += “repo”
> # Because the my Yocto meta-layers are managed by repo also, use a
> different directory for my recipe 
> REPODIR = “/home/benguan/projects/MyRecipeRepo”
> ```
>  
> Now I can build my recipe with Yocto, but there is an issue:  When
> there is any change required in the repositories of my application, I
> will change the code and update the tags in default.xml of
> manifest.git. I want Yocto could detect this change, fetch the change,
> them rebuild the recipe.  


the easiest would be to 'repo sync & bitbake'. bitbake just handles its
metadata and from it figures out if needs to re-execute a task, so
better if you split the repository update and the bitbake as two
separate processes/steps.

>  
> With “git://”, it is easy to achieve via setting “${AUTOREV}” to
> “SRCREV”. But the fetch2.repo doesn’t support SRCREV. I have go
> through the existing recipe within meta-oe and oe-core, no recipe is
> using “repo://”.
>  
> Does anybody have experience about it and help? Thank you in advance.
>  
> -- 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel



