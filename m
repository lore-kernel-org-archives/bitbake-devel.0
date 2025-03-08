Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBAC282EC
	for <webhook@archiver.kernel.org>; Sat,  8 Mar 2025 14:16:12 +0000 (UTC)
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
 by mx.groups.io with SMTP id smtpd.web11.9665.1741443370074760606
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Mar 2025 06:16:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YtB+dKc+;
 spf=pass (domain: gmail.com, ip: 209.85.222.66, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-86d42f08135so613681241.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 08 Mar 2025 06:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741443369; x=1742048169; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6djKM6C21ZvCdvG6lwJJ/wUMWWXsNGKgimibgcr1U4A=;
        b=YtB+dKc+lg2nsUkJG6RR+b64ZbcNAHuPSYlE7L51ul9nyo9488vp5NljgbMU/a0IXi
         uvugvHxPamT48Je6WTUWriNvlRpwyxacKBNnjAvgpiD4HIBZ9g1wmDDSqsAO5KKHs3OZ
         8qavpKBSoF7iPld/+pK+uSUz0hJYolhPmoUip7swCVjfsjSLP294Sneh74M99LxsUf4o
         nVhfk7Jm8AWrTq4rf1jtZvak6NUfCqQd9nnsB10SVL14Sn16mm57mLKIZVVrvhuFxBO9
         qt7CakXmKuTVrGKOmjyo4Nzm+mLDPU1YBemOMigZwo5yLZTmc9RtdYTUKI+oNcvCHj0Q
         tHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741443369; x=1742048169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6djKM6C21ZvCdvG6lwJJ/wUMWWXsNGKgimibgcr1U4A=;
        b=ANGz3BVhB7GUCMKwe/SgWkDSO34KGhKSIAajMiNywIE/R78JuS/14lCt7jOwYI13m1
         drhL07U1cQiyLWTy7d7lK10Wa5pUul0czUctJ7o4QLK0Wnl/buU5rLog3w8FunUATZEZ
         wfizxCrQzZjss7tzisZfY/+Stuou2BO3ou9Yy2OvSuezIbwAweBtqmdoiK8mdkqacJ1V
         X1GQPFjU4BLM+uq7jwjMyE0Z/Z0gwfuj6ei3duQFwOvgm0x4m0bCUHiTvCTF0ARYjZ3W
         6vt6YP3Klk8L1/75vL8qAeuhx3B0YzL05xmmL0aa3i7XfSJX4ZtqN7eXbSIoqKqL9bk8
         MWwg==
X-Gm-Message-State: AOJu0YwAUaqx6QO1exjeXWY+uwLNRJeQm/20IvPJEglQ09pDYQ/L9YCI
	GzYVjLUdfvxpoLUsqf1Wd3Yx7nvtATLA9DrrQyBQldHAQvkfKxGe+nnj2zHNf/Yzr6xL7HtnthM
	craMjVjimHCI1MH9bcTC/x0mmWas=
X-Gm-Gg: ASbGnctAWjmz+sujrcvsE+K2jYDfA5IrtXsPhhp1aT1Dlan1srOexfnHmtsMK/2XOAR
	CBF9taLSzdT5vNrSo2L5oVpZ0r5Bj+uNa21Ok7UedlKGkw629rpoVOVAkTXDKzondse7I22BGyr
	fMbW5wJB4I5ivtjD8pEvdK6+tzGA==
X-Google-Smtp-Source: AGHT+IHsREJZtMzYv0tk8vkrU8jpHr1bwDpH3H+HIqWwLD/u0KwvJe6db+0Tdhh2wBhKCcCYV3MChDItjRm/y7KWJVg=
X-Received: by 2002:a05:6102:f0d:b0:4bb:c527:aacd with SMTP id
 ada2fe7eead31-4c30a71a88bmr4622975137.23.1741443368907; Sat, 08 Mar 2025
 06:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20250228130137.400-1-eric.meyers@arthrex.com> <20250228130137.400-3-eric.meyers@arthrex.com>
 <CAB=6tBRU3+bKeNsbNpiHChBpeXbjR7Or3rOVT66-5K81OgZK2Q@mail.gmail.com>
 <CA+cKJ+GOjzvBoHrFr_Y634cOUJTrD1VC8864CfDKkRJp_ey2gQ@mail.gmail.com> <CAB=6tBRm_rJ2QeCdZhSNgTaZZ94DsyQX27MnAeLu9tiPnin2gQ@mail.gmail.com>
In-Reply-To: <CAB=6tBRm_rJ2QeCdZhSNgTaZZ94DsyQX27MnAeLu9tiPnin2gQ@mail.gmail.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Sat, 8 Mar 2025 08:16:06 -0600
X-Gm-Features: AQ5f1Jp0bkD4NnQR28YFgp95Tx5z0ar73ZlqaCESf7cxSGv3gNOTaQa9ZwiOVn4
Message-ID: <CA+cKJ+EsE0K6zm0AavqHEVRfGNx-y_AAr_1JOe-VMfmoUu9icQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>
Content-Type: multipart/alternative; boundary="0000000000006680b7062fd5615f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 08 Mar 2025 14:16:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17415

--0000000000006680b7062fd5615f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:56=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.com=
> wrote:

> On Fri, Mar 7, 2025 at 9:17=E2=80=AFAM Eric Meyers <eric.meyers15310@gmai=
l.com>
> wrote:
>
>>
>> Apologies if this isn't the correct process (this is my first time
>> submitting a patch), but what's needed to merge this patch into
>> master-next, then master?
>>
>>
> For now, probably nothing, but it never hurts to do what you did and ask.
> The
> bitbake repo maintainers watch this list.
>
> Your patches show up in patchwork here:
> https://patchwork.yoctoproject.org/project/bitbake/list/
> Just search for your name.
>
> Also, have you reviewed the contribution docs?
>
> https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html
>
>
> ..Ch:W..
>
>
Yes, I have reviewed those, they are what helped me out with initially
submitting the patch, I just wanted to poke this thread since the guidance
was 2-3 days until it makes it into master-next.

Anyways, I see the commits have been applied now:

    -
https://github.com/openembedded/bitbake/commit/177395a4dee1b51380e61ffa8889=
588f81740bc0
    -
https://github.com/openembedded/bitbake/commit/23f3f16cf211f9a9db8914eeb82c=
cf131ac21b22

Thanks a ton! I will submit another patch for backporting this to the
scarthgap version of bitbake (2.8) in the coming days.

-Eric

--0000000000006680b7062fd5615f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Mar 7, 2025 at 12:56=E2=80=AFPM Chuck Wolber &lt=
;<a href=3D"mailto:chuckwolber@gmail.com">chuckwolber@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><div dir=3D"ltr"><div style=3D"font-family:monospace">On Fri, Mar 7, 2=
025 at 9:17=E2=80=AFAM Eric Meyers &lt;<a href=3D"mailto:eric.meyers15310@g=
mail.com" target=3D"_blank">eric.meyers15310@gmail.com</a>&gt; wrote:</div>=
</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br><div>Apologies if this isn&#3=
9;t the correct process (this is my first time submitting a patch), but wha=
t&#39;s needed to merge this patch into master-next, then master?</div><div=
><br></div></div></div></blockquote><div><br></div><div><div style=3D"font-=
family:monospace">For now, probably nothing, but it never hurts to do what =
you did and ask. The</div><div style=3D"font-family:monospace">bitbake repo=
 maintainers watch this list.<br><br></div><div style=3D"font-family:monosp=
ace">Your patches show up in patchwork here: <a href=3D"https://patchwork.y=
octoproject.org/project/bitbake/list/" target=3D"_blank">https://patchwork.=
yoctoproject.org/project/bitbake/list/</a></div><div style=3D"font-family:m=
onospace">Just search for your name.<br><br></div><div style=3D"font-family=
:monospace">Also, have you reviewed the contribution docs?<br><br><a href=
=3D"https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html=
" target=3D"_blank">https://docs.yoctoproject.org/dev/contributor-guide/sub=
mit-changes.html</a><br></div><div style=3D"font-family:monospace"><br></di=
v><div style=3D"font-family:monospace"><br></div><div style=3D"font-family:=
monospace">..Ch:W..</div></div><div><br></div></div></div></blockquote><div=
><br></div><div>Yes, I have reviewed those, they are what helped me out wit=
h initially submitting the patch, I just wanted to poke this thread since t=
he guidance was 2-3 days until it makes it into master-next.</div><div><br>=
</div><div>Anyways, I see the commits have been applied now:</div><div><br>=
</div><div>=C2=A0 =C2=A0 - <a href=3D"https://github.com/openembedded/bitba=
ke/commit/177395a4dee1b51380e61ffa8889588f81740bc0">https://github.com/open=
embedded/bitbake/commit/177395a4dee1b51380e61ffa8889588f81740bc0</a></div><=
div>=C2=A0 =C2=A0 -=C2=A0<a href=3D"https://github.com/openembedded/bitbake=
/commit/23f3f16cf211f9a9db8914eeb82ccf131ac21b22">https://github.com/openem=
bedded/bitbake/commit/23f3f16cf211f9a9db8914eeb82ccf131ac21b22</a></div><di=
v><br></div><div>Thanks a ton! I will submit another patch for backporting =
this to the scarthgap version of bitbake (2.8) in the coming days.=C2=A0</d=
iv><div><br></div><div>-Eric=C2=A0</div><div>=C2=A0</div></div></div></div>=
</div>

--0000000000006680b7062fd5615f--

