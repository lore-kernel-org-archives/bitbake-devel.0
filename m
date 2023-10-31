Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81476C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:22:21 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web10.187237.1698762139582749740
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:22:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cexcn5cU;
 spf=pass (domain: gmail.com, ip: 209.85.219.176, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-da37522a363so953660276.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698762139; x=1699366939; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=izAmtFdHec0w07gUM/iS+7c01cli6V1h8FoVZmNC2+A=;
        b=cexcn5cUUOwOZ0sNJWCVC5yaJJKvhj/K4UDFADyaTcdEDj6FnD8LTsVkCchugctZ+3
         rEcssV8x2Npdaml5NMNXlWkptx/nOxOOPZqlP/QmKU1Z6Zes3hSIPiPR/DeoeR2Ge6dV
         Eco7jR9dkcfjS2SkfxnBqNNmgzxuBzIDFPc4ya6sVBIqqzRCqiaF6+LSc8T2fVDAwK70
         rNoFrQJywLUrlwM7k3fulKOCfko27Gh+5cMC1RgDDbtvPdHRjXduX0AoD9b0c13xHRg1
         QraOw+zGyraaIn44dVHeawtcx+OuOMESbwtXdWgHrRinLer7p335ao2VcI8Kyv6zeDxg
         f9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698762139; x=1699366939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izAmtFdHec0w07gUM/iS+7c01cli6V1h8FoVZmNC2+A=;
        b=MNgGQO33s/PpWIV/em2SXpKAtR5ftNVGuAQe62NvUhfTw/4EkeYTsxnufhcycaXs34
         8bZHLEkih5mDggC+FqIgEwOJwoOEs2yN+xDfk4JbyytppaUvQYD6TUgw/OUjYvZdF72Y
         NZNz7C5gE15kBNWRfvRflfMGUOPhAf1KnWsiO6LK1d55j3byRJL8amRfSrKy8fDY9E7G
         gNk/wKwjkqkBSYCYwq6ayhglTAU4Jx/BzUPgUVxED2waNoYDTgdYrySVtn9+IqLATpc+
         +3augdalc+ljcmlqiDWN0vETGRHtAru0z9Sz7S1f28dICW991MmmIAtPlJpBdqKfBdF0
         qc0Q==
X-Gm-Message-State: AOJu0YzOfcp/hq5/xL+Aa00sKm7LIy11G2umpeWZ9dIul+STV06PuDNy
	ofssV6MA+q6UMWmrM5T+P5rUdmiuIIfah5QGx+NHICI+Ol0cMg==
X-Google-Smtp-Source: AGHT+IEbwn+aGEGHwjAygtCmtc0gVVgfgPKJTROXFexiezeE/Zej92vOSQMpBIZOqOuAhBt4UQUTZhvnRO4Qnytf3nU=
X-Received: by 2002:a25:77d3:0:b0:d81:51db:3292 with SMTP id
 s202-20020a2577d3000000b00d8151db3292mr14375723ybc.45.1698762138638; Tue, 31
 Oct 2023 07:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 07:22:07 -0700
Message-ID: <CANx9H-BYBTED82qe32Ym0TwAZtB_kgB9WXu8RW7jP4D=Cm6VjA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/8] Toaster: Update toaster-requirements.txt
 to add pytest and some plugin's
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d4e093060903e1d8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:22:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15337

--000000000000d4e093060903e1d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> The pytest framework makes it easy to write small, readable tests, and ca=
n
> scale
> to support complex functional testing for applications and libraries.
> - Pytest-html is a plugin for pytest that generates a HTML report for tes=
t
> results.
>

This may be useful for local testing, but we do not use HTML in general for
test results on the AutoBuilder.


> - Pytest-django allows us to test Django project/applications with the
> pytest testing tool.
> - Pytest-env is a pytest plugin that enables us to set environment
> variables in a pytest.ini or pyproject.toml file
>
> These two seem sensible.

You didn't mention pytest-metadata, but it looks like it will be useful to
report out the system configuration:
 https://pypi.org/project/pytest-metadata/

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
>

Reviewed-by: Tim Orling <tim.orling@konsulko.com>


> ---
>  toaster-requirements.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/toaster-requirements.txt b/toaster-requirements.txt
> index d8e48b7f..19bf6fd2 100644
> --- a/toaster-requirements.txt
> +++ b/toaster-requirements.txt
> @@ -2,3 +2,8 @@ Django>4.2,<4.3
>  beautifulsoup4>=3D4.4.0
>  pytz
>  django-log-viewer=3D=3D1.1.7
> +pytest=3D=3D7.4.2
> +pytest-django=3D=3D4.5.2
> +pytest-env=3D=3D1.1.0
> +pytest-html=3D=3D4.0.2
> +pytest-metadata=3D=3D3.0.0
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15326):
> https://lists.openembedded.org/g/bitbake-devel/message/15326
> Mute This Topic: https://lists.openembedded.org/mt/102283457/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000d4e093060903e1d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">The pytest framework makes it=
 easy to write small, readable tests, and can scale<br>
to support complex functional testing for applications and libraries.<br>
- Pytest-html is a plugin for pytest that generates a HTML report for test =
results.<br></blockquote><div><br></div><div>This may be useful for local t=
esting, but we do not use HTML in general for test results on the AutoBuild=
er.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
- Pytest-django allows us to test Django project/applications with the pyte=
st testing tool.<br>
- Pytest-env is a pytest plugin that enables us to set environment variable=
s in a pytest.ini or pyproject.toml file<br>
<br></blockquote><div>These two seem sensible.</div><div><br></div><div>You=
 didn&#39;t mention pytest-metadata, but it looks like it will be useful to=
 report out the system configuration:</div><div>=C2=A0<a href=3D"https://py=
pi.org/project/pytest-metadata/">https://pypi.org/project/pytest-metadata/<=
/a></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br></blockquote><div><br></div><div>Reviewed-by: Tim Orling &lt;<a h=
ref=3D"mailto:tim.orling@konsulko.com">tim.orling@konsulko.com</a>&gt;</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0toaster-requirements.txt | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/toaster-requirements.txt b/toaster-requirements.txt<br>
index d8e48b7f..19bf6fd2 100644<br>
--- a/toaster-requirements.txt<br>
+++ b/toaster-requirements.txt<br>
@@ -2,3 +2,8 @@ Django&gt;4.2,&lt;4.3<br>
=C2=A0beautifulsoup4&gt;=3D4.4.0<br>
=C2=A0pytz<br>
=C2=A0django-log-viewer=3D=3D1.1.7<br>
+pytest=3D=3D7.4.2<br>
+pytest-django=3D=3D4.5.2<br>
+pytest-env=3D=3D1.1.0<br>
+pytest-html=3D=3D4.0.2<br>
+pytest-metadata=3D=3D3.0.0<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15326): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15326" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15326</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102283457/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102283457/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000d4e093060903e1d8--

