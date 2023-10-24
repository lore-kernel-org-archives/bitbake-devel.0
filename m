Return-Path: <dburns@seegrid.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67EEC25B47
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 20:27:32 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
 by mx.groups.io with SMTP id smtpd.web11.28649.1698179243748267701
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Oct 2023 13:27:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@seegrid.com header.s=google header.b=rh8C4znj;
 spf=permerror, err=parse error for token &{10 18 _spf.google.com}: parse error for token &{10 18 _netblocks.google.com}: limit exceeded (domain: seegrid.com, ip: 209.85.161.49, mailfrom: dburns@seegrid.com)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5841a3ffd50so816367eaf.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seegrid.com; s=google; t=1698179242; x=1698784042; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsL92GUbZl7j+OZgJC14/zLTZLFUjGmcv5kPXC84uyA=;
        b=rh8C4znjUYlWkqY/5CiaE/Qgwepu84San2rDtV0wkVvTEGZw/GkIeYTK9ZnxSk37kN
         RIETcLeUwiJsr8LCcJQd6ZsD6t4hHPlWVq6t8AbV+hETbdFsTurquPKea3sb2VSaZRt2
         VnJGnlr/886ATBSIsDtnZXmLB99YgA2smZJVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698179242; x=1698784042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsL92GUbZl7j+OZgJC14/zLTZLFUjGmcv5kPXC84uyA=;
        b=bhJe5qo47vSvWUTOyGO+r6F4WCYyD1cwLGx/7DGp6/UzmSMUfN/EjfshxqlP7VAo0U
         tLNRSDMmrC2wGCanON9o0ahxsuKYtuZ48IYJxnZnxCrNIPiEuUcZ3A95/gp3223erAxV
         QluqxfRubyJo9y67/r2v7VHeW2+VPMq7d9cyOS2xwPYNZ3PLPYMKeTHfkUdKHjUiFPDz
         PHXh4tfrcLcUZw8LQs6vXWTQtwCwyIqhDIZC5vm7ewaq0nL5MCQMgJhU8Fu5dD4U6vVW
         nc4uVfy5qvLzYaeD+F+uOg49xACQf42hZvc7I8X0zqJ2kZdHaPqu6URSppSa5eMRz+3f
         Brdg==
X-Gm-Message-State: AOJu0YxVGtTRfhy9ND08st30+hwunbLeC7zrJQOVyMxdQtbGg1T/rVC9
	YLuJWBEjoGqkJ4pkOQyEuRTKTMopMdRhRA88H0yjXpRi1zG0yvPmcIo=
X-Google-Smtp-Source: AGHT+IFP8MgodKEwqJVwYlz9v0YCQHRdvrI8VlsrSto/+vPahCtq8/FBCZoECc5IjgcT2asN4RqislWesjOMMDo6teI=
X-Received: by 2002:a05:6359:3018:b0:168:c017:c19c with SMTP id
 rf24-20020a056359301800b00168c017c19cmr8770348rwb.1.1698179242560; Tue, 24
 Oct 2023 13:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZje+vcoFiS5rHFn1rvUzmSo-++8VchDzTktSgxKLwD7F0Acg@mail.gmail.com>
In-Reply-To: <CAJZje+vcoFiS5rHFn1rvUzmSo-++8VchDzTktSgxKLwD7F0Acg@mail.gmail.com>
From: Desone Burns <dburns@seegrid.com>
Date: Tue, 24 Oct 2023 16:27:11 -0400
Message-ID: <CAJZje+tdOZPp73THMk6pZNLyzncLQcqTRcdyN=v99dJL_=430g@mail.gmail.com>
Subject: [PATCH] bitbake: fetch2: git: Add git-lfs install step
To: bitbake-devel@lists.openembedded.org
Cc: Joseph Chafin <jchafin@seegrid.com>
Content-Type: multipart/alternative; boundary="00000000000085981206087c2aa6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 20:27:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15282

--00000000000085981206087c2aa6
Content-Type: text/plain; charset="UTF-8"

When pulling a Git repo that included LFS, it was possible that
the LFS download would fail with a message regarding the LFS being
installed in the repo. This change runs the LFS install step prior
to checkout, to ensure the download step is included in the Git hooks.

Signed-off-by: Desone Burns II <dburnsii@live.com>
---
 bitbake/lib/bb/fetch2/git.py | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 33895e09b2..e4da7de377 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -52,6 +52,11 @@ Supported SRC_URI options are:
    For local git:// urls to use the current branch HEAD as the
revision for use with
    AUTOREV. Implies nobranch.

+- lfs
+    Enable the checkout to use LFS for large files. This will
download all LFS files
+    in the download step, as the unpack step does not have network access.
+    The default is "1", set lfs=0 to skip.
+
 """

 # Copyright (C) 2005 Richard Purdie
@@ -630,6 +635,8 @@ class Git(FetchMethod):
                 raise bb.fetch2.FetchError("Repository %s has LFS
content, install git-lfs on host to download (or set lfs=0 to ignore
it)" % (repourl))
             elif not need_lfs:
                 bb.note("Repository %s has LFS content but it is not
being fetched" % (repourl))
+            else:
+                runfetchcmd("%s lfs install" % ud.basecmd, d,
workdir=destdir)

         if not ud.nocheckout:
             if subpath:
@@ -689,13 +696,15 @@ class Git(FetchMethod):
         Check if the repository has 'lfs' (large file) content
         """

-        # The bare clonedir doesn't use the remote names; it has the
branch immediately.
-        if wd == ud.clonedir:
+        if ud.nobranch:
+            refname = self._build_revision(ud, d, ud.names[0])
+        elif wd == ud.clonedir:
+            # The bare clonedir doesn't use the remote names; it has
the branch immediately.
             refname = ud.branches[ud.names[0]]
         else:
             refname = "origin/%s" % ud.branches[ud.names[0]]

-        cmd = "%s grep lfs %s:.gitattributes | wc -l" % (
+        cmd = "%s lfs ls-files %s | wc -l" % (
             ud.basecmd, refname)

         try:
-- 
2.25.1

--00000000000085981206087c2aa6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote">When pulling a Git repo that in=
cluded LFS, it was possible that<br>
the LFS download would fail with a message regarding the LFS being<br>
installed in the repo. This change runs the LFS install step prior<br>
to checkout, to ensure the download step is included in the Git hooks.<br>
<br>
Signed-off-by: Desone Burns II &lt;<a href=3D"mailto:dburnsii@live.com" tar=
get=3D"_blank">dburnsii@live.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/git.py | 15 ++++++++++++---<br>
=C2=A01 file changed, 12 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py<br=
>
index 33895e09b2..e4da7de377 100644<br>
--- a/bitbake/lib/bb/fetch2/git.py<br>
+++ b/bitbake/lib/bb/fetch2/git.py<br>
@@ -52,6 +52,11 @@ Supported SRC_URI options are:<br>
=C2=A0 =C2=A0 For local git:// urls to use the current branch HEAD as the<b=
r>
revision for use with<br>
=C2=A0 =C2=A0 AUTOREV. Implies nobranch.<br>
<br>
+- lfs<br>
+=C2=A0 =C2=A0 Enable the checkout to use LFS for large files. This will<br=
>
download all LFS files<br>
+=C2=A0 =C2=A0 in the download step, as the unpack step does not have netwo=
rk access.<br>
+=C2=A0 =C2=A0 The default is &quot;1&quot;, set lfs=3D0 to skip.<br>
+<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0# Copyright (C) 2005 Richard Purdie<br>
@@ -630,6 +635,8 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise bb.fetc=
h2.FetchError(&quot;Repository %s has LFS<br>
content, install git-lfs on host to download (or set lfs=3D0 to ignore<br>
it)&quot; % (repourl))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif not need_lfs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.note(&quot=
;Repository %s has LFS content but it is not<br>
being fetched&quot; % (repourl))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;=
%s lfs install&quot; % ud.basecmd, d, workdir=3Ddestdir)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ud.nocheckout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if subpath:<br>
@@ -689,13 +696,15 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Check if the repository has &#39;lfs&#39;=
 (large file) content<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The bare clonedir doesn&#39;t use the remote=
 names; it has the<br>
branch immediately.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if wd =3D=3D ud.clonedir:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.nobranch:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 refname =3D self._build_revision=
(ud, d, ud.names[0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif wd =3D=3D ud.clonedir:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # The bare clonedir doesn&#39;t =
use the remote names; it has<br>
the branch immediately.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0refname =3D ud.branches[ud.=
names[0]]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0refname =3D &quot;origin/%s=
&quot; % ud.branches[ud.names[0]]<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s grep lfs %s:.gitattributes | =
wc -l&quot; % (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;%s lfs ls-files %s | wc -l&quot;=
 % (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basecmd, refname)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-- <br>
2.25.1</div></div>

--00000000000085981206087c2aa6--

