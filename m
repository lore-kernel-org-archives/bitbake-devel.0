Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.66])
 by mx.groups.io with SMTP id smtpd.web10.49460.1597078549506380667
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2020 09:55:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=xYaJXZOf;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.101.66, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFcjfL9gSIc4YkMG5eb4FePj6TaXqzAb5RtAfrfgYt1kqN8gRLEMotw+unnwDe/787QJl3lhed6xnAp/pirsGa/NQCe/iBjoK5y+LkMMhPDiQb2atJNnmeMxrm2YkJ8aJoR8VrXNcF7LdoOV0n5xYkFsmvbuom4cXkfKknEY2Gu/YjubYUnG9Fr/n0ELWgBoVxgiWnPYiSTscntxVLgDz09K6DLz3xxIOgNGckdQhJaeXk5WrIDGVhNZxCCBeJTVArsHNg7Kkp+XCr2Gmi5jtnln4DbX0T/aEgRiiLIocpSHVm1tnWf1z/x/hU3k0/6ZD2aENeAqvV4kiiDD68APIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu3I+LjtWy8Sl2leAZP+NNohbtzKKsapc7EHT2KQmuU=;
 b=dVFiE8W3WwI6ScELk0FZNOIe2A2I/KrEEVvyQhVirQHLF+trmVdEPNlkG0oe1ezkEzW0XJ6CPj+VX+ZRndQWLlCbgcmDJaxj9fokHlIwBA3XDf3OCHT+HmxXranIBofP8J0aWOxjxdJjIz1V7d+q10WgFY3XoAk7dMLGSw6i/35KMbUw5J2v7YGXQQOnxCZgJBjhaBEGKyqXyVZZvvH0xiTeuJP210jEaMgr0SxEGiYR7dFyh+si48DaOw789kMUx4Kg5PuBSReE8uIzsTFczHZizUonlecCeGQL71BVobBO84bNltIQj8RcbVlrGQuu8BB1E8UX+ymPXlvRTzEPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu3I+LjtWy8Sl2leAZP+NNohbtzKKsapc7EHT2KQmuU=;
 b=xYaJXZOfal0puRBS86sezBqToA4UU2n0iy6ZQPiGTvj8KZWc4XhSjcankY5WpPHpW1qSCHMM6laJsTaZoqx2fpFSwK0seQYjZqz9BiQGGdQaUgDxSoM76Jwy0nvYYBqrlAVhH1sOPy97/BwQnwRpAMX95NfvHxuyBHIchB1vvEhOfSFbNjJApY3g8CN6moqYelB1XIWElojkO4zLfrfM/FAyGJeD64iC91onltbezosqvY9ufg2sGpVU2iOz3bbeJhVaCbMinzk1vLKS4JWP3nyOw2tKYF5HnwsErWUXX1PsDukEC/DS5R+Vq0zbl2u/xZhsVoRGJSSmWku/5DYD7A==
Received: from DM5PR15CA0053.namprd15.prod.outlook.com (2603:10b6:3:ae::15) by
 BN7PR12MB2643.namprd12.prod.outlook.com (2603:10b6:408:29::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Mon, 10 Aug 2020 16:55:46 +0000
Received: from DM6NAM12FT005.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::bf) by DM5PR15CA0053.outlook.office365.com
 (2603:10b6:3:ae::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Mon, 10 Aug 2020 16:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT005.mail.protection.outlook.com (10.13.178.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.11 via Frontend Transport; Mon, 10 Aug 2020 16:55:45 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Mon, 10 Aug 2020 10:55:44 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v3 0/4] [RFC] Shell func backtracing
Date: Mon, 10 Aug 2020 12:55:20 -0400
Message-ID: <20200810165524.37417-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e0bf86a-ac4e-4911-7476-08d83d4e39d4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN7PR12MB26438E44FAE52F3CC023D19A8B440@BN7PR12MB2643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fcHxOMMv3IrZovrpHDE9N/xrZRjGSTQ6y3vUFrM6C5KcaLGk3SWeDRrnx2/MpcCAM5oxIwEMrfebCCmiUigg9ehhAe+5aDo5WGd7q3vE/0PkPlCT9eBkJDGQP0MhKhUqbKeOhiEZe3983cXftjZWBm1aeCoxP9bX1pJK0j81BZhwYsP2acuLXQaftSfSR+cJiDl4F7+jbcTuLvCM5zy75HLvh9OPeJNonhgwQcL6NcSoV6d4GFGKrd2mS7xtYd2R+lNwR2ovT56Mvfq7zLtuh2QVZjZISEyHEh1a01MKPu8VuwRIYg0IA5feg4sP4/Y6dWpjY39F1GGhfNe0E9aS1fAhd5wogQGIPSm+6FzFjVXlo0rvFBJHIU41efAZRpMQNkdhZ/VUCCQ86k8sSY45kR1ku9UVYdM0gV+C2KzG7Z0=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(29502001)(46966005)(4744005)(83380400001)(6666004)(2906002)(82740400003)(107886003)(426003)(186003)(7636003)(1076003)(54906003)(956004)(8936002)(478600001)(356005)(4326008)(2616005)(8676002)(47076004)(36906005)(70206006)(6916009)(86362001)(5660300002)(44832011)(82310400002)(36756003)(26005)(336012)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 16:55:45.8764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0bf86a-ac4e-4911-7476-08d83d4e39d4
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT005.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2643
Content-Type: text/plain

v1: .run script backtrace
v2: add metadata-relative backtracing
v3: fix dash syntax errors; ShellCheck warnings

This patch series lacks commit 9747211c (data: emit filename/lineno
information for shell functions) since it has already been pushed
to master.

Chris Laplante (4):
  build: print a backtrace when a Bash shell function fails
  build: print a backtrace with the original metadata locations of Bash
    shell funcs
  build: add back the Bash EXIT trap to handle cases that ERR doesn't
  build: fix shell trap syntax errors in dash; ShellCheck warnings

 lib/bb/build.py   | 116 +++++++++++++++++++++++++++++++++++++++++-----
 lib/bb/process.py |   3 +-
 2 files changed, 107 insertions(+), 12 deletions(-)

--
2.17.1

