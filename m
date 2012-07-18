Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1SrRqm-0000pw-Rn; Wed, 18 Jul 2012 12:51:24 +0200
Received: by bkcik5 with SMTP id ik5so1006490bkc.6
	for <multiple recipients>; Wed, 18 Jul 2012 03:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=GAWR978Hpar9lZRKPi+bt8YOA3HVBSma89XLUbMlIxk=;
	b=OsnXiHrfvYEIB6sLvjTxcM3ctsVbuuILcTbK3IEj1eA05uNA4VKFKXvQOcS1fzhj1E
	/1G+C1Hv3DLiG+VYbngovAOb0zs0RDuZnBkmJ2/cLTFkKjQL24Jw9oXRHzlMujyWS2Ij
	xrqQdXqQ98vTkn32q7wiPF4mr0IaTQNGnuMO1GBJEltMBcE6vvouzQL1/kRNT+0MLs48
	MRhgRyx4cgRFfjsm/CL7vBftYGfvX6uSDXNRbsP1yfMeDPUjw/3Hwv7b0l4oMluytsJ+
	IWQVatHbyIkPLDsv9JkBaLr09nhyEHO+ls/NyQz3bRXdaRgl/Puj9c4ROKHxgJNSX9WP
	6wKg==
Received: by 10.204.0.80 with SMTP id 16mr1169790bka.71.1342608004378;
	Wed, 18 Jul 2012 03:40:04 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id c18sm11519219bkv.8.2012.07.18.03.40.02
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 18 Jul 2012 03:40:03 -0700 (PDT)
Date: Wed, 18 Jul 2012 12:40:12 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120718104012.GJ22569@jama.jama.net>
References: <1342606005.30680.17.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1342606005.30680.17.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: PLEASE READ: Major change landing shortly (python whitespace)
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
X-List-Received-Date: Wed, 18 Jul 2012 10:51:25 -0000
X-Groupsio-MsgNum: 2451
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3D7yMlnunRPwJqC7"
Content-Disposition: inline

--3D7yMlnunRPwJqC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2012 at 11:06:45AM +0100, Richard Purdie wrote:
> It's become clear we have a horrible mixture of whitespace (tabs and
> space) in python functions. At first glance this sounds trivial but
> there is a serious problem if pieces of code get mixed together with
> different whitespace since they may or may not work as intended.
>=20
> The documented standard for python functions is four space indentation
> although we have a mixture. Fixing this sounds simple at first, we just
> go through and change tabs to spaces. The problem comes with _append and
> _prepend to python functions since both need their whitespace changed at
> the same time. populate_packages() is the real problem child in that
> regard but its the less common examples I worry about.
>=20
> I did some research and we have inconsistencies, even in existing
> functions since people are editing files and getting confused
> (understandably).
>=20
> So the question becomes, how do we get ourselves out of this mess?
>=20
> I put a proposal to the TSC, that we have bitbake warn/error whenever it
> finds tab characters in any python function. The advantage of this is
> that we give the user a clear definitive error. The downside is that
> we'll have to go through all the metadata and scrub it for the problem.
>=20
> The TSC agrees we should do something about this rather than perpetuate
> the problem and that this is as good a solution as any of us can come up
> with. We also agreed that we should do it sooner than later before it
> gets any later in this release cycle. Putting it off until the next
> release cycle didn't seem to offer any advantage, we might as well get
> on with it.
>=20
> So I am going to:
>=20
> a) Try and flush through as many pending patches as I can.
> b) Check in a warning into bitbake master and increase its version
> c) Require that version in OE-Core

Great.. this is usefull also for latest change from proto to protocol
param in fetcher, but please make sure that the svn.py patch I've sent
yesterday is also in before release..

> d) Commit a significant set of whitespace changes to OE-Core, resolving
> all the warnings for OE-Core.
>=20
> I plan to do this, tomorrow, Thursday.
>=20
> The reason for getting on with it is that the patches are horrible to
> carry around and that any other patches made against OE-Core will likely
> need to be remade to apply after these changes. I therefore don't want a
> week of waiting around discussing it, this is something I believe we
> need to do now and be done with it. I'm also not going to post the
> whitespace patches for review, I'll write+merge them and then be
> responsive for accepting fixes for anything that gets broken. They will
> only be whitespace changes.
>=20
> I appreciate this is going to cause some disruption but I think there is
> a problem worth solving here and this is the best way to do it. If
> anyone has any strong objections I'm open to alternative ideas.
>=20
> The bitbake patch to error on tab whitespace is included below. I'll try
> and post a branch with the whitespace fixes on later today.
>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
>=20
> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> index e3ffefe..4b653a5 100644
> --- a/bitbake/lib/bb/data.py
> +++ b/bitbake/lib/bb/data.py
> @@ -291,6 +291,8 @@ def build_dependencies(key, keys, shelldeps, vardepva=
ls, d):
>              if d.getVarFlag(key, "python"):
>                  parsedvar =3D d.expandWithRefs(value, key)
>                  parser =3D bb.codeparser.PythonParser(key, logger)
> +                if parsedvar.value and "\t" in parsedvar.value:
> +                    bb.warn("Variable %s contains tabs, please remove th=
ese" % key)
>                  parser.parse_python(parsedvar.value)
>                  deps =3D deps | parser.references
>              else:
> diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
> index eae840f..86f9463 100644
> --- a/bitbake/lib/bb/parse/ast.py
> +++ b/bitbake/lib/bb/parse/ast.py
> @@ -212,9 +212,9 @@ class ExportFuncsNode(AstNode):
>                          data.setVarFlag(calledvar, flag, data.getVarFlag=
(var, flag))
> =20
>                  if data.getVarFlag(calledvar, "python"):
> -                    data.setVar(var, "\tbb.build.exec_func('" + calledva=
r + "', d)\n")
> +                    data.setVar(var, "    bb.build.exec_func('" + called=
var + "', d)\n")
>                  else:
> -                    data.setVar(var, "\t" + calledvar + "\n")
> +                    data.setVar(var, "    " + calledvar + "\n")
>                  data.setVarFlag(var, 'export_func', '1')
> =20
>  class AddTaskNode(AstNode):
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--3D7yMlnunRPwJqC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAGkowACgkQN1Ujt2V2gBwEJgCgiVnPlJEVFLo/NlCT8b4tRBj9
8VAAnimgMvrhWBtR/NthK8J4GsTQ+xIB
=Tn8A
-----END PGP SIGNATURE-----

--3D7yMlnunRPwJqC7--
