Return-Path: <chris.laplante@agilent.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	by mail.openembedded.org (Postfix) with ESMTP id 3C25A7F895
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2020 16:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=K+nCX50LsqiqOYpyz8wO76RR6l1is5yTVjCnaiOMFuJ/ze9nsNJkzASRb5F36AVIFuOLrK02fLL4PsJKPjbmu0ymAnyNut16VdqroDJ00tswk2KRnFq/v6siJ9oifpLU10lCxDtOebB2NZT/a7fU4wzAwbGSS0Uq9WdSGbONq44EJVmoXLQSLqcD94AnqhfUDwg6Vj88G8qztveO9oddNixtRYHQyCbUQLORH5/s70y+eE8A9fw11Yx/phdJPePug4MqpzyS+ffD06dGXHWpg9Kfil4b+sGvkAV38im4WnmqzZvfus699xfaiXEkKrPFZtSSxNILLl/F7MmtVwMvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fuhEjM2HWonC5Q29movd2bA2lFAx+hhVkrwF4/aVvVI=;
	b=JvV4jXQ8+ePt7bFxxbgqMPYsAVYMLEsJCrNzXJms80HTVEbYKgCqESMlm0xIC/AznKLa682Q5YRbdpziCDdOhBmkhntkf3UNqOTz2fy08Gz+58xiEfw2fx57CWWSXg/Tg8pHY6T2gBkQmK0j5VNmVS9JzL1ZHMDMNAcwiW6ucF/HrC//YPxNjqmJkgjbOHPndbhTF17m8pCILBHlE7Bl503PoC1gMVhumIj1upoxT2DxDNIHB431nGz4/MA3po6IXE7O1LNExJasmOkvCMiz7zHu3zxkklZBZeANK3n5U8f2N/iqDmpCE3w/fp1DZ/9AnJjKtn7fIK3AZPHPb8yHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fuhEjM2HWonC5Q29movd2bA2lFAx+hhVkrwF4/aVvVI=;
	b=LqdmFaTGpziFyBHNygCNf4I5uYoIAXvTRGx5UqiMLgJTogjVdC3X1XHp/c0sFZWsmTvA4tbynYwjxV3nggfGSgJYeGlJcJkAc2nqoQVxHl32AveCNMd5ajpaM7bRXi7mdvWqNJFanCfYplcljHIidRV5zzqfDtswBf0LcAVB0Sw=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
	by BYAPR12MB3142.namprd12.prod.outlook.com (2603:10b6:a03:de::19)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9;
	Thu, 16 Jan 2020 16:28:52 +0000
Received: from BN8NAM12FT020.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe5b::203) by BN8PR12CA0036.outlook.office365.com
	(2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via
	Frontend Transport; Thu, 16 Jan 2020 16:28:52 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.34)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.34 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
	BN8NAM12FT020.mail.protection.outlook.com (10.13.182.144) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2665.6 via Frontend Transport; Thu, 16 Jan 2020 16:28:52 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Thu, 16 Jan 2020 09:28:50 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 16 Jan 2020 11:28:05 -0500
Message-ID: <1579192085-27436-3-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579192085-27436-1-git-send-email-chris.laplante@agilent.com>
References: <1579192085-27436-1-git-send-email-chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(29502001)(199004)(189003)(4744005)(5660300002)(8676002)(70206006)(8936002)(36906005)(356004)(6666004)(426003)(4326008)(246002)(107886003)(956004)(316002)(54906003)(2616005)(336012)(86362001)(44832011)(186003)(478600001)(7636002)(36756003)(26005)(6916009)(2906002)(14773001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3142;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ca7b132-4657-48b7-88e4-08d79aa12c69
X-MS-TrafficTypeDiagnostic: BYAPR12MB3142:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3142C2F5933EC0DBE7A39BE38B360@BYAPR12MB3142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOOHnFjRZ3mLmtxmfRNFMjeg5tE1UBEKID4HsQ38jtzabVIQoX+cRncH7s92nnww2pf5QocsrENP4HOyOzNAYxq/3qKP7kP/QAj/goqHzz9UQgEW5+NyRugMIKaamsq+pEJjrpsJlKM5ewbyeV3R6Ww3e+7oPclo7EbUsrWUFdMMAoBVAuF5U7PeDRajItHBc1Xw71ZWIkhco4kojkUZvvzmCfgixtAK3Q87zSNli5JdG11Ko9gktns53iTqEJXPHe8+tPT8lO57j9ywqHA5/0caW0dVFrJGniQlK8bazpFwk2eABD6TnZ5cFZKDWodUSTN0EcaJyByJ6fUGpgL9gUSamOusDhLGdEtKA+FZFZnyLVx/0W5FgkiCifFT3vCwz9yS/cr01giTr/KK8+8+sPZEHioFy+2UQTpqExjYsw8wyMBT1BdCptkZNhwDIVbvZqVtU6rYEsHdJr7rv2hc2Wa++d3zcHhKvJWIfv+ioUOGODgkf8Q7mm+58edCw5Zn5GrCAKKsPLUtUJc48EzRZw==
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 16:28:52.0351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca7b132-4657-48b7-88e4-08d79aa12c69
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3142
Subject: [PATCH 3/3] persist_data.py: Immediately get exclusive lock in __setitem__
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
X-List-Received-Date: Thu, 16 Jan 2020 16:28:52 -0000
Content-Type: text/plain

To avoid races, SQLTable::__setitem__ needs an exclusive lock for the
entire transaction, not just the INSERT/UPDATE part.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/persist_data.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index de8f87a..7357ab2 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -179,6 +179,9 @@ class SQLTable(collections.MutableMapping):
         elif not isinstance(value, str):
             raise TypeError('Only string values are supported')
 
+        # Ensure the entire transaction (including SELECT) executes under write lock
+        cursor.execute("BEGIN EXCLUSIVE")
+
         cursor.execute("SELECT * from %s where key=?;" % self.table, [key])
         row = cursor.fetchone()
         if row is not None:
-- 
2.7.4


