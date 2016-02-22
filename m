Return-Path: <alex@stunpix.com>
X-Greylist: delayed 433 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 22 Feb 2016 18:42:08 UTC
Received: from forward6o.cmail.yandex.net (forward6o.cmail.yandex.net
	[37.9.109.52])
	by mail.openembedded.org (Postfix) with ESMTP id D842477199
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 18:42:08 +0000 (UTC)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::27])
	by forward6o.cmail.yandex.net (Yandex) with ESMTP id 06EEF2152E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 21:34:52 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id C99491E39B6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 21:34:52 +0300 (MSK)
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	YiD7WdRt4M-YqkuQVOE; Mon, 22 Feb 2016 21:34:52 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1456166092; bh=To02i4h3Dc1BAYY84IrlKmyhQiVYkDUgar4Jqsmd5EA=;
	h=From:To:Subject:Date:Message-Id:X-Mailer;
	b=NN9gU4BoVzv42e2I3Bbb6bntYbHtkjmD2Y2SxFw3g1y4SYVVeBq8lB7qbBtkrNiVW
	2NbvB3HhhvgcqeIhxGE7hR5bpjM61s1Sc/UIMlkBH5om1cdWd/NhDitY3Bh5wX/vEe
	V2V7pYx1gPVBAGr7mFLb+2zyGH8VRJzmIDl8uYbk=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0
From: Alexander Shashkevich <alex@stunpix.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 20:34:51 +0200
Message-Id: <1456166091-13075-1-git-send-email-alex@stunpix.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bb/fetch2: broken functionality for entries like file://dir; subdir=foo in SRC_URI
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
X-List-Received-Date: Mon, 22 Feb 2016 18:42:10 -0000

For SRC_URI entries like file://dir1;subdir=foo1 and file://dir2/dir3;subdir=foo2/foo3
subdirectories ${WORKDIR}/foo1 and ${WORKDIR}/foo2/foo3 are created, but dir1 and dir2/dir3 are
only copied to ${WORKDIR}/dir1 and ${WORKDIR}/dir2/dir. Correct way: directories must be copied/unpacked
into '${WORKDIR}/foo1/dir1' and '${WORKDIR}/foo2/foo3/dir2/dir' respectively.

Signed-off-by: Alexander Shashkevich <alex@stunpix.com>
---
 lib/bb/fetch2/__init__.py | 55 ++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c3dcfd2..87486b2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1400,50 +1400,31 @@ class FetchMethod(object):
             elif file.endswith('.7z'):
                 cmd = '7za x -y %s 1>/dev/null' % file
 
+        if 'subdir' in urldata.parm:
+            unpackdir = '%s/%s' % (rootdir, urldata.parm.get('subdir'))
+            bb.utils.mkdirhier(unpackdir)
+        else:
+            unpackdir = rootdir
+
         if not unpack or not cmd:
             # If file == dest, then avoid any copies, as we already put the file into dest!
-            dest = os.path.join(rootdir, os.path.basename(file))
-            if (file != dest) and not (os.path.exists(dest) and os.path.samefile(file, dest)):
-                if os.path.isdir(file):
-                    # If for example we're asked to copy file://foo/bar, we need to unpack the result into foo/bar
-                    basepath = getattr(urldata, "basepath", None)
-                    destdir = "."
-                    if basepath and basepath.endswith("/"):
-                        basepath = basepath.rstrip("/")
-                    elif basepath:
-                        basepath = os.path.dirname(basepath)
-                    if basepath and basepath.find("/") != -1:
-                        destdir = basepath[:basepath.rfind('/')]
-                        destdir = destdir.strip('/')
-                    if destdir != "." and not os.access("%s/%s" % (rootdir, destdir), os.F_OK):
-                        os.makedirs("%s/%s" % (rootdir, destdir))
-                    cmd = 'cp -fpPR %s %s/%s/' % (file, rootdir, destdir)
-                    #cmd = 'tar -cf - -C "%d" -ps . | tar -xf - -C "%s/%s/"' % (file, rootdir, destdir)
-                else:
-                    # The "destdir" handling was specifically done for FILESPATH
-                    # items.  So, only do so for file:// entries.
-                    if urldata.type == "file" and urldata.path.find("/") != -1:
-                       destdir = urldata.path.rsplit("/", 1)[0]
-                       if urldata.parm.get('subdir') != None:
-                          destdir = urldata.parm.get('subdir') + "/" + destdir
-                    else:
-                       if urldata.parm.get('subdir') != None:
-                          destdir = urldata.parm.get('subdir')
-                       else:
-                          destdir = "."
-                    bb.utils.mkdirhier("%s/%s" % (rootdir, destdir))
-                    cmd = 'cp -f %s %s/%s/' % (file, rootdir, destdir)
+            dest = os.path.join(unpackdir, os.path.basename(file))
+            if file != dest and not (os.path.exists(dest) and os.path.samefile(file, dest)):
+                destdir = '.'
+                # For file:// entries all intermediate dirs in path must be created at destination
+                if urldata.type == "file":
+                    urlpath = urldata.path.rstrip('/') # Trailing '/' makes copy to wrong place
+                    if urlpath.find("/") != -1:
+                        destdir = urlpath.rsplit("/", 1)[0] + '/'
+                        bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
+                cmd = 'cp -fpPR %s %s' % (file, destdir)
 
         if not cmd:
             return
 
-        # Change to subdir before executing command
+        # Change to workdir before executing command
         save_cwd = os.getcwd();
-        os.chdir(rootdir)
-        if 'subdir' in urldata.parm:
-            newdir = ("%s/%s" % (rootdir, urldata.parm.get('subdir')))
-            bb.utils.mkdirhier(newdir)
-            os.chdir(newdir)
+        os.chdir(unpackdir)
 
         path = data.getVar('PATH', True)
         if path:
-- 
2.1.4


