Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605AAC3DA6F
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:04:51 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by mx.groups.io with SMTP id smtpd.web10.1880.1692824683294474545
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:04:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=YYVgWDR+;
 spf=pass (domain: ti.com, ip: 198.47.19.142, mailfrom: rs@ti.com)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NL4g58001868;
	Wed, 23 Aug 2023 16:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692824682;
	bh=RzjbF4X3n+ZixJZuJiiLoUg3qTvt382c3ve/DMsZSws=;
	h=From:To:CC:Subject:Date;
	b=YYVgWDR+gsTGc5CUHEqlK/eTSTygWK5fm1AGLGtPccKVRd8OHmNtNDPLR62SIHzq1
	 RFCi6AYkslLoaibNnN6bGlpoLOhO38VVt7UWTbUdC4TVoOdafLdLY968nWH7w46quR
	 F23BXOX9w8v6S8DdaMqg/2r02eV8YjUXr+vrNJNg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NL4gKM114811
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Aug 2023 16:04:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 16:04:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 16:04:41 -0500
Received: from rs-desk.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NL4fld087342;
	Wed, 23 Aug 2023 16:04:41 -0500
From: <rs@ti.com>
To: <richard.purdie@linuxfoundation.org>
CC: <bitbake-devel@lists.openembedded.org>, Randolph Sapp <rs@ti.com>
Subject: [PATCH] bitbake-worker: export_proxies if network flag = 1
Date: Wed, 23 Aug 2023 16:04:38 -0500
Message-ID: <20230823210438.2172797-1-rs@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:04:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14959

From: Randolph Sapp <rs@ti.com>

Call the export_proxies() function if the network flag is set. Not sure
why anyone would want to enable access without passing proxy variables
if they are set.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 bin/bitbake-worker | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 451e6926..ba199ef9 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -285,6 +285,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                 for e, v in exports:
                     os.environ[e] = v
 
+                # if network is true we should assume proxy variables are to be passed through
+                if the_data.getVarFlag(taskname, 'network', False):
+                    bb.utils.export_proxies(the_data)
+
                 for e in fakeenv:
                     os.environ[e] = fakeenv[e]
                     the_data.setVar(e, fakeenv[e])
-- 
2.41.0


