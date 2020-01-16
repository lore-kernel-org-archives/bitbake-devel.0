Return-Path: <chris.laplante@agilent.com>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
	(mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by mail.openembedded.org (Postfix) with ESMTP id A56E57F8B1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2020 16:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=P4c2ytvO/yuwuQI2kdGBR1+TvUqiZMEioEfkZKiOaGE1rz7ja3CXMbuGbjre+TfojaVpaQJtz5svBdOj4v/ONvAnOk7N0qi8wJFaWfLuDjtcYLJeLuuBqtVuX0WO+gfMUmQYabk+16f4L/9/7L8vx7z7ImVet7O0v10XJMYWodrQNBn+1vmhM/0z6OUYdUcm8qQ103Ksd+WvVLVg6fgeEGBCpYIA+FUDmZwg3XMx8x0uL3D2IEUiioSAZKM5y3ss2bZbMRkmEwvUBmNxhBz6yQZTz36wB+QCYfWHszcdDp8FWGVuIZvHWaC7zmOBncI3Ks7smmCBCva3GjZBg4buyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=YxChMSBB5Twf0MaCDOx+KCIGswUqyeRZ8fLQSu4pk5w=;
	b=FdADtqUK1LZu/5dpU1DW023WuDUwCK/quoEQr79OaGkHoE0tjL2U8tCOGoxmMCEQ2Y3iNzyaAN+Y3gfBUVMWysoar6Sp7IY5nBGAqdLsAlsu0d0L/VsypotY3/u0OPhXMosyRqh6IKC6MuNde446ms45AdM/K3Bs66OyRnFf8fjr6uZrDO28BdwhR2bTpyJIu9WPiFjPba4W2Pzis2kmuOG/xBWOfiad6kmdhEeEhoMxYOMGCGs/fHm0a25k8bbpYMZxdWlnE1IycOJfwt8KZq5A09kdV4S7E3pdNuFn5uet44Qg+DpFZzqb2c2VcYzqSAxTrdJSwWmf+Czs57gxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=YxChMSBB5Twf0MaCDOx+KCIGswUqyeRZ8fLQSu4pk5w=;
	b=DkeOaz/M9/nnOEerqh+ASGRtUpkdwsWQRehj4fsF4ddNulqILRDTkxzIEkLa8ZSTVSLd7vgsEF9m1GfgmG6H0VpD1shcWlN6KBUg1bXCEZHryDyXpmv+eeEgw+/Uol/frG2n3m664WLgTDL4TEzbPfVJZ9SLLXNC7tUayttBgtU=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
	by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18;
	Thu, 16 Jan 2020 16:28:51 +0000
Received: from BN8NAM12FT020.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe5b::203) by BN8PR12CA0036.outlook.office365.com
	(2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via
	Frontend Transport; Thu, 16 Jan 2020 16:28:51 +0000
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
	15.20.2665.6 via Frontend Transport; Thu, 16 Jan 2020 16:28:51 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Thu, 16 Jan 2020 09:28:49 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 16 Jan 2020 11:28:04 -0500
Message-ID: <1579192085-27436-2-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579192085-27436-1-git-send-email-chris.laplante@agilent.com>
References: <1579192085-27436-1-git-send-email-chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(29502001)(199004)(189003)(7636002)(186003)(8936002)(4744005)(8676002)(86362001)(246002)(336012)(70206006)(5660300002)(426003)(36906005)(6916009)(44832011)(107886003)(2906002)(26005)(2616005)(356004)(4326008)(54906003)(956004)(316002)(36756003)(478600001)(6666004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4188;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6da483e-dd4d-4aab-389b-08d79aa12c0a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4188:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41883EBD6E0091EB513928BB8B360@DM6PR12MB4188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bd3w+gGwMjuqJ/HBmF6Xuej4+0XgDM8smnwytjutH7tXmA6KKgDFljnfe6LGWjfWKiXYwhez5pvyRSPImjxQu1aniDGPe2FEuKdCXcXluy/oQf4qg4UO29rha0cijxzfwZiPJBUR2kEQ/F6e49Ra2V68sGZyX8/kn3RPL1I8n98hUnWoJ27/5CWTkDaXUYB8Ug/76KAtnbkZkj5kLqFJCgcgROcQ5G+qIhtGwwlah8GnM5e5GrTZ95RReM9eIyfzPzSFBAbFU35wwpuzn20AosrFArR204bu2f+zYADD3PIkepfLcvNWXHSwsmtelz/IV3FpjCuz0Y6mAhMSKbLe5MRa88WcygOcI5iEYEu0HW2sGcopVHWe9pO6hXqJ0HzMf4L2gz4cww3uox8v5CWn9ffH+u6D1ha5gZJwmldb7PcROuts5HUmzCscTYIbW2YEgnhvj8ZkG7acoAw2TOLKi0mRK9hnu1duxW6BHiS0otorkORBKh7F2yO9/sKEycQ
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 16:28:51.4094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6da483e-dd4d-4aab-389b-08d79aa12c0a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
Subject: [PATCH 2/3] fetch2/git: _revision_key: collapse adjacent slashes
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
X-List-Received-Date: Thu, 16 Jan 2020 16:28:51 -0000
Content-Type: text/plain

From a SRCREV caching point of view, there is no reason to treat the
following upstreams as different:

    SRC_URI = "git://github.com/file/file.git"
    SRC_URI = "git://github.com//file/file.git"

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index fa41b07..9ba9cdc 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -594,7 +594,9 @@ class Git(FetchMethod):
         """
         Return a unique key for the url
         """
-        return "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]
+        # Collapse adjacent slashes
+        slash_re = re.compile(r"/+")
+        return "git:" + ud.host + slash_re.sub(".", ud.path) + ud.unresolvedrev[name]
 
     def _lsremote(self, ud, d, search):
         """
-- 
2.7.4


