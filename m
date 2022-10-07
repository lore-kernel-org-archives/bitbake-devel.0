Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B77C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:01:54 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.84])
 by mx.groups.io with SMTP id smtpd.web08.3024.1665140508149749565
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Oct 2022 04:01:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com
 header.s=selector2-armh-onmicrosoft-com header.b=3O+M0e+f;
 spf=pass (domain: arm.com, ip: 40.107.6.84, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=OkRvFCKySUomyv/svF9+d6O3/uqs3L+MoZYg8GmniZbG28vhp8dlI3TMxEDLcvqSxvnCJkQ1d1IeFiiChLgfbxCTcMmqp8awYkIrQDe4iG7jaYfy6O5a5zpzc81jLjL4EQE7dNp55hsZ8oHNqp+D4aequBLZqKz/xskUOC4XY5bTQUzpWE7KVkg0utcdbB4RbzqSGY1KMyjimhvTf9XyGLPmwY6q5lYrA/Vokh4RhlKjqkjT0FZOdpNQLJPAknGcGpztGGCL8Bd0cK6oRxaI64kqLtxVOe0ZO34FwTm5tKYmWPzH306KGrTplAjIKYcUdoMcoIDPZv1xSEhtUnvthg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF/UdDWtqNaS8UzSmkOm0w3Przl4UWLX3G/oGb2FPEA=;
 b=ALIC5YjgDsk6FjOwmo47+xaiylZSuQxKhmUI7zMsJeku9yStRVgxl81ghli8HOepGm/llmWZVtlhFTSMsb7xHudurjWpAzadw4IgjWaTvG8wIAdTv3ZKsPubyQeLdozj5yX0EJQCVo3IYmdHm23h8UIzGF9GLghEvemjWqlEumBoVh+IHZS7X7rxOYuaD3rVpxy9++DprIA6oHggNMBDwfXPT5wMuMXRwycexzPCfVg76KPbyYTAo1vmk85Urk1Sy+PVZD6cCzwmctxLPChJuRKkD0VmnnptyNQhnRqPiIqGdgnLfl0QWqGsqOXMAwqCpIpcEyxQ4xdHI3Obi4hGaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF/UdDWtqNaS8UzSmkOm0w3Przl4UWLX3G/oGb2FPEA=;
 b=3O+M0e+fJj1UgTogLgKJim4e2DFaO61sZEOgopuWdn4W7qw1fDekbV4ZJkRPOF0j9HAG7lcVjvjW3w81+ueaOINHwa1vXGzGf0yvLBHRWaaowhFlrkU/Ks1h04TNqaNeGU2HHLWGQpUnG8Ttb9YzqN5zwal4FgjXzXZPoZAU3Jg=
Received: from AM6P191CA0069.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::46)
 by AS4PR08MB7712.eurprd08.prod.outlook.com (2603:10a6:20b:513::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 11:01:44 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::fc) by AM6P191CA0069.outlook.office365.com
 (2603:10a6:209:7f::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38 via Frontend
 Transport; Fri, 7 Oct 2022 11:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 11:01:43 +0000
Received: ("Tessian outbound ce981123c49d:v128");
 Fri, 07 Oct 2022 11:01:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d52e23eb20c0ca1c
X-CR-MTA-TID: 64aa7808
Received: from 4d104d414a15.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 17E812E3-4D6D-40A4-9DFD-619AFB8005AA.1;
	Fri, 07 Oct 2022 11:01:35 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 4d104d414a15.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 07 Oct 2022 11:01:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7HGfw2pzmKMxDADnmgwGhkIrt/Qhtq5VmXZpmoFU8261TeKKek9SBgg520Wtr9TabgLM6FnR8DB0MXxj9qTKFUhT8y+2o5OsAKI7TzI/uDUa1e11uDc/PKUvosQarAuMvJMduX4inpcfHkkCFFrGvOx1HtFuGOwtS2WzXLxtSEqKrolKPdud/rxZsdv2NUOVGB5ZpX0oOsXuboVCowbWN6wDekxjb3kpGMupGMsAyeAWOs17Oa5BMxpFQcYBiKvuSKLS9k/bYuGL9Of8xJKDcjKwEHgo087sZS5OsAH4NbwRcLOMIP5c6tS1b04Ihtwg0gxJOIc9ADcSZzohk0XFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF/UdDWtqNaS8UzSmkOm0w3Przl4UWLX3G/oGb2FPEA=;
 b=S4FQbaP0auu/xURrrqc/6Yu1tLhVD2pQybc//DPX4W1p7pKaGcxF/+Wg04qjax4pjhoau3SNDRBqgbvjQwhKgbDijP+Xt2aJ86mErvJYqgkKs/VuFzgQGULOlw3WHlBGlOPihjJ7vPELjVq/ZWpQF8PBqr9QtLRTkiep076ILddOm4HmOHtyqPzwgKq/LKg+bWQKfX9vVlv1jVuYEsMDZr87oXWiqAUU4yhwSivQplsQ0dWklMDs8URUztxOmxYxTGT39aIw42F7fzTL/BMyfZTrCghBaI43seUu7qL4GGcTvRnOqqJxsUggLVEL98iN8FcvQJKTyMfU7DO25q25XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF/UdDWtqNaS8UzSmkOm0w3Przl4UWLX3G/oGb2FPEA=;
 b=3O+M0e+fJj1UgTogLgKJim4e2DFaO61sZEOgopuWdn4W7qw1fDekbV4ZJkRPOF0j9HAG7lcVjvjW3w81+ueaOINHwa1vXGzGf0yvLBHRWaaowhFlrkU/Ks1h04TNqaNeGU2HHLWGQpUnG8Ttb9YzqN5zwal4FgjXzXZPoZAU3Jg=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AM8PR08MB6484.eurprd08.prod.outlook.com (2603:10a6:20b:357::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 11:01:33 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7d2b:2570:9a99:a3d2]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7d2b:2570:9a99:a3d2%5]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 11:01:33 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "mark.hatle@kernel.crashing.org" <mark.hatle@kernel.crashing.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][kirkstone,langdale,master][PATCH] utils/ply:
 Update md5 to better report errors with hashlib
Thread-Topic: [bitbake-devel][kirkstone,langdale,master][PATCH] utils/ply:
 Update md5 to better report errors with hashlib
Thread-Index: AQHY2c4XVg22r/5uyESYmERo79tWOK4CxLaA
Date: Fri, 7 Oct 2022 11:01:33 +0000
Message-ID: <344ED4DF-457F-45AA-8415-373D00543E00@arm.com>
References: <1665093202-28238-1-git-send-email-mark.hatle@kernel.crashing.org>
In-Reply-To: 
 <1665093202-28238-1-git-send-email-mark.hatle@kernel.crashing.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AM8PR08MB6484:EE_|VE1EUR03FT060:EE_|AS4PR08MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d59823-294e-41a5-99da-08daa85351d3
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 xOIqhrauH4EBtw3HlAXFi2Ux/aZeooKF47v6cJKIxVbmoDeTUzscbT4u1hZ+lI3wLCTbgkYN15512agnu7ly5/rN/RDErOnBBDT9dEF2pDTtjbAt7TDHSng2Tnbu4RB+ZLNEwl+vC2YOmtpXf4tIeMtbVMq7TEgWIeAejjxPt7fhI5fIklnf0vflEH3qCvd7b1NrOy78v0afIQTkHW5/3mBi5ztKmXVkAbHBXxm1/YcXfkPXGHFhXL3QnwUwofpbsqmwt3cpGc+myHAwjgE/OmuJM6yeZZl/D3XYWHLoFzllduka2OUPXvy+DVakkKG0qNtFhk2fgS1BO2mFn/8Pz1alKA3YdMznh1VEB5tGsoq4WopNZbtoUIrrQH8lCeDLas9ODxaqErHRIIpyPzRs4KBKFbsvY3CMk5QVs/VDfRbDRRJcesNt7c8giEQ0t1xRKoPxjPKsJO7gM5eXNX5bOaxjOqtAN3w5kPmHUedNZl8XiXZR5yyNzcPLEaQc7hXo7ld4dYMfIHrC5xDsFryEUT8veWPoTE+KRJw6er/o+Q/ssc/Ahon9udSkVkmSj3WxW0gnY79v39oGekuCR7oqQFoRDLj5GI1Qh2M81MHPsSxTJuK3U8I7T559tfHKqzWeWjWMWjOcE2CYei6rC+2FWXZXGeYtbYGpx5Qa/UxkmoFMpK6SQ5w+Xv/btJLbdloa6uCrzin/WS9x0d+I38DNHfWlqrNzgaljHaKoAfDEJICHeId55126cQgOhV/zmXQxduwT9iErCDjBkzCQWZi2w1aBySwkfRh4wmy3LH51+n0=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(66556008)(66946007)(316002)(86362001)(64756008)(66476007)(76116006)(91956017)(66446008)(6916009)(4744005)(5660300002)(36756003)(2906002)(8936002)(15650500001)(8676002)(4326008)(33656002)(41300700001)(186003)(2616005)(122000001)(38100700002)(478600001)(6506007)(38070700005)(71200400001)(6486002)(53546011)(26005)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC6E85ADDD69D94588C9615BFA10FBE5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6484
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	8923cdb9-42b6-4fa8-a236-08daa8534c17
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wuHpA2PSJrWDnX/l8IBF/8eQuQvx3yPPZ58Mv2NMh9GoDOutKQMMnui22c5o/GXWBEpSq/QUxo5HpiE0UaCw733AMUIHo/eH4cbMtfchTVEQ8cOjSUKRMA8nlVVuuOKECgGKGSHWbNe7Y6sVkSYs/18uoELxvJ2R8fgEOL1O0m0y5WOhISN3wMmrqmdAoAOkhgd2Pf1z9XJklzpecj7WySCLUyW17c0j4lJFxszLAxzFfNyzqt6UbtPP46iqrFxz1JXlrnUh9nGYDAxUAwb3k9uPGaKAOoqHOphrwROzB2zEM9GWMmH8LbeuLOQ4CMSi0ClcqpZrAidm6c7KReIlcbYBshB6DQPxldmq2LCjL7q0B55oWWc8nEFu26NRyF6BU2Iwt00yK2WXdb4h+YimnaxJ1b8LGv17Wxi1oQ20B2rGBXslg674A8DOQeCZNM3e0NvZCeRKqxpUFv6dKPYU6PubWwCC8IAkPgyQmRFXfmcZWqTu7W5AEm6rsso/Ps/xuPNTdBBWnUsBEV3xJtl6S0l3AEOY9bV7I27cbESFJhuNlytcYm3y5AKBPb8ZXI0s9c3+uMwtxf0DygPTAyedSHHRw6S2M0DgY2C4xmblyUSLI90z4TSzYGxkR5kIl1LGqwVDovzPnVXrZCtJlT7gAW8Z5GOlhiUNldRJLKojeTzDUiEc/Yg9Jy0RybqjtsApwdmbup12Rmp2jLc8b9uSYu8Bv9xVfV+PzOMGgf4Skldyx9JyZ9a01qiJBhLjCx6jYnnkG7m0tvICnqcUdafrrA==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(53546011)(6486002)(26005)(2906002)(2616005)(186003)(6506007)(6512007)(5660300002)(40480700001)(4744005)(82310400005)(36756003)(15650500001)(4326008)(40460700003)(478600001)(8676002)(70206006)(70586007)(316002)(6862004)(8936002)(41300700001)(82740400003)(36860700001)(83380400001)(356005)(81166007)(86362001)(336012)(33656002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 11:01:43.3826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d2d59823-294e-41a5-99da-08daa85351d3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7712
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Oct 2022 11:01:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14028


> On 6 Oct 2022, at 22:53, Mark Hatle via lists.openembedded.org <mark.hatl=
e=3Dkernel.crashing.org@lists.openembedded.org> wrote:
>=20
> Additionally, some versions of hashlib don't appear to implement the
> second FIPS related argument.  Detect this and support both versions.

FWIW

Changed in version 3.9: All hashlib constructors take a keyword-only argume=
nt usedforsecurity with default value True. A false value allows the use of=
 insecure and blocked hashing algorithms in restricted environments. False =
indicates that the hashing algorithm is not used in a security context, e.g=
. as a non-cryptographic one-way compression function.

Ross=

