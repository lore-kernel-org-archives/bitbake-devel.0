Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2CEE49A5
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 20:34:26 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by mx.groups.io with SMTP id smtpd.web10.6964.1692736456215751988
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Aug 2023 13:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@myneves.com header.s=protonmail2 header.b=PBsrIFqS;
 spf=pass (domain: myneves.com, ip: 185.70.40.22, mailfrom: paulo@myneves.com)
Date: Tue, 22 Aug 2023 20:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail2; t=1692736452; x=1692995652;
	bh=qVPdX86H3Q0jlxNRU3m0rxjUUBP8rNQdInkw6Y0M3qI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PBsrIFqS+bVMsmkqOukuQO0GUuwFIdXk8yfLYykyXC9MAgdaSR1ZYLfMlaE+LBkfw
	 r6jCoTZ13M5Aoae/vxXbdx2HDuWHuDpvHL/SC7Z4hM0PLLEfLectQLO0rGfaqK0KGj
	 KZCjbDMfRiDI810llb7QcJYepjy4TN3+uR5fBhZ2BDF4bmvb9BWp48yMbZ0ObZck19
	 MhqsFvylZwuzNU0hJIZ0srMjLswyYQYK3deYwkIO9s5P8QreX/p9Nf1fnM2wt2goRR
	 0AL3+fgdzco8Wtkdt4ENrW8RUqgLQEIS5NT8Fvz29Ls8j84iHLwBbtAYDIFnNcDVn5
	 EP9zhkJ5BNP2A==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 1/1] siggen.py: Improve taskhash reproducibility
Message-ID: <20230822203350.264625-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Aug 2023 20:34:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14958

file checksums are part of the data checksummed
to generate the task hash. The list of file checksums
was not ordered.

In this commit we make sure the task hash checksum takes
a list of checksum data that is ordered by unique file name
thus guaranteeing reproducibility.

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/siggen.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 879c136e1..b023b79ec 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -361,7 +361,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         for dep in sorted(self.runtaskdeps[tid]):
             data +=3D self.get_unihash(dep[1])
=20
-        for (f, cs) in self.file_checksum_values[tid]:
+        for (f, cs) in sorted(self.file_checksum_values[tid], key=3Dclean_=
checksum_file_path):
             if cs:
                 if "/./" in f:
                     data +=3D "./" + f.split("/./")[1]
@@ -426,7 +426,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if runtime and tid in self.taskhash:
             data['runtaskdeps'] =3D [dep[0] for dep in sorted(self.runtask=
deps[tid])]
             data['file_checksum_values'] =3D []
-            for f,cs in self.file_checksum_values[tid]:
+            for f,cs in sorted(self.file_checksum_values[tid], key=3Dclean=
_checksum_file_path):
                 if "/./" in f:
                     data['file_checksum_values'].append(("./" + f.split("/=
./")[1], cs))
                 else:
@@ -745,6 +745,12 @@ class SignatureGeneratorTestEquivHash(SignatureGenerat=
orUniHashMixIn, SignatureG
         self.server =3D data.getVar('BB_HASHSERVE')
         self.method =3D "sstate_output_hash"
=20
+def clean_checksum_file_path(file_checksum_tuple):
+    f, cs =3D file_checksum_tuple
+    if "/./" in f:
+        return "./" + f.split("/./")[1]
+    return f
+
 def dump_this_task(outfile, d):
     import bb.parse
     mcfn =3D d.getVar("BB_FILENAME")
--=20
2.34.1



