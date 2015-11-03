Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id A62E773D46
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 17:31:09 +0000 (UTC)
Received: by wmeg8 with SMTP id g8so21061039wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Nov 2015 09:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=MqG4sirKXM5gCdyoWscP7TfRDQeO9DTmRlJTHN4VYC8=;
	b=zeQoqrgA+r7fioqB88rNMQot0HDPYAjrcuTIXPv1hliF1JGJ6VPcVmjlT92w0aNN3Q
	9Tv6WDCbseq78638LRSVEEfR+xartmqTp6JM0mnX+xEpRy0+Lcm1xVZ8QyfLsVkqaXCj
	8Wlt2IUtknNkK9ozGrZOe74lHNkmHJxDcZFz4qI9iOcBZ5P+60pt2qDP7+uV5shtbe8Q
	5L3y6mAQZJGUT04cU9eaU7IrrIPdgJKZSxIExCn/bOo23iEXZiXEbhXiYq9s0PQXI1uz
	dIW4TyHmNhj2Y16KtRk5ElocFx2yaI0wai4nNbrDFIsNGo3qFFrN+Ph6X8N+5kJgZ+gY
	XZ7g==
X-Received: by 10.28.23.206 with SMTP id 197mr22515575wmx.88.1446571869369;
	Tue, 03 Nov 2015 09:31:09 -0800 (PST)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	e63sm24398522wma.7.2015.11.03.09.31.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Nov 2015 09:31:08 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Tue, 3 Nov 2015 18:31:13 +0100
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Message-ID: <20151103173113.GB2556@jama>
References: <1446570229-7700-1-git-send-email-ed.bartosh@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1446570229-7700-1-git-send-email-ed.bartosh@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] qemu-native: fix build on Ubuntu 15.10
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
X-List-Received-Date: Tue, 03 Nov 2015 17:31:11 -0000
X-Groupsio-MsgNum: 6620
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2015 at 07:03:49PM +0200, Ed Bartosh wrote:
> Build of qemu-native on Ubuntu 15.10 fails on configure step.
> The reason for this is that system dbus version is higher than
> oe dbus version and system pulseaudio libraries require newer dbus.
>=20
> It causes configure to break with a lot of errors similar to this:
>   libpulsecommon-6.0.so: undefined reference to dbus_watch_get_enabled@LI=
BDBUS_1_3
>=20
> Fixed by building qemu-native with the system dbus on Ubuntu 15.10
>=20
> Note: This is a workaround. It must be removed when oe dbus is upgraded
> to the version >=3D system dbus version (1.10.0 at the moment).
>=20
> [YOCTO #8553]
>=20
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

wrong ML

> ---
>  meta/recipes-devtools/qemu/qemu.inc | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/meta/recipes-devtools/qemu/qemu.inc b/meta/recipes-devtools/=
qemu/qemu.inc
> index abbace8..b17da2f 100644
> --- a/meta/recipes-devtools/qemu/qemu.inc
> +++ b/meta/recipes-devtools/qemu/qemu.inc
> @@ -40,6 +40,12 @@ do_configure_prepend_class-native() {
>  	BHOST_PKGCONFIG_PATH=3D$(PATH=3D/usr/bin:/bin pkg-config --variable pc_=
path pkg-config || echo "")
>  	if [ ! -z "$BHOST_PKGCONFIG_PATH" ]; then
>  		export PKG_CONFIG_PATH=3D$PKG_CONFIG_PATH:$BHOST_PKGCONFIG_PATH
> +		# link with system dbus on Ubuntu 15.10
> +		# FIXME: remove below 4 lines when oe dbus is upgraded
> +		if [ -r /etc/lsb-release -a "$(lsb_release -is)$(lsb_release -rs)" =3D=
 "Ubuntu15.10" ] ; then
> +			libs=3D$(PKG_CONFIG_ALLOW_SYSTEM_LIBS=3D1 PKG_CONFIG_PATH=3D$BHOST_PK=
GCONFIG_PATH PATH=3D/usr/bin:/bin pkg-config --libs dbus-1 || echo "")
> +			[ -n "$libs" ] && export LDFLAGS=3D"$libs $LDFLAGS"
> +		fi
>  	fi
>  }
> =20
> --=20
> 2.1.4
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlY472AACgkQN1Ujt2V2gBz+YACfRsoNSlBa7wa2B9F5I1DwH11R
yw8AoI772XJUjxXPKETx5vwsrF0JAvTI
=5JHZ
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
