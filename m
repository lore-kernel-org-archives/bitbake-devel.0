Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FEC19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 05:38:46 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.9524.1740721124628251118
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 21:38:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PrTWZOTZ;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cfc8772469so7159495ab.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 21:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740721124; x=1741325924; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zi14lsJJtwJgpuEhN51heKl64mbGHZWTwh/CmxD8DpI=;
        b=PrTWZOTZfZFxK5Ip9rGv/3NxCxBaEL/jio329wsvBADoaqp0PA1lSxWNYWt6tz/lxl
         0bHS0o+OaDjzD2w/za9hhn56US2gRgKpV9TkDxAtgU21ZdiLENrnQi4j+rV2TX70ZKpj
         VFKgEi+wcYLpJvBQmG6PsZwNIWfWQ4mZbf0JHnNXBFa8Nfmqz0yoJjH/Kk48VG5sgIvW
         w3OODSJWzj/5ggvI3+8iQhMcbk+BQa8mjzRRDwQUAtnCPUWSc8qE8pcE4DHsckSJJloN
         AhPbhcRwGmOx+66SAnYFKEUcZ9+CLUsh71xk0+95SObFh3Kfgh4TWstf1vtF1IbNHdq8
         ImJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740721124; x=1741325924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zi14lsJJtwJgpuEhN51heKl64mbGHZWTwh/CmxD8DpI=;
        b=uh7sBWqZ/4Pi8tYehscpjQEtH+rFx9OkGT+2iOpbhAna+T1cddLx5rRc63houKXCho
         D4M+yi1YALJt7wvEJ6Sm3Y0Oef92NTwx1exzFVxrG4a1e0Fl7v+qSsYZ2m8bl/pjY8ri
         /QfY4zvl2uYK5ot5Md5JlaLG/rWNnt1f6S6AaJvXCAHy3QOfR7/cKtgmYceG2FUpzc6E
         QAfSWmNoIt+3aBd555OdW5ROpHCmNiZUBqJ0f6jNckKFaZbnsE7knv43h4TpJK+GXXxm
         dVmC1lPYlmHXK7tS3bsHYke94oOwQgJtrEy0lIbFivzH20fOP8MioEq26wrZGmhH0JAB
         5KqQ==
X-Gm-Message-State: AOJu0YyM5tEY3iV0WZdBpfQ3YCnUma7gMq1PcdhbBpWClguROtjNXiFY
	k+szI5nRHF1XvRYN+9mv8cETSwqU37aGIlgbLZX9nyle0nfSEQlv1FZobN1v7quE2XJpQShGDgB
	Uhvv/9okhwxNPjhjM1nmXZc3VkYA=
X-Gm-Gg: ASbGncumP1uIz+sUPRfLDy9PMsJ969TElqvwlo/OTvuRySvGvzHhvsh4Bo6b9MbgwXQ
	UaeqdGqyfu4mXmkVGFpoLmPYpa1wnHp1jlthmA8g0gZ0PCtHh1G1QGl7KZT3DuvvfJcyNTuTeXM
	k783ciiMWCsS2DMS/WCl+ZV9slKaNb5hU/ugyOvoA=
X-Google-Smtp-Source: AGHT+IGhrW0NeGO0dWLKujaSyobIQ+kmWOZweAx7I+/ekiSoAaHRM8EmlbbqlAa9dOZ5Z2TCflUSXo5cZMkyuNCO4eM=
X-Received: by 2002:a05:6e02:216c:b0:3cf:bc71:94f5 with SMTP id
 e9e14a558f8ab-3d3e6f4aaecmr19051255ab.22.1740721123748; Thu, 27 Feb 2025
 21:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20250227223436.28224-1-eric.meyers@arthrex.com> <20250227223436.28224-2-eric.meyers@arthrex.com>
In-Reply-To: <20250227223436.28224-2-eric.meyers@arthrex.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Thu, 27 Feb 2025 21:38:26 -0800
X-Gm-Features: AQ5f1Jo60Cgf0Iks2sVyqyIoSuoy6AZ0SuLt-HNPyh1Lyxh8kgkRIavZKdiHjYU
Message-ID: <CAB=6tBTRXOH1MHWgbtewbZBMj1Mp3Hmne3_28nM8=7p=FJYQzQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>
Content-Type: multipart/alternative; boundary="0000000000003bf64a062f2d389b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 05:38:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17355

--0000000000003bf64a062f2d389b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 2:34=E2=80=AFPM Eric Meyers <eric.meyers15310@gmail=
.com>
wrote:

> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
> Cc: Chuck Wolber <chuckwolber@gmail.com>
> ---
>  lib/bb/fetch2/npm.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index c09f05044..2c7ed5340 100644
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
> @@ -103,6 +109,21 @@ class NpmEnvironment(object):
>          if self.user_config:
>              self.user_config.close()
>
> +    def _home_npmrc(self, d):
> +        """Function to return user's HOME .npmrc file (or None if it
> doesn't exist)"""
> +        home_npmrc_file =3D None
> +        if d.getVar("BB_USE_HOME_NPMRC") =3D=3D "1":
> +            home_npmrc_file =3D os.path.join(os.environ.get("HOME"),
> ".npmrc")
> +            if not os.path.exists(home_npmrc_file):
> +                home_npmrc_file =3D None
> +                bb.warn("BB_USE_HOME_NPMRC flag is set, but NO valid
> .npmrc was detected - "\
> +                        "check that a valid .npmrc file exists in your
> HOME directory.")
> +            else:
> +                bb.warn("BB_USE_HOME_NPMRC flag is set and valid .npmrc
> detected - "\
> +                        "npm fetcher will now use the .npmrc file in the
> HOME directory.")
> +
> +        return home_npmrc_file
> +
>      def run(self, cmd, args=3DNone, configs=3DNone, workdir=3DNone):
>          """Run npm command in a controlled environment"""
>          with tempfile.TemporaryDirectory() as tmpdir:
>


Nice work! Only one remaining issue that I can see. I do not think you need
to
warn when there is no .npmrc present. That should enable you to simplify
your
logic a bit to something like this:

home_npmrc_file =3D os.path.join(os.environ.get("HOME"), ".npmrc")
if d.getVar("BB_USE_HOME_NPMRC") =3D=3D "1" and os.path.exists(home_npmrc_f=
ile):
   bb.warn(f"BB_USE_HOME_NPMRC flag set and valid .npmrc detected - "\
        "npm fetcher will use {home_npmrc_file}")
   return home_npmrc_file
return None

..Ch:W..


--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--0000000000003bf64a062f2d389b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">On Thu, Feb 27, 2025 at 2:34=E2=80=AFPM Eric Meyers &lt=
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
=C2=A0lib/bb/fetch2/npm.py | 21 +++++++++++++++++++++<br>
=C2=A01 file changed, 21 insertions(+)<br>
<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index c09f05044..2c7ed5340 100644<br>
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
@@ -103,6 +109,21 @@ class NpmEnvironment(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.user_config:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.user_config.close()<br=
>
<br>
+=C2=A0 =C2=A0 def _home_npmrc(self, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Function to return user&#39;=
s HOME .npmrc file (or None if it doesn&#39;t exist)&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 home_npmrc_file =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.getVar(&quot;BB_USE_HOME_NPMRC&quot;) =3D=
=3D &quot;1&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 home_npmrc_file =3D os.path.join=
(os.environ.get(&quot;HOME&quot;), &quot;.npmrc&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(home_npmrc=
_file):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 home_npmrc_file =
=3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;BB_U=
SE_HOME_NPMRC flag is set, but NO valid .npmrc was detected - &quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;check that a valid .npmrc file exists in your HOME directo=
ry.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;BB_U=
SE_HOME_NPMRC flag is set and valid .npmrc detected - &quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;npm fetcher will now use the .npmrc file in the HOME direc=
tory.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return home_npmrc_file<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def run(self, cmd, args=3DNone, configs=3DNone, workdir=
=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run npm command in a co=
ntrolled environment&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with tempfile.TemporaryDirectory() as tmp=
dir:<br>
</blockquote></div><div><br></div><div><br></div><div><div style=3D"font-fa=
mily:monospace" class=3D"gmail_default">Nice work! Only one remaining issue=
 that I can see. I do not think you need to</div><div style=3D"font-family:=
monospace" class=3D"gmail_default">warn when there is no .npmrc present. Th=
at should enable you to simplify your</div><div style=3D"font-family:monosp=
ace" class=3D"gmail_default">logic a bit to something like this:<br><br>hom=
e_npmrc_file =3D os.path.join(os.environ.get(&quot;HOME&quot;), &quot;.npmr=
c&quot;)</div><div style=3D"font-family:monospace" class=3D"gmail_default">=
if d.getVar(&quot;BB_USE_HOME_NPMRC&quot;) =3D=3D &quot;1&quot; and os.path=
.exists(home_npmrc_file):</div><div style=3D"font-family:monospace" class=
=3D"gmail_default">=C2=A0=C2=A0 bb.warn(f&quot;BB_USE_HOME_NPMRC flag set a=
nd valid .npmrc detected - &quot;\</div><div style=3D"font-family:monospace=
" class=3D"gmail_default">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;=
npm fetcher will use {home_npmrc_file}&quot;)</div><div style=3D"font-famil=
y:monospace" class=3D"gmail_default">=C2=A0=C2=A0 return home_npmrc_file</d=
iv><div style=3D"font-family:monospace" class=3D"gmail_default">return None=
</div></div><div><br></div><div><div style=3D"font-family:monospace" class=
=3D"gmail_default">..Ch:W..</div><br clear=3D"all"></div><br><span class=3D=
"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div><b><span style=3D"font-family:monospace">=C2=
=A0 Opinions expressed are my own. |<br>=C2=A0-----------------------------=
---|------ &quot;Perfection must be reached by degrees<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 she require=
s the slow hand of time.&quot;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Voltaire</span></b></div></div><=
/div></div>

--0000000000003bf64a062f2d389b--

