Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56239CD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 12:38:00 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10776.1778157471423396248
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 05:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=rsL9vHv1;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=rsL9vHv1;
 spf=pass (domain: arm.com, ip: 40.107.159.69, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IfpSCjfq5skWNmboim9JU4idBIizSYnPli9+NeKhqK8uzgkRCDT7xPEdDRIgiPs31CsmKJs3eVAyKU1dTN5V1+GNLgA5drfpsyWzycOgp7XJs0YFGOh4kLGfr5g4pOhLMrSzOo17dnNUBN5bwslIqq/sHiqOaoFHUMJcgqJJWFK2tu7imUHqZR/g067h4UeNDIroHw+xBEAtTWUk3r7xTxBbhOHHWXZVMZbotEWsLzvelLjTbO9qaT9Ind/SukzGgdX0WyAFM4+g4fZ4ouQuLg9ilnMgSa+COJEddqwwfU9ibmHgZsf6opvxj96TN887YM+3rO8wOycgEIJv0SWVrw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOe/rJT1953hEhVEqOoNE/6lvHGojZjeLvyyxC9PC5w=;
 b=wQpAPLiYNhFq/Q+40Bt9m1H7oRXkwZgZSREe/VNv+IOX+pWUWmH/QfJ13RisCL696cau0yeNkpimr7EBJqudYEhRN7CRVAh/O2X9N3gr3ogpXH5osMZwjc80GuemGgz3v3gJotSIgQT6ntRTEw9BZTwvMZtR2kFpuQc5CP8tY2CEcZgWeqWq4RAKdhP5QaW0T2anMt4HS8Q63fNceMLLUa63kLJC+lxyIb8JXtzeqXQ8UPwTMEDNYaVha0GVFCeHXsiBx6X5DB1hoZK94Nw2hQfirM4PQHjPDtTs8ujhFudA+8fpK5bkREHKMmbPcIb7/hdLaZOu43Y68pDrx0PESA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOe/rJT1953hEhVEqOoNE/6lvHGojZjeLvyyxC9PC5w=;
 b=rsL9vHv1RRbx9QhYw1UBWiLUvJV2Gb1Tr3ehXrfCx11TLnnhWXA7ZNYFfJAYL6bev0xD4yOvAcsXTNTW2KXnZEzJ+Y7c4Yq4Imx6RYBotTPQQDYXgKJIf1hj+WII5nbK1Hst51QabHO51x7M+7EhZqKSx0YhKmqufSOhXWYPM18=
Received: from CWLP123CA0265.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::13)
 by PAVPR08MB8967.eurprd08.prod.outlook.com (2603:10a6:102:326::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:37:43 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:400:1d5:cafe::8d) by CWLP123CA0265.outlook.office365.com
 (2603:10a6:400:1d5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 12:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Thu, 7 May 2026 12:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7aae+28jTKgkId4HYbMAz4k7ezLw3VLIIx8mEQvVWCuJh4r987nytMyAAKVoh4/OnrCBSO14dkzHrv+UpBrPa5TjV9vPfZUGKhO4YDMHPOH2gOvQWZxg6jVd8VitLDDd+vmvKLuYzQTB7i2xqJ/VmbR6U7olOkAS+fva6IvrJu75AWSPI/daRP3nv+BetqChICLGF42u8Rn1Ue9DQMCBEgggqTrE4MaPWWdn4EbYBIo5/sf7wVTjhcMQidImiqXwtohey9dJY+ffJX3k81I1kHKhfyz6bCr4un1i6diGjIdLLIkWdKkGgiBmy7oTB7ddfCnKU2hrH2EQtrW1lCG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOe/rJT1953hEhVEqOoNE/6lvHGojZjeLvyyxC9PC5w=;
 b=EczUCef5ObXFbRGzwWaOwLYyxGbAejcHL7FD5n4hAcqDd+s17bbcBj/nEclskXcvjCL73o6cVhZoHnd310ki+Vb5Kfwvhds9vM6inklwxnibkdzHHe3zahNUaRKm4dAezjscp2P6eRUYA+jfH53MdFaNO/EJFD90EXReCJox8jkh/t/iNTVpGRDN22o/AQ8yP5CzadOYdyu9XPYRqjUezwc5sWTeqa3RxH7BtuR6HPlqbkHscN0pxTvrkSDYKh/7VPuDd5V0sGteBbORHPgDF7XZfFA44TBYwyuvpHf4uyW4XESdcVZ50AgKOV+/w16roFNjGk0moGAr+Arn/7Lfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOe/rJT1953hEhVEqOoNE/6lvHGojZjeLvyyxC9PC5w=;
 b=rsL9vHv1RRbx9QhYw1UBWiLUvJV2Gb1Tr3ehXrfCx11TLnnhWXA7ZNYFfJAYL6bev0xD4yOvAcsXTNTW2KXnZEzJ+Y7c4Yq4Imx6RYBotTPQQDYXgKJIf1hj+WII5nbK1Hst51QabHO51x7M+7EhZqKSx0YhKmqufSOhXWYPM18=
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19)
 by DU0PR08MB9773.eurprd08.prod.outlook.com (2603:10a6:10:446::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 12:36:35 +0000
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b]) by AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 12:36:35 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>, Yocto-mailing-list
	<yocto@lists.yoctoproject.org>, Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [bitbake-devel] proposal: build pipelines in bitbake-setup
Thread-Topic: [bitbake-devel] proposal: build pipelines in bitbake-setup
Thread-Index: AQHc3Hh72dEnnidHYU6vP95C5oTNKrYCg0uA
Date: Thu, 7 May 2026 12:36:35 +0000
Message-ID: <6100A74F-B06F-49D5-9895-DB7D5B563773@arm.com>
References: 
 <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.6)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AM9PR08MB6258:EE_|DU0PR08MB9773:EE_|AMS0EPF000001B5:EE_|PAVPR08MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 93dd0de9-8a86-4e1b-c17a-08deac356f32
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|366016|376014|3613699012|18002099003|38070700021|3023799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 
 hSn9SHxmDLsoVkGbEhGwBHUZZtKzL6cr2p/Cqaeoxi46uZ+AQLXRlZAutXH/kyhptZbxuBofigYCTwNlgZaaMOWO9MjqcvVyJVMaTycQXyD2yPVcQbrHm02A6tHhdjEGcdAA5G8AiOef+lIgmrLBBduEyfoPZIlfACLtAIj5sJqD++XzeP8T5+aPrvl9QutwhpmqREPeNkMWdQgc//iaBWkp2DjvLiDy1U0ikmL8c0dXtrgHhqPjno8K0eE975dzOxgFkmDUNYjDywAKITsERxypI7jiSACtEPmYGMw/rYF1274ubgGRD0BWiNyXGsiAn4YjMYnFwzduNXj9EVJVqLEhTt/ooNqX4zakEsmEE5vJjctsxUffztlv9/PFrqfaGkm0z6vdJQ2DBISEqztpFtGemLdvORSaBpEd+PgeEGzVPiXtHChOvZnudp4sLQuTVhw3SC+U46xbshd5qr2NCaSYf7x0tSB25eiKTVn8RwscRAqRS4TY5znvQjkra5Wm5sMj31R43qVpglMBfXfi4lPoSpz+XKAkk5vYUdyW7fo8E/3fZglVZljXmYBIODt5M96zCvhZyl/sdAtfV3dc0IN1T/v/ibSiJEZXP9KsBaFi4VizQtOIvJ/mdRvqvobHazi4GBq9sMNXelaPxsvaLnYY9kYRdipB+USdELS5MBfUzIb+Om1dSZsBR50M9NmnYY9a6pSBo0/tpdY3KpsNuD6TLU/yqyFD6mVjYN7CXRzr+hEbv/hytwRi9EkEVlaiTZASV9AR9HIgCAVKbIv39Q==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6258.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3613699012)(18002099003)(38070700021)(3023799003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD3DF6CFE2FDD24A8793CA943DD571DD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 h3MQBqFr9SdIyxlHW2VJwsTAHv1MnG3rCL448UsMCdUiq0kjb0ns2OEjlGwtgiZij7BJkOeAIPtakYyJah+PteEwYSGK8n3sRofk9icn+AZbK4Fx1FGz5ML57rO6mqVqXZ8NpTwfpEHrAfkNrBwHInWyhvk4SiOnZ0g1txu/U2H5S4Ng7T7r0I9XiwAqCSE+fb7flZ9bJSmkqHY75cWdXXxw15pmgFcFb4OfaD9LWn5bml5lGHbMUa2mWSgns176cuaNgY+2Ad+7Tzos8/ColSMdtpidlEuH7uuMeBRXI8mYkuUk+Ics4YvNjvvlxzzfU+dFgL4VoN+3Rzq1HHyy3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9773
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	d8ceabcc-f575-42e4-c1dc-08deac3546d2
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|35042699022|82310400026|376014|36860700016|1800799024|14060799003|18002099003|56012099003|22082099003|3023799003|3613699012;
X-Microsoft-Antispam-Message-Info: 
	oZ5k9o0EFIk0xPyZGUXE9edeGDJv0jup2aOUgiXdoI/8GErhPGfqMul+KKUNm7iw5pnoCSbv759pPDDvSYUQEq1k4peB/oSz/DWt8RwKxJMYJwn58p3z5/HcIP1t2vlEKJisB5qtSY+5VKl8tgDEi/VW/9N+xBuMuVMqowUx+Bm+Sa4kfsYr/bJ8jrRLpwpkcWZOIvyW8+aNlpFCEJNplyZOK+uqWNt6KuSTsD31ZNwb01WDYXnzdmmRPbMdZhHNVAuOKMYnZrk+QHtmps94v5g/PJT46NFZyybbn8f5e06jbFcTINTg7xjfHe1liZFMWoc4BBFJqooVNXrCwO5IsFPZwkvx4mCzNI/LytJpUr0QG7s3YVStQwBaabyUdjiF+y2zqpmvZ6uKrixDf6gaMbW1NsNC74h6vJkpPC+u39rJKAf8AyS4AEbzs2TpQnblXe1IHu0Ri3T6I5jqy7/9SUXLFj49OqoytHrRksLxLYVW66KS73SK8y15Jv6f3qd30ziVQy0dW3IgTatMGzBJNyBV5eh1lTYjwhPsJEZKDKJY5mrdccNmWRwIKQdVVb1aEg7rxxusFO/yEbxFgaLv/Pu4QcxHTXelPyBV93GADXsxQtQSGpPj2AhZWt5XeMkil2kpGisCuF+UmiMKpwjerR6xpMZwBozdNvdsFINeEPcpzqp3ThcHJvZdzdtru9hsQOvIg3yumNzyahjtSleP/24h9WiKtTleZJ/dipZK/4Ip+8xb/70WUhv9cgohDPn2rUNOLJ9afunN497TrVMEK7F+8mX96nZu0NgW1v2cPaI=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(376014)(36860700016)(1800799024)(14060799003)(18002099003)(56012099003)(22082099003)(3023799003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Y+LBBMCTAk+EtplligpKAwc0KWkWpk/+mpsKnKw9nMEl9/vBqAQaVs5ipfhakaSzMBHFwNJdTW84I2EgQA9oebcVKTNp6wrRr9zRue54YVhl8GHBy6TVAI/wtqnj2BSa09VvWAYCLvJ7Dc8Kj03udaAhlK2eLARfal9SBk6Ohp9yfLZT52oVRk+zaMoFXe3QAO52hPJmAbPtLDYaBVUcfbFB66A4gzU2lyiMuFv4ZUf+XdDXawJkqHaMvW5o9npGFltYAoeeFPPy9VYj8wPNHRBsl7PWwVyG3v8PQR1nXqLCn9mOyBkabMIeimRvQRBXjH/aQ/cJPZmaFFTmMzqWFzs80qRwGfNlMfm7VXO3OExQgBsFZR/nfdRkWP1KN5zowdA/Ps5ofTUKtp1lrN/UnylxMY3ad9mWZOIz72dRqn5Jf68CGgpM4/u0RZJIfpjH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:37:43.1117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dd0de9-8a86-4e1b-c17a-08deac356f32
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8967
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 12:38:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19459

T24gNSBNYXkgMjAyNiwgYXQgMTE6MTcsIEFsZXhhbmRlciBLYW5hdmluIHZpYSBsaXN0cy5vcGVu
ZW1iZWRkZWQub3JnIDxhbGV4LmthbmF2aW49Z21haWwuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IHdyb3RlOg0KPiANCj4gYml0YmFrZS1zZXR1cCBjdXJyZW50bHkgZG9lc24ndCBzdXBwb3J0
IGRlc2NyaWJpbmcgYnVpbGQgcGlwZWxpbmVzOiBhDQo+IHNlcXVlbmNlIG9mIGNvbW1hbmRzIHRo
YXQgYWN0dWFsbHkgcHJvZHVjZSBzb21ldGhpbmcgdXNlZnVsLiBGb3IgYQ0KPiB0cnVlIGVuZC10
by1lbmQgc29sdXRpb24gdGhpcyBnYXAgc2hvdWxkIGJlIGZpbGxlZC4NCg0KVG8gYmUgaG9uZXN0
IEkgdGhpbmsgSSBkaXNhZ3JlZSB3aXRoIHlvdSBoZXJlLiAgVGhlcmXigJlzIGFscmVhZHkgYSBs
b2FkIG9mIOKAnGJ1aWxkIHBpcGVsaW5l4oCdIHRvb2xzIGZyb20gc2ggc2NyaXB0cyB0byBNYWtl
ZmlsZXMgdG8gdGhlIG11bHRpdHVkZSBvZiAgdGFzayBydW5uZXJzIHdyaXR0ZW4gaW4gZXZlcnkg
bGFuZ3VhZ2UgdW5kZXIgdGhlIHJ1biAoaW52b2tlLCByYWtlLCBldGMpLg0KDQpEb2VzIHRoZSB3
b3JsZCBuZWVkIGFub3RoZXIgb25lPw0KDQpSb3Nz

