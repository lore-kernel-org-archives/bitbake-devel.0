Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F0C52D7C
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 11:31:02 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.11008.1724326257426347928
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Aug 2024 04:30:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=ShXfRNOZ;
 spf=pass (domain: snapchat.com, ip: 209.85.208.48, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso960049a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1724326256; x=1724931056; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mILfmMj9zExAoZEv9l+hV0IFHikIM4aAmKaL+5cNPA0=;
        b=ShXfRNOZHeva/cnTz9bUBefXXfbtNEXHpjy1fKHpQxHPdUJqGFvXBW11nxFz80Wwuo
         ewOPPIHOjcjDjs/YI4kJras+JuUmt4jWbu/1vzQBIPhYINODi2uxxUlaM4wO4vnLRkz5
         PwzIGtwarKCLi9Gk0vYNAisHkQ2XQn6h4JZnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326256; x=1724931056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mILfmMj9zExAoZEv9l+hV0IFHikIM4aAmKaL+5cNPA0=;
        b=Atke28awattThP7nwRkrwJVRhG8+itI8+W/MzaxQ3SA89AWxyE7gYDlzkgOzkYv4bh
         1SqTiCU/CDMeWEGU1sLV1qgdv3NKtDVog/9P4e9vgM9xlEFpSv5tIJtNs5mdMHx3ZZG3
         nvWieDvu4m4P8kHBIcEYTAtE7Ia+Pk5wfyyaZSw+vVpDbnW1HvBM7rE16XSyIGhNq8bq
         BoVpeIkAHIKLadpnnsrueVj5hGOTf2nRTeCgu+PfKgHIFXgPxraZk82b9wYilkakOEOo
         z6IN/GV8lv7RT/+to7CtmwvgPTYffz57tj/OHWLS0qvROO0LYcDOM/rOSpBaCTEvNLG1
         y92g==
X-Forwarded-Encrypted: i=1; AJvYcCXtflsy7zqpYWo9G1UVOppbUa+HktfrS0O4Tp6/chPCifdPQd2/qL4nb0OZCVZU7gbBsDE4P+iYe4sdK47C@lists.openembedded.org
X-Gm-Message-State: AOJu0YwGEar9A4O05i0xf3fEFeeJL5dCnF7Wu834TzmDOj2Xr1R6MivB
	1zkHWMXY4xy++wNkgVHmUD1oI8PYWzqJuI1ym9utQQYITXhxByNDL7X6XXvmdeX87XCDrosmi2K
	KwYgyVOLK+RIdj924iPMV6gWhct/P8rBsgKmXQQ==
X-Google-Smtp-Source: AGHT+IHfa3jok8onhsw7Nysr9vHNOCuvSKo9k8qER2swEEVk0gQQheb4Wjci/z4KZtuZ5hxY/WeqYfDfBWPHohHc63I=
X-Received: by 2002:a17:907:9404:b0:a7a:bb54:c858 with SMTP id
 a640c23a62f3a-a866f2aa121mr350581166b.26.1724326255419; Thu, 22 Aug 2024
 04:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHUKmYaTcWnhQVcbD6GAnz5ymwUv3GwjfVx6d4kOyDCzrpCCQA@mail.gmail.com>
 <28323.1724262081445932896@lists.openembedded.org> <17EE06B6AD411EA3.9439@lists.openembedded.org>
In-Reply-To: <17EE06B6AD411EA3.9439@lists.openembedded.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 22 Aug 2024 13:30:44 +0200
Message-ID: <CAHUKmYb+YSCixLXioM95SObLtVwsmAFFbOCuTKgpHkHS=hLNnA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Ensure GCP fetcher checks if file
 exists before download.
To: ecordonnier@snap.com
Cc: charlie.johnston@loftorbital.com, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ee8c8b062043fd2c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 11:31:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16516

--000000000000ee8c8b062043fd2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Is that approach acceptable, or is it better to bundle it into the
download_to_filename logic as you describe?"

-> If I understand correctly you added a call to exists() inside the
function download(), before doing the call to download_to_filename()? The
advantage of catching the exception thrown by download_to_filename instead
of adding an additional call to exists() is that it does one network
transaction instead of two in the case where the file really exists. I
think the performance is important there, because there are potentially
thousands of calls being done when using it as a fetch pre-mirror or
sstate-cache mirror. Maybe we need to catch more exceptions than only the
"NotFound" one however.

=C3=89tienne


On Thu, Aug 22, 2024 at 12:38=E2=80=AFPM Etienne Cordonnier via
lists.openembedded.org <ecordonnier=3Dsnap.com@lists.openembedded.org> wrot=
e:

> Hi Charlie,
> I tested this patch locally, but I'm using google cloud only as
> state-cache mirror, and I tested that it works when I try to call
> download() on a file which doesn't exist in the google cloud bucket. Does
> it work for your use-case?
>
> =C3=89tienne
>
> From 2d10a74b01e4b6d9a7b7f94e62784e345ec85f0a Mon Sep 17 00:00:00 2001
> From: Etienne Cordonnier <ecordonnier@snap.com>
> Date: Wed, 21 Aug 2024 13:34:34 +0200
> Subject: [PATCH] gcp.py: remove slow calls to gsutil stat
>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  bitbake/lib/bb/fetch2/gcp.py | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/gcp.py b/bitbake/lib/bb/fetch2/gcp.py
> index eb3e0c6a6bb..9ac2f752f6b 100644
> --- a/bitbake/lib/bb/fetch2/gcp.py
> +++ b/bitbake/lib/bb/fetch2/gcp.py
> @@ -19,11 +19,11 @@ Additionally, gsutil must also be installed.
>
>  import os
>  import bb
> +from google.api_core.exceptions import NotFound
>  import urllib.parse, urllib.error
>  from bb.fetch2 import FetchMethod
>  from bb.fetch2 import FetchError
>  from bb.fetch2 import logger
> -from bb.fetch2 import runfetchcmd
>
>  class GCP(FetchMethod):
>      """
> @@ -48,7 +48,6 @@ class GCP(FetchMethod):
>              ud.basename =3D os.path.basename(ud.path)
>
>          ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
> -        ud.basecmd =3D "gsutil stat"
>
>      def get_gcp_client(self):
>          from google.cloud import storage
> @@ -63,13 +62,15 @@ class GCP(FetchMethod):
>          if self.gcp_client is None:
>              self.get_gcp_client()
>
> -        bb.fetch2.check_network_access(d, ud.basecmd,
> f"gs://{ud.host}{ud.path}")
> -        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), =
d)
> +        bb.fetch2.check_network_access(d, "blob.download_to_filename",
> f"gs://{ud.host}{ud.path}")
>
>          # Path sometimes has leading slash, so strip it
>          path =3D ud.path.lstrip("/")
>          blob =3D self.gcp_client.bucket(ud.host).blob(path)
> -        blob.download_to_filename(ud.localpath)
> +        try:
> +            blob.download_to_filename(ud.localpath)
> +        except NotFound:
> +            raise FetchError("The GCP API threw a NotFound exception")
>
>          # Additional sanity checks copied from the wget class (although
> there
>          # are no known issues which mean these are required, treat the
> GCP API
> @@ -91,8 +92,7 @@ class GCP(FetchMethod):
>          if self.gcp_client is None:
>              self.get_gcp_client()
>
> -        bb.fetch2.check_network_access(d, ud.basecmd,
> f"gs://{ud.host}{ud.path}")
> -        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), =
d)
> +        bb.fetch2.check_network_access(d,
> "gcp_client.bucket(ud.host).blob(path).exists()",
> f"gs://{ud.host}{ud.path}")
>
>          # Path sometimes has leading slash, so strip it
>          path =3D ud.path.lstrip("/")
> --
> 2.43.0
>
>
> On Wed, Aug 21, 2024 at 7:41=E2=80=AFPM Charlie Johnston via
> lists.openembedded.org
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.openembedded=
.org&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNon=
VuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3JOLa=
caaSf0Ybjrzp2ypdUAKDjAqWArfIIg&s=3DdTQvc7buPp4YC9A0C-kX75ciZrOsa0UEcDEInebJ=
zFU&e=3D>
> <charlie.johnston=3Dloftorbital.com@lists.openembedded.org> wrote:
>
>> Hello,
>>
>> I actually ran into the slowness of gsutil stat recently and have been
>> testing a patch locally that does something similar to what you describe=
.
>> The difference is that I modified it to drop the runfetchcomd and raise =
a
>> FetchError if self.gcp_client.bucket(ud.host).blob(path).exists()  is
>> false.
>> Is that approach acceptable, or is it better to bundle it into the
>> download_to_filename logic as you describe?
>>
>> Regards,
>> Charlie
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16515):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_16515&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dhq=
GfVHbClPTscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&s=3DkCznyCMp=
R5CzmDe3KeIwDR5JM24ELmq8QZguI06JUuk&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_102834834_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DhqGfVHbClPTsc=
dMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&s=3Dtfd7JFbaM14OIscUydQ=
KKmlSYkXlw08lV8SfY0gN-_s&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DhqGfVHbClP=
TscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&s=3Dc9W4p9VYP2ytBvDF=
3f0gpr_0bPqKxzKbTjzalHAwGyQ&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ee8c8b062043fd2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&quot;Is that approach acceptable, or is it better to bund=
le it into the download_to_filename logic as you describe?&quot;<br><br>-&g=
t; If I understand correctly you added a call to exists() inside the functi=
on download(), before doing the call to download_to_filename()? The advanta=
ge of catching the exception thrown by download_to_filename instead of addi=
ng an additional call to exists() is that it does one network transaction i=
nstead of two in the case where the file really exists. I think the perform=
ance is important there, because there are potentially thousands of calls b=
eing done when using it as a fetch pre-mirror or sstate-cache mirror. Maybe=
 we need to catch more exceptions than only the &quot;NotFound&quot; one ho=
wever.<br><br>=C3=89tienne<br><br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 22, 2024 at 12:38=E2=80=AFPM =
Etienne Cordonnier via <a href=3D"http://lists.openembedded.org">lists.open=
embedded.org</a> &lt;ecordonnier=3D<a href=3D"mailto:snap.com@lists.openemb=
edded.org">snap.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Charlie,<br>I=
 tested this patch locally, but I&#39;m using google cloud only as state-ca=
che mirror,=C2=A0and I tested that it works when I try to call download() o=
n a file which doesn&#39;t exist in the google=C2=A0cloud bucket. Does it w=
ork for your use-case?<br><br>=C3=89tienne<br><br>From 2d10a74b01e4b6d9a7b7=
f94e62784e345ec85f0a Mon Sep 17 00:00:00 2001<br>From: Etienne Cordonnier &=
lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecordonnier@sn=
ap.com</a>&gt;<br>Date: Wed, 21 Aug 2024 13:34:34 +0200<br>Subject: [PATCH]=
 gcp.py: remove slow calls to gsutil stat<br><br>Signed-off-by: Etienne Cor=
donnier &lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank">ecord=
onnier@snap.com</a>&gt;<br>---<br>=C2=A0bitbake/lib/bb/fetch2/gcp.py | 14 +=
++++++-------<br>=C2=A01 file changed, 7 insertions(+), 7 deletions(-)<br><=
br>diff --git a/bitbake/lib/bb/fetch2/gcp.py b/bitbake/lib/bb/fetch2/gcp.py=
<br>index eb3e0c6a6bb..9ac2f752f6b 100644<br>--- a/bitbake/lib/bb/fetch2/gc=
p.py<br>+++ b/bitbake/lib/bb/fetch2/gcp.py<br>@@ -19,11 +19,11 @@ Additiona=
lly, gsutil must also be installed.<br>=C2=A0<br>=C2=A0import os<br>=C2=A0i=
mport bb<br>+from google.api_core.exceptions import NotFound<br>=C2=A0impor=
t urllib.parse, urllib.error<br>=C2=A0from bb.fetch2 import FetchMethod<br>=
=C2=A0from bb.fetch2 import FetchError<br>=C2=A0from bb.fetch2 import logge=
r<br>-from bb.fetch2 import runfetchcmd<br>=C2=A0<br>=C2=A0class GCP(FetchM=
ethod):<br>=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>@@ -48,7 +48,6 @@ clas=
s GCP(FetchMethod):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.b=
asename =3D os.path.basename(ud.path)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))<br>-=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basecmd =3D &quot;gsutil stat&quot;<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0def get_gcp_client(self):<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from google.cloud import storage<br>@@ -63,13 +62,15 @@ cl=
ass GCP(FetchMethod):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.gcp_clie=
nt is None:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get_gcp=
_client()<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.check_network=
_access(d, ud.basecmd, f&quot;gs://{ud.host}{ud.path}&quot;)<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0runfetchcmd(&quot;%s %s&quot; % (ud.basecmd, f&quot;gs:=
//{ud.host}{ud.path}&quot;), d)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.c=
heck_network_access(d, &quot;blob.download_to_filename&quot;, f&quot;gs://{=
ud.host}{ud.path}&quot;)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# P=
ath sometimes has leading slash, so strip it<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0path =3D ud.path.lstrip(&quot;/&quot;)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0blob =3D self.gcp_client.bucket(ud.host).blob(path)<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0blob.download_to_filename(ud.localpath)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0try:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blob.do=
wnload_to_filename(ud.localpath)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0except Not=
Found:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise FetchError(&quot=
;The GCP API threw a NotFound exception&quot;)<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0# Additional sanity checks copied from the wget class (=
although there<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# are no known issues w=
hich mean these are required, treat the GCP API<br>@@ -91,8 +92,7 @@ class =
GCP(FetchMethod):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.gcp_client i=
s None:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get_gcp_cli=
ent()<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.check_network_acc=
ess(d, ud.basecmd, f&quot;gs://{ud.host}{ud.path}&quot;)<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0runfetchcmd(&quot;%s %s&quot; % (ud.basecmd, f&quot;gs://{ud.=
host}{ud.path}&quot;), d)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.check_n=
etwork_access(d, &quot;gcp_client.bucket(ud.host).blob(path).exists()&quot;=
, f&quot;gs://{ud.host}{ud.path}&quot;)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0# Path sometimes has leading slash, so strip it<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0path =3D ud.path.lstrip(&quot;/&quot;)<br>-- <br>2.=
43.0<br><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Aug 21, 2024 at 7:41=E2=80=AFPM Charlie Johnston via <a=
 href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.openem=
bedded.org&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfd=
iw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DhqGfVHbClPTs=
cdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&amp;s=3DdTQvc7buPp4YC9=
A0C-kX75ciZrOsa0UEcDEInebJzFU&amp;e=3D" target=3D"_blank">lists.openembedde=
d.org</a> &lt;charlie.johnston=3D<a href=3D"mailto:loftorbital.com@lists.op=
enembedded.org" target=3D"_blank">loftorbital.com@lists.openembedded.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v>Hello,<br><br>I actually ran into the slowness of gsutil stat recently an=
d have been testing a patch locally that does something similar to what you=
 describe. The difference is that I modified it to drop the runfetchcomd an=
d raise a FetchError if <span style=3D"color:rgb(51,51,51);font-family:syst=
em-ui,&quot;Segoe UI&quot;,Roboto,&quot;Helvetica Neue&quot;,&quot;Noto San=
s&quot;,&quot;Liberation Sans&quot;,Arial,sans-serif,&quot;Apple Color Emoj=
i&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto C=
olor Emoji&quot;;font-size:16px;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;float:none;display:inline">self.gcp_client.bucket=
(ud.host).blob(path).exists()<span>=C2=A0</span></span> is false.</div>
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
<br>
<br>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16515): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_16515&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DhqGfVHbClPTscdMaVha_b7aC=
2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&amp;s=3DkCznyCMpR5CzmDe3KeIwDR5JM2=
4ELmq8QZguI06JUuk&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_16515&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&amp;s=
=3DkCznyCMpR5CzmDe3KeIwDR5JM24ELmq8QZguI06JUuk&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp=
2ypdUAKDjAqWArfIIg&amp;s=3Dtfd7JFbaM14OIscUydQKKmlSYkXlw08lV8SfY0gN-_s&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3J=
OLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&amp;s=3Dtfd7JFbaM14OIscUydQKKmlSYkXlw08lV=
8SfY0gN-_s&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2=
ypdUAKDjAqWArfIIg&amp;s=3Dc9W4p9VYP2ytBvDF3f0gpr_0bPqKxzKbTjzalHAwGyQ&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DhqGfVHbClPTscdMaVha_b7aC2hJi=
z3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&amp;s=3Dc9W4p9VYP2ytBvDF3f0gpr_0bPqKxz=
KbTjzalHAwGyQ&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000ee8c8b062043fd2c--

