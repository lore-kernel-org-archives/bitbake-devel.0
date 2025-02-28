Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281ADC282C6
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 18:09:35 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web11.950.1740766170965400993
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 10:09:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZV8fTc4d;
 spf=pass (domain: gmail.com, ip: 209.85.166.176, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d1a428471fso18705155ab.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740766170; x=1741370970; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xp0b17MkV2f0ZEylbPwfQDgbhsXVwc2YAO/0ka1oSNo=;
        b=ZV8fTc4dNhW0n0iRuQGLWIAwFaBZV9rRk90VbjNawSAAiIGZkt7vClIJPhLIK86i7M
         bsWidjN/Xjn54pgU1AAvpfaCoIuUpclcWHeYpAEzSSgKzS38ozJprp/ksjr/G2IJUfaR
         U/Pt1BU7PoMUX3KyR3G0PaOedSfVW6ZOcqTYsSIXl1dC9cZLnQGoclWz1pE8J7sI9MTs
         pljdzS7PCBQzHP+rz5RqXznl5Ut2SAq6mrv49SlvclYwrOKTHasBy26qLNbxlqzifZKP
         5G9wg/kn0oILkaOrTGY/C14MSzNTWisIhbBoj4N8AfqvxDQWpsppEHL17vW74r3fW5Ky
         DKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740766170; x=1741370970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp0b17MkV2f0ZEylbPwfQDgbhsXVwc2YAO/0ka1oSNo=;
        b=ksoFyse0KdEcbcZd/pRd+NumSt/2UF7Tl9STqXlLTQmzf7kKRksKawhJyhWwZjBYI7
         NwB+0xVZ7nZKNM2L3jtMECcgNmC1pbc0IOGJ+T3PmicNFIHfd2Wq0HXR+K8hHV1oopHk
         J4J39DyEgdbFKOapeOAINWXBBqqvJ03iJxQOEolw82eJmT98ReiT8fmN/w2MvThDWwVa
         JV3OIOv9IggwsC9H0cNWxsQHCGN5Tk5OIBla9mi5IJ3fPvTZSdKXMnxWJjzT14HeAkIq
         x5QhyXds+rtT6PmrQBqHTCeMxI9Fxe/4u5mzXLYE5n1Y56GkJYfdWvzvVSi2uVFwqBHu
         iKFg==
X-Gm-Message-State: AOJu0YyD7hJcJEmgzflcs+ijpAkBXPbEdHVtHnCW63vr26u1TmG7/RSq
	kY7al0HS9/x2nCvD22Gvvus8yhWAddSHm3Ao+Y+mjyIKF5C9r0hUzeWHToQhmqZbtVKhvXX9K4B
	BVZ4df2jf8Lhg8wpwgjpARw7U3aQ=
X-Gm-Gg: ASbGncvcotACrocFk2hy4Wo/DmOZd45roo/dSDbyvP7Ux6B/2lj0TZt++KxeXgL7kAq
	lI6NRYBRniH10fR1TCf/2jtQE1A3dOiKjVUvv/E49XrsfKlpu+95riVjH7cwSxGvF/ZIIZP1TDk
	zEkY6tQ82bt86qpdhlWrcOBFTk75foYxbp5cvFvHE=
X-Google-Smtp-Source: AGHT+IFsL0gKlcId26UKaKjhz9ZFDyJ6pF9hgDJeHdLRfs1Ni06l340x39BLRiqoEdemPibAothV1BG6f4quMLnnmP4=
X-Received: by 2002:a05:6e02:138d:b0:3d3:dd60:bc37 with SMTP id
 e9e14a558f8ab-3d3e6fadcb1mr43772825ab.22.1740766170154; Fri, 28 Feb 2025
 10:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20250228130137.400-1-eric.meyers@arthrex.com> <20250228130137.400-3-eric.meyers@arthrex.com>
In-Reply-To: <20250228130137.400-3-eric.meyers@arthrex.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Fri, 28 Feb 2025 10:09:09 -0800
X-Gm-Features: AQ5f1JoSQt5xENVRNTcAEmztybI26IU_Rc_87MoYlPj-DDKmwLyypZPUQhR_Vhg
Message-ID: <CAB=6tBRU3+bKeNsbNpiHChBpeXbjR7Or3rOVT66-5K81OgZK2Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>
Content-Type: multipart/alternative; boundary="00000000000035929f062f37b569"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 18:09:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17363

--00000000000035929f062f37b569
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:01=E2=80=AFAM Eric Meyers <eric.meyers15310@gmail=
.com>
wrote:

> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
> Cc: Chuck Wolber <chuckwolber@gmail.com>
> ---
>  .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 858de6347..00300d0d8 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -692,6 +692,12 @@ overview of their function and contents.
>        Within an executing task, this variable holds the hash of the task
> as
>        returned by the currently enabled signature generator.
>
> +   :term:`BB_USE_HOME_NPMRC`
> +      Controls whether or not BitBake uses the user's .npmrc file within
> their
> +      home directory within the npm fetcher. This can be used for
> authentication
> +      of private NPM registries, among other uses. This is turned off by
> default
> +      and requires the user to explicitly set it to "1" to enable.
> +
>     :term:`BB_VERBOSE_LOGS`
>        Controls how verbose BitBake is during builds. If set, shell scrip=
ts
>        echo commands and shell script output appears on standard out
>


Signed-off-by: Chuck Wolber <chuckwolber@gmail.com>

..Ch:W..


--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--00000000000035929f062f37b569
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">On Fri, Feb 28, 2025 at 5:01=E2=80=AFAM Eric Meyers &lt=
;<a href=3D"mailto:eric.meyers15310@gmail.com">eric.meyers15310@gmail.com</=
a>&gt; wrote:</div></div><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Eric Meyers=
 &lt;<a href=3D"mailto:eric.meyers@arthrex.com" target=3D"_blank">eric.meye=
rs@arthrex.com</a>&gt;<br>
Cc: Geoff Parker &lt;<a href=3D"mailto:geoffrey.parker@arthrex.com" target=
=3D"_blank">geoffrey.parker@arthrex.com</a>&gt;<br>
Cc: Chuck Wolber &lt;<a href=3D"mailto:chuckwolber@gmail.com" target=3D"_bl=
ank">chuckwolber@gmail.com</a>&gt;<br>
---<br>
=C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
index 858de6347..00300d0d8 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
@@ -692,6 +692,12 @@ overview of their function and contents.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Within an executing task, this variable holds th=
e hash of the task as<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0returned by the currently enabled signature gene=
rator.<br>
<br>
+=C2=A0 =C2=A0:term:`BB_USE_HOME_NPMRC`<br>
+=C2=A0 =C2=A0 =C2=A0 Controls whether or not BitBake uses the user&#39;s .=
npmrc file within their<br>
+=C2=A0 =C2=A0 =C2=A0 home directory within the npm fetcher. This can be us=
ed for authentication<br>
+=C2=A0 =C2=A0 =C2=A0 of private NPM registries, among other uses. This is =
turned off by default<br>
+=C2=A0 =C2=A0 =C2=A0 and requires the user to explicitly set it to &quot;1=
&quot; to enable.<br>
+<br>
=C2=A0 =C2=A0 :term:`BB_VERBOSE_LOGS`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Controls how verbose BitBake is during builds. I=
f set, shell scripts<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0echo commands and shell script output appears on=
 standard out<br>
</blockquote></div><div><br clear=3D"all"></div><br><div><span class=3D"gma=
il_default" style=3D"font-family:monospace">Signed-off-by: </span><span cla=
ss=3D"gmail_default" style=3D"font-family:monospace">Chuck Wolber &lt;<a hr=
ef=3D"mailto:chuckwolber@gmail.com">chuckwolber@gmail.com</a>&gt;<br></span=
></div><div><span class=3D"gmail_default" style=3D"font-family:monospace"><=
br></span></div><div><span class=3D"gmail_default" style=3D"font-family:mon=
ospace">..Ch:W..</span></div><br><br><span class=3D"gmail_signature_prefix"=
>-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">=
<div><b><span style=3D"font-family:monospace">=C2=A0 Opinions expressed are=
 my own. |<br>=C2=A0--------------------------------|------ &quot;Perfectio=
n must be reached by degrees<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 she requires the slow hand of time.&qu=
ot;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -Voltaire</span></b></div></div></div></div>

--00000000000035929f062f37b569--

