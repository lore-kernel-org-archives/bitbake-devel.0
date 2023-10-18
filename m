Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC7DCDB484
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 19:52:05 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web10.10920.1697658723826454247
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Oct 2023 12:52:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JFjYzsEN;
 spf=pass (domain: gmail.com, ip: 209.85.128.174, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7ac4c3666so88842127b3.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697658723; x=1698263523; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lv1JiKEdq/9sdrX9jlDNhWUHgNdwOJ4Z6Q76W/i3vWI=;
        b=JFjYzsENrb09P+R3nyf1sOwuEvpiJyYlL5+Kc00Sn5oCOH+E7XQx7Fu2PjzxGWk41C
         0IJUv2oRRH3FQiPbaNieXvtKrScaF8xGJfD1QqI4tOn2vipKPgfeZCHmON6MMxflEmwe
         nDmwoe8MCi2pyXVXiNi1iaAtZbuBklustljXa48MV1rnI7vlD1/yNGrsVl3yco6N+WQJ
         mp0lbjxxqAbuP2OczrF5ouR/uEzgiWxrcPHTMoOemx3mpx9d0gL5moK4RWnb7tQh4Ln4
         jIaHD8Pb5+CP0jojZ/XrEElwhAfj/Z8BK6qHSpaoAnwMiOKrk9+iGxa/xREGn/2Vqbqi
         PgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658723; x=1698263523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lv1JiKEdq/9sdrX9jlDNhWUHgNdwOJ4Z6Q76W/i3vWI=;
        b=G4rPF2/C0cdaAqanp5KHkAZ3c12piinXrI0YiFmxVDoUm0+joCiYWNskws4pEv2sLN
         ETix/rpNlLFCOhL8YReZZhvfFFpw7bublR4Sp+oKS3ZcYECMtCUzQCGfR7a9CbtL49cL
         qCH/Of6VuZeNn/X85cK+BUPE0300isF0sDFgkn2m72QmL/o86uxnfJodwhJR71zbwnAa
         YZYMuM4FWpYRqOtf0J2Ud3R94noSOJ42McMbTfpKemwAETvHciAAj22mFL9xhH84OobW
         Na+w8ZaqqgSH35LM3/RYXegwniN6qkCDGCoxYd5+A7LacUiW5+5nA3i5MCIyxXOtP9qX
         i5Qg==
X-Gm-Message-State: AOJu0YwYjgOPnKY6ATGKyTR0fJElAE+LSi+YseWdav4a/AZLWaYj37HL
	5QGl01IgfVSppd1OupLPxSDvXI6kLWVR83uF7smhUHAltHg=
X-Google-Smtp-Source: AGHT+IEK2NN4WVDWpjAUBWzatv6rBXqq14bYGkcQzo1pKK01ofu8qNNYznqxyPNzCs8BfNBz/rTThIKCnxyGsWsLiCk=
X-Received: by 2002:a05:690c:fc3:b0:59f:519e:3e9a with SMTP id
 dg3-20020a05690c0fc300b0059f519e3e9amr313284ywb.20.1697658722844; Wed, 18 Oct
 2023 12:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231018194605.2710214-1-marlon.rodriguez-garcia@savoirfairelinux.com>
In-Reply-To: <20231018194605.2710214-1-marlon.rodriguez-garcia@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Wed, 18 Oct 2023 12:51:51 -0700
Message-ID: <CANx9H-Df7sm427L8pB50CfraS_Grx6Sj_TG-jUXTX9Qw=N3S5A@mail.gmail.com>
Subject: Re: [Toaster] [PATCH] toaster: add tox.ini file to execute flake8 and
 test suite
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: toaster@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000200474060802f99e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 19:52:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15259

--000000000000200474060802f99e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you check if you are sending to both toaster and bitbake-devel lists at
the same time? otherwise I have a feeling we are going to miss some
communication.

On Wed, Oct 18, 2023 at 12:46=E2=80=AFPM Marlon Rodriguez Garcia <
marlon.rodriguez-garcia@savoirfairelinux.com> wrote:

> Added configuration file for tox https://tox.wiki/en/4.11.3/ that
> includes flake8 and the test suite.
>

We do not have tox in openembedded-core and I am reluctant to add a
specific tool, as it has a lot of dependencies. I am not aware of any other
python based tools that we author which have tox enabled.


> This file can be execute using the command 'tox tox.ini' and can be used
> in autobuilder.
>
> By adding flake8 to the validation of toaster the following aspects have
> to be take into consideration:
> Objective
> - To comply with PEP8 standards, we propose to utilize a linting
> tool(Flake8) that checks toaster's codebase for errors, styling issues an=
d
> complexity
>
> Ruleset
> - See complete list of rules : https://www.flake8rules.com/
>
> Assumptions
> - We are aware that not all Flake8 rules can be applied to current
> codebase (those determined to be more troublesome can be excluded).
> - The patches can be integrated gradually by sections and/or rules.
> - The tox.ini will include the execution of the test suite.
>
> Pros
> - Standardized codebase for future integrations.
> - Majority of the patches will be syntax modifications and not affecting
> application logic.
>
> Cons
> - Major refactor of the codebase.
>
> Signed-off-by: Marlon Rodriguez Garcia <
> marlon.rodriguez-garcia@savoirfairelinux.com>
> ---
>  lib/toaster/tox.ini | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 lib/toaster/tox.ini
>
> diff --git a/lib/toaster/tox.ini b/lib/toaster/tox.ini
> new file mode 100644
> index 00000000..bcdfdb4f
> --- /dev/null
> +++ b/lib/toaster/tox.ini
> @@ -0,0 +1,25 @@
> +[tox]
> +envlist =3D py310
> +skipsdist =3D True
> +toxworkdir =3D {env:TOX_WORKDIR:.tox}
> +passenv =3D *
> +
> +[testenv]
> +setenv =3D
> +    DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_test
> +    TOASTER_BUILDSERVER=3D1
> +    EVENTREPLAY_DIR=3D{toxinidir}/../../../build/
> +    BUILDDIR=3D{toxinidir}/../../../build/
> +commands =3D
> +    flake8
> +    python3 {toxinidir}/manage.py test tests.db tests.commands
> tests.builds tests.browser tests.functional tests.views
> +deps =3D
> +    -r ../../toaster-requirements.txt
> +    -r {toxinidir}/tests/toaster-tests-requirements.txt
> +    flake8
> +
> +[flake8]
> +ignore =3D E501, F403
> +
> +[testenv:chrome]
> +commands=3D{[testenv]commands} --splinter-webdriver=3Dchrome
> \ No newline at end of file
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5873):
> https://lists.yoctoproject.org/g/toaster/message/5873
> Mute This Topic: https://lists.yoctoproject.org/mt/102046799/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000200474060802f99e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Can you check if you are sending to both =
toaster and bitbake-devel lists at the same time? otherwise I have a feelin=
g we are going to miss some communication.</div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 18, 2023 at 12:46=E2=
=80=AFPM Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodriguez-gar=
cia@savoirfairelinux.com">marlon.rodriguez-garcia@savoirfairelinux.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Added=
 configuration file for tox <a href=3D"https://tox.wiki/en/4.11.3/" rel=3D"=
noreferrer" target=3D"_blank">https://tox.wiki/en/4.11.3/</a> that includes=
 flake8 and the test suite.<br></blockquote><div><br></div><div>We do not h=
ave tox in openembedded-core and I am reluctant to add a specific tool,=C2=
=A0as it has a lot of dependencies. I am not aware of any other python base=
d tools that we author which have tox enabled.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
This file can be execute using the command &#39;tox tox.ini&#39; and can be=
 used in autobuilder.<br>
<br>
By adding flake8 to the validation of toaster the following aspects have to=
 be take into consideration:<br>
Objective<br>
- To comply with PEP8 standards, we propose to utilize a linting tool(Flake=
8) that checks toaster&#39;s codebase for errors, styling issues and comple=
xity<br>
<br>
Ruleset<br>
- See complete list of rules : <a href=3D"https://www.flake8rules.com/" rel=
=3D"noreferrer" target=3D"_blank">https://www.flake8rules.com/</a><br>
<br>
Assumptions<br>
- We are aware that not all Flake8 rules can be applied to current codebase=
 (those determined to be more troublesome can be excluded).<br>
- The patches can be integrated gradually by sections and/or rules.<br>
- The tox.ini will include the execution of the test suite.<br>
<br>
Pros<br>
- Standardized codebase for future integrations.<br>
- Majority of the patches will be syntax modifications and not affecting ap=
plication logic.<br>
<br>
Cons<br>
- Major refactor of the codebase.<br>
<br>
Signed-off-by: Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodrigu=
ez-garcia@savoirfairelinux.com" target=3D"_blank">marlon.rodriguez-garcia@s=
avoirfairelinux.com</a>&gt;<br>
---<br>
=C2=A0lib/toaster/tox.ini | 25 +++++++++++++++++++++++++<br>
=C2=A01 file changed, 25 insertions(+)<br>
=C2=A0create mode 100644 lib/toaster/tox.ini<br>
<br>
diff --git a/lib/toaster/tox.ini b/lib/toaster/tox.ini<br>
new file mode 100644<br>
index 00000000..bcdfdb4f<br>
--- /dev/null<br>
+++ b/lib/toaster/tox.ini<br>
@@ -0,0 +1,25 @@<br>
+[tox]<br>
+envlist =3D py310<br>
+skipsdist =3D True<br>
+toxworkdir =3D {env:TOX_WORKDIR:.tox}<br>
+passenv =3D *<br>
+<br>
+[testenv]<br>
+setenv =3D<br>
+=C2=A0 =C2=A0 DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_test<br>
+=C2=A0 =C2=A0 TOASTER_BUILDSERVER=3D1<br>
+=C2=A0 =C2=A0 EVENTREPLAY_DIR=3D{toxinidir}/../../../build/<br>
+=C2=A0 =C2=A0 BUILDDIR=3D{toxinidir}/../../../build/<br>
+commands =3D<br>
+=C2=A0 =C2=A0 flake8<br>
+=C2=A0 =C2=A0 python3 {toxinidir}/manage.py test tests.db tests.commands t=
ests.builds tests.browser tests.functional tests.views<br>
+deps =3D <br>
+=C2=A0 =C2=A0 -r ../../toaster-requirements.txt<br>
+=C2=A0 =C2=A0 -r {toxinidir}/tests/toaster-tests-requirements.txt<br>
+=C2=A0 =C2=A0 flake8<br>
+<br>
+[flake8]<br>
+ignore =3D E501, F403<br>
+<br>
+[testenv:chrome]<br>
+commands=3D{[testenv]commands} --splinter-webdriver=3Dchrome<br>
\ No newline at end of file<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#5873): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/5873" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/5873</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/102046799/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/102046799/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000200474060802f99e--

