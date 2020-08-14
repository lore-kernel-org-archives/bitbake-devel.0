Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.43])
 by mx.groups.io with SMTP id smtpd.web12.10.1597438636188547629
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2020 13:57:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Wj3SN7RY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.43, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVq8nWbYa0h1K0pzIxns77I8AyBxs/bObXVXYe7ASgtW1RMDqeUgsklDJe2mPYBHjZQDF607hmFll0PSp0rU4ndCYp1OBvyUJnAZmo32rneEdJAXx5BEiTZ7OrKL+oBiS6ze8N6yCJ5FQAV2YJgkZzzotw1r1zHJkx3DvyMPie87CTkDBq1cxSJ+Mt2nKTVRefjqIzJL7auXGuaCny+Ju7tKvji0jzVOAUdHD/fcYY/z763WKyIvvvP2fjrMDYyIzzHpMmMJjoxSnJG5tvsRF7SbrviNI8/xX00/scwLs4i5SYzmdTNPORaAHh+XcYrMEpBV694iEAFASmu8C1cxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvzVKdBBE9diAjPVp00cKe6HhfCuXUECCqIdwUJShtQ=;
 b=U29c4g7BqmAGIWHy1q6hsiXMZuSaZ4z/gq+uNfNLVKcWs6g5ZNR4/HyPfkCEiYhfTEamukIZj4AR/QDiQDMBRjEmjoSyxd0LlQhOjcuPFlDi3UV298Vj7AdmH8MFdLQkpl8Wt04G9hxcl8+nwbkr92G+z/eWdsMDrUJ/EmeDut8rec8660aGttc+wPeZtMbC1eX2/eS4ReWEmEzaa7IV9vjLh2/fNqOMXHyxyRu3y4mmhddNo7ZOpVODr5tsDBG8eCdcq9twY9yRbeth/i0W7D/TfTnId7b8NdfgFz22v5QQEUHMxnN07OnvvtfSVrksvrgMf4Ykg6jhmMetDTl/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvzVKdBBE9diAjPVp00cKe6HhfCuXUECCqIdwUJShtQ=;
 b=Wj3SN7RY6sBIklTttDY2IxTE/S9cTmGAa0+31amznemBS7VSCGF1bLySUWP0OiIf5ccHjP1ymZI1DI8hywua6gpMHq0WGzdjkPTOtLiJ4xUwk4T6GV1HaXi9+e4JTKo+rpQncReZbwrVaOuEybnpII/cGoUUxLadgSlfatllgtrBem1GoWDpmvRGqgkXOBSUAICGDVCpXSIxhTwbrZSoeWdH4xMo6XtlNOVKHkT1xaTodkAaT3YRp5D8XDmQgJt2Kc7KMG/Y/ezuO6eVNQdSxa0FiTlzsgor7lTX4hT/T3Qvsv4N31AOcci9kajx0Rw+kOsstG0YmMxmYjY5I0J/HA==
Received: from BN6PR22CA0026.namprd22.prod.outlook.com (2603:10b6:404:37::12)
 by BYAPR12MB3480.namprd12.prod.outlook.com (2603:10b6:a03:aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 20:57:08 +0000
Received: from BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::1e) by BN6PR22CA0026.outlook.office365.com
 (2603:10b6:404:37::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Fri, 14 Aug 2020 20:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 BN8NAM12FT042.mail.protection.outlook.com (10.13.182.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Fri, 14 Aug 2020 20:57:07 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 14 Aug 2020 14:57:06 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v4 0/2] Shell func backtracing
Date: Fri, 14 Aug 2020 16:55:55 -0400
Message-ID: <20200814205557.69655-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d2dc706-aaba-445e-658b-08d840949b71
X-MS-TrafficTypeDiagnostic: BYAPR12MB3480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB34801A5BB03F122F5A25F6958B400@BYAPR12MB3480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qbRWKuaB0mfZfyH+i8xCqb+qrw+BDivFfb0zTHSe8z61n0V023vZRR05azrcoJi6DPvHjOQOiLhoTZRnTCJHa0Cs4OJ/7Z9eNNa5mUBYJXNDcTL/TDyHnr0QbmDKg+/LI67SI5R1PXQWww22OHeR0Da3paxuX7TnFs+WOmv+BkAF4vXv/Q04OcYBE/Fu9ZEUS/9SjZ1Ilh/Ry1dnKatQ8t8Cc7j24LTMM1Qkm/FUnZTGPdlPh8jhQ9kjjpjftmURtnYn3LyhI6I2633wJia58x8Ir5+lbG9duNTo3gMLpnhp31NTtzGdl0ONiDNOLtmEMZuo00X+vy1r+oAN0pabQF0J3L4DyxJqNFk9BrPa5H77EWGFP2zjChdZdL/f5gFMRa0a5gcc8oPgzfv2/DAuE3Pa4DVsq38Wf3aInZR2jc8=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(29502001)(46966005)(956004)(336012)(6666004)(2906002)(82740400003)(70206006)(7636003)(4744005)(8676002)(478600001)(356005)(83380400001)(26005)(86362001)(107886003)(82310400002)(47076004)(5660300002)(36756003)(8936002)(1076003)(6916009)(186003)(316002)(44832011)(54906003)(2616005)(36906005)(426003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 20:57:07.7824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2dc706-aaba-445e-658b-08d840949b71
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3480
Content-Type: text/plain

v1: .run script backtrace
v2: add metadata-relative backtracing
v3: fix dash syntax errors; ShellCheck warnings
v4: remove troublesome ERR trap; use DEBUG trap to track command linenos
	so that failing lineno is accurate

Chris Laplante (2):
  build: print a backtrace when a Bash shell function fails
  build: print a backtrace with the original metadata locations of Bash
    shell funcs

 lib/bb/build.py   | 119 +++++++++++++++++++++++++++++++++++++++++-----
 lib/bb/process.py |   3 +-
 2 files changed, 110 insertions(+), 12 deletions(-)

--
2.17.1

