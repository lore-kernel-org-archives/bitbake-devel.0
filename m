Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TkKqD-0002RM-4z
	for bitbake-devel@lists.openembedded.org;
	Sun, 16 Dec 2012 21:29:41 +0100
Received: by mail-ee0-f47.google.com with SMTP id e51so2742023eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 16 Dec 2012 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=qNFyF/J2ufdR8/CNS9EFepU577Lub2a8BQEsLx66low=;
	b=l7P0r9L+cT7/x45YDsi2uOn1nijeNfRaPJvOCL6VNHyE8fH/fZuO9WNnrPL/LgTmfv
	mFvBKAr0jfOfwgr9+bm8R7UU09Ti0DOZPRM3+qu2PQfxXMhBlblySyEUvaZObFtD3LCv
	2yrgXuVh3Q3KcYVZwBsA32Mi3xBVbwV4BK9DXWzq1Am1yBwA3sJ8vRxTFQ/lon6epQzZ
	/5RIACo0gA4EdK4CabX/fgb8/isYe2pw+4gsdTWJI+ciFRLTLNbk3yFYJDU56YKbAU0h
	KFJpql9V1Kflt63l2xnEakRcTt++ZNbH64qeR3HcDfFhd5XlASp+M+cpN3TnA3a30gDs
	cqDA==
Received: by 10.14.223.135 with SMTP id v7mr34690797eep.41.1355688902003;
	Sun, 16 Dec 2012 12:15:02 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id w44sm24588780eep.6.2012.12.16.12.15.00
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 16 Dec 2012 12:15:01 -0800 (PST)
Date: Sun, 16 Dec 2012 21:15:01 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20121216201501.GG3448@jama>
References: <1355493212.32519.16.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1355493212.32519.16.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Philip Balister <philip@balister.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: BBHandler/ConfHandler: Improve multiline comment handling
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
X-List-Received-Date: Sun, 16 Dec 2012 20:29:41 -0000
X-Groupsio-MsgNum: 3050
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline

--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2012 at 01:53:32PM +0000, Richard Purdie wrote:
> Faced with an expression like:
>=20
>  # Some comment \
>  FOO =3D "bar"
>=20
> what should bitbake do? Technically, the \ character means its multiline =
and
> currently the code treats this as a continuation of the comment. This can
> surprise some people and is not intuitive.
>=20
> This patch makes bitbake simply error and asks the user to be clearer
> about what they mean.

I have at least 2 bb files with '# foo \', but error message is not nice:

$ bitbake -k azy-native azy
Pseudo may be out of date, rebuilding pseudo before the main build
ERROR: Unable to parse /OE/shr-core/meta-jama/recipes-jama/packagegroups/pa=
ckagegroup-jama.bb                                                 | ETA:  =
00:00:58
Traceback (most recent call last):
  File "/OE/shr-core/bitbake/lib/bb/cache.py", line 674, in load_bbfile(bbf=
ile=3D'/OE/shr-core/meta-jama/recipes-jama/packagegroups/packagegroup-jama.=
bb', appends=3D[], config=3D<bb.data_smart.DataSmart object at 0x7fe632927d=
50>):
                     data.setVar('__BBAPPEND', " ".join(appends), bb_data)
    >            bb_data =3D parse.handle(bbfile, bb_data)
                 if chdir_back:
  File "/OE/shr-core/bitbake/lib/bb/parse/__init__.py", line 90, in handle(=
fn=3D'/OE/shr-core/meta-jama/recipes-jama/packagegroups/packagegroup-jama.b=
b', data=3D<bb.data_smart.DataSmart object at 0xe287150>, include=3D0):
             if h['supports'](fn, data):
    >            return h['handle'](fn, data, include)
         raise ParseError("not a BitBake file", fn)
  File "/OE/shr-core/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 150,=
 in handle(fn=3D'/OE/shr-core/meta-jama/recipes-jama/packagegroups/packageg=
roup-jama.bb', d=3D<bb.data_smart.DataSmart object at 0xe287150>, include=
=3D0):
         # actual loading
    >    statements =3D get_statements(fn, abs_fn, base_name)

  File "/OE/shr-core/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 106,=
 in get_statements(filename=3D'/OE/shr-core/meta-jama/recipes-jama/packageg=
roups/packagegroup-jama.bb', absolute_filename=3D'/OE/shr-core/meta-jama/re=
cipes-jama/packagegroups/packagegroup-jama.bb', base_name=3D'packagegroup-j=
ama.bb'):
                 s =3D s.rstrip()
    >            feeder(lineno, s, filename, base_name, statements)
             if __inpython__:
  File "/OE/shr-core/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 205,=
 in feeder(lineno=3D58, s=3D'', fn=3D'/OE/shr-core/meta-jama/recipes-jama/p=
ackagegroups/packagegroup-jama.bb', root=3D'packagegroup-jama.bb', statemen=
ts=3D[<bb.parse.ast.DataNode object at 0xd4c4850>, <bb.parse.ast.DataNode o=
bject at 0x31f2b10>, <bb.parse.ast.DataNode object at 0x9421a90>, <bb.parse=
=2East.InheritNode object at 0xc99f250>, <bb.parse.ast.DataNode object at 0=
xc99f410>, <bb.parse.ast.DataNode object at 0xc99f390>, <bb.parse.ast.DataN=
ode object at 0xc99f790>, <bb.parse.ast.DataNode object at 0xc99f890>, <bb.=
parse.ast.DataNode object at 0xc99f6d0>, <bb.parse.ast.DataNode object at 0=
xc99f8d0>, <bb.parse.ast.DataNode object at 0xc99f750>]):

    >    if len(__residue__) !=3D 0 and __residue__[0][0] =3D=3D "#" and s[=
0] !=3D "#":
             bb.fatal("There is a confusing multiline, partially commented =
expression on line %s of file %s (%s).\nPlease clarify whether this is all =
a comment or should be parsed." % (lineno, fn, s))
IndexError: string index out of range

ERROR: There is a confusing multiline, partially commented expression on li=
ne 25 of file /OE/shr-core/meta-handheld/recipes-kernel/linux/linux-handhel=
ds-2.6_2.6.21-hh20.bb (SRC_URI[rppatch35.md5sum] =3D "8ab51e8ff728f4155db64=
b9bb6ea6d71").
Please clarify whether this is all a comment or should be parsed.
ERROR: Command execution failed: Exited with 1

Summary: There were 3 ERROR messages shown, returning a non-zero exit code.

After removing that line from linux-handhelds-2.6 and fixing such lines in =
packagegroup-jama.bb, new recipe also with # foo \ is shown:

$ bitbake -k azy-native azy
Pseudo may be out of date, rebuilding pseudo before the main build
Loading cache: 100% |######################################################=
###################################################################| ETA:  =
00:00:00
Loaded 35 entries from dependency cache.
ERROR: Unable to parse /OE/shr-core/meta-jama/recipes-jama/packagegroups/pa=
ckagegroup-jama-shr.bb                                             | ETA:  =
--:--:--
Traceback (most recent call last):
  File "/OE/shr-core/bitbake/lib/bb/cache.py", line 674, in load_bbfile(bbf=
ile=3D'/OE/shr-core/meta-jama/recipes-jama/packagegroups/packagegroup-jama-=
shr.bb', appends=3D[], config=3D<bb.data_smart.DataSmart object at 0x7f7cca=
917d50>):
                     data.setVar('__BBAPPEND', " ".join(appends), bb_data)
    >            bb_data =3D parse.handle(bbfile, bb_data)
                 if chdir_back:
  File "/OE/shr-core/bitbake/lib/bb/parse/__init__.py", line 90, in handle(=
fn=3D'/OE/shr-core/meta-jama/recipes-jama/packagegroups/packagegroup-jama-s=
hr.bb', data=3D<bb.data_smart.DataSmart object at 0x7f7cca8647d0>, include=
=3D0):
             if h['supports'](fn, data):
    >            return h['handle'](fn, data, include)
         raise ParseError("not a BitBake file", fn)
  File "/OE/shr-core/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 150,=
 in handle(fn=3D'/OE/shr-core/meta-jama/recipes-jama/packagegroups/packageg=
roup-jama-shr.bb', d=3D<bb.data_smart.DataSmart object at 0x7f7cca8647d0>, =
include=3D0):
         # actual loading
    >    statements =3D get_statements(fn, abs_fn, base_name)
    =20
  File "/OE/shr-core/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 106,=
 in get_statements(filename=3D'/OE/shr-core/meta-jama/recipes-jama/packageg=
roups/packagegroup-jama-shr.bb', absolute_filename=3D'/OE/shr-core/meta-jam=
a/recipes-jama/packagegroups/packagegroup-jama-shr.bb', base_name=3D'packag=
egroup-jama-shr.bb'):
                 s =3D s.rstrip()
    >            feeder(lineno, s, filename, base_name, statements)
             if __inpython__:
  File "/OE/shr-core/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 205,=
 in feeder(lineno=3D30, s=3D'', fn=3D'/OE/shr-core/meta-jama/recipes-jama/p=
ackagegroups/packagegroup-jama-shr.bb', root=3D'packagegroup-jama-shr.bb', =
statements=3D[<bb.parse.ast.DataNode object at 0xc0b8910>, <bb.parse.ast.Da=
taNode object at 0xc0b8d10>, <bb.parse.ast.DataNode object at 0xc0b8890>, <=
bb.parse.ast.InheritNode object at 0xc0b8a50>, <bb.parse.ast.DataNode objec=
t at 0xc0b8fd0>, <bb.parse.ast.DataNode object at 0xc0b8810>, <bb.parse.ast=
=2EDataNode object at 0xc0b8790>, <bb.parse.ast.DataNode object at 0xc0b871=
0>, <bb.parse.ast.DataNode object at 0xc0b8610>, <bb.parse.ast.DataNode obj=
ect at 0xc0b8690>, <bb.parse.ast.DataNode object at 0xc0b8510>]):
    =20
    >    if len(__residue__) !=3D 0 and __residue__[0][0] =3D=3D "#" and s[=
0] !=3D "#":
             bb.fatal("There is a confusing multiline, partially commented =
expression on line %s of file %s (%s).\nPlease clarify whether this is all =
a comment or should be parsed." % (lineno, fn, s))
IndexError: string index out of range

ERROR: Command execution failed: Exited with 1

Summary: There were 2 ERROR messages shown, returning a non-zero exit code.

And then the same for meta-openembedded/meta-oe/recipes-support/cpufrequtil=
s/cpufrequtils_008.bb ....

Cheers,

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/=
parse/parse_py/BBHandler.py
> index 2ee8ebd..58049bd 100644
> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
> @@ -200,7 +200,10 @@ def feeder(lineno, s, fn, root, statements):
> =20
>      if s and s[0] =3D=3D '#':
>          if len(__residue__) !=3D 0 and __residue__[0][0] !=3D "#":
> -            bb.error("There is a comment on line %s of file %s (%s) whic=
h is in the middle of a multiline expression.\nBitbake used to ignore these=
 but no longer does so, please fix your metadata as errors are likely as a =
result of this change." % (lineno, fn, s))
> +            bb.fatal("There is a comment on line %s of file %s (%s) whic=
h is in the middle of a multiline expression.\nBitbake used to ignore these=
 but no longer does so, please fix your metadata as errors are likely as a =
result of this change." % (lineno, fn, s))
> +
> +    if len(__residue__) !=3D 0 and __residue__[0][0] =3D=3D "#" and s[0]=
 !=3D "#":
> +        bb.fatal("There is a confusing multiline, partially commented ex=
pression on line %s of file %s (%s).\nPlease clarify whether this is all a =
comment or should be parsed." % (lineno, fn, s))
> =20
>      if s and s[-1] =3D=3D '\\':
>          __residue__.append(s[:-1])
> diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/b=
b/parse/parse_py/ConfHandler.py
> index dbc6776..9b09c9f 100644
> --- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
> @@ -98,15 +98,22 @@ def handle(fn, data, include):
>      while True:
>          lineno =3D lineno + 1
>          s =3D f.readline()
> -        if not s: break
> +        if not s:
> +            break
>          w =3D s.strip()
> -        if not w: continue          # skip empty lines
> +        # skip empty lines
> +        if not w:
> +            continue
>          s =3D s.rstrip()
> -        if s[0] =3D=3D '#': continue    # skip comments
>          while s[-1] =3D=3D '\\':
>              s2 =3D f.readline().strip()
>              lineno =3D lineno + 1
> +            if s2 and s[0] =3D=3D "#" and s2[0] !=3D "#":
> +                bb.fatal("There is a confusing multiline, partially comm=
ented expression on line %s of file %s (%s).\nPlease clarify whether this i=
s all a comment or should be parsed." % (lineno, fn, s))
>              s =3D s[:-1] + s2
> +        # skip comments
> +        if s[0] =3D=3D '#':
> +            continue
>          feeder(lineno, s, fn, statements)
> =20
>      # DONE WITH PARSING... time to evaluate
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlDOK8UACgkQN1Ujt2V2gBwJOwCfTmdfzvvBKIieH00gngaWjEfE
rWsAoIry/dPeCPm7VWrjnRDyqd3ymVmv
=ROOE
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
