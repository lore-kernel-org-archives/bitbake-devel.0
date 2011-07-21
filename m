Received: from mail-ww0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>) id 1QjpFB-0003hs-Sg
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 11:08:35 +0200
Received: by wwi18 with SMTP id 18so847561wwi.24
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2011 02:04:26 -0700 (PDT)
Received: by 10.227.32.73 with SMTP id b9mr8571683wbd.107.1311239066771;
	Thu, 21 Jul 2011 02:04:26 -0700 (PDT)
Received: from [172.20.0.96] (ip545070eb.adsl-surfen.hetnet.nl [84.80.112.235])
	by mx.google.com with ESMTPS id gd1sm867435wbb.61.2011.07.21.02.04.24
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 21 Jul 2011 02:04:25 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1244.3)
From: Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <6ac3109c3cf221687a96606685fb209cb5d68556.1310696828.git.liping.ke@intel.com>
Date: Thu, 21 Jul 2011 11:04:22 +0200
Message-Id: <C7884CFB-DBBE-4EB0-9C21-88BDE564DDB4@dominion.thruhere.net>
References: <cover.1310696828.git.liping.ke@intel.com>
	<6ac3109c3cf221687a96606685fb209cb5d68556.1310696828.git.liping.ke@intel.com>
To: Ke Liping <liping.ke@intel.com>
X-Mailer: Apple Mail (2.1244.3)
X-Mailman-Approved-At: Thu, 21 Jul 2011 12:56:56 +0200
Cc: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [yocto] [PATCH 1/1][Image Creator] Remove unused target tree data for Hob
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
X-List-Received-Date: Thu, 21 Jul 2011 09:08:35 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Op 21 jul. 2011, om 07:50 heeft Ke Liping het volgende geschreven:

> From: Liping Ke <liping.ke@intel.com>
>=20
> Since Hob only needes package dependency information, we can
> create a new version of package information retrieving methods,
> remove task dependency information, so that we can greatly
> reduce data loading time for Hob


Does this fix the bug where DEPENDS are leaking into the RDEPENDS list? =
If you select something like systemd the gui will list 'gtk' as a =
runtime dep for the image, while it's only a transitive buildtime one.


>=20
> Signed-off-by: Liping Ke <liping.ke@intel.com>
> ---
> bitbake/lib/bb/cooker.py |   96 =
+++++++++++++++++++++++++++++++++++++---------
> 1 files changed, 77 insertions(+), 19 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 8badd2d..26ed2ae 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -296,13 +296,12 @@ class BBCooker:
>             if data.getVarFlag( e, 'python', envdata ):
>                 logger.plain("\npython %s () {\n%s}\n", e, =
data.getVar(e, envdata, 1))
>=20
> -    def prepareTreeData(self, pkgs_to_build, task):
> +    def prepareTreeData(self, pkgs_to_build, task, runqueue=3DTrue):
>         """
>         Prepare a runqueue and taskdata object for iteration over =
pkgs_to_build
>         """
>         # Need files parsed
>         self.updateCache()
> -
>         # If we are told to do the None task then query the default =
task
>         if (task =3D=3D None):
>             task =3D self.configuration.cmd
> @@ -322,12 +321,22 @@ class BBCooker:
>             runlist.append([k, "do_%s" % task])
>         taskdata.add_unresolved(localdata, self.status)
>=20
> -        rq =3D bb.runqueue.RunQueue(self, self.configuration.data, =
self.status, taskdata, runlist)
> -        rq.rqdata.prepare()
> -
> -        return taskdata, rq
> -
> -    def generateDepTreeData(self, pkgs_to_build, task, =
more_meta=3DFalse):
> +        # For some users, take Hob as example, we only need less =
dependency data
> +        # mark this kind of user as "less_meta" data requesterG
> +        if (runqueue):
> +            rq =3D bb.runqueue.RunQueue(self, =
self.configuration.data, self.status, taskdata, runlist)
> +            rq.rqdata.prepare()
> +            return taskdata, rq
> +        else:=20
> +            tasks_fnid =3D []
> +            if len(taskdata.tasks_name) =3D=3D 0:
> +            # Nothing to do
> +                return
> +            for task in xrange(len(taskdata.tasks_name)):
> +                tasks_fnid.append(taskdata.tasks_fnid[task])
> +            return taskdata, tasks_fnid
> +   =20
> +    def generateTaskDepTreeData(self, pkgs_to_build, task):
>         """
>         Create a dependency tree of pkgs_to_build, returning the data.
>         When more_meta is set to True include summary, license and =
group
> @@ -351,18 +360,10 @@ class BBCooker:
>             fn =3D taskdata.fn_index[fnid]
>             pn =3D self.status.pkg_fn[fn]
>             version  =3D "%s:%s-%s" % self.status.pkg_pepvpr[fn]
> -            if more_meta:
> -                summary =3D self.status.summary[fn]
> -                lic =3D self.status.license[fn]
> -                section =3D self.status.section[fn]
>             if pn not in depend_tree["pn"]:
>                 depend_tree["pn"][pn] =3D {}
>                 depend_tree["pn"][pn]["filename"] =3D fn
>                 depend_tree["pn"][pn]["version"] =3D version
> -                if more_meta:
> -                    depend_tree["pn"][pn]["summary"] =3D summary
> -                    depend_tree["pn"][pn]["license"] =3D lic
> -                    depend_tree["pn"][pn]["section"] =3D section
>             for dep in rq.rqdata.runq_depends[task]:
>                 depfn =3D taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
>                 deppn =3D self.status.pkg_fn[depfn]
> @@ -407,12 +408,69 @@ class BBCooker:
>         return depend_tree
>=20
>=20
> +    def generatePkgDepTreeData(self, pkgs_to_build, task):
> +        """
> +        Create a dependency tree of pkgs_to_build, returning the =
data.
> +        When more_meta is set to True include summary, license and =
group
> +        information in the returned tree.
> +        """
> +        taskdata, tasks_fnid =3D self.prepareTreeData(pkgs_to_build, =
task, False)
> +
> +        seen_fnids =3D []
> +        depend_tree =3D {}
> +        depend_tree["depends"] =3D {}
> +        depend_tree["pn"] =3D {}
> +        depend_tree["rdepends-pn"] =3D {}
> +        depend_tree["packages"] =3D {}
> +        depend_tree["rdepends-pkg"] =3D {}
> +
> +        for task in xrange(len(tasks_fnid)):
> +            fnid =3D tasks_fnid[task]
> +            fn =3D taskdata.fn_index[fnid]
> +            pn =3D self.status.pkg_fn[fn]
> +            version  =3D "%s:%s-%s" % self.status.pkg_pepvpr[fn]
> +            summary =3D self.status.summary[fn]
> +            lic =3D self.status.license[fn]
> +            section =3D self.status.section[fn]
> +            if pn not in depend_tree["pn"]:
> +                depend_tree["pn"][pn] =3D {}
> +                depend_tree["pn"][pn]["filename"] =3D fn
> +                depend_tree["pn"][pn]["version"] =3D version
> +                depend_tree["pn"][pn]["summary"] =3D summary
> +                depend_tree["pn"][pn]["license"] =3D lic
> +                depend_tree["pn"][pn]["section"] =3D section
> +
> +            if fnid not in seen_fnids:
> +                seen_fnids.append(fnid)
> +                packages =3D []
> +
> +                depend_tree["depends"][pn] =3D []
> +                for dep in taskdata.depids[fnid]:
> +                    =
depend_tree["depends"][pn].append(taskdata.build_names_index[dep])
> +
> +                depend_tree["rdepends-pn"][pn] =3D []
> +                for rdep in taskdata.rdepids[fnid]:
> +                    =
depend_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep])
> +
> +                rdepends =3D self.status.rundeps[fn]
> +                for package in rdepends:
> +                    packages.append(package)
> +
> +                for package in packages:
> +                    if package not in depend_tree["packages"]:
> +                        depend_tree["packages"][package] =3D {}
> +                        depend_tree["packages"][package]["pn"] =3D pn
> +                        depend_tree["packages"][package]["filename"] =
=3D fn
> +                        depend_tree["packages"][package]["version"] =3D=
 version
> +
> +        return depend_tree
> +   =20
>     def generateDepTreeEvent(self, pkgs_to_build, task):
>         """
>         Create a task dependency graph of pkgs_to_build.
>         Generate an event with the result
>         """
> -        depgraph =3D self.generateDepTreeData(pkgs_to_build, task)
> +        depgraph =3D self.generateTaskDepTreeData(pkgs_to_build, =
task)
>         bb.event.fire(bb.event.DepTreeGenerated(depgraph), =
self.configuration.data)
>=20
>     def generateDotGraphFiles(self, pkgs_to_build, task):
> @@ -421,7 +479,7 @@ class BBCooker:
>         Save the result to a set of .dot files.
>         """
>=20
> -        depgraph =3D self.generateDepTreeData(pkgs_to_build, task)
> +        depgraph =3D self.generateTaskDepTreeData(pkgs_to_build, =
task)
>=20
>         # Prints a flattened form of package-depends below where =
subpackages of a package are merged into the main pn
>         depends_file =3D file('pn-depends.dot', 'w' )
> @@ -628,7 +686,7 @@ class BBCooker:
>             pkgs =3D pkgs + extra_pkgs
>=20
>         # generate a dependency tree for all our packages
> -        tree =3D self.generateDepTreeData(pkgs, 'build', =
more_meta=3DTrue)
> +        tree =3D self.generatePkgDepTreeData(pkgs, 'build')
>         bb.event.fire(bb.event.TargetsTreeGenerated(tree), =
self.configuration.data)
>=20
>     def buildWorldTargetList(self):
> --=20
> 1.7.0.4
>=20
> _______________________________________________
> yocto mailing list
> yocto@yoctoproject.org
> https://lists.yoctoproject.org/listinfo/yocto



