Return-Path: <liu.ming50@gmail.com>
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
	[209.85.221.50])
	by mail.openembedded.org (Postfix) with ESMTP id AE6E56BA10
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 12:50:54 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id f7so13042589wrp.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ZQTMWv3dKcWhS2HBMgcWFYtTgEpZg4BoVOD4foJ5KTo=;
	b=Hm9yzs66rxOsaiaf28liSFnma99+ymfcRrXMWGh1YIZwGXKfGcBO4eWdqJ8+yyXjzB
	5rra++zNas3ENSJbTLV6ZRMMLvdYFsv2u0Jya5cAoaIylBDMSosLOUi7LlWD1yYpQS/P
	0ZJnVNjHLbiZaDoCX7/C9OV+cPRaIxkeM7wdtI7nzyqcaY8/xliJbbv7rq/DMjKfVq21
	DKw8rJYcjycglQDVw9z0JMvHeaA4d+QBaOGyJifrZPggGnpIwrkpcPJWiUG845Prlbeu
	QRxdWNwS3ElTm17fLam+9WFqR9st13LTZrP8S7SqHeu/AeAaR62qYzUpZl+VfgFXzQQM
	MX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ZQTMWv3dKcWhS2HBMgcWFYtTgEpZg4BoVOD4foJ5KTo=;
	b=VsDV5e3XTnDw/2tD8eSjaJUVKIdA0JEHFHgAB7/gYZOq8/ObRnnvPni67ljrs3FP1m
	bwtUyVeLBpXzmVy2RG16OlC6InoTZaVF+7fMRpmyVRLry9U5mVjGfVEpU/lVPzVltmx4
	L3KnYlK3qxWmCHSNfiF/mwOXVTmCiOiw6WUKWKN5iadt9/Ac3AvI55oogAqLvJjdkKaB
	yPU7VX+bViZ70FASVfr3oCh5t5ax9HM5C9NF1cVa3NiydMQPh9wPdKuefx3bqbeOJ7J5
	dsSt1EeT7lrLyvtrJ7n5V5v7WigNDzzKwrtpnfYpoynNXRWBI+MIIaGDxbBrRGQPuhaU
	uUdA==
X-Gm-Message-State: AJcUukeMUdJ9QX652M/K/4Wpg0saAVwSK9JT6zqTGngseHm39A2wYfxf
	D8j//cBjK+nkwHSLn16nFRz3Q1VzUFe9+TkquHM=
X-Google-Smtp-Source: ALg8bN58lJIa7XyNpueeIl9p9rstM5NdhXO3vMgsBrAbEGl3hiW39SSIhUE6FRbPH+aq8+vuVhFMK0eftORXGTR0TXE=
X-Received: by 2002:adf:fc89:: with SMTP id g9mr14665759wrr.96.1548507055181; 
	Sat, 26 Jan 2019 04:50:55 -0800 (PST)
MIME-Version: 1.0
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
	<3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
	<CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
In-Reply-To: <CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
From: Ming Liu <liu.ming50@gmail.com>
Date: Sat, 26 Jan 2019 13:50:42 +0100
Message-ID: <CALatG=68F2Zvj17nmTBZgC5FsxirfRPEmQY493nEVBq_4RW+kQ@mail.gmail.com>
To: Patrick Vacek <patrickvacek@gmail.com>
Cc: Luka Pivk <luka.pivk@toradex.com>, Stefan Agner <stefan.agner@toradex.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Sat, 26 Jan 2019 12:50:54 -0000
Content-Type: multipart/alternative; boundary="000000000000f4d51905805be45b"

--000000000000f4d51905805be45b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Mark:

I could reproduce the error reported by Stefan, on the tip:
...
commit 8c8ecec2a722bc2885e2648d41ac8df07bdf660d
Author: Mark Hatle <mark.hatle@windriver.com>
Date:   Wed Jan 23 10:28:18 2019 -0500

    gitsmy.py: Fix unpack of submodules of submodules
...


seems GitSM does not handle recursive submodules.

in my aktualizr/1.0+gitAUTOINC+d00d1a04cc-7/git/.git/config:
...
[submodule "tests/tuf-test-vectors"]
        url =3D
/mnt/oe/downloads/git2/github.com.advancedtelematic.tuf-test-vectors.
[submodule "partial/extern/isotp-c"]
        url =3D
/mnt/oe/downloads/git2/github.com.advancedtelematic.isotp-c.git
[submodule "third_party/HdrHistogram_c"]
        url =3D /mnt/oe/downloads/git2/github.com.HdrHistogram.HdrHistogram=
_c
[submodule "third_party/googletest"]
        url =3D /mnt/oe/downloads/git2/github.com.google.googletest.git
...

in which, /mnt/oe/downloads/git2/github.com.advancedtelematic.isotp-c.git
has its own submodule,

aktualizr/1.0+gitAUTOINC+d00d1a04cc-7/git/partial/extern/isotp-c/.gitmodule=
s
...
[submodule "deps/bitfield-c"]
        path =3D deps/bitfield-c
        url =3D https://github.com/advancedtelematic/bitfield-c.git
...

but that recursive submodule is fetched but not unpacked.

the best,
thank you

Patrick Vacek <patrickvacek@gmail.com> =E6=96=BC 2019=E5=B9=B41=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=881:07=E5=AF=AB=E9=81=93=EF=BC=
=9A

> On Sat, Jan 26, 2019 at 11:15 AM Stefan Agner <stefan@agner.ch> wrote:
>
>> > So it seems to be that something in the recipe was expecting semi-brok=
en
>> > behavior.. and its actually a recipe problem.
>>
>> Agreed, in this case we need to fix the recipe.
>>
> Sorry, I must be missing something. What might be wrong with the recipe?
> Is there more that needs to be specified than a SRCREV and a branch? As f=
ar
> as I understand git, it keeps track of the submodules, so I don't know wh=
at
> other information there would be to provide. The reason this particular
> case is difficult is because there are recursive submodules. When we buil=
d
> aktualizr, we have to be careful to specify that. See
> https://github.com/advancedtelematic/aktualizr#building:
>
> git submodule update --init --recursive
>
> Thanks,
> Patrick
>

--000000000000f4d51905805be45b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr">Hi, Mark:<div><br></div><div>I could reproduce the erro=
r reported by Stefan, on the tip:</div><div>...</div><div><div>commit 8c8ec=
ec2a722bc2885e2648d41ac8df07bdf660d</div><div>Author: Mark Hatle &lt;<a hre=
f=3D"mailto:mark.hatle@windriver.com">mark.hatle@windriver.com</a>&gt;</div=
><div>Date:=C2=A0 =C2=A0Wed Jan 23 10:28:18 2019 -0500</div><div><br></div>=
<div>=C2=A0 =C2=A0 gitsmy.py: Fix unpack of submodules of submodules</div><=
/div><div>...</div><div><br></div><div><br></div><div>seems GitSM does not =
handle recursive submodules.</div><div><br></div><div>in my=C2=A0aktualizr/=
1.0+gitAUTOINC+d00d1a04cc-7/git/.git/config:</div><div>...</div><div>[submo=
dule &quot;tests/tuf-test-vectors&quot;]</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 url =3D /mnt/oe/downloads/git2/github.com.advancedtelematic.tuf-test-ve=
ctors.</div><div>[submodule &quot;partial/extern/isotp-c&quot;]</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D /mnt/oe/downloads/git2/github.com.advan=
cedtelematic.isotp-c.git</div><div>[submodule &quot;third_party/HdrHistogra=
m_c&quot;]</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D /mnt/oe/downloads/=
git2/github.com.HdrHistogram.HdrHistogram_c</div><div>[submodule &quot;thir=
d_party/googletest&quot;]</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D /mn=
t/oe/downloads/git2/github.com.google.googletest.git=C2=A0</div><div>...</d=
iv><div><br></div><div>in which, /mnt/oe/downloads/git2/github.com.advanced=
telematic.isotp-c.git has its own submodule,=C2=A0</div><div><br></div><div=
>aktualizr/1.0+gitAUTOINC+d00d1a04cc-7/git/partial/extern/isotp-c/.gitmodul=
es<br></div><div>...</div><div><div>[submodule &quot;deps/bitfield-c&quot;]=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D deps/bitfield-c</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D <a href=3D"https://github.com/advancedt=
elematic/bitfield-c.git">https://github.com/advancedtelematic/bitfield-c.gi=
t</a></div></div><div>...</div><div><br></div><div>but that recursive submo=
dule is fetched but not unpacked.</div><div><br></div><div>the best,</div><=
div>thank you</div></div></div></div></div></div></div></div></div></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Pa=
trick Vacek &lt;<a href=3D"mailto:patrickvacek@gmail.com">patrickvacek@gmai=
l.com</a>&gt; =E6=96=BC 2019=E5=B9=B41=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=85=
=AD =E4=B8=8B=E5=8D=881:07=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div dir=3D"ltr">On Sat, Jan 26, 2019 at 11:15 AM Stefan Agne=
r &lt;<a href=3D"mailto:stefan@agner.ch" target=3D"_blank">stefan@agner.ch<=
/a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt; So it seems to be that something in the recipe was expecting semi-brok=
en<br>
&gt; behavior.. and its actually a recipe problem.<br>
<br>
Agreed, in this case we need to fix the recipe.<br></blockquote><div>Sorry,=
 I must be missing something. What might be wrong with the recipe? Is there=
 more that needs to be specified than a SRCREV and a branch? As far as I un=
derstand git, it keeps track of the submodules, so I don&#39;t know what ot=
her information there would be to provide. The reason this particular case =
is difficult is because there are recursive submodules. When we build aktua=
lizr, we have to be careful to specify that. See=C2=A0<a href=3D"https://gi=
thub.com/advancedtelematic/aktualizr#building" target=3D"_blank">https://gi=
thub.com/advancedtelematic/aktualizr#building</a>:</div><div><br></div><div=
><div>git submodule update --init --recursive</div></div><div><br></div><di=
v>Thanks,</div><div>Patrick</div></div></div></div></div>
</blockquote></div>

--000000000000f4d51905805be45b--
