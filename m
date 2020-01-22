Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680064.outbound.protection.outlook.com [40.107.68.64])
	by mail.openembedded.org (Postfix) with ESMTP id ADBE07FD8D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2020 17:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=GL2yaOh/lDRpcgMKQkBBunnh2E82ZQxkbquSPioyWU25NWNCZpc7QETv9dV9d2Wsbw5Kh5UyqfQBIGMtcaUH2JlLakCmd1GM3PCIRxFmI7cpHs6zXa8CsCE+f8POW/c/wURy3UoeMpkVm8+L70cjUHzlWP2/0S0XDMQpvpKqH84LDFRQlQ6XXz/h6sYf/+yqdLpPbCU6zieO2YufNHhdy6Y+FzHXABWOh/8xwb5GOi+xnmIjEEcuSyu4nMbMVZCTvyIwLzBZp+MfPrjyqex8EAOdEcthxqvNsYIhs/4IA3nqy9mtu3rSlqNRztAEo1REep0OczA22T5fGm9j0kkpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=I3TFRHCcHZJifihoM77qI6hxvLUD++W1WP3k7xAEm9Q=;
	b=gr6qbsZf0jUIbFlPJiksNrQfmq2BQEkxNkX/wXDIGFcznfMvFWOLqsydM6KJAku6qvreTaBQiIfzp/PVFnQMwaf+rfgD9kqObKf0cko5UmXHox9AXgja/q/TM505e1fmvJMqR2QmphZuzz3SnG86UENacD68WgJT9fWTb6wQnAlaUWrZqpb7VoM+qG7nLXwbl7syFvsGZ9/LjpAfXk6+P8J4zI9daiH68G9AgsAWVkl6iRskjq0VAJ5nPvWJcn2/eBIPYKowmb5geT8Z5OgIQZj7aJiKYD9/9D2gx4R0F1eRbfWQPqASIoobCvcJV7uiogd/0N4wCx+v7G1a/jPfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=I3TFRHCcHZJifihoM77qI6hxvLUD++W1WP3k7xAEm9Q=;
	b=PYfONLHx8eXszcxyrceKtgnsysTTqlr5hRcLjdacTAb39wf+qfuFgcQebKhf/j/tsmNP5EAMgkNiPLoIW0XGrPD8BpH0GhNsaizqKZJwmk48vUeL9co24EhoU9ernw0/kYSkCxxdlBPCR7RJ5lYcrASdFBGaaaIAn2RXAyTnIlc=
Received: from DM3PR12CA0077.namprd12.prod.outlook.com (2603:10b6:0:57::21) by
	MWHPR12MB1711.namprd12.prod.outlook.com (2603:10b6:300:10a::20) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.24;
	Wed, 22 Jan 2020 17:26:34 +0000
Received: from DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe59::206) by DM3PR12CA0077.outlook.office365.com
	(2603:10b6:0:57::21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via
	Frontend Transport; Wed, 22 Jan 2020 17:26:34 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	DM6NAM12FT006.mail.protection.outlook.com (10.13.178.234) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 17:26:33 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Wed, 22 Jan 2020 10:26:30 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Jan 2020 12:26:04 -0500
Message-ID: <1579713964-40343-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(189003)(199004)(29502001)(26005)(107886003)(5660300002)(4744005)(478600001)(186003)(70206006)(36906005)(7636002)(2906002)(86362001)(4326008)(336012)(356004)(426003)(6666004)(2616005)(44832011)(956004)(316002)(6916009)(8936002)(246002)(8676002)(36756003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1711;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df553d68-b885-4a9c-b056-08d79f603a4b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1711:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1711BC132B4BFD0A74DBECA78B0C0@MWHPR12MB1711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeRVSZUgpTUYtb958GeoNjov22xH3oJKw9+eXzblbHczQiAWVNlWxoHIZrNpXdokz0VNpkLsu8SCfvCqDqUr6EnTp+tL/NlJQFbghPvNbIfNI1SKfi0N9PnlJjUtvB/Wqi6ZGfQSBdwyVWSAgLpcwoYf4vfXwoAB5hbGJLZWWOLNzIcSWYM0nA9+ZnzIeGftDtKYOsWa+SXNy7/KXI0HYBaUeLBPyLGrX1FOt1CuTwyYz/dXJpTWPqagyJj/5jj+/8Jh42J+vetNw5Wc1kBgGNCyiYOMQ3l4RIpR33/MlJHxml7HencxKxdGOmXHZ0a3ckdIEjS4ePmw1RNU6M1EheW7s6jPoWRRvIvylJDi0cSteEXTK7r3YhQiHTBeR82B0MWVOOE7BPlhUXxXtoUhawMbAFQafopfnWVA//DQxZBHhrRAAvvrBa/XPwrEbDPrz6qKbHUGv3+k0jiHxZV5dq/9MJVFLhkLa7N/pDGcXf1QbGRSF8w6qSXxmoqh/BkX
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 17:26:33.8630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df553d68-b885-4a9c-b056-08d79f603a4b
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1711
Subject: [PATCH] build.py: augment TaskBase to capture PN and PV
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
X-List-Received-Date: Wed, 22 Jan 2020 17:26:35 -0000
Content-Type: text/plain

PF is already captured, but it's a pain to try to parse out PN and PV,
which can be helpful to have available.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index b6d23e6..23b6ee4 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -65,6 +65,8 @@ class TaskBase(event.Event):
         self.taskname = self._task
         self.logfile = logfile
         self.time = time.time()
+        self.pn = d.getVar("PN")
+        self.pv = d.getVar("PV")
         event.Event.__init__(self)
         self._message = "recipe %s: task %s: %s" % (d.getVar("PF"), t, self.getDisplayName())
 
-- 
2.7.4


