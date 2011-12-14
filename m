Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rad5B-0002dN-JW
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Dec 2011 01:52:30 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 13 Dec 2011 16:45:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="86266874"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by orsmga001.jf.intel.com with ESMTP; 13 Dec 2011 16:45:31 -0800
Received: from pgsmsx151.gar.corp.intel.com (172.30.236.41) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 14 Dec 2011 08:44:51 +0800
Received: from shsmsx601.ccr.corp.intel.com (10.239.4.112) by
	PGSMSX151.gar.corp.intel.com (172.30.236.41) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Wed, 14 Dec 2011 08:44:50 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	shsmsx601.ccr.corp.intel.com ([10.239.4.112]) with mapi;
	Wed, 14 Dec 2011 08:44:49 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Dec 2011 08:44:49 +0800
Thread-Topic: [bitbake-devel] [PATCH 06/10] command.py: add
	generateTargetsTreePro API
Thread-Index: Acy5t3J8bJDNQQXkQWOXq3AWxxtxUgAQhDPw
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12DBFD6E32@shsmsx501.ccr.corp.intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
	<925c50cd17dbddca6228b40f6016338aee485e82.1323656120.git.dongxiao.xu@intel.com>
	<4EE7817D.20507@linux.intel.com>
In-Reply-To: <4EE7817D.20507@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
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
X-List-Received-Date: Wed, 14 Dec 2011 00:52:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of Joshua
> Lock
> Sent: Wednesday, December 14, 2011 12:47 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH 06/10] command.py: add
> generateTargetsTreePro API
>=20
>=20
>=20
> On 11/12/11 18:20, Dongxiao Xu wrote:
> > Currently we have generateTargetsTree API, which is used to get
> > dependency information. However in that tree, there will be
> > "virtual/xxx" in depends fields. Therefore we need to replace it with
> > its real providers.
> >
> > Besides, for packages that provided by multiple recipes, we will find
> > their preverred provider.
> >
> > To make the original Hob working, we still keep the
> > generateTargetsTree API.
>=20
> I assume the 'original Hob' compatability will only be maintained until
> Hobv2 is merged?
>=20
> Is there anything preventing us from having an optional parameter on
> generateTargetsTree to switch to pro mode rather than duplicating a bunch=
 of
> code and functionality on a temporary basis?

Yes, thanks for your suggestion, I will modify it accordingly.

Thanks,
Dongxiao

>=20
> something like:
>=20
> > +    def generateTargetsTree(self, command, params):
> > +        """
> > +        A pro version of generateTargetsTree
> > +        """
> > +        klass =3D params[0]
> > +        param_len =3D len(params)
> > +        if param_len 2:
> > +            pkg_list =3D params[1]
> > +            resolve =3D params[2]
> > +        elif param_len > 1:
> > +            pkg_list =3D params[1]
> > +            resolve =3D false
> > +        else:
> > +            pkg_list =3D []
> > +            resolve =3D false
> > +
> > +        command.cooker.generateTargetsTree(klass, pkg_list, resolve)
> > +        command.finishAsyncCommand()
> > +    generateTargetsTreePro.needcache =3D True
>=20
>=20
> Then you can use the resolve boolean to switch the generateBlahBlahBlah
> methods to operate in the old or new way. Method signature would be
> something like:
>=20
> > +    def generateTargetsTree(self, klass=3DNone, pkgs=3D[], resolve=3Df=
alse):
>=20
> > +    def generatePkgDepTreeDataPro(self, pkgs_to_build, task,
> resolve=3Dfalse):
>=20
> Cheers,
> Joshua
>=20
> >
> > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > ---
> >  lib/bb/command.py |   14 +++++++
> >  lib/bb/cooker.py  |   98
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 112 insertions(+), 0 deletions(-)
> >
> > diff --git a/lib/bb/command.py b/lib/bb/command.py index
> > 6b4a598..15e7839 100644
> > --- a/lib/bb/command.py
> > +++ b/lib/bb/command.py
> > @@ -238,6 +238,20 @@ class CommandsAsync:
> >          command.finishAsyncCommand()
> >      generateTargetsTree.needcache =3D True
> >
> > +    def generateTargetsTreePro(self, command, params):
> > +        """
> > +        A pro version of generateTargetsTree
> > +        """
> > +        klass =3D params[0]
> > +        if len(params) > 1:
> > +            pkg_list =3D params[1]
> > +        else:
> > +            pkg_list =3D []
> > +
> > +        command.cooker.generateTargetsTreePro(klass, pkg_list)
> > +        command.finishAsyncCommand()
> > +    generateTargetsTreePro.needcache =3D True
> > +
> >      def findConfigFiles(self, command, params):
> >          """
> >          Find config files which provide appropriate values diff --git
> > a/lib/bb/cooker.py b/lib/bb/cooker.py index 666242f..9f05d35 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > @@ -498,6 +498,85 @@ class BBCooker:
> >
> >          return depend_tree
> >
> > +    def generatePkgDepTreeDataPro(self, pkgs_to_build, task):
> > +        """
> > +        Create a dependency tree of pkgs_to_build, returning the data.
> > +        """
> > +        _, taskdata =3D self.prepareTreeData(pkgs_to_build, task)
> > +        tasks_fnid =3D []
> > +        if len(taskdata.tasks_name) !=3D 0:
> > +            for task in xrange(len(taskdata.tasks_name)):
> > +                tasks_fnid.append(taskdata.tasks_fnid[task])
> > +
> > +        seen_fnids =3D []
> > +        depend_tree =3D {}
> > +        depend_tree["depends"] =3D {}
> > +        depend_tree["pn"] =3D {}
> > +        depend_tree["rdepends-pn"] =3D {}
> > +        depend_tree["packages"] =3D {}
> > +        depend_tree["rdepends-pkg"] =3D {}
> > +
> > +        for task in xrange(len(tasks_fnid)):
> > +            fnid =3D tasks_fnid[task]
> > +            fn =3D taskdata.fn_index[fnid]
> > +            pn =3D self.status.pkg_fn[fn]
> > +            version  =3D "%s:%s-%s" % self.status.pkg_pepvpr[fn]
> > +            summary =3D self.status.summary[fn]
> > +            lic =3D self.status.license[fn]
> > +            section =3D self.status.section[fn]
> > +            rdepends =3D self.status.rundeps[fn]
> > +            if pn not in depend_tree["pn"]:
> > +                depend_tree["pn"][pn] =3D {}
> > +                depend_tree["pn"][pn]["filename"] =3D fn
> > +                depend_tree["pn"][pn]["version"] =3D version
> > +                depend_tree["pn"][pn]["summary"] =3D summary
> > +                depend_tree["pn"][pn]["license"] =3D lic
> > +                depend_tree["pn"][pn]["section"] =3D section
> > +                depend_tree["pn"][pn]["packages"] =3D rdepends.keys()
> > +
> > +            if fnid not in seen_fnids:
> > +                seen_fnids.append(fnid)
> > +                packages =3D []
> > +
> > +                depend_tree["depends"][pn] =3D []
> > +                for dep in taskdata.depids[fnid]:
> > +                    item =3D taskdata.build_names_index[dep]
> > +                    pn_provider =3D ""
> > +                    targetid =3D taskdata.getbuild_id(item)
> > +                    if targetid in taskdata.build_targets:
> > +                        fnid =3D taskdata.build_targets[targetid][0]
> > +                        fn_provider =3D taskdata.fn_index[fnid]
> > +                        pn_provider =3D self.status.pkg_fn[fn_provider=
]
> > +                    else:
> > +                        pn_provider =3D item
> > +                    depend_tree["depends"][pn].append(pn_provider)
> > +
> > +                depend_tree["rdepends-pn"][pn] =3D []
> > +                for rdep in taskdata.rdepids[fnid]:
> > +
> > + depend_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep]
> > + )
> > +
> > +                for package in rdepends:
> > +                    depend_tree["rdepends-pkg"][package] =3D []
> > +                    for rdepend in rdepends[package]:
> > +
> depend_tree["rdepends-pkg"][package].append(rdepend)
> > +                    packages.append(package)
> > +
> > +                for package in packages:
> > +                    if package not in depend_tree["packages"]:
> > +                        targetid =3D taskdata.getrun_id(package)
> > +                        if targetid in taskdata.run_targets:
> > +                            fnid =3D taskdata.run_targets[targetid][0]
> > +                            fn =3D taskdata.fn_index[fnid]
> > +                            pn =3D self.status.pkg_fn[fn]
> > +                            version  =3D "%s:%s-%s" %
> self.status.pkg_pepvpr[fn]
> > +                        depend_tree["packages"][package] =3D {}
> > +                        depend_tree["packages"][package]["pn"] =3D pn
> > +
> depend_tree["packages"][package]["filename"] =3D fn
> > +                        depend_tree["packages"][package]["version"]
> =3D
> > + version
> > +
> > +        return depend_tree
> > +
> > +
> >      def generateDepTreeEvent(self, pkgs_to_build, task):
> >          """
> >          Create a task dependency graph of pkgs_to_build.
> > @@ -746,6 +825,25 @@ class BBCooker:
> >          tree =3D self.generatePkgDepTreeData(pkgs, 'build')
> >          bb.event.fire(bb.event.TargetsTreeGenerated(tree),
> > self.configuration.data)
> >
> > +    def generateTargetsTreePro(self, klass=3DNone, pkgs=3D[]):
> > +        """
> > +        Generate a dependency tree of buildable targets
> > +        Check and add providers for each dependencies
> > +        Generate an event with the result
> > +        """
> > +        # if the caller hasn't specified a pkgs list default to univer=
se
> > +        if not len(pkgs):
> > +            pkgs =3D ['universe']
> > +        # if inherited_class passed ensure all recipes which inherit t=
he
> > +        # specified class are included in pkgs
> > +        if klass:
> > +            extra_pkgs =3D self.findInheritsClass(klass)
> > +            pkgs =3D pkgs + extra_pkgs
> > +
> > +        # generate a dependency tree for all our packages
> > +        tree =3D self.generatePkgDepTreeDataPro(pkgs, 'build')
> > +        bb.event.fire(bb.event.TargetsTreeGenerated(tree),
> > + self.configuration.data)
> > +
> >      def buildWorldTargetList(self):
> >          """
> >           Build package list for "bitbake world"
>=20
> --
> Joshua Lock
>         Yocto Project "Johannes factotum"
>         Intel Open Source Technology Centre
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


