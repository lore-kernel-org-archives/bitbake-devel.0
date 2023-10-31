Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A86C4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:59:57 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
 by mx.groups.io with SMTP id smtpd.web11.799.1698764389226539140
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:59:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LNxnSphb;
 spf=pass (domain: gmail.com, ip: 209.85.219.175, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so5180331276.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698764388; x=1699369188; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx7ZuZOiOSQJH5RHWTz1tricbrMlHHXbhlScENcdNGQ=;
        b=LNxnSphbINEnoC74J4hfxbtQk0XWeFHjEcc3eSqD/EBIN9h4Cg9pGxHkviKMaOE8Zg
         LNuVdoWpiNcd9Y0tgkhQiyR3j/6C4X5Vwo5SMDpWaTQXHHoqB4MgXdmdkARCR5NxH+PD
         cgHRJbOJmZtIeWn7FyyQyAOqlSCLIg7WuCGU3nmgD/bYrcyPgsq2q63Vh2LBMFRdjwwP
         cO+D6KX39ORfJ4bHZruH+w1mEvJeNW9CQzqKcQjjlzpgEyrGbCPcCs/DQjA35+uNONFP
         Jv+1npCm3kgLMABpwhvHxz5sOWkQFjdiHoHTPNZmFwtkI83zPC3rsfOxebV6IAi5wQOJ
         PhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764388; x=1699369188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kx7ZuZOiOSQJH5RHWTz1tricbrMlHHXbhlScENcdNGQ=;
        b=U+8aKvqEEP40fNdTLaTK3GsEfkqjsd3KKxdocVtvP1DJWD7n0T07bK4DS4Zz0raPII
         JAfpPwI5bBsdMCWhbnjZDbgWrqh1rt9OZMn2CxJEJUJpwLJI6kQY/gJVC1Vx1JelX8+X
         XMjcfsC+82F3xNHARAwBwgfHblPCEBqV6p2ytBAGfwsTBOgMJSVXB7XbALodB8YM1ST3
         5Q3l9jmHuYQ9EEuZCtw3lIsgaxhfkViU35evZ6B4Y95uwr2MZ9CIHVR4xht8HK1kCUo2
         jHkP4MV3sr5AyCcWsjg54ymFbevLSa6x8liEwNirBAXxa9cUMRz7ZAp6ciDa9mmZ9cKd
         Zp+w==
X-Gm-Message-State: AOJu0YymkX94AIZzLcFePQjaKShvNS6zal/uvfXKjOPM0vtrlLa4plYg
	CnezYoe2taNnygTtyQ0TqNqL7uwuvPPamiHmRUz4eGzZQu0=
X-Google-Smtp-Source: AGHT+IFLdTzXgWtW9sQ0eYYGlh/AxKhkQyH4kFB39Hlou111ZSYDFk4L8LT5wyAw+uPTBNpat8FPjaOhJlg6+e6VK+c=
X-Received: by 2002:a25:2e0c:0:b0:d9a:4fa0:dca9 with SMTP id
 u12-20020a252e0c000000b00d9a4fa0dca9mr12099770ybu.25.1698764388360; Tue, 31
 Oct 2023 07:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195132.235083-1-alassane.yattara@savoirfairelinux.com> <20231030195132.235083-6-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195132.235083-6-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 07:59:37 -0700
Message-ID: <CANx9H-CqXf5eMtbBiMO1sS9VtmYShRv=WDNc3wX5d_ogKoWCcA@mail.gmail.com>
Subject: Re: [Toaster] [PATCH 6/8] Toaster: Move toaster tests requirements in bitbake/lib/toaster/toaster-tests-requirements
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: toaster@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000ece7630609046734"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:59:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15343

--000000000000ece7630609046734
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> To make difference between bitbake and toaster python requirements,
> a dedicated requirements file is created for toaster in root of toaster
> dir.
>
>
Since this is making a change to what was introduced in the first patch in
this series, you should instead go back and fix that commit?


> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/toaster-tests-requirements.txt | 5 +++++
>  toaster-requirements.txt                         | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/toaster/tests/toaster-tests-requirements.txt
> b/lib/toaster/tests/toaster-tests-requirements.txt
> index f30ac070..7109c625 100644
> --- a/lib/toaster/tests/toaster-tests-requirements.txt
> +++ b/lib/toaster/tests/toaster-tests-requirements.txt
> @@ -1 +1,6 @@
>  selenium>=3D4.13.0
> +pytest=3D=3D7.4.2
> +pytest-django=3D=3D4.5.2
> +pytest-env=3D=3D1.1.0
> +pytest-html=3D=3D4.0.2
> +pytest-metadata=3D=3D3.0.0
> diff --git a/toaster-requirements.txt b/toaster-requirements.txt
> index 19bf6fd2..d8e48b7f 100644
> --- a/toaster-requirements.txt
> +++ b/toaster-requirements.txt
> @@ -2,8 +2,3 @@ Django>4.2,<4.3
>  beautifulsoup4>=3D4.4.0
>  pytz
>  django-log-viewer=3D=3D1.1.7
> -pytest=3D=3D7.4.2
> -pytest-django=3D=3D4.5.2
> -pytest-env=3D=3D1.1.0
> -pytest-html=3D=3D4.0.2
> -pytest-metadata=3D=3D3.0.0
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5909):
> https://lists.yoctoproject.org/g/toaster/message/5909
> Mute This Topic: https://lists.yoctoproject.org/mt/102283477/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ece7630609046734
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">To make difference between bi=
tbake and toaster python requirements,<br>
a dedicated requirements file is created for toaster in root of toaster dir=
.<br>
<br></blockquote><div><br></div><div>Since this is making a change to what =
was introduced in the first patch in this series, you should instead go bac=
k and fix that commit?</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br>
---<br>
=C2=A0lib/toaster/tests/toaster-tests-requirements.txt | 5 +++++<br>
=C2=A0toaster-requirements.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 -----<br>
=C2=A02 files changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toaster=
/tests/toaster-tests-requirements.txt<br>
index f30ac070..7109c625 100644<br>
--- a/lib/toaster/tests/toaster-tests-requirements.txt<br>
+++ b/lib/toaster/tests/toaster-tests-requirements.txt<br>
@@ -1 +1,6 @@<br>
=C2=A0selenium&gt;=3D4.13.0<br>
+pytest=3D=3D7.4.2<br>
+pytest-django=3D=3D4.5.2<br>
+pytest-env=3D=3D1.1.0<br>
+pytest-html=3D=3D4.0.2<br>
+pytest-metadata=3D=3D3.0.0<br>
diff --git a/toaster-requirements.txt b/toaster-requirements.txt<br>
index 19bf6fd2..d8e48b7f 100644<br>
--- a/toaster-requirements.txt<br>
+++ b/toaster-requirements.txt<br>
@@ -2,8 +2,3 @@ Django&gt;4.2,&lt;4.3<br>
=C2=A0beautifulsoup4&gt;=3D4.4.0<br>
=C2=A0pytz<br>
=C2=A0django-log-viewer=3D=3D1.1.7<br>
-pytest=3D=3D7.4.2<br>
-pytest-django=3D=3D4.5.2<br>
-pytest-env=3D=3D1.1.0<br>
-pytest-html=3D=3D4.0.2<br>
-pytest-metadata=3D=3D3.0.0<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#5909): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/5909" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/5909</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/102283477/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/102283477/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000ece7630609046734--

