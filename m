Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <francesco.brundu@gmail.com>) id 1SWZyU-0008G2-TE
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 23:17:07 +0200
Received: by obhx4 with SMTP id x4so9611909obh.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=FoRfn+olnKWWGFzM/xLtU18nr3Aem56ND6bbsaX4Yhw=;
	b=s6yO71fdnnCCXQYHCcxn17S1u8siqF6dfvWAJzAK1qX65otZ6IMe9cdq8SmXEfQE3a
	1gYBnDmxuRKsnEs745YQUFKe9cvQL9UIVSIPcIye0MJY5SRWf0w5cQihrR5Zbm2ekGWy
	3RbYwyC4V2XfmdH/HzRD3Jt9tMldR8PPcEdBTwH1i8kd/FEUe0aSgzoLMdjImKQdwZMq
	RTCOhXr85pP4dSu7R++HpD4eBSIM4k2QJCmJko6BxcyeFHpwAyhtOfwCDvXvufcmyFlY
	EVcMhu1HAtbNjrxSemRB4hlmRYbgrVIUbZQws9sant8NKsgtm0M7MdztVC7NXD668rVD
	XoLQ==
MIME-Version: 1.0
Received: by 10.60.14.169 with SMTP id q9mr20796258oec.19.1337634418377; Mon,
	21 May 2012 14:06:58 -0700 (PDT)
Received: by 10.60.69.162 with HTTP; Mon, 21 May 2012 14:06:58 -0700 (PDT)
In-Reply-To: <CABcZANkK9QjB4s5707eW9fEkLvL5QvfayhmhjorhwEhe0Q2N0Q@mail.gmail.com>
References: <CAFc_i-FgKp-Gwr9GEs3ApjTE8vvwU=u7abOA1KwWRtEXpoV3cA@mail.gmail.com>
	<CABcZAN=ur8sRo3FW3o9FUwdG1Ceu+=hsyQuEcLnF-8MgtU7-Rg@mail.gmail.com>
	<CAFc_i-HzOPOde1=J0iXa5MoFJFhJjBn0JKV4meOgXfNkV=iV2g@mail.gmail.com>
	<CABcZANkK9QjB4s5707eW9fEkLvL5QvfayhmhjorhwEhe0Q2N0Q@mail.gmail.com>
Date: Mon, 21 May 2012 23:06:58 +0200
Message-ID: <CAFc_i-HObE76u6KP_E-qxpmOtC6b986DCdNk0fiR8-U2LWBO1A@mail.gmail.com>
From: "francesco.brundu@gmail.com" <francesco.brundu@gmail.com>
To: Chris Larson <clarson@kergoth.com>
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
X-List-Received-Date: Mon, 21 May 2012 21:17:07 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for your time, I thought that uclibc had to be built
separately. I somehow found correct variable name at
http://www.openembedded.org/wiki/Uclibc_FAQ
thanks to your hint. Just set ANGSTROMLIBC =3D "uclibc" in local.conf.
Thanks again.
Bye

On 21 May 2012 20:19, Chris Larson <clarson@kergoth.com> wrote:
> On Mon, May 21, 2012 at 11:15 AM, francesco.brundu@gmail.com
> <francesco.brundu@gmail.com> wrote:
>> Ok thanks. Bitbake now gives me "No provider Error" for uclibc
>>
>> user@ubuntu:~/stuff$ bitbake uclibc
>> Loading cache: 100%
>> |#######################################################################=
###########################################################################=
############################################|
>> Time: 00:00:02
>> Loaded 7102 entries from dependency cache.
>> Parsing recipes: 100%
>> |#######################################################################=
###########################################################################=
##########################################|
>> Time: 00:00:04
>> Parsing of 7217 .bb files complete (6456 cached, 761 parsed). 7886
>> targets, 310 skipped, 0 masked, 0 errors.
>>
>> Build Configuration:
>> BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "1.12.0"
>> METADATA_BRANCH =C2=A0 =3D "master"
>> METADATA_REVISION =3D "1ff63aa"
>> TARGET_ARCH =C2=A0 =C2=A0 =C2=A0 =3D "arm"
>> TARGET_OS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "linux-gnueabi"
>> MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "beagleboard"
>> DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "angstrom"
>> DISTRO_VERSION =C2=A0 =C2=A0=3D "v2012.05"
>> TARGET_FPU =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "hard"
>>
>> ERROR: Nothing PROVIDES 'uclibc'
>
> You didn't configure the metadata to use uclibc. Set TCLIBC to uclibc,
> if I remember correctly. And there should never be a need to bitbake
> it explicitly, the build automatically builds a C library when it
> needs one.
> --
> Christopher Larson



--=20
Francesco Brundu


