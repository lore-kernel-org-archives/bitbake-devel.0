Return-Path: <liu.ming50@gmail.com>
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id 72464771E0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 18:15:46 +0000 (UTC)
Received: by lfs39 with SMTP id 39so57188400lfs.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=aSwNCHhlnz1RtM1MLfcF8VwIPGiF5rdCSaTf0GNA3hI=;
	b=YBGSaN5DsKRh5Kpay3McAxihmQ+rlkCKN8yOCgV8CB0El4r1cAjAgBROnjjT2hoYAp
	DGvOqn8J4WKo4A2hazyKS7uVDJnSDFBafyBxmeubYV+hFj8b5wiAWAKLChlP1Wg1LOKJ
	jAwttbyVCiN2K36i5sYWEmoD9FyILioE/zKJwJ21/UWDmgSuE/XCUECv4XQ0EzwLfh8D
	zbXHfF5KKXVmdh3aoqniM0V1n6wb+SI5hESaez8lMCZXevYpCsGhIVggRP8M8WZBErWH
	7Wi0t5InW1lIPvTp1Ja2yYOB5DJ70czQSwiPGB6BnF8sL9c2+au7WhJNsnPqW58SzClz
	5faw==
X-Received: by 10.25.151.199 with SMTP id z190mr11222050lfd.122.1447438546608; 
	Fri, 13 Nov 2015 10:15:46 -0800 (PST)
Received: from localhost.localdomain (m77-218-247-203.cust.tele2.se.
	[77.218.247.203]) by smtp.gmail.com with ESMTPSA id
	au8sm3290941lbc.31.2015.11.13.10.15.45
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 Nov 2015 10:15:46 -0800 (PST)
From: Ming Liu <liu.ming50@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Nov 2015 19:15:31 +0100
Message-Id: <1447438532-9595-1-git-send-email-liu.ming50@gmail.com>
X-Mailer: git-send-email 1.9.1
Cc: Ming Liu <peter.x.liu@external.atlascopco.com>
Subject: [OE-core] [PATCH 1/2] fetch2/__init__.py: Extend subdir unpack parameter to local folder
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
X-List-Received-Date: Fri, 13 Nov 2015 18:15:52 -0000

From: Ming Liu <peter.x.liu@external.atlascopco.com>

This fixes urls of the form file://some/path/file;subdir=b. When
the file is a folder.

Also tweaks the way to get subdir parameter, storing it into a variable
instead of calling urldata.parm.get() multiple times.

Signed-off-by: Ming Liu <peter.x.liu@external.atlascopco.com>
---
 lib/bb/fetch2/__init__.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 288a1c8..d7439fa 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1412,6 +1412,7 @@ class FetchMethod(object):
             # If file == dest, then avoid any copies, as we already put the file into dest!
             dest = os.path.join(rootdir, os.path.basename(file))
             if (file != dest) and not (os.path.exists(dest) and os.path.samefile(file, dest)):
+                subdir = urldata.parm.get('subdir')
                 if os.path.isdir(file):
                     # If for example we're asked to copy file://foo/bar, we need to unpack the result into foo/bar
                     basepath = getattr(urldata, "basepath", None)
@@ -1423,6 +1424,8 @@ class FetchMethod(object):
                     if basepath and basepath.find("/") != -1:
                         destdir = basepath[:basepath.rfind('/')]
                         destdir = destdir.strip('/')
+                    if subdir:
+                        destdir = subdir + "/" + destdir
                     if destdir != "." and not os.access("%s/%s" % (rootdir, destdir), os.F_OK):
                         os.makedirs("%s/%s" % (rootdir, destdir))
                     cmd = 'cp -fpPR %s %s/%s/' % (file, rootdir, destdir)
@@ -1432,11 +1435,11 @@ class FetchMethod(object):
                     # items.  So, only do so for file:// entries.
                     if urldata.type == "file" and urldata.path.find("/") != -1:
                        destdir = urldata.path.rsplit("/", 1)[0]
-                       if urldata.parm.get('subdir') != None:
-                          destdir = urldata.parm.get('subdir') + "/" + destdir
+                       if subdir:
+                          destdir = subdir + "/" + destdir
                     else:
-                       if urldata.parm.get('subdir') != None:
-                          destdir = urldata.parm.get('subdir')
+                       if subdir:
+                          destdir = subdir
                        else:
                           destdir = "."
                     bb.utils.mkdirhier("%s/%s" % (rootdir, destdir))
-- 
1.9.1


