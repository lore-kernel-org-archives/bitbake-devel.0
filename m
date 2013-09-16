Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2F4246C82A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 14:11:16 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GEPGbe015221; Mon, 16 Sep 2013 15:25:16 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RpOsNDOom9Tr; Mon, 16 Sep 2013 15:25:15 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GEPCdt015210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 15:25:14 +0100
Message-ID: <1379340656.3484.309.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 15:10:56 +0100
In-Reply-To: <039a39382824feb5ed5e28a8beb40855a6657170.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<039a39382824feb5ed5e28a8beb40855a6657170.1379338189.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/7] bitbake: cooker: add extra recipe information
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
X-List-Received-Date: Mon, 16 Sep 2013 14:11:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Adding in the extra recipe information when creating
> the dependency tree information.
> 
> This works in server-mode because the HOB extra_cache
> is already enabled. In normal mode, it will do nothing
> with no performance impact.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/cooker.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 68a3c01..cb0e3e5 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -439,6 +439,29 @@ class BBCooker:
>                  depend_tree["pn"][pn] = {}
>                  depend_tree["pn"][pn]["filename"] = fn
>                  depend_tree["pn"][pn]["version"] = version
> +
> +                # This data is needed for webhob;
> +                # it's here if the bitbake runs in server mode
> +                try:
> +                    summary = self.recipecache.summary[fn]
> +                    lic = self.recipecache.license[fn]
> +                    section = self.recipecache.section[fn]
> +                    description = self.recipecache.description[fn]
> +                    homepage = self.recipecache.homepage[fn]
> +                    bugtracker = self.recipecache.bugtracker[fn]
> +                    inherits = self.recipecache.inherits.get(fn, None)
> +                    depend_tree["pn"][pn]["filename"] = fn
> +                    depend_tree["pn"][pn]["version"] = version
> +                    depend_tree["pn"][pn]["summary"] = summary
> +                    depend_tree["pn"][pn]["license"] = lic
> +                    depend_tree["pn"][pn]["section"] = section
> +                    depend_tree["pn"][pn]["description"] = description
> +                    depend_tree["pn"][pn]["inherits"] = inherits
> +                    depend_tree["pn"][pn]["homepage"] = homepage
> +                    depend_tree["pn"][pn]["bugtracker"] = bugtracker
> +                except:
> +                    pass
> +
>              for dep in rq.rqdata.runq_depends[task]:
>                  depfn = taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
>                  deppn = self.recipecache.pkg_fn[depfn]

This is horrible, please try and do something like:

diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
index 9e38a43..041ba0e 100644
--- a/bitbake/lib/bb/cache_extra.py
+++ b/bitbake/lib/bb/cache_extra.py
@@ -67,3 +67,6 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.bugtracker[fn] = self.bugtracker
         cachedata.prevision[fn] = self.prevision
         cachedata.files_info[fn] = self.files_info
+
+    @staticmethod
+    def addDepTreePackageInfo(xxx)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2c8d4dc..84d62e5 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -485,6 +485,10 @@ class BBCooker:
                         depend_tree["packages"][package]["filename"] = fn
                         depend_tree["packages"][package]["version"] = version
 
+                        for extracache in self.cooker.caches_array:
+                            if <executable function>:
+                                 <function>(depend_tree["packages"][package])
+
         return depend_tree

so the extra cache info is added as a staticmethod function in the extra
cache info file which generated the data. You might as well fix the
hardcoding in the following function marked with:

     ######## WARNING : this function requires cache_extra to be enabled ########

to use this approach too whilst you're doing this.

Thanks,

Richard


