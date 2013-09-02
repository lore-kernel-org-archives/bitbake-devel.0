Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 912306BBDA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Sep 2013 13:47:26 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r82DlRXL007348
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Sep 2013 06:47:28 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.342.3; Mon, 2 Sep 2013 06:47:26 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 2 Sep 2013 09:47:21 -0400
Message-ID: <38a257cf48a0e83f75352c5f3eff36c305b48d09.1378129369.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1378129369.git.liezhi.yang@windriver.com>
References: <cover.1378129369.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] runqueue.py: check whether multiple versions of the same PN are due to be built
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
X-List-Received-Date: Mon, 02 Sep 2013 13:47:26 -0000
Content-Type: text/plain

There would be an race issue if we:

$ bitbake make-3.81 make-3.82

This because they are being built at the same time which would cause
unexpected problems, for example:

[snip]
ERROR: Package already staged (/path/to/tmp/sstate-control/manifest-qemux86-make.populate-sysroot)?!
ERROR: Function failed: sstate_task_postfunc
[snip]

Or there would be python's strack trace such as:

[snip]
 *** 0004:    mfile = open(manifest)
     0005:    entries = mfile.readlines()
     0006:    mfile.close()
     0007:
     0008:    for entry in entries:
Exception: IOError: [Errno 2] No such file or directory: xxx
[snip]

[YOCTO #5094]

I think that we can quite earlier to fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/runqueue.py |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0700a5b..c77cb85 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -702,7 +702,17 @@ class RunQueueData:
                 else:
                     msg += "\n This usually means one provides something the other doesn't and should."
                     logger.error(msg)
-
+                # Check whether multiple versions of the same PN are due to be
+                # built, for example:
+                # <pn>-1.0
+                # <pn>-2.0
+                seen_pn = []
+                for fn in prov_list[prov]:
+                    pn = self.dataCache.pkg_fn[fn]
+                    if pn not in seen_pn:
+                        seen_pn.append(pn)
+                    else:
+                        bb.fatal("Multiple versions of %s are due to be built." % pn)
 
         # Create a whitelist usable by the stamp checks
         stampfnwhitelist = []
-- 
1.7.10.4


