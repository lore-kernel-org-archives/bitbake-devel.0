Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D1C433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 15:04:16 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48])
 by mx.groups.io with SMTP id smtpd.web08.6815.1636124655651194211
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 08:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=KCjD+cxu;
 spf=pass (domain: gmail.com, ip: 209.85.222.48,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f48.google.com with SMTP id az37so17595894uab.13;
        Fri, 05 Nov 2021 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=892cAxHpm09U94vLhd84FTONoryR78JZLM7dtE8c1x4=;
        b=KCjD+cxueDCP1cnB1skCbAWxIlXfqZgwjsWLKQvNyBPVKAVrIyYOA7Y5ayk15cyz+S
         r4nLV93jtwmYWdVqpCuifi03zOVpxxZwuvHkegW92rsJjOfvCx5vg4fT6aoj7bNoKsO2
         ESG90Xx6RzLIDsajVkPu0jZklD2c76cxrYkce7i2nB4tZ+zt9iOhrPnDvIXMLShmfAKI
         qFYLzjr0uMFc8HTr40Au5h6z/LZFWaal9bFy+4p6UA+Xr65vx8INC/9sJhUpByr87E5V
         SMj19FpLiv7tSrNeif30a5lRmfxl5dl/FiMOFyHDUhTsSdvYMGsT4Yum1oWBY/f7EDE7
         d4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=892cAxHpm09U94vLhd84FTONoryR78JZLM7dtE8c1x4=;
        b=F7T80qASnGixXtRhcYsgfHhMfpYZoCVZoUHmuWeyDy114eke8b24o3Jh9ojcrfMTNA
         7rkimRgAMMrv+XvE/NlreiJKHJb9XQm3ZZ9Q6BOFi3rRRTj2CcIpSafBzRnt26Qx+Ygh
         dRSDKg6IZTbSFVMbEyGmTDmNE0+j22+wkDeWYDQxj2wsjIWzHqcQNZSgLOz1wvudkO98
         AGf/YahK9hYHTAZnTbwUpYtipiJ9aCwZL4NBPzV3GO2On1ba8LqcBb49nFDjM8IFS8BZ
         1vjMSbdmaQ1j0OiUNRvVC+q5VcK/dSh2WlBRhhUglv59iOAeU9h1fHdCIXnWejwQEc+N
         WQ1Q==
X-Gm-Message-State: AOAM533M+asUy85IkXWZpzALXcy8uCwAs4YVXS4kbrhSZrklHfBN9Pv4
	a8aV6/z+GzOJztcXdoM16vJ+RJyvRBPeDBUoMlI=
X-Google-Smtp-Source: 
 ABdhPJzBqJnW5Odw5tHEezQHqnhrDab0/zhHld+Y3CR2J/wDlMeltAYRVU6OKZNslkz28GV0l3yLITxNVh2Jt2LAIdM=
X-Received: by 2002:a05:6102:c88:: with SMTP id
 f8mr23019458vst.13.1636124654760;
 Fri, 05 Nov 2021 08:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211105133104.19895-1-jasper@fancydomain.eu>
 <CANNYZj_s8_PkKfMQnBxNZLs-p0F5xb4StCXiF84OkbE5zpptqw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_s8_PkKfMQnBxNZLs-p0F5xb4StCXiF84OkbE5zpptqw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Nov 2021 16:04:03 +0100
Message-ID: 
 <CANNYZj_-qmAPdSwN-cjR5htukanLC=mqhzjZZq8WGuXObZry3A@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: jasper@fancydomain.eu
Cc: OE-core <openembedded-core@lists.openembedded.org>, martin@mko.dev,
	Daniel.Baumgart@iris-sensing.net,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Content-Type: multipart/alternative; boundary="000000000000daf6cb05d00bf4a5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 15:04:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12905

--000000000000daf6cb05d00bf4a5
Content-Type: text/plain; charset="UTF-8"

Ah I didn't notice it's something that already exists. Still, I'm curious
for which items is it used, and why repo over other options?

Alex

On Fri, 5 Nov 2021 at 15:20, Alexander Kanavin <alex.kanavin@gmail.com>
wrote:

> Wait, what is the use case for the repo fetcher?
>
> Alex
>
> On Fri, 5 Nov 2021 at 14:31, Jasper Orschulko via lists.openembedded.org
> <jasper=fancydomain.eu@lists.openembedded.org> wrote:
>
>> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>>
>> Add a recipe for repo, prerequisite for the repo fetcher.
>>
>> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>> ---
>>  .../repo/files/0001-python3-shebang.patch     | 21 ++++++++++++
>>  .../0001-Set-REPO_REV-to-v2.17.3.patch        | 33 +++++++++++++++++++
>>  meta/recipes-devtools/repo/repo.inc           | 25 ++++++++++++++
>>  meta/recipes-devtools/repo/repo_2.17.3.bb     |  7 ++++
>>  4 files changed, 86 insertions(+)
>>  create mode 100644
>> meta/recipes-devtools/repo/files/0001-python3-shebang.patch
>>  create mode 100644
>> meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>>  create mode 100644 meta/recipes-devtools/repo/repo.inc
>>  create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb
>>
>> diff --git a/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
>> b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
>> new file mode 100644
>> index 0000000000..09ccf58264
>> --- /dev/null
>> +++ b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
>> @@ -0,0 +1,21 @@
>> +From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
>> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>> +Date: Tue, 14 Sep 2021 16:46:51 +0200
>> +Subject: [PATCH] python3 shebang
>> +
>> +---
>> + repo | 2 +-
>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>> +
>> +diff --git a/repo b/repo
>> +index b13e34c..205e0e5 100755
>> +--- a/repo
>> ++++ b/repo
>> +@@ -1,4 +1,4 @@
>> +-#!/usr/bin/env python
>> ++#!/usr/bin/env python3
>> + # -*- coding:utf-8 -*-
>> + #
>> + # Copyright (C) 2008 The Android Open Source Project
>> +--
>> +2.33.0
>> diff --git
>> a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>> b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>> new file mode 100644
>> index 0000000000..294a3af53a
>> --- /dev/null
>> +++
>> b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>> @@ -0,0 +1,33 @@
>> +From bdd2a528da59c28db8ae2986834926de7cebf3ab Mon Sep 17 00:00:00 2001
>> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>> +Date: Thu, 4 Nov 2021 16:55:12 +0100
>> +Subject: [PATCH] Set REPO_REV to v2.17.3
>> +
>> +repo is an unusual tool because it downloads all of its own Python
>> modules
>> +using GPG-signed git tags, and stores those files as part of the project
>> +that it is working with.
>> +
>> +So in order to have a reproducible repo installation within the project
>> +folders, we hardcode the REPO_REV variable to this recipes PV.
>> +
>> +Upstream-Status: Inappropriate [configuration]
>> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>> +---
>> + repo | 2 +-
>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>> +
>> +diff --git a/repo b/repo
>> +index 4cddbf1..cf5f6b1 100755
>> +--- a/repo
>> ++++ b/repo
>> +@@ -142,7 +142,7 @@ if __name__ == '__main__':
>> + REPO_URL = os.environ.get('REPO_URL', None)
>> + if not REPO_URL:
>> +   REPO_URL = 'https://gerrit.googlesource.com/git-repo'
>> +-REPO_REV = os.environ.get('REPO_REV')
>> ++REPO_REV = 'v2.17.3'
>> + if not REPO_REV:
>> +   REPO_REV = 'stable'
>> + # URL to file bug reports for repo tool issues.
>> +--
>> +2.33.1
>> diff --git a/meta/recipes-devtools/repo/repo.inc
>> b/meta/recipes-devtools/repo/repo.inc
>> new file mode 100644
>> index 0000000000..60b32e4d74
>> --- /dev/null
>> +++ b/meta/recipes-devtools/repo/repo.inc
>> @@ -0,0 +1,25 @@
>> +# SPDX-License-Identifier: MIT
>> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
>> +
>> +SUMMARY = "Tool for managing many Git repositories"
>> +DESCRIPTION = "Repo is a tool built on top of Git. Repo helps manage
>> many Git repositories, does the uploads to revision control systems, and
>> automates parts of the development workflow."
>> +HOMEPAGE = "https://android.googlesource.com/tools/repo"
>> +SECTION = "console/utils"
>> +
>> +LICENSE = "Apache-2.0"
>> +
>> +SRC_URI = "git://
>> git@gerrit.googlesource.com/git-repo.git;protocol=https;branch=main"
>> +MIRRORS = "git://git@gerrit.googlesource.com/git-repo.git git://
>> github.com/GerritCodeReview/git-repo.git \n"
>> +
>> +SRC_URI += "file://0001-python3-shebang.patch"
>> +
>> +S = "${WORKDIR}/git"
>> +
>> +RDEPENDS_${PN} = "python3"
>> +
>> +do_install() {
>> +    install -d ${D}${bindir}
>> +    install -m 755 ${WORKDIR}/git/repo ${D}${bindir}
>> +}
>> +
>> +BBCLASSEXTEND = "native nativesdk"
>> diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb
>> b/meta/recipes-devtools/repo/repo_2.17.3.bb
>> new file mode 100644
>> index 0000000000..c26264b9e9
>> --- /dev/null
>> +++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: MIT
>> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
>> +
>> +require recipes-devtools/repo/repo.inc
>> +
>> +SRCREV = "11b30b91df1f0e03b53da970ec2588e85817bacc"
>> +LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
>> --
>> 2.33.1
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#12893):
>> https://lists.openembedded.org/g/bitbake-devel/message/12893
>> Mute This Topic: https://lists.openembedded.org/mt/86840271/1686489
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>> alex.kanavin@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>

--000000000000daf6cb05d00bf4a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ah I didn&#39;t notice it&#39;s something that alread=
y exists. Still, I&#39;m curious for which items is it used, and why repo o=
ver other options?</div><div><br></div><div>Alex<br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 5 Nov 202=
1 at 15:20, Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com"=
>alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div>Wait, what is the use case for=
 the repo fetcher? <br></div><div><br></div><div>Alex<br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 5 No=
v 2021 at 14:31, Jasper Orschulko via <a href=3D"http://lists.openembedded.=
org" target=3D"_blank">lists.openembedded.org</a> &lt;jasper=3D<a href=3D"m=
ailto:fancydomain.eu@lists.openembedded.org" target=3D"_blank">fancydomain.=
eu@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">From: Jasper Orschulko &lt;<a href=3D"mailto:Jaspe=
r.Orschulko@iris-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensi=
ng.com</a>&gt;<br>
<br>
Add a recipe for repo, prerequisite for the repo fetcher.<br>
<br>
Signed-off-by: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris=
-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<b=
r>
---<br>
=C2=A0.../repo/files/0001-python3-shebang.patch=C2=A0 =C2=A0 =C2=A0| 21 +++=
+++++++++<br>
=C2=A0.../0001-Set-REPO_REV-to-v2.17.3.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3=
3 +++++++++++++++++++<br>
=C2=A0meta/recipes-devtools/repo/repo.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 25 ++++++++++++++<br>
=C2=A0meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"n=
oreferrer" target=3D"_blank">repo_2.17.3.bb</a>=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
7 ++++<br>
=C2=A04 files changed, 86 insertions(+)<br>
=C2=A0create mode 100644 meta/recipes-devtools/repo/files/0001-python3-sheb=
ang.patch<br>
=C2=A0create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-RE=
PO_REV-to-v2.17.3.patch<br>
=C2=A0create mode 100644 meta/recipes-devtools/repo/repo.inc<br>
=C2=A0create mode 100644 meta/recipes-devtools/repo/<a href=3D"http://repo_=
2.17.3.bb" rel=3D"noreferrer" target=3D"_blank">repo_2.17.3.bb</a><br>
<br>
diff --git a/meta/recipes-devtools/repo/files/0001-python3-shebang.patch b/=
meta/recipes-devtools/repo/files/0001-python3-shebang.patch<br>
new file mode 100644<br>
index 0000000000..09ccf58264<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch<br>
@@ -0,0 +1,21 @@<br>
+From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001<br>
+From: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris-sensing=
.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<br>
+Date: Tue, 14 Sep 2021 16:46:51 +0200<br>
+Subject: [PATCH] python3 shebang<br>
+<br>
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
diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2=
.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v=
2.17.3.patch<br>
new file mode 100644<br>
index 0000000000..294a3af53a<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.p=
atch<br>
@@ -0,0 +1,33 @@<br>
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
+folders, we hardcode the REPO_REV variable to this recipes PV.<br>
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
++REPO_REV =3D &#39;v2.17.3&#39;<br>
+ if not REPO_REV:<br>
+=C2=A0 =C2=A0REPO_REV =3D &#39;stable&#39;<br>
+ # URL to file bug reports for repo tool issues.<br>
+--<br>
+2.33.1<br>
diff --git a/meta/recipes-devtools/repo/repo.inc b/meta/recipes-devtools/re=
po/repo.inc<br>
new file mode 100644<br>
index 0000000000..60b32e4d74<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/repo.inc<br>
@@ -0,0 +1,25 @@<br>
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
+<br>
+SRC_URI =3D &quot;git://<a href=3D"http://git@gerrit.googlesource.com/git-=
repo.git;protocol=3Dhttps;branch=3Dmain" rel=3D"noreferrer" target=3D"_blan=
k">git@gerrit.googlesource.com/git-repo.git;protocol=3Dhttps;branch=3Dmain<=
/a>&quot;<br>
+MIRRORS =3D &quot;git://<a href=3D"http://git@gerrit.googlesource.com/git-=
repo.git" rel=3D"noreferrer" target=3D"_blank">git@gerrit.googlesource.com/=
git-repo.git</a> git://<a href=3D"http://github.com/GerritCodeReview/git-re=
po.git" rel=3D"noreferrer" target=3D"_blank">github.com/GerritCodeReview/gi=
t-repo.git</a> \n&quot;<br>
+<br>
+SRC_URI +=3D &quot;file://0001-python3-shebang.patch&quot;<br>
+<br>
+S =3D &quot;${WORKDIR}/git&quot;<br>
+<br>
+RDEPENDS_${PN} =3D &quot;python3&quot;<br>
+<br>
+do_install() {<br>
+=C2=A0 =C2=A0 install -d ${D}${bindir}<br>
+=C2=A0 =C2=A0 install -m 755 ${WORKDIR}/git/repo ${D}${bindir}<br>
+}<br>
+<br>
+BBCLASSEXTEND =3D &quot;native nativesdk&quot;<br>
diff --git a/meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" r=
el=3D"noreferrer" target=3D"_blank">repo_2.17.3.bb</a> b/meta/recipes-devto=
ols/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"noreferrer" target=3D"_bl=
ank">repo_2.17.3.bb</a><br>
new file mode 100644<br>
index 0000000000..c26264b9e9<br>
--- /dev/null<br>
+++ b/meta/recipes-devtools/repo/<a href=3D"http://repo_2.17.3.bb" rel=3D"n=
oreferrer" target=3D"_blank">repo_2.17.3.bb</a><br>
@@ -0,0 +1,7 @@<br>
+# SPDX-License-Identifier: MIT<br>
+# Copyright (C) 2021 iris-GmbH infrared &amp; intelligent sensors<br>
+<br>
+require recipes-devtools/repo/repo.inc<br>
+<br>
+SRCREV =3D &quot;11b30b91df1f0e03b53da970ec2588e85817bacc&quot;<br>
+LIC_FILES_CHKSUM =3D &quot;file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3=
c6bd57&quot;<br>
-- <br>
2.33.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12893): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12893" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12893</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86840271/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86840271/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000daf6cb05d00bf4a5--

