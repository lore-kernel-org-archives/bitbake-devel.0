Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id AC81A6BBDA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Sep 2013 13:41:25 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r82DfQA4005271
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Sep 2013 06:41:26 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 2 Sep 2013 06:41:25 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 2 Sep 2013 09:41:20 -0400
Message-ID: <27659d52912f96cb30a1a2d44638b262b50c1acc.1378121138.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1378121137.git.liezhi.yang@windriver.com>
References: <cover.1378121137.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] taskdata.py: set PREFERRED_VERSION when it is in the item
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
X-List-Received-Date: Mon, 02 Sep 2013 13:41:25 -0000
Content-Type: text/plain

There is an error if we:

$ bitbake make (the make-3.82 will be built)
// Edit make.inc
$ bitbake make-3.81
[snip]
 *** 0004:    mfile = open(manifest)
     0005:    entries = mfile.readlines()
     0006:    mfile.close()
     0007:
     0008:    for entry in entries:
Exception: IOError: [Errno 2] No such file or directory: xxx
[snip]

Set the PREFERRED_VERSION if we find the version info in the item would fix the
problem, I think that we need iterate in all the packages since it seems that
we can't know wether the item is just a PN or PN-PV unless we compare them,
what can I think is check len(all_p) == 1, but this doesn't work when the same
recipe is multiple layers.

[YOCTO #5067]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/taskdata.py |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 58fe199..38a3191 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -430,6 +430,21 @@ class TaskData:
 
         all_p = dataCache.providers[item]
 
+        # Check whether item has the one of following formats and set the
+        # PREFERRED_VERSION if it does:
+        # - <pn>-<pv>
+        # - <pn>-<pv>-<pr> (when no PE)
+        # - <pn>-<pe>_<pv>-<pr> (when PE)
+        for fn in all_p:
+            pn = dataCache.pkg_fn[fn]
+            pe = dataCache.pkg_pepvpr[fn][0]
+            pv = dataCache.pkg_pepvpr[fn][1]
+            pr = dataCache.pkg_pepvpr[fn][2]
+            if not pe and (item == "%s-%s" % (pn, pv) or item == "%s-%s-%s" % (pn, pv, pr)):
+                cfgData.setVar("PREFERRED_VERSION_" + pn, pv)
+            elif pe and item == "%s-%s_%s-%s" % (pn, pe, pv, pr):
+                cfgData.setVar("PREFERRED_VERSION_" + pn, pv)
+
         eligible, foundUnique = bb.providers.filterProviders(all_p, item, cfgData, dataCache)
         eligible = [p for p in eligible if not self.getfn_id(p) in self.failed_fnids]
 
-- 
1.7.10.4


