Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 213067875C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:15:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w11FFCI0021110
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:15:12 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:15:11 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:27 +0800
Message-ID: <d3b070a54511d9396249dd771a78599f00e6d1cc.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 6/8] bitbake: parse: fixes for resolve_file()
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
X-List-Received-Date: Thu, 01 Feb 2018 15:15:11 -0000
Content-Type: text/plain

The resolve_file() calls mark_dependency(), so the one which calls
resolve_file() doesn't need call mark_dependency() again.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/parse/__init__.py             | 3 ++-
 bitbake/lib/bb/parse/parse_py/BBHandler.py   | 3 ---
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 3 ---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 2fc4002..5397d57 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -134,8 +134,9 @@ def resolve_file(fn, d):
         if not newfn:
             raise IOError(errno.ENOENT, "file %s not found in %s" % (fn, bbpath))
         fn = newfn
+    else:
+        mark_dependency(d, fn)
 
-    mark_dependency(d, fn)
     if not os.path.isfile(fn):
         raise IOError(errno.ENOENT, "file %s not found" % fn)
 
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index f89ad24..e5039e3 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -131,9 +131,6 @@ def handle(fn, d, include):
 
     abs_fn = resolve_file(fn, d)
 
-    if include:
-        bb.parse.mark_dependency(d, abs_fn)
-
     # actual loading
     statements = get_statements(fn, abs_fn, base_name)
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 97aa130..9d3ebe1 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -134,9 +134,6 @@ def handle(fn, data, include):
     abs_fn = resolve_file(fn, data)
     f = open(abs_fn, 'r')
 
-    if include:
-        bb.parse.mark_dependency(data, abs_fn)
-
     statements = ast.StatementGroup()
     lineno = 0
     while True:
-- 
2.7.4


