Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE8BC3DA4A
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 10:38:12 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.10376.1724323088508584035
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Aug 2024 03:38:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=XN8mm9bS;
 spf=pass (domain: snapchat.com, ip: 209.85.208.49, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so896765a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1724323087; x=1724927887; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2OIyeFPvLvEW8NqYN8Q9g+nSl/w5y35epYNQJ1hP8/o=;
        b=XN8mm9bSVSsBrXkSrCPORtHQWWN2V7J1+5RCDz6z5ILlxDQKxFjhqC6PGmxpzVvrqV
         HFFgPlyKX/0YDGWLNCtCbtZkSsWqfh3Wt8pM3MQjbxMk2SacDGuDOlyBC/ngS9UFVofy
         pNeCa90ZrL9tU/0xZi/DimyOg1YvqFn70Ri6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323087; x=1724927887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OIyeFPvLvEW8NqYN8Q9g+nSl/w5y35epYNQJ1hP8/o=;
        b=qOIRm/vj3PLe+McG0jRa0goEdAxwgPiDwVYmx7R2uBSuW3cVwuOQONQ+Q8IJxfYvD7
         Utk9NdU2J/gH0qE9ZLTRqgVTWhXVdR5/6bRdjl26xcF3lYdkC903+vUmnsOwj9/c0gTq
         Iq8vWE5Ei5rDxqqpCIFdFvJ9hEDusICTkwI4PbCCi9yNLgJ96BH5sbHMOL6Ij2z+Dca6
         /K0VG8D2XUf+Y0SG52aXgysU6Id4kHecipMjzXOXBym4D6+fNqmYKgU6H/3ein9Gx5Lm
         zqOOQR7gEMrDsYspT5QHY4vvcXI1SYjayXPh4nfqVMLjfdCLKY0MKPe9dohYel6CeBGW
         rGgg==
X-Gm-Message-State: AOJu0Yx2ZCPxF9Tf6Oqx2S5V9VbrwKyfTN3PgjWoemS/YqEPklXaeOYR
	zS+4XqLjcbZJnva2W9tVUL+TfSB8WgckfNglHmadvC/2sOR1Do9gWcmmU+3WONlF+wsLUHYZeAO
	3o0BDFGd+WPN2LTvlYehGBzsNzuhWEifWCgRuFQ==
X-Google-Smtp-Source: AGHT+IHqs6Fd8H+srE7agIWqvSzvgvOIcZGwtq3qET9QP20Y/enaF50enaGFT72YpXG6/Pr2FOCibTNmRsy2E2AVBGI=
X-Received: by 2002:a17:906:6a1a:b0:a86:7cd4:3c7d with SMTP id
 a640c23a62f3a-a867cd43d0emr341038966b.57.1724323086430; Thu, 22 Aug 2024
 03:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHUKmYaTcWnhQVcbD6GAnz5ymwUv3GwjfVx6d4kOyDCzrpCCQA@mail.gmail.com>
 <28323.1724262081445932896@lists.openembedded.org>
In-Reply-To: <28323.1724262081445932896@lists.openembedded.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 22 Aug 2024 12:37:54 +0200
Message-ID: <CAHUKmYbf_d5o3q35wnb0wKiphTz+m7jWv7W9yFc2TNQf1_88sw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Ensure GCP fetcher checks if file
 exists before download.
To: charlie.johnston@loftorbital.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000b9e24062043412e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 10:38:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16515

--0000000000000b9e24062043412e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie,
I tested this patch locally, but I'm using google cloud only as state-cache
mirror, and I tested that it works when I try to call download() on a file
which doesn't exist in the google cloud bucket. Does it work for your
use-case?

=C3=89tienne

From 2d10a74b01e4b6d9a7b7f94e62784e345ec85f0a Mon Sep 17 00:00:00 2001
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 21 Aug 2024 13:34:34 +0200
Subject: [PATCH] gcp.py: remove slow calls to gsutil stat

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 bitbake/lib/bb/fetch2/gcp.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gcp.py b/bitbake/lib/bb/fetch2/gcp.py
index eb3e0c6a6bb..9ac2f752f6b 100644
--- a/bitbake/lib/bb/fetch2/gcp.py
+++ b/bitbake/lib/bb/fetch2/gcp.py
@@ -19,11 +19,11 @@ Additionally, gsutil must also be installed.

 import os
 import bb
+from google.api_core.exceptions import NotFound
 import urllib.parse, urllib.error
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import logger
-from bb.fetch2 import runfetchcmd

 class GCP(FetchMethod):
     """
@@ -48,7 +48,6 @@ class GCP(FetchMethod):
             ud.basename =3D os.path.basename(ud.path)

         ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
-        ud.basecmd =3D "gsutil stat"

     def get_gcp_client(self):
         from google.cloud import storage
@@ -63,13 +62,15 @@ class GCP(FetchMethod):
         if self.gcp_client is None:
             self.get_gcp_client()

-        bb.fetch2.check_network_access(d, ud.basecmd,
f"gs://{ud.host}{ud.path}")
-        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), d)
+        bb.fetch2.check_network_access(d, "blob.download_to_filename",
f"gs://{ud.host}{ud.path}")

         # Path sometimes has leading slash, so strip it
         path =3D ud.path.lstrip("/")
         blob =3D self.gcp_client.bucket(ud.host).blob(path)
-        blob.download_to_filename(ud.localpath)
+        try:
+            blob.download_to_filename(ud.localpath)
+        except NotFound:
+            raise FetchError("The GCP API threw a NotFound exception")

         # Additional sanity checks copied from the wget class (although
there
         # are no known issues which mean these are required, treat the GCP
API
@@ -91,8 +92,7 @@ class GCP(FetchMethod):
         if self.gcp_client is None:
             self.get_gcp_client()

-        bb.fetch2.check_network_access(d, ud.basecmd,
f"gs://{ud.host}{ud.path}")
-        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), d)
+        bb.fetch2.check_network_access(d,
"gcp_client.bucket(ud.host).blob(path).exists()",
f"gs://{ud.host}{ud.path}")

         # Path sometimes has leading slash, so strip it
         path =3D ud.path.lstrip("/")
--=20
2.43.0


On Wed, Aug 21, 2024 at 7:41=E2=80=AFPM Charlie Johnston via lists.openembe=
dded.org
<charlie.johnston=3Dloftorbital.com@lists.openembedded.org> wrote:

> Hello,
>
> I actually ran into the slowness of gsutil stat recently and have been
> testing a patch locally that does something similar to what you describe.
> The difference is that I modified it to drop the runfetchcomd and raise a
> FetchError if self.gcp_client.bucket(ud.host).blob(path).exists()  is
> false.
> Is that approach acceptable, or is it better to bundle it into the
> download_to_filename logic as you describe?
>
> Regards,
> Charlie
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16511):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_16511&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DJ3=
DBa7sI3nkIKaTR4ZW8Uzsiw79t9J5oyNAVsmpkDi5jhASeIf4cW-N6xqgzM2YU&s=3DR--JKE0t=
hCYvjlCpXaIKlazUZYH3ZMJJ1rUCNzFm7V4&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_102834834_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DJ3DBa7sI3nkIK=
aTR4ZW8Uzsiw79t9J5oyNAVsmpkDi5jhASeIf4cW-N6xqgzM2YU&s=3DUNwFoBXsa4ppk3kZ6yA=
wXeHnH65UWUAqjeTetl_PXR4&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DJ3DBa7sI3n=
kIKaTR4ZW8Uzsiw79t9J5oyNAVsmpkDi5jhASeIf4cW-N6xqgzM2YU&s=3DDHpp2kG8zSDI-dEE=
XLyOpFUVkDqCiVbN-5U3EUfcO4Q&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000000b9e24062043412e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Charlie,<br>I tested this patch locally, but I&#39;m us=
ing google cloud only as state-cache mirror,=C2=A0and I tested that it work=
s when I try to call download() on a file which doesn&#39;t exist in the go=
ogle=C2=A0cloud bucket. Does it work for your use-case?<br><br>=C3=89tienne=
<br><br>From 2d10a74b01e4b6d9a7b7f94e62784e345ec85f0a Mon Sep 17 00:00:00 2=
001<br>From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com"=
>ecordonnier@snap.com</a>&gt;<br>Date: Wed, 21 Aug 2024 13:34:34 +0200<br>S=
ubject: [PATCH] gcp.py: remove slow calls to gsutil stat<br><br>Signed-off-=
by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com">ecordonn=
ier@snap.com</a>&gt;<br>---<br>=C2=A0bitbake/lib/bb/fetch2/gcp.py | 14 ++++=
+++-------<br>=C2=A01 file changed, 7 insertions(+), 7 deletions(-)<br><br>=
diff --git a/bitbake/lib/bb/fetch2/gcp.py b/bitbake/lib/bb/fetch2/gcp.py<br=
>index eb3e0c6a6bb..9ac2f752f6b 100644<br>--- a/bitbake/lib/bb/fetch2/gcp.p=
y<br>+++ b/bitbake/lib/bb/fetch2/gcp.py<br>@@ -19,11 +19,11 @@ Additionally=
, gsutil must also be installed.<br>=C2=A0<br>=C2=A0import os<br>=C2=A0impo=
rt bb<br>+from google.api_core.exceptions import NotFound<br>=C2=A0import u=
rllib.parse, urllib.error<br>=C2=A0from bb.fetch2 import FetchMethod<br>=C2=
=A0from bb.fetch2 import FetchError<br>=C2=A0from bb.fetch2 import logger<b=
r>-from bb.fetch2 import runfetchcmd<br>=C2=A0<br>=C2=A0class GCP(FetchMeth=
od):<br>=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>@@ -48,7 +48,6 @@ class G=
CP(FetchMethod):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.base=
name =3D os.path.basename(ud.path)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basecmd =3D &quot;gsutil stat&quot;<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0def get_gcp_client(self):<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from google.cloud import storage<br>@@ -63,13 +62,15 @@ class =
GCP(FetchMethod):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.gcp_client i=
s None:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get_gcp_cli=
ent()<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.check_network_acc=
ess(d, ud.basecmd, f&quot;gs://{ud.host}{ud.path}&quot;)<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0runfetchcmd(&quot;%s %s&quot; % (ud.basecmd, f&quot;gs://{ud.=
host}{ud.path}&quot;), d)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.check_n=
etwork_access(d, &quot;blob.download_to_filename&quot;, f&quot;gs://{ud.hos=
t}{ud.path}&quot;)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Path so=
metimes has leading slash, so strip it<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0path =3D ud.path.lstrip(&quot;/&quot;)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0blob =3D self.gcp_client.bucket(ud.host).blob(path)<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0blob.download_to_filename(ud.localpath)<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0try:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blob.downl=
oad_to_filename(ud.localpath)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0except NotFou=
nd:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise FetchError(&quot;Th=
e GCP API threw a NotFound exception&quot;)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0# Additional sanity checks copied from the wget class (alt=
hough there<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# are no known issues whic=
h mean these are required, treat the GCP API<br>@@ -91,8 +92,7 @@ class GCP=
(FetchMethod):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.gcp_client is N=
one:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get_gcp_client=
()<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.check_network_access=
(d, ud.basecmd, f&quot;gs://{ud.host}{ud.path}&quot;)<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0runfetchcmd(&quot;%s %s&quot; % (ud.basecmd, f&quot;gs://{ud.h=
ost}{ud.path}&quot;), d)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.check_ne=
twork_access(d, &quot;gcp_client.bucket(ud.host).blob(path).exists()&quot;,=
 f&quot;gs://{ud.host}{ud.path}&quot;)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0# Path sometimes has leading slash, so strip it<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0path =3D ud.path.lstrip(&quot;/&quot;)<br>-- <br>2.=
43.0<br><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Aug 21, 2024 at 7:41=E2=80=AFPM Charlie Johnston via <a=
 href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;char=
lie.johnston=3D<a href=3D"mailto:loftorbital.com@lists.openembedded.org">lo=
ftorbital.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div>Hello,<br><br>I actually ran into =
the slowness of gsutil stat recently and have been testing a patch locally =
that does something similar to what you describe. The difference is that I =
modified it to drop the runfetchcomd and raise a FetchError if <span style=
=3D"color:rgb(51,51,51);font-family:system-ui,&quot;Segoe UI&quot;,Roboto,&=
quot;Helvetica Neue&quot;,&quot;Noto Sans&quot;,&quot;Liberation Sans&quot;=
,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,=
&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;font-size:16px;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;float:non=
e;display:inline">self.gcp_client.bucket(ud.host).blob(path).exists()<span>=
=C2=A0</span></span> is false.</div>
<div>Is that approach acceptable, or is it better to bundle it into the <sp=
an style=3D"color:rgb(51,51,51);font-family:system-ui,&quot;Segoe UI&quot;,=
Roboto,&quot;Helvetica Neue&quot;,&quot;Noto Sans&quot;,&quot;Liberation Sa=
ns&quot;,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoj=
i&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;font-size:=
16px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;word-spacing:0px;white-space:normal;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">download_to_filename<span> logic as you describe?=
</span></span></div>
<div>=C2=A0</div>
<div><span style=3D"color:rgb(51,51,51);font-family:system-ui,&quot;Segoe U=
I&quot;,Roboto,&quot;Helvetica Neue&quot;,&quot;Noto Sans&quot;,&quot;Liber=
ation Sans&quot;,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe=
 UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;fo=
nt-size:16px;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;word-spacing:0px;white-space:normal;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial;float:none;display:inline"><span>Regards,</span></span></div>
<div><span style=3D"color:rgb(51,51,51);font-family:system-ui,&quot;Segoe U=
I&quot;,Roboto,&quot;Helvetica Neue&quot;,&quot;Noto Sans&quot;,&quot;Liber=
ation Sans&quot;,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe=
 UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;fo=
nt-size:16px;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;word-spacing:0px;white-space:normal;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial;float:none;display:inline"><span>Charlie</span></span></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16511): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_16511&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DJ3DBa7sI3nkIKaTR4ZW8Uzsi=
w79t9J5oyNAVsmpkDi5jhASeIf4cW-N6xqgzM2YU&amp;s=3DR--JKE0thCYvjlCpXaIKlazUZY=
H3ZMJJ1rUCNzFm7V4&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_16511&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3DJ3DBa7sI3nkIKaTR4ZW8Uzsiw79t9J5oyNAVsmpkDi5jhASeIf4cW-N6xqgzM2YU&amp;s=
=3DR--JKE0thCYvjlCpXaIKlazUZYH3ZMJJ1rUCNzFm7V4&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DJ3DBa7sI3nkIKaTR4ZW8Uzsiw79t9J5oyNAVsmpkDi5jhA=
SeIf4cW-N6xqgzM2YU&amp;s=3DUNwFoBXsa4ppk3kZ6yAwXeHnH65UWUAqjeTetl_PXR4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DJ3DBa7sI3nkIKaTR4ZW8Uzsiw79t9J5=
oyNAVsmpkDi5jhASeIf4cW-N6xqgzM2YU&amp;s=3DUNwFoBXsa4ppk3kZ6yAwXeHnH65UWUAqj=
eTetl_PXR4&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DJ3DBa7sI3nkIKaTR4ZW8Uzsiw79t9J5oyNAVsmpkDi5jhAS=
eIf4cW-N6xqgzM2YU&amp;s=3DDHpp2kG8zSDI-dEEXLyOpFUVkDqCiVbN-5U3EUfcO4Q&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DJ3DBa7sI3nkIKaTR4ZW8Uzsiw79t=
9J5oyNAVsmpkDi5jhASeIf4cW-N6xqgzM2YU&amp;s=3DDHpp2kG8zSDI-dEEXLyOpFUVkDqCiV=
bN-5U3EUfcO4Q&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000000b9e24062043412e--

