Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SKeer-0006DS-3l
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Apr 2012 01:51:33 +0200
Received: by qafl39 with SMTP id l39so1131550qaf.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Apr 2012 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=3FpuMncpaXOX//6l2a1TiC3+HZ8mYVbRUOxrUaziIG0=;
	b=SqiwvK+F/hZl+jAvijXyk5vFCp9faU//u492dfL/2I0NPr2csRhknHYNSoCFgwFL9I
	titA/Vxi0B0Tg5SAhgdRwApizGiRduWYKkbMhgvGV3R7pyuBLUDQgzEwIKILrda6eQnn
	2Smx6ZVVtrIrwq8eJEjlmJs3NqQb8ZD+MH10NA1xT/0u8EyTDri2bO+w6ocpwOkBrMrx
	surMG1r1jmsDGiEgANC5Eip5iMkAozQKEQxB7WaM7OA9aZV7ShKPSmDkUDU3d1cl0CwU
	0+nqQwvyX23bfbaJGMWYqD0PTaybQxNcDurJJqYlHldoNIWHI25aBtH2fwgB/ynbO/AH
	fanQ==
Received: by 10.229.136.17 with SMTP id p17mr1736721qct.151.1334792524738;
	Wed, 18 Apr 2012 16:42:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.79.79 with HTTP; Wed, 18 Apr 2012 16:41:44 -0700 (PDT)
In-Reply-To: <E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
From: Chris Larson <kergoth@gmail.com>
Date: Wed, 18 Apr 2012 16:41:44 -0700
Message-ID: <CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Cc: "'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: python function used in variable expansion called multiple times per recipe
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
X-List-Received-Date: Wed, 18 Apr 2012 23:51:33 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 4:39 PM, Daniel Lazzari <dlazzari@leapfrog.com> wro=
te:
> I think immediate expansion is what I=E2=80=99ll need to use, thanks for =
the tip.
> That at least brings the invocation down to once per run. Unfortunately, =
the
> variable doesn=E2=80=99t seem to get filled in when I change to immediate=
 expansion.
>
> def testFunc(bb, d):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 print( bb.data.getVar("PN", d, True) )
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return "e1"
>
> EXTERNPV :=3D "${@testFunc(bb, d)}"
>
> Now only prints the package name once, but using =E2=80=93e, I don=E2=80=
=99t see the
> variable EXTERNPV at all.

Don't know what to tell you. It does work, so it's something wrong on
your end. Either it's returning an empty string, which will result in
-e only showing the commented out definition, or it's raising an
exception, or something else in your setup. Aside: you don't need to
pass 'bb' in. That namespace is always accessible, even from def'd
python functions.
--=20
Christopher Larson


