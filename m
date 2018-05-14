Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 752E074FDD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 13:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 865621834A;
	Mon, 14 May 2018 15:18:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ymFrZf2Yg8ri; Mon, 14 May 2018 15:18:34 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id BE9B3180E4;
	Mon, 14 May 2018 15:18:34 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8C21E08A;
	Mon, 14 May 2018 15:18:34 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB501E089;
	Mon, 14 May 2018 15:18:34 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Mon, 14 May 2018 15:18:34 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by seth.se.axis.com (Postfix) with ESMTP id 92A9CC5;
	Mon, 14 May 2018 15:18:34 +0200 (CEST)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Mon, 14 May 2018 15:18:34 +0200
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
	XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%21]) with mapi id
	15.00.1263.000; Mon, 14 May 2018 15:18:34 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Matt Hoosier <matt.hoosier@gmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] fetch/gitsm: avoid live submodule
	fetching	during unpack()
Thread-Index: AQHT6V4Dv7zd0uh4EkC1uRRej2f8fKQvN+sA
Date: Mon, 14 May 2018 13:18:34 +0000
Message-ID: <0ed6e7841d4949a98e6978944adf8c8e@XBOX02.axis.com>
References: <20180511192636.6231-1-matt.hoosier@gmail.com>
In-Reply-To: <20180511192636.6231-1-matt.hoosier@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PATCH] fetch/gitsm: avoid live submodule fetching	during unpack()
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
X-List-Received-Date: Mon, 14 May 2018 13:18:36 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Matt Hoosier
> Sent: den 11 maj 2018 21:27
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] fetch/gitsm: avoid live submodule
> fetching during unpack()
>=20
> Although the submodules' histories have been fetched during the
> do_fetch() phase, the mechanics used to clone the workdir copy
> of the repo haven't been transferring the actual .git/modules
> directory from the repo fetched into downloads/ during the
> fetch task.
>=20
> Fix that, and for good measure also explicitly tell Git to avoid
> hitting the network during do_unpack() of the submodules.
>=20
> Rev3 changes:
>=20
> - Really fix the shallow-clone issue claimed to be addressed in rev2.
>=20
> Rev2 changes:
>=20
> - Fixed a failure when unpacking a shallow cloned mirror repository.

The Rev2 and Rev3 changes information should go below the --- below=20
as it should not be part of the commit message as it relates to the=20
patch submission process rather than the actual change. If any of it=20
is relevant for the commit message, then the commit message should=20
be changed as well.

> [YOCTO #12739]
>=20
> Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0aff1008..3969f2f5 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -132,4 +132,30 @@ class GitSM(Git):
>=20
>          if self.uses_submodules(ud, d, ud.destdir):
>              runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.name=
s[0]], d, workdir=3Dud.destdir)
> -            runfetchcmd(ud.basecmd + " submodule update --init --recursi=
ve", d, workdir=3Dud.destdir)
> +
> +            updateflags =3D ""
> +
> +            # Copy over the submodules' fetched histories too.
> +            if ud.bareclone:
> +                repo_conf =3D ud.destdir
> +            else:
> +                repo_conf =3D os.path.join(ud.destdir, '.git')
> +
> +            if os.path.exists(ud.clonedir):
> +                # This is not a copy unpacked from a shallow mirror clon=
e. So
> +                # the manual intervention to populate the .git/modules d=
one
> +                # in clone_shallow_local() won't have been done yet.
> +                runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir, =
'modules'), repo_conf), d)
> +                updateflags +=3D " --no-fetch"
> +            elif os.path.exists(os.path.join(repo_conf, 'modules')):
> +                # Unpacked from a shallow mirror clone. Manual populatio=
n of
> +                # .git/modules is already done.
> +                updateflags +=3D " --no-fetch"
> +            else:
> +                # This isn't fatal; git-submodule will just fetch it
> +                # during do_unpack().
> +                bb.error("submodule history not retrieved during do_fetc=
h()")
> +
> +            # Careful not to hit the network during unpacking; all histo=
ry should already
> +            # be fetched.
> +            runfetchcmd(ud.basecmd + " submodule update --init --recursi=
ve %s" % updateflags, d, workdir=3Dud.destdir)
> --
> 2.13.6

//Peter


