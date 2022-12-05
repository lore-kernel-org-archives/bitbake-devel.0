Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2DC4321E
	for <webhook@archiver.kernel.org>; Mon,  5 Dec 2022 22:00:47 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.29922.1670277636642074825
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Dec 2022 14:00:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=RBwXExWh;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1ED6283A1F;
	Mon,  5 Dec 2022 23:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1670277634;
	bh=vhgAKb7P6Ji8C8iY2xWivR9LPmPS/oQFjrEPHIG088Q=;
	h=From:To:Cc:Subject:Date:From;
	b=RBwXExWhGxfCS1jxzhTETG2JJWYgZ+YrRDsPFeAkQ9JD6yhDB5UdHu1+8tV6T4IUl
	 BZFEp7Nv5jiJIMd//7NU53rw8NIbaQWTE1oD5Cr+CeKMwgYbcTZZacqzr4+dvUu5UQ
	 XzJfJccm5MjGrHGlAaFN1IP3jYFtQfbSx4wb98Oupn/gOunTrZ0Zu9JGXHRFloWHV9
	 6wP8ufBkj+pwR0XxSYwmpxDCZShPPCUknd86m8f4bw4o/xEUjtedilj0zaxHA1FISl
	 vki4XueRY/7pPZiur1R40p7FWn+1mMl2XEGcYQwqb1Y4NrK5xPi6JieB1kBaSA52sd
	 Yl0iww1mZ+P8w==
From: Marek Vasut <marex@denx.de>
To: bitbake-devel@lists.openembedded.org
Cc: Marek Vasut <marex@denx.de>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Martin Jansa <Martin.Jansa@gmail.com>,
	Mikko.Rapeli@bmw.de,
	Quentin Schulz <foss+yocto@0leil.net>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH] fetch2/git: Prevent git fetcher from fetching gitlab repository metadata
Date: Mon,  5 Dec 2022 23:00:19 +0100
Message-Id: <20221205220019.19650-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Dec 2022 22:00:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14137

The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
single object in the remote repository. This works poorly with gitlab
and github, which use the remote git repository to track its metadata
like merge requests, CI pipelines and such.

Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
and refs/keep-around/* and they all contain massive amount of data that
are useless for the bitbake build purposes. The amount of useless data
can in fact be so massive (e.g. with FDO mesa.git repository) that some
proxies may outright terminate the 'git fetch' connection, and make it
appear as if bitbake got stuck on 'git fetch' with no output.

To avoid fetching all these useless metadata, tweak the git fetcher such
that it only fetches refs/heads/* and refs/tags/* . Avoid using negative
refspecs as those are only available in new git versions.

Per feedback on the ML, Gerrit may push commits outsides of branches or
tags during CI runs, which currently works with the 'nobranch=3D1' fetche=
r
parameter. To retain this functionality, keep fetching everything in case
the 'nobranch=3D1' is present. This still avoids fetching massive amount =
of
data in the common case, since 'nobranch=3D1' is rare. Update 'nobranch'
documentation.

Reviewed-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Cc: Mikko.Rapeli@bmw.de
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Quentin Schulz <foss+yocto@0leil.net>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
---
V1: - Add RB from Peter
    - Keep fetching everything in case of nobranch=3D1
    - Update nobranch documentation
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/git.py                                     | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 9c269ca8..e86a4d86 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -424,8 +424,8 @@ This fetcher supports the following parameters:
=20
 -  *"nobranch":* Tells the fetcher to not check the SHA validation for
    the branch when set to "1". The default is "0". Set this option for
-   the recipe that refers to the commit that is valid for a tag instead
-   of the branch.
+   the recipe that refers to the commit that is valid for a any namespac=
e
+   instead of the branch.
=20
 -  *"bareclone":* Tells the fetcher to clone a bare clone into the
    destination directory without checking out a working tree. Only the
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 578edc59..c80e8e5c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -44,7 +44,7 @@ Supported SRC_URI options are:
=20
 - nobranch
    Don't check the SHA validation for branch. set this option for the re=
cipe
-   referring to commit which is valid in tag instead of branch.
+   referring to commit which is valid in any namespace instead of branch=
.
    The default is "0", set nobranch=3D1 if needed.
=20
 - usehead
@@ -382,7 +382,11 @@ class Git(FetchMethod):
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=
=3Dud.clonedir)
=20
             runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (ud=
.basecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
-            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:ref=
s/*" % (ud.basecmd, shlex.quote(repourl))
+
+            if ud.nobranch:
+                fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*=
:refs/*" % (ud.basecmd, shlex.quote(repourl))
+            else:
+                fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/h=
eads/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(r=
epourl))
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
--=20
2.35.1


