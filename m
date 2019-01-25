Return-Path: <liu.ming50@gmail.com>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail.openembedded.org (Postfix) with ESMTP id E3A7E60402
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 13:45:07 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id m1so6833325wml.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 05:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=n+nP02ZC2BPhfIXJxdgCCnpjkQJrqzTR6RpcfbHHF8E=;
	b=OnAXWymqIKR34VSs3Nh6UOHtjWRYp2HkCcbmVZiH0JXFxquPwek3UyzNWU0DTkmgBe
	UvFfcOFJ2lUhqnt2jrXdJsvC4Z8Hhj5lJbWX3eGpr2PCnFg5JiblgYrtzdwfcMH20Ty3
	c3OqrT2+97b7unlKaXtmRApX+bWWdoKkh1nEc87MVEWqL3IAZZDM9J+wOAJoxQs08YOu
	Jna3UR3eEgQDHjY1IVGzNUxXBVCMBcwE/xJEebR+nWi0wHFLxA7kr1qu49czadFC+3Iy
	4EiggsCNjeM1FNbd91xelp4h2QooR3MpwRNifiTchTnEOLcEkUSBooxCxKpUzjm8EkSY
	V97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=n+nP02ZC2BPhfIXJxdgCCnpjkQJrqzTR6RpcfbHHF8E=;
	b=UXF+uMWuDyIplBrdmrvIduofYanuPdVvtdQhN71F55WO0BE9rh4sOYuh08BGcYv/cF
	JXQAXecBL0JgP22A9mJ/4liBEt0pYCxa/jU4+y/g6v77opY05T8IBz3/v4XRw9z9QJAC
	L//1nWoUiG9zyscfgMIMP+QlLAYqyJw8szTrAB/Iqe2m479gq7txULwTZQlk5FeHZWmg
	mb50KkBv8C7sIm/7bRq6a94eL7Wg4D8Il+u0lKY5Q6vIjoUWmLBW3szXhFtRXaOqQOJ+
	brVYCZcc+aYtaO2Bh5MlVDQV2M32O6JkmxA8EvzT88nJ9a7xnDXeoPWGFLGYJSF+s8gc
	nW8A==
X-Gm-Message-State: AJcUukdL0319SW1ll+4wlifLBn7F1Af2zcOzQUqqIrXBV7ojOc3ocBPy
	kODTOCJfC595rYoLO74dowKoJLuydRcxoAbd9tg=
X-Google-Smtp-Source: ALg8bN6EhdrQI2W4pob/Ghg/K7DfXUgCTH8Oiaw71EuqB441HO+doEBVqPF1xOxzjzV1qMpgJZT1k0r16JsR02RXFJE=
X-Received: by 2002:a1c:e1d5:: with SMTP id y204mr6945255wmg.65.1548423908374; 
	Fri, 25 Jan 2019 05:45:08 -0800 (PST)
MIME-Version: 1.0
References: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
	<18561a9b63079e5dc2d4b4a8b6b12728475b0402.camel@linuxfoundation.org>
	<CALatG=7YgmkROJpk_6pfZFKGP3=RjoJC_mh3gRsKMF+e=6=aqA@mail.gmail.com>
	<1dbceb752ca54fcbb32c4c4325272b80670693f4.camel@linuxfoundation.org>
In-Reply-To: <1dbceb752ca54fcbb32c4c4325272b80670693f4.camel@linuxfoundation.org>
From: Ming Liu <liu.ming50@gmail.com>
Date: Fri, 25 Jan 2019 14:44:57 +0100
Message-ID: <CALatG=5tuk+qOc3D67wFpP=bnPxxyP4r-K=5wD2ieVgMYEhD+Q@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	mark.hatle@windriver.com
Cc: bitbake-devel@lists.openembedded.org,
	Stefan Agner <stefan.agner@toradex.com>, Luka Pivk <luka.pivk@toradex.com>
Subject: Re: [PATCH] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 13:45:08 -0000
Content-Type: multipart/alternative; boundary="000000000000053d1e0580488918"

--000000000000053d1e0580488918
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Richard:

Involve in Mark.

Please correct me if I am wrong, but according to the code, seems these
upper level locks could not protect this race condition, because it's
inside the GitSM unpack function, the call chain is:

Inside GitSM:
```
def unpack
  -> for module in submodules:
       -> unpack_submodules
            -> runfetchcmd
                 -> bb.process.run
                      -> git config submodule
```

since 'git config submodule' run concurrently and try to modify a same git
config file, hence the race might happen, but it's hard to be reproduced
since 'git config submodule' finishes quite quickly.

//Ming Liu

Richard Purdie <richard.purdie@linuxfoundation.org> =E6=96=BC 2019=E5=B9=B4=
1=E6=9C=8825=E6=97=A5 =E9=80=B1=E4=BA=94
=E4=B8=8B=E5=8D=881:24=E5=AF=AB=E9=81=93=EF=BC=9A

> On Fri, 2019-01-25 at 12:35 +0100, Ming Liu wrote:
> > Hi, Stefan:
> >
> > Could you help confirm this?
> >
> > Hi, Richard:
> >
> > May I know how has the issue been fixed?
> >
> > I updated the tip to:
> > ```
> > commit 8c8ecec2a722bc2885e2648d41ac8df07bdf660d
> >     gitsmy.py: Fix unpack of submodules of submodules
> >
> >     If the submodule is in a subdirectory, it needs to have that
> > structure
> >     preserved.  This means the unpack path needs to be in the
> > 'dirname' of the
> >     final path -- since the unpack directory name is specified in the
> > URI.
> >
> >     Additional specific test cases were added to ensure this is
> > working properly
> >     based on two recent error reports.
> >
> >     Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> >     Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
> > >
> > ```
> > on top of that commit, I could see there are "git config submodule"
> > being called concurrently in different processes, which does have a
> > race condition, and will lead to the error observed by Stefan,
> > although it's not easy to be reproduced.
>
> There are locks at a higher level in the fetchers, in
> lib/bb/fetch2/__init__.py the download() method has:
>
> if ud.lockfile:
>     lf =3D bb.utils.lockfile(ud.lockfile)
>
> and the unpack() method has similar locks.
>
> Mark and I believe there were some code paths where the locks were
> being bypassed in the gitsm fetcher but Mark reworked the code so that
> we were both happy that there should always be a lock held.
>
> We need to fix any races properly ensuring they're covered by the main
> fetcher locks, adding new ones would only fix a symptom of the real
> problem.
>
> Cheers,
>
> Richard
>
>
>
>

--000000000000053d1e0580488918
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi, Richard:</div><div><br></div><di=
v>Involve in Mark.</div><div><br></div><div>Please correct me if I am wrong=
, but according to the code, seems these upper level locks could not protec=
t this race condition, because it&#39;s inside the GitSM unpack function, t=
he call chain is:</div><div><br></div><div>Inside GitSM:</div><div>```</div=
><div>def unpack</div><div>=C2=A0 -&gt; for module in submodules:</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; unpack_submodules=C2=A0</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; runfetchcmd</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; bb.process.run</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 -&gt; git config submodule</div><div>```</div><div><br></div><di=
v>since &#39;git config submodule&#39; run concurrently and try to modify a=
 same git config file, hence the race might happen, but it&#39;s hard to be=
 reproduced since &#39;git config submodule&#39; finishes quite quickly.</d=
iv><div><br></div><div>//Ming Liu</div></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"=
mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.o=
rg</a>&gt; =E6=96=BC 2019=E5=B9=B41=E6=9C=8825=E6=97=A5 =E9=80=B1=E4=BA=94 =
=E4=B8=8B=E5=8D=881:24=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Fri, 2019-01-25 at 12:35 +0100, Ming L=
iu wrote:<br>
&gt; Hi, Stefan:<br>
&gt; <br>
&gt; Could you help confirm this? <br>
&gt; <br>
&gt; Hi, Richard:<br>
&gt; <br>
&gt; May I know how has the issue been fixed?<br>
&gt;<br>
&gt; I updated the tip to:<br>
&gt; ```<br>
&gt; commit 8c8ecec2a722bc2885e2648d41ac8df07bdf660d<br>
&gt;=C2=A0 =C2=A0 =C2=A0gitsmy.py: Fix unpack of submodules of submodules<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0If the submodule is in a subdirectory, it needs to =
have that<br>
&gt; structure<br>
&gt;=C2=A0 =C2=A0 =C2=A0preserved.=C2=A0 This means the unpack path needs t=
o be in the<br>
&gt; &#39;dirname&#39; of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0final path -- since the unpack directory name is sp=
ecified in the<br>
&gt; URI.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0Additional specific test cases were added to ensure=
 this is<br>
&gt; working properly<br>
&gt;=C2=A0 =C2=A0 =C2=A0based on two recent error reports.<br>
&gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Mark Hatle &lt;<a href=3D"mailto:mar=
k.hatle@windriver.com" target=3D"_blank">mark.hatle@windriver.com</a>&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Richard Purdie &lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linux=
foundation.org</a><br>
&gt; &gt;<br>
&gt; ```<br>
&gt; on top of that commit, I could see there are &quot;git config submodul=
e&quot;<br>
&gt; being called concurrently in different processes, which does have a<br=
>
&gt; race condition, and will lead to the error observed by Stefan,<br>
&gt; although it&#39;s not easy to be reproduced.<br>
<br>
There are locks at a higher level in the fetchers, in<br>
lib/bb/fetch2/__init__.py the download() method has:<br>
<br>
if ud.lockfile:<br>
=C2=A0 =C2=A0 lf =3D bb.utils.lockfile(ud.lockfile)<br>
<br>
and the unpack() method has similar locks.<br>
<br>
Mark and I believe there were some code paths where the locks were<br>
being bypassed in the gitsm fetcher but Mark reworked the code so that<br>
we were both happy that there should always be a lock held.<br>
<br>
We need to fix any races properly ensuring they&#39;re covered by the main<=
br>
fetcher locks, adding new ones would only fix a symptom of the real<br>
problem.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000053d1e0580488918--
