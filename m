Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5731C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:25 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3437.1787861237694677019
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=XO9Cj97+;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.201.57, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLlom7yOB2TymoK3M4kCGNbQdqpbjGp6HaO9YR7AyPVCePHKXGvpG9ktYboTkdU7YVfb17GFOg9vfryvsCOP9C5tQiCLXsOrsqxcCF7ZTGNnMgHBg7OHda+wVUdib3xmtPMoKqL5OnBjkWeVThpdChiDHp5OrxJ6WFqWjoulsYPlDDRzZ80fqDy4/fYAYZ061TqZkDQDE4hp2xV/fviKsaCRperfz1sxxuh1GWM+Q8wIwrz253RE4wwt/6+QAYUbz3ZXQMZvzmFDTeGYip02Y0MIqjONSd2Jc5JGZOww4SRdJaFqJfWjaI05eDilS6kLmJjh9ixROX2jA7Y7AHUDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9CS6QjEjI2WOO8fAyMrXe99VM/+GndPZ6RNEwDqtVI=;
 b=rhfTYHgPJ4UjUbAm/sSrMrqI7gfZgFWOpSeB3VhhP77LuRaIz27c4Gd5v3YtP4PIGkPiGrXnupQ+eS4G6+okou+5aghHKTPJAcQGFliyZPmYGRCbyVwK52Dbrks2snUIEnKETXlpNX6o2Io11/uNw9Fg4+rZKB/Qfwsvu55eNcbti4Kd+zajuNvj/ntvDkU7ek6KgcnEK7bmr/1SLHFALugJ8Jep89ZmvI9Aht3Wm48XhoScH+y9WszE1g3Plm8r2QIz1tHLkjISuXxcPTJhp+PtX53RpRk1XXd2FgWUHa2qvY59863LmzMfq+QN/zlW+htY1RcOAM/HDV0BPUpdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9CS6QjEjI2WOO8fAyMrXe99VM/+GndPZ6RNEwDqtVI=;
 b=XO9Cj97+CiHmCsMX48z63bTKttwhed7A7w1iV7dTKgjUDL9V/VqBcdDT7bNXM8RAnyoI0T/ioSsUe89+RJmHmZtjp6AdRbeV2luHMQ8dyAA37dOh6FjjpVusAFHvsBoiQXUA8g1ywNsd7iHnrAJky+EbzEbM41gkhxaHCCFlQebRFtbQwj8rc6jdrU0bxaco2iFli9jPcD+VXMNNV0TnjVzY1d1fMA5GqWAgVumyAY800HaPowuV6gRbSxQwB1qCj4t21sMztb/9Ug2jy/P+8nBH917SI6ApjyJ2Dvbh9HMuIwt6wZw8OcM2/VCoJx/G6fVwIE97cQ3KZ4Nm+gz7VQ==
Received: from CH5PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:1ed::24)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 20:07:10 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::58) by CH5PR02CA0023.outlook.office365.com
 (2603:10b6:610:1ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:08 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:06:59 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 00/11] runqueue correctness fixes, optimizations, and cleanups
Date: Thu, 27 Aug 2026 16:05:52 -0400
Message-ID: <20260827200603.688796-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1f3059-af01-4dc2-8661-08df0476c667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	PvMf3vF1pBK8eEFdEdbI4VjEJxXABWH4Eb/mjHl4sduxGzbrKXIle+BsNQ1w6SAOtdzUYj/tTpkHc2LB/yKriGygeh5XK487xsTK9tCTIsEIp2+9VpzLSbAdyeVRvminJWN3/ugBUybaQljYyse0TsF1llRG+acXZZgHp4LR06idbNw3e2DYYSQiEqJfoivKRKfXkIk1y74JsH/l0WFqdWXBbsy57qYwPwwfHSbTFCLOurnpNHNukJoyeLC+KIRJV+tr1LAUpdwo6OkzS+xGdwTgJKjfHc5JmybQ8tiiO5HVU2AqXr4Es0lxwjGmIMdNHPeh/K/1IFezpSDkQdGEERuDr8go9Yz3dpHfMEhnps6Ez6Tqa4wTwBJNStTP2efDPAS+ZM9iUuVB8VYzsUJl8niZrAOqJQxA18gPejUGaBUQTplhXY/ziktUvNq4i3cG9yB7Tute9ylp1mTlNt9RYGODHha6D0c0zh2xLL1JbDN02f/xGo4XyxNEdSPwu6yoAWfNNqoIs2+RIjMoJaBk+tCDdR6DsK8ibWOpvf/34JLElkhbse6WofVqKGitX3A9PyIj9AeJH4HfuTIpVe5WLQ6F/bk55Gv8L8GgC/nmb+lREDXEfxWH9UrWVgSVs5Z96UNR63N/+2Yue9/GktMpeXic6HbGzStyBv+iT44CAjaimha+IUic1I2thisUTXg+yxsz7A1UMseDY3acnoQVuA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	UriY2/xpt5Agwi29E8xKm//jXVC599h2yl152jDvHG0rqMRZXYkR36plS13k6H+GTdx09C6obzXYApC51kprswYaruT5F5G4DDbf69xxS3kgNych+7cr0WxBMNzk3OXt34QUN4FwXQUQfjzXdQejAKzWZ07rjrEJVP0F0w53wk60iuvj8vEbffBZnzEVIFSbKJodN7/6lGXNiliZNV8kusZEezMvYtrb7aQy/Ub+RbOmD606iZlfV7Kkimx480lWdHHcK0ABfvWPniCI5dx71mQ9q9vv7XL4MKsJvCiyGOoJKDAArAZBy5d6OgCR5J6yo2fEuw/bYFNyrsLpScI39feyo0QW0c786BVZYdsntXyiuc/GT/VvgMn8vvZkZ/rAz1danIBv/eXJEwHbHvjtXS4fn/SEiYrNFum97PZbyUV0hNTPpsk6ywEehVdsuFnE
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:08.9867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1f3059-af01-4dc2-8661-08df0476c667
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20075

From: Chris Laplante <chris.laplante@agilent.com>

Sorry in advance for the patchbomb, but there were lots of things I wanted =
to
fix/cleanup, while I attempt to absorb a bit of how runqueue works.

I think the most interesting fix is patch 9/11
("runqueue: wait for covered tasks before setscene").

Chris Laplante (11):
  runqueue: remove unused attributes/variables
  runqueue: remove unused RunQueueExecute.sorted_setscene_tids; declare
    setscene_tids_generator in __init__
  runqueue: remove long-unused RunQueueData
    get_user_idstring/get_short_user_idstring
  runqueue: cleanup imports
  runqueue: remove RunQueueExecute.build_stamps2 which is never read
  runqueue: optimize construction of rev_prio_map
  runqueue: declare pressure/load attributes in
    RunQueueScheduler.__init__ rather than dynamically
  runqueue: fix remaining attributes created outside of constructor
  runqueue: wait for covered tasks before setscene
  runqueue: clean up dumpsigs polling
  runqueue: report memory pressure limit correctly

 lib/bb/runqueue.py | 110 ++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

--
2.43.0


