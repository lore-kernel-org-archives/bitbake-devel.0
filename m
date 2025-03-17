Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EAC35FF8
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 18:56:42 +0000 (UTC)
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
 by mx.groups.io with SMTP id smtpd.web10.61205.1742237795997766304
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Mar 2025 11:56:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V+HdxNoU;
 spf=pass (domain: gmail.com, ip: 209.85.222.67, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-8670fd79990so1885389241.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Mar 2025 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237795; x=1742842595; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=09GNzuzPdwGB5BTsNYjcU5gU9KvwOYgFUrDHijh9VLI=;
        b=V+HdxNoUfpyezX7nHgtShMJm/xiJlATN38Emrfn3Poq0bvKme/ae+KwZ6ZUPLK38nP
         xnEaNIxRcPg6I7ozP75KWdWtqs2c3+EfzLyK4mqoI7vrrJfEAL+hnoGXcvozBXQCX00K
         wGrO1NCJqHVEVHWsDis3jzMW/wL+pD5iVanlv8VSIiBf6voKTdkC1UqGQD5Jd/444EF8
         0CCShg30JxH9/EdNd0Q1nkxzFMvdab1HFBgmbgn4itL2OGAIh4oVI1EYR2X/mUbFjFz2
         g2iPgvpO96fZAJLJbq0S42vdxw8xldPRo5KfPjzqWN0LhbTJda+k9NPXkIPBLJEpzD+q
         cHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237795; x=1742842595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09GNzuzPdwGB5BTsNYjcU5gU9KvwOYgFUrDHijh9VLI=;
        b=foJ/JH9xL4LIbWBebcjmeZkkdq4ahaKZ5fYMTcuEIh3TBvrWGOgdF/CYJWzYyXkLGB
         BQ2ptuEtJNVZagEJ4p8Jr3a24S2dWZvWe1tP1w5G4DNK0BWTVHYpX8bTgeq9WdDE+0AX
         oOmFfTolI0osztQ+Gr5qGO8UbEobRVA9Dg63oKpvsqLsEdgwN/q3c3C0no019CCexu7s
         uztWv/KSoqUbVNmfUdQN2pygdPb3zJutEEHfjfHm+yop+r/Xmqb86vyhqKoZ76w6TWaX
         mLXxixUN0ZIuZl2hdz4kf8l3imJExXKMuSGPDsYkbphmc5W0DP09aTf9JmkbVQVPPiBz
         YhOw==
X-Gm-Message-State: AOJu0YzPSLXbS3SKb0asmLSH1LZim2c8j9z9Ey0fYg4I8KDEZV7GIjMa
	WJhKqJeaL5oR8NfCoOsLWCvuTKnrtBP1QppIdq2GVdBHdn0CQZ4iqWpd6m7hXIxDSEl1GRHXXW3
	kmoVaugVq02LJP/s+d2i29+Vq64bLtz4/kKY=
X-Gm-Gg: ASbGncuuHJhIR8OD8Lc3sZTP/RKTO8NUhV+GPwnGJ0/6s4dgU7SFyj421cx/yGxC4LU
	+qwR4ttLhitPXBttEW8dHNEivlYy0OC2SRdLV4u388yOp4DmichyHz/9ETBvShotuEvpP9Kk7g2
	IrSUwYqcyptYAn0HeqzBv7RFMCkA==
X-Google-Smtp-Source: AGHT+IGvsdaFigegZlBsrWCZgGuxDXw/z9l5xyH/1WyackBaNX+x+QfHVHX3FQiLVcI+bNseiVgQufuNYIPl1XSUiEM=
X-Received: by 2002:a05:6102:f8d:b0:4c3:6393:8448 with SMTP id
 ada2fe7eead31-4c38310cd8fmr10886456137.1.1742237794992; Mon, 17 Mar 2025
 11:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250311122901.13820-1-eric.meyers@arthrex.com> <20250311122901.13820-2-eric.meyers@arthrex.com>
In-Reply-To: <20250311122901.13820-2-eric.meyers@arthrex.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Mon, 17 Mar 2025 13:56:36 -0500
X-Gm-Features: AQ5f1JraPln5-phNzHuvtPA6Vy_RhnlnyFIVlU20Hq23zgibdV8PpVH_XynX-Ns
Message-ID: <CA+cKJ+E9FAaZS+0QfUnAK5JnRXgkQpyR4H2B-mBEnUbK7KoM+A@mail.gmail.com>
Subject: Re: [bitbake][styhead][2.10][PATCH v1 1/2] fetch2/npm: Adding npmrc
 support for private registry authentication
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>
Content-Type: multipart/alternative; boundary="000000000000e28dbb06308e5883"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Mar 2025 18:56:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17449

--000000000000e28dbb06308e5883
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:28=E2=80=AFAM Eric Meyers <eric.meyers15310@gmail=
.com>
wrote:

> From: Eric Meyers <eric.meyers15310@gmail.com>
>
> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
> ---
>  lib/bb/fetch2/npm.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index ac76d64cd..38f460e5b 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -91,6 +91,12 @@ class NpmEnvironment(object):
>          self.d =3D d
>
>          self.user_config =3D tempfile.NamedTemporaryFile(mode=3D"w",
> buffering=3D1)
> +
> +        hn =3D self._home_npmrc(d)
> +        if hn is not None:
> +            with open(hn, 'r') as hnf:
> +                self.user_config.write(hnf.read())
> +
>          for key, value in configs:
>              self.user_config.write("%s=3D%s\n" % (key, value))
>
> @@ -103,6 +109,15 @@ class NpmEnvironment(object):
>          if self.user_config:
>              self.user_config.close()
>
> +    def _home_npmrc(self, d):
> +        """Function to return user's HOME .npmrc file (or None if it
> doesn't exist)"""
> +        home_npmrc_file =3D os.path.join(os.environ.get("HOME"), ".npmrc=
")
> +        if d.getVar("BB_USE_HOME_NPMRC") =3D=3D "1" and
> os.path.exists(home_npmrc_file):
> +            bb.warn(f"BB_USE_HOME_NPMRC flag set and valid .npmrc
> detected - "\
> +                    f"npm fetcher will use {home_npmrc_file}")
> +            return home_npmrc_file
> +        return None
> +
>      def run(self, cmd, args=3DNone, configs=3DNone, workdir=3DNone):
>          """Run npm command in a controlled environment"""
>          with tempfile.TemporaryDirectory() as tmpdir:
>


Just poking this patch submission since I haven't heard anything since
initially submitting it a week ago/haven't seen anything merge yet.

I know @rpurdie said it was borderline new functionality on a previous
thread and might not be accepted into styhead (2.10) and scarthgap (2.8),
but just wanted to have closure if that's the case.

Would be really nice/make our lives easier if this could make it all the
way into scarthgap, but understand if there is hesitation from the
maintainers.

Thanks,
-Eric

--000000000000e28dbb06308e5883
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">On Tue, Mar 11, 2025 at =
7:28=E2=80=AFAM Eric Meyers &lt;<a href=3D"mailto:eric.meyers15310@gmail.co=
m">eric.meyers15310@gmail.com</a>&gt; wrote:</div><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">F=
rom: Eric Meyers &lt;<a href=3D"mailto:eric.meyers15310@gmail.com" target=
=3D"_blank">eric.meyers15310@gmail.com</a>&gt;<br>
<br>
Signed-off-by: Eric Meyers &lt;<a href=3D"mailto:eric.meyers@arthrex.com" t=
arget=3D"_blank">eric.meyers@arthrex.com</a>&gt;<br>
Cc: Geoff Parker &lt;<a href=3D"mailto:geoffrey.parker@arthrex.com" target=
=3D"_blank">geoffrey.parker@arthrex.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/npm.py | 15 +++++++++++++++<br>
=C2=A01 file changed, 15 insertions(+)<br>
<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index ac76d64cd..38f460e5b 100644<br>
--- a/lib/bb/fetch2/npm.py<br>
+++ b/lib/bb/fetch2/npm.py<br>
@@ -91,6 +91,12 @@ class NpmEnvironment(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.d =3D d<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.user_config =3D tempfile.NamedTempor=
aryFile(mode=3D&quot;w&quot;, buffering=3D1)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hn =3D self._home_npmrc(d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if hn is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(hn, &#39;r&#39;) as hn=
f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.user_config.w=
rite(hnf.read())<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for key, value in configs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.user_config.write(&quo=
t;%s=3D%s\n&quot; % (key, value))<br>
<br>
@@ -103,6 +109,15 @@ class NpmEnvironment(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.user_config:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.user_config.close()<br=
>
<br>
+=C2=A0 =C2=A0 def _home_npmrc(self, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Function to return user&#39;=
s HOME .npmrc file (or None if it doesn&#39;t exist)&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 home_npmrc_file =3D os.path.join(os.environ.ge=
t(&quot;HOME&quot;), &quot;.npmrc&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&quot;BB_USE_HOME_NPMRC&quot;) =3D=
=3D &quot;1&quot; and os.path.exists(home_npmrc_file):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(f&quot;BB_USE_HOME_NPMRC=
 flag set and valid .npmrc detected - &quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;npm fetcher will use {home_npmrc_file}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return home_npmrc_file<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def run(self, cmd, args=3DNone, configs=3DNone, workdir=
=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run npm command in a co=
ntrolled environment&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with tempfile.TemporaryDirectory() as tmp=
dir:<br></blockquote><div><br></div><div><br></div>Just poking this patch s=
ubmission since I haven&#39;t heard anything since initially submitting it =
a week ago/haven&#39;t seen anything merge yet.=C2=A0<div><br></div><div>I =
know=C2=A0@rpurdie said it was borderline new functionality on a previous t=
hread and might not be accepted into styhead (2.10) and scarthgap (2.8), bu=
t just wanted to have closure if that&#39;s the case.=C2=A0</div><div><br><=
/div><div>Would be really nice/make our lives easier if this could make it =
all the way into scarthgap, but understand if there is hesitation from the =
maintainers.</div><div><br></div><div>Thanks,</div><div>-Eric</div></div></=
div></div>

--000000000000e28dbb06308e5883--

