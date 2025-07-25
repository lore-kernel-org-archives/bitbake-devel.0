Return-Path: <alexander.merkle@lauterbach.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A6C87FCA
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 11:14:14 +0000 (UTC)
Received: from smtp1.lauterbach.com (smtp1.lauterbach.com [62.154.241.196])
 by mx.groups.io with SMTP id smtpd.web11.17215.1753442052172280756
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Jul 2025 04:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lauterbach.com, ip: 62.154.241.196, mailfrom: alexander.merkle@lauterbach.com)
Received: (qmail 17168 invoked by uid 484); 25 Jul 2025 11:14:09 -0000
X-Qmail-Scanner-Diagnostics: from amepc3.intern.lauterbach.com by smtp1.lauterbach.com (envelope-from <alexander.merkle@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.209):. 
 Processed in 0.012612 secs); 25 Jul 2025 11:14:09 -0000
Received: from amepc3.intern.lauterbach.com (HELO amepc3.intern.lauterbach.com.) (Authenticated_SSL:amerkle@[10.2.10.209])
          (envelope-sender <alexander.merkle@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <bitbake-devel@lists.openembedded.org>; 25 Jul 2025 11:14:09 -0000
From: Alexander Merkle <alexander.merkle@lauterbach.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Merkle <alexander.merkle@lauterbach.com>
Subject: [PATCH] bitbake: forward proxy env variables if network access is enabled
Date: Fri, 25 Jul 2025 13:13:47 +0200
Message-Id: <20250725111347.1812105-1-alexander.merkle@lauterbach.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Jul 2025 11:14:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17809

For steps that set `network` manually e.g. `do_compile[network] = "1"`
the proxy environment variables should be forwarded. Otherwise the step
may not have full access when corporate proxies are used.
There seem to be various examples around that use e.g. the go.bbclass
which downloads modules while the `do_compile` step.

Signed-off-by: Alexander Merkle <alexander.merkle@lauterbach.com>
---
 bitbake/bin/bitbake-worker | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index d2b146a6a9..4012a1a1fb 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -292,6 +292,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                 exports = bb.data.exported_vars(the_data)
 
                 bb.utils.empty_environment()
+
+                if bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
+                    bb.utils.export_proxies(the_data)
+
                 for e, v in exports:
                     os.environ[e] = v
 
-- 
2.39.5


