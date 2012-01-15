Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1RmXMd-0008TF-1L
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 22:11:43 +0100
Received: by eekd17 with SMTP id d17so1364594eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Jan 2012 13:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=IpU1rJYkIFz7S+qL/DwUWxlThdsmz3ZpX0w4wu1u1+g=;
	b=QLc5AEY/3W2tjkol+PNtn1MLt4ZPR0w3m/uPks1TgD3o3cYn9pEZdRnSOymsmDCvik
	flLifN2Uf3jWuQTCqZy6Np2e5YNlqyrlSCaGVHJdcFvfbvuQiaPGPnyMcUhM9Td4cWTQ
	OzZDqnMp/djkIVAx614mcZAB0TwFirrl511+s=
Received: by 10.213.19.204 with SMTP id c12mr2053136ebb.130.1326661444847;
	Sun, 15 Jan 2012 13:04:04 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id e12sm63334418eea.5.2012.01.15.13.04.02
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 15 Jan 2012 13:04:03 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Jan 2012 22:03:52 +0100
Message-Id: <1326661433-26379-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.3
Subject: [PATCH 1/2] setup.py: install prserv too
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 15 Jan 2012 21:11:43 -0000

* otherwise cooker fails:
  Traceback (most recent call last):
    File /usr/bin/bitbake, line 39, in <module>
      from bb import cooker
    File /usr/lib64/python2.7/site-packages/bb/cooker.py, line 39, in <module>
      import prserv.serv
  ImportError: No module named prserv.serv

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 setup.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.py b/setup.py
index 038dd87..7921811 100755
--- a/setup.py
+++ b/setup.py
@@ -54,9 +54,9 @@ setup(name='bitbake',
       requires = ["ply", "progressbar"],
       package_dir = {"": "lib"},
       packages = ["bb.server", "bb.parse.parse_py", "bb.parse", "bb.fetch",
-                  "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb"],
+                  "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb", "prserv"],
       py_modules = ["codegen"],
-      scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs"],
+      scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv"],
       data_files = [("share/bitbake", glob("conf/*") + glob("classes/*")),
                   ("share/doc/bitbake-%s/manual" % __version__, glob("doc/manual/html/*"))],
       cmdclass = {
-- 
1.7.8.3



