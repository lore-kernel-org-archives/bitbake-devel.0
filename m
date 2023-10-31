Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5914C41535
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:28:11 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web11.187798.1698762485195232658
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dsqXwdyJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.177, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so4391875276.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698762484; x=1699367284; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L8hvhYJucUVAduDy14mLjtnQ52I9vxkhADQgsshHfsk=;
        b=dsqXwdyJG9lmNqr6qIuseT/i22lLwaPuFI1aHLL5z2fwmZQ8BSgFT/+us9Ou1cXhr7
         ZTu9cz9yT+cG3DQi6QsrN9e+ILjHx/9Y/k6s6HLF6VZhFYcHeU+cMPRFMftwKXTQ/pDn
         6k1Xym0PKsK6c+ydRRHkutatgbCPwV0nEUUoGW5IwCgH4IANf4uwT+13CgZxTTVGP00A
         O1Ht7LHzvSUGCcw/RBaE12gGBOgZk5I93TSb3AB7aoclgwZmFcC8Pe0yGwgoI/ojQYSq
         V7+YUuC7RFh/czqWC2KepoCxp7SyatpI1+uLC71z1IAzc9kAIn0TfDCifKWhzUKtKUAr
         s0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698762484; x=1699367284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8hvhYJucUVAduDy14mLjtnQ52I9vxkhADQgsshHfsk=;
        b=JiyJBXoPOcw+nfi5ObWv3wvfwoGlSOxWFB//O5cIb0dofm9dVXQmN1KmLwr6f/1jYE
         xpLL2ytURLYZtmBKwGcEi01XckCUCLkk2XWXhtL1UhSBcNu6jY82ejbWS2+EYl+H+x4x
         GfA97a+17zyfWC5rONBDMmqPrXPgmImxViwdenc9r8LboR1N/Y3KMSLiNpSQ9RAktfxT
         2QMG56lCvgmuZQrrqH8QdTsU/gNblUoI2pyGUZqCGmJloUT4ttUaOowCrm62wsj0Uf/O
         ULj6yyimIDWVHJ0mG3Pgo+Ybkk6w6G75+BKMK81OecutJfhP5WNpGBIWIPdxL4/gp58j
         P9nQ==
X-Gm-Message-State: AOJu0YwpdWazdM4V3LbcSJP5/9yqfeoQc6AawCUi/RKYmry6VS0X/LO2
	ucee88darw4fJu+6VClOcGqp2SB2gpiW0BpyitPBysG8yig=
X-Google-Smtp-Source: AGHT+IFgbh6+DPqZXFPsnnusfhOrGFcsEzd/Ex1GET6S8znFH2d7EPm+MZJZqzL3CLbBYJUNbfX2pRfTWIRXSQdSrpk=
X-Received: by 2002:a25:83c1:0:b0:d9c:7c97:7fcd with SMTP id
 v1-20020a2583c1000000b00d9c7c977fcdmr10171785ybm.27.1698762484219; Tue, 31
 Oct 2023 07:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com> <20231030195037.232912-2-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195037.232912-2-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 07:27:53 -0700
Message-ID: <CANx9H-DBH+GSL777XSVCRZf7uebo4kFRZ1hDAA_oJQu2Mp6C8g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/8] Toaster: Update orm.models to catch
 error ProcessLookupError
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000006e06b7060903f6b5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:28:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15339

--0000000000006e06b7060903f6b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/orm/models.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
> index 0d503a51..4f6d2147 100644
> --- a/lib/toaster/orm/models.py
> +++ b/lib/toaster/orm/models.py
> @@ -1389,9 +1389,6 @@ class Machine(models.Model):
>          return "Machine " + self.name + "(" + self.description + ")"
>
>
> -
> -
> -
>  class BitbakeVersion(models.Model):
>
>      name =3D models.CharField(max_length=3D32, unique =3D True)
> @@ -1838,6 +1835,7 @@ class LogMessage(models.Model):
>      def __str__(self):
>          return force_bytes('%s %s %s' % (self.get_level_display(),
> self.message, self.build))
>
> +
>

Why the extra new lines? Is this a PEP-8 thing?


>  def invalidate_cache(**kwargs):
>      from django.core.cache import cache
>      try:
> @@ -1845,6 +1843,7 @@ def invalidate_cache(**kwargs):
>      except Exception as e:
>        logger.warning("Problem with cache backend: Failed to clear cache:
> %s" % e)
>
> +
>  def signal_runbuilds():
>      """Send SIGUSR1 to runbuilds process"""
>      try:
> @@ -1853,6 +1852,9 @@ def signal_runbuilds():
>              os.kill(int(pidf.read()), SIGUSR1)
>      except FileNotFoundError:
>          logger.info("Stopping existing runbuilds: no current process
> found")
> +    except ProcessLookupError:
>

We should at a minimum be doing a logger.warning here.

ProcessLookupError here most likely means that a subprocess has failed or
been killed and we should not just be ignoring that.


> +        pass
> +
>
>  class Distro(models.Model):
>      search_allowed_fields =3D ["name", "description",
> "layer_version__layer__name"]
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15325):
> https://lists.openembedded.org/g/bitbake-devel/message/15325
> Mute This Topic: https://lists.openembedded.org/mt/102283456/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000006e06b7060903f6b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Alassane Yatta=
ra &lt;<a href=3D"mailto:alassane.yattara@savoirfairelinux.com" target=3D"_=
blank">alassane.yattara@savoirfairelinux.com</a>&gt;<br>
---<br>
=C2=A0lib/toaster/orm/models.py | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py<br>
index 0d503a51..4f6d2147 100644<br>
--- a/lib/toaster/orm/models.py<br>
+++ b/lib/toaster/orm/models.py<br>
@@ -1389,9 +1389,6 @@ class Machine(models.Model):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;Machine &quot; + <a href=3D"=
http://self.name" rel=3D"noreferrer" target=3D"_blank">self.name</a> + &quo=
t;(&quot; + self.description + &quot;)&quot;<br>
<br>
<br>
-<br>
-<br>
-<br>
=C2=A0class BitbakeVersion(models.Model):<br>
<br>
=C2=A0 =C2=A0 =C2=A0name =3D models.CharField(max_length=3D32, unique =3D T=
rue)<br>
@@ -1838,6 +1835,7 @@ class LogMessage(models.Model):<br>
=C2=A0 =C2=A0 =C2=A0def __str__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return force_bytes(&#39;%s %s %s&#39; % (=
self.get_level_display(), self.message, self.build))<br>
<br>
+<br></blockquote><div><br></div><div>Why the extra new lines? Is this a PE=
P-8 thing?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
=C2=A0def invalidate_cache(**kwargs):<br>
=C2=A0 =C2=A0 =C2=A0from django.core.cache import cache<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
@@ -1845,6 +1843,7 @@ def invalidate_cache(**kwargs):<br>
=C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Problem with cache backend:=
 Failed to clear cache: %s&quot; % e)<br>
<br>
+<br>
=C2=A0def signal_runbuilds():<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Send SIGUSR1 to runbuilds process&quo=
t;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
@@ -1853,6 +1852,9 @@ def signal_runbuilds():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.kill(int(pidf.read()), S=
IGUSR1)<br>
=C2=A0 =C2=A0 =C2=A0except FileNotFoundError:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://logger.info" rel=3D"nor=
eferrer" target=3D"_blank">logger.info</a>(&quot;Stopping existing runbuild=
s: no current process found&quot;)<br>
+=C2=A0 =C2=A0 except ProcessLookupError:<br></blockquote><div><br></div><d=
iv>We should at a minimum be doing a logger.warning here.</div><div><br></d=
iv><div>ProcessLookupError here most likely means that a subprocess has fai=
led or been killed and we should not just be ignoring that.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
+<br>
<br>
=C2=A0class Distro(models.Model):<br>
=C2=A0 =C2=A0 =C2=A0search_allowed_fields =3D [&quot;name&quot;, &quot;desc=
ription&quot;, &quot;layer_version__layer__name&quot;]<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15325): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15325" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15325</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102283456/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102283456/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000006e06b7060903f6b5--

