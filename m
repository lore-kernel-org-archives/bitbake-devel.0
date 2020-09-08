Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.79])
 by mx.groups.io with SMTP id smtpd.web12.1860.1599607929382892513
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Sep 2020 16:32:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=xOSVX8T2;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.79, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPXnI1MCMHLJ0kyyUP9rO2m4f08Z5lxO9FIkOTZu5IvQ9DwVKKwVnmJ4gSprrSS42fhtrDGjpBtvIcsZMxzk+FGic1MiDjqu9NsllH87RT2PCGYKAjQaNVV38ie3Y+DXXLUGY58LNOUpfFzCyTtx2c5efGA98ofTE66zh+XBmpk0xegnQftlUzMWy/4D+zJr/9SxYGdXmNVL2oGU6dO8gTTlHBYju8eU3LzZfy6E0tbiiPuYgR/hw+juXqUIj7xKZTtyGb8LuduHys1BfLTKmS9+ScTe8pYRmxcfC5BRU1wIST+Hq9fbAxfMNb8GTAsftmD9Bzigx7tOV8QU0iShsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s/ypalBdDVUZydbXLU+fIzOU7JFEOTOq3WC6EECWLU=;
 b=Dqal3FXEA0R2bfu2eHIWmmOqoGw5XwsQN/XyyML62GXopmSU8QbyYFs8VLzPN4YOgh5F3Ui608gBI280m3ymGJ5eloHDeyz09MSEd9EZp/YEZwudi9ZTiLrS9Dt3Evi1pd8GFx47l9qhZbMbfTpRyt2hVt4O04Z+LgP/RUi3d6KLNHtR0U6Cb8SV44DVW1MhF+qYnry8QWITehmaOaYXtdcsCLg9lk4n4/vUBySw/Nj8j/zOfv7FZ/PwXy04Vn6woKdseYe0qvl1s0hx4usDajFnNQcV69Gqr831Nsdk4rA5VsMsIAXMXAqhD2nseW49Ig8VLzYHMIkLQHc9W3lTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s/ypalBdDVUZydbXLU+fIzOU7JFEOTOq3WC6EECWLU=;
 b=xOSVX8T2RI+aLK859t1qJ8kh+Kn5AYe6wUAbKytF2C0jhXpJzWR8wpZ/P+RGZ7hwL88hP/8R9Hlg9eeBMSLDSvRcBh7sjP17cQpsno5LZPbnGBBwrkkCxme5b9ipb+Yaw4/LWU5foiOkj6RveTzhsSbucRYhayrJXQiorrh5mLQs9LWJzsRjEzKd8Dt18FXtk24UFQXLe91x45a/rWrcrZEAGtthIupzYWPb+jvX9uTRkrgElWN/Nxh+0z7X003OKbM6Jf4aIF9PX2kMy5vdfpRf6T1EU3jSCbcMWAib5VtTa8xsUTZyj0b8CWyfkZDofC8YOqnrpUmML1CzNmXMUw==
Received: from DM5PR21CA0024.namprd21.prod.outlook.com (2603:10b6:3:ac::34) by
 DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Tue, 8 Sep 2020 23:32:08 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::7) by DM5PR21CA0024.outlook.office365.com
 (2603:10b6:3:ac::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.0 via Frontend
 Transport; Tue, 8 Sep 2020 23:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.8 via Frontend Transport; Tue, 8 Sep 2020 23:32:08 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
 15.1.2044.4; Tue, 8 Sep 2020 17:31:55 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] utils: fix UnboundLocalError when _print_exception raises
Date: Tue, 8 Sep 2020 19:31:50 -0400
Message-ID: <20200908233150.91699-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg1.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4fcd0b-8421-4c77-f204-08d8544f6731
X-MS-TrafficTypeDiagnostic: DM6PR12MB3932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM6PR12MB39328685559537FA504469638B290@DM6PR12MB3932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bF/LCEUGCbRYM2jBqs252tEkaCCGHgltH8xckBWR/nzCJjCJEyyb2g+SPD3OJV4L+vRq4cTDXaJPfVzQWIJZkIbnW59vkueZlLC0e1ZT2b/x6VQOBbuc4I3OTgWdTalWmKPA5xuHBHUF6SoAyn1jh/2bPWfkMJ94YjEMwEDn1NgcD9pfywoi40D1fz8f9lnV8F3Envn9RCwNuQDS2k+1Tt9xh9pHu/1UjfLdKWIA9D4L19sWoY1chwh/91IVDTTW1FyWpLxMyZ41DdVVK8Q4GSXHwZywpmWp0gtvmRYqJpqVe2Wbl/HvVujS5pvt24nq2vxcNtFwxTY9XyXqyA7QM7JcYVH0D3VmaS5FE2yhot22hqfxrgkLSbKjhr00s5aVuTZCVNk5JBZSpe6boWWHiLbYd1rvVM4WuI4MR/NT5sxieUHlH/5hTU2qSCPGKuLv+a1OeQhVfeiKeIq6dq7V2GsHLAP4sztfKPivDGa+yVmGoAtYU90/C0GO96DOE2so
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(29502001)(46966005)(336012)(83380400001)(70206006)(82740400003)(4744005)(966005)(7636003)(47076004)(107886003)(6916009)(1076003)(6666004)(5660300002)(86362001)(26005)(356005)(426003)(4326008)(478600001)(36756003)(82310400003)(2906002)(186003)(956004)(2616005)(316002)(44832011)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 23:32:08.2201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4fcd0b-8421-4c77-f204-08d8544f6731
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
Content-Type: text/plain

PEP 3110 changed how exceptions work. 'e' is unbound
after the 'except' clause. See: https://www.python.org/dev/peps/pep-3110/#semantic-changes

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e51b8ca5..c70ec742 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -402,8 +402,8 @@ def better_exec(code, context, text = None, realfile = "<code>", pythonexception
         (t, value, tb) = sys.exc_info()
         try:
             _print_exception(t, value, tb, realfile, text, context)
-        except Exception as e:
-            logger.error("Exception handler error: %s" % str(e))
+        except Exception as e2:
+            logger.error("Exception handler error: %s" % str(e2))
 
         e = bb.BBHandledException(e)
         raise e
-- 
2.17.1

