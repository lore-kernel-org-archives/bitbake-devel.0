Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1ST6Qe-00039w-5i
	for bitbake-devel@lists.openembedded.org;
	Sat, 12 May 2012 09:07:48 +0200
Received: by wibhm14 with SMTP id hm14so1725580wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2012 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=wmwLOelxeCmkNPejx2EcQgmnZ/kMystd7BpCDlnQ3qU=;
	b=Bcr/e3KZNnM3BTZ9XRsMu+xPVtK6C6QEgq36JvRkkMm6RtN2rlxL9+MTtStVLrKa8l
	2km36P2gAGg2SXTn74eJ0wP6ZgTdVxTPdUigbGd/UwQ1NNjVFoKE3FQZKTtvb1NZCWh0
	WM3g2r3IxbUw/qxKPcR1iSdDZzbqhbS/6iU4iz3fE7J/a/7JoLLHL1k8YJ7D5NiO+bjg
	yOicFrJRLuD685RWlvp17yxaUT2yHg8cEraPyLO1lzEi5ZaCVa+bmvxPIbB+7GuNCC3H
	vAL5ffDfYMPOO0qycA/1te5C+Rx766oViHm2v1AzMKYTx24IWnBIpZwBZkjYadEpYH29
	qNYw==
Received: by 10.180.88.233 with SMTP id bj9mr2209728wib.1.1336805871232;
	Fri, 11 May 2012 23:57:51 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id f19sm26150250wiw.11.2012.05.11.23.57.49
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 11 May 2012 23:57:49 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 12 May 2012 08:57:47 +0200
Message-Id: <1336805867-25625-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.6
Subject: [PATCH] setup.py: fix path for bitbake-selftest
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
X-List-Received-Date: Sat, 12 May 2012 07:07:48 -0000

* currently fails with:
  running build_scripts
  creating build/scripts-2.7
  copying and adjusting bin/bitbake -> build/scripts-2.7
  copying and adjusting bin/bitbake-layers -> build/scripts-2.7
  copying and adjusting bin/bitbake-diffsigs -> build/scripts-2.7
  copying and adjusting bin/bitbake-prserv -> build/scripts-2.7
  error: file '/tmp/tmpfs/portage/dev-embedded/bitbake-9999/work/bitbake-9999/bitbake-selftest' does not exist

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 setup.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.py b/setup.py
index 167692d..5f9e595 100755
--- a/setup.py
+++ b/setup.py
@@ -56,7 +56,7 @@ setup(name='bitbake',
       packages = ["bb.server", "bb.parse.parse_py", "bb.parse", 
                   "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb", "prserv", "bb.tests"],
       py_modules = ["codegen"],
-      scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv", "bitbake-selftest"],
+      scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv", "bin/bitbake-selftest"],
       data_files = [("share/bitbake", glob("conf/*") + glob("classes/*")),
                   ("share/doc/bitbake-%s/manual" % __version__, glob("doc/manual/html/*"))],
       cmdclass = {
-- 
1.7.8.6



