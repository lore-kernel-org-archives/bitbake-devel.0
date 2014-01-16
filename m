Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
	by mail.openembedded.org (Postfix) with ESMTP id 11C3D6E20F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 14:21:17 +0000 (UTC)
Received: by mail-ee0-f42.google.com with SMTP id e49so1535528eek.15
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 06:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=+HO8BUZ3W60nZGd75d3MwW33ZuNL9yXYeJ0OafDbn9k=;
	b=tLVutfZ99xmroAzk/RPNrL/fL1i6EcKmDOOpN8LVbO6TCS4SKKe5SGvVW02KrnWA6h
	LDJHhjY0IzBnslgOUUxapA7aNznOYT9jT+AdLkMRwXPiqixzCbXJVorKHQxPAUhUVVAV
	p6yfu5fIE65+RLhztuBVx65XKkkAl6zxVV+jYH9quomceNosc3wuWLIRCbvHdNeLlw84
	aEb4U+FTgyBSOiegstTvOjj7JUo/JdLge/1w79TPtmYEwaGUDzzUSMWCF9LFsbgZ/kVQ
	7bgywuGIqGwrJoHX4Uyqukk4JQ37HnGI8tT2r78gaEiiLU0zqXCaykAdVfUJ8LHWOZmE
	TMhA==
X-Received: by 10.15.49.9 with SMTP id i9mr1351063eew.112.1389882078111;
	Thu, 16 Jan 2014 06:21:18 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id 7sm18525171eee.12.2014.01.16.06.21.16
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Jan 2014 06:21:16 -0800 (PST)
Date: Thu, 16 Jan 2014 15:21:39 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Phil Blundell <pb@pbcl.net>
Message-ID: <20140116142139.GF3742@jama>
References: <1389371323.9182.169.camel@phil-desktop.brightsign>
MIME-Version: 1.0
In-Reply-To: <1389371323.9182.169.camel@phil-desktop.brightsign>
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
X-List-Received-Date: Thu, 16 Jan 2014 14:21:18 -0000
X-Groupsio-MsgNum: 4319
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline

--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 04:28:43PM +0000, Phil Blundell wrote:
> This means that it now understands "standard" URI syntax as well as
> the slightly odd legacy bitbake variant.
>=20
> There are other places in bitbake (e.g. Local.urldata_init) that also=20
> need fixing, but this is a start.

I agree it's good start, I was trying to test this together with
http://lists.openembedded.org/pipermail/bitbake-devel/2014-January/004327.h=
tml

and bitbake-selftest shows failure on different URL, did it pass for you?
- ('http', 'www.google.com', '/index.html', None, None, {})
+ ('http', 'www.google.com', '/index.html', '', '', {})

+ few errors before that like:
File "/usr/lib64/python2.7/re.py", line 238, in _compile
    raise TypeError, "first argument must be string or compiled pattern"
  TypeError: first argument must be string or compiled pattern

> Signed-off-by: Phil Blundell <pb@pbcl.net>
> ---
>  lib/bb/fetch2/__init__.py | 60 ++++++++++++++++++++++++++---------------=
------
>  1 file changed, 33 insertions(+), 27 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 260fb37..4886dae 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -329,40 +329,46 @@ def decodeurl(url):
>      user, password, parameters).
>      """
> =20
> -    m =3D re.compile('(?P<type>[^:]*)://((?P<user>.+)@)?(?P<location>[^;=
]+)(;(?P<parm>.*))?').match(url)
> -    if not m:
> +    if url.startswith("file://"):
> +        # This is an old-style bitbake URL.  Fix it up.
> +        url =3D "file:" + url[7:]
> +
> +    import urlparse
> +    d =3D urlparse.urlsplit(url)
> +    if not d.scheme:
>          raise MalformedUrl(url)
> =20
> -    type =3D m.group('type')
> -    location =3D m.group('location')
> -    if not location:
> +    netloc =3D d.netloc
> +    path =3D d.path
> +
> +    if not path:
>          raise MalformedUrl(url)
> -    user =3D m.group('user')
> -    parm =3D m.group('parm')
> =20
> -    locidx =3D location.find('/')
> -    if locidx !=3D -1 and type.lower() !=3D 'file':
> -        host =3D location[:locidx]
> -        path =3D location[locidx:]
> -    else:
> -        host =3D ""
> -        path =3D location
> -    if user:
> -        m =3D re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
> -        if m:
> -            user =3D m.group('user')
> -            pswd =3D m.group('pswd')
> -    else:
> -        user =3D ''
> -        pswd =3D ''
> +    user =3D ''
> +    pswd =3D ''
> +    host =3D ''
> +
> +    if netloc:
> +        m =3D re.compile('((?P<user>[^:@]+)(:(?P<pswd>[^@]+))?@)?(?P<hos=
t>.+)').match(netloc)
> +        if not m:
> +            raise MalformedUrl(url)
> +
> +        user =3D m.group('user')
> +        pswd =3D m.group('pswd')
> +        host =3D m.group('host')
> =20
>      p =3D {}
> -    if parm:
> -        for s in parm.split(';'):
> -            s1, s2 =3D s.split('=3D')
> -            p[s1] =3D s2
> +    sep =3D path.find(";")
> +    if sep !=3D -1:
> +        for s in path[sep+1:].split(';'):
> +            try:
> +                s1, s2 =3D s.split('=3D')
> +                p[s1] =3D s2
> +            except ValueError:
> +                raise MalformedUrl(url)
> +        path =3D path[:sep]
> =20
> -    return type, host, urllib.unquote(path), user, pswd, p
> +    return d.scheme, host, urllib.unquote(path), user, pswd, p
> =20
>  def encodeurl(decoded):
>      """Encodes a URL from tokens (scheme, network location, path,
> --=20
> 1.8.5
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLX6vMACgkQN1Ujt2V2gBxQzgCfcDCs3J7YtZaV0wK3BIizpVfs
5L4AoLk0Yqm0magsGrn4bKTJJFJd4hjH
=RW53
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
