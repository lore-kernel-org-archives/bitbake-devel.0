Return-Path: <s.christ@phytec.de>
X-Greylist: delayed 592 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 22 Jun 2016 09:46:28 UTC
Received: from root.phytec.de (mail.x-arc.de [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id 60397601D3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2016 09:46:28 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id 77F89A00266
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2016 11:37:28 +0200 (CEST)
Received: from augenblix.phytec.de ([172.16.0.56])
	by idefix.phytec.de (IBM Domino Release 9.0.1FP5 HF413)
	with ESMTP id 2016062211362121-347230 ;
	Wed, 22 Jun 2016 11:36:21 +0200 
From: Stefan Christ <s.christ@phytec.de>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2016 11:34:32 +0200
Message-Id: <1466588072-37331-1-git-send-email-s.christ@phytec.de>
X-Mailer: git-send-email 1.9.1
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP5
	HF413|March 21, 2016) at 22.06.2016 11:36:21,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP5 HF413|March 21,
	2016) at 22.06.2016 11:36:21,
	Serialize complete at 22.06.2016 11:36:21
X-TNEFEvaluated: 1
Subject: [PATCH krogoth+] fetch2: fix unpack of symbolic links
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
X-List-Received-Date: Wed, 22 Jun 2016 09:46:29 -0000

Files in the download directory can be symbolic links to the real file.
The fetcher must copy the real file instead of copying the symbolic
link. Otherwise other tasks will fail, like patching, or the recipe will
modify files in the download directory.

This patch fixes commit 865d2fef ("bitbake: fetch2: fixes copying of
file://dir; subdir=foo, bug 6128 and bug 6129").

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e8fbe89..a1819e7 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1423,7 +1423,9 @@ class FetchMethod(object):
                     if urlpath.find("/") != -1:
                         destdir = urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd = 'cp -fpPR %s %s' % (file, destdir)
+                # Use -L to always resolve symbolic links. Files in download
+                # directory can be links to the real file.
+                cmd = 'cp -fpLR %s %s' % (file, destdir)
 
         if not cmd:
             return
-- 
1.9.1


