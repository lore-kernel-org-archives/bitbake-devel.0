Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
	[209.85.215.179])
	by mail.openembedded.org (Postfix) with ESMTP id 27AA26B8C5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 14:44:35 +0000 (UTC)
Received: by mail-ea0-f179.google.com with SMTP id q10so492494ead.24
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=nUIehmdFS9CX55HBvSRj49LilxyCKFDNBLSzSs28Zbw=;
	b=C23B4CC3bdx/A/zmWRzHLPGGxNVpMorCA+Wju/GtJq0bMrN0GGhc8yWVFiUDsjYKWH
	Kh7dQtXsJExKvT2IXjjrOYyA+NxLlwtA4T7R2s1kerQITiJDjzb0FwPcJUuCmtN5mvtD
	tcYcCh/gacqRx+5UWK/5FXB+w7n8nZIGM94bFYEJbyNafXQSXlHWb7DNwKJMBhZ2cCJd
	qpBpFr4bhqqh6fMqtmbtgZWPB4t00thBbNoOwxZtH2OUE6n6XbIeA7LGGpCjiUeOJznH
	yyPbNrW0ERRFV9VfcFiyGsTa/EMO6icLsDcgUKf+7e3izQZGD7u52FY5FI8+OO+MHhz1
	WqFw==
X-Received: by 10.14.99.66 with SMTP id w42mr12598339eef.63.1389883476282;
	Thu, 16 Jan 2014 06:44:36 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id 7sm18699966eee.12.2014.01.16.06.44.35
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Jan 2014 06:44:35 -0800 (PST)
Date: Thu, 16 Jan 2014 15:44:57 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Phil Blundell <pb@pbcl.net>
Message-ID: <20140116144457.GG3742@jama>
References: <1389371323.9182.169.camel@phil-desktop.brightsign>
	<20140116142139.GF3742@jama>
MIME-Version: 1.0
In-Reply-To: <20140116142139.GF3742@jama>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH] bitbake: Rewrite fetch2.decodeurl() to use urlparse.urlsplit()
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
X-List-Received-Date: Thu, 16 Jan 2014 14:44:37 -0000
X-Groupsio-MsgNum: 4320
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline

--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 03:21:39PM +0100, Martin Jansa wrote:
> On Fri, Jan 10, 2014 at 04:28:43PM +0000, Phil Blundell wrote:
> > This means that it now understands "standard" URI syntax as well as
> > the slightly odd legacy bitbake variant.
> >=20
> > There are other places in bitbake (e.g. Local.urldata_init) that also=
=20
> > need fixing, but this is a start.
>=20
> I agree it's good start, I was trying to test this together with
> http://lists.openembedded.org/pipermail/bitbake-devel/2014-January/004327=
=2Ehtml
>=20
> and bitbake-selftest shows failure on different URL, did it pass for you?
> - ('http', 'www.google.com', '/index.html', None, None, {})
> + ('http', 'www.google.com', '/index.html', '', '', {})
>=20
> + few errors before that like:
> File "/usr/lib64/python2.7/re.py", line 238, in _compile
>     raise TypeError, "first argument must be string or compiled pattern"
>   TypeError: first argument must be string or compiled pattern

Returning empty string instead of None for user/pass seems to fix all
fetcher tests we currently have (including my with '@') and also the
TypeErrors from uri_replace

Here is what I did, sending inline as maybe the better way would be to
fix uri_replace (and possibly other places) to correctly work with None.

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1bbe0e7..da69500 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -344,18 +344,18 @@ def decodeurl(url):
     if not path:
         raise MalformedUrl(url)
=20
-    user =3D ''
-    pswd =3D ''
-    host =3D ''
+    user =3D d.username or ''
+    pswd =3D d.password or ''
+    host =3D d.hostname or ''
=20
     if netloc:
         m =3D re.compile('((?P<user>[^:@]+)(:(?P<pswd>[^@]+))?@)?(?P<host>=
=2E+)').match(netloc)
         if not m:
             raise MalformedUrl(url)
=20
-        user =3D m.group('user')
-        pswd =3D m.group('pswd')
-        host =3D m.group('host')
+        user =3D m.group('user') or ''
+        pswd =3D m.group('pswd') or ''
+        host =3D m.group('host') or ''
=20
     p =3D {}
     sep =3D path.find(";")

> > Signed-off-by: Phil Blundell <pb@pbcl.net>
> > ---
> >  lib/bb/fetch2/__init__.py | 60 ++++++++++++++++++++++++++-------------=
--------
> >  1 file changed, 33 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 260fb37..4886dae 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -329,40 +329,46 @@ def decodeurl(url):
> >      user, password, parameters).
> >      """
> > =20
> > -    m =3D re.compile('(?P<type>[^:]*)://((?P<user>.+)@)?(?P<location>[=
^;]+)(;(?P<parm>.*))?').match(url)
> > -    if not m:
> > +    if url.startswith("file://"):
> > +        # This is an old-style bitbake URL.  Fix it up.
> > +        url =3D "file:" + url[7:]
> > +
> > +    import urlparse
> > +    d =3D urlparse.urlsplit(url)
> > +    if not d.scheme:
> >          raise MalformedUrl(url)
> > =20
> > -    type =3D m.group('type')
> > -    location =3D m.group('location')
> > -    if not location:
> > +    netloc =3D d.netloc
> > +    path =3D d.path
> > +
> > +    if not path:
> >          raise MalformedUrl(url)
> > -    user =3D m.group('user')
> > -    parm =3D m.group('parm')
> > =20
> > -    locidx =3D location.find('/')
> > -    if locidx !=3D -1 and type.lower() !=3D 'file':
> > -        host =3D location[:locidx]
> > -        path =3D location[locidx:]
> > -    else:
> > -        host =3D ""
> > -        path =3D location
> > -    if user:
> > -        m =3D re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
> > -        if m:
> > -            user =3D m.group('user')
> > -            pswd =3D m.group('pswd')
> > -    else:
> > -        user =3D ''
> > -        pswd =3D ''
> > +    user =3D ''
> > +    pswd =3D ''
> > +    host =3D ''
> > +
> > +    if netloc:
> > +        m =3D re.compile('((?P<user>[^:@]+)(:(?P<pswd>[^@]+))?@)?(?P<h=
ost>.+)').match(netloc)
> > +        if not m:
> > +            raise MalformedUrl(url)
> > +
> > +        user =3D m.group('user')
> > +        pswd =3D m.group('pswd')
> > +        host =3D m.group('host')
> > =20
> >      p =3D {}
> > -    if parm:
> > -        for s in parm.split(';'):
> > -            s1, s2 =3D s.split('=3D')
> > -            p[s1] =3D s2
> > +    sep =3D path.find(";")
> > +    if sep !=3D -1:
> > +        for s in path[sep+1:].split(';'):
> > +            try:
> > +                s1, s2 =3D s.split('=3D')
> > +                p[s1] =3D s2
> > +            except ValueError:
> > +                raise MalformedUrl(url)
> > +        path =3D path[:sep]
> > =20
> > -    return type, host, urllib.unquote(path), user, pswd, p
> > +    return d.scheme, host, urllib.unquote(path), user, pswd, p
> > =20
> >  def encodeurl(decoded):
> >      """Encodes a URL from tokens (scheme, network location, path,
> > --=20
> > 1.8.5
> >=20
> >=20
> >=20
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>=20
> --=20
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com



--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLX8GkACgkQN1Ujt2V2gBxMRACgmvHnpxc8GmEyyIEGK++yyDs+
uvIAnA/DGiTTT0E4/52u6mg9+vBBz9NF
=hCX3
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
