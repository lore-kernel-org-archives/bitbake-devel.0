Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rEK-0003UM-7U
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:38:38 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 Feb 2012 13:30:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112980149"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:30:05 -0800
Message-ID: <4F4E98DC.1000007@linux.intel.com>
Date: Wed, 29 Feb 2012 13:30:04 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<5a158f5e8818f75e2938dd6dc3038414ca918212.1330523904.git.shane.wang@intel.com>
In-Reply-To: <5a158f5e8818f75e2938dd6dc3038414ca918212.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 24/32] Hob(crumbs/hoblistmodel.py): Add mapping for rprovides and pkg
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
X-List-Received-Date: Wed, 29 Feb 2012 21:38:38 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 29/02/12 06:15, Shane Wang wrote:
> From: Dongxiao Xu<dongxiao.xu@intel.com>
>
> When checking the package's RDEPENDS information, we will see some case like
> A RDEPENDS virtual-b, and B RPROVIDES virtual-b, we need to reflect this relationship
> in packaging selection.
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   18 +++++++++++++++---
>   1 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> index e440979..e910944 100644
> --- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -51,6 +51,7 @@ class PackageListModel(gtk.TreeStore):
>           self.pkgs_size = 0
>           self.pn_path = {}
>           self.pkg_path = {}
> +        self.rprov_pkg = {}
>
>           gtk.TreeStore.__init__ (self,
>                                   gobject.TYPE_STRING,
> @@ -71,10 +72,18 @@ class PackageListModel(gtk.TreeStore):
>       Returns the path in the model or None
>       """
>       def find_path_for_item(self, item_name):
> +        pkg = item_name
> +        if item_name == "virtual-locale-en-gb":
> +            print("xdx: item name in pkg_path.keys: %s" % (item_name in self.pkg_path.keys()))
> +            print("xdx: item name in rprov_pkg.keys: %s" % (item_name in self.rprov_pkg.keys()))

Was this left in on purpose?

>           if item_name not in self.pkg_path.keys():
> -            return None
> -        else:
> -            return self.pkg_path[item_name]
> +            if item_name not in self.rprov_pkg.keys():
> +                return None
> +            pkg = self.rprov_pkg[item_name]
> +            if pkg not in self.pkg_path.keys():
> +                return None
> +
> +        return self.pkg_path[pkg]
>
>       def find_item_for_path(self, item_path):
>           return self[item_path][self.COL_NAME]
> @@ -137,6 +146,7 @@ class PackageListModel(gtk.TreeStore):
>           self.pkgs_size = 0
>           self.pn_path = {}
>           self.pkg_path = {}
> +        self.rprov_pkg = {}
>
>           for pkginfo in pkginfolist:
>               pn = pkginfo['PN']
> @@ -160,6 +170,8 @@ class PackageListModel(gtk.TreeStore):
>               rdep = pkginfo['RDEPENDS_%s' % pkg] if 'RDEPENDS_%s' % pkg in pkginfo.keys() else ""
>               rrec = pkginfo['RRECOMMENDS_%s' % pkg] if 'RRECOMMENDS_%s' % pkg in pkginfo.keys() else ""
>               rprov = pkginfo['RPROVIDES_%s' % pkg] if 'RPROVIDES_%s' % pkg in pkginfo.keys() else ""
> +            for i in rprov.split():
> +                self.rprov_pkg[i] = pkg
>
>               if 'ALLOW_EMPTY_%s' % pkg in pkginfo.keys():
>                   allow_empty = pkginfo['ALLOW_EMPTY_%s' % pkg]

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


