Return-Path: <alex@stunpix.com>
Received: from forward21o.cmail.yandex.net (forward21o.cmail.yandex.net
	[37.9.109.96])
	by mail.openembedded.org (Postfix) with ESMTP id 8C7736FF30
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 16:16:07 +0000 (UTC)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::25])
	by forward21o.cmail.yandex.net (Yandex) with ESMTP id 33499406C1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 19:16:07 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id 11858DE0244
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 19:16:06 +0300 (MSK)
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	pnjLZFcbn4-G6j4HdmH; Wed, 09 Mar 2016 19:16:06 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1457540166; bh=879Is+vmUhXvNdgajzuWJ84TekPoP8JZcGbMJQvTzzU=;
	h=From:To:Subject:Date:Message-Id:X-Mailer;
	b=DDZq7B4nOfkI6teyAixTMHhXCrODYNeJ2gNa7v5cBfebA5Q/Ld6/OvjOnDDf/iGG5
	lUlVbjs1U23ErUyGpqAmSlNcD+GSWL5y4hUv2eYeEzqfX/VQSZZGSYCvuYzv3Vd1Ic
	optECe9UB16sWNHVNJWgE2/pmVAr69g1CPxhDILI=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-Suid-Status: 1 0
From: Alexander Shashkevich <alex@stunpix.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 18:15:49 +0200
Message-Id: <1457540149-94456-1-git-send-email-alex@stunpix.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH v2] bb/fetch2: fixes copying of file://dir; subdir=foo, bug 6128 and bug 6129
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
X-List-Received-Date: Wed, 09 Mar 2016 16:16:09 -0000

When in SRC_URI appears file://dir;subdir=foo unpacker copies 'dir' to ${WORKDIR}, not
${WORKDIR}/foo as it should be.

These changes are fixing following bugs as well:
Bug 6128 - Incorrect wildcard unpack behaviour in fetcher
Bug 6129 - Local directories unpack to a different location than local files

Signed-off-by: Alexander Shashkevich <alex@stunpix.com>
---
 bitbake/lib/bb/fetch2/__init__.py                  | 61 +++++++++-------------
 bitbake/lib/bb/tests/fetch.py                      | 36 ++++++++++---
 .../qemu/nativesdk-qemu-helper_1.0.bb              | 22 ++++----
 3 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index a9c044b..8b59598 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1355,6 +1355,11 @@ class FetchMethod(object):
         iterate = False
         file = urldata.localpath
 
+        # Localpath can't deal with 'dir/*' entries, so it converts them to '.',
+        # but it must be corrected for local files copying
+        if urldata.basename == '*' and file.endswith('/.'):
+            file = '%s/%s' % (file.rstrip('/.'), urldata.path)
+
         try:
             unpack = bb.utils.to_boolean(urldata.parm.get('unpack'), True)
         except ValueError as exc:
@@ -1408,50 +1413,32 @@ class FetchMethod(object):
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 cmd = 'ar -p %s data.tar.gz | zcat | tar --no-same-owner -xpf -' % file
 
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
+                if urldata.type == "file" and not urldata.path.startswith("/"):
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
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 94173c1..b3de37e 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -451,9 +451,7 @@ class FetcherLocalTest(FetcherTest):
 
     def test_local_wildcard(self):
         tree = self.fetchUnpack(['file://a', 'file://dir/*'])
-        # FIXME: this is broken - it should return ['a', 'dir/c', 'dir/d', 'dir/subdir/e']
-        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=6128
-        self.assertEqual(tree, ['a', 'b', 'dir/c', 'dir/d', 'dir/subdir/e'])
+        self.assertEqual(tree, ['a',  'dir/c', 'dir/d', 'dir/subdir/e'])
 
     def test_local_dir(self):
         tree = self.fetchUnpack(['file://a', 'file://dir'])
@@ -461,22 +459,44 @@ class FetcherLocalTest(FetcherTest):
 
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
         self.assertEqual(tree, ['bar/dir/subdir/e'])
 
+    def test_local_abspathfiles(self):
+        abspath = 'file://%s' % self.localsrcdir
+        tree = self.fetchUnpack([abspath + '/a', abspath + '/dir/c'])
+        self.assertEqual(tree, ['a', 'c'])
+
+    def test_local_abspathdirs(self):
+        abspath = 'file://%s' % self.localsrcdir
+        tree = self.fetchUnpack([abspath + '/dir/subdir'])
+        self.assertEqual(tree, ['subdir/e'])
+
+    def test_local_abspathsubdirparam(self):
+        abspath = 'file://%s' % self.localsrcdir
+        tree = self.fetchUnpack([abspath + '/a;subdir=foo', abspath + '/dir/subdir;subdir=bar/foo'])
+        self.assertEqual(tree, ['bar/foo/subdir/e', 'foo/a'])
+
+    def test_local_trailingslash(self):
+        tree = self.fetchUnpack(['file://dir/subdir/', 'file://dir/subdir/;subdir=bar'])
+        self.assertEqual(tree, ['bar/dir/subdir/e', 'dir/subdir/e'])
+
+    def test_local_abspathtrailingslash(self):
+        abspath = 'file://%s' % self.localsrcdir
+        tree = self.fetchUnpack([abspath + '/dir/subdir/', abspath + '/dir/subdir/;subdir=bar'])
+        self.assertEqual(tree, ['bar/subdir/e', 'subdir/e'])
+
 class FetcherNetworkTest(FetcherTest):
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
diff --git a/meta/recipes-devtools/qemu/nativesdk-qemu-helper_1.0.bb b/meta/recipes-devtools/qemu/nativesdk-qemu-helper_1.0.bb
index 51d1c59..dc924f0 100644
--- a/meta/recipes-devtools/qemu/nativesdk-qemu-helper_1.0.bb
+++ b/meta/recipes-devtools/qemu/nativesdk-qemu-helper_1.0.bb
@@ -8,15 +8,15 @@ LIC_FILES_CHKSUM = "file://${WORKDIR}/tunctl.c;endline=4;md5=ff3a09996bc5fff6bc5
                     file://${COREBASE}/scripts/runqemu;endline=18;md5=77fbe442a88b1bcdc29c3ba67733b21b"
 
 
-SRC_URI = "file://${COREBASE}/scripts/runqemu \
-           file://${COREBASE}/scripts/runqemu-internal \
-           file://${COREBASE}/scripts/runqemu-addptable2image \
-           file://${COREBASE}/scripts/runqemu-gen-tapdevs \
-           file://${COREBASE}/scripts/runqemu-ifup \
-           file://${COREBASE}/scripts/runqemu-ifdown \
-           file://${COREBASE}/scripts/oe-find-native-sysroot \
-           file://${COREBASE}/scripts/runqemu-extract-sdk \
-           file://${COREBASE}/scripts/runqemu-export-rootfs \
+SRC_URI = "file://${COREBASE}/scripts/runqemu;subdir=scripts \
+           file://${COREBASE}/scripts/runqemu-internal;subdir=scripts \
+           file://${COREBASE}/scripts/runqemu-addptable2image;subdir=scripts \
+           file://${COREBASE}/scripts/runqemu-gen-tapdevs;subdir=scripts \
+           file://${COREBASE}/scripts/runqemu-ifup;subdir=scripts \
+           file://${COREBASE}/scripts/runqemu-ifdown;subdir=scripts \
+           file://${COREBASE}/scripts/oe-find-native-sysroot;subdir=scripts \
+           file://${COREBASE}/scripts/runqemu-extract-sdk;subdir=scripts \
+           file://${COREBASE}/scripts/runqemu-export-rootfs;subdir=scripts \
            file://tunctl.c \
            file://raw2flash.c \
           "
@@ -33,8 +33,8 @@ do_compile() {
 
 do_install() {
 	install -d ${D}${bindir}
-	install -m 0755 ${WORKDIR}${COREBASE}/scripts/oe-* ${D}${bindir}/
-	install -m 0755 ${WORKDIR}${COREBASE}/scripts/runqemu* ${D}${bindir}/
+	install -m 0755 ${WORKDIR}/scripts/oe-* ${D}${bindir}/
+	install -m 0755 ${WORKDIR}/scripts/runqemu* ${D}${bindir}/
 	install tunctl ${D}${bindir}/
 	install raw2flash.spitz ${D}${bindir}/
 	install flash2raw.spitz ${D}${bindir}/
-- 
2.5.0


