Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C2C282C6
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 18:09:05 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
 by mx.groups.io with SMTP id smtpd.web11.938.1740766141905936379
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 10:09:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=goIjIbzZ;
 spf=pass (domain: gmail.com, ip: 209.85.166.178, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so8849845ab.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 10:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740766141; x=1741370941; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OqiIGN8FzWpv3jKAdZsoWfatHH4U3wMTn7BHKHqsbTg=;
        b=goIjIbzZCEbJBEskDM9xU+s0BM9N1iUfvcFJNJgwf/6rL0QBh4qS/EaYa+Ebfvj/Wv
         SR/AWf8KtT2zQOyPkw9RW17a0XeZfU3cglXWvgoSpmDxKXqCio6rEAlLKVdAH+xUudSN
         9JHXgc5767nHu5js0CaMHCqJ4OqLio11lC4Jza1VugDXWak/BUrxT6oMwb1zYOfqN022
         B5/NKQ6vLUCl0bJGMFcXk2NURt0u8dQjK9gYORdi5xFa47Xj4yNq+JVPBfsrHktXT1eh
         tDbfwxyRfIKSIILfr8RzCup8BuZWdjDgr84HxCydiXpL9Vn0fPGUrM/+kN1E1HfFdK6Q
         ymXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740766141; x=1741370941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqiIGN8FzWpv3jKAdZsoWfatHH4U3wMTn7BHKHqsbTg=;
        b=qcA4YMpbtyzKEjCkF373gNlfDMBwEBKzIv0eM0WEV3Osfla1BPeIYw8rMdG8ZSVxBd
         mL7wKo53hOReaPkqxtjUjFzJPsPlxItUqOH/2M8M71I3RifaORopGJ1Edc4Q2dZDiaoS
         l+pCubwLCaRONEnshnV3pqmMX7I68tMkmJmIhzkNb2OQXjxpZeQEGVz5xoKh8Wt714IO
         k0IORCN42mtvPjNvnDm9l0hN/hUqVIQk0qTBpaAA5aRELWTmTN21sqBWPbQ0oc5kk/Ey
         f33TiiEVAvcV3c9rbnxkBtR8zNUEp/i7v3UmXE4mp+Jmca7ptLAxzNVDVxyWo7z/416k
         x98Q==
X-Gm-Message-State: AOJu0Yz4u2Wf6VDqGdzkjohfVVCwrfvKqOZeoTns7V4k2DwKsQEMS4x+
	1M951i1SYGw/vtpBswoCU3onY3DaDwdYx9n2RduXmNarkrXsEJ6HQj3Opc63w1HREt10r9h+OxS
	pAotIjeZFsIc7j4avzCJhiMZw3Bg=
X-Gm-Gg: ASbGnct6tzoH9v0VZBD8+GxovqSwiMkRECWoireXrwqwLhclT+JTG1aZ0GUYGxO0r2p
	MSHMxjV4N9+KCXjUVfUTFf/cHuAKhoT5jTxf1up292Z2oBrTFZZPSS1mIdSrBfdF9tR55pdkrav
	ROf3JsKbCq323K3ppYz2ntQLb2RDk/dV/J2SJI424=
X-Google-Smtp-Source: AGHT+IEiAteKKJR1JSdDK2uhUNraSY/j9qyrdiOyknr4HKedf9xvEQ94tgDFJUgfcH+pFvJrJUNfb5QwhRYSqo1Nuvk=
X-Received: by 2002:a05:6e02:548:b0:3d3:f4fc:a292 with SMTP id
 e9e14a558f8ab-3d3f4fca3bdmr6085145ab.12.1740766141132; Fri, 28 Feb 2025
 10:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20250228130137.400-1-eric.meyers@arthrex.com> <20250228130137.400-2-eric.meyers@arthrex.com>
In-Reply-To: <20250228130137.400-2-eric.meyers@arthrex.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Fri, 28 Feb 2025 10:08:44 -0800
X-Gm-Features: AQ5f1JofH03aheJyUpyJ6WkaFod8PS0s0NwLnh2rYLpDNJkkbgBw-MGJ9-iIAE8
Message-ID: <CAB=6tBTEkrFS6uftp=31=96Uebo26fB4KXWx+=pV+jmiqFUB2Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>
Content-Type: multipart/alternative; boundary="0000000000007abbf4062f37b3a5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 18:09:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17362

--0000000000007abbf4062f37b3a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:01=E2=80=AFAM Eric Meyers <eric.meyers15310@gmail=
.com>
wrote:

> Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
> Cc: Geoff Parker <geoffrey.parker@arthrex.com>
> Cc: Chuck Wolber <chuckwolber@gmail.com>
> ---
>  lib/bb/fetch2/npm.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index c09f05044..e469d6676 100644
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


Signed-off-by: Chuck Wolber <chuckwolber@gmail.com>

..Ch:W..

--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--0000000000007abbf4062f37b3a5
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
=C2=A0lib/bb/fetch2/npm.py | 15 +++++++++++++++<br>
=C2=A01 file changed, 15 insertions(+)<br>
<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index c09f05044..e469d6676 100644<br>
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
dir:<br>
</blockquote></div><div><br clear=3D"all"></div><br><div><span class=3D"gma=
il_default" style=3D"font-family:monospace">Signed-off-by: </span><span cla=
ss=3D"gmail_default" style=3D"font-family:monospace">Chuck Wolber &lt;<a hr=
ef=3D"mailto:chuckwolber@gmail.com">chuckwolber@gmail.com</a>&gt;</span></d=
iv><div><span class=3D"gmail_default" style=3D"font-family:monospace"><br><=
/span></div><div><span class=3D"gmail_default" style=3D"font-family:monospa=
ce">..Ch:W..</span></div><br><span class=3D"gmail_signature_prefix">-- </sp=
an><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><b>=
<span style=3D"font-family:monospace">=C2=A0 Opinions expressed are my own.=
 |<br>=C2=A0--------------------------------|------ &quot;Perfection must b=
e reached by degrees<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 she requires the slow hand of time.&quot;<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -Voltaire</span></b></div></div></div></div>

--0000000000007abbf4062f37b3a5--

