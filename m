Return-Path: <s.lengfeld@phytec.de>
X-Greylist: delayed 415 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 20 Sep 2016 12:19:05 UTC
Received: from root.phytec.de (mail.phytec.eu [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id 6890D6025F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 12:19:05 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id EAF82A00279
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 14:12:26 +0200 (CEST)
Received: from augenblix.phytec.de ([172.16.0.56])
	by idefix.phytec.de (IBM Domino Release 9.0.1FP5 HF413)
	with ESMTP id 2016092014120871-223672 ;
	Tue, 20 Sep 2016 14:12:08 +0200 
From: Stefan Lengfeld <s.lengfeld@phytec.de>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2016 14:12:08 +0200
Message-Id: <1474373528-5865-1-git-send-email-s.lengfeld@phytec.de>
X-Mailer: git-send-email 1.9.1
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP5
	HF413|March 21, 2016) at 20.09.2016 14:12:08,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP5 HF413|March 21,
	2016) at 20.09.2016 14:12:08,
	Serialize complete at 20.09.2016 14:12:08
X-TNEFEvaluated: 1
X-Mailman-Approved-At: Tue, 20 Sep 2016 14:15:53 +0000
Subject: [PATCH krogoth] bitbake: fetch: copy files with -H
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 20 Sep 2016 12:19:06 -0000

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

When using a PREMIRROR with plain (non-unpack) files, a SRC_URI like

SRC_URI = "file://devmem2.c"

will cause devmem2.c to be a symlink in the WORKDIR pointing to the
local PREMIRROR.

Trying to apply a patch on this file will either modify the file on
the PREMIRROR or will fail due to sanity checks:

ERROR: devmem2-1.0-r7 do_patch: Command Error: 'quilt --quiltrc /cache/build-ubuntu/sysroots/x86_64-oe-linux/etc/quiltrc push' exited with 1  Output:
Applying patch devmem2-fixups-2.patch
File devmem2.c is not a regular file -- refusing to patch

(Bitbake rev: cfd481fe9799e7a4c6bfac32e56cc91cfcd81088)

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
Hi,

this patch was already applied on poky's master branch. Can you please backport
it to krogoth. The bug is there, too. I already posted a different patch some
time ago:

    http://lists.openembedded.org/pipermail/bitbake-devel/2016-June/007621.html

Thanks.

Kind regards,
	Stefan Lengfeld
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6ef0c6f..7773c16 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1424,7 +1424,7 @@ class FetchMethod(object):
                     if urlpath.find("/") != -1:
                         destdir = urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd = 'cp -fpPR %s %s' % (file, destdir)
+                cmd = 'cp -fpPRH %s %s' % (file, destdir)
 
         if not cmd:
             return
-- 
1.9.1


