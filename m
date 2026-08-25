Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63ABC61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:46:46 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30465.1787687198606239027
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:46:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=m+u3hcqm;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.196.32, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUgQmdghDMa5e696PwdVfKjTRC0iBgkfiDg9tVkqUFAZ0jX6HjaVehIv4BZIv5dh52x3/CjdTxXLNBlfXTdq+I3TDSFnFNxxZ7t7oE1SsEl4fCuvqeZVoPASzMvcg1eKUESN8bBXTRPL80twnuI/dLwjG3a7laejKLofQd9+hVmmpx8TLCPJypQ+qm8syz1j7s2JQcS1ySjR8QWyrxfIb233TWircWP4soaxkb2qLUvA5P/UWz7tc4xUr3FP3P/7qjXhlwJL+k694yjE4bQtXnUSu/PN8SYtDgHT3XYZjUkxQuaWnNC6ntjl26RCvN5zjNVVYvlk4XU9709nkEAeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1CDrfiiDIi1hfhehpACijiumzQY2lYgw7SkexyEG7c=;
 b=gw9NtEyl7eNTBPefhWDZS6OPi83qSEGOP45EBMnrL4Gy1stoBvBpWoQkyLk1Z9S/YylEROsIigIyEzRGnTe4ATL+cV8zZOaM0fd2XZ0CskIr2/JVJUTifjfB3xkkpUZywkJ/2SBMxuRSxiz5HKPUG95tV6KcHGiuIoMXSHze15Yz8g/0ffJ/25wRNmyqG9rkY0yAMgNQMt1LmSzh/mpGauLN5DsBSJn2F8M9eOb7JOg7BZ4b0XSze+Hoovm8TrXWP6zYdXsvdLckcJPXg5Q/hZh7rs6A+0T2yRYcTH//NggAWaWFrL/K8T0ur4Txch2gVsk1Ld/pdOlrXbxbU/DsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1CDrfiiDIi1hfhehpACijiumzQY2lYgw7SkexyEG7c=;
 b=m+u3hcqmJdkhEdiHJuucDPRm3I/DSuB+8xWn1D9BgqHt4A/8aWNfh8eSq6HFM0vzgNL4I+5MXcdjbvp2lwyPd7f84FowShXhebUGIuofjPYEzmlekWitXY55VyY+uojowRuwccTx5GlKgZB7pLHqh4Y48G/w/zSGnGIJ1SHuDTGDb5zISnIdFV1b5cATLQy4UNn/y2vxnPjJs2QnrtA8+N3UGEne5+kvgUZyENXxJkbRl+JmaWA9SHH2x2KVPLn4ifZVff7D5EoZJrR0xWmvilxbtVQbI8A3Q0h/ZzGBKcUtnNtQZg1xFsbvQHPKugzBQhOFCktJ9rBK5WXRVGzMcg==
Received: from SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 19:46:30 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::7b) by SJ0PR03CA0027.outlook.office365.com
 (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 19:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 19:46:29 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 25 Aug 2026 13:45:57 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/6] runqueue: fix init of RunQueueScheduler.prio_map; add test for 'basic' scheduler
Date: Tue, 25 Aug 2026 15:45:45 -0400
Message-ID: <20260825194549.152553-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825194549.152553-1-chris.laplante@agilent.com>
References: <20260825194549.152553-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 459cc9e4-ea65-47cc-e66d-08df02e18ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	sIErtkjx7F+azVjROQZan811SfvFeWdKeiVSwa0sIZbLnvzh8SvRRYQ8R3KDwppzwJFeo8sJZulKa+niBhXInRiMvtIp+wbTaWBSy0BLeqFc6c+qHqRmu6uE7SRbdOkkacbL7VffQKReDh5OXXJiyGSR1noz9qgV3aYD6eFcqnpuB9zs4klA1UlZOsy5Hb/4F28m62VDfjbVMYKHFlWAXJ6IxVxOVLGCQTdgvkLqaFMf4SSU4sIpBohEmge9m3ljIPisWb7dPGWnKj0qGjWfS+C3KjCSDFD8Dp0QRIhr522X3Owl8o1/DTfCt9p4/WGQ53UKM1ubYXuuhN7jsfEZsI0mZwuJ+qO4Wwr0Hg8yt0mpKUNoyiFG8kpAoMuRypMeQaxGgy2NJBr7TFadTUlgrNb+iVhiTVrTicQg0oNGecx7MTRRKEKsCXMES8aO8Af+xXDZEyNrbIVnxT7rhMAiQrRxnJ40J2oazwEKX0kUd/HxAJNnAtMABpk7XkrjzlnKtLwK65qx5K7UuciiduT7em+/flS12wZ5SmXzu8sQkpxTmJ2bkV/0T1uu9/zoPA5n6qrgBCjfyc7JUPcnBzSraoqpUQ5NcpUXKdujjuZ2lHiG6/Y7sMFc46n0jEmhqtlf4oUOXtegiDNE/f0NflTXts+gNVQhUG/IFhzzedQL7eLMr++6vC1zWvBNdrKisE9TtCw7HD7SwOo+YPEZl/4tWg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	i96fHtYgKNN7W4uJQ7ODMDJg1AtAC9uBJ0ltzTYG7iNY3i4oX4Qf3Z9lWhdtsMqyBTp4MjsGXkh6KmmZEQFYU/eC8IrvDw4JwmUutq6z3j9EXQlInND0bTk+8Fj9k54OdvLDmnSMpsymKMGIOdP/fG8wAHZaOmqQDfzNj79lm6CAG1yGZ5WGpdrfBvyU8u6dtvPd+PePCczmGz7smGj/jCfmBsW/Ade54UBH+YbDnrZTRuamPWQPd6F++hN8zyE4+7fyWh3pUjavfZmfoMsZ8pC5QwxFNrsqZlsj8vUjuKAM/79cvRwTqOvN8jUMSUKsbs7RcHiMurl0krOT4h7VqNUtTFQn8FW2WhcfMbapO5ReClpBSppAoL0GVkCY6fNfswvByVePac+BKaEnFCtr3RGnRBZr4Xo3dHOftsIB0wwx8nRkQQMaSOND4JWxJtNI
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:46:29.7325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459cc9e4-ea65-47cc-e66d-08df02e18ee7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:46:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20044

From: Chris Laplante <chris.laplante@agilent.com>

Before this patch, RunQueueScheduler.prio_map was incorrectly
initialized as a list with a single element, the dictionary keys view.

It broke like so:

ERROR: An uncaught exception occurred in runqueue
Traceback (most recent call last):
  File "/home/laplante/repos/bitbake/lib/bb/runqueue.py", line 1663, in exe=
cute_runqueue
    return self._execute_runqueue()
           ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/laplante/repos/bitbake/lib/bb/runqueue.py", line 1629, in _ex=
ecute_runqueue
    retval =3D self.rqexe.execute()
             ^^^^^^^^^^^^^^^^^^^^
  File "/home/laplante/repos/bitbake/lib/bb/runqueue.py", line 2357, in exe=
cute
    task =3D self.sched.next()
           ^^^^^^^^^^^^^^^^^
  File "/home/laplante/repos/bitbake/lib/bb/runqueue.py", line 308, in next
    return self.next_buildable_task()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/laplante/repos/bitbake/lib/bb/runqueue.py", line 285, in next=
_buildable_task
    self.rev_prio_map[tid] =3D self.prio_map.index(tid)
                             ^^^^^^^^^^^^^^^^^^^^^^^^
ValueError: '/home/laplante/repos/bitbake/lib/bb/tests/runqueue-tests/recip=
es/a1.bb:do_fetch' is not in list

The other schedulers don't have this problem because they overwrite
prio_map.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py       | 2 +-
 lib/bb/tests/runqueue.py | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 544081053..c2e6561ec 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -154,7 +154,7 @@ class RunQueueScheduler(object):
         self.rqdata =3D rqdata
         self.numTasks =3D len(self.rqdata.runtaskentries)
=20
-        self.prio_map =3D [self.rqdata.runtaskentries.keys()]
+        self.prio_map =3D list(self.rqdata.runtaskentries.keys())
=20
         self.buildable =3D set()
         self.skip_maxthread =3D {}
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 74f5ded2e..42c02cd15 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -63,6 +63,15 @@ class RunQueueTests(unittest.TestCase):
=20
             self.shutdown(tempdir)
=20
+    def test_basic_scheduler(self):
+        with tempfile.TemporaryDirectory(prefix=3D"runqueuetest") as tempd=
ir:
+            cmd =3D ["bitbake", "a1"]
+            tasks =3D self.run_bitbakecmd(cmd, tempdir, extraenv=3D{"BB_SC=
HEDULER": "basic"})
+            expected =3D ['a1:' + task for task in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+
+            self.shutdown(tempdir)
+
     def test_single_setscenevalid(self):
         with tempfile.TemporaryDirectory(prefix=3D"runqueuetest") as tempd=
ir:
             cmd =3D ["bitbake", "a1"]
--=20
2.43.0


