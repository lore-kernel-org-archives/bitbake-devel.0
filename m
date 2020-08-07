Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.61])
 by mx.groups.io with SMTP id smtpd.web11.7167.1596810253151705756
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 07:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=MudIWQAk;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.61, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnvwFKySKDFO6i3sW/78traGCpQtQincMKCuxaGtXhHquE8oWamSPL9CC5AxfJYbjoDyKbffkhFDqkac9J6V0ENjnj4i5qUZKwE+uu2XKBYI/3us5yhCwgqhnSkcuWqP1OPPdpXCqzpGAlnj38/pyG2NXX+i0Jpb92eLv2jwNfVKhvRszWU3ezgurNg//o053cRlL9UNyGDe62ENqTa1HjuB0DOx9xbeMB0hYdbSP7g/d6cxLLCE1UTtkxWnhBht1KDhKBbXXOLokG6Y3NYhmukEyyh9eGGJKZy7/qdbJMG5qgE8vLcNaJIiAtIou1oISuWPm1I7sfs4z2/OGlDmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5Az5ZcElHXeST6W8GZOGZnQ4gEgu2nyTm5lHmXRhwQ=;
 b=nw8FPfk4LlHfaH96aPSvKj2P2QpsLM+XGj1wY0VbuoHfHvm8biiA7f+aHDBFqDZekulHSpPAf9lpG1D6lgpGGHIdpbsmimuG8H8WmhQAZDyuVbJS7EhXypazfcXf9nDQxJNwSKZ5SyX/fjQ1s8M95FolCEdAHiALzZYRxdHUqKKugW4l2OjBjatS6Ev5SSSXKyCFkDwAfbD8X3nO5iakl8ywXvACTQljKGHPBmKR2DspAT+eRN201aBoN+dog+dhESmfy7Gv9UaoX7NgZSQP11fjFA3rFLV5cs/O9sWKIqCWxRXYm1M2QqIPqTntAzMIr98dlDSTx8BUlJMdUzNYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5Az5ZcElHXeST6W8GZOGZnQ4gEgu2nyTm5lHmXRhwQ=;
 b=MudIWQAkVWU0p84N1IQjsNgvQ3ypjAYurNxOc1q/e2+L4siFPOSnxtJYrJtf4wJyWUiHiNAy7cnd3vukYGpiI2jCmWHwxPY+rGsuwGpveWZmINlDsbk2oRXMpuDeHROAe+mS+zhSobF766q9zKt6plNkohGZDoh2Aa2J60zSNHtUpe4NJgHslXBXDEGro/Q4UyHghneMOPznQI7vV5tKkIifh7MM5bCdRRwyTT0n2xL4VbUZBHgJXER9upJMj7n5O6qNzqzUcG7f3qLZOv5c9y+BJ1r5DjFvMGm9ff9mJgMNJpApxl/izMj9onkTB74UQ86o8y8HabSkbl1RwJAuVg==
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Fri, 7 Aug
 2020 14:24:11 +0000
Received: from DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::e8) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Fri, 7 Aug 2020 14:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT029.mail.protection.outlook.com (10.13.178.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 14:24:11 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 7 Aug 2020 08:23:58 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH 0/3] [do not merge] Shell-based func backtracing
Date: Fri, 7 Aug 2020 10:23:40 -0400
Message-ID: <20200807142343.8648-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d16f67ee-242c-4dad-a2cd-08d83add8df4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MN2PR12MB448649B3F882181F14A5AF868B490@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	76+F7Tq8fjz3GGhabFqjafdCFVq+0raI0DFTpaQvqSRfWhbagUSxxAeedcGA2Dtf3MW5jLBM/x8brkTGG/GhPsPngdtAnEGWE7Wrgey50R476oH7cQHSCtDKMoxJtOty6HdIX6yNOwV6F/L7BKJWdPSwf1MMx/UBM8nlKRbDZPUHXAD2H4rdCLzvRLTNC3YySo17uQivRl9amyCum3XI5d+atgKIbvkGfK63HMJt7PKv177oYdKZ0P7i871U3/20AX+HNq31HJYn9PpGitRIoPj+taNG7LiTNJo58rHOBT/u3TOK8xEG4ar76bZuLbvDwhKkHVXofBQwyoMhDFbC7avY5LI9y9yTCK3L16m0vy5SNxRyp1E2eNim3AAjLf2c67D2fwsR8yOxNUJoSkolQJ4Yl+fjV11zo07ptdzUY9Q=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(136003)(346002)(396003)(29502001)(46966005)(5660300002)(36906005)(1076003)(47076004)(44832011)(6666004)(336012)(4326008)(83380400001)(82310400002)(7636003)(356005)(82740400003)(2906002)(107886003)(8676002)(36756003)(2616005)(956004)(86362001)(316002)(54906003)(186003)(478600001)(26005)(426003)(8936002)(6916009)(4744005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 14:24:11.5549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f67ee-242c-4dad-a2cd-08d83add8df4
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
Content-Type: text/plain

Do not merge. For reference only.

This is a completely shell-based WIP implementation of the shell func
backtracing patch series I posted late last week. To be mergeable, I'd
need revise the approach I use. Currently I try to determine where the
failing function is defined and then look at the previous line to find
the comment on which location info is printed. But it doesn't work for
nested shell functions. I will need to change it to use the approach in
the other patch series, i.e. scan backwards from the lineno in the frame
to locate the comment.

Chris Laplante (3):
  data: emit filename/lineno information for shell functions
  build: print the originating filename/lineno of failing Bash shell
    functions
  WIP

 lib/bb/build.py | 55 +++++++++++++++++++++++++++++++++++++++----------
 lib/bb/data.py  |  6 ++++++
 2 files changed, 50 insertions(+), 11 deletions(-)

--
2.17.1

