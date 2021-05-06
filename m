Received: from mga01.intel.com (mga01.intel.com [])
 by mx.groups.io with SMTP id smtpd.web11.2989.1620264864497033411
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 May 2021 18:34:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: OIqHjmWegUqlqm5njER5xGMlDMWTN44iCjW2A7wQFx4APGyO594vFhZwstn7bzxii60BUiE2gY
 pHSoaAwwlzXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="219222919"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="219222919"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:34:23 -0700
IronPort-SDR: IqdQM32U+XHxnNiU0YQX4jQDB9w4N0gxsacd6RCyg+TW13AVN8x1V+Ar7QXyuX8ag+E9d1sUN8
 bTCfsTGMHTZg==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="459046430"
Received: from hanpinon-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.47.180])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:34:21 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 2/2] runqueue: Handle deferred task rehashing in multiconfig builds
Date: Thu,  6 May 2021 09:34:14 +0800
Message-Id: <715babe7495e683a430fc5ee0427ed72f835edea.1620264737.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620264737.git.anuj.mittal@intel.com>
References: <cover.1620264737.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the hash of a task changes and that hash is a deferred task (e.g. a multiconfig
build), we need to ensure that the hash change propagates through to all the tasks
else the build will run multiple copies of the task, sometimes with oddly differing
results as the outhashes of native tasks built in differing locations can confuse
things.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2db571324f755edc4981deecbcfdf0aaa5a97627)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 78e576eb2..6c41fe6d4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2294,10 +2294,16 @@ class RunQueueExecute:
             self.updated_taskhash_queue.remove((tid, unihash))
 
             if unihash != self.rqdata.runtaskentries[tid].unihash:
-                hashequiv_logger.verbose("Task %s unihash changed to %s" % (tid, unihash))
-                self.rqdata.runtaskentries[tid].unihash = unihash
-                bb.parse.siggen.set_unihash(tid, unihash)
-                toprocess.add(tid)
+                # Make sure we rehash any other tasks with the same task hash that we're deferred against.
+                torehash = [tid]
+                for deftid in self.sq_deferred:
+                    if self.sq_deferred[deftid] == tid:
+                        torehash.append(deftid)
+                for hashtid in torehash:
+                    hashequiv_logger.verbose("Task %s unihash changed to %s" % (hashtid, unihash))
+                    self.rqdata.runtaskentries[hashtid].unihash = unihash
+                    bb.parse.siggen.set_unihash(hashtid, unihash)
+                    toprocess.add(hashtid)
 
         # Work out all tasks which depend upon these
         total = set()
-- 
2.30.2

