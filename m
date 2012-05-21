Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SWXMm-0005ay-Ca
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 20:30:00 +0200
Received: by werg55 with SMTP id g55so3747237wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=RIp0l6e/94s7YZYo986vhlVmNwBv01l0qeguWwqNeO4=;
	b=bAjNngR1WrtBePvarAkRGSfGN6gx8GvmlUD0EoO/5IA0l4afVInJ0yJ+lA3yryVmb7
	X9X4Xl5UtAa6Ub/l/oBvgcDS/eizhtLRWu2383u+2CvcI2YZCSMpwIjPWkxk9s3JopTZ
	HuoFB0Dfrf6T/1l8cP+xFCkANrGin4VlYH3ADYNv2vp1oo33i7M5MVG+EKXJzySi5b6t
	DPCddY5V8TvTwGAoS9yXkiPMFrd1m2Ayj01RSYPcstYgTXRPYNXFbPVLILtOBiwd9lNw
	OjzR9K1dah5po0RaR745lXr6JpqGe0xI5zyXN+pE/vxqfyVKLr4jbBfcxI0J6+mTwOsx
	e5fA==
Received: by 10.216.132.75 with SMTP id n53mr13712370wei.51.1337624392637;
	Mon, 21 May 2012 11:19:52 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Mon, 21 May 2012 11:19:32 -0700 (PDT)
In-Reply-To: <CAFc_i-HzOPOde1=J0iXa5MoFJFhJjBn0JKV4meOgXfNkV=iV2g@mail.gmail.com>
References: <CAFc_i-FgKp-Gwr9GEs3ApjTE8vvwU=u7abOA1KwWRtEXpoV3cA@mail.gmail.com>
	<CABcZAN=ur8sRo3FW3o9FUwdG1Ceu+=hsyQuEcLnF-8MgtU7-Rg@mail.gmail.com>
	<CAFc_i-HzOPOde1=J0iXa5MoFJFhJjBn0JKV4meOgXfNkV=iV2g@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 21 May 2012 11:19:32 -0700
X-Google-Sender-Auth: -JDTs97_oWI30Z78yN3RM2xCWxY
Message-ID: <CABcZANkK9QjB4s5707eW9fEkLvL5QvfayhmhjorhwEhe0Q2N0Q@mail.gmail.com>
To: "francesco.brundu@gmail.com" <francesco.brundu@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake raises MultipleMatches exception while trying to build uclibc
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
X-List-Received-Date: Mon, 21 May 2012 18:30:00 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 11:15 AM, francesco.brundu@gmail.com
<francesco.brundu@gmail.com> wrote:
> Ok thanks. Bitbake now gives me "No provider Error" for uclibc
>
> user@ubuntu:~/stuff$ bitbake uclibc
> Loading cache: 100%
> |########################################################################=
###########################################################################=
###########################################|
> Time: 00:00:02
> Loaded 7102 entries from dependency cache.
> Parsing recipes: 100%
> |########################################################################=
###########################################################################=
#########################################|
> Time: 00:00:04
> Parsing of 7217 .bb files complete (6456 cached, 761 parsed). 7886
> targets, 310 skipped, 0 masked, 0 errors.
>
> Build Configuration:
> BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "1.12.0"
> METADATA_BRANCH =C2=A0 =3D "master"
> METADATA_REVISION =3D "1ff63aa"
> TARGET_ARCH =C2=A0 =C2=A0 =C2=A0 =3D "arm"
> TARGET_OS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "linux-gnueabi"
> MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "beagleboard"
> DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "angstrom"
> DISTRO_VERSION =C2=A0 =C2=A0=3D "v2012.05"
> TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "hard"
>
> ERROR: Nothing PROVIDES 'uclibc'

You didn't configure the metadata to use uclibc. Set TCLIBC to uclibc,
if I remember correctly. And there should never be a need to bitbake
it explicitly, the build automatically builds a C library when it
needs one.
--=20
Christopher Larson


