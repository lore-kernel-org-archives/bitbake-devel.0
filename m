Return-Path: <Kai.Kang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id DFED77F380
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 03:08:34 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x9H38WGY020904
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 16 Oct 2019 20:08:32 -0700
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.468.0; Wed, 16 Oct 2019 20:08:19 -0700
From: <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Thu, 17 Oct 2019 11:08:12 +0800
Message-ID: <20191017030812.17173-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue.py: not show warning for deferred multiconfig task
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
X-List-Received-Date: Thu, 17 Oct 2019 03:08:35 -0000
Content-Type: text/plain

From: Kai Kang <kai.kang@windriver.com>

When follow the instructions of multiconfig from Yocto dev manual that
set in core-image-sato recipe:

  do_image[mcdepends] = "multiconfig:x86:arm:core-image-minimal:do_rootfs"

it show too many annoying warnings look like:

| WARNING: Deferring mc:x86:virtual:native:/buildarea6/kkang/poky/meta/recipes-support/libxslt/libxslt_1.1.33.bb:do_populate_sysroot
| after mc:arm: virtual:native:/buildarea6/kkang/poky/meta/recipes-support/libxslt/libxslt_1.1.33.bb:do_populate_sysroot

Treat them as infomations rather than warnings.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 18049436fd..21a9f02a1e 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2750,7 +2750,7 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 sqdata.hashes[h] = tid
             else:
                 sqrq.sq_deferred[tid] = sqdata.hashes[h]
-                bb.warn("Deferring %s after %s" % (tid, sqdata.hashes[h]))
+                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
 
 
 class TaskFailure(Exception):
-- 
2.17.1


