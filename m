Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHkn-00049Z-Hb
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:55:53 +0100
Received: by opal (Postfix, from userid 111)
	id 6919E10337; Fri, 20 Jan 2012 16:57:48 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120165748.6919E10337@opal>
Date: Fri, 20 Jan 2012 16:57:48 +0000 (UTC)
From: git@git.openembedded.org
Subject: Martin Jansa : setup.py: install prserv too
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
X-List-Received-Date: Fri, 20 Jan 2012 16:55:53 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: b4a40c2139e0a8c089ef9aba0796b40470b38e6c
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=b4a40c2139e0a8c089ef9aba0796b40470b38e6c

Author: Martin Jansa <martin.jansa@gmail.com>
Date:   Sun Jan 15 22:03:52 2012 +0100

setup.py: install prserv too

* otherwise cooker fails:
  Traceback (most recent call last):
    File /usr/bin/bitbake, line 39, in <module>
      from bb import cooker
    File /usr/lib64/python2.7/site-packages/bb/cooker.py, line 39, in <module>
      import prserv.serv
  ImportError: No module named prserv.serv

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 setup.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.py b/setup.py
index 581a24c..3f9899e 100755
--- a/setup.py
+++ b/setup.py
@@ -54,9 +54,9 @@ setup(name='bitbake',
       requires = ["ply", "progressbar", "futures"],
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



