Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2ADC433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 11:00:29 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.9087.1636628427584891429
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:00:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=SjAuqQI6;
 spf=pass (domain: gmail.com, ip: 209.85.167.46,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id br15so9472888lfb.9;
        Thu, 11 Nov 2021 03:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldP9RaTl2VU6lA/B6nNm7zjHyGCs4mAXKhdbs5ko7EY=;
        b=SjAuqQI6pq1iQm2POYTErpndXp60E0s5bBeySCAg4pnhw47lD5zmiCkn2oYh0+/oKi
         taqwLh+Rry40PNvOZiPmdX86NK8x9MQRA101HqvfRHg+gJPzAjmi9ySR/rgC8hx7dFOO
         HI6W/6MgfuGEIZ9a9G553XPPY9nKrqvUkcOA586EJtnzH1OfNpI0p8STZm8LeZEwGbaR
         +Bqv8jtJtO3CIWm8p1fy+RmghuEDEx+w0sWYdZT0xv1Dkz4TfMV5Jv0mLbxPT22RfpM6
         iKw5rXkyDTCWyNFmVKElaDqFwYSKQCG6Kpv0TmixsOHD5jGExeK0YULdDUtrPFghFACr
         6Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldP9RaTl2VU6lA/B6nNm7zjHyGCs4mAXKhdbs5ko7EY=;
        b=DqI2rm8cpUKM/9FMpjXJZSSyZN1loGL19cJRXImlA3wN3b48Oz3QZCHTO745V6RSdO
         bw9iG4+t2KT0ifyhZHTwKwjzwHu311WXQB/fyU10wdzFoYw4m7P14Jzel7IgGT1vVgSa
         KDlNc0X6EYorCgzfWS6CR7jYRXYcNPw6TMnnR7jkgZu/ihgYTOOaJD+NQMrUHSUbr/wj
         ztXUua2oVZQaCyRDscAGkhYIF/7iuRIwkzNT2HZGVUWNE9qhBdD7EvBuRRFn+UD1ecGk
         VZrnIPZH1tINMud1wuh1S8zACIDQI1bAgbGZdBQE1GsvWaj2ZcE9evs+10e5fsnMP6qo
         eM5g==
X-Gm-Message-State: AOAM531QcUphkYX5QGM5p2efQiAg9TeJfoqTCaYnh3AwqUMYWbc4ZveO
	GiEdlNac6CNlRuYJrmsBnhO90cTqYYnPpEyw9Cyidyaj28c=
X-Google-Smtp-Source: 
 ABdhPJxBo7DR31uUAcxkA6zrT6xI8NzB4CB+IBGcOAuomHJCXbTQ/UWmpXDKqWt019gZS2wUbyorsa9RgdWawujIZuc=
X-Received: by 2002:a05:6512:b21:: with SMTP id
 w33mr5811702lfu.447.1636628425708;
 Thu, 11 Nov 2021 03:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20211111102124.7661-1-jasper@fancydomain.eu>
In-Reply-To: <20211111102124.7661-1-jasper@fancydomain.eu>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 11 Nov 2021 11:00:03 +0000
Message-ID: 
 <CANPvuRmk3er1ZJXemR-MQc9k+uxWLOjdy3bZVQZqWv_VfVJvJw@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH v5 1/2] repo: Add recipe for
 2.17.3
To: jasper@fancydomain.eu
Cc: OE-core <openembedded-core@lists.openembedded.org>, martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com, bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Content-Type: multipart/alternative; boundary="000000000000f1993d05d0813fc4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 11:00:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13007

--000000000000f1993d05d0813fc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jasper Orschulko via lists.openembedded.org <jasper=3D
fancydomain.eu@lists.openembedded.org> escreveu no dia quinta, 11/11/2021
=C3=A0(s) 10:21:

> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>
> Add a recipe for repo 2.17.3, prerequisite for the repo fetcher.
>
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>  meta/conf/distro/include/maintainers.inc      |  1 +
>  .../0001-Set-REPO_REV-to-v2.17.3.patch        | 35 +++++++++++++++++++
>  .../repo/repo/0001-python3-shebang.patch      | 26 ++++++++++++++
>  meta/recipes-devtools/repo/repo_2.17.3.bb     | 28 +++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644
> meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>  create mode 100644
> meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
>  create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb
>
> diff --git a/meta/conf/distro/include/maintainers.inc
> b/meta/conf/distro/include/maintainers.inc
> index f3e0a75d56..58a0a9615f 100644
> --- a/meta/conf/distro/include/maintainers.inc
> +++ b/meta/conf/distro/include/maintainers.inc
> @@ -652,6 +652,7 @@ RECIPE_MAINTAINER:pn-quilt-native =3D "Robert Yang <
> liezhi.yang@windriver.com>"
>  RECIPE_MAINTAINER:pn-quota =3D "Anuj Mittal <anuj.mittal@intel.com>"
>  RECIPE_MAINTAINER:pn-re2c =3D "Khem Raj <raj.khem@gmail.com>"
>  RECIPE_MAINTAINER:pn-readline =3D "Hongxu Jia <hongxu.jia@windriver.com>=
"
> +RECIPE_MAINTAINER:pn-repo =3D "Jasper Orschulko <
> Jasper.Orschulko@iris-sensing.com>"
>  RECIPE_MAINTAINER:pn-resolvconf =3D "Chen Qi <Qi.Chen@windriver.com>"
>  RECIPE_MAINTAINER:pn-rgb =3D "Unassigned <unassigned@yoctoproject.org>"
>  RECIPE_MAINTAINER:pn-rpcbind =3D "Hongxu Jia <hongxu.jia@windriver.com>"
> diff --git
> a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.pat=
ch
> b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.pat=
ch
> new file mode 100644
> index 0000000000..285b1d3129
> --- /dev/null
> +++
> b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.pat=
ch
> @@ -0,0 +1,35 @@
> +From bdd2a528da59c28db8ae2986834926de7cebf3ab Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Thu, 4 Nov 2021 16:55:12 +0100
> +Subject: [PATCH] Set REPO_REV to v2.17.3
> +
> +repo is an unusual tool because it downloads all of its own Python modul=
es
> +using GPG-signed git tags, and stores those files as part of the project
> +that it is working with.
> +
> +So in order to have a reproducible repo installation within the project
> +folders, we hardcode the default REPO_REV to a SHA1 that corresponds to
> +the version of the recipe. REPO_REV can still be overwriten by the user,
> +by specifying the REPO_REV environment variable.
> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/repo b/repo
> +index b13e34c..31130e9 100755
> +--- a/repo
> ++++ b/repo
> +@@ -130,7 +130,7 @@ if not REPO_URL:
> +   REPO_URL =3D 'https://gerrit.googlesource.com/git-repo'
> + REPO_REV =3D os.environ.get('REPO_REV')
> + if not REPO_REV:
> +-  REPO_REV =3D 'stable'
> ++  REPO_REV =3D '11b30b91df1f0e03b53da970ec2588e85817bacc'
> +
> + # increment this whenever we make important changes to this script
> + VERSION =3D (2, 8)
> +--
> +2.33.1
> diff --git a/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
> b/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
> new file mode 100644
> index 0000000000..d3888c8bb2
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
> @@ -0,0 +1,26 @@
> +From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Tue, 14 Sep 2021 16:46:51 +0200
> +Subject: [PATCH] python3 shebang
> +
> +Yocto does not symlink from python to python3, thus change the shebang
> from
> +python to python3.
> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/repo b/repo
> +index b13e34c..205e0e5 100755
> +--- a/repo
> ++++ b/repo
> +@@ -1,4 +1,4 @@
> +-#!/usr/bin/env python
> ++#!/usr/bin/env python3
> + # -*- coding:utf-8 -*-
> + #
> + # Copyright (C) 2008 The Android Open Source Project
> +--
> +2.33.0
> diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb
> b/meta/recipes-devtools/repo/repo_2.17.3.bb
> new file mode 100644
> index 0000000000..cb0af89c09
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: MIT
> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
> +
> +SUMMARY =3D "Tool for managing many Git repositories"
> +DESCRIPTION =3D "Repo is a tool built on top of Git. Repo helps manage m=
any
> Git repositories, does the uploads to revision control systems, and
> automates parts of the development workflow."
> +HOMEPAGE =3D "https://android.googlesource.com/tools/repo"
> +SECTION =3D "console/utils"
> +
> +LICENSE =3D "Apache-2.0"
> +LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
> +
> +SRC_URI =3D "git://
> gerrit.googlesource.com/git-repo.git;protocol=3Dhttps;branch=3Dmain"
> +SRCREV =3D "11b30b91df1f0e03b53da970ec2588e85817bacc"
> +
> +SRC_URI +=3D "file://0001-python3-shebang.patch \
> +            file://0001-Set-REPO_REV-to-v2.17.3.patch"
>

I think we can replace the patch 0001-Set-REPO_REV-to-v2.17.3.patch with a
post function
and with it we can reuse the SRCREV of the recipe. Something like:

do_fix_rev(){
    sed -i "s/REPO_REV =3D 'stable'/REPO_REV =3D '${SRCREV}'" ${S}/repo
}

do_patch[postfuncs] +=3D "do_fix_rev"


> +
> +MIRRORS +=3D "git://gerrit.googlesource.com/git-repo.git git://
> github.com/GerritCodeReview/git-repo.git \n"
> +
> +S =3D "${WORKDIR}/git"
> +
> +do_install() {
> +       install -Dm 0755 ${WORKDIR}/git/repo ${D}${bindir}/repo
> +}
> +
> +RDEPENDS:${PN} =3D "python3"
>

repo uses git internally, so add it

RDEPENDS:${PN} =3D "python3 git"


> +
> +BBCLASSEXTEND =3D "native nativesdk"
> --
> 2.33.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13003):
> https://lists.openembedded.org/g/bitbake-devel/message/13003
> Mute This Topic: https://lists.openembedded.org/mt/86978419/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000f1993d05d0813fc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Jasper Orschulko via <a href=3D"http=
://lists.openembedded.org" target=3D"_blank">lists.openembedded.org</a> &lt=
;jasper=3D<a href=3D"mailto:fancydomain.eu@lists.openembedded.org" target=
=3D"_blank">fancydomain.eu@lists.openembedded.org</a>&gt; escreveu no dia q=
uinta, 11/11/2021 =C3=A0(s) 10:21:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orsc=
hulko@iris-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com=
</a>&gt;<br>
<br>
Add a recipe for repo 2.17.3, prerequisite for the repo fetcher.<br>
<br>
Signed-off-by: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris=
-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<b=
r>
---<br>
=C2=A0meta/conf/distro/include/maintainers.inc=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
=C2=A0.../0001-Set-REPO_REV-to-v2.17.3.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3=
5 +++++++++++++++++++<br>
=C2=A0.../repo/repo/0001-python3-shebang.patch=C2=A0 =C2=A0 =C2=A0 | 26 +++=
+++++++++++<br>
=C2=A0meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"n=
oreferrer" target=3D"_blank">repo_2.17.3.bb</a>=C2=A0 =C2=A0 =C2=A0| 28 +++=
++++++++++++<br>
=C2=A04 files changed, 90 insertions(+)<br>
=C2=A0create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-RE=
PO_REV-to-v2.17.3.patch<br>
=C2=A0create mode 100644 meta/recipes-devtools/repo/repo/0001-python3-sheba=
ng.patch<br>
=C2=A0create mode 100644 meta/recipes-devtools/repo/<a href=3D"http://repo_=
2.17.3.bb" rel=3D"noreferrer" target=3D"_blank">repo_2.17.3.bb</a><br>
<br>
diff --git a/meta/conf/distro/include/maintainers.inc b/meta/conf/distro/in=
clude/maintainers.inc<br>
index f3e0a75d56..58a0a9615f 100644<br>
--- a/meta/conf/distro/include/maintainers.inc<br>
+++ b/meta/conf/distro/include/maintainers.inc<br>
@@ -652,6 +652,7 @@ RECIPE_MAINTAINER:pn-quilt-native =3D &quot;Robert Yang=
 &lt;<a href=3D"mailto:liezhi.yang@windriver.com" target=3D"_blank">liezhi.=
yang@windriver.com</a>&gt;&quot;<br>
=C2=A0RECIPE_MAINTAINER:pn-quota =3D &quot;Anuj Mittal &lt;<a href=3D"mailt=
o:anuj.mittal@intel.com" target=3D"_blank">anuj.mittal@intel.com</a>&gt;&qu=
ot;<br>
=C2=A0RECIPE_MAINTAINER:pn-re2c =3D &quot;Khem Raj &lt;<a href=3D"mailto:ra=
j.khem@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt;&quot;<br>
=C2=A0RECIPE_MAINTAINER:pn-readline =3D &quot;Hongxu Jia &lt;<a href=3D"mai=
lto:hongxu.jia@windriver.com" target=3D"_blank">hongxu.jia@windriver.com</a=
>&gt;&quot;<br>
+RECIPE_MAINTAINER:pn-repo =3D &quot;Jasper Orschulko &lt;<a href=3D"mailto=
:Jasper.Orschulko@iris-sensing.com" target=3D"_blank">Jasper.Orschulko@iris=
-sensing.com</a>&gt;&quot;<br>
=C2=A0RECIPE_MAINTAINER:pn-resolvconf =3D &quot;Chen Qi &lt;<a href=3D"mail=
to:Qi.Chen@windriver.com" target=3D"_blank">Qi.Chen@windriver.com</a>&gt;&q=
uot;<br>
=C2=A0RECIPE_MAINTAINER:pn-rgb =3D &quot;Unassigned &lt;<a href=3D"mailto:u=
nassigned@yoctoproject.org" target=3D"_blank">unassigned@yoctoproject.org</=
a>&gt;&quot;<br>
=C2=A0RECIPE_MAINTAINER:pn-rpcbind =3D &quot;Hongxu Jia &lt;<a href=3D"mail=
to:hongxu.jia@windriver.com" target=3D"_blank">hongxu.jia@windriver.com</a>=
&gt;&quot;<br>
diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2=
.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v=
2.17.3.patch<br>
new file mode 100644<br>
index 0000000000..285b1d3129<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.p=
atch<br>
@@ -0,0 +1,35 @@<br>
+From bdd2a528da59c28db8ae2986834926de7cebf3ab Mon Sep 17 00:00:00 2001<br>
+From: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris-sensing=
.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<br>
+Date: Thu, 4 Nov 2021 16:55:12 +0100<br>
+Subject: [PATCH] Set REPO_REV to v2.17.3<br>
+<br>
+repo is an unusual tool because it downloads all of its own Python modules=
<br>
+using GPG-signed git tags, and stores those files as part of the project<b=
r>
+that it is working with.<br>
+<br>
+So in order to have a reproducible repo installation within the project<br=
>
+folders, we hardcode the default REPO_REV to a SHA1 that corresponds to<br=
>
+the version of the recipe. REPO_REV can still be overwriten by the user,<b=
r>
+by specifying the REPO_REV environment variable.<br>
+<br>
+Upstream-Status: Inappropriate [configuration]<br>
+Signed-off-by: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iri=
s-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<=
br>
+---<br>
+ repo | 2 +-<br>
+ 1 file changed, 1 insertion(+), 1 deletion(-)<br>
+<br>
+diff --git a/repo b/repo<br>
+index b13e34c..31130e9 100755<br>
+--- a/repo<br>
++++ b/repo<br>
+@@ -130,7 +130,7 @@ if not REPO_URL:<br>
+=C2=A0 =C2=A0REPO_URL =3D &#39;<a href=3D"https://gerrit.googlesource.com/=
git-repo" rel=3D"noreferrer" target=3D"_blank">https://gerrit.googlesource.=
com/git-repo</a>&#39;<br>
+ REPO_REV =3D os.environ.get(&#39;REPO_REV&#39;)<br>
+ if not REPO_REV:<br>
+-=C2=A0 REPO_REV =3D &#39;stable&#39;<br>
++=C2=A0 REPO_REV =3D &#39;11b30b91df1f0e03b53da970ec2588e85817bacc&#39;<br=
>
+ <br>
+ # increment this whenever we make important changes to this script<br>
+ VERSION =3D (2, 8)<br>
+-- <br>
+2.33.1<br>
diff --git a/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch b/m=
eta/recipes-devtools/repo/repo/0001-python3-shebang.patch<br>
new file mode 100644<br>
index 0000000000..d3888c8bb2<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch<br>
@@ -0,0 +1,26 @@<br>
+From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001<br>
+From: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris-sensing=
.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<br>
+Date: Tue, 14 Sep 2021 16:46:51 +0200<br>
+Subject: [PATCH] python3 shebang<br>
+<br>
+Yocto does not symlink from python to python3, thus change the shebang fro=
m<br>
+python to python3.<br>
+<br>
+Upstream-Status: Inappropriate [configuration]<br>
+Signed-off-by: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iri=
s-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<=
br>
+---<br>
+ repo | 2 +-<br>
+ 1 file changed, 1 insertion(+), 1 deletion(-)<br>
+<br>
+diff --git a/repo b/repo<br>
+index b13e34c..205e0e5 100755<br>
+--- a/repo<br>
++++ b/repo<br>
+@@ -1,4 +1,4 @@<br>
+-#!/usr/bin/env python<br>
++#!/usr/bin/env python3<br>
+ # -*- coding:utf-8 -*-<br>
+ #<br>
+ # Copyright (C) 2008 The Android Open Source Project<br>
+--<br>
+2.33.0<br>
diff --git a/meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" r=
el=3D"noreferrer" target=3D"_blank">repo_2.17.3.bb</a> b/meta/recipes-devto=
ols/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"noreferrer" target=3D"_bl=
ank">repo_2.17.3.bb</a><br>
new file mode 100644<br>
index 0000000000..cb0af89c09<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"n=
oreferrer" target=3D"_blank">repo_2.17.3.bb</a><br>
@@ -0,0 +1,28 @@<br>
+# SPDX-License-Identifier: MIT<br>
+# Copyright (C) 2021 iris-GmbH infrared &amp; intelligent sensors<br>
+<br>
+SUMMARY =3D &quot;Tool for managing many Git repositories&quot;<br>
+DESCRIPTION =3D &quot;Repo is a tool built on top of Git. Repo helps manag=
e many Git repositories, does the uploads to revision control systems, and =
automates parts of the development workflow.&quot;<br>
+HOMEPAGE =3D &quot;<a href=3D"https://android.googlesource.com/tools/repo"=
 rel=3D"noreferrer" target=3D"_blank">https://android.googlesource.com/tool=
s/repo</a>&quot;<br>
+SECTION =3D &quot;console/utils&quot;<br>
+<br>
+LICENSE =3D &quot;Apache-2.0&quot;<br>
+LIC_FILES_CHKSUM =3D &quot;file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3=
c6bd57&quot;<br>
+<br>
+SRC_URI =3D &quot;git://<a href=3D"http://gerrit.googlesource.com/git-repo=
.git;protocol=3Dhttps;branch=3Dmain" rel=3D"noreferrer" target=3D"_blank">g=
errit.googlesource.com/git-repo.git;protocol=3Dhttps;branch=3Dmain</a>&quot=
;<br>
+SRCREV =3D &quot;11b30b91df1f0e03b53da970ec2588e85817bacc&quot;<br>
+<br>
+SRC_URI +=3D &quot;file://0001-python3-shebang.patch \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://0001-Set-REPO_REV-to-v2.1=
7.3.patch&quot;<br></blockquote><div><br></div><div>I think we can replace =
the patch 0001-Set-REPO_REV-to-v2.17.3.patch with a post function</div><div=
>and with it we can reuse the SRCREV of the recipe. Something like:</div><d=
iv dir=3D"ltr"><br></div><div dir=3D"ltr">do_fix_rev(){<br>=C2=A0 =C2=A0 se=
d -i &quot;s/REPO_REV =3D &#39;stable&#39;/REPO_REV =3D &#39;${SRCREV}&#39;=
&quot; ${S}/repo<br>}<br><br>do_patch[postfuncs] +=3D &quot;do_fix_rev&quot=
;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+MIRRORS +=3D &quot;git://<a href=3D"http://gerrit.googlesource.com/git-rep=
o.git" rel=3D"noreferrer" target=3D"_blank">gerrit.googlesource.com/git-rep=
o.git</a> git://<a href=3D"http://github.com/GerritCodeReview/git-repo.git"=
 rel=3D"noreferrer" target=3D"_blank">github.com/GerritCodeReview/git-repo.=
git</a> \n&quot;<br>
+<br>
+S =3D &quot;${WORKDIR}/git&quot;<br>
+<br>
+do_install() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0install -Dm 0755 ${WORKDIR}/git/repo ${D}${bind=
ir}/repo<br>
+}<br>
+<br>
+RDEPENDS:${PN} =3D &quot;python3&quot;<br></blockquote><div><br></div><div=
>repo uses git internally, so add it</div><div><br></div><div>RDEPENDS:${PN=
} =3D &quot;python3 git&quot;<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+<br>
+BBCLASSEXTEND =3D &quot;native nativesdk&quot;<br>
-- <br>
2.33.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13003): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13003" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13003</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86978419/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86978419/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div=
></div></div>

--000000000000f1993d05d0813fc4--

