Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871EBC6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 10:07:06 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.8635.1678961223242444922
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 03:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=eKInCpER;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id j11so1559079lfg.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678961221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P1Fu4CUXInwiIJlWy7LfqPhIdTBVfBJWvRmz6/JBi/Q=;
        b=eKInCpERdaIuVsdW2Qj0I9q5DNY9VvHoAFrvdjm0P5bpIIfAr5lXBFeRbhA8kY6FxG
         l3ISr7DKiaaOjLberW9RN7Qp6Pdh5TlkdIUMFdmMgFPylNjtt70KXj+I+Eq5yraAI9mL
         2ckKhPfOObhXGQnyodfmsGOLVz9x+xg2pjHDpQDSnhyQQRyUF0wcpdguRQQsuJagwdfX
         WAPOFNzsqWwK3m6c1FlK74k6XpgJWyLkMoLMW6b6mQ4UL5dj0S5gY8ehiLHMgJNpnSj0
         MBR5hn0tvYreyS7k7K80tCnq/tIF2tnR/Qi6R9I0wCRyR1FimA/n34NdbrW0y3XXJ2OX
         T95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678961221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1Fu4CUXInwiIJlWy7LfqPhIdTBVfBJWvRmz6/JBi/Q=;
        b=ye+ea8D9qVucSYHgU5auY6qysfLPjd5a13Ndd5ViU2MU7Ok4Rhw2QzoWzvHivQeblo
         de7pJC2taSKvnFyDe4+5sqCofM6cN1E7cdk8zELoVLUDWYWLoaJ0AHJLhB6dk0AcxDMg
         y3sKfyezoitcCNReqJDLKS4DWVL0mNsHRzhcJ7n0cHpMOFfDM04t/pRZsMYOue88quZp
         iTaW3nDS6XNdkSM3W0ZcH43Gysh9LzH3XUnDRrcxGaJ1MVUhROuW0f0dnE4TdQYpj4mo
         yq/qKcfrKsj8AwF27+YJD7oyPsKLtbfYHwZYB0WYsDMf5++d33bSf1zehpcM99z5XEIb
         wRRg==
X-Gm-Message-State: AO0yUKVD5cicK7YGQe53ClRzoT1NsS2hY8prnglEKRXMULDFwgiaR+Cw
	3r9IXyS/aewVKf8rbLsYaS8EyT6cx0BDCzpWWB4=
X-Google-Smtp-Source: AK7set/17zlrJUyqQnXpqJG9ZcLX7MpqcmNDwRAKQSNXx6GzKibcvzHHb4RyFMAnqaIu2Uz8/LZgTQAlhy80242IHwg=
X-Received: by 2002:ac2:5099:0:b0:4e0:979d:56e9 with SMTP id
 f25-20020ac25099000000b004e0979d56e9mr3022340lfm.12.1678961220969; Thu, 16
 Mar 2023 03:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
 <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
 <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
 <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com>
 <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com>
 <CANNYZj9msRQ5MnC9wHtD0w9zscDXeq2+dxt8fwzZzNnAcPquWg@mail.gmail.com>
 <174CACDDD2990A66.7968@lists.openembedded.org> <CA+cAker=UA3mMte8-+ghj2y-r4x46Jre+ODo5m-4jn4bgr-bxg@mail.gmail.com>
 <CANNYZj_2S+=MyyLtJC2Z8vV1TnEgY9gmX_uT_KC0hagpMi48Qg@mail.gmail.com>
In-Reply-To: <CANNYZj_2S+=MyyLtJC2Z8vV1TnEgY9gmX_uT_KC0hagpMi48Qg@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 16 Mar 2023 11:06:49 +0100
Message-ID: <CA+cAkeo99FtejmqyBYShTPRfRuS3nnA=wUWVSHHt+nkx8dzz7w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002ae9d005f7019f0f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 10:07:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14579

--0000000000002ae9d005f7019f0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Mar 2023 at 09:23, Alexander Kanavin <alex.kanavin@gmail.com>
wrote:
>
> On Thu, 16 Mar 2023 at 09:20, Fr=C3=A9d=C3=A9ric Martinsons
> <frederic.martinsons@gmail.com> wrote:
> > I almost finished the patch and I checked in meta-oe for recipes to be
updated,
> > I see two : python3-pyruvate and uutils-coreutils
> >
> > But those recipes don't inherit cargo-update-crates,  python3-pyruvate
inherit
> > python_setuptools3_rust and seems to have been written manually.
> > And uutils-coreutils has been generated by cargo bitbake.
> > Should I modify them to use the update class or should I put the
checksum "by hand"?
>
> You should convert them to use the official class. Maintaining long
> lists of checksums by hand does not scale.
>

I managed easily to update uutils-coreutils
<https://github.com/openembedded/meta-openembedded/tree/master/meta-oe/reci=
pes-core/uutils-coreutils>
(I
removed its README.txt by the way) but
I cannot do it for python3-pyruvate
<https://github.com/openembedded/meta-openembedded/blob/master/meta-python/=
recipes-devtools/python/python3-pyruvate_1.1.2.bb>
because
I cannot find a Cargo.lock file, the git
repository had once though (see the tag under gitlab
<https://gitlab.com/tschorr/pyruvate/-/tree/1.1.2>) so it seems that it is
related
to the fetch by pypi which doesn't embed the Cargo.lock (or a bug in the
packaging
of the project). I don't know what to do with this one.

> > Moreover, since this dev will be cross dependent (impact on meta-oe,
oe-core and bitbake)
> > how do we proceed for the different patches to be merged at the same
time?
>
> You should submit all needed patches at the same time to respective
> mailing lists. Cross-reference them in commit messages (e.g. mention
> where the other patches are), and integrators will be able to minimize
> the window of breakage.
>
> Alex

Understood

--0000000000002ae9d005f7019f0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, 16 Mar 2023 at 09:23, Alexander Kanavin &l=
t;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; =
wrote:<br>&gt;<br>&gt; On Thu, 16 Mar 2023 at 09:20, Fr=C3=A9d=C3=A9ric Mar=
tinsons<br>&gt; &lt;<a href=3D"mailto:frederic.martinsons@gmail.com">freder=
ic.martinsons@gmail.com</a>&gt; wrote:<br>&gt; &gt; I almost finished the p=
atch and I checked in meta-oe for recipes to be updated,<br>&gt; &gt; I see=
 two : python3-pyruvate and uutils-coreutils<br>&gt; &gt;<br>&gt; &gt; But =
those recipes don&#39;t inherit cargo-update-crates, =C2=A0python3-pyruvate=
 inherit<br>&gt; &gt; python_setuptools3_rust and seems to have been writte=
n manually.<br>&gt; &gt; And uutils-coreutils has been generated by cargo b=
itbake.<br>&gt; &gt; Should I modify them to use the update class or should=
 I put the checksum &quot;by hand&quot;?<br>&gt;<br>&gt; You should convert=
 them to use the official class. Maintaining long<br>&gt; lists of checksum=
s by hand does not scale.<br>&gt;<div><br></div><div>I managed easily to up=
date=C2=A0<a href=3D"https://github.com/openembedded/meta-openembedded/tree=
/master/meta-oe/recipes-core/uutils-coreutils">uutils-coreutils</a>=C2=A0(I=
 removed its=C2=A0README.txt by the way) but</div><div>I cannot do it for=
=C2=A0<a href=3D"https://github.com/openembedded/meta-openembedded/blob/mas=
ter/meta-python/recipes-devtools/python/python3-pyruvate_1.1.2.bb">python3-=
pyruvate</a>=C2=A0because I cannot find a Cargo.lock file, the git</div><di=
v>repository had once though (see=C2=A0<a href=3D"https://gitlab.com/tschor=
r/pyruvate/-/tree/1.1.2">the tag under gitlab</a>) so it seems that it is r=
elated</div><div>to the fetch by pypi which doesn&#39;t embed the Cargo.loc=
k (or a bug in the packaging</div><div>of the project). I don&#39;t know wh=
at to do with this one.</div><div><br>&gt; &gt; Moreover, since this dev wi=
ll be cross dependent (impact on meta-oe, oe-core and bitbake)<br>&gt; &gt;=
 how do we proceed for the different patches to be merged at the same time?=
<br>&gt;<br>&gt; You should submit all needed patches at the same time to r=
espective<br>&gt; mailing lists. Cross-reference them in commit messages (e=
.g. mention<br>&gt; where the other patches are), and integrators will be a=
ble to minimize<br>&gt; the window of breakage.<br>&gt;<br>&gt; Alex</div><=
div><br></div><div>Understood</div></div>

--0000000000002ae9d005f7019f0f--

