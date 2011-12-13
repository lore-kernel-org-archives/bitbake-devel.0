Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RaVfo-0002rM-Jn
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 17:57:49 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 13 Dec 2011 08:46:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="46762988"
Received: from unknown (HELO [10.255.12.215]) ([10.255.12.215])
	by AZSMGA002.ch.intel.com with ESMTP; 13 Dec 2011 08:46:53 -0800
Message-ID: <4EE7817D.20507@linux.intel.com>
Date: Tue, 13 Dec 2011 08:46:53 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:8.0) Gecko/20111115 Thunderbird/8.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1323656120.git.dongxiao.xu@intel.com>
	<925c50cd17dbddca6228b40f6016338aee485e82.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <925c50cd17dbddca6228b40f6016338aee485e82.1323656120.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 06/10] command.py: add generateTargetsTreePro API
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
X-List-Received-Date: Tue, 13 Dec 2011 16:57:49 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 11/12/11 18:20, Dongxiao Xu wrote:
> Currently we have generateTargetsTree API, which is used to get
> dependency information. However in that tree, there will be
> "virtual/xxx" in depends fields. Therefore we need to replace it with
> its real providers.
> 
> Besides, for packages that provided by multiple recipes, we will find
> their preverred provider.
> 
> To make the original Hob working, we still keep the generateTargetsTree
> API.

I assume the 'original Hob' compatability will only be maintained until
Hobv2 is merged?

Is there anything preventing us from having an optional parameter on
generateTargetsTree to switch to pro mode rather than duplicating a
bunch of code and functionality on a temporary basis?

something like:

> +    def generateTargetsTree(self, command, params):
> +        """
> +        A pro version of generateTargetsTree
> +        """
> +        klass = params[0]
> +        param_len = len(params)
> +        if param_len 2:
> +            pkg_list = params[1]
> +            resolve = params[2]
> +        elif param_len > 1:
> +            pkg_list = params[1]
> +            resolve = false
> +        else:
> +            pkg_list = []
> +            resolve = false
> +
> +        command.cooker.generateTargetsTree(klass, pkg_list, resolve)
> +        command.finishAsyncCommand()
> +    generateTargetsTreePro.needcache = True


Then you can use the resolve boolean to switch the generateBlahBlahBlah
methods to operate in the old or new way. Method signature would be
something like:

> +    def generateTargetsTree(self, klass=None, pkgs=[], resolve=false):

> +    def generatePkgDepTreeDataPro(self, pkgs_to_build, task,
resolve=false):

Cheers,
Joshua

> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/command.py |   14 +++++++
>  lib/bb/cooker.py  |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index 6b4a598..15e7839 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -238,6 +238,20 @@ class CommandsAsync:
>          command.finishAsyncCommand()
>      generateTargetsTree.needcache = True
>  
> +    def generateTargetsTreePro(self, command, params):
> +        """
> +        A pro version of generateTargetsTree
> +        """
> +        klass = params[0]
> +        if len(params) > 1:
> +            pkg_list = params[1]
> +        else:
> +            pkg_list = []
> +
> +        command.cooker.generateTargetsTreePro(klass, pkg_list)
> +        command.finishAsyncCommand()
> +    generateTargetsTreePro.needcache = True
> +
>      def findConfigFiles(self, command, params):
>          """
>          Find config files which provide appropriate values
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 666242f..9f05d35 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -498,6 +498,85 @@ class BBCooker:
>  
>          return depend_tree
>  
> +    def generatePkgDepTreeDataPro(self, pkgs_to_build, task):
> +        """
> +        Create a dependency tree of pkgs_to_build, returning the data.
> +        """
> +        _, taskdata = self.prepareTreeData(pkgs_to_build, task)
> +        tasks_fnid = []
> +        if len(taskdata.tasks_name) != 0:
> +            for task in xrange(len(taskdata.tasks_name)):
> +                tasks_fnid.append(taskdata.tasks_fnid[task])
> +
> +        seen_fnids = []
> +        depend_tree = {}
> +        depend_tree["depends"] = {}
> +        depend_tree["pn"] = {}
> +        depend_tree["rdepends-pn"] = {}
> +        depend_tree["packages"] = {}
> +        depend_tree["rdepends-pkg"] = {}
> +
> +        for task in xrange(len(tasks_fnid)):
> +            fnid = tasks_fnid[task]
> +            fn = taskdata.fn_index[fnid]
> +            pn = self.status.pkg_fn[fn]
> +            version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
> +            summary = self.status.summary[fn]
> +            lic = self.status.license[fn]
> +            section = self.status.section[fn]
> +            rdepends = self.status.rundeps[fn]
> +            if pn not in depend_tree["pn"]:
> +                depend_tree["pn"][pn] = {}
> +                depend_tree["pn"][pn]["filename"] = fn
> +                depend_tree["pn"][pn]["version"] = version
> +                depend_tree["pn"][pn]["summary"] = summary
> +                depend_tree["pn"][pn]["license"] = lic
> +                depend_tree["pn"][pn]["section"] = section
> +                depend_tree["pn"][pn]["packages"] = rdepends.keys()
> +
> +            if fnid not in seen_fnids:
> +                seen_fnids.append(fnid)
> +                packages = []
> +
> +                depend_tree["depends"][pn] = []
> +                for dep in taskdata.depids[fnid]:
> +                    item = taskdata.build_names_index[dep]
> +                    pn_provider = ""
> +                    targetid = taskdata.getbuild_id(item)
> +                    if targetid in taskdata.build_targets:
> +                        fnid = taskdata.build_targets[targetid][0]
> +                        fn_provider = taskdata.fn_index[fnid]
> +                        pn_provider = self.status.pkg_fn[fn_provider]
> +                    else:
> +                        pn_provider = item
> +                    depend_tree["depends"][pn].append(pn_provider)
> +
> +                depend_tree["rdepends-pn"][pn] = []
> +                for rdep in taskdata.rdepids[fnid]:
> +                    depend_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep])
> +
> +                for package in rdepends:
> +                    depend_tree["rdepends-pkg"][package] = []
> +                    for rdepend in rdepends[package]:
> +                        depend_tree["rdepends-pkg"][package].append(rdepend)
> +                    packages.append(package)
> +
> +                for package in packages:
> +                    if package not in depend_tree["packages"]:
> +                        targetid = taskdata.getrun_id(package)
> +                        if targetid in taskdata.run_targets:
> +                            fnid = taskdata.run_targets[targetid][0]
> +                            fn = taskdata.fn_index[fnid]
> +                            pn = self.status.pkg_fn[fn]
> +                            version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
> +                        depend_tree["packages"][package] = {}
> +                        depend_tree["packages"][package]["pn"] = pn
> +                        depend_tree["packages"][package]["filename"] = fn
> +                        depend_tree["packages"][package]["version"] = version
> +
> +        return depend_tree
> +
> +
>      def generateDepTreeEvent(self, pkgs_to_build, task):
>          """
>          Create a task dependency graph of pkgs_to_build.
> @@ -746,6 +825,25 @@ class BBCooker:
>          tree = self.generatePkgDepTreeData(pkgs, 'build')
>          bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
>  
> +    def generateTargetsTreePro(self, klass=None, pkgs=[]):
> +        """
> +        Generate a dependency tree of buildable targets
> +        Check and add providers for each dependencies
> +        Generate an event with the result
> +        """
> +        # if the caller hasn't specified a pkgs list default to universe
> +        if not len(pkgs):
> +            pkgs = ['universe']
> +        # if inherited_class passed ensure all recipes which inherit the
> +        # specified class are included in pkgs
> +        if klass:
> +            extra_pkgs = self.findInheritsClass(klass)
> +            pkgs = pkgs + extra_pkgs
> +
> +        # generate a dependency tree for all our packages
> +        tree = self.generatePkgDepTreeDataPro(pkgs, 'build')
> +        bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
> +
>      def buildWorldTargetList(self):
>          """
>           Build package list for "bitbake world"

-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre


