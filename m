Return-Path: <Kai.Kang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 698DC7F95B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 09:27:21 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id xAS9RMc0023160
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 01:27:22 -0800 (PST)
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.468.0; Thu, 28 Nov 2019 01:27:21 -0800
From: <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 28 Nov 2019 17:27:18 +0800
Message-ID: <20191128092718.13336-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: add mc to pending hash index
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
X-List-Received-Date: Thu, 28 Nov 2019 09:27:21 -0000
Content-Type: text/plain

From: Kai Kang <kai.kang@windriver.com>

When build multiconfig target by following steps in section "Enabling
Multiple Configuration Build Dependencies" in yocto dev-manual which
adds dependency between multiconfig targets:

do_image[mcdepends] = "mc:x86:arm:core-image-minimal:do_rootfs"

it shows a lot of warnings, such as:

| WARNING: Deferring
|   mc:x86:virtual:native:/path/to/meta/recipes-support/nss/nss_3.45.bb:do_populate_sysroot
|   after
|   mc:arm:virtual:native:/path/to/meta/recipes-support/nss/nss_3.45.bb:do_populate_sysroot

In function pending_hash_index it only checks PN, taskname and hash. But
they are same for multiconfig native and allarch packages. Add multiconfig
to pending hash index too to make the index unique.

Ref:
https://www.yoctoproject.org/docs/latest/dev-manual/dev-manual.html#dev-enabling-multiple-configuration-build-dependencies

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 485d9341f5..059eb9e283 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -69,12 +69,12 @@ def build_tid(mc, fn, taskname):
     return fn + ":" + taskname
 
 # Index used to pair up potentially matching multiconfig tasks
-# We match on PN, taskname and hash being equal
+# We match on mc, PN, taskname and hash being equal
 def pending_hash_index(tid, rqdata):
     (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
     pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
     h = rqdata.runtaskentries[tid].unihash
-    return pn + ":" + "taskname" + h
+    return mc + ":" + pn + ":" + "taskname" + h
 
 class RunQueueStats:
     """
-- 
2.17.1


