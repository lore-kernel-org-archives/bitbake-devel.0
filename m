Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1ECBB6D74B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Jun 2019 06:35:55 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x5R6Ztxr020971
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 23:35:56 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 26 Jun 2019 23:35:55 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 27 Jun 2019 14:59:47 +0800
Message-ID: <c10318f78e7b7f877309751a9771aae93326f6e1.1561617701.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561617701.git.liezhi.yang@windriver.com>
References: <cover.1561617701.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake: lib: Cleanup /usr/bin/env python
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
X-List-Received-Date: Thu, 27 Jun 2019 06:35:55 -0000
Content-Type: text/plain

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py                     | 1 -
 bitbake/lib/bb/cookerdata.py                 | 1 -
 bitbake/lib/bb/main.py                       | 1 -
 bitbake/lib/bb/monitordisk.py                | 1 -
 bitbake/lib/bb/namedtuple_with_abc.py        | 1 -
 bitbake/lib/bb/parse/parse_py/BBHandler.py   | 1 -
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 1 -
 bitbake/lib/bb/parse/parse_py/__init__.py    | 1 -
 bitbake/lib/bb/runqueue.py                   | 1 -
 bitbake/lib/bb/taskdata.py                   | 1 -
 bitbake/lib/pyinotify.py                     | 3 +--
 11 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0008c2f..b4851e1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 842275d..e64c6c5 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index ca59eb9..bd11619 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 69b25c7..1a25b00 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 #
 # Copyright (C) 2012 Robert Yang
 #
diff --git a/bitbake/lib/bb/namedtuple_with_abc.py b/bitbake/lib/bb/namedtuple_with_abc.py
index c8e1d55..646aed6 100644
--- a/bitbake/lib/bb/namedtuple_with_abc.py
+++ b/bitbake/lib/bb/namedtuple_with_abc.py
@@ -1,5 +1,4 @@
 # http://code.activestate.com/recipes/577629-namedtupleabc-abstract-base-class-mix-in-for-named/
-#!/usr/bin/env python
 # Copyright (c) 2011 Jan Kaliszewski (zuo). Available under the MIT License.
 #
 # SPDX-License-Identifier: MIT
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 889f230..6f7cf82 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 """
    class for handling .bb files
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 71bf61b..2e84b91 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 """
    class for handling configuration data files
 
diff --git a/bitbake/lib/bb/parse/parse_py/__init__.py b/bitbake/lib/bb/parse/parse_py/__init__.py
index cdebe44..f508afa 100644
--- a/bitbake/lib/bb/parse/parse_py/__init__.py
+++ b/bitbake/lib/bb/parse/parse_py/__init__.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 """
 BitBake Parsers
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 010b085..58707db 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 """
 BitBake 'RunQueue' implementation
 
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index d13bd7c..8c25e09 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 """
 BitBake 'TaskData' implementation
 
diff --git a/bitbake/lib/pyinotify.py b/bitbake/lib/pyinotify.py
index 9dcfd0d..1528a22 100644
--- a/bitbake/lib/pyinotify.py
+++ b/bitbake/lib/pyinotify.py
@@ -1,5 +1,4 @@
-#!/usr/bin/env python
-
+#
 # pyinotify.py - python interface to inotify
 # Copyright (c) 2005-2015 Sebastien Martini <seb@dbzteam.org>
 #
-- 
2.7.4


