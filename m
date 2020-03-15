Return-Path: <chris.laplante@agilent.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	by mail.openembedded.org (Postfix) with ESMTP id 4FC8F60720
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Mar 2020 16:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=IAt5Mw/TRZAlMDhAu3DGD/jwM3f80Epz6cDC9E6yWDRTU397lvvKdP5BHgYruPm/G4zLg313skPaMz0Zalj6pWVdu4hNV7lYxINMvda1tseUJdWiN6lkJ9T+Ld5oOf7j1/s9wkTIcDjHmFGxEJrlPNvZU43spXDmlrlv38HD+4Jmjd1Emb81gFgbZ6up+xHOvH0fRAxFgg+sb+uBX4/x8CKUjxovV1xF9JztWYCTEIDhKYCrmMqXeaRSBSPtOUIhPqyhWWJ3BhPtkJqc2FH98FzFpjcgiZbKnLvQ//oDsPYRqUdHjlEOOz8qjBY2ZvIcyHHWJTs5Hwg+ny9z2gJyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=O/uLsZgfoqQKJxm0Gu+0+ipi+yU6n+Fa+kt4qwSGKgQ=;
	b=VZcvehTDjl1SJGl4dCiUz8NW4oDC+G9lXd3ArM4SnAJQuOSI2zSX+CVg/0yEBUlNBbpi9yDpOmZQoPVAZA+QjmFt3VsyOaVG7ht0sLUmkvfvtNCAZrqKz/i3YvJ5gGwAUGEd4zL/aRMt2e+wdIb253TI1fkkURzdQ5sgOutSJVDrzWi8OJB0u2UIN7yfEjfiKhwjt2Nux9iNXytI5S5Q/NvL+PkOzeSWN7ATc53RfIsV79gJHje7fPbYo+TMgC+gGd34H3fffiuEVZ7KbKgtYfXZYWZXyFIb8Uo926wK+ImtfaZtnMszYEw+IQhj+qd1BHEcNU4jtFI4DtsOydVkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=O/uLsZgfoqQKJxm0Gu+0+ipi+yU6n+Fa+kt4qwSGKgQ=;
	b=ijcgU4mas/nqcxOTUyGife/rqH/t8xnyRrkXcySCZRFexqex7JPBPfVvQfpDrVNc/rbF7MM2euehUUqSdV2kCSBfD+eLHDpzHvVH8npn4k3XeHSdGea7ndQ9GMZUs0DuFw0LeHptNVoiInf+YDhNvCHLWN/aXqZSH2NTcYJY0qY=
Received: from DM5PR06CA0042.namprd06.prod.outlook.com (2603:10b6:3:5d::28) by
	MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2814.22; Sun, 15 Mar 2020 16:16:27 +0000
Received: from DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
	(2603:10b6:3:5d:cafe::6c) by DM5PR06CA0042.outlook.office365.com
	(2603:10b6:3:5d::28) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via
	Frontend Transport; Sun, 15 Mar 2020 16:16:27 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	DM6NAM12FT058.mail.protection.outlook.com (10.13.179.205) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2814.6 via Frontend Transport; Sun, 15 Mar 2020 16:16:27 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Sun, 15 Mar 2020 10:16:26 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 15 Mar 2020 12:16:10 -0400
Message-ID: <1584288970-69085-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(29502001)(199004)(46966005)(426003)(36906005)(316002)(336012)(356004)(6666004)(186003)(7636002)(54906003)(6916009)(26005)(86362001)(47076004)(70206006)(107886003)(478600001)(4326008)(966005)(2906002)(246002)(2616005)(44832011)(8676002)(8936002)(5660300002)(36756003)(956004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2555;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:exch.smtp.agilent.com; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ea5f17-974c-4ca3-7c12-08d7c8fc36ff
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25559903C72AEE154CE6F3AC8BF80@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0343AC1D30
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIRp0ATeAIk295hLtDJsH/O1Fa5yOQlM4g0AoX7BvM1yowxmrHUE3x21/ODKGu2Kv4Q2vhLdYoffTK9yuXwdHx5zlqQ3JiNXKBMl/nt22ZTHKee+AESSwTuReQf6N9o+T+kkhvjfJsihJ8Y6VIUIa6hwyp4+Fc7SlgE2y4VznjgkS0+36g2475p8fWexGCdQ3ZuHfraIpL9NWzGPABpf2ABTSsudyvaRTOo+T/cyTbjQQDZQa0p3keBY6BAEQGEUtbzXYSgir7twoXivCfjFgB0Vk81dA8jeKFbTW63AUXF2H6ljOBYvarhcPfaACUADIahDZM5ct4UW07X/oVBLPFWoJWlAAF+PypLVHcjqDtv7wQMeg/azxyLyFrm0EyBZJ9RCVj+CL3WdUMMLkDHK9b/g/Ahup+npR2TzKhxnvOUmqsTLIaX9yPafZO9nJNRKjCf9kijEPh8seyjSw4xZInHClTHB9wmgJvk1XtyN2MREHsAZluzbt+deh1repOQlGHThcvTmelW2K9P6YeSSj/fLE6A88MaiscmFKjs3swjSPUWSpdyaFlaoUvs2lbA+CRmlaznFuqiYw60A69soG4eOimKb+JylJg0kW9hI5a55WOeyuwRaMb1xRGhprT4H
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2020 16:16:27.5122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ea5f17-974c-4ca3-7c12-08d7c8fc36ff
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
Subject: [PATCH] build.py: warn of deprecated use of [noexec] or [nostamp] with value other than '1'
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
X-List-Received-Date: Sun, 15 Mar 2020 16:16:28 -0000
Content-Type: text/plain

It would be nice for something like the following to work:

    do_task[noexec] = "${@"1" if condition else ""}"

It currently does not, because "noexec" takes effect even when the flag
is present but the value is "".

[YOCTO #13808]

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 23b6ee4..2503515 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -798,11 +798,14 @@ def add_tasks(tasklist, d):
             task_deps['tasks'].append(task)

         flags = d.getVarFlags(task)
-        def getTask(name):
+        def getTask(name, check_deprecation=False):
             if not name in task_deps:
                 task_deps[name] = {}
             if name in flags:
                 deptask = d.expand(flags[name])
+                # See: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13808
+                if check_deprecation and (deptask != "1"):
+                    bb.warn("Deprecated usage of [{0}] flag with a value other than '1'. In the future, [{0}] will only take effect when set to '1'.".format(name))
                 task_deps[name][task] = deptask
         getTask('mcdepends')
         getTask('depends')
@@ -811,9 +814,9 @@ def add_tasks(tasklist, d):
         getTask('rdeptask')
         getTask('recrdeptask')
         getTask('recideptask')
-        getTask('nostamp')
+        getTask('nostamp', check_deprecation=True)
         getTask('fakeroot')
-        getTask('noexec')
+        getTask('noexec', check_deprecation=True)
         getTask('umask')
         task_deps['parents'][task] = []
         if 'deps' in flags:
--
2.7.4


