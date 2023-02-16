Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A03EC636CC
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 11:11:39 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.88])
 by mx.groups.io with SMTP id smtpd.web10.7476.1676545890435674262
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Feb 2023 03:11:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=AFtle1sV;
 spf=pass (domain: arm.com, ip: 40.107.249.88, mailfrom: ross.burton@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5DYclcYI55ZlpIPdUk8dvXZI2J9KVmmz9ecp0lHr0w=;
 b=AFtle1sVBUqu3mNqJ0ZGpWxOZsvnNCDjuHBg1t0ShBAPDu4GalHcauGbwYG95r3+xFUWb+1S84x0P2PzbBNbgo/TxwAaYDL9osRZOU4k09RfWNHxcq+Givg81fxgrhGKqDyu+AEXc+/cZl+/Q47gFJyJ1I1maAxEoH4SqKLpjZY=
Received: from DU2PR04CA0194.eurprd04.prod.outlook.com (2603:10a6:10:28d::19)
 by DBBPR08MB6058.eurprd08.prod.outlook.com (2603:10a6:10:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 11:11:26 +0000
Received: from DBAEUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::64) by DU2PR04CA0194.outlook.office365.com
 (2603:10a6:10:28d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 11:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT038.mail.protection.outlook.com (100.127.143.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 11:11:26 +0000
Received: ("Tessian outbound 8038f0863a52:v132"); Thu, 16 Feb 2023 11:11:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 99a3651b15ccaa63
X-CR-MTA-TID: 64aa7808
Received: from 45306dbcb8d1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 415DC220-75B3-4325-AC79-E134F6F6FEE3.1;
	Thu, 16 Feb 2023 11:11:19 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 45306dbcb8d1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 16 Feb 2023 11:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crQ8nQpz0Yo8srl4u1dGEcHoYvGaoCZtNaDg3H6iIoaC/L7akhTnG14lQHnDcaoqmuEGl1XWH/sGphzn+uQ9HriZ3Ic1jJyuv6+no99UdPEADmVfG8+/in6Jerk0OCixcSp4r2bk/+RrOp9mSkAugobAz+Oyvcovux4v+ibqE0KrBueJROicgCQYzD41J9+yQtWrjR9jBd0xj7X/O87AlAidBVF0t475OtMVgVNJEDceLr1OuNWgRZo//2F7wQQ/BaRhnKPHZ7AkpjXNp90EYEPMz3uAGjxIeg01/KOTRvG43HrFwjy4SmRJX18ZjxO+0v8vSEpbbPDVBQGD1npAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5DYclcYI55ZlpIPdUk8dvXZI2J9KVmmz9ecp0lHr0w=;
 b=On7IhqKcrZPjuSBtWJdTYaPTbuYSi8+pUVkXX5zaXPy27LBre5vLyNqt/efonDAyv5BQUzsRvm272F5GtR4EEEbeQse4jtpGarKJ7DD8SrCzaVJ8nLnbTnM4CZ199w7zTI0StVJZhspDml1IseyRBpzYhtuCowNb/ZLqzdS0tb4RRgLJBJMbM41bgl0AGyT1w18cpAeXRUSgFBcJsBlnQq+W1G1EqvKmwoq5N1SknLPQf0yroifXy1v7GCpxk9egWA35rTgBv7FJW7xL0np0KckWAFswjmFCr/ACq7jW9r2UyvOagOSvR7mPpM4cIhu0AwsJz+J2517HGkmA187tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5DYclcYI55ZlpIPdUk8dvXZI2J9KVmmz9ecp0lHr0w=;
 b=AFtle1sVBUqu3mNqJ0ZGpWxOZsvnNCDjuHBg1t0ShBAPDu4GalHcauGbwYG95r3+xFUWb+1S84x0P2PzbBNbgo/TxwAaYDL9osRZOU4k09RfWNHxcq+Givg81fxgrhGKqDyu+AEXc+/cZl+/Q47gFJyJ1I1maAxEoH4SqKLpjZY=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AM9PR08MB6244.eurprd08.prod.outlook.com (2603:10a6:20b:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 11:11:17 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 11:11:17 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Paulo Neves <paulo@myneves.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: clean up netrc usage
Thread-Topic: [bitbake-devel] [PATCH] fetch2/wget: clean up netrc usage
Thread-Index: AQHZQI6Fd3q9WR99D0OsON3/WlSrpa7RWV4AgAAUPwA=
Date: Thu, 16 Feb 2023 11:11:16 +0000
Message-ID: <D94D44DE-9CA9-420E-B535-E3165CD64F6A@arm.com>
References: <20230214160751.2391568-1-ross.burton@arm.com>
 <76c73df9-69ff-da0c-60fb-378b9940f75a@myneves.com>
In-Reply-To: <76c73df9-69ff-da0c-60fb-378b9940f75a@myneves.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AM9PR08MB6244:EE_|DBAEUR03FT038:EE_|DBBPR08MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: acf8213e-dff9-497a-2964-08db100e8bdb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 Hc04VFTdmiy1jDHU5ydKNq7hO4hbvqoUGHo7TiCHgVQ4nDjdTavDJmm0lkoOYMQik+KxDrGU+AAnUtM4HlNnmIkdGGjky5FRK9SzEZ9Xz9b0wfu7nZodl43z+1LQinEYrpCxUc6vjK5X6adMfXtT2osTsxtCcxDyDbZB83KL2EbGaZ+sD2veqKVsL0P3b9AENj5m189l/orx/GWQmDLSE+a0R0wB4R0/phqutp6YKK3w/veKYtBDL+VR5zioMxgeD8lg/qEcWziQH7VoLMdMPFXJVIqYrviwZUq6q/7/1b9PM1oJLc6kFVZIPRYZpV0qqbszkwo0KW81zU1tuvrPTqjP+dCcCOaqeVQXZ/0AciXT5cBVP7vomx3NArgglB6RwWjH/ibabY+z449OK4g/uXU7AioalF1d1dPaJqf+Eebwg/wuRJmswWLJVH8TX+38UbvipNJ/nXVdCKOY1W0ZP5Ol/9qlrX/7aqZN92R+lJSVRmirQEjC/1z/SAVDz/yaJJrg8whhu66RMDdzylx3CK8G0aayXhyXmKhrRItO/4xjMhaypYBT318mYGg3kPRCbxRtiXmUus+5sye1o+DVLiRfJJW60yDIwqEDnEbDgQDWB7xbGMebGN1oMwO979HUb7UzIogvgD1lpQAGTbGneB3QCrAwkmsA+zTSZT55n3D3Z96VC+HJ6ZHWxki6Y1oWzSSmNOrjsvNhnv80sjmJ93nYSZ9X27iA8HNkvv4Xcs4=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199018)(66556008)(41300700001)(8676002)(76116006)(91956017)(64756008)(66476007)(66446008)(66946007)(4326008)(6916009)(36756003)(33656002)(316002)(86362001)(8936002)(38070700005)(478600001)(5660300002)(122000001)(38100700002)(71200400001)(6512007)(4744005)(2616005)(53546011)(186003)(2906002)(6506007)(6486002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <762EB1293CA9474FBFBCB6D75348BFDF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6244
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DBAEUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	2959a8e9-40a7-4f33-802b-08db100e862d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eZQduEBEKCty2NmIVg6wkyB2DYC8GgphCzGarZcnusrq5HBsbQOdMOuQM7VWlBBMI1a+OEFc11oxcpZzbwwAmg3u/dC18+WpPrCxo88tUdibkn/abfMCY8h0G6J0ZVis3BFUfr1bKmio1UYKMHxZp/6T8Hj+fuh4jCtE27sf8nC6bywCVFi/F795iS0kDDP1N63m6d8fxoXapi7bWxgG/l2Ptt5mQDpFSK6WeXMxZGu/lASz3oAEhwchFl+lpW94NEyxP/YFtGWi8dmYUD0eBhUCvI9Q7r2fyW9iTLDNtvdICyDjwNj8Y2CfxiN2sgb4coMV04L1NGdBEhGoYTsreYz/wskK2/HflgluZp61M+Z19O/TK3xR3MDRdqF/d8hmSkTrEoMpo9TVOmEZa91Cx0+yPZOoQI6LykPh9Y8fLmixrvvgqRlAH9TTh+CUxjAdfRaKD4yr/sniRzis1BtHWx2mdaDETax8QviP2tTuaVJ6izk9c4AuJg14thJvJymDLQaabrzRaa7+PhNG8Di68O3vIuFJOJbnsmU02aLV1/Ko0V1GG9gHOUZprFYJJv80dqZGk5clGXxBd51tslCmOS3LPhnC8NitPTrz9YsCQtU5eUuDI9+FJvOx2dXsydFAzQ5/UixI1Vt3BsGmSzMF5vdreIPp7lTk+4jXTZE1r1lBiRyJnOljVKZHQfpcR11Hfrs9ewCIU11HyxcWEPxW5A==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(2906002)(336012)(4744005)(6506007)(478600001)(53546011)(6486002)(26005)(6862004)(6512007)(36756003)(40460700003)(33656002)(5660300002)(186003)(36860700001)(2616005)(40480700001)(47076005)(82310400005)(41300700001)(8936002)(356005)(86362001)(81166007)(70206006)(82740400003)(4326008)(70586007)(8676002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 11:11:26.4883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf8213e-dff9-497a-2964-08db100e8bdb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DBAEUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Feb 2023 11:11:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14446

T24gMTYgRmViIDIwMjMsIGF0IDA5OjU4LCBQYXVsbyBOZXZlcyA8cGF1bG9AbXluZXZlcy5jb20+
IHdyb3RlOg0KPiANCj4gWW91ciBjb21taXQgbWVudGlvbnMgVHlwZUVycm9yIGJ1dCB5b3UgYWxz
byByZW1vdmVkIEltcG9ydEVycm9yIGFuZA0KPiBJT0Vycm9yLiBXaHkgd2VyZSB0aGV5IHRoZXJl
IGFuZCB3aHkgYXJlIHRoZXkgcmVtb3ZlZD8NCg0KSW1wb3J0RXJyb3IgbWFrZXMgbm8gc2Vuc2Ug
YXMgbmV0cmMgaXMgYSBzdGFuZGFyZCBtb2R1bGUuDQoNCklPRXJyb3Igd2FzIHVzZWQgdG8gY2F0
Y2ggRmlsZU5vdEZvdW5kRXJyb3IsIGJ1dCB0aGUgbmV0cmMgY2xhc3MgZG9jdW1lbnRzIHRoYXQg
aXQgdGhyb3dzIEZpbGVOb3RGb3VuZCBpZiB0aGVyZSBpc27igJl0IGEgbmV0cmMsIHNvIHRoYXTi
gJlzIGV4cGVjdGVkIGJlaGF2aW91ciB0aGF0IHdlIHNob3VsZCBzaWxlbnRseSBoYW5kbGUuICBB
bnkgb3RoZXIgZGlzayBJTyBlcnJvcnMgYXJlIGEgcHJvYmxlbSB0aGF0IHNob3VsZCBiZSByYWlz
ZWQuDQoNClJvc3M=

