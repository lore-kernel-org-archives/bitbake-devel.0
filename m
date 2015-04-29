Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 31587716CE;
	Wed, 29 Apr 2015 09:38:18 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 29 Apr 2015 02:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,670,1422950400"; d="scan'208";a="702600154"
Received: from pkcletus-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.20.230])
	by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2015 02:38:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>
Date: Wed, 29 Apr 2015 10:38:18 +0100
Message-ID: <5242032.yZR8PR0vAI@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.6 (Linux/3.19.5-200.fc21.x86_64; KDE/4.14.6; x86_64; ; )
In-Reply-To: <3303347.WRWmiSbDbc@samweis.auenland.lan>
References: <3303347.WRWmiSbDbc@samweis.auenland.lan>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-devel@lists.openembedded.org
Subject: Re: [oe] Bug in cooker - networked PR_SERV
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
X-List-Received-Date: Wed, 29 Apr 2015 09:38:19 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Jan-Simon,

On Thursday 26 March 2015 19:48:52 Jan-Simon M=F6ller wrote:
> I found a bug in cooker that shows up when I try to enable the networ=
ked
> PRSERV. bitbake will crash (and still run at 100% after CTRL-C) until=
 kill
> -9.
>=20
> I tracked it down to bitbake/lib/bb/cooker.py line 169:
>         if self.state !=3D state.initial:
>             raise Exception("Illegal state for feature set change")
>=20
> self.state seems to be 6 at this stage and state.initial is 0 .
>=20
> Hack: If I comment out this check, it seems to continue, but I see no=
 size-
> increase in the prserv sqlite and also nothing printed for loglevel=3D=
DEBUG in
> the log.
>=20
>=20
> Here are the details:
>=20
> My setup is:
> Build Configuration:
> BB_VERSION        =3D "1.24.0"
> BUILD_SYS         =3D "x86_64-linux"
> NATIVELSBSTRING   =3D "openSUSE-project-13.2"
> TARGET_SYS        =3D "i586-poky-linux"
> MACHINE           =3D "qemux86"
> DISTRO            =3D "poky"
> DISTRO_VERSION    =3D "1.7.1"
> TUNE_FEATURES     =3D "m32 i586"
> TARGET_FPU        =3D ""
> meta
> meta-yocto
> meta-yocto-bsp    =3D "<unknown>:<unknown>"
>=20
> ####### Only changes to conf/local.conf:
> PRSERV_HOST=3D"127.0.0.1:5555"
> (an a prserv started in a separate terminal)
>=20
> ####### Crash
>=20
> x86> bitbake core-image-minimal
> Traceback (most recent call last):
>   File "/home/dl9pf/test1/script/4.1/poky-dizzy-12.0.1/bitbake/bin/bi=
tbake",
> line 382, in <module>
>     ret =3D main()
>   File "/home/dl9pf/test1/script/4.1/poky-dizzy-12.0.1/bitbake/bin/bi=
tbake",
> line 347, in main
>     server_connection =3D server.establishConnection(featureset)
>   File "/home/dl9pf/test1/script/4.1/poky-
> dizzy-12.0.1/bitbake/lib/bb/server/process.py", line 247, in
> establishConnection
>     raise BaseException(error)
> BaseException: Traceback (most recent call last):
>   File "/home/dl9pf/test1/script/4.1/poky-
> dizzy-12.0.1/bitbake/lib/bb/command.py", line 71, in runCommand
>     result =3D command_method(self, commandline)
>   File "/home/dl9pf/test1/script/4.1/poky-
> dizzy-12.0.1/bitbake/lib/bb/command.py", line 268, in setFeatures
>     command.cooker.setFeatures(features)
>   File "/home/dl9pf/test1/script/4.1/poky-
> dizzy-12.0.1/bitbake/lib/bb/cooker.py", line 169, in setFeatures
>     raise Exception("Illegal state for feature set change")
> Exception: Illegal state for feature set change
>=20
> ERROR: Unable to set the cooker to the correct featureset: Traceback =
(most
> recent call last):
>   File "/home/dl9pf/test1/script/4.1/poky-
> dizzy-12.0.1/bitbake/lib/bb/command.py", line 71, in runCommand
>     result =3D command_method(self, commandline)
>   File "/home/dl9pf/test1/script/4.1/poky-
> dizzy-12.0.1/bitbake/lib/bb/command.py", line 268, in setFeatures
>     command.cooker.setFeatures(features)
>   File "/home/dl9pf/test1/script/4.1/poky-
> dizzy-12.0.1/bitbake/lib/bb/cooker.py", line 169, in setFeatures
>     raise Exception("Illegal state for feature set change")
> Exception: Illegal state for feature set change

Sorry it's taken a while to get back to you. Are you still seeing this=20=

problem?

(FYI, this would probably have been better sent to the bitbake or OE-Co=
re=20
mailing lists; I've added the bitbake list to CC.)

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

