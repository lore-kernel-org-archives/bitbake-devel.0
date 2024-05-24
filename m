Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB1C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 14:15:01 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.134])
 by mx.groups.io with SMTP id smtpd.web11.16829.1716560094393917898
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 07:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=adfswCvj;
 spf=pass (domain: cherry.de, ip: 40.107.21.134, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvzQW614m1fUXmoyUT+KtEhVUJsSVLsYsiOjk9X5ZeCC+VvQqmyYcJiZycIou4KYGAmXmZQ5+DKaz4HziYWpcCc3lWiE/U6Fmk9PGBX0vIM3C7saV1elht6AN67tyRB/bvUBuZ5de/k/5cMJSM2LlmZkxpUdYE/iREaWA6K0RUL9kTdF29HpdeJwMOHviab8dxJKm9S/18Pq22jn2Kfq07jLXwWyDjd728fF+n54XrXz7w4QHs0Gnuik1QdFroxMEeqitr67l7M1qxCDsY3uZisLyYElR2g0F70d63apDaSPiiiVVmtFzNStuy8nb0+7fRPjrdb9iOUDM2Q4WLCJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryZligUfKm8z0nvwQ/aWOFV6bLZQYHP3IWZjkWNHiu0=;
 b=naB+NkMTTOFvNtgIFQC0O0Fs82bWI3WA9N2fpQ8cEvAQ35y5nMvH3OykLFam3viIY3Ip+RZ4HFSxhuRfSLSk20271QdZH5BVcNS6dpLbYt8QcjteY4Bdoczn6Ba1czQaEkgri6wR14tkM77PlEBRjIsYQ1WHKIXXqSZ1Mg0kgU28mffUrIZf+wDYwS/xE8W/JW+aNL7sDOP3W9/xPdpWQ/M2Z/A14knayiGqxEuZRu7Hs1sB65Mp4jjrEhS+GBsgQJq/oWNEpPinFDL2fHviyW1HAqu4QrksfHd3pn2O+3SnKP3Jkd96O0iqD4kVRo13Gj83srcw2Io/OQsYIsXzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryZligUfKm8z0nvwQ/aWOFV6bLZQYHP3IWZjkWNHiu0=;
 b=adfswCvjPOspyXFU4Jv+6mxxZo2M7QDgtCUyY7EZVxG233BfiwvfS+X3ocZhP7TOoM84+hYnynJrCCZFIjpE6bn2X9sfAT54pTC/oqHc14lOD/+IQU9bnRFOkj1WPYGYLXZICcAbWGchxAhuiq753YDMMBmqvzJ/GZg41R/Jsck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by AS1PR04MB9311.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 14:14:49 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 14:14:49 +0000
Message-ID: <afdd4a7a-8e55-4519-9ce6-7d09e50c0d44@cherry.de>
Date: Fri, 24 May 2024 16:14:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] Dependencies ?
To: mlynch@hi-techniques.com, bitbake-devel@lists.openembedded.org
References: <lfcT.1716559062178660500.wc5p@lists.openembedded.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <lfcT.1716559062178660500.wc5p@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|AS1PR04MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 466722a2-ac1e-4995-6497-08dc7bfbdf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M25kRkYwUy9ybTB0WXZ4NGVEci8vbVV2bnFSSStxTjh0clJtUjJUZ0JVYjlN?=
 =?utf-8?B?dW93S0RONGxWUVFRSTMyYXBXdXozcnFPdGlKY2ZhTGcvdVJqcGpCZFdTUndR?=
 =?utf-8?B?WU1PcmZGUEVJKzBidlNrOUJVNHZlbk1pazZCVHFtKzZ2M0JkN2l2ZWJYMytV?=
 =?utf-8?B?UnNWY252SmxyRitMT0JCeUpTZ1g4VllqKy9LN29sSjZDZ0xoODNSTFFiTllV?=
 =?utf-8?B?NDc2cE1zZzN4SVFxMktuMHZxaVdpaXJWUmhTc3V6dllQZjJ5RDdzUEVaVC9Z?=
 =?utf-8?B?Ums5b1BJc0RWQnYvU0xaWWFBT2U4bFU2WlN5clhDOVgxVjB4bzg5L2dibDdG?=
 =?utf-8?B?MUF5elhGemFZS0VaTWhCYXcyRVdKZ0piOWtKcUsrTGVxanM2MTZHUjhIVDR1?=
 =?utf-8?B?SnRUT1pEUkd1ditITm1xdWo2UmhTd08zdElDdDY2TVlEY085UHlFRGdMUVFo?=
 =?utf-8?B?VnRJVEFvb2FVQkkvcWdzdkxLaHk3aGo5c21GWjdwK0NxYXV3b3VlYS9WTUhs?=
 =?utf-8?B?UjUvL05vT1h2UTRYOVFEM3ZnTTc5ZTJkRmNkWEZvQ0JTU0psSnVCU29YRUN4?=
 =?utf-8?B?T2IrT1didVNsdTlLQUNXV0UxY25KVWI4bk5oWXlUT3NrZ01lTVh0YlkvU0ZW?=
 =?utf-8?B?S1h5ZlZJR1hPcGl6ZWFFRGl5ZHNPbWQ3YkRDaTgxZWZWdXdEZnV2bStCOVdM?=
 =?utf-8?B?YVZNZnZtOS9YVGczNmdRT0svSmF2SllSa0h5dDAwZWxaZmJEYjdrSi82OHZF?=
 =?utf-8?B?TTVDaU9yZkpKUEpPdTlRaW1hMEZiem91QksvUVg0UDU2QzROVkV5M21rYk8v?=
 =?utf-8?B?VlBGb1hkaU9yRGk1YUVpTm9lVXJHZVphV1ZpNXdKYjVUY0kyS0dzNWVIWUpj?=
 =?utf-8?B?TFZLcUNBVWgxdHVMRktLbDJIa2VMekNRaEJCT1MvcnJZdlhqb3lpajNrRWhF?=
 =?utf-8?B?enY2SXE4aUVNNzRWREQ4NnFBR1V3c2dUaXM0UzZYVDBzalR0WHJCL2V5MUZO?=
 =?utf-8?B?QmxPcTNJUExXd3Z0b2lkeCt5TnhxcTd0QmVIQzFFSjhDSitJaGlEckh6WkQx?=
 =?utf-8?B?Ung0WXdQV3prODRHY09xK2R5ZUtNMGcySnA3UGZEZmsxaDNJcXVjKzA4TFBP?=
 =?utf-8?B?WXp4N0J6YnVPODJ1RDBQazN3NU5NMXNYb0l3eTA1V2plT3Q0bXBIR1JwN2N3?=
 =?utf-8?B?cmw2OG9sY1BzRi9IU0h3OUg1ZE1BUFViWHVUd0hvaEE1SlN2UkkxSUFpTmZ5?=
 =?utf-8?B?UDRPbHlkNFJuOGkxYVdzK3VQSUhYeDBxVDd1d2g1dENWY2lnUEp2SzY0UGRI?=
 =?utf-8?B?VGcwenFWdXRCOGVYSVpleFRqSE9oRWVka3ZQcUZ5T3hWNjVEOU4xa29pMW0r?=
 =?utf-8?B?dmdQY2tZcmZML1JHS21nRGhkalV4d1diQkxuTnd1QnNhUXVBTlU0dDZNRndk?=
 =?utf-8?B?dkRiWTdhRkpEN0xydHNXSzJYUXhKelB1c1RJUEFTR0FrRUhQalFyTElZZStk?=
 =?utf-8?B?ZldnTG83MGNyaXJaUUdObVpsSkphVjZnTDZDR1FYUVFlWXNWSG8zQURSRnYr?=
 =?utf-8?B?MTcwY2I3MlhoUGwydUVYWkZqRHZ5SUo3QVdmSHhqTFhPZFpwcEdmaU01UUFU?=
 =?utf-8?Q?npw2LeW4oidfLonyHY8+gj6gHqI4phRkOyKtrmpcMWl0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnBJVkVIeTdGK3BrMCt4MFZXQTIwbTFpK2RzSTlSM3ZrcEJJRW02QlhaUmNQ?=
 =?utf-8?B?RVZBS1UyUlZCTVdQVW9SeU9qbis5RmZlOVBDT3kzTHdrQWxQVE4rdU1yZmdT?=
 =?utf-8?B?Um1MMTk3Mlc3a1Q5VnJHeGxhOTc2TkZtTUpMOERYQTc2YlZXSEgxaVFUMlRF?=
 =?utf-8?B?cWNrQnQ2Qks2NmZZZFFLUUZMVW44T2lhNnoveHFITGJQRDJBWElhTHBaR2NG?=
 =?utf-8?B?ZTVOU2NyYko1VlJoYXl3RHd6SUE4djU2QW80KzdPZFNDU214RkM2N3loY0xH?=
 =?utf-8?B?NXV5VjhGbXE5ZnBDQjF1NkF3QnBaaDUwaU1ERXJ2OHV0MlNRSjhPY0EyMFZF?=
 =?utf-8?B?cjdUUzAvMkNvSG95MlZQZnpKSndiRWJpQWtuVVhMLzV5ZURCTXZhU2xCc2Jt?=
 =?utf-8?B?aFdiQWlrODN1TFNQMGl5Rmw0TDJpR0ZGaXRZNHhBQ2VKaitBK3R4MHdlWWdS?=
 =?utf-8?B?Q2VxbWxwWkFsc2ZnYnNLSjh5eDFYS1ZoK1Z1NFVKaUNtTllBeUhINVJROG1p?=
 =?utf-8?B?L282U2dTTVhTM2pIck4vZWQyOGMvWHBCc3F2a09xQWNxR3hNYUpNOXdWTndj?=
 =?utf-8?B?R0ZwVlZyYmk1WW1JMGxXR0JYc1B6dGtxSjd2dExzZHdKUHUwVkRndm1lcGVO?=
 =?utf-8?B?WVZTNnpCZ1d0ZVJGWktVdUVIL29SdWxHQ1pkZDJqajBLMXpqQk9yV3dQK3ov?=
 =?utf-8?B?Um5xcXhYSThkbFdyaVJYbTBPSjcxOUVIUE9ZLzkrUmgrK0VvME50NXorc0xL?=
 =?utf-8?B?M0FXaUZZZ0VpNzY2TE50QkR4YW10Y2FVaENPcEVhdHNBaXlCZm5pR3V2YVFT?=
 =?utf-8?B?Z0V1T0NjSjNlTGw1dDNuaHhBVTcxVEl3L0hIQmkwcEhjdFRTKytVdk5uNG1u?=
 =?utf-8?B?cG5hUjVIMmIybyt6aGRzTy9iSE0rcEczaWNOeURac2RlK2FWWCtEcWFYRW5X?=
 =?utf-8?B?b2g2M0hHV3R3eVRtYWx5U3J2b2Myd0M2Z1U4RUpMa0MwSWNWUFdtb0NlYnpj?=
 =?utf-8?B?eDYyNUltYnhFZERXRXlieXhiN0JUN2xOSGl5S1RWZGRWSTc5ci9odVB6bHp3?=
 =?utf-8?B?SVJYWThJeXNVTGZDeVJHUXRGaXQrVjIyOWthT2d1WnRsODlCdk1QbXBjWkYy?=
 =?utf-8?B?c1RDNUU2U1JWL0g1ZjA5b0VUa254UzFPUUtHT25UakRSc2QxajZnSnpBOWNX?=
 =?utf-8?B?Ykd4blIwME1nai9GbU8wYzFxeWljSFF1QUVxN3FxSENrd21TaGQwb3NyRFll?=
 =?utf-8?B?SWtSSGROZTl0SVhlVW0ybDlhSE94TG9xNjdPMzJMTlBQNTlyN0tUTFhqWk1L?=
 =?utf-8?B?YnhXMUE1TkUwaUNRUVNZdldaNU0xK3ZwV3pIMEpQUWpUcWs2YUdLWnBUMTlZ?=
 =?utf-8?B?dE5BVEc4Um81QW1xckZ4V1k3b3JJZ3gwZThqMEZMWEM3STU3OUUyZCtaWHo2?=
 =?utf-8?B?VzZpQ2M0M2dxK1JJM1dkcDUxSjdzL2pOcDNtS0ovQVJOcG5CUGZjQjFNUTI5?=
 =?utf-8?B?YjNFVmpOQ0xLL2M4V1dsck82RmVRdlBiSGVBRVhwNXoyd3ZRNW5kbit3MXVw?=
 =?utf-8?B?amU2V2lzRG9Oa2o4UW50a2hQSE5JNmZWalN2YWNOenl5aHptOW9ZYUxIQUN6?=
 =?utf-8?B?TEJOZWd5cGd2SUZjMzgvNjFUZExjRzFwRjlsWkRjaWZmWFVVbThCbkN3VlF2?=
 =?utf-8?B?R09lUmpLQnZkNzlneU1zWExTRjBFUVFTNitxTzlDWXhnVE1JVUhwTU9ZbXJL?=
 =?utf-8?B?OGFxVGRneTNUbUFzS1JZb2doc2o3WDJxU1JsclA5dndqWm1EOHpETXlzVGxE?=
 =?utf-8?B?YzZqMzRrcGhPZU9nZHU5WUxuWTl2TFNXbEM5aEZ4RjFsdGxIVDFpTjhJQUxY?=
 =?utf-8?B?YXp3WlMwRjZrbDIrbk4rVmtoWEMxWFF4UUVGa1hnSVpiMzJkSlp3NlZjZ29Q?=
 =?utf-8?B?MHU2aXplWkw4Wit4T0lzZWxxU1lOdVNhdnArZG14dmxUUldXelllaVRmbVYz?=
 =?utf-8?B?Tm85WUh0UkJZdzlJdWhTbkRNQ3VTK1RKZzdPMlgrSE44OGQ0NVpLbUp0VmN0?=
 =?utf-8?B?Y0NIM3M5czJuTjE2MDFnekZ1c29xUTIvNllhQnYyYVhHU0VKMG5iTW00WVl0?=
 =?utf-8?B?cmI1b2pibC9ZYmVFd1JJZllsR0g2Mlh3Nlhjdm9FeDhzditscWNTdWRSd3hC?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 466722a2-ac1e-4995-6497-08dc7bfbdf4d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 14:14:49.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uEQuiTD9oBNDrfyTRosE50Mh9v1POEkdfb9oS9j3cUErEtUOlOTzCNeR6YPJlWJqerDBTtSi1VLzI1lR45dooyLyk2F5Q2AoMmKtXwtiO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9311
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 14:15:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16253

SGkgTWljaGFlbCwNCg0KT24gNS8yNC8yNCAzOjU3IFBNLCBNaWNoYWVsIEx5bmNoIHZpYSBsaXN0
cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiBZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZy
b20gbWx5bmNoPWhpLXRlY2huaXF1ZXMuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcuIExlYXJu
IHdoeSB0aGlzIGlzIGltcG9ydGFudDxodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb24+DQo+IEhpIGFsbCwNCj4gDQo+IEkgaG9wZSB0aGlzIGlzIHRoZSBjb3JyZWN0
IHBsYWNlIHRvIGFzayB0aGlzLiAgSSdtIGluIHRoZSBwcm9jZXNzIG9mIHVwZGF0aW5nIGZyb20g
eW9jdG8ga2lya3N0b25lIGJyYW5jaGVzIHRvIHlvY3RvIHNjYXJ0aGdhcCBicmFuY2hlcyBhbmQg
cmFuIGludG8gYW4gaXNzdWUgdGhhdCBicm91Z2h0IHVwIGEgcXVlc3Rpb24gYWJvdXQgeW9jdG8v
Yml0YmFrZSBkZXBlbmRlbmNpZXMuICBNeSBub3JtYWwgd29yayBmbG93IGZvciB1cGRhdGluZyBp
cyB0byBzdGFydCB3aXRoIGFuIGVtcHR5IGRpcmVjdG9yeSB0cmVlLCBjbG9uZSBhbGwgb2YgdGhl
IGxheWVycywgY2hlY2tvdXQgdGhlIHNwZWNpZmljIGJyYW5jaCAoc2NhcnRoZ2FwKSAgZm9yIGVh
Y2ggYW5kIGRvIGEgZnJlc2ggYnVpbGQgb2YgY29yZS1pbWFnZS1taW5pbWFsLiAgVGhhdCBhbGwg
d2VudCBzbW9vdGhseSBleGNlcHQgZm9yIGEgY291cGxlIG9mIHJlY2lwZXMgaW4gdGhlIG1ldGEt
aW50ZWwgbGF5ZXIuICBBZnRlciBtZXNzaW5nIGFyb3VuZCB3aXRoIGl0IGEgYml0IGFuZCBub3Qg
ZmluZGluZyBhIHNvbHV0aW9uIG9uIG15IG93biBJIHBvc3RlZCBhIG1lc3NhZ2UgaW4gdGhlIG1l
dGEtaW50ZWwgZm9ydW0uICBUaGUgcmVzcG9uc2Ugd2FzIHRoYXQgdGhlIHJlY2lwZXMgSSB3YXMg
dHJ5aW5nIHRvIGJ1aWxkIGFyZSBub3QgY29tcGF0aWJsZSB3aXRoIHRoZSB2ZXJzaW9uIG9mIGNs
YW5nIGZyb20gdGhlIHNjYXJ0aGdhcCBicmFuY2ggb2YgbWV0YS1jbGFuZyBhbmQgdGhhdCBJIG5l
ZWRlZCB0byB1c2UgdGhlIG1pY2tlbGRvcmUgYnJhbmNoIG9mIG1ldGEtY2xhbmcuICBTbyBoZXJl
IGFyZSBteSBxdWVzdGlvbnMsIGZpcnN0LCBpcyB0aGVyZSBzb21lIHdheSB0byBmaW5kIG91dCBp
ZiBhIHJlY2lwZSBkZXBlbmRzIG9uIHNwZWNpZmljIHZlcnNpb25zIG9mIGl0ZW1zPyAgU2Vjb25k
LCBpcyB0aGVyZSBhIHdheSBmb3IgeW9jdG8vYml0YmFrZSB0byBpbmZvcm0gdGhlIHVzZXIgd2hl
biB0aGVyZSBpcyBhIHNwZWNpZmljIHZlcnNpb24gZGVwZW5kZW5jeSBpc3N1ZSBpbnN0ZWFkIG9m
IHRoZSByZWNpcGUgc2ltcGx5IGZhaWxpbmcgdG8gYnVpbGQ/ICBUaGFua3MgYW5kIG1vc3RseSBq
dXN0IGN1cmlvdXMuDQo+IA0KDQpPbiBhIGxheWVyIGxldmVsIHdlIGRvIGhhdmUgdGhpcyBtZWNo
YW5pc20geWVzLiBNYWludGFpbmVycyBvZiB0aGUgbGF5ZXIgDQphcmUgc3VwcG9zZWQgdG8gcHJv
dmlkZSB3aXRoIHdoaWNoIHJlbGVhc2Ugb2YgWW9jdG8vT0UtQ29yZSB0aGV5IGFyZSANCmNvbXBh
dGlibGUgd2l0aCBpbiBMQVlFUlNFUklFU19DT01QQVRfPG5hbWUgaW4gQkJGSUxFX0NPTExFQ1RJ
T05TPiANCnZhcmlhYmxlIGluIGNvbmYvbGF5ZXIuY29uZi4NCg0KaHR0cHM6Ly9naXQueW9jdG9w
cm9qZWN0Lm9yZy9tZXRhLWludGVsL3RyZWUvY29uZi9sYXllci5jb25mP2g9c2NhcnRoZ2FwI24y
MiANCnNwZWNpZmllcyBpdCBpcyBjb21wYXRpYmxlIHdpdGggc2NhcnRoZ2FwLiBIb3dldmVyIGl0
IGRvZXNuJ3QgbWVhbiBpdCdzIA0KY29tcGF0aWJsZSB3aXRoIGFsbCBsYXllcnMgdGhhdCBzdXBw
b3J0IHNjYXJ0aGdhcC4NCg0KQXMgZm9yIGEgcmVjaXBlLWxldmVsIG1lY2hhbmlzbSwgSSBkb24n
dCB0aGluayB3ZSBoYXZlIHRoaXMuIE9uZSBzZWxlY3RzIA0KdmVyc2lvbnMgb2YgcmVjaXBlcyB0
byBidWlsZCB2aWEgUFJFRkVSUkVEX1ZFUlNJT04gaWYgdGhlcmUgYXJlIG11bHRpcGxlIA0KdmVy
c2lvbnMsIGJ1dCB0aGF0IGlzIHNldCBmcm9tIHRoZSBnbG9iYWwgY29udGV4dCwgbm90IGZyb20g
d2l0aGluIA0KYW5vdGhlciByZWNpcGUuDQoNCkFzIGZvciBwYWNrYWdlLWxldmVsIG1lY2hhbmlz
bSwgd2UgaGF2ZSBzb21ldGhpbmcsIHNlZSAiKG9wZXJhdG9yIA0KdmVyc2lvbikiIGluIFJERVBF
TkRTIHZhcmlhYmxlLCBidXQgdGhhdCB3b3VsZCBiZSB0b28gbGF0ZSBhbHJlYWR5IGZvciANCnlv
dSBhcyB0aGUgaXNzdWUgaXMgdGhlIGJ1aWxkIGZhaWxpbmcgYW5kIG5vdCBhbiBpbmNvbXBhdGli
bGUgdmVyc2lvbiANCmJlaW5nIHB1bGxlZCBmb3IgcnVudGltZS4NCg0KSSBkb24ndCBrbm93IHdo
aWNoIHJlY2lwZXMgZnJvbSBtZXRhLWludGVsIGFyZW4ndCBjb21wYXRpYmxlIHdpdGggY2xhbmcg
DQpmcm9tIG1ldGEtY2xhbmcsIGJ1dCBpZiBtb3N0LCBtYXliZSB0aGV5IHNob3VsZCB0aGluayBh
Ym91dCAxKSANCmRvY3VtZW50aW5nIHRob3NlIGxpbWl0YXRpb25zIDIpIHJlbW92ZSB0aGUgY2xh
bmctbGF5ZXIgcGFydHMgaW4gDQpCQkZJTEVTX0RZTkFNSUMgDQooaHR0cHM6Ly9naXQueW9jdG9w
cm9qZWN0Lm9yZy9tZXRhLWludGVsL3RyZWUvY29uZi9sYXllci5jb25mP2g9c2NhcnRoZ2FwI24y
NSkgDQp1bnRpbCBzb21lb25lIGZpeGVzIHRoZSByZWNpcGVzPw0KDQpJJ20gc3VyZSBtZXRhLWlu
dGVsIHdvdWxkIGJlIGhhcHB5IHRvIHNlZSBwYXRjaGVzIHRvIGZpeCB0aG9zZSBpc3N1ZXMgYXMg
DQp3ZWxsLCBzbyBmZWVsIGZyZWUgdG8gc2VuZCB0aGVtIHNvbWUgYnVnIGZpeGVzIDopDQoNCkNo
ZWVycywNClF1ZW50aW4NCg==

