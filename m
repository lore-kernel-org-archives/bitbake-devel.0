Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7299C54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 17:08:14 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.53])
 by mx.groups.io with SMTP id smtpd.web11.79395.1674752886011909451
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 09:08:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=JiXCm444;
 spf=pass (domain: arm.com, ip: 40.107.15.53, mailfrom: ross.burton@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7oWi5i5NBTRHSIm06c0E1vzyWZjiCmE4hMNJOt9B18=;
 b=JiXCm444RvDyJfUbV9mJpT41b516qgxx7LMn28ulxo5svlWMx7ihW/a3Si4aPNVMeZ1Bc8P8rrH/71gUmXsbUSzLEa3ZjSBTrg4+o02prozdkM44NXktSRqtp3/1wJSUy465MCM2Y+IVT3btCTVBPW/8d63oYxfrQhrw5EVPn6Y=
Received: from AS9PR05CA0188.eurprd05.prod.outlook.com (2603:10a6:20b:495::8)
 by DB9PR08MB8225.eurprd08.prod.outlook.com (2603:10a6:10:39d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 17:08:02 +0000
Received: from AM7EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:495:cafe::6a) by AS9PR05CA0188.outlook.office365.com
 (2603:10a6:20b:495::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 17:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT017.mail.protection.outlook.com (100.127.140.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Thu, 26 Jan 2023 17:08:02 +0000
Received: ("Tessian outbound 43b0faad5a68:v132"); Thu, 26 Jan 2023 17:08:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 870d4f712b3f0f07
X-CR-MTA-TID: 64aa7808
Received: from 800198cbdbe2.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 438CB81B-F4A2-472D-AC28-95896BDBDFD4.1;
	Thu, 26 Jan 2023 17:07:55 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 800198cbdbe2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Jan 2023 17:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBAkUzFy+p8DxdXhBEAKqvcV8TZf67d3QlNMLbqwabzwRcZjiFKu4CrYP3wCAfyyXwQo68pB1NVLVrr+4P9dsTeXB9J/vK/WEVD8RVdkmX2/zNSdVuumbVvUOjUqc/phYyNSwVuOtX2yNwvGpaqCJH40RipYwL8R0X3C4R3sxptsB5YxfaDHmie6FrUNVjWr/4ihKsKW/hH+fIGysqIJK0bPTlOJwPxlNCim6GZC8ZAX64cZGQyNTRIk17NY8p+uRiGuI6MWMQ+8IrN5eYKx0WUf7r/rWiTDS6dU2vg9yP9arGXHVSuMfgvDV0Iih94VQhaeNY/F+diARGZDF0qAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7oWi5i5NBTRHSIm06c0E1vzyWZjiCmE4hMNJOt9B18=;
 b=h3XdGuI7SxU5BWwWMRzbWvpky8uNtcL9dqP5xCuOr0JL7gJt//tT/whU+TeTF2Qn3GLLu/qlEWGM1Pe00zWHBS/Ct96ueMnRk+Udoc6Q8BMr4/1a0PE+IPqjaxHnBhFsmJNj2f3ygXavaRfbShAIeUY3SuGY/B+5WXnbYeMC8Ti67+Eug3HETE2K3m8l9O5s81yArAAOXj0EbqC/Dhk/fJpzV4qRihWjoL5PyxUcsXuZG+QGe0vRCFf1IGIbM8mD8FPvDunm7DFriQgJVuynRxmAYPA+JbIBcCgmvR9JbJWK0JXB+Br2muIpUqCZXaw0Jh+kT6c8iEu8WzbHUn5PWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7oWi5i5NBTRHSIm06c0E1vzyWZjiCmE4hMNJOt9B18=;
 b=JiXCm444RvDyJfUbV9mJpT41b516qgxx7LMn28ulxo5svlWMx7ihW/a3Si4aPNVMeZ1Bc8P8rrH/71gUmXsbUSzLEa3ZjSBTrg4+o02prozdkM44NXktSRqtp3/1wJSUy465MCM2Y+IVT3btCTVBPW/8d63oYxfrQhrw5EVPn6Y=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS2PR08MB9366.eurprd08.prod.outlook.com (2603:10a6:20b:596::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 17:07:52 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 17:07:52 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "aw@pionix.de" <aw@pionix.de>
CC: Alexander Kanavin <alex.kanavin@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Using bitbake as a native standalone
 package-manager
Thread-Topic: [bitbake-devel] Using bitbake as a native standalone
 package-manager
Thread-Index: AQHZMWIKneC9V4xa5EqcZLuDwqfuXa6wwCiAgAAueYA=
Date: Thu, 26 Jan 2023 17:07:51 +0000
Message-ID: <D5BD049E-3D94-4F6C-841B-F7B2BB3860CB@arm.com>
References: <Yyvr.1674722117946957577.GL4y@lists.openembedded.org>
 <CANNYZj_ZrA5XzBkDDZa+6QoYYtizQAnu1VAMCZuh1ZVUic6gUg@mail.gmail.com>
 <CAMoDz1W_yqm1ZPSBwC9c9tTdpLTESUDJkpO5TrAT7pFgX5WGfA@mail.gmail.com>
In-Reply-To: 
 <CAMoDz1W_yqm1ZPSBwC9c9tTdpLTESUDJkpO5TrAT7pFgX5WGfA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AS2PR08MB9366:EE_|AM7EUR03FT017:EE_|DB9PR08MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d37f7e-e5ba-445f-5aba-08daffbfe220
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 3aPf28Xyzmrb8d3DMNBqKzZZnqPFCM9DS3YFEYpvdBXCBXpCMYlDZH71CwjD8ni0PLWDoFp/6x/71D1EAfOwb+p8wocxIENwU7LxscLBYLgjJB1ZWKLfCLDm+p4YFcyt0Zq+7C//vTJ5jgdH8Is1Z3RRfgGxfpT+MNU5EHKplcDIfw9JedKkcS3ZiPay7jco70CuxjfGurV/CF8HnkG0XF+sZBSxOxowBic7tMWuuR3ztQjPGXz+Vu/9ZYUhtPQYQgO7CDdif/reuZVFdnnXuVDQqxiatT/bDyWWlMtu4E8H19M/o6i72w6IGjPn4q0HO4EzHDZqFUzI3l8PwYRUqQoGPoRbPr5c8bXwD8sscmnO+lMi1leDmxM5H0AQ1ZJUhIpqmiruevLu1KazFxs//aBOIapx9GhymYfmbBgyBTL2/fjUnBYYekgc6ArUV0TV1/oRoJO7Koo7cWMUYjj4yA4wspKXEpIw7o0bVPI+roOs0+EAmVvKyVAaTjhnJFUXV/vYtDnPpHQSRdO6I3A/57nLOx16+/Qn4O3b1h0J0hsJR0fwioNivkWTJXIJN4r1/QmgjWNICif0ershAyTo1ZUo93GrAdfyfc49SYctXb2yqTyPKuyhY4WF+JfCE10VCmH4tJIFjfSAVtB1UZa3hWgs2vgEi04msO36UTV5FY88coe7pUiZMxQO50KdG3ep
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199018)(54906003)(38070700005)(2616005)(71200400001)(4326008)(38100700002)(53546011)(478600001)(186003)(66946007)(6486002)(6916009)(66446008)(76116006)(8676002)(86362001)(66556008)(64756008)(26005)(6512007)(966005)(66476007)(6506007)(41300700001)(36756003)(8936002)(4744005)(2906002)(122000001)(316002)(5660300002)(33656002)(91956017)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <011EB2E2F1BFE840BD44456B790799AC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9366
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM7EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	80ae25db-2d74-4aca-edf2-08daffbfdbe2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fSzEG1Z2pWQmFyRgs0oWrLlFDCJXI0VTk9wZ9nz+5xkxbFnuYz9dk3NFneKD+XIA1qixqr6kySbFEywczS+tSFwTBrEeAlrjF5k2Ju441iikiGXpP7O3BgqaZ6riu2qx23C/FBhAP9r06KIjZNmxpytJjLPcEy84uaPcYls9w7+K9y23DoAdQ7Tc0CkpDRFLbFn4smDhinvzKp8m7EMYlOICeWXOqjSVk7JUvJrVNCY7LDzgmUMh2CRsF4a/7ILwva0Qw19Tm4F4fJxEH2Cc8xvtGDmm9muK6yrFFezEZvfnNRtWuF9n/sDbEMyw0lz/k+5vQJxcXa/2jz6FPurbDOSs22T+8RFVQztaGdSYjaPFAG+HacCEKZRlSDG0WZgKOe3Z8QkLKZXGC2kLfuZYqXkWs16pyQun9MXS7Ox60nnx2G3x+11Jz4z06fPbI2sRrSCCOnCsfAA6Gww7eoHzSuiYtKHPrP7pKzybjGrHS4UDmN1PypaaYfgYAXe0NY3WwpzGS4kLL3CPPP/O7YtEu+2DVBzSH3F2aSip0aBu85D9znXOsSKRTuZRiuzqElIbEsDKc9/erKXPvt3iwSAVZYLRPKkxDwevUsGL5dFQQDYdpLhjRixqrPjMrdMGZE5hAPSo0UZDSL1s3RXXh769Lw==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(6486002)(966005)(478600001)(53546011)(336012)(47076005)(316002)(6506007)(70586007)(70206006)(54906003)(6512007)(8676002)(4326008)(41300700001)(5660300002)(26005)(2616005)(186003)(6862004)(8936002)(4744005)(82740400003)(81166007)(36860700001)(36756003)(40480700001)(2906002)(356005)(33656002)(86362001)(40460700003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 17:08:02.3329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d37f7e-e5ba-445f-5aba-08daffbfe220
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM7EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8225
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 17:08:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14353

T24gMjYgSmFuIDIwMjMsIGF0IDE0OjIxLCBBbnRvbiB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9y
ZyA8YXc9cGlvbml4LmRlQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdyb3RlOg0KPiANCj4gVGhh
bmsgeW91IGZvciB5b3VyIHJlcGx5LA0KPiANCj4gY2FuIHlvdSBwb2ludCBtZSBvbnRvIGFueSBn
dWlkZSBhYm91dCBob3cgdG8gY3JlYXRlIHN1Y2ggYSBtaW5pbWFsIG9lLWNvcmU/DQoNClRoYXTi
gJlzIHVwIHRvIHlvdTogc3RhcnQgYnkgd3JpdGluZyBhIGJhc2UuYmJjbGFzcyB3aGljaCBkZWZp
bmVzIHRoZSB0YXNrcywgbGlrZSBmZXRjaCwgY29uZmlndXJlLCBjb21waWxlLCBldGMuDQoNCmh0
dHBzOi8vYTR6LmdpdGxhYi5pby9kb2NzL0JpdEJha2UvZ3VpZGUuaHRtbCBjb3ZlcnMgdXNpbmcg
anVzdCBiaXRiYWtlIHRvIGJ1aWxkIHJlY2lwZXMgZnJvbSB0aGUgZ3JvdW5kIHVwLg0KDQpSb3Nz

