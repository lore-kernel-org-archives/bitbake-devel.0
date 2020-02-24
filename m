Return-Path: <chris.laplante@agilent.com>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	by mail.openembedded.org (Postfix) with ESMTP id 250BF60B32
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 15:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=F34VrlhpMsxIEz98qPjyzoLGgD4gv8dKWMtvUtzRMklB6TR5OiiOTgIAFEHrhhjjKaO6q/Rt4lfVVGGwnYY6+NNj0sz6npbRyy0dwkSTc1Tz3kbY8quDWAWaIf+VPTpqdC/RKuPdkYVPRyZ0aHOCY7P2WjSIB5u1Pt2D9e9+28AcFci+ZhsvHa+1pWQDWIMUyYNpntm1gAQs9ShWofHd23DBlFWnuiLRhBMAmeltWWIXGJKdcBv3zte7uxlodn9+nGr/Vq1bMwfGphoT16zp31MWp+OJvwdw7J+hS8I97SuexEBrIBZ+BNoxgAgbTnkWI+1LFKWa6+p6jo1d26xTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pa10xxJUyyYQitGE4P78W5mscVKC20+R+avdiuEwQNM=;
	b=LrRnjjUvCWM6ENo92BTcDPoXFCNwaPP8VwbSWEIMWJUXzyo2d2QmX8itubO14BS1Wh+ZglfhNOJ195YCuGC8xHvlEhoN8I6nJnz4p0qHi08vIIr7m1f8kZWdf0KaZHTh2Lx/EqIbTdWWUwF42lnz3oCjncRe0ULku3VIdUaxB4AMZN6zt+JFcc/zF5krEkIu4OTKSjiMZspLKV1qr/le8UovDv2cF7XuGcjBN+MVy1iK299n9uBBv7aiMpHYdo8LTq3bsysfPk4RV9+X36A/nyK5b6GQROsrm51UArVt4iDmux/xyp6shRKzM3F/nGkfpH3TWa5NInK5gISh6oVRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pa10xxJUyyYQitGE4P78W5mscVKC20+R+avdiuEwQNM=;
	b=bKX3UBU4EWgjeqLAwwk/rtiHm5h84Ybb2+jQ/pKDfFQULJvO+aXNBDQrBw+3fPsU1lNAuluAxQs/whjZqIOabp3zTGy3vpChd4NF8qeU02tHyrdF6zC53HkZgqn7gGSihMGYJAAMmqxmY9T2q2afss0AonaTNnHm/TUbOYJgWME=
Received: from MWHPR08CA0048.namprd08.prod.outlook.com (2603:10b6:300:c0::22)
	by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17;
	Mon, 24 Feb 2020 15:45:27 +0000
Received: from MW2NAM12FT008.eop-nam12.prod.protection.outlook.com
	(2603:10b6:300:c0:cafe::72) by MWHPR08CA0048.outlook.office365.com
	(2603:10b6:300:c0::22) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22 via
	Frontend Transport; Mon, 24 Feb 2020 15:45:26 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.37)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.37 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
	MW2NAM12FT008.mail.protection.outlook.com (10.13.180.75) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2772.6 via Frontend Transport; Mon, 24 Feb 2020 15:45:26 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Mon, 24 Feb 2020 08:44:40 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 24 Feb 2020 10:44:01 -0500
Message-ID: <1582559041-78575-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(29502001)(199004)(189003)(5660300002)(4326008)(2906002)(8936002)(186003)(316002)(26005)(8676002)(246002)(70206006)(107886003)(2616005)(336012)(6916009)(7636002)(36756003)(426003)(6666004)(356004)(86362001)(478600001)(44832011)(956004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4080;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg1.windmz.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aff561e-17e8-464f-9d85-08d7b9409170
X-MS-TrafficTypeDiagnostic: MN2PR12MB4080:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB408052B00C39F09442D341D18BEC0@MN2PR12MB4080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVS9eDLQZmqwPfquw9f8UrhZhWdka37wcrZ76JO9T+xzNkn+/pYvE1Pt2HHRiQMqdgH3z6GAHETpMWhafeVnTitG7S5PSHHzkmjZLyYUCsR/oD3HPXpadg15r/lPNwhYFXtm3MqzUovbIQsHgcZ0XjXabO5bDJK8Q7Gxzs0ur1Z5m7dKizAMNEbmStOafAaCc8F2UxxB/DMnHcs54scz0n6E8K9g4dhFMygWJuRrtAcMKiQ0imSP/DR3PRw9my5F01N6O5CDqnUe5L9FmsTx0p1qYZmOI5j5ZtWsgQnAhphU3a0TpGIUUsqWbg99h5YDJhIFMjeoeMTg8KDYPuhACvaT+xrgD2c+iqzEWmLEeNHC6LfXVwlgdE8V42BkBGh4qUpIPXW31FxZsLCMOhw9XdSBchV4Lmu/pwdajpIsal2fa1pSaEwENWICvXV0EEhJctNBoYdFlCLav42We8p8TCTIDgKgHJh5M/C8IXHrIRY8XEUwCUThK2dd8vQdPg19
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 15:45:26.4107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aff561e-17e8-464f-9d85-08d7b9409170
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Subject: [PATCH] runqueue: teach runonly/runall to accept "do_task" as well as "task"
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
X-List-Received-Date: Mon, 24 Feb 2020 15:45:28 -0000
Content-Type: text/plain

Previously --runonly=do_task would give a misleading error like:

  ERROR: Could not find any tasks with the tasknames ['do_task'] to run
  within the recipes of the taskgraphs of the targets...

The problem is that BitBake tried to find "do_do_task". So teach it to
only add the do_ prefix if it's not already there.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 71108ee..32966b4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -920,9 +920,11 @@ class RunQueueData:
             runq_build = {}

             for task in self.cooker.configuration.runall:
+                if not task.startswith("do_"):
+                    task = "do_{0}".format(task)
                 runall_tids = set()
                 for tid in list(self.runtaskentries):
-                    wanttid = fn_from_tid(tid) + ":do_%s" % task
+                    wanttid = "{0}:{1}".format(fn_from_tid(tid), task)
                     if wanttid in delcount:
                         self.runtaskentries[wanttid] = delcount[wanttid]
                     if wanttid in self.runtaskentries:
@@ -949,7 +951,9 @@ class RunQueueData:
             runq_build = {}

             for task in self.cooker.configuration.runonly:
-                runonly_tids = { k: v for k, v in self.runtaskentries.items() if taskname_from_tid(k) == "do_%s" % task }
+                if not task.startswith("do_"):
+                    task = "do_{0}".format(task)
+                runonly_tids = { k: v for k, v in self.runtaskentries.items() if taskname_from_tid(k) == task }

                 for tid in list(runonly_tids):
                     mark_active(tid,1)
--
2.7.4


