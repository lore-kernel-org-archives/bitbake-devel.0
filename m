Return-Path: <alex@stunpix.com>
Received: from forward10o.cmail.yandex.net (forward10o.cmail.yandex.net
	[37.9.109.60])
	by mail.openembedded.org (Postfix) with ESMTP id 1CA737710D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 16:32:50 +0000 (UTC)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::25])
	by forward10o.cmail.yandex.net (Yandex) with ESMTP id F19C321768
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 19:32:48 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id B8C7EDE129F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 19:32:48 +0300 (MSK)
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	7Lu53dV1BH-Wm8qh22t; Thu, 25 Feb 2016 19:32:48 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1456417968; bh=ERNE9g0IafGCHANdyDSXI7y3pm2aBAoYC6JPy6QlRLA=;
	h=From:To:Subject:Date:Message-Id:X-Mailer;
	b=QbSsisf9MpwqSnD2zvuSA3hAq9CmmfbywT/ZHZJdRqwycPpyVsWLV/cUj5r3AbnTJ
	g6Z0Ed2nQXdJniL2xR5QIPjVpJ8KR9Ers2Dk8OS7ONSQlaj25WlUee46E/1E/pJcf7
	ReR1Uj0BQYd4v3yyKopJKHbul3baZLQtfV+D8Xo4=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0
From: Alexander Shashkevich <alex@stunpix.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 18:32:31 +0200
Message-Id: <1456417951-11336-1-git-send-email-alex@stunpix.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bb/fetch2: fixes copying of file://dir; subdir=foo, bug 6128 and bug 6129
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
X-List-Received-Date: Thu, 25 Feb 2016 16:32:52 -0000

When in SRC_URI appears file://dir;subdir=foo unpacker copies 'dir' to ${WORKDIR}, not
${WORKDIR}/foo as it should be.

These changes are fixing following bugs as well:
Bug 6128 - Incorrect wildcard unpack behaviour in fetcher
Bug 6129 - Local directories unpack to a different location than local files

Signed-off-by: Alexander Shashkevich <alex@stunpix.com>
---
 lib/bb/fetch2/__init__.py | 61 +++++++++++++++++++----------------------------
 lib/bb/tests/fetch.py     | 12 ++++------
 2 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c3dcfd2..1d9a66f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1343,6 +1343,11 @@ class FetchMethod(object):
         iterate = False
         file = urldata.localpath
 
+        # Localpath can't deal with 'dir/*' entries, so it converts them to '.',
+        # but it must be corrected back for local files copying
+        if urldata.basename == '*' and file.endswith('/.'):
+            file = '%s/%s' % (file.rstrip('/.'), urldata.path)
+
         try:
             unpack = bb.utils.to_boolean(urldata.parm.get('unpack'), True)
         except ValueError as exc:
@@ -1400,50 +1405,32 @@ class FetchMethod(object):
             elif file.endswith('.7z'):
                 cmd = '7za x -y %s 1>/dev/null' % file
 
+        # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
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
+                    urlpath = urldata.path.rstrip('/') # Trailing '/' does a copying to wrong place
+                    if urlpath.find("/") != -1:
+                        destdir = urlpath.rsplit("/", 1)[0] + '/'
+                        bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
+                cmd = 'cp -fpPR %s %s' % (file, destdir)
 
         if not cmd:
             return
 
-        # Change to subdir before executing command
+        # Change to unpackdir before executing command
         save_cwd = os.getcwd();
-        os.chdir(rootdir)
-        if 'subdir' in urldata.parm:
-            newdir = ("%s/%s" % (rootdir, urldata.parm.get('subdir')))
-            bb.utils.mkdirhier(newdir)
-            os.chdir(newdir)
+        os.chdir(unpackdir)
 
         path = data.getVar('PATH', True)
         if path:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 81b22d0..850e2ba 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -451,9 +451,7 @@ class FetcherLocalTest(FetcherTest):
 
     def test_local_wildcard(self):
         tree = self.fetchUnpack(['file://a', 'file://dir/*'])
-        # FIXME: this is broken - it should return ['a', 'dir/c', 'dir/d', 'dir/subdir/e']
-        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=6128
-        self.assertEqual(tree, ['a', 'b', 'dir/c', 'dir/d', 'dir/subdir/e'])
+        self.assertEqual(tree, ['a',  'dir/c', 'dir/d', 'dir/subdir/e'])
 
     def test_local_dir(self):
         tree = self.fetchUnpack(['file://a', 'file://dir'])
@@ -461,17 +459,15 @@ class FetcherLocalTest(FetcherTest):
 
     def test_local_subdir(self):
         tree = self.fetchUnpack(['file://dir/subdir'])
-        # FIXME: this is broken - it should return ['dir/subdir/e']
-        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=6129
-        self.assertEqual(tree, ['subdir/e'])
+        self.assertEqual(tree, ['dir/subdir/e'])
 
     def test_local_subdir_file(self):
         tree = self.fetchUnpack(['file://dir/subdir/e'])
         self.assertEqual(tree, ['dir/subdir/e'])
 
     def test_local_subdirparam(self):
-        tree = self.fetchUnpack(['file://a;subdir=bar'])
-        self.assertEqual(tree, ['bar/a'])
+        tree = self.fetchUnpack(['file://a;subdir=bar', 'file://dir;subdir=foo/moo'])
+        self.assertEqual(tree, ['bar/a', 'foo/moo/dir/c', 'foo/moo/dir/d', 'foo/moo/dir/subdir/e'])
 
     def test_local_deepsubdirparam(self):
         tree = self.fetchUnpack(['file://dir/subdir/e;subdir=bar'])
-- 
2.1.4


