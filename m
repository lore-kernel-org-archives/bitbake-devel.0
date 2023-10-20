Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC4C001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 17:34:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.48])
 by mx.groups.io with SMTP id smtpd.web11.60839.1697823230051113298
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Oct 2023 10:33:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=SBsVm5NF;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.48, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIo7hhwXpX83ikd0XJIW4fbLF6it+ZWVx2E3R2KtXbKBytDwN2EmUVPW1+3IylMIluQKLwn+ofl10Egf79PDCBVul7oNqooBZCHJ5e4T0E1j7XS2ko1CjZ0uDzNVWtDcRn832eFZPT/46mGhhNQeToN2P85NU+bYWG/DvgiGpuGR4yC9uNeFepLOG9PPMMRwNOljww0nbeq5Mj1mOg4q/F6G4oO+nLUtpsK2wRze/njDP1cOiuMPSCaxIl80X5B//nkZl5ydFtEXf9LO7S2TJQNZNayLjU8b4sY8dkYjXQ5db1gZ7m7Cubm3DK9H4CcxWk4fskvV0WPnxjC78ElogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evuZRxsd0yY8d7Mp2Qfwi1SjI5b/X/L/lredxIUr+z4=;
 b=JE2sAuzWwtxSoZJeTUgWhXtb4MJ6rUgRItc/e5Rj+1rjU7eWCfdvfOA4FD4lYYpoyD/V0MZFIWvR8cXDaIxnApvzeEKDaj31dUdBGJZS7dAA9ZEfq/8tpbaw2W1vU5gFOVPvWwRMk6bS0r8L2eSKg4LGlCXY/xMvEM3AFfgyrWamLiyMUa3gJGxnbe5VwJybywYno9cFNSemFzQPBHp5v2adlLYWWice/OGLDWPAF25+C0PuO7/0B6Alc5vPVQjCinxbfJMIutc8V9xRh4V4JiS5Q1c0h7K/oISI25JcLFy1JJxm/wIdWuB/KWcU41GeC457rEUCv/O5rAAUuS2hPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evuZRxsd0yY8d7Mp2Qfwi1SjI5b/X/L/lredxIUr+z4=;
 b=SBsVm5NFaz2K6pLpV2tcTo5nZpgL59yfa36qm09vLM8hOQM5QjDJ80Qj8sTnrXaIGwK0mYgnpBS7vP8tNkkKdWuQOEQbXpRx7NBgCq94+xddq66NHQnAsfnf51JfHo3CfxGyK5NX3YfbPvz+h1y4ixA6LBp1QiZ4RayWkrDYxCd3aEnJs+l08HXAQaUlpJnpAhgbldRG/1O2EleevgHLLze/Ta/U4JKJ10c/V+ELYaThGqGORZr9EzQZKyRkZPFSkZNXwD9AMocqmXXAJXlRBwGCBIMM/LVpqgMfKffQ++BFGbTFDdsJVd44IIhNDLN77H6O6rC3C8/bgxhtH9t/rg==
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 17:33:47 +0000
Received: from DM6NAM12FT014.eop-nam12.prod.protection.outlook.com
 (2603:10b6:a03:255:cafe::27) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 17:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 DM6NAM12FT014.mail.protection.outlook.com (10.13.178.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.10 via Frontend Transport; Fri, 20 Oct 2023 17:33:47 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 11:33:33 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] runqueue: set has 'add', not 'append' method
Date: Fri, 20 Oct 2023 13:33:38 -0400
Message-ID: <20231020173338.873030-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT014:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 525b51f1-7872-41f9-4837-08dbd192b724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	smlr0DEYV2eSn9wUq2wbbcCyPeIH0BvebwSzxrCdEoYV58M3QCEs9jl+w52q203eITbK6mJBcBgSmHdq+5OR0CBzrstmyebLx2k1RgzO5tiZfyJoIt0hJN2f9f9DSTF+vAz8JaNBjY+uwsrii7LyF+OWthnga0/38McxzncrRzTJW2lQ+zDS1QO8s0u4LqaxgGpsBW9WtbfdCVy1l1UAkngs4Gle+m6hwIvRj+8wTXcQAf6TpwLP7SmCtPjb/0fXJoGuyKe6VWJfRnW+QJkiG0UQupERWYbC0C4ar1PS2vctdTfINELyItZYrpR8aXchmoOA9DmPhUdoVGVXUh45aD9HsdGmTEJI2a157ZpHc1Tx8UL51BXzXqDV8bzPw1LG472s+wZd2/lHhy4sMIFmmRPi7peQwsP+41ud+oOWITzFsSPguIYrnAtRCBTnaMtqbib15KrLnv9sjVL9b7qMIyLYrPCYMJSdppoXVVfIa09Xa/7KrrYhQ+vy4Dl/RFoVWuhr0tvP5TsSxTCfdxFD/epGdiv7hSmVFYmdoV2kt+JdKclKCXWVL8YIrEJJyNb7fltcaR2434nCti4KOZa3W+d2/x8GDzWdMFdFvJHyVkGr1IO/X2JRHBTsnvoIIOqY5JhDPPunsvmZbkDL8sAqbumAcZx1m3NEXScmbKJAZwDGtOoHRXRtdbWXy7tS48GgxeBw3XdWFE9wKBuYSEFClOWK5vUZ7b7pw+eD9PQkqEPYCF0lanPkJe7KzrB+7fqb
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(46966006)(36840700001)(40470700004)(36860700001)(336012)(8676002)(478600001)(70206006)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(4744005)(316002)(40460700003)(86362001)(2876002)(40480700001)(47076005)(6916009)(107886003)(956004)(1076003)(82740400003)(2616005)(426003)(356005)(26005)(36756003)(8936002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 17:33:47.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525b51f1-7872-41f9-4837-08dbd192b724
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT014.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Oct 2023 17:34:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15268

From: Chris Laplante <chris.laplante@agilent.com>

Discovered via pylint

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 56147c50a8..69b746c768 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -157,7 +157,7 @@ class RunQueueScheduler(object):
             (mc, fn, taskname, taskfn) =3D split_tid_mcfn(tid)
             self.stamps[tid] =3D bb.parse.siggen.stampfile_mcfn(taskname, =
taskfn, extrainfo=3DFalse)
             if tid in self.rq.runq_buildable:
-                self.buildable.append(tid)
+                self.buildable.add(tid)
=20
         self.rev_prio_map =3D None
         self.is_pressure_usable()
--=20
2.34.1


