Received: from mail-da0-f49.google.com ([209.85.210.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UCaKX-0000ep-PY
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Mar 2013 19:41:46 +0100
Received: by mail-da0-f49.google.com with SMTP id t11so2694079daj.36
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 Mar 2013 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=7KlOjQb8gDC8DQMzu06MEsEtrEL65MQ6NRUuYiHjHBA=;
	b=aJExBVJ7uZXHXSpiJ1qwNpPtj8DMR0/Vee/l1asl+97LYXlNOuFxgE3IEA4H0Pbwd8
	YcnvOAU3NQOGcsq8Ybw5TxUSjphaCQcG3MP9/uxNk7JBYxlhUVeWmxT90u9M9qhVxS2R
	8haCqu71DmlgC22kGTkHMd6TbV706IB5tOOhlkPYI22MVS6Lg/TG1Unj+u5UC9qBMxsA
	DioTmiAjTerGhuJjf3sVV5CvoQoKshLTubYWGYZeLj2E1K8DC1/9P4GteYLMv/wDOQ+V
	Uo6WWkLle51lNyiVXd3aUzVtzGGuvauFikr/oyrhOunNi7oa8HoS9mFHUj8BqG4Ueb/7
	jVnw==
X-Received: by 10.68.238.103 with SMTP id vj7mr29818735pbc.181.1362421516312; 
	Mon, 04 Mar 2013 10:25:16 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id 1sm23171449pba.32.2013.03.04.10.25.10
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Mon, 04 Mar 2013 10:25:15 -0800 (PST)
Date: Mon, 4 Mar 2013 19:24:59 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Message-ID: <20130304182459.GJ3268@jama>
References: <1362243005-12124-1-git-send-email-Martin.Jansa@gmail.com>
	<5134C272.7090008@windriver.com>
MIME-Version: 1.0
In-Reply-To: <5134C272.7090008@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] siggen: add quotes around variable values to see whitespace
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
X-List-Received-Date: Mon, 04 Mar 2013 18:41:47 -0000
X-Groupsio-MsgNum: 3285
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline

--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 09:49:06AM -0600, Mark Hatle wrote:
> On 3/2/13 10:50 AM, Martin Jansa wrote:
> > * without this change it's hard to see what's changed:
> >    bitbake-diffsigs sstate-cache/*/sstate-depmodwrapper-cross-cortexa8-=
vfp-neon-oe-linux-gnueabi-1.0-r0-cortexa8-vfp-neon-*_populate-sysroot.tgz.s=
iginfo
> >    basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bc=
c79e0a4356856a64141548
> >    Variable TUNE_CCARGS value changed from  -march=3Darmv7-a    -mthumb=
 -mthumb-interwork -mfloat-abi=3Dsoftfp -mfpu=3Dneon -mtune=3Dcortex-a8  to=
  -march=3Darmv7-a    -mthumb -mthumb-interwork -mfloat-abi=3Dsoftfp -mfpu=
=3Dneon -mtune=3Dcortex-a8
> >    Hash for dependent task depmodwrapper-cross_1.0.bb.do_install change=
d from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3
> >
> > * with this change, we can see extra trailing space in first version:
> >    basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bc=
c79e0a4356856a64141548
> >    Variable TUNE_CCARGS value changed from ' -march=3Darmv7-a    -mthum=
b -mthumb-interwork -mfloat-abi=3Dsoftfp -mfpu=3Dneon -mtune=3Dcortex-a8 ' =
to ' -march=3Darmv7-a    -mthumb -mthumb-interwork -mfloat-abi=3Dsoftfp -mf=
pu=3Dneon -mtune=3Dcortex-a8'
> >    Hash for dependent task depmodwrapper-cross_1.0.bb.do_install change=
d from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3
>=20
> No objection to this patch, but it does raise the question.  Should we so=
mehow=20
> strip the leading and training white space, maybe even multiple spaces (l=
ike=20
> above) and then use the results to generate the checksum?
>=20
> If I saw the above, my first comment would be "well that's stupid, the ou=
tput is=20
> the same"..  (Of course performance might be impacted by all of that stri=
pping..)

I had the same comment when I've seen it, that's why I added those
quotes to be able to spot that space at all.

I'm not sure what caused that extra space and so many rebuilds, but I've
noticed it today in completely different build where space in multiline
variable were squashed to one space separator and I think the only
difference were pool patches in bitbake.

> > Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> > ---
> >   lib/bb/siggen.py | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> > index 50e4558..8861337 100644
> > --- a/lib/bb/siggen.py
> > +++ b/lib/bb/siggen.py
> > @@ -331,12 +331,12 @@ def compare_sigfiles(a, b, recursecb =3D None):
> >           return changed, added, removed
> >
> >       if 'basewhitelist' in a_data and a_data['basewhitelist'] !=3D b_d=
ata['basewhitelist']:
> > -        output.append("basewhitelist changed from %s to %s" % (a_data[=
'basewhitelist'], b_data['basewhitelist']))
> > +        output.append("basewhitelist changed from '%s' to '%s'" % (a_d=
ata['basewhitelist'], b_data['basewhitelist']))
> >           if a_data['basewhitelist'] and b_data['basewhitelist']:
> >               output.append("changed items: %s" % a_data['basewhitelist=
'].symmetric_difference(b_data['basewhitelist']))
> >
> >       if 'taskwhitelist' in a_data and a_data['taskwhitelist'] !=3D b_d=
ata['taskwhitelist']:
> > -        output.append("taskwhitelist changed from %s to %s" % (a_data[=
'taskwhitelist'], b_data['taskwhitelist']))
> > +        output.append("taskwhitelist changed from '%s' to '%s'" % (a_d=
ata['taskwhitelist'], b_data['taskwhitelist']))
> >           if a_data['taskwhitelist'] and b_data['taskwhitelist']:
> >               output.append("changed items: %s" % a_data['taskwhitelist=
'].symmetric_difference(b_data['taskwhitelist']))
> >
> > @@ -349,7 +349,7 @@ def compare_sigfiles(a, b, recursecb =3D None):
> >       changed, added, removed =3D dict_diff(a_data['gendeps'], b_data['=
gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
> >       if changed:
> >           for dep in changed:
> > -            output.append("List of dependencies for variable %s change=
d from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
> > +            output.append("List of dependencies for variable %s change=
d from '%s' to '%s'" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]=
))
> >               if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
> >                   output.append("changed items: %s" % a_data['gendeps']=
[dep].symmetric_difference(b_data['gendeps'][dep]))
> >       if added:
> > @@ -363,7 +363,7 @@ def compare_sigfiles(a, b, recursecb =3D None):
> >       changed, added, removed =3D dict_diff(a_data['varvals'], b_data['=
varvals'])
> >       if changed:
> >           for dep in changed:
> > -            output.append("Variable %s value changed from %s to %s" % =
(dep, a_data['varvals'][dep], b_data['varvals'][dep]))
> > +            output.append("Variable %s value changed from '%s' to '%s'=
" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
> >
> >       changed, added, removed =3D dict_diff(a_data['file_checksum_value=
s'], b_data['file_checksum_values'])
> >       if changed:
> >
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlE05vsACgkQN1Ujt2V2gBxuDQCgsMVRU4IgHGE0ihONq0JssuzY
qqcAoI9yp/SiJ0xcg8AhkTIKDs8t+O/I
=1mgi
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
