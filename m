Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDt-0003MQ-Mh
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:38:09 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979904"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:42 -0800
Message-ID: <4F4E98C5.8090600@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:41 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<38d3055dcefb5c50789b9cc87c86bf9688e72868.1330523904.git.shane.wang@intel.com>
In-Reply-To: <38d3055dcefb5c50789b9cc87c86bf9688e72868.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 23/32] Hob(crumbs/hoblistmodel.py): Fix recipe's populate() function
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
X-List-Received-Date: Wed, 29 Feb 2012 21:38:09 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 29/02/12 06:15, Shane Wang wrote:
> From: Dongxiao Xu<dongxiao.xu@intel.com>
>
> According to the cooker's change, this commit fixes the way to getting
> recipe's build dependency.
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   42 +++--------------------------
>   1 files changed, 5 insertions(+), 37 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> index 227ae4b..e440979 100644
> --- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -512,27 +512,6 @@ class RecipeListModel(gtk.ListStore):
>               it = view_model.iter_next(it)
>           return None
>
> -    def map_runtime(self, event_model, runtime, rdep_type, name):
> -        if rdep_type not in ['pkg', 'pn'] or runtime not in ['rdepends', 'rrecs']:
> -            return
> -        package_depends = event_model["%s-%s" % (runtime, rdep_type)].get(name, [])
> -        pn_depends = []
> -        for package_depend in package_depends:
> -            if 'task-' not in package_depend and package_depend in event_model["packages"].keys():
> -                pn_depends.append(event_model["packages"][package_depend]["pn"])
> -            else:
> -                pn_depends.append(package_depend)
> -        return list(set(pn_depends))
> -
> -    def subpkg_populate(self, event_model, pkg, desc, lic, group, atype, pn):
> -        pn_depends = self.map_runtime(event_model, "rdepends", "pkg", pkg)
> -        pn_depends += self.map_runtime(event_model, "rrecs", "pkg", pkg)
> -        self.set(self.append(), self.COL_NAME, pkg, self.COL_DESC, desc,
> -                 self.COL_LIC, lic, self.COL_GROUP, group,
> -                 self.COL_DEPS, " ".join(pn_depends), self.COL_BINB, "",
> -                 self.COL_TYPE, atype, self.COL_INC, False,
> -                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, pn)
> -
>       """
>       The populate() function takes as input the data from a
>       bb.event.TargetsTreeGenerated event and populates the RecipeList.
> @@ -558,38 +537,27 @@ class RecipeListModel(gtk.ListStore):
>               group = event_model["pn"][item]["section"]
>               install = []
>
> +            depends = event_model["depends"].get(item, [])
> +            rdepends = event_model["rdepends-pn"].get(item, [])
> +            depends = depends + rdepends
> +
>               if ('task-' in name):
>                   if ('lib32-' in name or 'lib64-' in name):
>                       atype = 'mltask'
>                   else:
>                       atype = 'task'
> -                for pkg in event_model["pn"][name]["packages"]:
> -                    self.subpkg_populate(event_model, pkg, desc, lic, group, atype, name)
> -                continue
> -
>               elif ('-image-' in name):
>                   atype = 'image'
> -                depends = event_model["depends"].get(item, [])
> -                rdepends = self.map_runtime(event_model, 'rdepends', 'pn', name)
> -                depends = depends + rdepends
> -                install = event_model["rdepends-pn"].get(item, [])
> -
> +                install = rdepends
>               elif ('meta-' in name):
>                   atype = 'toolchain'
> -
>               elif (name == 'dummy-image' or name == 'dummy-toolchain'):
>                   atype = 'dummy'
> -
>               else:
>                   if ('lib32-' in name or 'lib64-' in name):
>                       atype = 'mlrecipe'
>                   else:
>                       atype = 'recipe'
> -                depends = event_model["depends"].get(item, [])
> -                depends += self.map_runtime(event_model, 'rdepends', 'pn', item)
> -                for pkg in event_model["pn"][name]["packages"]:
> -                    depends += self.map_runtime(event_model, 'rdepends', 'pkg', item)
> -                    depends += self.map_runtime(event_model, 'rrecs', 'pkg', item)
>
>               self.set(self.append(), self.COL_NAME, item, self.COL_DESC, desc,
>                        self.COL_LIC, lic, self.COL_GROUP, group,

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


