Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.47])
 by mx.groups.io with SMTP id smtpd.web10.10204.1596378935644943979
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 02 Aug 2020 07:35:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ja7eTGZY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.47, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMp8JFiBDzGgi+n0DoHZ1+GJay3PAH791VBJFsqt33zo2xgnd2N78AlScvNG8/cuo+zOPFFJLLfvCPV2/+EAJaBC9zlQH8UQWk5p0/pI6EdDedaqa2dtrqqjWAAB08L2CWWUQBCDGvWa5oHKXn8eWB/5SU8fNZmIIQ/RmddpUR/eeXbRP8uLxpxuPJmfWMnVyfpGxduRJcg6i4nG7BcCeAmidMS6e3r0HlXq8nxaxehSMPKLOh6R5oUE9i3aJBRLVvNmGjePZeaIiYouc/ypYV6h5kL8J2V2P3f4IW996eKfzj3GictB7x5g/Ukrbg+1gY/AD7lQv0XiHdsxLh/oHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DRSVXY+0tE2SnXZmfEeJclLdeepDtgCcprfMbB+mi0=;
 b=SmTxu0viqTN6TgqVg7dyW+WymLEYM7f4m8sREZ/NHI9GWte97ByjgGjQCbsf6LCiP4EUMLWe5NSZSWDDqflAKkO2012Yxry4GAV4KVizVzeiLQnbr8VMXUTQMWBbhA6TvlJNCUiv5Ik8Ph3tQ2IA9EYpivheYPA/Ad96Nmy+smZ1uwOcSCgfdnL47+Jiam5ObnhvP+5ClsmxCw1gXVNqbGwSGTzjqhrzhhBUxjRZcTkotN5KtZ/GfvApa07ORAyRDOyftdaPii2C7Gihh3DMBqLZHcUuLHCmz3UPkn1oTwNg4lWozH59nEnmj1Sm1EBRjxOS5eQc67bH0tgXBiqLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DRSVXY+0tE2SnXZmfEeJclLdeepDtgCcprfMbB+mi0=;
 b=ja7eTGZYVmIVjBGFTzn5YT76Kamo9bPvirLNJ+KkBvjd7WHIu4w5+IBeQNza9hsSx/wc+slNv17aisAudR/d5JMLBzrcwhtbxv/FQNa1V4uoNAC9PitnrHpO2M+lZw4qU8RAvtLU+Z3C9PVjlf4zDW1AeXMuX20gVlAhbgQ6KxzHvKehrn8wWYFKt3A3oYOT6Asi3SUOlpSgcI02YzMAl1JJRuPp/SOPn7o/qp/SpfydMbS7e41p3vJJgMkJmjuo0ZysollwPx+vbW8Q8rxunIWvnvB5UP1kTY2YQA/EuI/HhSuEAH4ixgTjsh1UPHKjwMPxc5uQtLzYulXdy0sdzw==
Received: from CO2PR04CA0162.namprd04.prod.outlook.com (2603:10b6:104:4::16)
 by BN6PR12MB1682.namprd12.prod.outlook.com (2603:10b6:405:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Sun, 2 Aug
 2020 14:35:32 +0000
Received: from MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::2) by CO2PR04CA0162.outlook.office365.com
 (2603:10b6:104:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Sun, 2 Aug 2020 14:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT021.mail.protection.outlook.com (10.13.180.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Sun, 2 Aug 2020 14:35:32 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Sun, 2 Aug 2020 08:35:31 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 0/4] [RFC] Shell func backtracing
Date: Sun, 2 Aug 2020 10:35:01 -0400
Message-ID: <20200802143505.88409-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7781c7b2-c685-48c1-e0ba-08d836f14fb5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN6PR12MB1682AD47E59862531452C4EA8B4C0@BN6PR12MB1682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zlyR8BHKEjKGPDzSIq208An7CXFAX5irCmtLLrzDQafeO+XFV+hUNIaMCx8B8YrRp1ihfiuc7d98/iCpqAy60kG+ud6Q8ut21knm1pOqg8GHXJhP3PxyIn6yu/4pdVor8IbLgsff++2rm5NAjatg/R/F8OyiETa6HCOFLU6bRtAl6tdV5JFUaS8pGQ4Qpl0vyfsCAJcESIYliGHK+T6zSVMCAq8eHBWpvSSXXtdXwxkj5rLZvca2AiW2iz+WsCwUCO8LKaUk8YqYPynTVZimdW+9J/Yi+zr2huQE+9GI/Ub1xium+R0dTawE4jeLlJuX4zZ2SlwSa9FDAi6LMsWJ2N9/f3FnH55Lkh57TicrJGQ0kC8/l5b0aZ9aCqPouXLDHM/hLGsOIbIf3yIbVHRvF84bd5SPqfYi7Z5sUA5wOcY=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(346002)(39860400002)(29502001)(46966005)(6666004)(82740400003)(356005)(82310400002)(8676002)(86362001)(7636003)(186003)(2906002)(478600001)(4326008)(316002)(70206006)(47076004)(83380400001)(1076003)(44832011)(426003)(107886003)(336012)(8936002)(6916009)(26005)(36906005)(36756003)(2616005)(956004)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 14:35:32.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7781c7b2-c685-48c1-e0ba-08d836f14fb5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1682
Content-Type: text/plain

This patch series replaces the one I sent Friday. It implements two
backtraces when a Bash shell function fails:

1) A backtrace within the .run file that BB generated.
2) A computed backtrace of the actual metadata locations (e.g. bb or
    bbclass) where each shell function is defined.

At one point I had both backtraces implemented entirely in the shell
traps. I moved (2) to build.py because it is easier to implement in
Python. One nice thing about leaving it in the shell trap would be that
it would still work even if a user was running a .run script directly,
but it seems like not many people do that. Still, if it's something
we're interested in, know that it's possible.

P.S. Sorry for all the v2, v3's I've been sending.

Chris Laplante (4):
  data: emit filename/lineno information for shell functions
  build: print a backtrace when a Bash shell function fails
  build: print a backtrace with the original metadata locations of Bash
    shell funcs
  build: add back the Bash EXIT trap to handle cases that ERR doesn't

 lib/bb/build.py   | 116 +++++++++++++++++++++++++++++++++++++++++-----
 lib/bb/data.py    |   6 +++
 lib/bb/process.py |   3 +-
 3 files changed, 113 insertions(+), 12 deletions(-)

--
2.17.1

