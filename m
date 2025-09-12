Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F1ACAC582
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 20:46:06 +0000 (UTC)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 by mx.groups.io with SMTP id smtpd.web11.1171.1757709961521459772
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 13:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=FIdJfIpq;
 spf=pass (domain: ti.com, ip: 198.47.23.235, mailfrom: reatmon@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CKk0dI1106423
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757709960;
	bh=4XH5ibqzhkQEhgZ43mrtKZwVAYz4+HWn5o4r/t5Olm0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=FIdJfIpqoAEioTUdO+Sp/6j/N0Ab2uGYmszfTaaxG26ecktSu7ub23Lqt5AFWJ2vP
	 uws+1KhYnZsU4J8GoW6687qYTmBXPRWp6/pFRX9ML3K/mx5zNU9KQLWY9Gdr0kTYMx
	 S35Hy0vw1bGHP8LrFK8Qtqk+Qe8FAWr/O9j0m0rg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CKk0Iq2111153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 15:46:00 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Fri, 12 Sep
 2025 15:46:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 15:46:00 -0500
Received: from uda0214219 (uda0214219.dhcp.ti.com [128.247.81.222])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CKk0OC4164887
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
Received: from reatmon by uda0214219 with local (Exim 4.90_1)
	(envelope-from <reatmon@ti.com>)
	id 1uxAee-0002hs-2v
	for bitbake-devel@lists.openembedded.org; Fri, 12 Sep 2025 15:46:00 -0500
From: Ryan Eatmon <reatmon@ti.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [bitbake][PATCH 2/3] bitbake-setup: Fix extracting config name
Date: Fri, 12 Sep 2025 15:45:58 -0500
Message-ID: <20250912204559.10360-2-reatmon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250912204559.10360-1-reatmon@ti.com>
References: <20250912204559.10360-1-reatmon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 20:46:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18016

When extracting the config name from from the filename, just splitting
on . does not allow for . in the config name.  For example:

coresdk-11.01.08-config.json -> coresdk-11

when it should be:

coresdk-11.01.08-config.json -> coresdk-11.01.08-config

os.path.splitext() already does this logic correctly, so use that
instead.

Signed-off-by: Ryan Eatmon <reatmon@ti.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 36103f1e8..342251bd5 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -50,7 +50,7 @@ def save_bb_cache():
     bb.fetch2.fetcher_parse_done()
 
 def get_config_name(config):
-    return os.path.basename(config).split('.')[0]
+    return os.path.splitext(os.path.basename(config))[0]
 
 def write_config(config, config_dir):
     with open(os.path.join(config_dir, "config-upstream.json"),'w') as s:
-- 
2.17.1


