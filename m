Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B87C71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:16:01 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web10.42692.1694373352930033760
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Na0B9yu+;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: rs@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38AJFlsd117321;
	Sun, 10 Sep 2023 14:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694373347;
	bh=AjV+U4SsqYW8od9MvEDfyqYBlWfwGBBN2eVTTPwHFk0=;
	h=From:To:CC:Subject:Date;
	b=Na0B9yu+E/OkqC6b22XeOHIO0I0LuzCryfApAfaE8mgMdKjhwZr3wipw4REnUqgmy
	 lk6M1nhF5NadbHUY8G4rkLrYumatDII2tRdrfm1dLu5G0J0/24BwpBASCh01dI8sjM
	 rdEdnm1F46yQ4IPBeN7vVxFx1uR2NHmsbpvvglqY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38AJFlWC016129
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 10 Sep 2023 14:15:47 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 14:15:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 14:15:46 -0500
Received: from rs-desk.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38AJFkGv049208;
	Sun, 10 Sep 2023 14:15:46 -0500
From: <rs@ti.com>
To: <richard.purdie@linuxfoundation.org>, <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>, <denis@denix.org>,
        <reatmon@ti.com>, Randolph Sapp <rs@ti.com>
Subject: [PATCH] bitbake-worker: remove the network flag
Date: Sun, 10 Sep 2023 14:14:46 -0500
Message-ID: <20230910191445.564413-2-rs@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:16:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15017

From: Randolph Sapp <rs@ti.com>

The network flag does not respect proxies as the fetch stage does [1].
As such it only works for some users at the whim of the recipe writer.

This introduces an issue downstream as the build results are now
dependent on the network architecture of the builder, the recipe in
question, and the combination of proxy variables they choose to export
in addition to the normal host variables that affect builds (host tool
version, build environment, etc).

This is far more indeterminate than a build system that properly exports
proxy variables. If abuse of the network tag is an issue, then the
network tag should be removed in it's current state.

[1] https://lists.openembedded.org/g/bitbake-devel/topic/100924096

Signed-off-by: Randolph Sapp <rs@ti.com>
---

The logical followup to my last patch, even if it does seem a little extreme.

 bin/bitbake-worker                                    | 11 +++++------
 .../bitbake-user-manual-metadata.rst                  |  6 ------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 451e6926..71ff0516 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -270,12 +270,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
-                if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
-                    if bb.utils.is_local_uid(uid):
-                        logger.debug("Attempting to disable network for %s" % taskname)
-                        bb.utils.disable_network(uid, gid)
-                    else:
-                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
+                if bb.utils.is_local_uid(uid):
+                    logger.debug("Attempting to disable network for %s" % taskname)
+                    bb.utils.disable_network(uid, gid)
+                else:
+                    logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 58975f4c..b35c332c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1519,12 +1519,6 @@ functionality of the task:
    released. You can use this variable flag to accomplish mutual
    exclusion.
 
--  ``[network]``: When set to "1", allows a task to access the network. By
-   default, only the ``do_fetch`` task is granted network access. Recipes
-   shouldn't access the network outside of ``do_fetch`` as it usually
-   undermines fetcher source mirroring, image and licence manifests, software
-   auditing and supply chain security.
-
 -  ``[noexec]``: When set to "1", marks the task as being empty, with
    no execution required. You can use the ``[noexec]`` flag to set up
    tasks as dependency placeholders, or to disable tasks defined
-- 
2.42.0


