Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C821175655
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 07:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4P7ol1D008848 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 08:50:47 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id imKJ5fuRKmE3 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 08:50:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4P7oXg9008843
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 08:50:44 +0100
Message-ID: <1432540233.29515.9.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 May 2015 08:50:33 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: cache: Clean up getVar usage to modern syntax/style
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
X-List-Received-Date: Mon, 25 May 2015 07:50:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

No functional change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index a1dde96..ef4d660 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -659,25 +659,25 @@ class Cache(object):
         """
         chdir_back = False
 
-        from bb import data, parse
+        from bb import parse
 
         # expand tmpdir to include this topdir
-        data.setVar('TMPDIR', data.getVar('TMPDIR', config, 1) or "", config)
+        config.setVar('TMPDIR', config.getVar('TMPDIR', True) or "")
         bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
         oldpath = os.path.abspath(os.getcwd())
         parse.cached_mtime_noerror(bbfile_loc)
-        bb_data = data.init_db(config)
+        bb_data = config.createCopy()
         # The ConfHandler first looks if there is a TOPDIR and if not
         # then it would call getcwd().
         # Previously, we chdir()ed to bbfile_loc, called the handler
         # and finally chdir()ed back, a couple of thousand times. We now
         # just fill in TOPDIR to point to bbfile_loc if there is no TOPDIR yet.
-        if not data.getVar('TOPDIR', bb_data):
+        if not bb_data.getVar('TOPDIR', False):
             chdir_back = True
-            data.setVar('TOPDIR', bbfile_loc, bb_data)
+            bb_data.setVar('TOPDIR', bbfile_loc)
         try:
             if appends:
-                data.setVar('__BBAPPEND', " ".join(appends), bb_data)
+                bb_data.setVar('__BBAPPEND', " ".join(appends))
             bb_data = parse.handle(bbfile, bb_data)
             if chdir_back:
                 os.chdir(oldpath)



