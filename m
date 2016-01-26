Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id ECABA76809
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 13:34:36 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 05:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,350,1449561600"; d="scan'208";a="641616598"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2016 05:34:36 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 15:34:29 +0200
Message-Id: <1453815272-8303-4-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 3/6] bb/runqueue: save task file dependency cache onto disk
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
X-List-Received-Date: Tue, 26 Jan 2016 13:34:37 -0000

Before this patch the usage of cache was quite useless as the file
checksums were not actually cached on disk but re-calculated every time.
This patch utilises the new writeout_file_checksum_cache() method of the
SignatureGenerator class to do the job.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/runqueue.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f840ad2..ecbc1ea 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -829,6 +829,7 @@ class RunQueueData:
                         procdep.append(self.taskData.fn_index[self.runq_fnid[dep]] + "." + self.runq_task[dep])
                     self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
 
+        bb.parse.siggen.writeout_file_checksum_cache()
         return len(self.runq_fnid)
 
     def dump_data(self, taskQueue):
-- 
2.1.4


