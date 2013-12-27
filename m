Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4ECB26B260
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Dec 2013 07:53:59 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBR7s05R028842
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Dec 2013 23:54:00 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.347.0;
	Thu, 26 Dec 2013 23:54:00 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Dec 2013 23:55:53 +0800
Message-ID: <c26d7a72feb5c465b89cbc719e97afec4a5c0892.1388159725.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1388159725.git.liezhi.yang@windriver.com>
References: <cover.1388159725.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: replace 3 spaces with 4
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
X-List-Received-Date: Fri, 27 Dec 2013 07:54:00 -0000
Content-Type: text/plain

A part of fetch2/__init__.py and yacc.py uses 3 spaces as the indent, I
think that they should be typos.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |  8 ++++----
 bitbake/lib/ply/yacc.py           | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 8fdf59c..439a44a 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1263,10 +1263,10 @@ class FetchMethod(object):
         return
 
     def clean(self, urldata, d):
-       """
-       Clean any existing full or partial download
-       """
-       bb.utils.remove(urldata.localpath)
+        """
+        Clean any existing full or partial download
+        """
+        bb.utils.remove(urldata.localpath)
 
     def try_premirror(self, urldata, d):
         """
diff --git a/bitbake/lib/ply/yacc.py b/bitbake/lib/ply/yacc.py
index 6168fd9..711987a 100644
--- a/bitbake/lib/ply/yacc.py
+++ b/bitbake/lib/ply/yacc.py
@@ -2589,9 +2589,9 @@ _lr_signature = %r
                 f.write("""
 _lr_action = { }
 for _k, _v in _lr_action_items.items():
-   for _x,_y in zip(_v[0],_v[1]):
-      if not _x in _lr_action:  _lr_action[_x] = { }
-      _lr_action[_x][_k] = _y
+    for _x,_y in zip(_v[0],_v[1]):
+        if not _x in _lr_action:  _lr_action[_x] = { }
+        _lr_action[_x][_k] = _y
 del _lr_action_items
 """)
 
@@ -2629,9 +2629,9 @@ del _lr_action_items
                 f.write("""
 _lr_goto = { }
 for _k, _v in _lr_goto_items.items():
-   for _x,_y in zip(_v[0],_v[1]):
-       if not _x in _lr_goto: _lr_goto[_x] = { }
-       _lr_goto[_x][_k] = _y
+    for _x,_y in zip(_v[0],_v[1]):
+        if not _x in _lr_goto: _lr_goto[_x] = { }
+        _lr_goto[_x][_k] = _y
 del _lr_goto_items
 """)
             else:
-- 
1.8.3.1


