Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ACFCAC5B0
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 10:39:36 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.9505.1758710372307988443
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 03:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aMtajIED;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso10608476a12.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758710371; x=1759315171; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xDg6zz8E0RhGDldE1AMv8JKA1lQFr7Dei0DN5EMzWpo=;
        b=aMtajIEDUY2waT+IyqTF+rQkpBZyhNUlfI2Aou7MK3v4pnygrcGO9FYnVKP+pqcTP1
         Cw09B3YeXvsl8wdBZ4WVYh8X56B58uyfxESsU8WZSlkarY3CY8Lp9s4+oUl72KiRByHU
         zT4McnrBUFJzPH9KoYvshxUrlvOw5f+tBBrEPKAABemr/R+ZSqZMuR3koRyB4UYv6yZ8
         T6XYSa1bqMQl6p57ykgKxsjY/86NYU52za6qGokpY9yc0qRyGRWb959FATH4pfiv32Sw
         CSjUdBX8oTYyNTuM5WLOk+VEkWFALuMKG0qabexn7WXjYZT0rd16tGBCGaFqsoHCLCG2
         Nu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710371; x=1759315171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDg6zz8E0RhGDldE1AMv8JKA1lQFr7Dei0DN5EMzWpo=;
        b=Q5iAdju/bzbjJ/OYqxMEd53jeoBHgFKx8Ew22M9HdsHwaFkoUcirUIVdiM0LceE/Ia
         dIOi3/LJT7pHE9TfjRNLI1OD+QONfOkVmRFLOEvd7RzP8czSiG36AOXhACllareRPu0p
         lbKPYsZlXjsAWxnAUvAYr5q3tOIF2aFUZUh/9Vlu8RKkxd/zwxXy+vA0Rep0AYoKSeOw
         DyfMAl2Tveg/FTOE+LrCoB8J2yPFQkgh78lEOYPsLYHaoTSMXvw8MfyXLBV2Wi75Yqao
         9ueO8KJirkTuW9lIIxEWH/8WB5mCo2VsuWaXhISSu4vn3zGHNCwhWzba45LBY7q8m8HI
         savw==
X-Gm-Message-State: AOJu0Yzme3ulO2vSjHoipmxyPTQA1jW9UwokXotkar3VYxbA/eUg2ble
	SqrNQ6jJiqEW/INA3fKkHYijlSruuu5PmnRes9y7ve3Nqm3GCxkgQXejKiqY9PTS//YTQ8jbEFC
	XAODH7O27wPVY2Tc+CADvTqZu0r15uUI=
X-Gm-Gg: ASbGncs2DTnJwWAnIREqKSL4Bn6NVgSwQEiO3wQBxY6ypi7pQIfIuS3+Q2u4s7dSc8A
	Zq3wDrPlCLHhKbkPA5qcshHjl9WFWZDqgmcmakO5ieI120BX/h1U0+iTftM4AY/LBKi4XuQhpxC
	WNiRz4SoVps03YHd2w4hFfyPgQlxWtKt2jbMv7t/osbi2dqD1BJx/kO5N9hZ+BDhjUUjYjemFVY
	l3Fcw8e
X-Google-Smtp-Source: AGHT+IEXLJXaJXwd9Wq9bbMiwatuyHS4oIC8oNhDE5kC3FO+meWLz+B1upbvhixejWaoNImKDXmuRqiYJJDjP5OF3Xs=
X-Received: by 2002:a17:907:971d:b0:b2c:15aa:ff5b with SMTP id
 a640c23a62f3a-b3026c84e2dmr599804966b.11.1758710370459; Wed, 24 Sep 2025
 03:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <18683160554EF259.24570@lists.openembedded.org>
In-Reply-To: <18683160554EF259.24570@lists.openembedded.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 24 Sep 2025 11:39:19 +0100
X-Gm-Features: AS18NWD-SQVxgYNFToRXtRX-uxyUF8IfflORLS8S57tPnXdhfuKPaUyTM4NO7xk
Message-ID: <CANPvuRk2n7t9YHThXATOT+zD9DYrzV36rU4r+Ku50Wy9y9Q=7g@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] cooker: add support for more than one
 server in BB_HASHSERVE_UPSTREAM
To: quaresma.jose@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000e4e542063f89aa0a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 10:39:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18084

--000000000000e4e542063f89aa0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

With that we can have for example:

BB_HASHSERVE_UPSTREAM =3D "wss://hashserv.yoctoproject.org/ws
hashserv.yoctoproject.org:8686"

Jose

Jose Quaresma via lists.openembedded.org <quaresma.jose=3D
gmail.com@lists.openembedded.org> escreveu (quarta, 24/09/2025 =C3=A0(s) 11=
:32):

> From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
>
> Making the use of python websockets mandatory when connecting to hashserv=
e
> could
> create several difficulties for users, especially when the python-python
> is not
> available in the distribution used.
> So it will be better to have a list of servers where for example we can
> have a second fallback in case it is not possible to use the first one.
>
> If it is not possible to use any server from the specified list, this wil=
l
> cause a fatal error.
>
> Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
> ---
>  lib/bb/cooker.py | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index fb87368f1..976065622 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -312,21 +312,25 @@ class BBCooker:
>              # Create a new hash server bound to a unix domain socket
>              if not self.hashserv:
>                  dbfile =3D (self.data.getVar("PERSISTENT_DIR") or
> self.data.getVar("CACHE")) + "/hashserv.db"
> -                upstream =3D self.data.getVar("BB_HASHSERVE_UPSTREAM") o=
r
> None
> -                if upstream:
> -                    try:
> -                        with hashserv.create_client(upstream) as client:
> -                            client.ping()
> -                    except ImportError as e:
> -                        bb.fatal(""""Unable to use hash equivalence
> server at '%s' due to missing or incorrect python module:
> -%s
> -Please install the needed module on the build host, or use an environmen=
t
> containing it (e.g a pip venv or OpenEmbedded's buildtools tarball).
> -You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may
> result in significantly longer build times as bitbake will be unable to
> reuse prebuilt sstate artefacts."""
> -                                 % (upstream, repr(e)))
> -                    except ConnectionError as e:
> -                        bb.warn("Unable to connect to hash equivalence
> server at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
> -                                 % (upstream, repr(e)))
> -                        upstream =3D None
> +                hashserve_upstream_list =3D
> self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
> +                upstream =3D None
> +                if hashserve_upstream_list:
> +                    for hashserve_upstream in
> hashserve_upstream_list.split():
> +                        try:
> +                            with
> hashserv.create_client(hashserve_upstream) as client:
> +                                client.ping()
> +                                upstream =3D hashserve_upstream
> +                                break
> +                        except ImportError as e:
> +                            bb.warn("Unable to connect to hash
> equivalence server at '%s' due to missing or incorrect python module:\n%s=
"
> +                                    % (hashserve_upstream, repr(e)))
> +                        except ConnectionError as e:
> +                            bb.warn("Unable to connect to hash
> equivalence server at '%s':\n%s"
> +                                    % (hashserve_upstream, repr(e)))
> +
> +                if hashserve_upstream_list and not upstream:
> +                    bb.fatal("""Unable to use hash equivalence server:
> +    You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may
> result in significantly longer build times as bitbake will be unable to
> reuse prebuilt sstate artefacts.""")
>
>                  self.hashservaddr =3D "unix://%s/hashserve.sock" %
> self.data.getVar("TOPDIR")
>                  self.hashserv =3D hashserv.create_server(
> --
> 2.51.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18083):
> https://lists.openembedded.org/g/bitbake-devel/message/18083
> Mute This Topic: https://lists.openembedded.org/mt/115409539/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000e4e542063f89aa0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br>With that we can have for example:<b=
r><br>BB_HASHSERVE_UPSTREAM =3D &quot;wss://<a href=3D"http://hashserv.yoct=
oproject.org/ws">hashserv.yoctoproject.org/ws</a> <a href=3D"http://hashser=
v.yoctoproject.org:8686">hashserv.yoctoproject.org:8686</a>&quot;</div><div=
><br></div>Jose<div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">Jose Quaresma via <a href=3D"http://lis=
ts.openembedded.org">lists.openembedded.org</a> &lt;quaresma.jose=3D<a href=
=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.o=
rg</a>&gt; escreveu (quarta, 24/09/2025 =C3=A0(s) 11:32):<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">From: Jose Quaresma &lt;<a href=
=3D"mailto:jose.quaresma@oss.qualcomm.com" target=3D"_blank">jose.quaresma@=
oss.qualcomm.com</a>&gt;<br>
<br>
Making the use of python websockets mandatory when connecting to hashserve =
could<br>
create several difficulties for users, especially when the python-python is=
 not<br>
available in the distribution used.<br>
So it will be better to have a list of servers where for example we can<br>
have a second fallback in case it is not possible to use the first one.<br>
<br>
If it is not possible to use any server from the specified list, this will<=
br>
cause a fatal error.<br>
<br>
Signed-off-by: Jose Quaresma &lt;<a href=3D"mailto:jose.quaresma@oss.qualco=
mm.com" target=3D"_blank">jose.quaresma@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/cooker.py | 34 +++++++++++++++++++---------------<br>
=C2=A01 file changed, 19 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index fb87368f1..976065622 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -312,21 +312,25 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Create a new hash server =
bound to a unix domain socket<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.hashserv:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbfile =3D (s=
elf.data.getVar(&quot;PERSISTENT_DIR&quot;) or self.data.getVar(&quot;CACHE=
&quot;)) + &quot;/hashserv.db&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream =3D self.=
data.getVar(&quot;BB_HASHSERVE_UPSTREAM&quot;) or None<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if upstream:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 with hashserv.create_client(upstream) as client:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 client.ping()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
pt ImportError as e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bb.fatal(&quot;&quot;&quot;&quot;Unable to use hash equivalence =
server at &#39;%s&#39; due to missing or incorrect python module:<br>
-%s<br>
-Please install the needed module on the build host, or use an environment =
containing it (e.g a pip venv or OpenEmbedded&#39;s buildtools tarball).<br=
>
-You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result=
 in significantly longer build times as bitbake will be unable to reuse pre=
built sstate artefacts.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (upstream, repr(e)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
pt ConnectionError as e:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bb.warn(&quot;Unable to connect to hash equivalence server at &#=
39;%s&#39;, please correct or remove BB_HASHSERVE_UPSTREAM:\n%s&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (upstream, repr(e)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 upstream =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hashserve_upstream=
_list =3D self.data.getVar(&quot;BB_HASHSERVE_UPSTREAM&quot;) or None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream =3D None<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if hashserve_upstr=
eam_list:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
hashserve_upstream in hashserve_upstream_list.split():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 with hashserv.create_client(hashserve_upstream) as=
 client:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 client.ping()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream =3D hashserve_upstream<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 except ImportError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Unable to connect to hash equivalenc=
e server at &#39;%s&#39; due to missing or incorrect python module:\n%s&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (hashserve_upstream,=
 repr(e)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 except ConnectionError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Unable to connect to hash equivalenc=
e server at &#39;%s&#39;:\n%s&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (hashserve_upstream,=
 repr(e)))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if hashserve_upstr=
eam_list and not upstream:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.f=
atal(&quot;&quot;&quot;Unable to use hash equivalence server:<br>
+=C2=A0 =C2=A0 You can also remove the BB_HASHSERVE_UPSTREAM setting, but t=
his may result in significantly longer build times as bitbake will be unabl=
e to reuse prebuilt sstate artefacts.&quot;&quot;&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.hashserv=
addr =3D &quot;unix://%s/hashserve.sock&quot; % self.data.getVar(&quot;TOPD=
IR&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.hashserv=
 =3D hashserv.create_server(<br>
-- <br>
2.51.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18083): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18083" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18083</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/115409539/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/115409539/5052612</a><br>
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
div></div></div></div>

--000000000000e4e542063f89aa0a--

