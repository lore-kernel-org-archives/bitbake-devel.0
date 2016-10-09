Return-Path: <Kai.Kang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A11CE719CC
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Oct 2016 08:34:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u998YaUL003211
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 9 Oct 2016 01:34:36 -0700 (PDT)
Received: from k-desktop.wrs.com (128.224.162.231) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.294.0;
	Sun, 9 Oct 2016 01:34:35 -0700
From: <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 9 Oct 2016 16:34:32 +0800
Message-ID: <20161009083432.12803-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Subject: [PATCH] COW.py: fix sample codes
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
X-List-Received-Date: Sun, 09 Oct 2016 08:34:35 -0000
Content-Type: text/plain

From: Kai Kang <kai.kang@windriver.com>

The call of methods iteritems() and itervalues() in sample codes were
replaced by items() and values() to convert to Python 3 by Bitbake rev
d0f904d407f57998419bd9c305ce53e5eaa36b24. But the methods iteritems()
and itervalues() belong to class COWDictMeta not class dict or set. The
modifications should not be made in purpose that it fails to run sample
codes, so revert them.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 bitbake/lib/bb/COW.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/COW.py b/bitbake/lib/bb/COW.py
index 77a05cf..36ebbd9 100644
--- a/bitbake/lib/bb/COW.py
+++ b/bitbake/lib/bb/COW.py
@@ -213,11 +213,11 @@ if __name__ == "__main__":
     print()
 
     print("a", a)
-    for x in a.items():
+    for x in a.iteritems():
         print(x)
     print("--")
     print("b", b)
-    for x in b.items():
+    for x in b.iteritems():
         print(x)
     print()
 
@@ -225,11 +225,11 @@ if __name__ == "__main__":
     b['a'] = 'c'
 
     print("a", a)
-    for x in a.items():
+    for x in a.iteritems():
         print(x)
     print("--")
     print("b", b)
-    for x in b.items():
+    for x in b.iteritems():
         print(x)
     print()
 
@@ -244,22 +244,22 @@ if __name__ == "__main__":
     a['set'].add("o2")
 
     print("a", a)
-    for x in a['set'].values():
+    for x in a['set'].itervalues():
         print(x)
     print("--")
     print("b", b)
-    for x in b['set'].values():
+    for x in b['set'].itervalues():
         print(x)
     print()
 
     b['set'].add('o3')
 
     print("a", a)
-    for x in a['set'].values():
+    for x in a['set'].itervalues():
         print(x)
     print("--")
     print("b", b)
-    for x in b['set'].values():
+    for x in b['set'].itervalues():
         print(x)
     print()
 
@@ -269,7 +269,7 @@ if __name__ == "__main__":
     a['set2'].add("o2")
 
     print("a", a)
-    for x in a.items():
+    for x in a.iteritems():
         print(x)
     print("--")
     print("b", b)
@@ -289,7 +289,7 @@ if __name__ == "__main__":
         print("Yay - has_key with delete works!")
 
     print("a", a)
-    for x in a.items():
+    for x in a.iteritems():
         print(x)
     print("--")
     print("b", b)
@@ -300,7 +300,7 @@ if __name__ == "__main__":
     b.__revertitem__('b')
 
     print("a", a)
-    for x in a.items():
+    for x in a.iteritems():
         print(x)
     print("--")
     print("b", b)
@@ -310,7 +310,7 @@ if __name__ == "__main__":
 
     b.__revertitem__('dict')
     print("a", a)
-    for x in a.items():
+    for x in a.iteritems():
         print(x)
     print("--")
     print("b", b)
-- 
2.10.0


