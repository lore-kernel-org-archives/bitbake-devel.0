Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80275C5320E
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 11:13:53 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.17408.1724238829678727810
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Aug 2024 04:13:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=dPTXBdvV;
 spf=pass (domain: snapchat.com, ip: 209.85.218.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8643a6bd55so248798566b.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1724238828; x=1724843628; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=udR+dy8eJz1QV0zxCCzxLnTKkAO33rHkBMw61T01dJk=;
        b=dPTXBdvVawcF8xa9gXvkhvOuYFY7k27T3U5t5c/mOqcoUJM+b+0hUauL9CAl2s/uIY
         u1l8udlJlVY2ItrYf4IYjfZMwWtWBPzAGddFLtQL4HxMAMtnQ70RlCAilI/PO9jA/V6l
         rp0sMsOx7B/+conSxsXSSYoVeUENPZUfs+ZSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238828; x=1724843628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udR+dy8eJz1QV0zxCCzxLnTKkAO33rHkBMw61T01dJk=;
        b=KKDQM89nx+gLxzZw0M+3sgB1geuCsHsJ7qptxW2d4BDxQUVnjY58/qxS63C4WVNFb3
         NIrXcn5/7aOpKzDBna0zsfVm8ZKBAuGv3xWe3/HE0Sap1hC4iJAxWnkQ50CaXhDZpDX8
         KUxWzsqTTad0HwKO7yb9ajpH4VTPrgP6aueQ/3JKROZqJscpnIAoL5ivf7CDI48q4Ew9
         rYRMxfk1eCYbwE/A6BuKYs+YcetmaBEQWddRWMxJ+F1laTxBmmPizSnqAw2i1HLf4DKk
         I6gP4okru/w24tqSzITARsnhA0bZmrxcpm2FdcdbW1TmHz7znDZANvCdI3Z6MOCZXXYt
         MUMA==
X-Gm-Message-State: AOJu0YyNwcydxvExQZPPQRX+iAJFemoIg+GHf+K0wIY1fBj4cbZCtf4r
	K+FngrUlY6q5Nt5+unj1yo5Le7Try4C70sZqO908PeAGEOPvVNyDAvWSWCLWGrQajDbhBi18pl7
	8IOaXp5b4SRdEB+SceoToQ40EIeZE6I9SzPPSMQ==
X-Google-Smtp-Source: AGHT+IE2keBUBLBv9OvGtXk0aXiUv8QZ+8FhLx5fqU6r+2KSiBJg9GOwL2rZFpgK1BSVmE8o+kIRXpD5lC9/hVZLBJM=
X-Received: by 2002:a17:907:1c1d:b0:a86:4649:28e6 with SMTP id
 a640c23a62f3a-a866f8acf7cmr129766566b.57.1724238827700; Wed, 21 Aug 2024
 04:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231127131147.1128798-1-charlie.johnston@loftorbital.com>
In-Reply-To: <20231127131147.1128798-1-charlie.johnston@loftorbital.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 21 Aug 2024 13:13:36 +0200
Message-ID: <CAHUKmYa560gcxf_0LMEKmAgag7a67ivyB0OQuM39Rwc22ZxGAQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Ensure GCP fetcher checks if file
 exists before download.
To: Charlie Johnston <charlie.johnston@loftorbital.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d58ef106202fa226"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 11:13:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16508

--000000000000d58ef106202fa226
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
sorry, I'm testing this only now, long after it has been merged.
The second addition of runfetchcmd inside the function checkstatus is not
good in my opinion. It is redundant with the call
to self.gcp_client.bucket(ud.host).blob(path).exists() which already
returns True/False and does not throw an exception in case the file does
not exist. Also the call to gsutil stat is much slower than using the
python client to call exists() so we should not replace the call to
exists() with a call to gsutil stat. I think the intent of calling
check_network_access in checkstatus() was to error-out in case the error is
disabled. We can rather change the string "gsutil stat" to something else
to make the code more readable.

In the download function, I also think it would be better to add a
try/catch block around download_to_filename and throw a FetchError instead
of adding this extra slow [1] call to gsutil stat.

[1]: 2x to 4x slower according to
https://blog.gdeltproject.org/simple-experiments-in-gcs-ls-performance-comp=
aring-gcloud-python-the-gcs-json-api/#:~:text=3DUnsurprisingly%2C%20the%20G=
CLOUD%20CLI%20is,library%20offering%202%2D4x%20speedup


=C3=89tienne

On Mon, Nov 27, 2023 at 7:14=E2=80=AFPM Charlie Johnston <
charlie.johnston@loftorbital.com> wrote:

> The GCP fetcher was calling bb.fetch2.check_network_access with
> "gsutil stat" as the command, but then never actually ran that
> command to check if the file exists. In cases where the file did
> not exist in a gs:// premirror, this would lead to an unhandled
> exception from do_fetch when the GCP python API tried to perform
> the download.
>
> This change resolves that issue by adding a runfetchcmd to call
> gsutil.
>
> Signed-off-by: Charlie Johnston <charlie.johnston@loftorbital.com>
> ---
>  lib/bb/fetch2/gcp.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
> index f42c81fd..f40ce2ea 100644
> --- a/lib/bb/fetch2/gcp.py
> +++ b/lib/bb/fetch2/gcp.py
> @@ -47,6 +47,7 @@ class GCP(FetchMethod):
>              ud.basename =3D os.path.basename(ud.path)
>
>          ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
> +        ud.basecmd =3D "gsutil stat"
>
>      def get_gcp_client(self):
>          from google.cloud import storage
> @@ -61,7 +62,8 @@ class GCP(FetchMethod):
>          if self.gcp_client is None:
>              self.get_gcp_client()
>
> -        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
> +        bb.fetch2.check_network_access(d, ud.basecmd,
> f"gs://{ud.host}{ud.path}")
> +        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), =
d)
>
>          # Path sometimes has leading slash, so strip it
>          path =3D ud.path.lstrip("/")
> @@ -88,7 +90,8 @@ class GCP(FetchMethod):
>          if self.gcp_client is None:
>              self.get_gcp_client()
>
> -        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
> +        bb.fetch2.check_network_access(d, ud.basecmd,
> f"gs://{ud.host}{ud.path}")
> +        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), =
d)
>
>          # Path sometimes has leading slash, so strip it
>          path =3D ud.path.lstrip("/")
> --
> 2.39.2
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15576):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_15576&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9t=
4tVhNJHm_a-j81RmtjjjGs-dK8z3mbf1k2KnTXY2QSV7n3ZFg3rZKGKnIzpw7L&s=3DUfc44GrQ=
XbX_l46qNc5Y5lxJcIMmKJ5bdnDVQW4EFu8&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_102834834_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9t4tVhNJHm_a-=
j81RmtjjjGs-dK8z3mbf1k2KnTXY2QSV7n3ZFg3rZKGKnIzpw7L&s=3D9hBl_2FJgpF4ZQnus1T=
TZe8pJVWYK-n-Wv8mBBTNYyc&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9t4tVhNJHm=
_a-j81RmtjjjGs-dK8z3mbf1k2KnTXY2QSV7n3ZFg3rZKGKnIzpw7L&s=3DgvGokflWmVxRC7Gw=
ObSJV_2_JvuDVfe-sh2jVMegqDU&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000d58ef106202fa226
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>sorry, I&#39;m testing this only now, long after it=
 has been merged.<br>The second addition of runfetchcmd inside the function=
 checkstatus is not good in my opinion. It is redundant with the call to=C2=
=A0self.gcp_client.bucket(ud.host).blob(path).exists() which already return=
s True/False and does not throw an exception in case the file does not exis=
t. Also the call to gsutil stat is much slower than using the python client=
 to call exists() so we should not replace the call to exists() with a call=
 to gsutil stat. I think the intent of calling check_network_access in chec=
kstatus() was to error-out in case the error is disabled. We can rather cha=
nge the string &quot;gsutil stat&quot; to something else to make the code m=
ore readable.<br><br>In the download function, I also think it would be bet=
ter to add a try/catch block around download_to_filename and throw a FetchE=
rror instead of adding this extra slow [1] call to gsutil stat.<br><br>[1]:=
 2x to 4x slower according to <a href=3D"https://blog.gdeltproject.org/simp=
le-experiments-in-gcs-ls-performance-comparing-gcloud-python-the-gcs-json-a=
pi/#:~:text=3DUnsurprisingly%2C%20the%20GCLOUD%20CLI%20is,library%20offerin=
g%202%2D4x%20speedup">https://blog.gdeltproject.org/simple-experiments-in-g=
cs-ls-performance-comparing-gcloud-python-the-gcs-json-api/#:~:text=3DUnsur=
prisingly%2C%20the%20GCLOUD%20CLI%20is,library%20offering%202%2D4x%20speedu=
p</a>=C2=A0<br><br>=C3=89tienne</div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Nov 27, 2023 at 7:14=E2=80=AFPM Char=
lie Johnston &lt;<a href=3D"mailto:charlie.johnston@loftorbital.com">charli=
e.johnston@loftorbital.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">The GCP fetcher was calling bb.fetch2.check_netwo=
rk_access with<br>
&quot;gsutil stat&quot; as the command, but then never actually ran that<br=
>
command to check if the file exists. In cases where the file did<br>
not exist in a gs:// premirror, this would lead to an unhandled<br>
exception from do_fetch when the GCP python API tried to perform<br>
the download.<br>
<br>
This change resolves that issue by adding a runfetchcmd to call<br>
gsutil.<br>
<br>
Signed-off-by: Charlie Johnston &lt;<a href=3D"mailto:charlie.johnston@loft=
orbital.com" target=3D"_blank">charlie.johnston@loftorbital.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/gcp.py | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py<br>
index f42c81fd..f40ce2ea 100644<br>
--- a/lib/bb/fetch2/gcp.py<br>
+++ b/lib/bb/fetch2/gcp.py<br>
@@ -47,6 +47,7 @@ class GCP(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basename =3D os.path.bas=
ename(ud.path)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.localfile =3D d.expand(urllib.parse.un=
quote(ud.basename))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D &quot;gsutil stat&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_gcp_client(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from google.cloud import storage<br>
@@ -61,7 +62,8 @@ class GCP(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.gcp_client is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get_gcp_client()<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.check_network_access(d, &quot;gsutil=
 stat&quot;, ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.check_network_access(d, ud.basecmd, =
f&quot;gs://{ud.host}{ud.path}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s %s&quot; % (ud.basecmd, f=
&quot;gs://{ud.host}{ud.path}&quot;), d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Path sometimes has leading slash, so st=
rip it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D ud.path.lstrip(&quot;/&quot;)<br=
>
@@ -88,7 +90,8 @@ class GCP(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.gcp_client is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get_gcp_client()<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.check_network_access(d, &quot;gsutil=
 stat&quot;, ud.url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fetch2.check_network_access(d, ud.basecmd, =
f&quot;gs://{ud.host}{ud.path}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s %s&quot; % (ud.basecmd, f=
&quot;gs://{ud.host}{ud.path}&quot;), d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Path sometimes has leading slash, so st=
rip it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D ud.path.lstrip(&quot;/&quot;)<br=
>
-- <br>
2.39.2<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15576): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_15576&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9t4tVhNJHm_a-j81RmtjjjGs=
-dK8z3mbf1k2KnTXY2QSV7n3ZFg3rZKGKnIzpw7L&amp;s=3DUfc44GrQXbX_l46qNc5Y5lxJcI=
MmKJ5bdnDVQW4EFu8&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_15576&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3D9t4tVhNJHm_a-j81RmtjjjGs-dK8z3mbf1k2KnTXY2QSV7n3ZFg3rZKGKnIzpw7L&amp;s=
=3DUfc44GrQXbX_l46qNc5Y5lxJcIMmKJ5bdnDVQW4EFu8&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D9t4tVhNJHm_a-j81RmtjjjGs-dK8z3mbf1k2KnTXY2QSV7=
n3ZFg3rZKGKnIzpw7L&amp;s=3D9hBl_2FJgpF4ZQnus1TTZe8pJVWYK-n-Wv8mBBTNYyc&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9t4tVhNJHm_a-j81RmtjjjGs-dK8z3m=
bf1k2KnTXY2QSV7n3ZFg3rZKGKnIzpw7L&amp;s=3D9hBl_2FJgpF4ZQnus1TTZe8pJVWYK-n-W=
v8mBBTNYyc&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3D9t4tVhNJHm_a-j81RmtjjjGs-dK8z3mbf1k2KnTXY2QSV7n=
3ZFg3rZKGKnIzpw7L&amp;s=3DgvGokflWmVxRC7GwObSJV_2_JvuDVfe-sh2jVMegqDU&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9t4tVhNJHm_a-j81RmtjjjGs-dK8=
z3mbf1k2KnTXY2QSV7n3ZFg3rZKGKnIzpw7L&amp;s=3DgvGokflWmVxRC7GwObSJV_2_JvuDVf=
e-sh2jVMegqDU&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000d58ef106202fa226--

