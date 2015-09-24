Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 30EE67404E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 08:20:15 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t8O8KFvu015958
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 01:20:16 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.235.1;
	Thu, 24 Sep 2015 01:20:15 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Sep 2015 01:20:14 -0700
Message-ID: <8fff4dfd0ebbd8d187ab75a83e6741dd465b7a7e.1443082777.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1443082777.git.liezhi.yang@windriver.com>
References: <cover.1443082777.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] siggen.py: fix clean_basepath()
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
X-List-Received-Date: Thu, 24 Sep 2015 08:20:16 -0000
Content-Type: text/plain

Fixed:
$ bitbake-diffsigs tmp/stamps/x86_64-linux/quilt-native/0.64-r0.do_patch.sigdata.foo tmp/stamps/x86_64-linux/quilt-native/0.64-r0.do_fetch.sigdata.foo
[snip]
runtaskdeps changed from ['quiltquilt-native_0.64.bb.do_unpack'] to []

Note the "quiltquilt-native".

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/siggen.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 2985272..46fd2fc 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -303,7 +303,7 @@ def dump_this_task(outfile, d):
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile")
 
 def clean_basepath(a):
-    b = a.rsplit("/", 2)[1] + a.rsplit("/", 2)[2]
+    b = a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
         b = b + ":" + a.rsplit(":", 1)[0]
     return b
-- 
1.7.9.5


