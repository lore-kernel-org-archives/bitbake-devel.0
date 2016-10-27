Return-Path: <o.mandel@menlosystems.com>
X-Greylist: delayed 475 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 27 Oct 2016 16:42:59 UTC
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id 52E6571C84
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 16:42:59 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3t4XYP2z40z3hjhF;
	Thu, 27 Oct 2016 18:35:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3t4XYP2hmrzvl7R;
	Thu, 27 Oct 2016 18:35:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
	port 10024)
	with ESMTP id rsPfWWRLYWVZ; Thu, 27 Oct 2016 18:35:04 +0200 (CEST)
X-Auth-Info: MgDz0eI5ZcYSY2PExgzbTehvCdSuRY8Ppkrh8PkR4Q031/11JJx46nKgWcX4YbDL
Received: from menlobuildsrv.menlosystems.local
	(host-141-40-253-38.customer.izb-online.de [141.40.253.38])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu, 27 Oct 2016 18:35:04 +0200 (CEST)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Oct 2016 16:34:39 +0000
Message-Id: <1477586079-29340-1-git-send-email-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.1.4
Cc: Olaf Mandel <o.mandel@menlosystems.com>
Subject: [PATCH] toaster: fix if USER_CLASSES is missing buildstats
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
X-List-Received-Date: Thu, 27 Oct 2016 16:43:00 -0000

buildstats not being in USER_CLASSES is no reason to fail every
single task in toaster_collect_task_stats: using a non-existing
variable results in a None argument to os.path.join().

Check the variable availability before trying to use it.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 meta/classes/toaster.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta/classes/toaster.bbclass b/meta/classes/toaster.bbclass
index 4bddf34..638bb39 100644
--- a/meta/classes/toaster.bbclass
+++ b/meta/classes/toaster.bbclass
@@ -157,11 +157,11 @@ python toaster_collect_task_stats() {
     import bb.utils
     import os
 
-    toaster_statlist_file = os.path.join(e.data.getVar('BUILDSTATS_BASE', True), "toasterstatlist")
-
     if not e.data.getVar('BUILDSTATS_BASE', True):
         return  # if we don't have buildstats, we cannot collect stats
 
+    toaster_statlist_file = os.path.join(e.data.getVar('BUILDSTATS_BASE', True), "toasterstatlist")
+
     def stat_to_float(value):
         return float(value.strip('% \n\r'))
 
-- 
2.1.4


