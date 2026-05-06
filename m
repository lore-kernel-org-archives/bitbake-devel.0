Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA7CD343B
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 14:50:10 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20493.1778078999754239542
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 07:50:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=M2N9RzXs;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b93698bb57aso169937566b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 07:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778078998; cv=none;
        d=google.com; s=arc-20240605;
        b=BYTN55gjXz+OuU2cdY1ltEF3iPRgMZS2/kq/TsSuji2CQgoD7alDtrKTH/fIbBIEYe
         gkjIe/9eCt413CUroBEmt7Se1EkPiwT+uWg9a2gP/UISKFquQO2x9dMvOUGt7HC9h+5I
         /48OaWlri/HQXsm5vjI6xCk6N7oYrV9Edj/Xor8tMzPxp8sDGXniZjBLFlQOw3J1kO6N
         OauCGJH35FhFOliFtnFxlYr05DSGpSCHny6tqgeOjDW8TEFom6KO9XlRM3ofKbCRcn0U
         05KWO82c4QdP/KCYQTppwfnz0l52vO77db5tieRRtqCOM7+/40a0VEN5Fj9ziLy58KAG
         XFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K3XwcAoF87sCtvFWTNhQhfPe9e+WlPx8lMWJSLe5xVw=;
        fh=CXP6ezNhZ2dwV30j1TErAxvqUUUhI3me3DSdqP20/oA=;
        b=V5WoYw0tyNnYvEVMHnaAHVLJ6Cq25jKp9WgolW+Qmb5WpG2KwJRIn7XBx2bJEu/58Z
         J4YAWJoVE9atuhe22vK+5ctAqQl3bKgs1490JJ3q8ZcU7uD8piSJoxqIuyLfm9ZqMJYD
         vCJIRenNcx3MKrArmeHn3j0j/g0NosEYmXmESN/goGwrQ6hwblEVkSCgGYKwxyqsYcLo
         4LWlabO0f1cvkXKz9I9dXrwM7F+dODZKP+k6fPDhjglRdq2fkieXK+/WX08oWKX/AqEG
         DX961ZhiFKpa9AU8hYMvE6+mpoRMZLL5g7Tf3GSQFLggMTgOYbxGXPMYnbv9YGlqGrLa
         JFIA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778078998; x=1778683798; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K3XwcAoF87sCtvFWTNhQhfPe9e+WlPx8lMWJSLe5xVw=;
        b=M2N9RzXsPtJVZWRVsx4UonmxwbMrWpfL/tZPI7NHPceCs7AXSZXP283khqv1qbwHYp
         LyN4g4bJDjyWVAe9jtZ9SxwUlTbpgC3FUVSCEXNcdvyfMj/GzzHYLyxhlbr9Zhbl5Hav
         eRY47yNK9Ft5cnhLcGwKSx0neJ6Ul2gM1dsOg+4x+powhESsunzRzMJrjWr3/2GGuEAs
         vBwRWgIwEY/qreFvNRMbks/Ke2NG6lLMWhI5vBOVAv6BZNvuJuttiT0chOB2Nrcmb0gz
         va1BbL2z1C9BhAGn525SMQk1xAEJVTBG2+peqEzZp7qe8QwfrZUudnvipfcuPGnolyoZ
         Jeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078998; x=1778683798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3XwcAoF87sCtvFWTNhQhfPe9e+WlPx8lMWJSLe5xVw=;
        b=YAeWvVXaKXP96TCpK4AM+CIbS16rpc1RrNDfTfLdWRlYeFJpc+SORWPtShHoChj5d9
         pG5St/zldQzZeGeLt78uJsvBD4vNfUMZOdFvttoQrLW/wt+Ca5BvnsXQjC73kvIATG8h
         bylKfx2j3T49iKyXu4Awpn0DqOuGuWDW80/Mme9evTgQC7WL8+jjkJWp7UWTors2Bnuw
         RuN3chZOP/36MErZ/namYzWhtJTHqfGPlWakoTkotbyR5jJIgoG55rgfwohe5oaeT50a
         eawLBwiBtT6Ino3oZBj8ssMoziqbMJvkUSvRWY1yBGXMR7lMkvPz43Qargvs6bt0z2kD
         qhZw==
X-Gm-Message-State: AOJu0YwwYgkvR3+x0p+QKZY0mAH3GI7ijEVwu8bdGnPuBbI2CbZyx9UR
	fZ6TcBxHP9MxEFyiBPUe8Abh7gedWSGRfpC6uCxDYEI+6sYbftThJdO4b5sBdpwCNPwSf1ljKZH
	oQQtFbvx1po6jG42aleQ48RuM7gHITP7izA==
X-Gm-Gg: AeBDiet3wtMPwvzBVeUg3jaWHCTbKGHVGCsN9lFTZL+gVl/S4AwmScegMYi0m8fwAbT
	cVSw5/LULBcmWCukhlZBOpFcNh2QGqkaRDTtygke92dxhGdw7iZ2rBh2per+9ZTd10Os1uwkNeV
	0A15FoQa5u6aArRM/jhytbmIkTuodHP6KSlDj1ZY+O9RlCeHQQa7YqsQG+DpMeeSGZXWt16RGeW
	gqJxKi+SnfaP3h+y4HzowdCjZSJbIu7uwUq2VwSBLdTZBB23xMORPUIf6lvaoMDcok57Ew+2nZn
	ZaMYNdno1WDvzf0Fbu0bdoHkT4WCOZ/9B17pLqNn1ND+jejNlt3kdn5c6iRWAhoa/Lmp5oq8gMf
	ExNvi
X-Received: by 2002:a17:907:97c7:b0:b9e:8d2:1eb6 with SMTP id
 a640c23a62f3a-bc3d1854d5bmr384084666b.27.1778078997793; Wed, 06 May 2026
 07:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260506123755.628267-3-corentin.guillevic@smile.fr>
In-Reply-To: <20260506123755.628267-3-corentin.guillevic@smile.fr>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 6 May 2026 15:49:46 +0100
X-Gm-Features: AVHnY4JnUBu6XqAAzhyyKb7WVelpyn1AiVO8A73p5NsjU7eGo9_LyLXc4tWgGgU
Message-ID: <CANPvuRm-iYiu4MJ5YfO9VxEP-4Qxc8N5dq0-TQo9ay+UWhqtfQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] cooker: limit the execution of the
 hashequiv client/server ping
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000bd28a06512747fc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 14:50:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19450

--0000000000000bd28a06512747fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Corentin,

Corentin Guillevic via lists.openembedded.org <corentin.guillevic=3D
smile.fr@lists.openembedded.org> escreveu (quarta, 6/05/2026 =C3=A0(s) 13:4=
0):

> From: Corentin Guillevic <corentin.guillevic@smile.fr>
>
> The ping method is used to test the connection to the hash equivalence
> server.
> However, if the server is unavailable, the bitbake server has to wait
> several
> minutes for the system to terminate.
>
> While waiting for a response from the hash server, the bitbake server doe=
s
> not
> provide any feedback to the bitbake client. The latter then closes the
> link and
> fails with the error:
>
> Timeout while waiting for a reply from the bitbake server (60s at
> 09:50:15.377337)
>
> Adding a timeout to the ping step allows quicker action when a remote
> server is
> unavailable, and prevents disconnection of the client due to timeout.
> The default timeout is 10 seconds, but this can be set using the
> BB_HASHSERVE_UPSTREAM_TIMEOUT variable.
>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---
>
> Notes:
>     Changes in v3:
>     - Fix TypeError exception when BB_HASHSERVE_UPSTREAM_TIMEOUT is not
> defined
>
>  .../bitbake-user-manual-ref-variables.rst             | 11 +++++++++++
>  lib/bb/asyncrpc/client.py                             |  4 ++--
>  lib/bb/cooker.py                                      |  4 ++--
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 9824b58ef..cce03bc0c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -511,6 +511,17 @@ overview of their function and contents.
>
>           BB_HASHSERVE_UPSTREAM =3D "hashserv.yoctoproject.org:8686"
>
> +   :term:`BB_HASHSERVE_UPSTREAM_TIMEOUT`
> +      Specifies the duration (in seconds) for which BitBake waits for th=
e
> first
> +      response from the upstream Hash Equivalence server (specified by
> +      :term:`BB_HASHSERVE_UPSTREAM`).
> +
> +      This variable prevents BitBake from waiting too long for an
> unavailable server.
> +      If the time expires, the upstream Hash Equivalence server will be
> skipped for
> +      the build.
> +
> +      The default value is "10" (seconds).
> +
>     :term:`BB_INVALIDCONF`
>        Used in combination with the ``ConfigParsed`` event to trigger
>        re-parsing the base metadata (i.e. all the recipes). The
> diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> index 17b72033b..5e2505494 100644
> --- a/lib/bb/asyncrpc/client.py
> +++ b/lib/bb/asyncrpc/client.py
> @@ -199,8 +199,8 @@ class AsyncClient(object):
>          self.check_invoke_error(result)
>          return result
>
> -    async def ping(self):
> -        return await self.invoke({"ping": {}})
> +    async def ping(self, timeout=3DNone):
> +        return await asyncio.wait_for(self.invoke({"ping": {}}), timeout=
)
>
>      async def __aenter__(self):
>          return self
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 4b6ba3196..128cbaee9 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -342,7 +342,7 @@ according to
> https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".fo
>                  if upstream:
>                      try:
>                          with hashserv.create_client(upstream) as client:
> -                            client.ping()
> +
> client.ping(int(self.data.getVar("BB_HASHSERVE_UPSTREAM_TIMEOUT") or 10))
>                      except ImportError as e:
>                          bb.fatal(""""Unable to use hash equivalence
> server at '%s' due to missing or incorrect python module:
>  %s
> @@ -352,7 +352,7 @@ Please install the needed module on the build host, o=
r
> use an environment contai
>   - or set up pip venv
>  You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may
> result in significantly longer build times as bitbake will be unable to
> reuse prebuilt sstate artefacts."""
>                                   % (upstream, repr(e)))
> -                    except ConnectionError as e:
> +                    except (ConnectionError, TimeoutError) as e:
>                          bb.warn("Unable to connect to hash equivalence
> server at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
>

What about:

"Unable to connect to hash equivalence server at '%s' after '%s' seconds,
please correct or remove BB_HASHSERVE_UPSTREAM or increase the
BB_HASHSERVE_UPSTREAM_TIMEOUT:\n%s"

To raise awareness about the possible causes.

Jose

                                  % (upstream, repr(e)))
>                          upstream =3D None
> --
> 2.51.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19445):
> https://lists.openembedded.org/g/bitbake-devel/message/19445
> Mute This Topic: https://lists.openembedded.org/mt/119177877/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000000bd28a06512747fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Corentin,</div><div d=
ir=3D"ltr"><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">Corentin Guillevic via <a href=3D"http://lists.openembedded.org"=
 target=3D"_blank">lists.openembedded.org</a> &lt;corentin.guillevic=3D<a h=
ref=3D"mailto:smile.fr@lists.openembedded.org" target=3D"_blank">smile.fr@l=
ists.openembedded.org</a>&gt; escreveu (quarta, 6/05/2026 =C3=A0(s) 13:40):=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Corentin =
Guillevic &lt;<a href=3D"mailto:corentin.guillevic@smile.fr" target=3D"_bla=
nk">corentin.guillevic@smile.fr</a>&gt;<br>
<br>
The ping method is used to test the connection to the hash equivalence serv=
er.<br>
However, if the server is unavailable, the bitbake server has to wait sever=
al<br>
minutes for the system to terminate.<br>
<br>
While waiting for a response from the hash server, the bitbake server does =
not<br>
provide any feedback to the bitbake client. The latter then closes the link=
 and<br>
fails with the error:<br>
<br>
Timeout while waiting for a reply from the bitbake server (60s at 09:50:15.=
377337)<br>
<br>
Adding a timeout to the ping step allows quicker action when a remote serve=
r is<br>
unavailable, and prevents disconnection of the client due to timeout.<br>
The default timeout is 10 seconds, but this can be set using the<br>
BB_HASHSERVE_UPSTREAM_TIMEOUT variable.<br>
<br>
Signed-off-by: Corentin Guillevic &lt;<a href=3D"mailto:corentin.guillevic@=
smile.fr" target=3D"_blank">corentin.guillevic@smile.fr</a>&gt;<br>
---<br>
<br>
Notes:<br>
=C2=A0 =C2=A0 Changes in v3:<br>
=C2=A0 =C2=A0 - Fix TypeError exception when BB_HASHSERVE_UPSTREAM_TIMEOUT =
is not defined<br>
<br>
=C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 11 +++++++++++<br>
=C2=A0lib/bb/asyncrpc/client.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++-=
-<br>
=C2=A0lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++--<br>
=C2=A03 files changed, 15 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
index 9824b58ef..cce03bc0c 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
@@ -511,6 +511,17 @@ overview of their function and contents.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BB_HASHSERVE_UPSTREAM =3D &quot;<a href=
=3D"http://hashserv.yoctoproject.org:8686" rel=3D"noreferrer" target=3D"_bl=
ank">hashserv.yoctoproject.org:8686</a>&quot;<br>
<br>
+=C2=A0 =C2=A0:term:`BB_HASHSERVE_UPSTREAM_TIMEOUT`<br>
+=C2=A0 =C2=A0 =C2=A0 Specifies the duration (in seconds) for which BitBake=
 waits for the first<br>
+=C2=A0 =C2=A0 =C2=A0 response from the upstream Hash Equivalence server (s=
pecified by<br>
+=C2=A0 =C2=A0 =C2=A0 :term:`BB_HASHSERVE_UPSTREAM`).<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 This variable prevents BitBake from waiting too long =
for an unavailable server.<br>
+=C2=A0 =C2=A0 =C2=A0 If the time expires, the upstream Hash Equivalence se=
rver will be skipped for<br>
+=C2=A0 =C2=A0 =C2=A0 the build.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 The default value is &quot;10&quot; (seconds).<br>
+<br>
=C2=A0 =C2=A0 :term:`BB_INVALIDCONF`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Used in combination with the ``ConfigParsed`` ev=
ent to trigger<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0re-parsing the base metadata (i.e. all the recip=
es). The<br>
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py<br>
index 17b72033b..5e2505494 100644<br>
--- a/lib/bb/asyncrpc/client.py<br>
+++ b/lib/bb/asyncrpc/client.py<br>
@@ -199,8 +199,8 @@ class AsyncClient(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.check_invoke_error(result)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return result<br>
<br>
-=C2=A0 =C2=A0 async def ping(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return await self.invoke({&quot;ping&quot;: {}=
})<br>
+=C2=A0 =C2=A0 async def ping(self, timeout=3DNone):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return await asyncio.wait_for(self.invoke({&qu=
ot;ping&quot;: {}}), timeout)<br>
<br>
=C2=A0 =C2=A0 =C2=A0async def __aenter__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index 4b6ba3196..128cbaee9 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -342,7 +342,7 @@ according to <a href=3D"https://docs.yoctoproject.org/d=
ev-manual/hashequivserver.html" rel=3D"noreferrer" target=3D"_blank">https:=
//docs.yoctoproject.org/dev-manual/hashequivserver.html</a>&quot;&quot;&quo=
t;.fo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if upstream:<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0with hashserv.create_client(upstream) as client:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 client.ping()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 client.ping(int(self.data.getVar(&quot;BB_HASHSERV=
E_UPSTREAM_TIMEOUT&quot;) or 10))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0except ImportError as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bb.fatal(&quot;&quot;&quot;&quot;Unable to use hash equiva=
lence server at &#39;%s&#39; due to missing or incorrect python module:<br>
=C2=A0%s<br>
@@ -352,7 +352,7 @@ Please install the needed module on the build host, or =
use an environment contai<br>
=C2=A0 - or set up pip venv<br>
=C2=A0You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may r=
esult in significantly longer build times as bitbake will be unable to reus=
e prebuilt sstate artefacts.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (upstream, repr(e)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
pt ConnectionError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
pt (ConnectionError, TimeoutError) as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bb.warn(&quot;Unable to connect to hash equivalence server=
 at &#39;%s&#39;, please correct or remove BB_HASHSERVE_UPSTREAM:\n%s&quot;=
<br></blockquote><div><br></div><div>What about:</div><div><br></div><div>&=
quot;Unable to connect to hash equivalence server at &#39;%s&#39; after &#3=
9;%s&#39;=C2=A0seconds, please correct or remove BB_HASHSERVE_UPSTREAM or i=
ncrease=C2=A0the BB_HASHSERVE_UPSTREAM_TIMEOUT:\n%s&quot;</div><div><br></d=
iv><div>To raise awareness about the possible causes.</div><div><br></div><=
div>Jose</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (upstream, repr(e)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0upstream =3D None<br>
-- <br>
2.51.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19445): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19445" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19445</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/119177877/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/119177877/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>
</div>

--0000000000000bd28a06512747fc--

