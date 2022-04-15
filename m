Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E37CC433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:25:52 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web12.9009.1650038681678141258
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 09:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=fIInk6jX;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: raj.khem@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id y19so6735869qvk.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gQmgP+OC4sqemeArEZ3LDWWEtSZDZhAwwouwwm++Qo=;
        b=fIInk6jXYZslvHC3o8upwj7iG9XeThOrzAcJouW86DpCJsXipkphHCJIwXvuZnZtOR
         Qy41/AsLisnBGDM6K64PVcKljHML8L+MEROywKQjYjQqvzWiSvPYd5Eu49+UqggQc3SO
         FrS79vm/dX0pihbg740fqkWthYAB8we+cIOsQpwX7bGOhmdpCYyu+gTXdI6z2zkDTWLS
         0R9+LTj5yTNSF0hOTs1cPMoPyI7Zy6D+NaZIWLBn5Q8/r/nNdontoAM53WRWv/h36SL4
         f3Nr7BPT/Uz747Y8ttlrcsInM7UqUu3M0Jz+ud6cbEZ1YWqSFBtcj2UXKldOHmaDXBcZ
         yJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gQmgP+OC4sqemeArEZ3LDWWEtSZDZhAwwouwwm++Qo=;
        b=OOjA/Q7hj+nk/VngYSf4n3C5rw1nJoVNm342VC5MgGzoYJ2ceZqy/aYjIoFS3OUBwg
         iUVQyml67FpKo/J27l5Zjwfi8uPLTHBVdDmRlvKtSh5AVS7VmOm2uGKGzWK9T7KLMYx/
         vO+S/lcxWPvatLRKmkyUjACeWwltdF4t9bg5wTvThVepXt8TRFf10azJ6uplcXjaA5x4
         6a99kpwR3lAFoj4N1qbf0kLk6087QCf6rKqqxiIiB4Ila4SlSqxCqfv51XXobgH4wSRV
         iaBLvSevEyS6qLhUSM6/cD90tLNrWXgcaN0ePWyQNbm9J0ZCONxUCCVHw+UDPX94XCs9
         Q1Iw==
X-Gm-Message-State: AOAM531sqNj0hWegOZZVL2XiJkCAUtA3tT0yI5Qzuo2LXaseDFXT2q75
	rNW+OFI6F+yNVkk3dN+3fkAQCUNg0akBetbrdAY=
X-Google-Smtp-Source: 
 ABdhPJzM1PnqTdekjE6deX408jEb58dqSkD3ez7wQ2yBavTujDGYrocUR99cbAE0boBbQ172LcTEiaf/mVUd7VS9Y3c=
X-Received: by 2002:a05:6214:401d:b0:446:40bc:6687 with SMTP id
 kd29-20020a056214401d00b0044640bc6687mr769073qvb.110.1650038680567; Fri, 15
 Apr 2022 09:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133456.44233-1-matt@madison.systems>
In-Reply-To: <20220415133456.44233-1-matt@madison.systems>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 15 Apr 2022 09:04:29 -0700
Message-ID: 
 <CAMKF1srWYsAXw+HYMTBivYNSt_sME7JFoDP1+uVxSfM1SfW8rQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] providers: use local variable for
 packages_dynamic pattern
To: Matt Madison <matt@madison.systems>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000006bc3e005dcb391b5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:25:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13634

--0000000000006bc3e005dcb391b5
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 15, 2022 at 6:36 AM Matt Madison <matt@madison.systems> wrote:

> During parsing, Python raises
>
>    RuntimeError: dictionary changed size during iteration
>
> in getRuntimeProviders, if you happen to have a recipe
> with an explicit RDEPENDS on a dynamic package containing a '+'
> character, such as 'gtk+3-locale-en'.
>
> This is because we're using the modified pattern as the
> key into the packages_dynamic dict to append to rproviders,
> and since that key doesn't exist, the dict is getting modified
> to add a new, empty, entry for it. So even without the runtime
> error, we'd be generating an incorrect result.
>
> Fix this by using a local variable for modifying the pattern
> and using the original key to retrieve the value on a match.


Good fine I wonder if a test case would be good to have Added as well

>
>
> Signed-off-by: Matt Madison <matt@madison.systems>
> ---
>  lib/bb/providers.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/providers.py b/lib/bb/providers.py
> index 8c1c31a5..e11a4637 100644
> --- a/lib/bb/providers.py
> +++ b/lib/bb/providers.py
> @@ -396,8 +396,8 @@ def getRuntimeProviders(dataCache, rdepend):
>          return rproviders
>
>      # Only search dynamic packages if we can't find anything in other
> variables
> -    for pattern in dataCache.packages_dynamic:
> -        pattern = pattern.replace(r'+', r"\+")
> +    for pat_key in dataCache.packages_dynamic:
> +        pattern = pat_key.replace(r'+', r"\+")
>          if pattern in regexp_cache:
>              regexp = regexp_cache[pattern]
>          else:
> @@ -408,7 +408,7 @@ def getRuntimeProviders(dataCache, rdepend):
>                  raise
>              regexp_cache[pattern] = regexp
>          if regexp.match(rdepend):
> -            rproviders += dataCache.packages_dynamic[pattern]
> +            rproviders += dataCache.packages_dynamic[pat_key]
>              logger.debug("Assuming %s is a dynamic package, but it may
> not exist" % rdepend)
>
>      return rproviders
> --
> 2.32.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13633):
> https://lists.openembedded.org/g/bitbake-devel/message/13633
> Mute This Topic: https://lists.openembedded.org/mt/90486450/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> raj.khem@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000006bc3e005dcb391b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Apr 15, 2022 at 6:36 AM Matt Madison &lt;matt@madis=
on.systems&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">During parsin=
g, Python raises<br>
<br>
=C2=A0 =C2=A0RuntimeError: dictionary changed size during iteration<br>
<br>
in getRuntimeProviders, if you happen to have a recipe<br>
with an explicit RDEPENDS on a dynamic package containing a &#39;+&#39;<br>
character, such as &#39;gtk+3-locale-en&#39;.<br>
<br>
This is because we&#39;re using the modified pattern as the<br>
key into the packages_dynamic dict to append to rproviders,<br>
and since that key doesn&#39;t exist, the dict is getting modified<br>
to add a new, empty, entry for it. So even without the runtime<br>
error, we&#39;d be generating an incorrect result.<br>
<br>
Fix this by using a local variable for modifying the pattern<br>
and using the original key to retrieve the value on a match.</blockquote><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Good fine I wonder if a test ca=
se would be good to have Added as well=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex" dir=3D"auto"><br>
<br>
Signed-off-by: Matt Madison &lt;matt@madison.systems&gt;<br>
---<br>
=C2=A0lib/bb/providers.py | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/providers.py b/lib/bb/providers.py<br>
index 8c1c31a5..e11a4637 100644<br>
--- a/lib/bb/providers.py<br>
+++ b/lib/bb/providers.py<br>
@@ -396,8 +396,8 @@ def getRuntimeProviders(dataCache, rdepend):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rproviders<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Only search dynamic packages if we can&#39;t find any=
thing in other variables<br>
-=C2=A0 =C2=A0 for pattern in dataCache.packages_dynamic:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D pattern.replace(r&#39;+&#39;, r&qu=
ot;\+&quot;)<br>
+=C2=A0 =C2=A0 for pat_key in dataCache.packages_dynamic:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D pat_key.replace(r&#39;+&#39;, r&qu=
ot;\+&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if pattern in regexp_cache:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regexp =3D regexp_cache[pat=
tern]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
@@ -408,7 +408,7 @@ def getRuntimeProviders(dataCache, rdepend):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regexp_cache[pattern] =3D r=
egexp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if regexp.match(rdepend):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rproviders +=3D dataCache.packag=
es_dynamic[pattern]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rproviders +=3D dataCache.packag=
es_dynamic[pat_key]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(&quot;Assuming=
 %s is a dynamic package, but it may not exist&quot; % rdepend)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return rproviders<br>
-- <br>
2.32.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13633): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13633" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13633</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/90486450/1997=
914" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/90486450/1997914</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D"_bla=
nk">raj.khem@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000006bc3e005dcb391b5--

