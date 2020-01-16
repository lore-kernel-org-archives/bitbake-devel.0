Return-Path: <chris.laplante@agilent.com>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
	(mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by mail.openembedded.org (Postfix) with ESMTP id EBE4B7F8AE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2020 16:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=BRvyqyAvZW7Sb6FH0kfRHxDjNEbMop3jiaZ4Nk4A1YdwsD6iPUajA9II8WEVH/Eh+5w5rgOPRDIe5+9FhtU3JaSv2i0t44PCV1Mxt3jZ0UdMXk3Rga6oUEzjiikIfwtqyC+iBR24JOMWG+FRrzWeO2YgWnv7Wofi3tGkJrI5BdeG5vz2m4JcAx9VUXD3qLR08ys7ZWauEtsHMSgWKouv3D+HXYd/8iyANPm+1Efw/3KLzHE+WxxZzbki4EMoAxw+tl3OWUL69KRytoQNHHKSvqqDkPiqViKo63BjfRXa7PhW/vtb3qgMtL0eUOgG5SwgLpzVQ0LIoQVYe2OxBVow0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SOgnIuM/slA3qDGVjT2+NPa2ZWNnTRmqZ3/BJLsH0fA=;
	b=IzB//HvZoZssiNqsqkZI7y2nQMzPSqX7kRueXmluCApS2maw6/ebCELUJarjqjWGJVzHtco44WGQX5v6vlHFvXVhxP/mEkX2e9a8KnkqOneFT+giZ3mKYFunX6EZZw0oIKRwCcVi0wPz+hR/m+/MFmw1ltouwEBt7iFmeGs1UyuaGIXFrVRKBQJHxrQrb19jUpNoo4qFE3ZEEGjsG7SEm7jpzpLeIlgOs7+81d6GFjU0aGF40+dLOFjvrbIRFVLAfrw3PxMx0L9OuCirCANBoaiLUnuLdQKqx+a/F8hhBTAPZxpBdJYLWsj1Bpl1cSYkzyXEQdVuxQhWN7ia0dv98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SOgnIuM/slA3qDGVjT2+NPa2ZWNnTRmqZ3/BJLsH0fA=;
	b=KLNR7VxsM0ifW9dzqDL4lZoVZ1h0G4eRiRc2ALL25xjOHWImqPsMGl4HcriqjE8b+1xqhBH2MtEFVgZlkUXd1Wf5msDnVCb+7sFXc6vTImGiBmy87H6Oynz1jpyyDBXmwjIlJcg6XoaWcs2zkh3VR9i+bBph/kWGeuz8SrtTlUs=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
	by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18;
	Thu, 16 Jan 2020 16:28:51 +0000
Received: from BN8NAM12FT020.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe5b::203) by BN8PR12CA0036.outlook.office365.com
	(2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via
	Frontend Transport; Thu, 16 Jan 2020 16:28:50 +0000
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
	15.20.2665.6 via Frontend Transport; Thu, 16 Jan 2020 16:28:50 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Thu, 16 Jan 2020 09:28:49 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 16 Jan 2020 11:28:03 -0500
Message-ID: <1579192085-27436-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(29502001)(199004)(189003)(7636002)(186003)(8936002)(8676002)(86362001)(246002)(336012)(70206006)(5660300002)(426003)(36906005)(6916009)(44832011)(107886003)(2906002)(26005)(2616005)(356004)(4326008)(54906003)(956004)(316002)(36756003)(478600001)(6666004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4188;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf94eccf-485a-4929-1474-08d79aa12ba0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4188:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4188B0D5F2159496E92BDE4D8B360@DM6PR12MB4188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8ekrJJZ7nmIt78lHIQvIN7uMWWKPMZJ9IS/850MZ9Rtzi6FRVpwB3JoayLJV0N1VCS3cziFfGECXt8TGTEwyT26r9Vk5/bkWDhw9ugT0jqpYmrEaX4Amo21R/2FhzZk2q6psHgkQPMcIm1bgcPIfpWlYGtgy22FTBUS8HtsbD5d4DACzl/WAI3ufBNWicDvoCBQEzyFqJ/ka6uu0teSN5Ohykb8Tzs/k+RGUFQ87oR39onj2E9JkY4+hCLnXoImKKtkuUx6LXoijINDkNvxOyadseskI2PRO7oqIqC+z3CSyqgueWLodpD2lC//+RSjeHgy4y206Qlnc/wuK5Aac4xMQAc+mbR4JF4VggNN4ny38ZBm00vaWwYVOGUV7KyZ1L4L9CW193zv4OMrmPO8se17TcGxC+6YlkGl77kAvUluhGCQV5uNuMt+vE2yHfXz2d0uhpNL+j8fWXEWvCFzMgQFf2SZjF8zmUNKElYnXbTPyOpp2fgTvYMNdjN5Bnvl
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 16:28:50.7118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf94eccf-485a-4929-1474-08d79aa12ba0
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
Subject: [PATCH 1/3] fetch2: do not suffix srcrev cache key with PN
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

Prior to this change, two different recipes pulling from the same
exact repo could get a different SRCREV during a single parse session.

This was originally observed using git. For git at least, it still
allows recipes to pull from the same repo, but with different branches
or tags, since the form of the srcrev cache key for git is:

        "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]

Where the 'unresolvedrev' part is the branch or tag name.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/__init__.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 731c160..4a781bd 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1567,8 +1567,7 @@ class FetchMethod(object):
         return True, str(latest_rev)
 
     def generate_revision_key(self, ud, d, name):
-        key = self._revision_key(ud, d, name)
-        return "%s-%s" % (key, d.getVar("PN") or "")
+        return self._revision_key(ud, d, name)
 
     def latest_versionstring(self, ud, d):
         """
-- 
2.7.4


