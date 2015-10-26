Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id 6CF2773D27
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Oct 2015 16:19:11 +0000 (UTC)
Received: by padhk11 with SMTP id hk11so192825652pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Oct 2015 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:content-type:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=7vEabmItpIYTqx1vb5207WcbkSlDa851u5etkif54FI=;
	b=BkG5epBJZj97bwhXxeJWZ4ciH2bO9OVoUkKHFNSpn+kZ7MLUGIsrr7k+8QRH8b4orl
	9RrAvIMTkRVwGshSXPpPCpaK4JeDMbFSduETDxJlb3uhVKY3fgvjuouTPCCFL4Ld5sN6
	i4onf0PdTIJ1ypU66NAhciX/nABLa78Jg+wLV0P04H/bdjNVdi4BMqZIKUuQeC0IOSDe
	Ve0Zmg10X+Rh3IMW91KGIkqC+io/OMWCg/hSfkSz/KPD820nLv2J9JgtRqSe/+5ZNA7Y
	MW7f4ZNast4sGY5W4ovQFjsBk8yJpPBVmaBEJ4YY8lCmfec/eSbO8fATIpvaQyZX0Icz
	Bztw==
X-Received: by 10.66.123.72 with SMTP id ly8mr22671490pab.92.1445876352110;
	Mon, 26 Oct 2015 09:19:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4c02:370d:34a0:c0:a34c:c36c?
	([2601:647:4c02:370d:34a0:c0:a34c:c36c])
	by smtp.gmail.com with ESMTPSA id
	zk3sm34786418pbb.41.2015.10.26.09.19.11
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 26 Oct 2015 09:19:11 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
X-Pgp-Agent: GPGMail 2.6b2
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <CAKV_0egMyNQ2bzbO+gydU+vDsc_xwGgKgwmh9YW8vynVhShQ8Q@mail.gmail.com>
Date: Mon, 26 Oct 2015 09:19:02 -0700
Message-Id: <40CEB3B1-8820-4D38-91B6-5A41DACC4AED@gmail.com>
References: <1445723789-7493-1-git-send-email-raj.khem@gmail.com>
	<CAKV_0egMyNQ2bzbO+gydU+vDsc_xwGgKgwmh9YW8vynVhShQ8Q@mail.gmail.com>
To: Brian Avery <avery.brian@gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: Point to meta/conf for default toasterconf.json
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
X-List-Received-Date: Mon, 26 Oct 2015 16:19:12 -0000
X-Groupsio-MsgNum: 6597
Content-Type: multipart/signed;
	boundary="Apple-Mail=_B2F2AD22-2892-4DBC-80D9-5A4EE303342C";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_B2F2AD22-2892-4DBC-80D9-5A4EE303342C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Oct 26, 2015, at 9:05 AM, Brian Avery <avery.brian@gmail.com> =
wrote:
>=20
> True,
>=20
> but then builds for poky would fail :(
>=20
> How about something like (posted from gmail so just for discussion not
> to be used!!):
>=20
> if [ "$TOASTER_CONF" =3D "" ]; then
>=20
> -    TOASTER_CONF=3D"$(dirname =
$TOASTER)/../../meta-yocto/conf/toasterconf.json"
>=20
> +    if [ -e "$(dirname
> $TOASTER)/../../meta-yocto/conf/toasterconf.json" ] ; then
>=20
> +       TOASTER_CONF=3D"$(dirname
> $TOASTER)/../../meta-yocto/conf/toasterconf.json"
>=20
> +    elif [ -e "$(dirname $TOASTER)/../../meta/conf/toasterconf.json" =
] ; then
>=20
> +       TOASTER_CONF=3D"$(dirname =
$TOASTER)/../../meta/conf/toasterconf.json"
>=20
> +    fi
>=20
>     export TOASTER_CONF=3D$(python -c "import os; print
> os.path.realpath('$TOASTER_CONF')=E2=80=9D)

I think checking meta-yocto and meta is just doing it for two distro=E2=80=
=99s
IMO OE-Core should just default to meta/ and meta-yocto/poky should then
set TOASTER_CONF in its distro.conf

>=20
> fi
>=20
> -b
>=20
> On Sat, Oct 24, 2015 at 2:56 PM, Khem Raj <raj.khem@gmail.com> wrote:
>> meta-yocto may not exist in nodistro env
>>=20
>> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>> ---
>> bin/toaster | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/bin/toaster b/bin/toaster
>> index 2c3432c..c1a01f0 100755
>> --- a/bin/toaster
>> +++ b/bin/toaster
>> @@ -196,7 +196,7 @@ fi
>> # in the local layers that currently prevent using an arbitrary
>> # toasterconf.json
>> if [ "$TOASTER_CONF" =3D "" ]; then
>> -    TOASTER_CONF=3D"$(dirname =
$TOASTER)/../../meta-yocto/conf/toasterconf.json"
>> +    TOASTER_CONF=3D"$(dirname =
$TOASTER)/../../meta/conf/toasterconf.json"
>>     export TOASTER_CONF=3D$(python -c "import os; print =
os.path.realpath('$TOASTER_CONF')")
>> fi
>> if [ ! -f $TOASTER_CONF ]; then
>> --
>> 2.6.2
>>=20
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


--Apple-Mail=_B2F2AD22-2892-4DBC-80D9-5A4EE303342C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlYuUn0ACgkQuwUzVZGdMxSBEwCfZn71Zj5dozZZn16antth/wf/
ZyQAn0YRflECmj1waO1002rnIPqglWEi
=y/q8
-----END PGP SIGNATURE-----

--Apple-Mail=_B2F2AD22-2892-4DBC-80D9-5A4EE303342C--
