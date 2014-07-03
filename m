Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A69716ACC6
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jul 2014 06:27:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s636RUrf026650
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 2 Jul 2014 23:27:30 -0700 (PDT)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Wed, 2 Jul 2014 23:27:26 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Jul 2014 14:42:06 +0800
Message-ID: <7361f79c4044c3a66dfa3d695611002b5abfab11.1404369560.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1404369559.git.liezhi.yang@windriver.com>
References: <cover.1404369559.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] bitbake: lib: fix no newline at end of file
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
X-List-Received-Date: Thu, 03 Jul 2014 06:27:28 -0000
Content-Type: text/plain

Add a '\n' to the last line of the file to fix:

No newline at end of file

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/pysh/sherrors.py | 2 +-
 bitbake/lib/prserv/__init__.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/pysh/sherrors.py b/bitbake/lib/bb/pysh/sherrors.py
index 1d5bd53..49d0533 100644
--- a/bitbake/lib/bb/pysh/sherrors.py
+++ b/bitbake/lib/bb/pysh/sherrors.py
@@ -38,4 +38,4 @@ class ExitSignal(ShellError):
     
 class ReturnSignal(ShellError):
     """Exit signal."""
-    pass
\ No newline at end of file
+    pass
diff --git a/bitbake/lib/prserv/__init__.py b/bitbake/lib/prserv/__init__.py
index 0e0c98b..c3cb73a 100644
--- a/bitbake/lib/prserv/__init__.py
+++ b/bitbake/lib/prserv/__init__.py
@@ -11,4 +11,4 @@ def init_logger(logfile, loglevel):
     logging.basicConfig(level=numeric_level, filename=logfile, format=FORMAT)
 
 class NotFoundError(Exception):
-    pass
\ No newline at end of file
+    pass
-- 
1.8.3.1


