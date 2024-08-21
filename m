Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E95AC52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 11:20:03 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.17494.1724239199967223267
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Aug 2024 04:20:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=EpC1hYdw;
 spf=pass (domain: snapchat.com, ip: 209.85.128.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so50762035e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1724239198; x=1724843998; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yT/8dKygJgMxgUOI5uPZ3yZv5lQIF/thuKeBIAuhCpU=;
        b=EpC1hYdwwjkZp8IqaxB8/mwoJ6zlk6V4QH4/tRfoGr07j24Qzo4rBlw4IBTbpILujf
         7MuYVXgPEOXUXxN9bAuaYWf0fkJHvmuuUB+yby9LTQKms/K1FxhK4Hokm48+Bs6Qk1N/
         n3fqXJbU6qDURx5GdrZFiMumLrrYWrnFAYR1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239198; x=1724843998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yT/8dKygJgMxgUOI5uPZ3yZv5lQIF/thuKeBIAuhCpU=;
        b=R+RX6WrGeseEJbp3gD1fzCESbh+pQ51nihVLz1pif6RBkRtzZeWKOxcVAfDSfaSliO
         UO5D9pvtt3QVPAEJEaL502kvctOai30epFhOd5S929HwS4RjSpk8ncTALAbHj6OV82gi
         79dEt0n8h9UHJBKlJlrVyRolngMqiocm8Lh/ALSuE1kSNMEx6p/f8XjJk9sxp4Jm9Bfc
         vUKeXqqu2zvY/1nb51cAeWAOHbHJiVu51w9xcnMEH/eA6Nzci4rM8dexKw17DdOwPwOu
         d4a18xM6SR4mgjqyl713Hqm0RNXH7jTrGuyDxTeCyQVDmsI7wQWHFzWxwdllvVzxzz+c
         Cwkw==
X-Forwarded-Encrypted: i=1; AJvYcCWAMqNpDK2RiNF5n01tn6xV6yTaXrSeIjYnl+miil1g8tMBpYWN2cFAaCgXGG2TAwRFc0LjDtItmBdkbB35@lists.openembedded.org
X-Gm-Message-State: AOJu0YxUSpPViwdH+PboKHRaFpvh4dAaSZ9YCP82CdnysCYifCzxAzQY
	AjEx1LBNb1b0rUbV8/ee4bGcjOK/XfyJ94rxmpxfWd+TGfLjWmCXioSqkfy1VzV2/5hCQGuTcQ2
	o5XZnxYuUPVV/TfNiwHXF9nCi6gwtj33Un2PBwA==
X-Google-Smtp-Source: AGHT+IEcCzyyF7CDevfFxP3pNdvuP5ceQRw39iyINdI5lw18Ay4KSGM7dm94XCsDgDty77kWILA39nLsIlNck97Bv7A=
X-Received: by 2002:a05:6000:1acf:b0:368:5a8c:580b with SMTP id
 ffacd0b85a97d-372fd58ffa9mr1596045f8f.19.1724239198025; Wed, 21 Aug 2024
 04:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231127131147.1128798-1-charlie.johnston@loftorbital.com> <17EDBA14A1399376.18027@lists.openembedded.org>
In-Reply-To: <17EDBA14A1399376.18027@lists.openembedded.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 21 Aug 2024 13:19:47 +0200
Message-ID: <CAHUKmYaTcWnhQVcbD6GAnz5ymwUv3GwjfVx6d4kOyDCzrpCCQA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Ensure GCP fetcher checks if file
 exists before download.
To: ecordonnier@snap.com
Cc: Charlie Johnston <charlie.johnston@loftorbital.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e8a12e06202fb815"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 11:20:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16509

--000000000000e8a12e06202fb815
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"I think the intent of calling check_network_access in checkstatus() was to
error-out in case the error is disabled"
There is a typo: I meant "in case the network is disabled"

=C3=89tienne

On Wed, Aug 21, 2024 at 1:13=E2=80=AFPM Etienne Cordonnier via
lists.openembedded.org <ecordonnier=3Dsnap.com@lists.openembedded.org> wrot=
e:

> Hi,
> sorry, I'm testing this only now, long after it has been merged.
> The second addition of runfetchcmd inside the function checkstatus is not
> good in my opinion. It is redundant with the call
> to self.gcp_client.bucket(ud.host).blob(path).exists() which already
> returns True/False and does not throw an exception in case the file does
> not exist. Also the call to gsutil stat is much slower than using the
> python client to call exists() so we should not replace the call to
> exists() with a call to gsutil stat. I think the intent of calling
> check_network_access in checkstatus() was to error-out in case the error =
is
> disabled. We can rather change the string "gsutil stat" to something else
> to make the code more readable.
>
> In the download function, I also think it would be better to add a
> try/catch block around download_to_filename and throw a FetchError instea=
d
> of adding this extra slow [1] call to gsutil stat.
>
> [1]: 2x to 4x slower according to
> https://blog.gdeltproject.org/simple-experiments-in-gcs-ls-performance-co=
mparing-gcloud-python-the-gcs-json-api/#:~:text=3DUnsurprisingly%2C%20the%2=
0GCLOUD%20CLI%20is,library%20offering%202%2D4x%20speedup
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__blog.gdeltproject=
.org_simple-2Dexperiments-2Din-2Dgcs-2Dls-2Dperformance-2Dcomparing-2Dgclou=
d-2Dpython-2Dthe-2Dgcs-2Djson-2Dapi_-23-3A-7E-3Atext-3DUnsurprisingly-252C-=
2520the-2520GCLOUD-2520CLI-2520is-2Clibrary-2520offering-25202-252D4x-2520s=
peedup&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DFS9gvIUFPiKVDga08z06aINbaxjo5mnE=
40H4SNdvI43ssnr5oya_Wybo84xMWtdH&s=3DibgZhJYtKknknj7Hy4XRLEYowUfGpK2h0LsAyx=
nmZNs&e=3D>
>
>
> =C3=89tienne
>
> On Mon, Nov 27, 2023 at 7:14=E2=80=AFPM Charlie Johnston <
> charlie.johnston@loftorbital.com> wrote:
>
>> The GCP fetcher was calling bb.fetch2.check_network_access with
>> "gsutil stat" as the command, but then never actually ran that
>> command to check if the file exists. In cases where the file did
>> not exist in a gs:// premirror, this would lead to an unhandled
>> exception from do_fetch when the GCP python API tried to perform
>> the download.
>>
>> This change resolves that issue by adding a runfetchcmd to call
>> gsutil.
>>
>> Signed-off-by: Charlie Johnston <charlie.johnston@loftorbital.com>
>> ---
>>  lib/bb/fetch2/gcp.py | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
>> index f42c81fd..f40ce2ea 100644
>> --- a/lib/bb/fetch2/gcp.py
>> +++ b/lib/bb/fetch2/gcp.py
>> @@ -47,6 +47,7 @@ class GCP(FetchMethod):
>>              ud.basename =3D os.path.basename(ud.path)
>>
>>          ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
>> +        ud.basecmd =3D "gsutil stat"
>>
>>      def get_gcp_client(self):
>>          from google.cloud import storage
>> @@ -61,7 +62,8 @@ class GCP(FetchMethod):
>>          if self.gcp_client is None:
>>              self.get_gcp_client()
>>
>> -        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
>> +        bb.fetch2.check_network_access(d, ud.basecmd,
>> f"gs://{ud.host}{ud.path}")
>> +        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"),
>> d)
>>
>>          # Path sometimes has leading slash, so strip it
>>          path =3D ud.path.lstrip("/")
>> @@ -88,7 +90,8 @@ class GCP(FetchMethod):
>>          if self.gcp_client is None:
>>              self.get_gcp_client()
>>
>> -        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
>> +        bb.fetch2.check_network_access(d, ud.basecmd,
>> f"gs://{ud.host}{ud.path}")
>> +        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"),
>> d)
>>
>>          # Path sometimes has leading slash, so strip it
>>          path =3D ud.path.lstrip("/")
>> --
>> 2.39.2
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16508):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_16508&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DFS=
9gvIUFPiKVDga08z06aINbaxjo5mnE40H4SNdvI43ssnr5oya_Wybo84xMWtdH&s=3D9ve9G6Ox=
tTRxfAM7OJKYpbrpPAr0DtKiclOarHuYIMM&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_102834834_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DFS9gvIUFPiKVD=
ga08z06aINbaxjo5mnE40H4SNdvI43ssnr5oya_Wybo84xMWtdH&s=3DwIeCjd0uxsM__rakYQu=
Kwjp7vPi-fBe5s6ieUEf0rV4&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DFS9gvIUFPi=
KVDga08z06aINbaxjo5mnE40H4SNdvI43ssnr5oya_Wybo84xMWtdH&s=3DEGE4mfxQZBOZuuRa=
is6PCFAwDMGDIrGnieFa9dJa4ZQ&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000e8a12e06202fb815
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&quot;I think the intent of calling check_network_access i=
n checkstatus() was to error-out in case the error is disabled&quot;<br>The=
re is a typo: I meant &quot;in case the network is disabled&quot;<br><br>=
=C3=89tienne</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Aug 21, 2024 at 1:13=E2=80=AFPM Etienne Cordonnier via =
<a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;ec=
ordonnier=3D<a href=3D"mailto:snap.com@lists.openembedded.org">snap.com@lis=
ts.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr">Hi,<br>sorry, I&#39;m testing this only=
 now, long after it has been merged.<br>The second addition of runfetchcmd =
inside the function checkstatus is not good in my opinion. It is redundant =
with the call to=C2=A0self.gcp_client.bucket(ud.host).blob(path).exists() w=
hich already returns True/False and does not throw an exception in case the=
 file does not exist. Also the call to gsutil stat is much slower than usin=
g the python client to call exists() so we should not replace the call to e=
xists() with a call to gsutil stat. I think the intent of calling check_net=
work_access in checkstatus() was to error-out in case the error is disabled=
. We can rather change the string &quot;gsutil stat&quot; to something else=
 to make the code more readable.<br><br>In the download function, I also th=
ink it would be better to add a try/catch block around download_to_filename=
 and throw a FetchError instead of adding this extra slow [1] call to gsuti=
l stat.<br><br>[1]: 2x to 4x slower according to <a href=3D"https://urldefe=
nse.proofpoint.com/v2/url?u=3Dhttps-3A__blog.gdeltproject.org_simple-2Dexpe=
riments-2Din-2Dgcs-2Dls-2Dperformance-2Dcomparing-2Dgcloud-2Dpython-2Dthe-2=
Dgcs-2Djson-2Dapi_-23-3A-7E-3Atext-3DUnsurprisingly-252C-2520the-2520GCLOUD=
-2520CLI-2520is-2Clibrary-2520offering-25202-252D4x-2520speedup&amp;d=3DDwM=
FaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMI=
GRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFS9gvIUFPiKVDga08z06aINbaxjo5mnE40=
H4SNdvI43ssnr5oya_Wybo84xMWtdH&amp;s=3DibgZhJYtKknknj7Hy4XRLEYowUfGpK2h0LsA=
yxnmZNs&amp;e=3D" target=3D"_blank">https://blog.gdeltproject.org/simple-ex=
periments-in-gcs-ls-performance-comparing-gcloud-python-the-gcs-json-api/#:=
~:text=3DUnsurprisingly%2C%20the%20GCLOUD%20CLI%20is,library%20offering%202=
%2D4x%20speedup</a>=C2=A0<br><br>=C3=89tienne</div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 27, 2023 at 7:14=
=E2=80=AFPM Charlie Johnston &lt;<a href=3D"mailto:charlie.johnston@loftorb=
ital.com" target=3D"_blank">charlie.johnston@loftorbital.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The GCP fetcher=
 was calling bb.fetch2.check_network_access with<br>
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
<br>
<br>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16508): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_16508&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFS9gvIUFPiKVDga08z06aINb=
axjo5mnE40H4SNdvI43ssnr5oya_Wybo84xMWtdH&amp;s=3D9ve9G6OxtTRxfAM7OJKYpbrpPA=
r0DtKiclOarHuYIMM&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_16508&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3DFS9gvIUFPiKVDga08z06aINbaxjo5mnE40H4SNdvI43ssnr5oya_Wybo84xMWtdH&amp;s=
=3D9ve9G6OxtTRxfAM7OJKYpbrpPAr0DtKiclOarHuYIMM&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DFS9gvIUFPiKVDga08z06aINbaxjo5mnE40H4SNdvI43ssn=
r5oya_Wybo84xMWtdH&amp;s=3DwIeCjd0uxsM__rakYQuKwjp7vPi-fBe5s6ieUEf0rV4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_102834834_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFS9gvIUFPiKVDga08z06aINbaxjo5mn=
E40H4SNdvI43ssnr5oya_Wybo84xMWtdH&amp;s=3DwIeCjd0uxsM__rakYQuKwjp7vPi-fBe5s=
6ieUEf0rV4&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DFS9gvIUFPiKVDga08z06aINbaxjo5mnE40H4SNdvI43ssnr=
5oya_Wybo84xMWtdH&amp;s=3DEGE4mfxQZBOZuuRais6PCFAwDMGDIrGnieFa9dJa4ZQ&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DFS9gvIUFPiKVDga08z06aINbaxjo=
5mnE40H4SNdvI43ssnr5oya_Wybo84xMWtdH&amp;s=3DEGE4mfxQZBOZuuRais6PCFAwDMGDIr=
GnieFa9dJa4ZQ&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000e8a12e06202fb815--

