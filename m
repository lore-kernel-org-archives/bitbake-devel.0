Return-Path: <anibal.limon@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 08CD76E64A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Feb 2017 16:29:07 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Feb 2017 08:29:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,162,1484035200"; 
	d="asc'?scan'208";a="65688190"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.128.120])
	([10.219.128.120])
	by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2017 08:29:07 -0800
To: bitbake-devel@lists.openembedded.org
References: <1486074561-27644-1-git-send-email-anibal.limon@linux.intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <58A3311B.6090205@linux.intel.com>
Date: Tue, 14 Feb 2017 10:32:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1486074561-27644-1-git-send-email-anibal.limon@linux.intel.com>
Cc: paul.eggleton@linux.intel.com
Subject: Re: [PATCH] bitbake-layers: Handle exception raised bytinfoil.prepare()
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
X-List-Received-Date: Tue, 14 Feb 2017 16:29:08 -0000
X-Groupsio-MsgNum: 8418
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hvmfFl2RP747gIuMT1Blp9DKXekW5GVEw"

--hvmfFl2RP747gIuMT1Blp9DKXekW5GVEw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ping

On 02/02/2017 04:29 PM, An=C3=ADbal Lim=C3=B3n wrote:
> The tinfoil.prepare method can raise Exceptions when is parsing initial=

>  data so add this call inside try, finally to avoid get blocked for
> don't call tinfoil.shutdown().
>=20
> The tinfoil_init function was remove because isn't make sense now since=

>  tinfoil.prepare() needs to be inside try, finally closures.
>=20
> Example of raised exception and gets blocked:
>=20
> $ bitbake-layers add-layer ~/repos/meta-openembedded/meta-python/
>=20
> Traceback (most recent call last):
>   File "/home/alimon/repos/poky/bitbake/bin/bitbake-layers", line 83, i=
n
> main
>     tinfoil.prepare(True)
> ...
>   File "/home/alimon/repos/poky/bitbake/lib/bb/tinfoil.py", line 268, i=
n
> run_command
>     raise TinfoilCommandFailed(result[1])
> bb.tinfoil.TinfoilCommandFailed: Traceback (most recent call last):
>   File "/home/alimon/repos/poky/bitbake/lib/bb/command.py", line 81, in=

> runCommand
>     result =3D command_method(self, commandline)
> ...
>   File "/home/alimon/repos/poky/bitbake/lib/bb/cooker.py", line 1314, i=
n
> handleCollections
>     raise CollectionError("Errors during parsing layer configuration")
> bb.cooker.CollectionError: Errors during parsing layer configuration
>=20
> Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linux.intel.com>
> ---
>  bin/bitbake-layers | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/bin/bitbake-layers b/bin/bitbake-layers
> index 1e2cfbc..66fc7ca 100755
> --- a/bin/bitbake-layers
> +++ b/bin/bitbake-layers
> @@ -31,15 +31,6 @@ sys.path[0:0] =3D [os.path.join(topdir, 'lib')]
> =20
>  import bb.tinfoil
> =20
> -
> -def tinfoil_init(parserecipes):
> -    import bb.tinfoil
> -    tinfoil =3D bb.tinfoil.Tinfoil(tracking=3DTrue)
> -    tinfoil.prepare(not parserecipes)
> -    tinfoil.logger.setLevel(logger.getEffectiveLevel())
> -    return tinfoil
> -
> -
>  def logger_create(name, output=3Dsys.stderr):
>      logger =3D logging.getLogger(name)
>      loggerhandler =3D logging.StreamHandler(output)
> @@ -86,8 +77,10 @@ def main():
>      logger_setup_color(logger, global_args.color)
> =20
>      plugins =3D []
> -    tinfoil =3D tinfoil_init(False)
> +    tinfoil =3D bb.tinfoil.Tinfoil(tracking=3DTrue)
> +    tinfoil.logger.setLevel(logger.getEffectiveLevel())
>      try:
> +        tinfoil.prepare(True)
>          for path in ([topdir] +
>                      tinfoil.config_data.getVar('BBPATH').split(':')):
>              pluginpath =3D os.path.join(path, 'lib', 'bblayers')
>=20


--hvmfFl2RP747gIuMT1Blp9DKXekW5GVEw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYozEdAAoJEGJqcE9h3glgbjUP/0HCepK2bypBDYKuJiWCo1OE
Y/58XSdhTqnunBE9T97agkjveXPxnzU4ojfTmvPih+TIVPvQ7KVyDe1kGrq2rS/9
5HVIweaEdKSnCJZVDMGa4B32BfCL+j7ofp6imPeRbT26PEq0gvpwuZ1ALTPPiNd4
odgVPeytosE2ihfZowzfL3qcOucgXlAKg12M/GeRCYdYypRY7I6IdI0F7GuB2dPa
LQsd2SlfZZLEtwCM3LT/HtHxsjpeImL0bl1v04WVdPBbEqvUvRYQLj5pUtmNRZyw
yg13k7S7V6lzBJ7Ym4CZxIJHNpPu8p6BhNLQWESqABvPHE3a/d4U10Hvc5O4UX9E
HAzx3hUf8hTpTRvWNud94JCknhgS6rlFkTSuvxFDSQs868V4hlC+LSAJUmgGWBXS
cdbNI5P17U4ItoQ7fPBbf1NdVUNf38y22BxaxB4LhkaEp5xJ1TU8lwffiUpPLKRK
qEUFWo3P3MagNJ5VhP92c4zQuowYVvWfVHoCGlRMIjFmMrgZ0Oo+blRe4obdboYJ
HiRZpwg8rsuk3t3ONWywiJgmE600fEF3DgwcGpmjwXPtzxKRKQnuP56+2f3Gsn2S
vMRY0fxuPmBdFahEkDrxRYMM0qA1KObNOrQmtHjYbu9JHYRfUEk63BK27BQaLLfH
+9wLjk1/23Mgp4NQVGNU
=Fa8F
-----END PGP SIGNATURE-----

--hvmfFl2RP747gIuMT1Blp9DKXekW5GVEw--
