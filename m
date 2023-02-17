Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CABC05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 17:01:35 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by mx.groups.io with SMTP id smtpd.web10.11910.1676653289086809480
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 09:01:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=FVY2mZGc;
 spf=pass (domain: myneves.com, ip: 185.70.40.136, mailfrom: paulo@myneves.com)
Date: Fri, 17 Feb 2023 17:01:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676653285; x=1676912485;
	bh=O1ZiNKHGGNeFVe0vbBdvtx/YrSfAh+Od5fw9XiOws0A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FVY2mZGcnPskLtyglFK5ztxfMtVHia9oEtKqg0tvrYJzVGS1QSi/PEmseZcMD7MHS
	 wg11OAlIDcr3+R9aoCxD2ZckawCtyL9TxpNVnboLR1I/thGU2XrxhVB3xqbHvBa0xN
	 bapPa06ZtYEa63tzwfXttxnVxFK+aBWvC/oqrW/zhGPDH0ku+FFKljdBsqRrST/Djd
	 K6VLDHQwK+7/NUYNpGMAfh8FG6cvWtHSl83tEv6gnAxbi6ElCR48rn1OOe3KzECaG5
	 cI99qu/YoFbPkFSu9T6Ig6uemxFN5mZiU2mwun5ISRS7ArNXASGzDqZl5kWCSruFre
	 ltVXD2GLzECUg==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 5/5] git.py Replace mkdtemp with TemporaryDirectory and avoid exception masking
Message-ID: <20230217170009.58707-5-paulo@myneves.com>
In-Reply-To: <20230217170009.58707-1-paulo@myneves.com>
References: <20230217170009.58707-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 17:01:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14464

Due to using mkdtemp instead of TemporaryDirectory we needed to
manually cleanup the directory in a try finally block.
With tempfile.TemporaryDirectory we can handle the cleanup with
a "with" statement and not need to manually clean up oursevels.

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/fetch2/git.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index fcd70fdcf..9445643e5 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -417,8 +417,7 @@ class Git(FetchMethod):
             # It would be nice to just do this inline here by running 'git=
-lfs fetch'
             # on the bare clonedir, but that operation requires a working =
copy on some
             # releases of Git LFS.
-            tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR'))
-            try:
+            with tempfile.TemporaryDirectory(dir=3Dd.getVar('DL_DIR')) as =
tmpdir:
                 # Do the checkout. This implicitly involves a Git LFS fetc=
h.
                 Git.unpack(self, ud, tmpdir, d)

@@ -436,8 +435,6 @@ class Git(FetchMethod):
                 # downloaded.
                 if os.path.exists(os.path.join(tmpdir, "git", ".git", "lfs=
")):
                     runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clo=
nedir, d, workdir=3D"%s/git/.git" % tmpdir)
-            finally:
-                bb.utils.remove(tmpdir, recurse=3DTrue)

     def build_mirror_data(self, ud, d):

--
2.34.1



