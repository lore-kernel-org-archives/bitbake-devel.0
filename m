Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S5QcY-0001ST-9X
	for bitbake-devel@lists.openembedded.org;
	Thu, 08 Mar 2012 00:50:14 +0100
Received: by eekc1 with SMTP id c1so2124885eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Mar 2012 15:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=LFLX/kkyywMVk7j5JJVEm9WLY7GaHzmzFJl07uqMKwE=;
	b=EY0SiJe+/CBMi5bfW4RaT+FjL0swDCMQmNAaC/9NveR8Qhzmzvvw7iCreoMfB8rSKL
	qG08KtO2DGQ4e76XWTds2TJR9ueBWt7E97n/tmRyIrYGIJ6/Bvc/YTWO/URk2duxpPSS
	7mjnBIwTDKlPUs1735nALGAgbBicAs26WE+gvm3xQR6Ifh80VQQO3NjOnTnfoIf7LgbZ
	7sgEW80ErxMG4NcAzt9gi2syXSCkORCc9TBL+ZbkZbyANtNCbvsl5GPftj+UZwTHJL1C
	IMAcL//PSn+KPyq1KCBRJO60SE6WSz9N6thHYWtvMac/h5uRSIrooaToWp7BHzVYWjHg
	6zIQ==
Received: by 10.14.96.196 with SMTP id r44mr998699eef.87.1331163696926;
	Wed, 07 Mar 2012 15:41:36 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id v51sm92883048eef.2.2012.03.07.15.41.35
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 07 Mar 2012 15:41:36 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Mar 2012 00:41:27 +0100
Message-Id: <1331163687-7570-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.5
Subject: [PATCH] setup.py: remove bb.fetch package, code was dropped in 292e3430e5140b602cad86f55b5453e8cebb28a1
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
X-List-Received-Date: Wed, 07 Mar 2012 23:50:14 -0000

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 setup.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.py b/setup.py
index 7921811..bc2815d 100755
--- a/setup.py
+++ b/setup.py
@@ -53,7 +53,7 @@ setup(name='bitbake',
       version = __version__,
       requires = ["ply", "progressbar"],
       package_dir = {"": "lib"},
-      packages = ["bb.server", "bb.parse.parse_py", "bb.parse", "bb.fetch",
+      packages = ["bb.server", "bb.parse.parse_py", "bb.parse", 
                   "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb", "prserv"],
       py_modules = ["codegen"],
       scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv"],
-- 
1.7.8.5



