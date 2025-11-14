Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05CCCE7AF7
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:50:39 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16235.1763121036984107284
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GyBHO0xt;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-880503ab181so17123076d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 03:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763121036; x=1763725836; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6rRwLoItVvoZwKDCKiehA8CJBKVPTBkFnLMXsgeMcYc=;
        b=GyBHO0xtfdWcECi9BjiDNWSQuz0ztxdY0y2Q4JLRRHcEX7FKnoF4UzFUF/2+np+DdV
         mxS44wVflzfV+xJIucQyjtwlntCWkuWVWbyotC8JZTHczIMiUmaT8cI6whEFo3ycNql0
         EXBGx7xiOc0MvQETDvziIAHiMhT8YeCkWAhsf7u2+Yrl6T7CmyihT8Um+TL6kGR2Utm0
         v+bkO3YTQpk5Q0jrOPyiQFxSLprc2Fq7bu+omZTl8JexMmMlDFKZxMh7gFWgm+Yr0OFr
         TfDVF76c14MBtcTT/EtR8Dhq/oSGDjxBJDJFOq04JHHWTOtLSftTFoIz5QuEUViGfA0p
         JeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763121036; x=1763725836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rRwLoItVvoZwKDCKiehA8CJBKVPTBkFnLMXsgeMcYc=;
        b=RH4uKP0Ft6zv5gF5hbPlPdn3tOXAAwmfJIcswS3nlSDrHuhdyAcwK7mELaxyWKBVVS
         1iw27HHBXv/2leRGa9aaKlcf8lopaBio9TsTzhiE9EKLUj4kSbt2Ov+Mjn76srK/lEtv
         /VOG0NuzmK/pajtgxR1Xx6q8jFprf/kKBbT5dyGcsavHa9C+c/LSwBVuZ5tQe41XebwW
         82M4PIn1cLZkZsfXxzXGoVSz7odz2fCZQ0sTNY06Q1VCAPnAvDe/EhG8Cz0b32kI5FZD
         FMKaxKSV3Yysz9Az22vboCZ0Jns5f4Zvm4fGfoUiw3cmccsAFyAWuRwS1d/Q9Q6B+OJf
         wnjw==
X-Gm-Message-State: AOJu0YzZDwBRsG55N6EaKVIuPJOduJFBMxT9Lho4z+J/DNQbfUwAInxD
	2WzSywvucW/dJSAe8zMdaF16KauVx/i5rGhyK8YfzVCqEO9dtz0H23NMn/yZJgtE26jre97JdE7
	OlNXt9phfIvAir4Wk9dgB3FYq4mKa/24=
X-Gm-Gg: ASbGncvJGCyX1JZZvbBupuC2RS74nzwnD4JDdyh1M2JaOpl2vHvEXeiVvgoo3HiEfUd
	x8uqnnK49x5oOdinfAPzvgK2LGQs1OAxvjCLmOim0IS55qvNm0eBZlWBoBADzYfpjZyXzkkcV1z
	NTdziWVVPI9YESn9jH4Ws81PtqXJyle5XIjtvix3i5tx7htp1HodjqVWGuTY1h+V7LQiVY401hx
	a3ujdXnLQiaPXeYcKahk6qXP/9+HIX7CKd+Ru5pQS7/kiavl34x2Dr+u1e1xICSxJhni49L38kD
	6C1QEdqDxz13XQMS4Hz0jgX6eLE9F6dQc1ir
X-Google-Smtp-Source: AGHT+IHwGbmaGDoEeu2EM57KfttXUgvDwUfmSgau3jHmkD8bE6xWBdsd1BL863nlX5dBg0tJOhdG8jNw7wim4CHD8E4=
X-Received: by 2002:ad4:5ba8:0:b0:880:5cc1:6923 with SMTP id
 6a1803df08f44-8829269e378mr42859686d6.36.1763121035884; Fri, 14 Nov 2025
 03:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
 <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com> <CANNYZj8tDk8izGO2f_8ADHsaN9VudG_hsQrcw2N2O8NnXtdCCQ@mail.gmail.com>
 <5fffd119-5b6c-462d-9f1e-5b2b30f81715@windriver.com> <CANNYZj8eqw8QF8eWCoLki7XXWZ197pVZHckLtQ5aQx29aU+o4A@mail.gmail.com>
 <451e3958-7661-4070-bff9-b3bce661c21d@windriver.com> <afddd5c5-ab6b-4e9a-a667-93408a2d070c@windriver.com>
In-Reply-To: <afddd5c5-ab6b-4e9a-a667-93408a2d070c@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 12:50:25 +0100
X-Gm-Features: AWmQ_bmZ-XytNpPSeYYq3hjscEgmP06FKu0b-bM81BcN97hnglw-GTEIeMO9Dy4
Message-ID: <CANNYZj_efuiNV2LMfkQbXBD5QzV4NyHLcGM5JicetcyVZquwXA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: ChenQi <Qi.Chen@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="0000000000000a3d9e06438c9b4e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:50:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18397

--0000000000000a3d9e06438c9b4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Chen. I=E2=80=99m only reading emails this week, but I=E2=80=99ll tr=
y to look into
it and come up with ideas on Monday.

Alex

On Fri 14. Nov 2025 at 8.17, ChenQi <Qi.Chen@windriver.com> wrote:

> On 11/14/25 15:12, Chen Qi via lists.openembedded.org wrote:
> > On 11/14/25 14:49, Alexander Kanavin wrote:
> >> On Fri, 14 Nov 2025 at 07:37, ChenQi <Qi.Chen@windriver.com> wrote:
> >>> When machine/qemux86-64 fragment is enabled and users use 'MACHINE=3D=
xxx
> >>> bitbake <pkg>', the expected behavior is to error out and recommend
> >>> user
> >>> to use 'bitbake-config-build disable-fragment'.
> >>>
> >>> Here comes the problem. bitbake-config-build makes use of tinfoil and
> >>> when setting up tinfoil, the above error will appear again. We can't
> >>> recommend users to use 'bitbake-config-build disable-fragment' while
> >>> the
> >>> recommended method still errors out. This is the reason for the speci=
al
> >>> exception.
> >> But why would users be running 'MACHINE=3Dxxx bitbake-config-build
> >> disable-fragment ...' ? That prefix is intended only for bitbake
> >> invocations.
> >>
> >> Alex
> >
> Hi Alex,
>
> Ignore the reply below. Sorry, I just realized what's going on here.
>
> I was using 'MACHINE =3D"qemuarm64"' in local.conf to test things.
>
> So the error will appear again and again even with a simple
> 'bitbake-config-build --help' if there's no such special exception.
>
> Regards,
> Qi
>
> > I mean that users run something like 'MACHINE=3Dqemuarm64 bitbake
> > base-files', and they get error like below:
> >
> > ERROR: A builtin fragment 'machine/qemux86-64' is used while MACHINE
> > has already got an assignment.
> > Please either disable the fragment or remove the value assignment.
> > To disable the fragment, use 'bitbake-config-build disable-fragment
> > machine/qemux86-64'.
> >
> > Now they run 'bitbake-config-build disable-fragment
> > machine/qemux86-64' as recommended. If there's no such special
> > exception, they will get the same error again. Even if they run a
> > simple 'bitbake-config-build --help', they'll get the same error again.
> >
> > That's the reason for this special exception.
> >
> > Regards,
> > Qi
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#18387):
> https://lists.openembedded.org/g/bitbake-devel/message/18387
> > Mute This Topic: https://lists.openembedded.org/mt/116288219/7304865
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Qi.Chen@eng.windriver.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>
>

--0000000000000a3d9e06438c9b4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Chen. I=E2=80=99m only reading emails this week, b=
ut I=E2=80=99ll try to look into it and come up with ideas on Monday.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri 14. Nov 2025 at 8.17, ChenQi &lt;<a href=3D"mailto:Qi.Chen@windriv=
er.com">Qi.Chen@windriver.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">On 1=
1/14/25 15:12, Chen Qi via <a href=3D"http://lists.openembedded.org" rel=3D=
"noreferrer" target=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; On 11/14/25 14:49, Alexander Kanavin wrote:<br>
&gt;&gt; On Fri, 14 Nov 2025 at 07:37, ChenQi &lt;<a href=3D"mailto:Qi.Chen=
@windriver.com" target=3D"_blank">Qi.Chen@windriver.com</a>&gt; wrote:<br>
&gt;&gt;&gt; When machine/qemux86-64 fragment is enabled and users use &#39=
;MACHINE=3Dxxx<br>
&gt;&gt;&gt; bitbake &lt;pkg&gt;&#39;, the expected behavior is to error ou=
t and recommend <br>
&gt;&gt;&gt; user<br>
&gt;&gt;&gt; to use &#39;bitbake-config-build disable-fragment&#39;.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Here comes the problem. bitbake-config-build makes use of tinf=
oil and<br>
&gt;&gt;&gt; when setting up tinfoil, the above error will appear again. We=
 can&#39;t<br>
&gt;&gt;&gt; recommend users to use &#39;bitbake-config-build disable-fragm=
ent&#39; while <br>
&gt;&gt;&gt; the<br>
&gt;&gt;&gt; recommended method still errors out. This is the reason for th=
e special<br>
&gt;&gt;&gt; exception.<br>
&gt;&gt; But why would users be running &#39;MACHINE=3Dxxx bitbake-config-b=
uild<br>
&gt;&gt; disable-fragment ...&#39; ? That prefix is intended only for bitba=
ke<br>
&gt;&gt; invocations.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;<br>
Hi Alex,<br>
<br>
Ignore the reply below. Sorry, I just realized what&#39;s going on here.<br=
>
<br>
I was using &#39;MACHINE =3D&quot;qemuarm64&quot;&#39; in local.conf to tes=
t things.<br>
<br>
So the error will appear again and again even with a simple <br>
&#39;bitbake-config-build --help&#39; if there&#39;s no such special except=
ion.<br>
<br>
Regards,<br>
Qi<br>
<br>
&gt; I mean that users run something like &#39;MACHINE=3Dqemuarm64 bitbake =
<br>
&gt; base-files&#39;, and they get error like below:<br>
&gt;<br>
&gt; ERROR: A builtin fragment &#39;machine/qemux86-64&#39; is used while M=
ACHINE <br>
&gt; has already got an assignment.<br>
&gt; Please either disable the fragment or remove the value assignment.<br>
&gt; To disable the fragment, use &#39;bitbake-config-build disable-fragmen=
t <br>
&gt; machine/qemux86-64&#39;.<br>
&gt;<br>
&gt; Now they run &#39;bitbake-config-build disable-fragment <br>
&gt; machine/qemux86-64&#39; as recommended. If there&#39;s no such special=
 <br>
&gt; exception, they will get the same error again. Even if they run a <br>
&gt; simple &#39;bitbake-config-build --help&#39;, they&#39;ll get the same=
 error again.<br>
&gt;<br>
&gt; That&#39;s the reason for this special exception.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Qi<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#18387): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/18387" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/18387</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/11628821=
9/7304865" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.=
org/mt/116288219/7304865</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:Qi.Chen@eng.windriver.com" ta=
rget=3D"_blank">Qi.Chen@eng.windriver.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
<br>
</blockquote></div></div>

--0000000000000a3d9e06438c9b4e--

