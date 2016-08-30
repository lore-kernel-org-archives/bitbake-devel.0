Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 51949606D0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 10:19:18 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 30 Aug 2016 03:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,255,1470726000"; d="scan'208";a="1049095794"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2016 03:19:18 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id A71516A4080;
	Tue, 30 Aug 2016 03:18:58 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2016 13:18:58 +0300
Message-Id: <1472552338-3048-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Cc: Alexander Egorenkov <Alexander.Egorenkov@vector.com>
Subject: [krogoth][PATCH] toaster: Fix adding of bitbake variables containing ':'
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
X-List-Received-Date: Tue, 30 Aug 2016 10:19:18 -0000

From: Alexander Egorenkov <Alexander.Egorenkov@vector.com>

This fix is a backport from toaster-next.

Krogoth Toaster is unable to add a variable containing ':'
and fails with the following error message:

error on request:
too many values to unpack
Traceback (most recent call last):
 File "bitbake/lib/toaster/toastergui/views.py", line 2171, in
xhr_configvaredit
  variable, value = t.spli(":")
ValueError: too many values to unpack.

[YOCTO #10170]

Signed-off-by: Alexander Egorenkov <Alexander.Egorenkov@vector.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/views.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index bd5bf63..febd17f 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2168,7 +2168,7 @@ if True:
             if 'configvarAdd' in request.POST:
                 t=request.POST['configvarAdd'].strip()
                 if ":" in t:
-                    variable, value = t.split(":")
+                    variable, value = t.split(":", 1)
                 else:
                     variable = t
                     value = ""
@@ -2178,7 +2178,7 @@ if True:
             if 'configvarChange' in request.POST:
                 t=request.POST['configvarChange'].strip()
                 if ":" in t:
-                    variable, value = t.split(":")
+                    variable, value = t.split(":", 1)
                 else:
                     variable = t
                     value = ""
-- 
2.1.4


