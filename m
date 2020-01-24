Return-Path: <chris.laplante@agilent.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	by mail.openembedded.org (Postfix) with ESMTP id A30196D74B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 15:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=GXqaxVqo+lZ9itZa2sWV/Oz6CRoegpcN7IdDAhB0P7b6E+Ig6QRRTqGocajjHs7NAJx3fz1YowhXDjNa3+eySfT2PLmnZjgvXO8ZY4Ut3WT6eAsCwiR0CSgM4RBm5yXVlef+S5yhv10nTRT+iwVfGhX+0XTftk6MDCUUbrDgJ2ujG4DZcBOp9lOUas5i4QV2y4if2XAkgnYlaM/RY3ANUZZyJ0z8wiiF956Y05c9Vr0aFXzGI8Q9OHOxxY5aTh8UKIYV4rYrrXl4NVPm5KURW7a3MuAk9qNiIkm6VCLRqkQAfRDXMjUhxE4Hrbjy6d2YbHxhqRhsXaiXmigznu/sVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Sfw8QfXJCf1UuoLXbd4C3ZOysKuHvYQMixHu95jiJQk=;
	b=AuTeVKIm3lSmsMprrIAxhhUeYWYeZPcwJZJ3W2MvdL/GGAIJYXRc0SVeDIyPW4lbeMITpCZ6l8c3g1N3JcP3y0nyuf31KDvKOUCYBxWpgvQkOJysDLiQzd5kO5dhacesXOy0l2p6SjBji1FwCbLbMsAz1e6TgUlyf98B4phH63iuOoOScO8nT+A5tdSAYFeP8muk9ZXDB1OVF3YCZV2eNf+g24B2QS9eDA/LGQQ+jpzUESFYOgIUF/nCF/vC3dz+w0wATTDiEDGdrXkNrGqbH+3xv/o/RJhbysr4ueBrqT2MDj6Vwv9XmKpeTJuj5H0iNVq59YXu6SmBrfo3E2mgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Sfw8QfXJCf1UuoLXbd4C3ZOysKuHvYQMixHu95jiJQk=;
	b=rMP+QAhLPvRg4YMVpP5xyKvOBVP5ulThQ8iolQAIbVkJ8GFkvNDh/PbtCUYhGUgegO30KDqAjtQkvkkB7lEiZ4xj51BmIPnlJiCPbKSOeumclp1ZipPeDg+NmOoBL6fEXtm8Mi9k5WkhPrOCsjQP4Cq/i2VgxXbptR92YSd+iXY=
Received: from BN6PR1201CA0009.namprd12.prod.outlook.com
	(2603:10b6:405:4c::19) by MWHPR12MB1389.namprd12.prod.outlook.com
	(2603:10b6:300:13::12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20;
	Fri, 24 Jan 2020 15:16:44 +0000
Received: from DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe59::208) by BN6PR1201CA0009.outlook.office365.com
	(2603:10b6:405:4c::19) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via
	Frontend Transport; Fri, 24 Jan 2020 15:16:44 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	DM6NAM12FT013.mail.protection.outlook.com (10.13.178.66) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2686.12 via Frontend Transport; Fri, 24 Jan 2020 15:16:43 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 24 Jan 2020 08:16:34 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 24 Jan 2020 10:16:22 -0500
Message-ID: <1579878983-121851-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(29502001)(107886003)(186003)(4744005)(426003)(26005)(336012)(478600001)(4326008)(2906002)(70206006)(36906005)(8676002)(6666004)(86362001)(246002)(356004)(6916009)(316002)(2616005)(5660300002)(36756003)(7636002)(956004)(44832011)(8936002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1389;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7884982-b036-4266-0f3e-08d7a0e06bfa
X-MS-TrafficTypeDiagnostic: MWHPR12MB1389:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13894CABFF43334B5B4049928B0E0@MWHPR12MB1389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02929ECF07
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knLZjH6EHIiyekQg8YFWASmDspsquhQ2qAo3BengKyCpOT/avtRKEaQbrOncDzGiFd3GEvUUkjY3QJvylp16K7pIc8sjDSkGRELztsM8sqNeT3xboZFgybUIbm4jeHdImV2Q0NDKNuQDOS7ia/yBfTO5zE6vxSZVFaiAHfTIibnINQDGO3PkNGJkKobhSWIfGAeOpM2LKjg/Z9SkoXG4opa3mTKXaUX+f7x3CMRKRm8fN+vUnvtFopfykhoh6L30ndM25oWq1vfeU3eMBro2qQ7kdLCnjYtFD8R4DB6IyZz31sEUgLyOIdkwvtkPy/tI1D8/DFf4hvlyou4oM2TmmBGdyPNXwnTireFMeukcR+K1QhdEtEzcMDTBcFhFOsZ9W7tW/PqNFrW7bqe4h2xrkee+H4Vlu/9EQHeTtGbo54l1CZ29lWNuVeD3yjyGv/OuDZojlL+RYaoybCqrC5QW28vMVnYDarPNpJqnlyL4f0b2hHH43H1GPSiPvYf9XJsM
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 15:16:43.9533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7884982-b036-4266-0f3e-08d7a0e06bfa
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1389
Subject: [PATCH 0/1] TeamCity UI
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
X-List-Received-Date: Fri, 24 Jan 2020 15:16:44 -0000
Content-Type: text/plain

This patch depends on one I sent a few days ago, entitled:
    [bitbake-devel][PATCH] build.py: augment TaskBase to capture PN and PV

Features:
    * Warning and error log level handling
    * Won't kill the build if a *_setscene task fails
    * Reports discrete task failures (exposed in TC UI)
    * Reports do_compile failure using special
      compilationStarted/compilationFailed messages, which receives
      special handling by TC

TODO:
    * Need to do a better job of grouping (blockStart/blockEnd) the service messages
      to avoid flooding the UI.

Chris Laplante (1):
  ui/teamcity: add a TeamCity service message frontend

 lib/bb/ui/teamcity.py | 398 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 398 insertions(+)
 create mode 100644 lib/bb/ui/teamcity.py

--
2.7.4


