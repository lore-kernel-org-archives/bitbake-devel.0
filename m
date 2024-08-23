Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA0C52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 09:25:41 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.12483.1724405134977082675
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Aug 2024 02:25:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Ql2Ev/QI;
 spf=pass (domain: snapchat.com, ip: 209.85.167.45, mailfrom: ecordonnier@snapchat.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efdf02d13so2520054e87.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1724405133; x=1725009933; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4nFwFQLc9z6cJZFNi/HFjL//MHKBSuNG87cwkG9N9O4=;
        b=Ql2Ev/QIgQ/zGo7t/xYs1ogj6GI7ZML30Yc43baTI4b8zcOdHIqWlwHmVs8fN7YUCk
         zxJYq5eFozpUJXHuzLfrInRAh82d3mIUdM7IHZu2jxzeT1YObA89k0NYzWhTXMCvZ0go
         g98uVg4/bVVV5xdzK5C8BGLmvThHphxBf/eNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405133; x=1725009933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nFwFQLc9z6cJZFNi/HFjL//MHKBSuNG87cwkG9N9O4=;
        b=eieduHUBT1LFZFiS0Zlj1Yu032s6weDnogJBGEM4u9NKR6vydWSsBADHs6M4aof7Ih
         leTIzHjI8pcG9Txb3ObhRn504+GoyeyST3f7qvhZkakMCu7vWhVpD9gbhoNmYUszfY4R
         KnHobnmJ25usNnxvQN2ppqHA5qlV5ALpROnRIvgMaZLUT1kWvzjudpsQms4N3dIsOUfX
         touqDuSo8eI1r7Urx4WXNIam0iRTSVKqaLcFWL29B5qcKz31U+h5mnkhXGYqiDJnJbB3
         ZuX4qqKePXH8ME3b9rsKkDqYeUNDXicxfmcvGkG5e3SpPyvL0Wg/g0iv7KsiP5HZ6+yi
         +q/w==
X-Gm-Message-State: AOJu0YzbxobAMn90TC9yzs1XTy76rWWwFOjk0PJU7euR0euFQTn4Ce3W
	grmZeup+2vDfLng9eL+5j9XEoly6rKFqRq5qiU3WScXTWAejB4qm0CasMadu+hjILe81X2MfPRH
	jWs7kWgizK8ALlkTZMdoxDkMGOjd/w7NkRJ9lbA==
X-Google-Smtp-Source: AGHT+IF9ECgegULFQRfvk+/ysVKMLc6BnRKkgh6k/Bn5mRq8B3+jgFHWHIjE5KR2CJQtd+jT6aea0AjS3Q2nj38XPF0=
X-Received: by 2002:a05:6512:3188:b0:52e:932d:88ab with SMTP id
 2adb3069b0e04-5343884705cmr1678281e87.23.1724405132441; Fri, 23 Aug 2024
 02:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240823084108.1106312-1-ecordonnier@snap.com> <7c8eab24043fb9f05c2df8ebe4f55d724595c977.camel@linuxfoundation.org>
In-Reply-To: <7c8eab24043fb9f05c2df8ebe4f55d724595c977.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Fri, 23 Aug 2024 11:25:21 +0200
Message-ID: <CAHUKmYam_tsvzkf+RtWYv2RMA4pkAh0TV9QLPoP1fbwJWA7zwQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] gcp.py: remove slow calls to gsutil stat
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000005e935e0620565b3c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 09:25:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16521

--0000000000005e935e0620565b3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Makes sense, I had forgotten that the module can be included inside
functions.

=C3=89tienne

On Fri, Aug 23, 2024 at 11:14=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2024-08-23 at 10:41 +0200, Etienne Cordonnier via
> lists.openembedded.org wrote:
> > From: Etienne Cordonnier <ecordonnier@snap.com>
> >
> > The changes of 1ab1d36c0af6fc58a974106b61ff4d37da6cb229 added calls to
> "gsutil stat" to avoid unhandled exceptions, however:
> > - in the case of checkstatus() this is redundant with the call to
> self.gcp_client.bucket(ud.host).blob(path).exists() which already returns
> True/False
> >  and does not throw an exception in case the file does not exist.
> > - Also the call to gsutil stat is much slower than using the python
> client to call exists() so we should not replace the call to exists() wit=
h
> a call to gsutil stat.
> > - I think the intent of calling check_network_access in checkstatus()
> was to error-out in case the error is disabled. We can rather change the
> string "gsutil stat" to something else to make the code more readable.
> > - add a try/except block in download() instead of the extra call to
> gsutil
> >
> > Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> > ---
> >  lib/bb/fetch2/gcp.py | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
> > index eb3e0c6a6..9ac2f752f 100644
> > --- a/lib/bb/fetch2/gcp.py
> > +++ b/lib/bb/fetch2/gcp.py
> > @@ -19,11 +19,11 @@ Additionally, gsutil must also be installed.
> >
> >  import os
> >  import bb
> > +from google.api_core.exceptions import NotFound
> >  import urllib.parse, urllib.error
> >  from bb.fetch2 import FetchMethod
> >  from bb.fetch2 import FetchError
> >  from bb.fetch2 import logger
> > -from bb.fetch2 import runfetchcmd
> >
> >  class GCP(FetchMethod):
> >      """
>
> I put this into a testing branch and everything broke since the google
> module isn't present in most places. I've moved the import into the
> download method.
>
> Cheers,
>
> Richard
>

--0000000000005e935e0620565b3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Makes sense, I had forgotten that the module can be includ=
ed inside functions.<br><br>=C3=89tienne</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 23, 2024 at 11:14=E2=80=
=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.o=
rg">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Fri, 2024-08-23 at 10:41 +0200, Et=
ienne Cordonnier via <a href=3D"http://lists.openembedded.org" rel=3D"noref=
errer" target=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; The changes of 1ab1d36c0af6fc58a974106b61ff4d37da6cb229 added calls to=
 &quot;gsutil stat&quot; to avoid unhandled exceptions, however:<br>
&gt; - in the case of checkstatus() this is redundant with the call to self=
.gcp_client.bucket(ud.host).blob(path).exists() which already returns True/=
False<br>
&gt; =C2=A0and does not throw an exception in case the file does not exist.=
<br>
&gt; - Also the call to gsutil stat is much slower than using the python cl=
ient to call exists() so we should not replace the call to exists() with a =
call to gsutil stat.<br>
&gt; - I think the intent of calling check_network_access in checkstatus() =
was to error-out in case the error is disabled. We can rather change the st=
ring &quot;gsutil stat&quot; to something else to make the code more readab=
le.<br>
&gt; - add a try/except block in download() instead of the extra call to gs=
util<br>
&gt; <br>
&gt; Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@sn=
ap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/fetch2/gcp.py | 14 +++++++-------<br>
&gt; =C2=A01 file changed, 7 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py<br>
&gt; index eb3e0c6a6..9ac2f752f 100644<br>
&gt; --- a/lib/bb/fetch2/gcp.py<br>
&gt; +++ b/lib/bb/fetch2/gcp.py<br>
&gt; @@ -19,11 +19,11 @@ Additionally, gsutil must also be installed.<br>
&gt; =C2=A0<br>
&gt; =C2=A0import os<br>
&gt; =C2=A0import bb<br>
&gt; +from google.api_core.exceptions import NotFound<br>
&gt; =C2=A0import urllib.parse, urllib.error<br>
&gt; =C2=A0from bb.fetch2 import FetchMethod<br>
&gt; =C2=A0from bb.fetch2 import FetchError<br>
&gt; =C2=A0from bb.fetch2 import logger<br>
&gt; -from bb.fetch2 import runfetchcmd<br>
&gt; =C2=A0<br>
&gt; =C2=A0class GCP(FetchMethod):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &quot;&quot;&quot;<br>
<br>
I put this into a testing branch and everything broke since the google<br>
module isn&#39;t present in most places. I&#39;ve moved the import into the=
<br>
download method.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--0000000000005e935e0620565b3c--

