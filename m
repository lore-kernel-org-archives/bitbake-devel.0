Return-Path: <alex.kanavin@gmail.com>
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
	[209.85.217.47])
	by mail.openembedded.org (Postfix) with ESMTP id 412047F33B;
	Thu,  1 Aug 2019 16:59:14 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id 190so49358284vsf.9;
	Thu, 01 Aug 2019 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pWmYABbCfxL/IYLniK/ZSFkmyHhIrf9zptEZrF8KE7Y=;
	b=EnPV74/CeOuIXzNh2G14G2KJyrntPy/CIb9NYNKC875j6fc5ZnOz5LAnQ7BTXEpRrZ
	EgKm8u+BCRE4RW9pkzEbiKZcvNNmxPKLPFNgco5n38nEnXVRYcK+D5B1SWPeqoKwPtc2
	kARzmObikxV/nDKQJnNOtp8k7zCTzLFswYDqXbBQMyJz3C/bB+1yNBVDtvVmvO00QppF
	v0MU7rs1NsYOgKMJ8+ka7K6BBJUbz65Ivh1+oEgj8S+1MwZUprlv/+OXGasAeT+oT7/u
	YSr1azwOPRgJDLmVQT2vv5DymUjeS0cK1X91yWsd1jbSmF2+UGYYEZxouDsYme6bAMjc
	ll4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pWmYABbCfxL/IYLniK/ZSFkmyHhIrf9zptEZrF8KE7Y=;
	b=dYuViF3oecfmBfIy/zx5wrgh4nGw+jSleoC1IMdFK+KrqAMizjYTk5X7bC2gBO8T0D
	arwtAumsjow9ymeSRRp1f9dPoN4bvmPjnTdnbwTt85wNk5e4aCi3H4SRmzq3poS9IQG1
	Qjv2EffXVWSLJtgnqj9ajnVZTq7vPzpBu9RaGp9KBbzpfUgESehdk+Xwf8apbO3D+uZ6
	SUcQ1l9baLLyYnEL7lg2J3nKJKBp2Km37RXSDc38iiVJ88CwVmvrd/FI5AlOADCqGr4w
	qVJHOIiEaEUS111Tc/yM7xUBJvnbwKV+64BtJ2lg4xUTfPoHR09hcMOvgrXk3xtHQXJp
	pgmA==
X-Gm-Message-State: APjAAAXqHu8NuEWYfM2sZ/fVBcvIbUu0fmCYlBu1RTwMo1juKUplNvnz
	ZWVf1Jvoy9WO03/16sSJ+6IPDulstJWRqjhC6OEkNtb1
X-Google-Smtp-Source: APXvYqx/gdQ9e4mFSdBAIt7EHRrhe500A06gYHNH5RxS/a545NncNhGJ+/4VQTkjVzLNlRZthzA9Fne+EGl7liwKIaw=
X-Received: by 2002:a67:8709:: with SMTP id j9mr83424023vsd.35.1564678755232; 
	Thu, 01 Aug 2019 09:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 1 Aug 2019 18:59:04 +0200
Message-ID: <CANNYZj9+4L=N-5KCmcb8Xe_NyY=6iygbnq7quedZWR2cZocKrw@mail.gmail.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>
Subject: Re: RFC: exposing information about the SRC_URI(s)/branch via buildhistory (or similar mechanism)
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
X-List-Received-Date: Thu, 01 Aug 2019 16:59:15 -0000
Content-Type: multipart/alternative; boundary="00000000000064b369058f112993"

--00000000000064b369058f112993
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, but I think you should drop the practice of using AUTOREV. This
completely destroys reproducibility of builds, and makes them susceptible
to global breakage when someone pushes a broken commit into one of the
component repositories.

Yes, bumping SRCREV is annoying, but a) it can be automated; b) you can
catch and reject any problems with the build at that point, so you always
have a nightly that works.

AUTOREV was never meant for the project level, it is a facility strictly
for local development.

Alex

On Thu, 1 Aug 2019 at 18:51, chris.laplante--- via bitbake-devel <
bitbake-devel@lists.openembedded.org> wrote:

> Hello all,
>
>
>
> Most of my team=E2=80=99s closed source recipes use something like the fo=
llowing:
>
>
>
> SRC_URI =3D "git://git@host/path;protocol=3Dssh;branch=3D${BRANCH}"
>
> SRCREV =3D =E2=80=9C${AUTOREV}=E2=80=9D
>
> BRANCH ??=3D =E2=80=9Cmaster=E2=80=9D
>
>
>
> (BRANCH is just a convention we use to make the SRC_URI branch easy to
> override.)
>
>
>
> This makes nightly builds convenient because we always build from the
> latest. For release versions, we can use SRCREV_pn-recipe and/or
> BRANCH_pn-recipe overrides in local.conf. We get the SRCREV overrides usi=
ng
> buildhistory-collect-srcrevs. But buildhistory has no notion or tracking =
of
> SRC_URI or branches, so currently we use a script that generates the BRAN=
CH
> overrides.
>
>
>
> I=E2=80=99m interesting in adding SRC_URI support to buildhistory (or a s=
imilar
> mechanism), and would like to get some input.
>
>
>
> Option 1) The easiest way, I think, is to just generate SRC_URI_pn-
> overrides with variable expansion.
>
>
>
> Option 2) I think it could be useful to introduce BRANCH as a convention.
> Currently the =E2=80=9Cbranch=E2=80=9D SRC_URI parameter implicitly defau=
lts to =E2=80=9Cmaster=E2=80=9D. I
> could foresee it implicitly defaulting to =E2=80=9C${BRANCH}=E2=80=9D, wi=
th BRANCH ??=3D
> =E2=80=9Cmaster=E2=80=9D to replicate existing functionality. To handle m=
ultiple
> source-controlled SRC_URIs, we=E2=80=99d have to do something similar to =
how SRCREV
> has a =E2=80=9Cname=E2=80=9D override. With this option, I wouldn=E2=80=
=99t think it would be
> necessary to generate SRC_URI overrides; just BRANCH overrides.
>
>
>
> Option 3) A combination of 1 and 2?
>
>
>
> Looking forward to input.
>
>
>
> Thanks,
>
> Chris
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000064b369058f112993
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Apologies, but I think you should drop the practice o=
f using AUTOREV. This completely destroys reproducibility of builds, and ma=
kes them susceptible to global breakage when someone pushes a broken commit=
 into one of the component repositories. </div><br><div>Yes, bumping SRCREV=
 is annoying, but a) it can be automated; b) you can catch and reject any p=
roblems with the build at that point, so you always have a nightly that wor=
ks.</div><div><br></div><div>AUTOREV was never meant for the project level,=
 it is a facility strictly for local development.<br></div><div><br></div><=
div>Alex<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, 1 Aug 2019 at 18:51, chris.laplante--- via bitbak=
e-devel &lt;<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake=
-devel@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_-1566771397637526125WordSection1">
<p class=3D"MsoNormal">Hello all,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Most of my team=E2=80=99s closed source recipes use =
something like the following:
<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:0.5in">SRC_URI =3D &quot;git://=
git@host/path;protocol=3Dssh;branch=3D${BRANCH}&quot;<u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:0.5in">SRCREV =3D =E2=80=9C${AU=
TOREV}=E2=80=9D<u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:0.5in">BRANCH ??=3D =E2=80=9Cma=
ster=E2=80=9D<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">(BRANCH is just a convention we use to make the SRC_=
URI branch easy to override.)<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">This makes nightly builds convenient because we alwa=
ys build from the latest. For release versions, we can use SRCREV_pn-recipe=
 and/or BRANCH_pn-recipe overrides in local.conf. We get the SRCREV overrid=
es using buildhistory-collect-srcrevs.
 But buildhistory has no notion or tracking of SRC_URI or branches, so curr=
ently we use a script that generates the BRANCH overrides.
<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I=E2=80=99m interesting in adding SRC_URI support to=
 buildhistory (or a similar mechanism), and would like to get some input.
<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Option 1) The easiest way, I think, is to just gener=
ate SRC_URI_pn- overrides with variable expansion.
<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Option 2) I think it could be useful to introduce BR=
ANCH as a convention. Currently the =E2=80=9Cbranch=E2=80=9D SRC_URI parame=
ter implicitly defaults to =E2=80=9Cmaster=E2=80=9D. I could foresee it imp=
licitly defaulting to =E2=80=9C${BRANCH}=E2=80=9D, with BRANCH ??=3D =E2=80=
=9Cmaster=E2=80=9D to replicate
 existing functionality. To handle multiple source-controlled SRC_URIs, we=
=E2=80=99d have to do something similar to how SRCREV has a =E2=80=9Cname=
=E2=80=9D override. With this option, I wouldn=E2=80=99t think it would be =
necessary to generate SRC_URI overrides; just BRANCH overrides.<u></u><u></=
u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Option 3) A combination of 1 and 2?<u></u><u></u></p=
>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Looking forward to input.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
<p class=3D"MsoNormal">Chris<u></u><u></u></p>
</div>
</div>

-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--00000000000064b369058f112993--
