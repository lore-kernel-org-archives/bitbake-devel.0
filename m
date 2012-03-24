Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBElL-0001EY-6m
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:23:19 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 23 Mar 2012 17:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="144382460"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2012 17:14:10 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
In-Reply-To: <alpine.DEB.2.02.1203221552180.21491@oneiric>
References: <alpine.DEB.2.02.1203221552180.21491@oneiric>
Date: Sat, 24 Mar 2012 08:11:59 +0800
Message-ID: <1332547919.1849.3.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Fix typo: BB_NUMBER_THREAD -> BB_NUMBER_THREADS
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
X-List-Received-Date: Sat, 24 Mar 2012 00:23:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-22 at 15:54 -0400, Robert P. J. Day wrote:
> Correct some apparent misspellings of BB_NUMBER_THREADS.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Actually these are Hob self-defined variables in its template, and it
will not impact the functionality. But definitely we missed the 's' in
BB_NUMBER_THREADS. Thanks for finding that.

Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> 
> ---
> 
> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> index 5a292e7..619f1d4 100755
> --- a/lib/bb/ui/crumbs/builder.py
> +++ b/lib/bb/ui/crumbs/builder.py
> @@ -75,7 +75,7 @@ class Configuration:
>          self.sstatedir = template.getVar("SSTATE_DIR")
>          self.sstatemirror = template.getVar("SSTATE_MIRROR")
>          self.pmake = int(template.getVar("PARALLEL_MAKE").split()[1])
> -        self.bbthread = int(template.getVar("BB_NUMBER_THREAD"))
> +        self.bbthread = int(template.getVar("BB_NUMBER_THREADS"))
>          self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
>          self.image_extra_size = int(template.getVar("IMAGE_EXTRA_SPACE"))
>          # image_overhead_factor is read-only.
> @@ -103,7 +103,7 @@ class Configuration:
>          template.setVar("SSTATE_DIR", self.sstatedir)
>          template.setVar("SSTATE_MIRROR", self.sstatemirror)
>          template.setVar("PARALLEL_MAKE", "-j %s" % self.pmake)
> -        template.setVar("BB_NUMBER_THREAD", self.bbthread)
> +        template.setVar("BB_NUMBER_THREADS", self.bbthread)
>          template.setVar("PACKAGE_CLASSES", " ".join(["package_" + i for i in self.curr_package_format.split()]))
>          template.setVar("IMAGE_ROOTFS_SIZE", self.image_rootfs_size)
>          template.setVar("IMAGE_EXTRA_SPACE", self.image_extra_size)
> diff --git a/lib/bb/ui/crumbs/template.py b/lib/bb/ui/crumbs/template.py
> index a03063c..5679c18 100644
> --- a/lib/bb/ui/crumbs/template.py
> +++ b/lib/bb/ui/crumbs/template.py
> @@ -125,7 +125,7 @@ class RecipeFile(ConfigFile):
> 
>  class TemplateMgr(gobject.GObject):
> 
> -    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRROR", "PARALLEL_MAKE", "BB_NUMBER_THREAD", "CONF_VERSION"]
> +    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRROR", "PARALLEL_MAKE", "BB_NUMBER_THREADS", "CONF_VERSION"]
>      __gBBLayersVars__ = ["BBLAYERS", "LCONF_VERSION"]
>      __gRecipeVars__ = ["DEPENDS", "IMAGE_INSTALL"]
> 
> 




