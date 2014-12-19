Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3F395728F2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 10:20:51 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 19 Dec 2014 02:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,606,1413270000"; d="scan'208";a="640218079"
Received: from khamid-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.31.61])
	by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2014 02:20:49 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Dec 2014 10:20:29 +0000
Message-Id: <79cdd488775ff1feab60c83bf52255d7031af76c.1418984377.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] siggen: ensure nostamp tasks force dependent tasks to re-execute
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
X-List-Received-Date: Fri, 19 Dec 2014 10:20:53 -0000

If a nostamp task is depended on by a non-nostamp task, then we want the
signature of that task to change such that it re-executes afterwards.
This is an unusual situation, but we want this to work in OE in
externalsrc.bbclass so that compilation happens every time it is
requested.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 5103073..0c77d72 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -187,6 +187,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 self.file_checksum_values[k][f] = cs
                 data = data + cs
 
+        taskdep = dataCache.task_deps[fn]
+        if 'nostamp' in taskdep and task in taskdep['nostamp']:
+            # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
+            import uuid
+            data = data + str(uuid.uuid4())
+
         taint = self.read_taint(fn, task, dataCache.stamp[fn])
         if taint:
             data = data + taint
-- 
1.9.3


