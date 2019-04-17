Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id BF04C7C752
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 11:02:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x3HB2nqc023746
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 04:02:49 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 17 Apr 2019 04:02:49 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Apr 2019 19:01:49 +0800
Message-ID: <aa2657ac8c4b26061757d86867c39f9eee37c528.1555498609.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555498609.git.liezhi.yang@windriver.com>
References: <cover.1555498609.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/3 V2] bitbake-diffsigs: Use 4 spaces as indent for recursecb
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
X-List-Received-Date: Wed, 17 Apr 2019 11:02:48 -0000
Content-Type: text/plain

It used 2 spaces as indent which wasn't clear enough, and might cause
confusions, people might think it was in wrong format.

Fixed:
$ bitbake bc-native -ccleansstate -Snone
$ bitbake bc-native -ccleansstate -Snone
$ bitbake-diffsigs tmp/stamps/x86_64-linux/bc-native/1.07.1-r0.do_cleansstate.sigdata.*

* Before:
Hash for dependent task bc/bc_1.07.1.bb.do_clean:virtual:native changed from [foo]
  Taint (by forced/invalidated task) changed from [foo]
Taint (by forced/invalidated task) changed from [foo]

* Now
Hash for dependent task bc/bc_1.07.1.bb.do_clean:virtual:native changed from [foo]
    Taint (by forced/invalidated task) changed from [foo]
Taint (by forced/invalidated task) changed from [foo]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-diffsigs | 2 +-
 bitbake/lib/bb/runqueue.py   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index fa430bb..73229b7 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -105,7 +105,7 @@ def recursecb(key, hash1, hash2):
         out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb, color=color)
         for change in out2:
             for line in change.splitlines():
-                recout.append('  ' + line)
+                recout.append('    ' + line)
 
     return recout
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 329cda3..524c85d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1667,7 +1667,7 @@ class RunQueue:
             recout = []
             if len(hashfiles) == 2:
                 out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
-                recout.extend(list('  ' + l for l in out2))
+                recout.extend(list('    ' + l for l in out2))
             else:
                 recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
 
-- 
2.7.4


