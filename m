Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05372C6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 20:21:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.57])
 by mx.groups.io with SMTP id smtpd.web10.113228.1680639694981119522
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 13:21:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector2 header.b=Bf1gClSA;
 spf=pass (domain: infinera.com, ip: 40.107.244.57, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt2hfkDklvl2TkxAehLYOcIApk0SLDliqsdfB11ZbK4YvKSB44SJ4n/HapuSgrG7KeWzjng+GFUCUgymw/lIgGkre6d8+LYIn7WZMiIJL+koXu3wTbl+yjuC4HB06yMNn4lUQ8G0FZgqwsCU2yjGBoI4MuznaYUgSMQ1w5JD/x8V+diWH5tRKU8T0oieRh1/wrlesoctle/YfWFW+35YWogXaPwhMolQkTZ3weCU5bLltlzfDXVSbzwSsJ8h+rVxLUpxZepJYERDvySDaM46ddrrCtxwCUQAo8jLBUZEhwh01JQBb3iv0+61Z9MG4qgVzm28r/a8AEKLscVtbhSSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t57f+jDIsOuyHWkmSLmv9yP/X69I8qBPWSnRWkgCY4=;
 b=dD8wIp4Y0eR+1g7p0JM8VOzjiSPIKw9ZLRkPNN2b2gTt3aPjDoKckxmpo8Bd+DrFLElOSwf4Wittc1m3IbK4SAJblQc59PYs2XfQvlqg30Q+Jq9ccpDNLIf8ZM4+hlnLJAOx3QmMLP5UW0PQ3mmgfnq8OkUMWLCbT3BN4rdSWzKdqq3fk415mzbL+vTECpte8stXe6+P5ir4v7WHBhZXzcWPpTeG7tuT0fnwaOvOfpEx5XQ/6IrspBNM9WlCxDftXlDyfdVofI/97jzeADNHRlTFETHqnqmWrGw6SoYxylDdgCxKZ9cd9miZrOESuKDjRip3919xGl1S7AJ9Dc02xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t57f+jDIsOuyHWkmSLmv9yP/X69I8qBPWSnRWkgCY4=;
 b=Bf1gClSAftT3zgWJo5M7tSWX/3g/Wln9UlFTjaHpI779uepe7dOaW455N7LAk6mkP6+zZRx5gnpng6+D2b/G8SWdEZRB3bXKkE9I/Z1uX304TSgPmixHOoL4TwJBBRv3itq37gQUZz7z3TCV3APlBp76TS0NwXiP/v3ClFrS/uHGeXtPS0KCGTI5mEQ70g345gB5sjT3uq8BppxZLsNrasgTbVBnPljbmMoBvZyc11+WuRl1Iz/Q76xWynJCtitG6ynP6qjyOezfsVtXeEjuljXBlt78h2zbEa/1ps43pdiiyc+04rhhzN6QJM7ffp6KUhUZP3iOQQTowrpeY+Sknw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SJ0PR10MB6351.namprd10.prod.outlook.com (2603:10b6:a03:479::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 20:21:31 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 20:21:31 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: building python-inflect ?
Thread-Topic: building python-inflect ?
Thread-Index: AQHZZzMLji7qD3GRKECuFCU/tl240g==
Date: Tue, 4 Apr 2023 20:21:31 +0000
Message-ID: <43210b1ce3260a74b29f28db3125aad206612ac9.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SJ0PR10MB6351:EE_
x-ms-office365-filtering-correlation-id: e9758edc-097b-435c-e935-08db354a2dee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HCpUhKygki0mRtMB90Qa5aTzJfxx/0dhy9V6p3oWBzvhLMj1P0b9yHqMOYdsrA4v2Ao54bmYMWJACfPn8Q7JptBV530yOu6rtAgkTCEEd0kOfyyt5F+Sfsdpnwr3SmQFndvCPSQqA+2MoVpc22oaY9AoNDTMjEJ3c7iyVgroH5zz90+GbgA1DHdzCtN+upcnazT6XOxvUWm45d6cADiuQTcNgnxBzZiPdfDavzlt1kYXTLYeN6xaRZ2WnjiX6i1vdnqP2IGfsbCAf5iVZ68icOpLXCMS2kUtlUXe+ukEGyMOdXVKscD1f5dzB5790pXKB/Ivf11zxabnaKUtv8nbJ9PLsHRAVwDovoz9LiiE6Oe/PSGefX9lxNPeUTJEWHTOopZwPiR5F+khB/PrP2zQufQaY8KHOIPIrKNBoW6KgiyQ4XUkls4YhIz13hosDZo0cFgA5lv7pwHS0Ko56ZQ9tdMbroPMD8i9U3AqnbB5Xwh1SQIkhJJ3tqIEoOfi/LuhjLT02F8/r8oVkaQ3O+3IIICv+TSSy5tfiwrLttOy8k0xUSatfJPc/PqCYA1Oi2H+CwQnLQV2McuUgnu/KWwStnGmx+O97XUoxSOTA1ALbWk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(6512007)(6506007)(186003)(2616005)(6486002)(966005)(71200400001)(3480700007)(5660300002)(86362001)(122000001)(41300700001)(8936002)(38070700005)(36756003)(38100700002)(478600001)(66476007)(76116006)(64756008)(66556008)(66446008)(66946007)(91956017)(6916009)(8676002)(4744005)(2906002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TDVnc2c1WFpPbFhHSm82ckJmOHJVVHduRUlPNzJFc3FLZFBKMkI4a0JhSjNu?=
 =?utf-8?B?MmNNY3lUSmZYWTE3TkI3QVJRQitFbkM1MTgrWGpmNEdsWThsWTBxZmhIZkJL?=
 =?utf-8?B?SWJEWjFFOXFnQ0dIVTF2aE1VaHBpSnRBVnFjNDdCcjAxeGtoazhJOHpzbnZl?=
 =?utf-8?B?YklsWUxtQ2ttL2U2MHplWmdoenlWREo2SnhGcmQ1c3hOK292ZVNtNGRYNEZ2?=
 =?utf-8?B?S2JJNDZtVVVMZ3pCZW1QdDJaR0k1TStqbkcya2RrOHp5YVRFNWpLbGQvU2ov?=
 =?utf-8?B?cGdJSkgwdFE1TGY3VVJ3bXo3RldzWGNsWVRsWFFGMENzcUVvcWIxU2M1TGkx?=
 =?utf-8?B?NlAyc0lXaE9BZXFnbHNWSUd4ZHlpUTN6L3B2L2s4SnRlaG9lVGxTWHQrWVVy?=
 =?utf-8?B?THE5QndQYzNMcHRnejcwendvZERvL2o4azN5OVNZTFBLdkxBZ0tWZndTYUpX?=
 =?utf-8?B?WjJXK1VWN24wYUUreDB5K0tHSHVrdERwK01OZDVwVUg0ekpvaHpITWp4MTNv?=
 =?utf-8?B?MXZGYTJJTEY2WkJGeVUrRFpidStDb1pGODI3NVlheHp3N2xMaDVMMTliek5T?=
 =?utf-8?B?aHZ2bGVvZVMxOUpjT05uc2RzRHhNdGlxK2o2TSt2Vk5lck90VzlUSjA1R1BN?=
 =?utf-8?B?NmZWZXZKM24ydmtYeXdKQm5HZE9YWEhrS1VJbkNsTTF1ZGNFRVZLUElZOXNS?=
 =?utf-8?B?MmNtOXQyTnF6aDN0ZERRTHlhREQyYzVtbFZqb3lPU3daYk9TL3djM3JtS2dG?=
 =?utf-8?B?TnVNYnJhVU11WVlDUkNBV1ErRDl1NXBWQTdHbURhcTBUd0pOa3FablJCd3Bx?=
 =?utf-8?B?dlk4eUkrdXFRK09kWVYyRE9wR1JNLy9VbjRFWTZ2WUFJTEplMUI0OGQybi9J?=
 =?utf-8?B?NTNVZWhkWklqWEJ0L0d2YjRuZm9LTktLWkVXWVJhczdxcmVrUEV0T0VTYitW?=
 =?utf-8?B?Unc1YVZnVHNwZGp3TUQrSHJkbmhTN25GZjdSVGFBVlIzdEFTanlwakJJaDM4?=
 =?utf-8?B?UTJaOWlEYTJYRE42eVlXU1d5cXN4ZHFER2JkVGpsMWJNY0gwQ01vcWVSL2Nk?=
 =?utf-8?B?aVdYSmJ1akdZd0R0V2Y1TFRta0FHSU4wOE1Vb1VILzYwakVNcUJUNEV3V1Ev?=
 =?utf-8?B?UGJiSXF4OFlKNUhoZGwvOGxqZ0k0V1dnRVJJOVRQWEFxeHNSekY1RkxuV1g5?=
 =?utf-8?B?WFFHeFdjaE05UklUa3ErL2V4cGRPS0wrR1F4bVo1dVE1YnpvWEhDVForTE1o?=
 =?utf-8?B?Q1RFNGJlRklCVy91TklnN2VNa21QRG5SblVLbUJ0ZjlrZ1J4UVM1NmV6V2Jy?=
 =?utf-8?B?Tm9POGMrNjc1TSt5N3Y1Q0dEaExMVTZKZ2U4bGFHTjJJK21PRUVpOWw3RDZZ?=
 =?utf-8?B?Tmh0WUxKTm9ReER2UEFrd3d6bEFFaTJaUmkwcGNuWllqSWFYd05IODgwTEZV?=
 =?utf-8?B?WnpZei9xYm9GbUlaU2Ztd2phL0NDSHR1cW5LVjF2U0pPdTVaR01seTJQbTVU?=
 =?utf-8?B?YVNTMnByZG1zTzlIM1hHSXNJNTVxQ2JaK2pweWttK1RBRnBJWFAzZHJNcjJ6?=
 =?utf-8?B?Tms2Um1sMkVCekFxeG5ta3ltR0kxQ3V0eU03a0MzSDcrekUwVmwwS2VSRStS?=
 =?utf-8?B?OHRGeGF5ckpDd2hnVVBwOW43SnMrbEtUODN5eWIvdVhHWW15bWJHUGxneUhS?=
 =?utf-8?B?QS9EVHM1aXFyZTQwcTR1L1NIQW1NckoyLzZMR080eGIvaWJYTlN6RFZPaGNQ?=
 =?utf-8?B?U2o0UlFHUEY3em9XQmhlR0s1YzNnOU1JYWxKcEdGTjNXT3UxUlQwZVRqNXVW?=
 =?utf-8?B?dXUvQlVicWNTOUpNeXdqUzZJcXJTZmY3SVBUMk1tVHRlSXNIVUFzNFFyLzVF?=
 =?utf-8?B?bzM0MW1YQ1RFZzJKNk0vMGtXM2JSUVZIakdiMTVQVmExMUJkTmVhMDVLZnZu?=
 =?utf-8?B?cXJqRnZaUVVIejR6RXBxcnVZb1VYM3lvY0V4Z3NyRHBvLzBsalMwbWE1R1VZ?=
 =?utf-8?B?NTFwWjdLWGlzRUMrQVJzaUVRWndXakFRelB5RWpEUE9iT1Bvd0JUdjh6YURO?=
 =?utf-8?B?UzdiV01oUjFna1V4cVRqbHBwOFNWdFAreGxFQTNFbEtKUHduT0FkVFFYdVhm?=
 =?utf-8?B?eGJ3bGZWWkxSMEg2VTNXNHpVYzBxOWRxVDZFNDNaRkFQRjV0OGpESThzbkhH?=
 =?utf-8?Q?nm+ABJYmze8cdYf0P3J84iRv7zDP4UWUq8tH3KNyofOI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E3DF7805C4084EBBAB20601751ECC5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9758edc-097b-435c-e935-08db354a2dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 20:21:31.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMI8dda0e7BQiQG9VWSiSe6opWPBlszjaa3IrJ0dCq3mUP1Y0Oki/O5RoCP6CGnXmbUPvt3AlJ1QX1qZdlaqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6351
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 20:21:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14634

VHJ5aW5nIHRvIG1ha2UgYSAuYmIgZm9yIHB5dGhvbi1pbmZsZWN0LCBodHRwczovL2dpdGh1Yi5j
b20vamFyYWNvL2luZmxlY3QgYnV0IHRoaXMgcGtnDQpkb2VzIG5vdCBoYXZlIGEgc2V0dXAucHks
IG9ubHkgYSBzZXR1cC5jZmcNCg0KSSBkbyBub3Qgc3BlYWsgcHl0aG9uIGFuZCBjYW5ub3Qgd29y
ayBvdXQgd2hhdCB0byBkbywgSSBnb3QoY2FuIHNvbWVvbmUgaGVscCBtZSBmaWxsIGluIHRoZSBt
aXNzaW5nIHBhcnQ/KToNCg0KU1VNTUFSWSA9ICJBIHBvcnQgb2YgUnVieSBvbiBSYWlscycgaW5m
bGVjdGlvbiB0byBQeXRob24uIg0KSE9NRVBBR0UgPSAiaHR0cHM6Ly9weXBpLm9yZy9wcm9qZWN0
L2luZmxlY3QiDQpMSUNFTlNFID0gIk1JVCINClNFQ1RJT04gPSAiZGV2ZWwvcHl0aG9uIg0KI0xJ
Q19GSUxFU19DSEtTVU0gPSAiZmlsZTovL0xJQ0VOU0U7bWQ1PTJmYjZmYTFhNmYxNzkyZDc4ZGUx
OWFkMWJiNjUzYzMxIg0KTElDX0ZJTEVTX0NIS1NVTSA9ICJmaWxlOi8vTElDRU5TRTttZDU9N2E3
MTI2ZTA2ODIwNjI5MGYzZmU5ZjhkNmM3MTNlYTYiDQoNClNSQ19VUklbbWQ1c3VtXSA9ICJlN2Fh
ZDhmMTYxZWU5Yzg1YzdkMTI1YWY2OWFlNjYxZiINClNSQ19VUklbc2hhMjU2c3VtXSA9ICJmMWE2
YmNiMDEwNTA0NmY4OTYxOWZkZTFhN2QwNDRjNjEyYzYxNGMyZDg1ZWYxODI1ODJkOWRjOWI4NmQz
MDlhIg0KDQppbmhlcml0IHB5cGkgcHRlc3QNCg0KU1JDX1VSSSArPSIgXA0KCWZpbGU6Ly9ydW4t
cHRlc3QgXA0KIg0KI0RFUEVORFMgPSAicHl0aG9uMy1weWRhbnRpYyINClJERVBFTkRTOiR7UE59
ID0gInB5dGhvbjMtcHlkYW50aWMiDQoNClJERVBFTkRTOiR7UE59X3B0ZXN0ICs9IiBcDQoJJHtQ
WVRIT05fUE59X3B5dGVzdCBcDQoiDQoNCmRvX2luc3RhbGxfcHRlc3QoKSB7DQoJY3AgLWYgJHtT
fS90ZXN0X2luZmxlY3Rpb24ucHkgJHtEfSR7UFRFU1RfUEFUSH0vDQp9DQoNCg0KUkRFUEVORFM6
JHtQTn0gKz0gIiR7UFlUSE9OX1BOfS1weXRlc3QiDQoNCkJCQ0xBU1NFWFRFTkQgPSAibmF0aXZl
IG5hdGl2ZXNkayINCg0K

