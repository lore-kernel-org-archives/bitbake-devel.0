Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8BC0E787FC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jan 2018 08:57:26 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w0I8vRBR003521
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jan 2018 00:57:27 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 18 Jan 2018 00:57:26 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 18 Jan 2018 16:57:41 +0800
Message-ID: <9a21e82b35b935826dd28413684f0918c00f9eb0.1516265726.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1516265726.git.liezhi.yang@windriver.com>
References: <cover.1516265726.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] parse: don't add attempted files to dependencies
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
X-List-Received-Date: Thu, 18 Jan 2018 08:57:26 -0000
Content-Type: text/plain

The attempts are the files that it tries to search but don't exist, it
searches the file in BBPATH until find it, so the attempts might be very long
when there are many layers, which causes bb_cache.dat very big (I have 54 layers,
the bb_cache.dat can be 119M, and even much bigger depends on the order of BBLAYERS).

Here is the testing data of 54 layers before and after the patch.

                    Before          After
Parsing time        33s             9s
Loading time        30s             5s
Cache size          119M            20M

The time and size can be more or less depends on the order of BBLAYERS before
the patch.

I checked the code, but didn't find why we need the attempts as dependencies,
the one that I can think of is the file doesn't exist when parsing, and added
to the attempts location after parsing, but the parseBaseConfiguration() can
detect and handle this well (and will cause reparse in such a case), so I think
that we can safely remove them from dependencies since they have side effects.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/parse/__init__.py             | 2 --
 lib/bb/parse/parse_py/BBHandler.py   | 3 ---
 lib/bb/parse/parse_py/ConfHandler.py | 2 --
 3 files changed, 7 deletions(-)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 2fc4002..a96124f 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -129,8 +129,6 @@ def resolve_file(fn, d):
     if not os.path.isabs(fn):
         bbpath = d.getVar("BBPATH")
         newfn, attempts = bb.utils.which(bbpath, fn, history=True)
-        for af in attempts:
-            mark_dependency(d, af)
         if not newfn:
             raise IOError(errno.ENOENT, "file %s not found in %s" % (fn, bbpath))
         fn = newfn
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index f89ad24..48804e9 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -68,9 +68,6 @@ def inherit(files, fn, lineno, d):
         if not os.path.isabs(file):
             bbpath = d.getVar("BBPATH")
             abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
-            for af in attempts:
-                if af != abs_fn:
-                    bb.parse.mark_dependency(d, af)
             if abs_fn:
                 file = abs_fn
 
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 97aa130..ea3eba0 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -95,8 +95,6 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
         abs_fn, attempts = bb.utils.which(bbpath, fn, history=True)
         if abs_fn and bb.parse.check_dependency(data, abs_fn):
             logger.warning("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE')))
-        for af in attempts:
-            bb.parse.mark_dependency(data, af)
         if abs_fn:
             fn = abs_fn
     elif bb.parse.check_dependency(data, fn):
-- 
2.7.4


