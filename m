Return-Path: <ragesh.nair@duagon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD9DCDB474
	for <webhook@archiver.kernel.org>; Sat, 21 Oct 2023 01:11:13 +0000 (UTC)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (CHE01-GV0-obe.outbound.protection.outlook.com [40.107.23.123])
 by mx.groups.io with SMTP id smtpd.web11.70294.1697850671504190264
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Oct 2023 18:11:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@duagon.com header.s=selector1 header.b=Uu3AQSXP;
 dkim=pass header.i=@duagon.com header.s=selector1 header.b=Uu3AQSXP;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@duagon.com header.s=selector1 header.b=LySmd+yZ;
 spf=pass (domain: duagon.com, ip: 40.107.23.123, mailfrom: ragesh.nair@duagon.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj6z/tIQIB7kI0vc0le0QzWu/6/nBF0g2Sr+Fn6KWUM=;
 b=Uu3AQSXPztz57e6mYLvC82pghGB0afGuKxqNLboB/1WHVVn6XMQ/vCmPOW27jC5AwG5yOGmo33xsgIm3Phpzrm8LGIhLTm1KpoICRzfnvEt49eLomxGXRIiEPtmvBgpBRoxp3guavMuWCrly0v6Hdo4NCPseM5AoLNmH8+9PcTc=
Received: from AS4P190CA0042.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::19)
 by ZR0P278MB0790.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 01:11:06 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::31) by AS4P190CA0042.outlook.office365.com
 (2603:10a6:20b:5d1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Sat, 21 Oct 2023 01:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Sat, 21 Oct 2023 01:11:05 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4SC3LJ580pzxpC
	for <bitbake-devel@lists.openembedded.org>; Sat, 21 Oct 2023 03:11:04 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS
	for <bitbake-devel@lists.openembedded.org>; Sat, 21 Oct 2023 03:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj6z/tIQIB7kI0vc0le0QzWu/6/nBF0g2Sr+Fn6KWUM=;
 b=Uu3AQSXPztz57e6mYLvC82pghGB0afGuKxqNLboB/1WHVVn6XMQ/vCmPOW27jC5AwG5yOGmo33xsgIm3Phpzrm8LGIhLTm1KpoICRzfnvEt49eLomxGXRIiEPtmvBgpBRoxp3guavMuWCrly0v6Hdo4NCPseM5AoLNmH8+9PcTc=
Received: from AS9PR06CA0413.eurprd06.prod.outlook.com (2603:10a6:20b:461::22)
 by ZR0P278MB1153.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Sat, 21 Oct
 2023 01:11:01 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::ee) by AS9PR06CA0413.outlook.office365.com
 (2603:10a6:20b:461::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Sat, 21 Oct 2023 01:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=fail (signature did not verify)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Sat, 21 Oct 2023 01:11:00 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sat, 21 Oct 2023 01:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNYwluue8R8jXbgSNhygy+hhAZiWvYB8CUdKqE+DvScD6smtYNv/nzD54iztYjPEzSRE/cs1hEF1IZjGJCpFWLl+rGI0KeY0LveKf05eyoJVWAfpp1n0pyQH3lfKk+3+oHejEVQO2vKzTx38tP4NEi17PEmofVcEZ5S5tVKh36eSBk2JKvC4N5Xd0ocn81BzExJM2ER74YzCZTfqXOO0aeH/NNVwXKxRoyJAsMAv5x6hmdlrH47GU+UzAwsoq/UIN8tkl3BQo9LPNs4WNzQc5wwyWCQlmi0xIfizvS+6XrT0VgdOiBIUoGMAwOwVX9t1yMdhcTIjiPAuVahK4eDwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj6z/tIQIB7kI0vc0le0QzWu/6/nBF0g2Sr+Fn6KWUM=;
 b=gUmb8sY6cFldQGMwHqnaaEy1zYIraUF9ViHGP5hdFNILmXLIDEYPJlqfcEbQXuEGMPdDTuU8WpajQQJk7HFxBOhYZ7uRzca/k5Wtxjjt9vojYKZkYBIcY7ddnT7/zOHdgubm2YnIJKU5LKauev/YpSLQn3rgZuv5GN1S1VSMmCHRd76pyKkk0C2vPLP6X8SisRXUKdcFsRg5F1s2Efbk80+T7Trv78mUoCrrXuX25o76aaOfwMupgVEhvhr/36a8IdR/FYOMVXALEuMhN4EisxzKXcatLZ45j9cEl7ZC5y5fQMra1UuO4Oc3YTVkJcet3iE8+yXz8N84y2h51sZfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj6z/tIQIB7kI0vc0le0QzWu/6/nBF0g2Sr+Fn6KWUM=;
 b=LySmd+yZDzk1I+C5nXgquufGyw2uyKfiRwS13zHQnz0QW7MIaQugoJArRWHYC7zTOqd4VogiuEVxyoDrzgy0csAA99FUm2/NgP/4opz8J+LaRlH022Q7nwB9gAJqL0mSrf7+HjgrMtGtwj7s445+Lnj6FbrUd9nP0pdHhxQVeBQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:31::7) by
 GV0P278MB0951.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Sat, 21 Oct 2023 01:10:52 +0000
Received: from ZR0P278MB0218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80f1:e5bc:edec:d4de]) by ZR0P278MB0218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80f1:e5bc:edec:d4de%6]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 01:10:52 +0000
Date: Sat, 21 Oct 2023 03:10:49 +0200
From: Ragesh Nair <ragesh.nair@duagon.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: fix lfs fetch with destsuffix param
Message-ID: <55f2587-4a5a-d635-7f1-f02ec6a5bebb@duagon.com>
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: AS4P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::18) To ZR0P278MB0218.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:31::7)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: 
	ZR0P278MB0218:EE_|GV0P278MB0951:EE_|AMS0EPF00000195:EE_|ZR0P278MB1153:EE_|AM4PEPF00027A65:EE_|ZR0P278MB0790:EE_
X-MS-Office365-Filtering-Correlation-Id: 900f515e-a33b-4397-6eae-08dbd1d299b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 DTRRuurWlmkHi3+w6jeqR3iciOre2UdxCOINiOqV3be+foVklaNbjX54ogzvzqM6PyjEpEwydv1djeX7qsT/TD4sGKjeIJT8ZvpIpAO3Lofw7EGKbFvI4bRpfylMaiv882NSmjFOuPvVjOMCqQpTOi+cp7c6ZtNfvQSDuwtei9C9oPP8FYcgBAiJQZSSFruqWjBadGEMHxSElrhifAkvn0WXTjPPw44ooY4RhkkzbyhxtZ0lN2ZhJGlsxCS61aD5LHDuEJzi7QSH9usXMPEI+DnXXxiNf4kIKU+NBz//RnSfdz/SlLMU49zpoyNmXxHocldtoeVP2DOsSrGu5+LBWFo2+VnzmFpWlW6KlV02JImd8wKzRnIO4r6MBfq/R6nRSo3s2joBKV3ww0p01yUJKZIV0rAnSnAvI/3vLVeEZvVaxcHnjKVvvMVR/HAjXsRNxBroMEyyKWy15rDNzqquoL9ty+DHTr9litHSP/YHCrcbT3VfWpEIZrPfTWDSxM+xwTzq+ndJCTjawpvydye/1+5YWNqHVrPnt5pTesZO7fYB2zswPw/yi2g4dbzNVGok
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0218.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(86362001)(2906002)(5660300002)(38100700002)(6506007)(6486002)(83380400001)(8676002)(8936002)(36756003)(41300700001)(44832011)(6916009)(316002)(66946007)(66556008)(66476007)(2616005)(6512007)(26005)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0951
X-CodeTwo-MessageID: 216b3b55-687c-40bb-be4c-74e015f61773.20231021011059@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
 919c8cdf-372f-4826-3cad-08dbd1d291ba
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 3o+hINL3bNNmDfRVXEuy7CfTwMVOkLcxnIHK2VkSnBe0PauE8SiCPXA1LH551YxCNl1MZjA74lMhoQ6li5r0y3dwiEpRyPCHx7AnKTnK784kt8g9EfU5miKUQ3kMnjy+S2mRwLVfrI+/w6MyMpSLvtJDCMwbMw7Zcbv7U/5amnDKs064anoPTai7Lo/ZiwQevfpOhtAGhvwSbXgjA0nx7D/b0d5fjgtqVU6m+2bigR2K7fvyT4QM8lZql4iaXElS2kLxOXwF/++wuosFqq+dx09zFHWpMaocZpi0lkaoo7NsIHur5LoB4KACtG/qgQIE+JqO3qe4cxk5iHnOpguPQbaOAWlxGty1KdCrFgavmq6cBxBv0XR1Qmzwb+R/gdwX8rA8GqpuCgLqkVXNx8EiTF3UbH59ZmQTW//BjSOQoA5sZiQurx1EXeRPYf6QFewBzY9qrjCLMSnyEHDi33WIRPkGZqCmMRnB0UBlHu+qm1mmWSLC8RQerx2hOZPb64giHvdau3j7zwsTVqmGOnbyvgcn3+vUxpqRVx1Kz0DCQYvcE7LPwr2lD73q8fMpM0VrmlFpOkjLGXb0VPfp3kbt0MuzWwSRwDhJKVHaQbTRhmiKHhawQYXZmb3Dlc6EUQ+Q0V3mJM6I2kFAH28ysjHZGn6VtZYINiSz1z2kEfAe5hdwNzFU5p0yURzsVPU7iAUYYukAacucBbyIyLW3hh4IBw==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(6512007)(26005)(6666004)(2616005)(6506007)(6486002)(47076005)(336012)(83380400001)(478600001)(2906002)(70206006)(5660300002)(44832011)(41300700001)(70586007)(8676002)(8936002)(316002)(6916009)(86362001)(7596003)(7636003)(82740400003)(356005)(36860700001)(36756003)(40480700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1153
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	ee1c9c33-556d-4660-c73c-08dbd1d296c5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JSK1rHT64ds3Bpven6vlm9EZV3++416YkvZDpfWaF/qWIohDwp4moVFDxR9GRPEoIqsPn9vH1yLgGtWk4G8gzg9BWKGhXLmwpmksiCo1o31Zr48T+yj93XjFoPe8TgwsDy6P9Q7FpsnU4IPEW9cDPnuTc1XBAByGHBwppLp9RlzqB+trt0yg7EIzVDouwFu4Uvqb76h5RL5rikpweH1lg71hklrVYR5L28m3rdezf9UAL+PH3H7wRbDspjr2gzcVrtrLM/Hwd23k5XbdczjTMe1NFbu5ypa0TbqeYxXFYuKpwig/87U6PIan5Jw9h72sV/zxTi8qJZekolEybSY+wDusP8WFXRKdYxk6jR2UwLiK5fR3CTb3LwT3oqIkkl9FdzQPFjZkRjIrxZl7RvrFo+hEt8TJELjKUPwL2NgLkSqoBbtX3nJdPdva3PwSpGUgPBNv4D5xHs9pql1WiU4iNig3J4QDDL6PVi3w0vALTQuXUPoqfh5A/BLOT2C8d8AWzZ3qYGLbRWyS6m/5IODsFS5zQyEr2nx4VvWT1nIriEsuNuRNu+2UuIjJmr1zxcbTrLSB2k3g+1h/R7I8UcU12DdWWCkdPTsDxtax3z5dZ+flDJT5aRvWhaUXjEMO0Iwtnx56HPjskhC1YX7wI0kS3OB9NP5pPmr0MGOJS/KHDGv3hTE1EKknazN3yNTeUXkPJ65Diyq5SsnXxGwa1u/6LE4zPOwxrCa4Uc2O0Kl6edlh6os8aeH021XG3GeuIjgw
X-Forefront-Antispam-Report: 
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39850400004)(376002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(36840700001)(46966006)(47076005)(2906002)(336012)(36860700001)(5660300002)(83380400001)(8676002)(44832011)(41300700001)(8936002)(6506007)(26005)(6512007)(2616005)(6666004)(40480700001)(86362001)(36756003)(6916009)(70206006)(70586007)(478600001)(82740400003)(6486002)(316002)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 01:11:05.2033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f515e-a33b-4397-6eae-08dbd1d299b2
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0790
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Oct 2023 01:11:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15273

Pre-fetching of LFS blobs now also works if a destsuffix parameter is
supplied.

This also fixes issues with Yocto Kirkstone (and newer) builds, where
fetching the LFS blobs is retried unsuccessfully during do_unpack, as
network access is blocked for any task other than do_fetch.

Signed-off-by: Ragesh Nair <ragesh.nair@duagon.com>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c7ed1f03..27a0d051 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -462,8 +462,8 @@ class Git(FetchMethod):
                 # Only do this if the unpack resulted in a .git/lfs directory being
                 # created; this only happens if at least one blob needed to be
                 # downloaded.
-                if os.path.exists(os.path.join(tmpdir, "git", ".git", "lfs")):
-                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/git/.git" % tmpdir)
+                if os.path.exists(os.path.join(ud.destdir, ".git", "lfs")):
+                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/.git" % ud.destdir)
 
     def build_mirror_data(self, ud, d):
 
-- 
2.34.1


