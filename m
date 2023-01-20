Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B3C05027
	for <webhook@archiver.kernel.org>; Fri, 20 Jan 2023 11:25:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.62])
 by mx.groups.io with SMTP id smtpd.web10.71945.1674213928882418698
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Jan 2023 03:25:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=3+Y6HE7F;
 spf=pass (domain: arm.com, ip: 40.107.22.62, mailfrom: ross.burton@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULKDdY7cQv3yd4L11ub/7xHgOJBhK86Jls3BNJZfEyk=;
 b=3+Y6HE7FakP5RtbTL0yeTB+WOmE4eF/ClAW9E2NWMf5WgnG9VSTxhENOk8XP4b2f3qPWlVpqwio21Ky0RdATUcGNPGphDMwdpAGZHVM03VyxmgfJsrJnw7nL8KzPPbezHrloLvs0qUcJBEP5qPFsbOiJvnc0Ef3X8IaMw7sojIc=
Received: from AS8PR04CA0034.eurprd04.prod.outlook.com (2603:10a6:20b:312::9)
 by DB9PR08MB7510.eurprd08.prod.outlook.com (2603:10a6:10:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 11:25:19 +0000
Received: from AM7EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::f9) by AS8PR04CA0034.outlook.office365.com
 (2603:10a6:20b:312::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 11:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT033.mail.protection.outlook.com (100.127.140.129) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 11:25:18 +0000
Received: ("Tessian outbound baf1b7a96f25:v132"); Fri, 20 Jan 2023 11:25:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2d55130d0b4d6cc5
X-CR-MTA-TID: 64aa7808
Received: from 7683066b8cab.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B30D0434-59D8-4FE2-A037-E1CD73C25AB5.1;
	Fri, 20 Jan 2023 11:25:12 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7683066b8cab.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Jan 2023 11:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmPgG7s+FOZF+92g07FW6mzg3jv1tKLABYpfkjBknB35lM8jtGDZBUJwp13hTTmRa1Kj2fnGfqJE9DIu845VxUluFvSN4s88Bz76KcjEgCvPdjwweIX4rpVZAdyPDWiednJntRFGnp4agew51H84UeUgHtRtsyLKtcMsUNiae48U0+d7iFNiPN5bHG2YRdtqzr6rbgCDsLLln+FH72wGcwCLbla7u3UtGCbdX7n5vOTlThAq8nNYLk9pUxkVqLGrZ1OCkLfQn06x/4oNuMwcdJ1Ofo4jC8voWMHb4n7RpQ1LcWtVZFbDBj8XKZXhFUHNC7vSBs4KQzSh6GDsNVyzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULKDdY7cQv3yd4L11ub/7xHgOJBhK86Jls3BNJZfEyk=;
 b=Xu+oK1m0RO/ndBuHozXHMomhoxXTEOQthQREVxm99GCp2QBDmaFAHk0IX10UPAfuEPijj8Gx8ZHsqljyJFGs4Kusb5svCex9APsKbBsiot/oi6v53YRavMjeTUPGsdPZWE9imvOZifEo44o4gZjaGTADJgBv0HfOZWNtnj956txymRgIvooX+RTx2TnCY30py5UyFdQMLoRP4tCQ1bqShTn/+rnP8axV8J+xc3mY9EFn4fI//yYgXnHQg2x6Igcu4JEcPaAXuFdJbkSzH+MwMFMx4/MSRZP0QptaHWKydJqcTNePILx3IbvPgY2Nam3soll1Dt7cafgcDzTZ2PCfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULKDdY7cQv3yd4L11ub/7xHgOJBhK86Jls3BNJZfEyk=;
 b=3+Y6HE7FakP5RtbTL0yeTB+WOmE4eF/ClAW9E2NWMf5WgnG9VSTxhENOk8XP4b2f3qPWlVpqwio21Ky0RdATUcGNPGphDMwdpAGZHVM03VyxmgfJsrJnw7nL8KzPPbezHrloLvs0qUcJBEP5qPFsbOiJvnc0Ef3X8IaMw7sojIc=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by PAVPR08MB8846.eurprd08.prod.outlook.com (2603:10a6:102:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 11:25:10 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0%5]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 11:25:10 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "ahmet.fenerci@andasis.com" <ahmet.fenerci@andasis.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Bitbake inaccessible file
Thread-Topic: [bitbake-devel] Bitbake inaccessible file
Thread-Index: AQHZLJ/kxHCzD2afjE2QA6kwqLVRzK6nKmmA
Date: Fri, 20 Jan 2023 11:25:10 +0000
Message-ID: <9952F175-28CE-4DA9-AAAF-B070198D6FBB@arm.com>
References: 
 <DB5P192MB21839A67B248EF872B524589FDC59@DB5P192MB2183.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: 
 <DB5P192MB21839A67B248EF872B524589FDC59@DB5P192MB2183.EURP192.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|PAVPR08MB8846:EE_|AM7EUR03FT033:EE_|DB9PR08MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 87de7882-7c25-436a-a8d8-08dafad902d4
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 MmABIb8L2bzaAo3tB3oYFSzTtU1ocqpUP/lroHzIfQCwn+o0i6Yw48mG3aoywtlddqjO1HRSGKc7QiE5BOKSQ5/AKbiM1Eg6zncK45Ep9pxl1fHnTm52AmYX4KsYy5iKHPK749SgbdxoI8+XMkBj88v/aN959C0CvZynslgxV2ND/l/V1mx4Txv2nFno7IWigBdPFY/T9t7YZGJVS7BUPVhWvvlMJTsv6wXsO/bFvARFl7+LybyiWZh6hjSTzHWoTNVwlfh0OcKTfRJpc0xY6DkeiBMiiTmjdsdojY3aGLysOsZ4vuE4R3OA8NiBcUKYsBCJeyez66SdA/BBsXX+L9Excg6WgsNasjhORbMGfYdoN5KCWeALPlPSJmdq7AilFP5ODK/ttiPEiylUdJZNf74iYHEspyg8v6WZEr+oBMQzfs6OZGmV1PsmyWfVNg6ppMVpzlnJ/fMdZIFE1J9oNagpJzKOEL74HbvaR0y+Zbp5kfGX5rNiEbmpU8V4TbklniQv6Ss0qymABD2HHxrDL9MGjY8gypsjP0ojDF4ITKYygiWJKb1xkVOjAsvTKHs0pcF+OATIZSBl8ZNs/0zp/1nt+Wc02iuTg1RJmeK4ba7GJk7+DIVlB1jHj5a9wxmz7RDDZSxbzNss5BHy2sGPRoGkAzhlp+WQcQ5lNcGRsNHbQOia268N9MwbIVG6YM4XMzzxl7fbEmx/8r7Eg4UDUEZQ08P7qVwKtycAnpWxhmTHBJBgQwP7TnEwfRjMUCneM9kTU42h/byWuQNTxydUxkNDOGoaMkP0PPi6jzHbrOI=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(8676002)(41300700001)(66556008)(6916009)(64756008)(5660300002)(66946007)(316002)(66446008)(66899015)(66476007)(2906002)(6486002)(966005)(71200400001)(122000001)(26005)(53546011)(36756003)(6506007)(478600001)(6512007)(186003)(4326008)(33656002)(76116006)(91956017)(8936002)(83380400001)(38070700005)(2616005)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <A881C92FAA73AF4CAB1AD852F54469DD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8846
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM7EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	78afc743-5ceb-489f-4cec-08dafad8fdb2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2UNmdiU13+Oocb4A5X5KszsP/t2ugXOktFyRIiGIr64PkXHgKnJaR8wmMrkP8wPm4k1s0GmsU8/CvkLBZRYjsTaaj0QtNO08taIdy4OReC/La6wc8NSdhqhIZBhlr9ssD3K/tdPCUASESz/BrRhU24fcm81e0CtO1h6lFFr+ITrBdY+ZBDkq7ydMgvzD7AtwwU6qN8cQe0RHROqrX0nI5jbqIsnbORBMlrF9M6i6aQGdQsHnpyUWZ5e7SnCj/hRn7r5BT7ABQSnFTT2WawilT2LP3lTrr4XHWfyQsgRXdmDWzahYL2n74NuOPgwhVUkIWAumugQZB3/FofTKamRT4KRxhqpJoGevK76sTb0hyJeohLo4TSkVEG1H9fp9SuiI72ASFi0LzQIRU0JcdwWaUz1FN5bEyYWCFfQsbdsyqR/LqYZTR0OjOLAQGxN5By9DHHGwtKCvMCS3N8hLoENU5eiorFgsJB8/Pn764/AZhu6OtIw2XSO0eF3JJE0etlAPidvGMdSOJSYqd7FifUW283QkDS/DoP0TQNR9uAMV//FRqyQ5xikJPzMIenM9aCueWO0A/DSm1BsaPigw/X8gR8eB94Ovgy18dgVccNq0uRvRGwOm1kojQsPKAAd64qpmB0L52aSFb6kHIC8xcx87tbw4/BpSa1eF15VBwJLj2mlozNq6zITXdTlvPsSWCN4YwfUZ22x6iybwseE1rD2HJjw9myxSlpOs8D8LIWsXz6CZLqlSMR7QMewVCpti2WOPBkEkwbJTFgxdZJW/XQo6uA==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(478600001)(36756003)(33656002)(6486002)(83380400001)(966005)(36860700001)(53546011)(6506007)(186003)(6512007)(2616005)(26005)(47076005)(40480700001)(336012)(70206006)(8676002)(70586007)(8936002)(4326008)(6862004)(356005)(81166007)(5660300002)(86362001)(82740400003)(41300700001)(40460700003)(316002)(66899015)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 11:25:18.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87de7882-7c25-436a-a8d8-08dafad902d4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM7EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7510
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Jan 2023 11:25:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14328

VGhpcyBsaXN0IGlzIGZvciBkZXZlbG9wbWVudCBvZiBiaXRiYWtlLiAgQXMgeW914oCZcmUgdXNp
bmcgbWV0YS1pbnRlbCBJIHN1Z2dlc3QgeW91IHRyeSBtZXRhLWludGVsQGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPG1haWx0bzptZXRhLWludGVsQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IGluc3Rl
YWQuDQoNClJvc3MNCg0KPiBPbiAyMCBKYW4gMjAyMywgYXQgMDg6MTgsIEFobWV0IEZlbmVyY2kg
dmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPGFobWV0LmZlbmVyY2k9YW5kYXNpcy5jb21AbGlz
dHMub3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IEkgd2FudCB0byBy
dW4gWW9jdG8gb24gSW50ZWwgQXRvbSBQcm9jZXNzb3IgQzM3NTguIE15IGJvYXJkIHN1cHBvcnQg
U3VtbyBicmFuY2gtaGFyY3V2YXIgcGxhdGZvcm0sIHNvIEkgdXNlZCB0aGUgaW5zdHJ1Y3Rpb25z
IHN0YXRlZCBvbiB0aGUgc2l0ZSA6IGh0dHBzOi8vd3d3LnlvY3RvcHJvamVjdC5vcmcvc29mdHdh
cmUtb3ZlcnZpZXcvbGF5ZXJzL2JzcHMvc3Vtby0yNS1oYXJjdXZhci8gLg0KPiANCj4gQWZ0ZXIg
c3VjY2Vzc2Z1bGx5IGRvd25sb2FkaW5nIHBva3ksIG1ldGEtaW50ZWwsIG1ldGEtZHBkaywgbWV0
YS1pbnRlbC1xYXQgKGFjY29yZGluZyB0byBzdW1vIGJyYW5jaCkgYW5kIGFkZGluZyBzZXR0aW5n
cyB0byBjb25maWcgZmlsZSwgSSBidWlsdCBpbWFnZS1zYXRvIHdpdGggdXNpbmcgYml0YmFrZSBj
b21tYW5kLiBUaGUgYnVpbGQgcHJvY2VzcyB0b29rIGFib3V0IDYtNyBob3VycyB3aXRoIGFuIGVy
cm9yLiBUaGUgZXJyb3IgaXMgcmVsYXRlZCB3aXRoIHRoZSBmaWxlIDogInFhdDEuNy5sLjQuMS4w
LTAwMDIyLnRhci5neiIgLiAoIEludGVsIFF1aWNrQXNzaXN0IFRlY2hub2xvZ3kgKS4gQml0YmFr
ZSBjb3VsZCBub3QgZmV0Y2ggVVJMIGJlY2F1c2Ugbm8gYWNjZXNzIHRvIGZpbGUgb24gc2l0ZS4g
KDAxLm9yZyA6IEludGVsIE9wZW4gU291cmNlKS4gDQo+ICggaHR0cHM6Ly8wMS5vcmcvc2l0ZXMv
ZGVmYXVsdC9maWxlcy9kb3dubG9hZHMvaW50ZWxyLXF1aWNrYXNzaXN0LXRlY2hub2xvZ3kvcWF0
MS43LmwuNC4xLjAtMDAwMjIudGFyLmd6ICkNCj4gDQo+IFExLSBJcyB0aGVyZSBhbnkgb3RoZXIg
d2F5IHRvIGZpbmQgdGhpcyBmaWxlPyhxYXQxLjcubC40LjEuMC0wMDAyMi50YXIuZ3opID8gDQo+
IFEyLSBJbiBJbnRlbCB3ZWJzaXRlICggaHR0cHM6Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQvd3d3
L3VzL2VuL2Rvd25sb2FkLzE5NzM0L2ludGVsLXF1aWNrYXNzaXN0LXRlY2hub2xvZ3ktZHJpdmVy
LWZvci1saW51eC1ody12ZXJzaW9uLTEtNy5odG1sICksIHRoZXJlIGFyZSBzb21lIFF1aWNrQXNz
aXN0IFRlY2hub2xvZ3kgZHJpdmVycyAodGhlIGVhcmxpZXN0IHZlcnNpb24gNC4xMi4wLTAwMDEx
MSkgLCBjYW4gSSB1c2Ugb25lIG9mIHRoZXNlIGRyaXZlcyBpbiB5b2N0byBwcm9qZWN0PyBJZiBp
dCdzIHBvc3NpYmxlLCBob3cgY2FuIEkgc2V0IHRvIGZldGNoIFVSTCBpbiBiaXRiYWtlPw0KPiBR
My0gSXMgaXQgcG9zc2libGUgdG8gcnVuIGFuIHVwZGF0ZWQgYnJhbmNoIHZlcnNpb24gb2YgeW9j
dG9wcm9qZWN0IChEdW5mZWxsLCBLaXJrc3RvbmUgZXRjLikgZm9yIG15IGJvYXJkPw0KPiANCj4g
DQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVz
c2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KPiBWaWV3L1JlcGx5IE9ubGluZSAoIzE0MzI3KTog
aHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL2cvYml0YmFrZS1kZXZlbC9tZXNzYWdlLzE0
MzI3DQo+IE11dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL210
Lzk2Mzk2NDE1LzY4NzU4ODgNCj4gR3JvdXAgT3duZXI6IGJpdGJha2UtZGV2ZWwrb3duZXJAbGlz
dHMub3BlbmVtYmVkZGVkLm9yZw0KPiBVbnN1YnNjcmliZTogaHR0cHM6Ly9saXN0cy5vcGVuZW1i
ZWRkZWQub3JnL2cvYml0YmFrZS1kZXZlbC91bnN1YiBbcm9zcy5idXJ0b25AYXJtLmNvbV0NCj4g
LT0tPS09LT0tPS09LT0tPS09LT0tPS0NCg0KDQo=

