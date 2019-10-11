Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
	by mail.openembedded.org (Postfix) with ESMTP id CC8617F5DD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=D7iAL+i9I/Wih5qN5WC74r1qsrioxoxPqJUYVAosFCVplijiqpQektW6xslGApYjYNOz81pdQdTnBIq2bbCRH78OS6gKbZ2bUAdIfWiRcLAEkaUvFZxs9nFI8YdHkDLjTPZ7CFs3snUb/2udZmKsOqD3GMvKJWkMEdQ+NBimLwjlX2ZI6Pw3bglZvsOZPjyW1E4UAKv1px1zLPf4v+6U5yRx+etNSdq1wMzofs14ebs5Ir6FHPjBrZJg4AHBv3mxBCIBIMEIJza3M2yc8cKeml1sW+5T906r4J5vuql2R+DJp/TRw5nSfQ7TxZj0ZzdydKaOFOedzw7927O2SWKqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BAAD9BZyEqM7B3liBkRgAwHXixOIe7PZ04X8Z/oJZqw=;
	b=j+uIA1rYTR9aL4VAIOHG3TSdxREOvd6wT6F0mSY99/p7NlHsjcBDhDxs7ma1ZhseJX0jSJ2V7q4ilI3XX9xZ0U16TdprlJ/ld51B7GIKUx84IXb9XTAz6dMdSXFmoZ5gQIGKVTKHp0pghNhUk6e5c+bwnJN7JQi4Wov/cO0lTdVv8FsW4llILjTWIpN2+WJ66hHRihoFaWhF5x8zCB8qEEANJSLXA3GHu3kBTk7S/GQU1NFpxESb0F4EMl9yRb48rDVuZRxUJFB6p5Yd7p4eq70u0ZeSK1+nNzpOlrzJyFsfYeawD0Sf+eBHWVC8kiqBsGQLD4BLHDBTVROJ/n584Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BAAD9BZyEqM7B3liBkRgAwHXixOIe7PZ04X8Z/oJZqw=;
	b=a3ajlvbtaIwe46OSisQWR3eets2T1fOksX4GSEe0gVDRNlHROTfR92ORS0lle18+w1A8t7loSWHnnCkBce6XaKr7qJk7JhFrk7TT08/Edb5udx8lFociKYo40Kh7o1jR6vfv9f7HxvukUxYgP3kJuhCtNaELXLatHd3TV3n2PW8=
Received: from BN8PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:60::30)
	by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Fri, 11 Oct 2019 16:23:31 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::204) by BN8PR12CA0017.outlook.office365.com
	(2603:10b6:408:60::30) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:30 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.34)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.34 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
	CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:30 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:24 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:05 -0400
Message-ID: <df303e826934058ccbdc2bc58a56e766b362b7aa.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(29502001)(199004)(189003)(6666004)(356004)(4326008)(478600001)(118296001)(70206006)(48376002)(107886003)(50226002)(47776003)(36906005)(36756003)(476003)(2616005)(956004)(426003)(76176011)(44832011)(126002)(486006)(2351001)(336012)(50466002)(186003)(54906003)(7636002)(4744005)(106002)(2906002)(16586007)(316002)(6916009)(8936002)(26005)(8676002)(246002)(5660300002)(86362001)(51416003)(305945005)(11346002)(446003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4206;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea1ed4f-8509-4db3-32bd-08d74e675aba
X-MS-TrafficTypeDiagnostic: MN2PR12MB4206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4206CA5DE7369E4726DF1FB98B970@MN2PR12MB4206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObGVtN3XJ+r/0MQfs2/M4sE7euC7Iuqt7Welb76FCYGgSKSZ8Iz0A71XlITgRs4Dil6Lq2jtQcIxsjux/wZbIEGJBL6IUx+kAin/ZwdGQkhE+m+J+dcfVEt/f/d4eRWI6nbW+YnFYiwrqDOTaOZUoI4mddJQVu3LrD40BcE7yKOTgWXLsHIoKUM2Uuq6JyUj7oIExfIcnC7+25T2EJN3gBqJFW7rUS6FwX+Ty3dViX2GqF/Q63yEyUaxGttipaUfXu7Ry7bvTVMSf64Jhwzb1ptKJkxgzLQiJcae/wd8vydapoKlrRZ8GZ0H0Dx78aD5Iv1RfTr4WgqRMzaY8cQQOgFhQm0faT8k1gJAj//0u64LT958MLeVPy7NF52Quyj9BCItkQVocbYEwGOxy9Wu3IMfsvpXcdEaj3ZNpn/Si10=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:30.5843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea1ed4f-8509-4db3-32bd-08d74e675aba
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
Subject: [PATCH 5/9] bitbake: contrib/vim: don't redeclare indenter
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:31 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 6bd7b1e..3a0ca86 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -2,6 +2,10 @@ if exists("b:did_indent")
     finish
 endif
 
+if exists("*BitbakeIndent")
+    finish
+endif
+
 runtime! indent/sh.vim
 unlet b:did_indent
 
-- 
2.7.4


