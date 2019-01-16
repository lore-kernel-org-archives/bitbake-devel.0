Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 605817C1B5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Jan 2019 06:12:55 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0G6CZsA023906
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 22:12:46 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Tue, 15 Jan 2019 22:12:25 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Jan 2019 14:30:41 +0800
Message-ID: <52961ec262083777d20e7711fb5b1f2b9d3196ee.1547620210.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547620210.git.liezhi.yang@windriver.com>
References: <cover.1547620210.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] bb: siggen: Add a prefix for uuid4
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
X-List-Received-Date: Wed, 16 Jan 2019 06:12:55 -0000
Content-Type: text/plain

This can make bitbake-diffsigs and dumpsig easier to understand, otherwise,
it's hard to know it is a random uuid unless look into the code.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/build.py  | 2 +-
 bitbake/lib/bb/siggen.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 3e2a94e..b8f5cd6 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -767,7 +767,7 @@ def write_taint(task, d, file_name = None):
     # The specific content of the taint file is not really important,
     # we just need it to be random, so a random UUID is used
     with open(taintfn, 'w') as taintf:
-        taintf.write(str(uuid.uuid4()))
+        taintf.write('uuid4-%s' % str(uuid.uuid4()))
 
 def stampfile(taskname, d, file_name = None, noextra=False):
     """
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 66aea79..a0ca7e1 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -206,7 +206,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if 'nostamp' in taskdep and task in taskdep['nostamp']:
             # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
             import uuid
-            taint = str(uuid.uuid4())
+            taint = 'uuid4-%s' % str(uuid.uuid4())
             data = data + taint
             self.taints[k] = "nostamp:" + taint
 
-- 
2.7.4


