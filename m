Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47776E7E363
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 10:05:08 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8512.1775210690203978653
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2026 03:04:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=P97qSV45;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899a9f445cbso21920906d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 03:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775210689; cv=none;
        d=google.com; s=arc-20240605;
        b=ek8oaddVzOFUrQO2l9x14p+H7EQ9tIi2DanL2T92lu0MieaMLg7SmMM5OrbrfNAdaj
         7Ry9T6c4hh8MVZkysB8WJjIEKOSBNTm3+JhlUuKM5sT9ZZwkFWYCxkf22RePtj0fw4Nb
         ZI+TvTDxfqJPTm9PFjwT9lHyOBhacLHpuJTPy7MW6qfi5s1mSK83ONEaflJiHc2VqJoI
         fdMwiCZ1UXTnx34KvAa8EZVkEpkCOWUEXfXCfx+OulZhyiPhHFjPMERUD14mWNBAQaXc
         A9J5R1QRNgLB6w96Wi8gWpENyFQzAVBMdrpEOUJhERdGzkM1xNlj1ARutjRo35RPbJoV
         D6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tDJEJ5Yh0YDgVRlqwy52BdYkAYZGXn6uxvUSshJz+Tc=;
        fh=jMg1xH3YF7jCP5HFyVaVjleQIn+tat1Z+NuH7GVL3Hg=;
        b=TVAU1swXc5WGjjPfQ/fmFxVRnn12TKzuT+74S9dYw63mFiN9jpYRb8TzJ68rRUEi15
         9Tmz2JW8NBkm7vdEiL58q97ls0kmmxOQNSHH0xINeZmX8dnSExMqJeIxdzjY3W+JPbLZ
         MlLVPuwgsJPMI06QL8+07jgju0fjKQ8QF7Ulb2aBBhltSAbD8ZXCGXmWpPJxzd4rD7f2
         v5aY0O0tn59RLSkGK7hTxV8+4zudVkZH4zqs/EeHfvp/P4ySgjefq5swKj+nIg79JVGM
         YbA8/+p8bIOwYPAYJhcDeXTQxOxMGSD+QH1TEJvAVyRvJMjLNL4snTjFDesCM5JpGd4R
         hq2g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775210689; x=1775815489; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDJEJ5Yh0YDgVRlqwy52BdYkAYZGXn6uxvUSshJz+Tc=;
        b=P97qSV45BH3rJ2Qhzdt2wXdEZZ9GcKHQ3FukPEjKMtX1qNIhoW0ffp70VYM+HJQ9zO
         KjhklAV5yCc19bhfq45gho2UEV58boFwYaVILG1Y49kxsRpAWKkBh3prREth/48pAinz
         cYpDdzzBk8b7RQlDW7YowaBl/GxchPnV1hEK4AKAahEISwQKl5487ofquxdrXYuV2p1w
         HOO8lm4D4Rl5dh0lyfa9xp2NrZJER4h/v5Jo+nba+q6AA4BqRJn0czCuDDI9DPMyPdwE
         bTGDDN8QIZHSs1/dIRKV8mNJaQNVXvwyrpalc9G2nF+vVA2zokaGrUcra3N7J7AuUD0n
         9HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210689; x=1775815489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDJEJ5Yh0YDgVRlqwy52BdYkAYZGXn6uxvUSshJz+Tc=;
        b=YCnKoTIGeYiHViVqP/lxgymyMl5HvIAkuq5Dx1lSLdRHNv3KkgFU2sag+3CLL+y3Td
         4WQdq5GvC7I6gNX+dTHuqUPMtEGZhrNA6/ei+9BWRzP2k4st+UYLCC4linTfNPxahcQ1
         nvUuRO28UteefgDSY1SGZqG58d68OS3Mcqd8rm/jEp4K3BFnU7sBjXW6FDS9txRGEtqc
         bTy/cilve/JPwnvVz+VeUtXw91rlZR8rl/TfaCysydhTO08IOvTXCxu3glgymtd6h1wT
         S8YeG4d8tLB2UgjprnJrViBHImmosvZM6py35YU5Ijo0RKR3twfYp7Oqc3SPj0n6lgJU
         fmdA==
X-Forwarded-Encrypted: i=1; AJvYcCVk9lVylAJUmeKI8JKyzQZXWESVnXQ2AcmGhEMbTVCbrQCgXpRqMWd8VM1U3CJcpfdYHNuDHYdDhhb3CYQw@lists.openembedded.org
X-Gm-Message-State: AOJu0Yzu2HND5azv2E8WgePfIBP1mmmaJ5SKOdO7jh7zmxO/h6/QDvtc
	jD7QMbJmTkqp4vTPXkhLOYZ9XTPWNC87Ml/WRoyvFTkRhOv5mGVupkvPEMjGOWpkMrTlZwFZV66
	emmF4GBmbhZdT7lY/lZTG/pVaobM5ONI=
X-Gm-Gg: AeBDies31H21UVqeUrsnE2mmfbmjuorelc6mzAgrs+mcrTMzIySgNN3kMIrhANjP/o1
	NxZHRWn4Ukp8jAhzoYv+izk485Rnb9AdNYttYlS/BDOEmQb26BG+G46/URFXO/U72INOvSZH47O
	P5S9FpC6/jRDDMeJqlMlPTZ1tU+UtINv/DuN9FG51ewthO4AzUWyDEJgApSzYHsT1YwjvA8g5HE
	spepGi3oOzjxYvioyTVbxOhe6M8SJsbeVlFJUSx6C5hnpk3t0ZvzVTOJmB4gYmhQRaJwMzu4aE9
	v/sKTyM3rOgxCA06UiALfiU9lmAh81XQZ0Da7L4X
X-Received: by 2002:a05:6214:601b:b0:89e:df5c:19f6 with SMTP id
 6a1803df08f44-8a704caf6eamr34016616d6.42.1775210689065; Fri, 03 Apr 2026
 03:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
 <20260331-docs-fixes-v1-1-45ee34341e72@bootlin.com> <6f743774-fe4b-4e9e-ba99-6ffe1d76a51b@cherry.de>
 <57bb4e5300a4be34f4cfddcf41d9a21b5b7bc579.camel@linuxfoundation.org>
 <CANNYZj9U3BYUv-cvQvmu7d=8O82Gdg-2GSon6vNJ71BMi6bKsg@mail.gmail.com> <DHJD5ZA0XGWN.3LDDWNE9PDM1X@bootlin.com>
In-Reply-To: <DHJD5ZA0XGWN.3LDDWNE9PDM1X@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 3 Apr 2026 12:04:37 +0200
X-Gm-Features: AQROBzAg8EeBswbwQpI0NwDMZR35zhynx3vQ9-DmD9ePhBv67mlOJgbp_cPfvlI
Message-ID: <CANNYZj8=z7U5jpCN+NaAmTspYduH=pcMohMcbnqGp8mQvmHoiA@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] bitbake-setup: rename "abort"
 rebase conflict stragegy to "halt"
To: antonin.godard@bootlin.com
Cc: richard.purdie@linuxfoundation.org, quentin.schulz@cherry.de, 
	bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000085f5d1064e8b72fa"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 10:05:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19318

--00000000000085f5d1064e8b72fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The trouble with =E2=80=98reset=E2=80=99 is that it means resetting the who=
le system to its
initial state. =E2=80=98Abort=E2=80=99 is about a stopping a particular ope=
ration such that
the system is returned to the state before the operation started.

I have no idea how INI has utterly failed to catch these nuances in its
rationale you linked, and is even accusing the term of =E2=80=98lacking tec=
hnical
clarity=E2=80=99, but it certainly doesn=E2=80=99t help the cause.

Alex


On Fri 3. Apr 2026 at 10.07, Antonin Godard via lists.yoctoproject.org
<antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:

> On Tue Mar 31, 2026 at 1:36 PM CEST, Alexander Kanavin wrote:
> > There=E2=80=99s a simpler rationale too: this follows =E2=80=98git reba=
se =E2=80=94abort=E2=80=99. If git
> > upstream finds a better word, we will follow. And I agree that all of t=
he
> > proposed alternatives are less accurate.
>
> This goes against previous efforts to convert the documentation and other
> components to not use these words :/
>
> https://lists.openembedded.org/g/openembedded-architecture/topic/inclusiv=
e_language_summary/75821819
>
> [...]
> >> > This is not what halt means. Maybe 'reset' would be a better choice?
> Or
> >> > if you really want to follow the recommendations from that website, =
I
> >> > guess "cancel"?
> >>
> >> The trouble is none of these alternatives really match what abort
> >> means, reset and cancel do mean something different. "abandon" might b=
e
> >> closer but still isn't right. "attempt" maybe? If we get too creative
> >> with this, users just won't understand what it means :(
>
> I had the impression, from the documentation, that bitbake-setup would
> leave the
> repository in the middle of a rebase, to let you deal with conflict, and
> then
> continue on the next bitbake-setup update call.
>
> It appears to use --abort instead, so a misunderstanding from my part.
>
> Out of these options, I think "reset" might be the best one, I agree with
> Quentin. But I'm not a native speaker, so I might not have an
> understanding as
> subtle as others.
>
> I'll let Richard decide on what to do here.
>
> Antonin
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#9173):
> https://lists.yoctoproject.org/g/docs/message/9173
> Mute This Topic: https://lists.yoctoproject.org/mt/118594590/1686489
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/docs/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000085f5d1064e8b72fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">The trouble with =E2=80=98reset=E2=80=99 is that it =
means resetting the whole system to its initial state. =E2=80=98Abort=E2=80=
=99 is about a stopping a particular operation such that the system is retu=
rned to the state before the operation started.</div></div><div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I have no idea how INI has utterly faile=
d to catch these nuances in its rationale you linked, and is even accusing =
the term of =E2=80=98lacking technical clarity=E2=80=99, but it certainly d=
oesn=E2=80=99t help the cause.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Alex</div><div dir=3D"auto"><br></div><div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri 3. Apr 2026 at 10.07, An=
tonin Godard via <a href=3D"http://lists.yoctoproject.org" target=3D"_blank=
">lists.yoctoproject.org</a> &lt;antonin.godard=3D<a href=3D"mailto:bootlin=
.com@lists.yoctoproject.org" target=3D"_blank">bootlin.com@lists.yoctoproje=
ct.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;paddi=
ng-left:1ex;border-left-color:rgb(204,204,204)">On Tue Mar 31, 2026 at 1:36=
 PM CEST, Alexander Kanavin wrote:<br>
&gt; There=E2=80=99s a simpler rationale too: this follows =E2=80=98git reb=
ase =E2=80=94abort=E2=80=99. If git<br>
&gt; upstream finds a better word, we will follow. And I agree that all of =
the<br>
&gt; proposed alternatives are less accurate.<br>
<br>
This goes against previous efforts to convert the documentation and other<b=
r>
components to not use these words :/<br>
<a href=3D"https://lists.openembedded.org/g/openembedded-architecture/topic=
/inclusive_language_summary/75821819" rel=3D"noreferrer" target=3D"_blank">=
https://lists.openembedded.org/g/openembedded-architecture/topic/inclusive_=
language_summary/75821819</a><br>
<br>
[...]<br>
&gt;&gt; &gt; This is not what halt means. Maybe &#39;reset&#39; would be a=
 better choice? Or<br>
&gt;&gt; &gt; if you really want to follow the recommendations from that we=
bsite, I<br>
&gt;&gt; &gt; guess &quot;cancel&quot;?<br>
&gt;&gt;<br>
&gt;&gt; The trouble is none of these alternatives really match what abort<=
br>
&gt;&gt; means, reset and cancel do mean something different. &quot;abandon=
&quot; might be<br>
&gt;&gt; closer but still isn&#39;t right. &quot;attempt&quot; maybe? If we=
 get too creative<br>
&gt;&gt; with this, users just won&#39;t understand what it means :(<br>
<br>
I had the impression, from the documentation, that bitbake-setup would leav=
e the<br>
repository in the middle of a rebase, to let you deal with conflict, and th=
en<br>
continue on the next bitbake-setup update call.<br>
<br>
It appears to use --abort instead, so a misunderstanding from my part.<br>
<br>
Out of these options, I think &quot;reset&quot; might be the best one, I ag=
ree with<br>
Quentin. But I&#39;m not a native speaker, so I might not have an understan=
ding as<br>
subtle as others.<br>
<br>
I&#39;ll let Richard decide on what to do here.<br>
<br>
Antonin<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#9173): <a href=3D"https://lists.yoctoproject.org/g/docs=
/message/9173" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproj=
ect.org/g/docs/message/9173</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/118594590/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/118594590/1686489</a><br>
Group Owner: <a href=3D"mailto:docs%2Bowner@lists.yoctoproject.org" target=
=3D"_blank">docs+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/docs/unsub" rel=3D=
"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/docs/unsub<=
/a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex.kanav=
in@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>
</div>

--00000000000085f5d1064e8b72fa--

