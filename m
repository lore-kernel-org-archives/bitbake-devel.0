Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B29DE6E71A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:44:44 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s0KBijRx008525
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 03:44:45 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.347.0;
	Mon, 20 Jan 2014 03:44:45 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 19:44:53 +0800
Message-ID: <9f7465db614c664c49904033aa70170278972932.1390218256.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1390218256.git.liezhi.yang@windriver.com>
References: <cover.1390218256.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] siggen.py: fix the SignatureGenerator()
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
X-List-Received-Date: Mon, 20 Jan 2014 11:44:44 -0000
Content-Type: text/plain

If we set:

BB_SIGNATURE_HANDLER = "noop"

Then we would get the following errors:

[snip]
File "runqueue.py", line 876, in RunQueue._start_worker(fakeroot=False, rqexec=None):
                "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
   >            "hashes" : bb.parse.siggen.taskhash,
                "hash_deps" : bb.parse.siggen.runtaskdeps,
AttributeError: 'SignatureGenerator' object has no attribute 'taskhash'
[snip]

This patch fixes the problem.

[YOCTO #5741]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/siggen.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 9db29a2..a54357a 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -34,7 +34,9 @@ class SignatureGenerator(object):
     name = "noop"
 
     def __init__(self, data):
-        return
+        self.taskhash = {}
+        self.runtaskdeps = {}
+        self.file_checksum_values = {}
 
     def finalise(self, fn, d, varient):
         return
@@ -42,7 +44,7 @@ class SignatureGenerator(object):
     def get_taskhash(self, fn, task, deps, dataCache):
         return "0"
 
-    def set_taskdata(self, hashes, deps):
+    def set_taskdata(self, hashes, deps, checksum):
         return
 
     def stampfile(self, stampbase, file_name, taskname, extrainfo):
-- 
1.8.3.1


