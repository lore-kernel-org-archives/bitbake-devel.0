Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17186C1B087
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 20:40:14 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.86])
 by mx.groups.io with SMTP id smtpd.web11.228.1740688807578457244
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 12:40:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=EEl8Sdn1;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=EEl8Sdn1;
 spf=pass (domain: arm.com, ip: 40.107.104.86, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BX8IoqdF0Vdey4gO9E/MWxf6rxBsNVdnko5qfXODHJnibSUZ8s89oBnHwH/NAH7PGRRz+DJgxbpr7codulak4i1vz/dxeI/5wKoXqKXXJ6phXf23WL2rN1LncOj4v9fWZz9HK2V8hZXq+0yr/zBaUTEDUZppPJhMrFTYmE+DwlkzyjUsWbqewUwaXROO2ABI9Fg0o0hg/QS/K0YIZOPvGHzS6/ya4bmEqfjQqpKgJRoIuuXrgK9hoaJEuOBHB86XWpkpGc9PLK/0Bi6nKPEE9mUY4yhfdy28DfUO3YuqqInHCFUAki61oEaBUyc/B+lIXqbKp664rFaSKKUY3zLALA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE5S/Q2rOGpqlYAKQw6icZ6PyVi8Fz/z0NjMrry5fac=;
 b=kzNr6Fs7UAN1TxdJ5RBsB9s5Gii6nonI0wddaVwwlQZfZ1s43/gbQZGVcKAMTOsGcSU61xUDjZHY7Cb8XaWZxtE5ifndYvRs1OLihMqqzxsHnMsxSERv7BPzEs3ODkFOfZ82gxqf9VoSVmVeTdoi0ahqTLJ7qKlsK4aX3ApnsfdlB1DZo71Yq4XsBeE9AHqBRxWxOZep/UfGgHQga3E31oQX5UUoy00lGClnWszyDg0xWn9wcJVOyd4kkrPYhUgu6wOKSFQ/thuWsF5BiTy938Z2fVf8pfheNNJcuyX1Ov8gEZvE1V6cWkvknf/55Ina/8YNezP27iP7bCKODtmGBQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE5S/Q2rOGpqlYAKQw6icZ6PyVi8Fz/z0NjMrry5fac=;
 b=EEl8Sdn1P7Q8XBV3byzgtmxcX1/qWQ33EP7CqkSht4eQyzDG4Yj4VXVLT3umZhKCmBmp0/nysj7zAYEtENtOcHUTE6Eil1zhjkM/6jaAaJpOksp2zfD8vlQVn6H6yaQ3O4EZHDkfAEuiXw717EVFCfa0nBr/HB9SKCWG85VpkSU=
Received: from AS4P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::12)
 by AS8PR08MB8875.eurprd08.prod.outlook.com (2603:10a6:20b:5b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 20:40:01 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::f8) by AS4P251CA0010.outlook.office365.com
 (2603:10a6:20b:5d2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Thu,
 27 Feb 2025 20:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Thu, 27 Feb 2025 20:39:59 +0000
Received: ("Tessian outbound c3a902884497:v585"); Thu, 27 Feb 2025 20:39:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5335d4b71edf9a5a
X-TessianGatewayMetadata: 2Xi1+UipjYQl1p7t5dpFLD5y7ZBW50usEOgPlDFLGkCe0woxIqjZ0mGmmF8sXWfySXwC2p5mPW7Km6zioS63dQrNxBKljflK8L24jUUjOIt8UMZoF7EiSv2+unbjtUNoTpUOkLRqyZCCXjmn5CmDj8lrQS73oSNk4SYv0yUakO4=
X-CR-MTA-TID: 64aa7808
Received: from Lf0f78e25704c.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 58FC334F-8C90-4B25-B5E3-B22E3193CA18.1;
	Thu, 27 Feb 2025 20:39:40 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf0f78e25704c.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 27 Feb 2025 20:39:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtKh34m9WS124BlhcoU4j1a/oZ/Sc0YcC3JAGWq0q1yTpInUP7DB/Ar+WipkslYCQztVgkNuSiVcyyQ0I1fJDaJSSGYxA9xWKpmTPIHRz0faUnXD3gs8YN00G4JsLjPnt/XRl8KRnvlZ3RdQaqhOAV8U+yp1lTCFqXvuKEfMtzntt0LT7ya4N63Rsq5P8igblzKg4AfApbAwYjRfYrXN4zAnir2JhNYEafkI7ht7qu3AmHdi+jHY7mfXva4cPu5r5awpu4g5LQjsxVLVhH9SV1R77tmWnnsiizfoWtTQLfBnyxthARK/tkY4iVfDn8u25R4O2gNfgX9lNUaNfxl96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE5S/Q2rOGpqlYAKQw6icZ6PyVi8Fz/z0NjMrry5fac=;
 b=bFOL8V+6G1kHx/E9eP6hpJ8XxCgyYJu9c2723DLGz/6YMJEiJdzjGxEfprHtJn7VDRcNsykEQgjrN74gkk2W6M2bZ+OmxX6KQKxNkTB9KKnuj1SRG1tihs0h5hwUsjnxltn4u3cri2QGpfdXbZHVKyWmBNbgJDohWffLPbb3sX4ve1rs18OQIVoo4WMy3bzauCU4V+7DiJ/+NiVRYzSe5iUAbfoJfh/cXPQK4/xP+2UW+Hzz+U3tjvAcY3xE7DmDkNqvFz83qhlu9tMHl1CSa90xEKsVSNOP533cD0IrF2+yF4ggmf6oSrA/HIZs5/o/vK71u5ZTzGrxNNgnMmIJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE5S/Q2rOGpqlYAKQw6icZ6PyVi8Fz/z0NjMrry5fac=;
 b=EEl8Sdn1P7Q8XBV3byzgtmxcX1/qWQ33EP7CqkSht4eQyzDG4Yj4VXVLT3umZhKCmBmp0/nysj7zAYEtENtOcHUTE6Eil1zhjkM/6jaAaJpOksp2zfD8vlQVn6H6yaQ3O4EZHDkfAEuiXw717EVFCfa0nBr/HB9SKCWG85VpkSU=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DU0PR08MB7809.eurprd08.prod.outlook.com (2603:10a6:10:3b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 20:39:30 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%5]) with mapi id 15.20.8466.024; Thu, 27 Feb 2025
 20:39:30 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "stefan-koch@siemens.com" <stefan-koch@siemens.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "docs@lists.yoctoproject.org"
	<docs@lists.yoctoproject.org>, "simon.sudler@siemens.com"
	<simon.sudler@siemens.com>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	"quentin.schulz@cherry.de" <quentin.schulz@cherry.de>
Subject: Re: [bitbake-devel] [PATCH v4 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Topic: [bitbake-devel] [PATCH v4 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Thread-Index: AQHbhIW0GmgvEAVZwE+ji7Oro2bNubNbpk2A
Date: Thu, 27 Feb 2025 20:39:29 +0000
Message-ID: <80041E02-3798-4BAD-86C3-D27381F6179C@arm.com>
References: <20250221172602.527924-1-stefan-koch@siemens.com>
In-Reply-To: <20250221172602.527924-1-stefan-koch@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.300.87.4.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DU0PR08MB7809:EE_|AM2PEPF0001C716:EE_|AS8PR08MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f43c16-1cd7-4649-17c5-08dd576ee7bb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?MmxYbCs0ZFlJODl4UFZnZXM5ZlhrY0I3OElMQlplY0ZuT0k1SnM0K3lwVERr?=
 =?utf-8?B?akQ2bmNMYnYvMFcvUzBqdjNONjRJMlJ1cmhEUzdEYzZNYWRXMEVwVGQxOTZC?=
 =?utf-8?B?NTd1NGNiZEJpZWxCbmxUcHJwY2p6eGVYMk9NcUJ0aGt6K1l5Uml2d3BhemJY?=
 =?utf-8?B?ZTI5b0laVHdNc3AzSmdsV0IvREhsMlF4OTJPRnlZVkg5RXZRanhCN2VPbThj?=
 =?utf-8?B?VnFHd0l3RVZLV0JwRDZkYXUyWG9qTkdjcTFEajFxN1BnUVNjbjR3MG1welFr?=
 =?utf-8?B?OHMya1hwSW1RTDBBa1BPSFVSSnBvTEZTaW1yRVQyRnEvdk1LdjRCZWs1OHVp?=
 =?utf-8?B?aGVJblpCTExJS1Q1YVZQS09wQ0ZsUEpTTTE0UERucjh3UmxlWjVXTDZCUm8x?=
 =?utf-8?B?QUszR2M2c3pxQjhTTzJYM240VVB3MGpPQ2piZGx2TjhvTDgzTnZUd2M0bi9N?=
 =?utf-8?B?bCtXNHdpWDNLK05uSjBnUDRucFRJUFBxVkxHNnpreUNFYnU1RCtFMWpVKzZO?=
 =?utf-8?B?ZVRJL3BscjFzTVBuSjkwV0pTd2ZYWmtwa1JxRHROSXlzNTMwRHhnV21rNENQ?=
 =?utf-8?B?cFo0QkVtelJwU0NaNU43aDhVQXVscFlOYWFqZ1ZmdkNRNzU3cmw0V2pKcjFZ?=
 =?utf-8?B?ZDZwM0ZLcGJxendpcWd3Q0k1NU5XaHhHZlMwcWp6WVhTMTFwT0ZNOUx4MXJl?=
 =?utf-8?B?VitlOVNScE82cjNqOEFjdHFqbGlmOUgzQTFPK1E1eXcxR3R0QzZOMVNMNFBY?=
 =?utf-8?B?UXF5bTk2UUIvejhIUVNHTWgvcG1VM1c4YXBNY091WTM1aEhFZlJoYTE1bitk?=
 =?utf-8?B?d1Bzb0VDZWYyaG82Q0g1endKZDlrcVN3eUJKb3JHdUxGdVY2eGY0NDIyVW5K?=
 =?utf-8?B?ZEF2OVdiVS8xd2RTL2IzK25tMUJRTW1QUStQbFhWRUpwV2xjN2g5eVE1T1BY?=
 =?utf-8?B?cGwyRGZtbHl0T29VODZGVG51RVY0N2hPb1dLMTVDYXNRZ1lKdWNxdFN1UVlI?=
 =?utf-8?B?QjFJTklwQnZNdjk5NUw2NERITDJmZCtNbEJyV2N2UTNEdERoSTV6N1BMc1ZL?=
 =?utf-8?B?NjB3eU1vVWJ0N0MvQnBRRThhTWFHcmZGZXdPSmZCc1M1dTBkZFpGZDB5eUdl?=
 =?utf-8?B?clNmN3A5aHVLcXRrVi84dEJMZk9tUlJ1TUlRU0JaWWN3ZzRHcmFBaXlBN3FN?=
 =?utf-8?B?WjNOcUthYXRoekNaZ2UxZUsvclUrWkVpcWFzV2x2aldhWlUydlU5SjZrV0Fm?=
 =?utf-8?B?WjRIdDF4Z2NtLytvbGF4aXRhajBKZWFEbDFJNXJIOTU3cTY0NWF3T2s2WUVW?=
 =?utf-8?B?dm9wVEZNd29rYlFxWGFPQXN3M2MzVzNFdTRpTUVlN0NrS2txczJFNXNJa013?=
 =?utf-8?B?eGdqWW8wd3Zad3pFYldrQStkcDA5bmplUlp2bm5NWGsyTmN5OUlabUtjeDRu?=
 =?utf-8?B?b0cxTDVlRmVVeWxadDBFNi84VERadk5NRjg0ZGZOQzM1djZzcEovd1E1SWZs?=
 =?utf-8?B?aG1RY2dXS2dpRmxldUxuNHp4SmJKaG9TelhSNVV6RkJtOCtLdjFSK2xEa2NS?=
 =?utf-8?B?OHkyTTBGRTg5ek9CSFpiaGxmOURKa0ZhZkZmN1Z1QVRIVG85clUzcjlORnds?=
 =?utf-8?B?SDBTTUpBLzBXci9JdkVadWI5WnJDZkdmT2pYMG9POTZlU1JsVFdLNFR1Mlh3?=
 =?utf-8?B?YndMVjBzQUxYMTdQRTFpeXdZYm9waFpIZnlsU2R1Q0RodDZtbkxlU2NZN3F2?=
 =?utf-8?B?SUFwaGhqME5kcVBtcUs0bFNnOUVWd2t3YjVFdlhQamd3NHI0eUZzb0ZnRitV?=
 =?utf-8?B?LzNFbEpPaUFVMndkTURaUXhnWEtqc0NSbGlDL2EwY3NkdzBNMFFxZTU5VXI1?=
 =?utf-8?B?VXNCbXZHanVKVDYybWx0Y1VPVk1uOWRZMjdJcTVGNkRSa29BNDNFb0lqbE9E?=
 =?utf-8?Q?9URO8Q09OxP/QqmuOpwMQW1Cu0619t37?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C8805464C5B7B46B0684CD086AC017A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7809
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	6a907ef3-9a89-4095-a7c3-08dd576ed5ba
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|376014|36860700013|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S2xHU01HRkRhTkdZNUwzZVlBUXAwOUgrZFZJMlRlNTZHZGdTT3IzSVR6MFlo?=
 =?utf-8?B?Z2ZtNEdWVnkwdkpwWml6SVE3amF3ZzZxTHYxR1JzZGJpTlR6bDV0T3FkSlNE?=
 =?utf-8?B?bTU3dVdCdDJUMFlSaDZZNUo2eTFwa084UG1jbElUNXpBeVIrYWtJRS9DekxH?=
 =?utf-8?B?cmtjdFRQSjFNQ0ZzQ0Q3cVkxWG5wZ09wbUlkeWsyZ29UWndlYkxBQUdicGN3?=
 =?utf-8?B?QnpGN2tEaGRLVi8zUnBwdjBETkh5ZkQweUhOT0tObDlLWGhSU2VJYlZ2enVl?=
 =?utf-8?B?SjZWS3ovVWplSXduc25Lc2twQThnYmgxd0FzTXRSYzJNWndmWHlxZnI5UnQ3?=
 =?utf-8?B?YjdvUkh2NFIxZ1NURUZsQSswMUlGak9nblZMVXBxUC9ieUxucW5TSGJkbUkv?=
 =?utf-8?B?bXFteUdqanBOUWlwRjVJaEhyYk1hajdxNG9GbnFCT2dNcUZOY1lxWW9oOU9X?=
 =?utf-8?B?OWdPdUVjWjUrVDRUUm1wYkY5Y3Vpc3Ava2ZWb3BaeHRMYkV6d1F1Q3IvRWlQ?=
 =?utf-8?B?bnBQeDhDNmNzSGRWMUJJaDNhSFozYjZHTStIQy9BMU9kblk4Y0NhYmdQaVVG?=
 =?utf-8?B?TXRBSkIwYkpOblNWVEYzanp1Y3FCWGpHT0FEeWVvOTNmS285cFRrN2llZWo3?=
 =?utf-8?B?Qmw5ZFlPMjgxNzhHbWMrVU1qWnQ0UHlra0V3K3pEbFQwR0ZuRlkvWEdoMUZU?=
 =?utf-8?B?a2FNdUl0NldybW4yb09sL0RuQnBMbnpIaUhEbnpwWjJmNUxrTXdYYXE4SUZQ?=
 =?utf-8?B?cEoxT0xvdlNubDJyQWtFc1I4T2lrV3NRNFVrbzV2cFdYb0VzSDhYRElxemZY?=
 =?utf-8?B?cXhsV3BhUG9BUUJZb1k0cjlLQytHUjd4Rys4L3Y2OXA1aDQ1Y0VFZ0lickg4?=
 =?utf-8?B?YTdzWHRtSUVkMDVjYi9kQ3A0a0d0Q21rMFNHVkExMWtRQVAzczAxdm9iYUcr?=
 =?utf-8?B?TDJUYlBoTHlKaTJwZWRLZExNSzVFVnVjOGc1RHRRTHZWQVpsbjJoeGVWVzJm?=
 =?utf-8?B?N3paTFRMNmJWUEtLRTJpd3RBTWZ5RDhtSnk3UktpQ1QrYWNORW9JT1hsWVBX?=
 =?utf-8?B?RDVVSW5aRVFYRTVPeUU4K2FKMGhhcklhS1pFUmxUZ3VMTk14b1hvYlR2VWhU?=
 =?utf-8?B?b00zOFVIVFhSdkNtOEl5MElHRm5lb3BvYVJLQ1JRbytLLzhmUlVHQk5yTnE5?=
 =?utf-8?B?ZTBGb3AwSVFGdXNJeWVjZllBMEYwNDY4YzQ4UlFwSm5INjlWVTF2bk5OWGly?=
 =?utf-8?B?S005Zll3MHk3THJsa25INFRuRWc0RWM4OTRYSGJYUXBBSm9TblczN2VkWXNx?=
 =?utf-8?B?N2pLeGcydzdLRm43ZjVyZjFDeEl6U3k5RnlpSTRKWnBweDBkM3NuQW5OR0lo?=
 =?utf-8?B?eUhZTlVXRDgycDNENGhmenN2TUsrdStnNXZXcS9TbGVDN3FJUEc2TG1NeUJ6?=
 =?utf-8?B?dHliOW1IeTZEeWR6SEszZlBQVVJZVUFQRmhOSC85TTdTYW9EUStvZUx2Z0Ix?=
 =?utf-8?B?YTh4aUNCUnRVS25UN1VPV0xWNCsrRGJyTHZZTFJVaXcxMmhFclNqd2dCY1RV?=
 =?utf-8?B?ZVNONkRmRzZPU3ZaN0JlVTVLQlE0YThOMTVWUEYvQ1RUcGhUWWxnZnRtTUUw?=
 =?utf-8?B?bFRWZ0lUSWNuTWdtTGdkM2pkWmtDQkJiODJTeXNkK090aU5qNnNpdkZFKzZp?=
 =?utf-8?B?aEdOMXBnMWU1M1lwcS9hNnAwWUZPVDB3UWljZVJJWjlIaDlJNFU5Rmo0azJW?=
 =?utf-8?B?ZzJCM3I3UldpTVN6ZEhzZ011UDVFSUtTZ3dvNnFFa2hSbVZpQVlpRnNoWTQz?=
 =?utf-8?B?VnVDblJDMmlyaVIyaHJkUEF2ejV5MXdHZWVFT2tubEcxYThMZFVaVkkwcUdh?=
 =?utf-8?B?V2FTb29zR05zeVU0Y1VVRkhtWlZEVUtsc2R0dDJDK05jT254OXdmaEQ3Um9u?=
 =?utf-8?B?T1lTNy8zZjlrTVVhRytSa2xITjRVczdsajIrZW13VnBKL0N6azlQb2FvOVZZ?=
 =?utf-8?Q?sldxcle1JRvBPtFhhI4yGmJaoxa5IA=3D?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(36860700013)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:39:59.9795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f43c16-1cd7-4649-17c5-08dd576ee7bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8875
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 20:40:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17351

T24gMjEgRmViIDIwMjUsIGF0IDE3OjI1LCBLb2NoLCBTdGVmYW4gdmlhIGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmcgPHN0ZWZhbi1rb2NoPXNpZW1lbnMuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+
IHdyb3RlOg0KPiArICAgICAgICB1ZC5zaGFsbG93X3NraXBfZmFzdCA9IGQuZ2V0VmFyKCJCQl9H
SVRfU0hBTExPV19TS0lQX0ZBU1QiKSA9PSAiMSINCg0KV2h5IHdvdWxkIHdlIG5lZWQgYSB3YXkg
X2Zyb20gYSByZWNpcGVfIHRvIHNheSDigJxldmVuIHRob3VnaCBJIGFza2VkIGZvciBhIHNoYWxs
b3cgY2xvbmUsIGRvbuKAmXQgYWN0dWFsbHkgZG8gYSBzaGFsbG93IGNsb25l4oCdPyAgSWYgYSBy
ZWNpcGUgZG9lc27igJl0IHdhbnQgdG8gZG8gYSBzaGFsbG93IGNsb25lLCBpdCBjYW4gbm90IHNl
dCBCQl9HSVRfU0hBTExPVz0xLg0KDQo+ICsgICAgQGNvbnRleHRtYW5hZ2VyDQo+ICsgICAgZGVm
IGNyZWF0ZV9hdG9taWMoc2VsZiwgZmlsZW5hbWUpOg0KPiArICAgICAgICAiIiJDcmVhdGUgYXMg
YSB0ZW1wIGZpbGUgYW5kIG1vdmUgYXRvbWljYWxseSBpbnRvIHBvc2l0aW9uIHRvIGF2b2lkIHJh
Y2VzIiIiDQo+ICsgICAgICAgIGZkLCB0ZmlsZSA9IHRlbXBmaWxlLm1rc3RlbXAoZGlyPW9zLnBh
dGguZGlybmFtZShmaWxlbmFtZSkpDQo+ICsgICAgICAgIHRyeToNCj4gKyAgICAgICAgICAgIHlp
ZWxkIHRmaWxlDQo+ICsgICAgICAgICAgICB1bWFzayA9IG9zLnVtYXNrKDBvNjY2KQ0KPiArICAg
ICAgICAgICAgb3MudW1hc2sodW1hc2spDQo+ICsgICAgICAgICAgICBvcy5jaG1vZCh0ZmlsZSwg
KDBvNjY2ICYgfnVtYXNrKSkNCj4gKyAgICAgICAgICAgIG9zLnJlbmFtZSh0ZmlsZSwgZmlsZW5h
bWUpDQo+ICsgICAgICAgIGZpbmFsbHk6DQo+ICsgICAgICAgICAgICBvcy5jbG9zZShmZCkNCg0K
SSByZWFsaXNlIHlvdeKAmXJlIGp1c3QgbW92aW5nIGNvZGUsIGJ1dCBhdG9taWNhbGx5IGNyZWF0
aW5nIGFuIGVtcHR5IGZpbGUgc2VlbXMgcHJldHR5IHBvaW50bGVzcy4NCg0KPiArICAgICAgICAg
ICAgIyBXaGVuIHNraXBwaW5nIGZhc3QgaW5pdGlhbCBzaGFsbG93IG9yIHRoZSBmYXN0IGluaXRh
bCBzaGFsbG93IGNsb25lIGZhaWxlZDoNCj4gKyAgICAgICAgICAgICMgVHJ5IGFnYWluIHdpdGgg
YW4gaW5pdGlhbCByZWd1bGFyIGNsb25lDQo+ICsgICAgICAgICAgICBpZiBub3Qgc2hhbGxvd19m
YXN0X3N0YXRlOg0KPiArICAgICAgICAgICAgICAgIHVkLnNoYWxsb3dfc2tpcF9mYXN0ID0gVHJ1
ZQ0KPiArICAgICAgICAgICAgICAgIHJ1bmZldGNoY21kKGNsb25lX2NtZCwgZCwgbG9nPXByb2dy
ZXNzaGFuZGxlcikNCg0KQXQgdGhpcyBwb2ludCB3aHkgY2Fu4oCZdCB5b3UganVzdCBzZXQgdWQu
c2hhbGxvdz1GYWxzZSBpbnN0ZWFkIG9mIG5lZWRpbmcgYSBzZXBhcmF0ZSBza2lwIHZhcmlhYmxl
Pw0KDQpSb3Nz

