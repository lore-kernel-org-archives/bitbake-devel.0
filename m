Received: from mail-da0-f48.google.com ([209.85.210.48])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1Tyjrh-0003GL-T8; Fri, 25 Jan 2013 15:02:46 +0100
Received: by mail-da0-f48.google.com with SMTP id k18so179335dae.35
	for <multiple recipients>; Fri, 25 Jan 2013 05:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=D6WfpBcH36c+V6w3RqjGltImZM8XUlqdCzCbjTIuDOc=;
	b=C0Sia81db0D1VRS6UdLAABXbtk2lEW84deCfMvgPOLkh47p3mrFM9i3tDHLsP/5X7o
	ovXz17JLTJk5prRVqA31NT2aj3mMc3aC2wF2jKsxW0vBe0086yiKMOc7sV6c4GiqD2gp
	tJgemalmORmHMLB6Je1BDNi1dFf8Ymheg+v6mJ5JyO6URwuNemDHDz5yCSw9RHdm3ZGb
	0kyaTmKYOcxE1P3VMi10KNWqnta9vZdgxeDhiwXnKkLEl3Bb+2CXI0F3dlA0Fe3k9Wpq
	MJLfH850jopO12JvmksvzK4yvYU8G6N77+hPpPWXjy8r1fuBSX5HkjTuDWqXpF8p3Fhj
	jFFg==
X-Received: by 10.68.135.99 with SMTP id pr3mr14334116pbb.151.1359121630623;
	Fri, 25 Jan 2013 05:47:10 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id vn2sm710244pbc.31.2013.01.25.05.47.07
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Fri, 25 Jan 2013 05:47:09 -0800 (PST)
Date: Fri, 25 Jan 2013 14:47:05 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Constantin Musca <constantinx.musca@intel.com>
Message-ID: <20130125134705.GF3200@jama>
References: <1358952843-14300-1-git-send-email-constantinx.musca@intel.com>
MIME-Version: 1.0
In-Reply-To: <1358952843-14300-1-git-send-email-constantinx.musca@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH 1/3] prserv: use only PRSERV_HOST
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
X-List-Received-Date: Fri, 25 Jan 2013 14:02:46 -0000
X-Groupsio-MsgNum: 3177
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline

--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2013 at 04:54:03PM +0200, Constantin Musca wrote:
> - remove PRSERV_PORT variable
> - use 'hostname:port' as PRSERV_HOST format
> - use 'localhost:0' for enabling the local PRServer

Please update=20
https://wiki.yoctoproject.org/wiki/index.php?title=3DPR_Service

This seems to break 'bitbake-prserv-tool migrate_localcount'

ERROR: Execution of event handler 'primport_handler' failed################=
################################################################## | ETA:  =
00:00:00
Traceback (most recent call last):
  File "primport_handler(e)", line 9, in primport_handler(e=3D<bb.event.Par=
seCompleted object at 0xce963d0>)
  File "/OE/shr-core/openembedded-core/meta/lib/oe/prservice.py", line 43, =
in prserv_import_db(d=3D<bb.data_smart.DataSmart object at 0x1aff710>, filt=
er_version=3DNone, filter_pkgarch=3DNone, filter_checksum=3DNone):
         if conn is None:
    >        conn =3D prserv_make_conn(d)
             if conn is None:
  File "/OE/shr-core/openembedded-core/meta/lib/oe/prservice.py", line 13, =
in prserv_make_conn(d=3D<bb.data_smart.DataSmart object at 0x1aff710>, chec=
k=3DFalse):
         except Exception, exc:
    >        bb.fatal("Connecting to PR service %s:%s failed: %s" % (host, =
port, str(exc)))

NameError: global name 'host' is not defined

Cheers,

>=20
> [YOCTO #3744]
>=20
> Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
> ---
>  bitbake/lib/prserv/serv.py | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> index 5567c6f..d8bdf31 100644
> --- a/bitbake/lib/prserv/serv.py
> +++ b/bitbake/lib/prserv/serv.py
> @@ -268,10 +268,17 @@ def is_local_special(host, port):
> =20
>  def auto_start(d):
>      global singleton
> -    if (not d.getVar('PRSERV_HOST', True)) or (not d.getVar('PRSERV_PORT=
', True)):
> +
> +    host_params =3D filter(None, (d.getVar('PRSERV_HOST', True) or '').s=
plit(':'))
> +    if not host_params:
> +        return True
> +
> +    if len(host_params) !=3D 2:
> +        logger.critical('\n'.join(['PRSERV_HOST: incorrect format',
> +                'Usage: PRSERV_HOST =3D "<hostname>:<port>"']))
>          return True
> =20
> -    if is_local_special(d.getVar('PRSERV_HOST', True), int(d.getVar('PRS=
ERV_PORT', True))) and not singleton:
> +    if is_local_special(host_params[0], int(host_params[1])) and not sin=
gleton:
>          import bb.utils
>          cachedir =3D (d.getVar("PERSISTENT_DIR", True) or d.getVar("CACH=
E", True))
>          if not cachedir:
> @@ -285,8 +292,8 @@ def auto_start(d):
>      if singleton:
>          host, port =3D singleton.getinfo()
>      else:
> -        host =3D d.getVar('PRSERV_HOST', True)
> -        port =3D int(d.getVar('PRSERV_PORT', True))
> +        host =3D host_params[0]
> +        port =3D int(host_params[1])
> =20
>      try:
>          return PRServerConnection(host,port).ping()
> --=20
> 1.7.11.7
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlECjNkACgkQN1Ujt2V2gBzW8wCgpyioftVZpZUQjELw/tLcsyna
HuwAoJiRYjC3I1oNSzh1K/Et4gtvrV1G
=77Id
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
