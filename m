Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D63C433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 12:23:42 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web09.44104.1636374221402464861
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 04:23:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=e+j9ujyo;
 spf=pass (domain: gmail.com, ip: 209.85.167.51,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id u11so35792125lfs.1;
        Mon, 08 Nov 2021 04:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQEpaG3DiRcD8epmB4eG5t53OmyuVxeDQfyQ9y8aZGA=;
        b=e+j9ujyo6zrHBBhKJucwaeFEjnG63K2VZ+Op4rm3h9uB/qVWArSaDFG2R6ARJF7bRk
         lHu1l9+ZjocSCUPscy2Q+ipadrwglNSimqbfFSyH9VD+1zIWbZn5Ex2BdKVL4TglpyIj
         n8ExRjegOD2AplsW9+q9vB0q8uP9AOpq1En+GXWwhLTZXS83kEePb1Y00hG1PnjIWhse
         lrBgvTk3RV+n3lcKdWqNVhxOCNavVEcZzhdY/ToXxYmjtK9CPoYSh6T9985lAVn5AYWM
         IsMZM7OlakBAIKfvm2GDa7w9fO4yaQGRKlojAVvlWJw7RG8G/W8RmwYwCbHB57i56mA7
         alFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQEpaG3DiRcD8epmB4eG5t53OmyuVxeDQfyQ9y8aZGA=;
        b=fn2mIV09weykosylybSXLNQ05D0vZunmQxFasshapHONx7wi1cY2MjGP5xx/cOIYP9
         g7+z0iWiI0qk3DoAwZh+3n/sx7YSJ+dA6+KocXIVtitholt9Y/nZYB1jF9S0eFR123z6
         kQ1jh/A1V2eVjY0CsXBBwZvQegi3ifJu/Z36JUI8tDB3cOsntzQED2MyZVd+F9dIJQ7g
         aqDP0houvD4yUF6xZZdtARR6hkiTZkIjZGKYQJsd+2pSLKXcZTPU4ubpwJIQ/QQO/gXj
         Pr2LMXhgpLW2O9bC4dG7R3WILDGlaodKh/zorIhoDvbUldff1HHINWGIBLvGhhPwnFdW
         6ebw==
X-Gm-Message-State: AOAM531CWtHodh+6AwQcYglw6hAGzaG1SIEHKQVdWW1fbZMq7xDBYKKl
	AR1hT41xjTEbhIpuFKUAYADxXx96ZAU5ERAUxTg=
X-Google-Smtp-Source: 
 ABdhPJx6gu6+obGUyvwZrCetmhSZjXAue04VZXwZS4v4NVtOhWDLU8j0tXLc447lj9xD39B6EH1evDt3EwOcEwFKO4c=
X-Received: by 2002:a05:6512:b21:: with SMTP id
 w33mr70410789lfu.447.1636374219666;
 Mon, 08 Nov 2021 04:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20211108115842.15164-1-jasper@fancydomain.eu>
In-Reply-To: <20211108115842.15164-1-jasper@fancydomain.eu>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 8 Nov 2021 12:23:28 +0000
Message-ID: 
 <CANPvuR=C3WRD+8qTeAd4=F5jiPzPBWHLw_g6Ay3S_QBoGPQYEg@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH v3 1/2] repo: Add recipe for
 2.17.3
To: jasper@fancydomain.eu
Cc: OE-core <openembedded-core@lists.openembedded.org>, martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com, bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Content-Type: multipart/alternative; boundary="00000000000015373805d04610e3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 12:23:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12938

--00000000000015373805d04610e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jasper Orschulko via lists.openembedded.org <jasper=3D
fancydomain.eu@lists.openembedded.org> escreveu no dia segunda, 8/11/2021
=C3=A0(s) 11:59:

> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>
> Add a recipe for repo 2.17.3, prerequisite for the repo fetcher.
>
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>  meta/conf/distro/include/maintainers.inc      |  1 +
>  .../0001-Set-REPO_REV-to-v2.17.3.patch        | 34 +++++++++++++++++++
>  .../repo/repo/0001-python3-shebang.patch      | 26 ++++++++++++++
>  meta/recipes-devtools/repo/repo_2.17.3.bb     | 27 +++++++++++++++
>  4 files changed, 88 insertions(+)
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
> index 0000000000..3086f8eb42
> --- /dev/null
> +++
> b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.pat=
ch
> @@ -0,0 +1,34 @@
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
> +folders, we hardcode the REPO_REV variable to a SHA1 that corresponds to
> +the version of the recipe.
> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/repo b/repo
> +index 4cddbf1..cf5f6b1 100755
> +--- a/repo
> ++++ b/repo
> +@@ -142,7 +142,7 @@ if __name__ =3D=3D '__main__':
> + REPO_URL =3D os.environ.get('REPO_URL', None)
> + if not REPO_URL:
> +   REPO_URL =3D 'https://gerrit.googlesource.com/git-repo'
> +-REPO_REV =3D os.environ.get('REPO_REV')
> ++REPO_REV =3D '11b30b91df1f0e03b53da970ec2588e85817bacc'
> + if not REPO_REV:
> +   REPO_REV =3D 'stable'
> + # URL to file bug reports for repo tool issues.
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
> index 0000000000..9e5282cc9b
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
> @@ -0,0 +1,27 @@
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
> +SRC_URI +=3D "file://0001-python3-shebang.patch"
>

meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
^ this patch is not used on the recipe, anyway injecting SRCREV after
unpack will be better imo


> +SRCREV =3D "11b30b91df1f0e03b53da970ec2588e85817bacc"
> +
> +MIRRORS +=3D "git://gerrit.googlesource.com/git-repo.git git://
> github.com/GerritCodeReview/git-repo.git \n"
> +
> +S =3D "${WORKDIR}/git"
> +
> +do_install() {
> +       install -d ${D}${bindir}
> +       install ${WORKDIR}/git/repo ${D}${bindir}
> +}
> +
> +RDEPENDS:${PN} =3D "python3"
> +
> +BBCLASSEXTEND =3D "native nativesdk"
> --
> 2.33.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12936):
> https://lists.openembedded.org/g/bitbake-devel/message/12936
> Mute This Topic: https://lists.openembedded.org/mt/86903590/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000015373805d04610e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jasper Orschulko via <a href=3D"http:=
//lists.openembedded.org">lists.openembedded.org</a> &lt;jasper=3D<a href=
=3D"mailto:fancydomain.eu@lists.openembedded.org">fancydomain.eu@lists.open=
embedded.org</a>&gt; escreveu no dia segunda, 8/11/2021 =C3=A0(s) 11:59:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Jasper Orsch=
ulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris-sensing.com" target=3D"_bl=
ank">Jasper.Orschulko@iris-sensing.com</a>&gt;<br>
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
4 +++++++++++++++++++<br>
=C2=A0.../repo/repo/0001-python3-shebang.patch=C2=A0 =C2=A0 =C2=A0 | 26 +++=
+++++++++++<br>
=C2=A0meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"n=
oreferrer" target=3D"_blank">repo_2.17.3.bb</a>=C2=A0 =C2=A0 =C2=A0| 27 +++=
++++++++++++<br>
=C2=A04 files changed, 88 insertions(+)<br>
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
index 0000000000..3086f8eb42<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.p=
atch<br>
@@ -0,0 +1,34 @@<br>
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
+folders, we hardcode the REPO_REV variable to a SHA1 that corresponds to<b=
r>
+the version of the recipe.<br>
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
+index 4cddbf1..cf5f6b1 100755<br>
+--- a/repo<br>
++++ b/repo<br>
+@@ -142,7 +142,7 @@ if __name__ =3D=3D &#39;__main__&#39;:<br>
+ REPO_URL =3D os.environ.get(&#39;REPO_URL&#39;, None)<br>
+ if not REPO_URL:<br>
+=C2=A0 =C2=A0REPO_URL =3D &#39;<a href=3D"https://gerrit.googlesource.com/=
git-repo" rel=3D"noreferrer" target=3D"_blank">https://gerrit.googlesource.=
com/git-repo</a>&#39;<br>
+-REPO_REV =3D os.environ.get(&#39;REPO_REV&#39;)<br>
++REPO_REV =3D &#39;11b30b91df1f0e03b53da970ec2588e85817bacc&#39;<br>
+ if not REPO_REV:<br>
+=C2=A0 =C2=A0REPO_REV =3D &#39;stable&#39;<br>
+ # URL to file bug reports for repo tool issues.<br>
+--<br>
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
index 0000000000..9e5282cc9b<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"n=
oreferrer" target=3D"_blank">repo_2.17.3.bb</a><br>
@@ -0,0 +1,27 @@<br>
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
+SRC_URI +=3D &quot;file://0001-python3-shebang.patch&quot;<br></blockquote=
><div><br></div><div><span style=3D"color:rgb(0,0,0)">meta/recipes-devtools=
/repo/rep</span><span style=3D"color:rgb(0,0,0)">o-2.17.3/0001-Set-REPO_REV=
-to-</span><span style=3D"color:rgb(0,0,0)">v2.17.3.patch</span></div><div>=
^ this patch is not used on the recipe, anyway injecting SRCREV after unpac=
k will be better imo</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+SRCREV =3D &quot;11b30b91df1f0e03b53da970ec2588e85817bacc&quot;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0install -d ${D}${bindir}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0install ${WORKDIR}/git/repo ${D}${bindir}<br>
+}<br>
+<br>
+RDEPENDS:${PN} =3D &quot;python3&quot;<br>
+<br>
+BBCLASSEXTEND =3D &quot;native nativesdk&quot;<br>
-- <br>
2.33.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12936): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12936" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12936</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86903590/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86903590/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--00000000000015373805d04610e3--

