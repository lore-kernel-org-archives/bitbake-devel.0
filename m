Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D45CAC5B0
	for <webhook@archiver.kernel.org>; Sat,  4 Oct 2025 15:58:57 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.11965.1759593535409133974
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Oct 2025 08:58:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DzBjDskg;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2097480f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 04 Oct 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759593534; x=1760198334; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rhZ3dvnTbeESdI+IvxmNGJJl6twh5019BVxJSkomPVo=;
        b=DzBjDskgHrUImfjXKu3PR89AzM0rwRhp06UhtRzp6Scj55ht/jcS9ZEYWzBVSf2+Iy
         LpuPzQnwpEiEQSBqIzBkWuFhQmrqPm/RhUyxbATd17Vu+V9WDVg4oRJXY8yy7phg9kzC
         Qv1PUp5X6yJyVg5Ar02RrQ3NfCRb26fd2bN1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759593534; x=1760198334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhZ3dvnTbeESdI+IvxmNGJJl6twh5019BVxJSkomPVo=;
        b=ejYsGVkFe+Vzo8JarqUOIs9j3zwDxMtwqKGgJWv3X+5/QPWu1S2H/PUb2ZzkGPhh0v
         8YAqDnAEeiowDBpVD6G0KzW0tpU/mHt42/e/ZX77syOXrY2wEaY/wY9g1zJ3etjaCoa/
         Ubwt/FCjOgdfVL8vv1tEXGgxiQZKYbem776iTaa2XVdI71AVGMfiw8lM0nZNbUnkWJYX
         kURmCvabJIgkErOLvImG3qOwnHqcP+sLoFqMX9oVxXmBqAaA6g+Qvd22i9unku38nm1P
         Sg3dZ5nOQjQwZW3BtBGcXfHFsV98LMIRBD99fzK0QZysw/3Xl5ziLbB5qcE9zBjreXpL
         abFA==
X-Forwarded-Encrypted: i=1; AJvYcCX2o3aVZgl+pGmsxMwIypdWumyLyZeVjTLNoTg7ksBLOwS8jBEr75cRpLXCSwOQ7E7cjjQBcVGYIl7cg+Nq@lists.openembedded.org
X-Gm-Message-State: AOJu0YwNGUGIlQlNPXofDxMbYE8Dz1rEVxA74cL0gmtGaGOg6tQbtVpT
	qVkFexpBwZ51JhpMi3stxXHkZT4FYXRikRIBIqmn5bvDVZtl1USt30a14bajfGCwBbEfgI0eMwj
	PufZjHi4Xr/tNeRFFM/AgwN2WkhNT84fV5t41byB7uw==
X-Gm-Gg: ASbGncs3NhT6GAYGQ3yWeGiHxpkHWEfpHbg28EB15rvP0XepNC8QDqUAglRgardyUWJ
	ViB/+NLkC31cRxl57706RNy1mRCf8V5wESMYN3XtYrmEWspZ08RYck6hWH2gKNzcvCowYFLJUb9
	n+Ns8vOB3XHi/gUe+WdPtFwboUoxviUa2FkSGz9gsNUR15EGqdIw1dWTRGRV6ArPbksUm9MjYhy
	euQCKkLU1y6hwbB/kxJuPRGN0apxcwKf+vajf4Hy6+SLBH9yGRILu6XQqoR1+QF/ZHcV8v3PqIn
X-Google-Smtp-Source: AGHT+IG419OLAieA19m2qOLo+xNuZp5aY/sN3vLpPaFCGHqab37MTY4IaqcVxklOYMaGczC4lJhXOJ64/KI4hVxSP7M=
X-Received: by 2002:a05:6000:240d:b0:3e8:ee5d:f31e with SMTP id
 ffacd0b85a97d-4256716ddcdmr4613044f8f.25.1759593533605; Sat, 04 Oct 2025
 08:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251002155210.782342-1-yoann.congal@smile.fr>
 <8bf3234625affeee077859ea356928d64b7116b0.camel@linuxfoundation.org> <CAJdd5GYroEC5B599SVMpeJH8uvh12jafcR0WE3Cjdz-5NTNbew@mail.gmail.com>
In-Reply-To: <CAJdd5GYroEC5B599SVMpeJH8uvh12jafcR0WE3Cjdz-5NTNbew@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Sat, 4 Oct 2025 17:58:27 +0200
X-Gm-Features: AS18NWA8utHviHVCJULyY_4Fyx9DFH844voPGTKqTqvbriS-K-rEcRsKnRakrgg
Message-ID: <CAMSfU+6ox4rHFhAPyFNZ6G0frwtD16i5go9OYxBP20a936O+=A@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: optionally support
 JSON5 (e.g. comments) format
To: Joshua Watt <jpewhacker@gmail.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000008520620640574b01"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 04 Oct 2025 15:58:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18135

--0000000000008520620640574b01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 3 oct. 2025 =C3=A0 16:59, Joshua Watt <jpewhacker@gmail.com> a =C3=
=A9crit :

> On Fri, Oct 3, 2025 at 3:35=E2=80=AFAM Richard Purdie via
> lists.openembedded.org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> >
> > On Thu, 2025-10-02 at 17:52 +0200, Yoann Congal via
> lists.openembedded.org wrote:
> > > From: Yoann Congal <yoann.congal@smile.fr>
> > >
> > > One major limitation of JSON files is that comments are not
> > > supported.
> > > JSON5 (https://json5.org/) is an extension of the current JSON file
> > > format that support comments (among other evolutions).
> > >
> > > This patch adds the support of the JSON5 file format when reading
> > > configuration files.
> > >
> > > Sadly, no JSON5 support exists in Python stdlib, so we have to
> > > install a
> > > module. I chose https://pypi.org/project/json5/ (but
> > > https://pypi.org/project/pyjson5/ may be an alternative).
> > >
> > > I took care of only patching reading of the config file, the internal
> > > JSON files of bitbake-setup are still in classic JSON, which mean
> > > that
> > > operations that don't need to read the original configuration still
> > > work
> > > without a json5 module.
> > >
> > > I put an example of a JSON5 config in
> > > default-registry/configurations/poky-master_json5.conf.json
> > > This is poky-master.conf.json translated to JSON5 plus some comments.
> > >
> > > To try this:
> > >   python3 -m venv .venv; . .venv/bin/activate # if needed
> > >   pip install json5
> > >   ./bin/bitbake-setup init default-registry/configurations/poky-
> > > master_json5.conf.json poky_json5
> >
> > We could do something horrible like preprocess the json file and remove
> > any lines starting with "//". That works for reading but not for
> > writing.
>

Hello,

Just to see what that looks like, I've sent that here:
https://lists.openembedded.org/g/bitbake-devel/topic/rfc_patch_bitbake_setu=
p/115588267
(I'm not totally sure it won't blow up on some weird strings...)


Maybe just a "comment" property that gets ignored then? That's what
> JSONschema uses (although it does "@comment"), and then it doesn't
> violate any parsing? e.g.
>
> {
>   "comment": "This is a comment",
>   ...
> }
>

Yes, this is a possibility.
I don't love it since it mixes data and comments.
But, this is indeed pure JSON and the most low-hanging fruit to get
comments (no external deps, little to no extra code)

> I'm keen to try and keep the external dependencies that bitbake has to
> > a minimum. Why? People don't realise the issues they create for
> > documentation, container environments, things like build-appliance and
> > general ease of use. Yes, you can usually pip install things but it is
> > an extra hurdle for users. The websockets requirement for remote
> > hashequiv is an example of how an obvious/"trivial" dependency can work
> > out to be a pain and a usability issue.
> >
> > Given that, I'd really prefer to stick to what the python standard
> > library supports, which effectively means json at this point.
> >
> > FWIW I personally really dislike yaml files too, for no particularly
> > good reason, I just don't get on with the format.
> >
> > Cheers,
> >
> > Richard
> >
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#18128):
> https://lists.openembedded.org/g/bitbake-devel/message/18128
> > Mute This Topic: https://lists.openembedded.org/mt/115555001/3616693
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> JPEWhacker@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>


--=20
Yoann Congal
Smile ECS

--0000000000008520620640574b01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0ven. 3 =
oct. 2025 =C3=A0=C2=A016:59, Joshua Watt &lt;<a href=3D"mailto:jpewhacker@g=
mail.com">jpewhacker@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Fri, Oct 3, 2025 at 3:35=E2=
=80=AFAM Richard Purdie via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a><br>
&lt;richard.purdie=3D<a href=3D"mailto:linuxfoundation.org@lists.openembedd=
ed.org" target=3D"_blank">linuxfoundation.org@lists.openembedded.org</a>&gt=
; wrote:<br>
&gt;<br>
&gt; On Thu, 2025-10-02 at 17:52 +0200, Yoann Congal via <a href=3D"http://=
lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembe=
dded.org</a> wrote:<br>
&gt; &gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" t=
arget=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; One major limitation of JSON files is that comments are not<br>
&gt; &gt; supported.<br>
&gt; &gt; JSON5 (<a href=3D"https://json5.org/" rel=3D"noreferrer" target=
=3D"_blank">https://json5.org/</a>) is an extension of the current JSON fil=
e<br>
&gt; &gt; format that support comments (among other evolutions).<br>
&gt; &gt;<br>
&gt; &gt; This patch adds the support of the JSON5 file format when reading=
<br>
&gt; &gt; configuration files.<br>
&gt; &gt;<br>
&gt; &gt; Sadly, no JSON5 support exists in Python stdlib, so we have to<br=
>
&gt; &gt; install a<br>
&gt; &gt; module. I chose <a href=3D"https://pypi.org/project/json5/" rel=
=3D"noreferrer" target=3D"_blank">https://pypi.org/project/json5/</a> (but<=
br>
&gt; &gt; <a href=3D"https://pypi.org/project/pyjson5/" rel=3D"noreferrer" =
target=3D"_blank">https://pypi.org/project/pyjson5/</a> may be an alternati=
ve).<br>
&gt; &gt;<br>
&gt; &gt; I took care of only patching reading of the config file, the inte=
rnal<br>
&gt; &gt; JSON files of bitbake-setup are still in classic JSON, which mean=
<br>
&gt; &gt; that<br>
&gt; &gt; operations that don&#39;t need to read the original configuration=
 still<br>
&gt; &gt; work<br>
&gt; &gt; without a json5 module.<br>
&gt; &gt;<br>
&gt; &gt; I put an example of a JSON5 config in<br>
&gt; &gt; default-registry/configurations/poky-master_json5.conf.json<br>
&gt; &gt; This is poky-master.conf.json translated to JSON5 plus some comme=
nts.<br>
&gt; &gt;<br>
&gt; &gt; To try this:<br>
&gt; &gt;=C2=A0 =C2=A0python3 -m venv .venv; . .venv/bin/activate # if need=
ed<br>
&gt; &gt;=C2=A0 =C2=A0pip install json5<br>
&gt; &gt;=C2=A0 =C2=A0./bin/bitbake-setup init default-registry/configurati=
ons/poky-<br>
&gt; &gt; master_json5.conf.json poky_json5<br>
&gt;<br>
&gt; We could do something horrible like preprocess the json file and remov=
e<br>
&gt; any lines starting with &quot;//&quot;. That works for reading but not=
 for<br>
&gt; writing.<br></blockquote><div><br></div><div>Hello,</div><div><br></di=
v><div>Just to see what that looks like, I&#39;ve sent that here:</div><div=
><a href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/rfc_patch_=
bitbake_setup/115588267">https://lists.openembedded.org/g/bitbake-devel/top=
ic/rfc_patch_bitbake_setup/115588267</a></div><div>(I&#39;m not totally sur=
e it won&#39;t blow up on some weird strings...)=C2=A0</div><div><br></div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">

Maybe just a &quot;comment&quot; property that gets ignored then? That&#39;=
s what<br>
JSONschema uses (although it does &quot;@comment&quot;), and then it doesn&=
#39;t<br>
violate any parsing? e.g.<br>
<br>
{<br>
=C2=A0 &quot;comment&quot;: &quot;This is a comment&quot;,<br>
=C2=A0 ...<br>
}<br></blockquote><div><br></div><div>Yes, this is a possibility.</div><div=
>I don&#39;t love it since it mixes data and comments.</div><div>But, this =
is indeed pure JSON and the most low-hanging fruit to get comments (no exte=
rnal deps, little to no extra code)</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; I&#39;m keen to try and keep the external dependencies that bitbake ha=
s to<br>
&gt; a minimum. Why? People don&#39;t realise the issues they create for<br=
>
&gt; documentation, container environments, things like build-appliance and=
<br>
&gt; general ease of use. Yes, you can usually pip install things but it is=
<br>
&gt; an extra hurdle for users. The websockets requirement for remote<br>
&gt; hashequiv is an example of how an obvious/&quot;trivial&quot; dependen=
cy can work<br>
&gt; out to be a pain and a usability issue.<br>
&gt;<br>
&gt; Given that, I&#39;d really prefer to stick to what the python standard=
<br>
&gt; library supports, which effectively means json at this point.<br>
&gt;<br>
&gt; FWIW I personally really dislike yaml files too, for no particularly<b=
r>
&gt; good reason, I just don&#39;t get on with the format.<br>
&gt;<br>
&gt; Cheers,<br>
&gt;<br>
&gt; Richard<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#18128): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/18128" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/18128</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/11555500=
1/3616693" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.=
org/mt/115555001/3616693</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:JPEWhacker@gmail.com" target=
=3D"_blank">JPEWhacker@gmail.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000008520620640574b01--

