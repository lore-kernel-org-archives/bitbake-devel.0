Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1608CC76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 15:27:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.96.67])
 by mx.groups.io with SMTP id smtpd.web11.161507.1680794842802723063
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 08:27:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector2 header.b=lqWeTEDz;
 spf=pass (domain: infinera.com, ip: 40.107.96.67, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqKjiEnOVGYFW8mWfMAYAwJ1Z+zr8V8WNSTEnCU5uz1xRgslwa29Ko+hh7nAjy5q0I1kVLYl/2OZ80Qbg6Of5k7ZCvt2c1o3q2mqWT3fFOzQnDKZOsPJt1uk6KjOcTb5YSyTx6oMF/8Zv++gy6CZ1TOs2LpnTPsCQHbIkEiKh+4GyQSfI/owy+SzhslumtjJUnMv5ukxcF4D2C3B9WQpcrutsvDvY+mwFviPHwE/JKUJNInKsjxpaHPlLKHyLRjOv2Vqyh1mrg5I2M25zQEwRQSby7pwAf1s9qt84swdiS/Mp4U3UR+WJyPZVLJ5aJkhjH9SpNtZr6GZMGWnzsvRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4lQqHxMzE1ShVeWoaMTCCmpDbX5UqzA7xMNFKhGFdo=;
 b=POHMuB7UjBIC+L43PbZ9ziC12zjCvJ6U9vYnlqq/fcj5dVFDQnFa32KdeY0hi+BFXrATYCfbiKHmoK7D28u8gwz/dwgFySJ6pHzw4SilOafuGp9TgVjNT+EdzfkhCvCZ7j+ePi2hf7ln/iaBkBNsafjao3GfMDmr13FjuwfOvsWvRWrZ9j4ro+V32HY72xvxKQjQJAJbcdfTp/2CdBZ3sXGnYZFOpoUN+71ZE3h9IFfq0QoFhQPHFv2c4MliU4Ty2lYvhcT8P+WSLh+DqWVHIuLWUyC3lpy2FFJNGdkM7bzl1GHoWM3kqnfk2SYfX0pWDagRx0yeGtAESzBVmElDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4lQqHxMzE1ShVeWoaMTCCmpDbX5UqzA7xMNFKhGFdo=;
 b=lqWeTEDziKrzNLGwEbH0lOgNcWTvLBkpbTDoPjmAftyemRmyaGMcPKZxsxwcfWA2T0D4t4W3N3MlP8wLgk1AuB1lVt8yIjh8ikI38CvEWnaZqDKbmqpqJLK1NTSdwRiV0Fg7BixnECz4e3Qxiha+lOuW2n5MAKIzy4dg6Abf0RUZptwB3Yad0xpRIpgqbONx6K3DKfwvziyml+6qq+OR+diWid5Gtgbp43mPTGE5l8Kr4m74zpxUh6gDCHBUIVChIOHgJYmfQ3RHTBDBMzYkQ/Czi744wOcYabxjfoCGCUQG8vXA3slBdjjMgzQ/9mbTaWyYXwNAMzRHQWNE3gqXng==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB5659.namprd10.prod.outlook.com (2603:10b6:510:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 15:27:18 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::75fa:a159:8722:b9f9%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 15:27:16 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Kirkstone : vs _ bugs
Thread-Topic: Kirkstone : vs _ bugs
Thread-Index: AQHZaJxFssg02YsUk06H5mCpUXx13w==
Date: Thu, 6 Apr 2023 15:27:16 +0000
Message-ID: <3bdf71527c3afcae7cd303826a3b59a52e28cc96.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|PH0PR10MB5659:EE_
x-ms-office365-filtering-correlation-id: 3a431506-c4c6-4868-78c9-08db36b36798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xFHd90F4at0LWD2igBLKOU4Hxr/N5teng5qDYTK2j03mlH1RYhUG73K82oJYtN4YB2VMkdMjSXUnd1FeQCDj3ZpFSTeG0nfj4wnVo83Qhc39utSvuKBnq9TIenN+FYBorGTNcqmmdBbm22VvPLRxMuou3aLAckL5YqCv1ol9gC4P2pTk3P0kIX3ba5kTwr9JhEkJZOlvTSmoxtosJarRn7brrJc2di/2hgjtyNBK+B7rvb6aIb6D3/h4YtKSFhK5JsN6kVLXDThip/asl7pSf1h73j2Y7rIYfu3P2k98fjUuotamNlXf4D0qMgHAGgVBfKIC2W7O3Be+4xFrJDsBNhvHvUjScbTen5nxjbIo0R6Er8RTEs2aCxEOBUi+B777dWayCw/AnpbIqydhUl9ko0QPsyNMFZL+kIsoVPwWknZd88ia5oQMjudHkuqGScao7fmA5OlhAj2qQamuIGrw9L1z/SbMTnKOGN7kcewaGiek/k3xN/F9NiH58ISjHvOtT5vUY1zYI3RTfq4v8cmA58hZ8NETValYBME+Cyl1ZZaY+tx1nAG5RPK7cM+ybKzCPQVfdVCr8TYm80Di3kds+X/O669tIH+svU3U6tEgV7Ok325NQYBpdED+fIJku098
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(71200400001)(6486002)(36756003)(2616005)(86362001)(38100700002)(38070700005)(122000001)(6512007)(6506007)(186003)(91956017)(66556008)(8676002)(66446008)(66476007)(6916009)(66946007)(316002)(2906002)(64756008)(41300700001)(8936002)(4744005)(5660300002)(76116006)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YzBmcnB5QjJzMkh2QnIzbmZQU3VNMEZacVA1MmFMaEdzdDdNVW9NdXVGQnZk?=
 =?utf-8?B?cmR5SW5kSTRUT2F2RG5oSDZBbGFpbG9JYXlLTG41ZzZ4c1lVSGU4ZVAzdnJM?=
 =?utf-8?B?cEM5OTlGanlWK0k5c2NqMkVHZWIxalpWb2JRdG9mZytPRmFlS0c5RVpZUk9S?=
 =?utf-8?B?S2tvbEhRUVNobTZCM2o4SnNmemZTUG9rUDltTERmR0N2dnJIU1h0OTJhQTRu?=
 =?utf-8?B?a1A0dWI4OTVqR09GV3YxRVBqZm5pOE43R3cvdTlRa21Lbkw2UVV4c2Q3VmU3?=
 =?utf-8?B?b2h5NVFnbjR6VHZncWZjVFYydXVkcW9nYm1zOU5uZWkwNW54aWZIUUxRcWw5?=
 =?utf-8?B?Q1JxOFFOaEpZaUZwSFlMMWxoeFFweTVSR2FGcTdzaWxTN0NpZC9hd280QkZo?=
 =?utf-8?B?b01aSTdnb1ZJZVpQY0hvMnVRdDZ4L3BpR0RCTjU1bEJtNmV3eG1QQko4VzJp?=
 =?utf-8?B?UUs4SjF2Mnc3SWdFOGVuSHBRL0tIYWQwWHZ5WDZjUThUdm1rTVRwYVdyQlhl?=
 =?utf-8?B?dEtBd25KcVNyTHdmQ0RiNE5BMnEwR0J3bWhGd0ZJeXFlZVgwRTNLdkZFdFJq?=
 =?utf-8?B?OFduTmRUY0t5WGJubFRuUW1pMlpTb3dNb2lJVUJtL0xXNmFQUWVNNFByR01H?=
 =?utf-8?B?c1RqeFBtRXpveXFxb0I4eGVWNDRNaHZPdmNHRXZzTVJKcisyQmNSWSs5MndF?=
 =?utf-8?B?a0JnV05KMmtVVlE0MExGdHJjS096ZU5ZOGxZeHQ1Nk43dldXTE5GeXZzSTh2?=
 =?utf-8?B?dmdDem1ncjQxaVRJL2Npa1BOSEFaTjhBY2FGNDlwRXZlSDRheUg3aDlxMTla?=
 =?utf-8?B?MkNjQXJxWmV1ejJiNHFraWlKN0lOeVUrbWg1azIxUlVMZ2FpMzBQTnNYMXNX?=
 =?utf-8?B?cmlrNWRTV0RNa2xCa0FTZU50aVhkRXV5UytLRHE3VWNycHpvQTFuRHY1VjhF?=
 =?utf-8?B?bHpRWEY4WEoyVk9RazFjbjBodFBXZVgvWnpKQW1tTHJEVGJoT3pPakcvZzU4?=
 =?utf-8?B?ak03Qk5IRDd4Uzd2QlllaTRSdmlDZVdhM2R6NjUwaGcvWmVYUnZRaS9iNWRp?=
 =?utf-8?B?c2pGdDVTYWdSeit3anZ1eUJFR0hneVgvVEhjekJpVXlQbm9acmdkc1ptSGlR?=
 =?utf-8?B?Q2lTMHk2SEowYy9Kc1VHU1hpbkc4T3o1a3ZpUGtFR0dCN2ovZTNyVEpHR0k5?=
 =?utf-8?B?TEZicC9UMjJreitoTGx5cnd1S0liQkliR1cwaUt5V2N4NlZiS0txMndjUVBF?=
 =?utf-8?B?dy9qTFF2TWgydlF5MEovVlIvV3Y2NEZnU3FxU3R0MUZUMHRYS2E1cjV6QWtV?=
 =?utf-8?B?dFFUdEhmTm1mUTFkT0Z6V3ZoRzJTQVJ0a3B0bmVTOGI0OG0yRE9hc2pSbCsx?=
 =?utf-8?B?NUpSUDRzQ1pHeVBoellmWnVzNTdwMFNDY0tMRENocUhtUUgycGNjTWJJTUt1?=
 =?utf-8?B?d1BRRjNkNGVLRUl3elJsZE1kN0JvYnE4YkEyNDkvYlptNnJVTjVDbkRPcXpC?=
 =?utf-8?B?d3M1MFU1Wk1CNjV0M2hJaWZDdXUzU2s3V1J5SVJyaWRjR1BkdHhiMHlpOTFh?=
 =?utf-8?B?cjFrbTJTa1gxRDJjRERidTd0clVlSFdZMEZDMURESUw2dW9hZEVVR25SUlQw?=
 =?utf-8?B?VUxoY3RjMktJWGIrRVVKalZ2N2JlMzF2N1R3YnRmMnU5WlVKZ2FjOUMzT0xP?=
 =?utf-8?B?TjRTWjV5TEMvZ3VwellWdzIzcU05TkUvZUNvZlBVNXpLSFJZOVhWTXdMbkNH?=
 =?utf-8?B?TFpja2xxUTlKMStFWEtsd0hDVEJDQ01zQ0NnbXpPekNSRnd0bGNaekhWRVhw?=
 =?utf-8?B?VmRrbEJsT3V5WG5TZlFQRHZLeStKTkJKYlNoRWRTNGg0Z2VXTUYya21QOE5r?=
 =?utf-8?B?TGpkNy9SVVhBQzFwQTRsdTF5TkxJRFNnd0FwMjFnZmY5TDVTU0t2QkJiVzI1?=
 =?utf-8?B?T3JmVDlQYzhRN3VoU0Z0V0s3eUcrcjJXNlU0UXBDWnNLbWw0eiszd3VIV0ls?=
 =?utf-8?B?eUkvMnQyTjJSRlAyMGlTc3gwWXVhMXNCdlEvaiswUzd6TWJkK0h6K2RsQ2gr?=
 =?utf-8?B?eG4yMlZyWFdobnQ1cERxdVhDVXNpWWJpLzBuV3l2NW1zQ0x6QnI4M0xnU0RU?=
 =?utf-8?B?azE0OVN2bzd0dU1DWmlDTmpDTUJRcFJ4UUlZekQvU0dOVWp5VFU4SDFyZ2hJ?=
 =?utf-8?Q?jt5LdMA/JJcP3tVGMuSNkhVksPFYCTMkPG6rg4pcAc25?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B05E24183FF863499E241D6EC8E187B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a431506-c4c6-4868-78c9-08db36b36798
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 15:27:16.7752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NuuP4CyGA6ZDH6gQZwGkmKwTcUH/Nci6P0E7Xs+w3egZhq6dRZe9rcIf831UYNxBb0trJEdFOjyR5DACrd92Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 15:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14678

UG9ydGluZyB0byBLaXJrc3RvbmUgSSBzdHVtYmxlZCBvdmVyIHRoaXM6DQogIFBSRUZFUlJFRF9W
RVJTSU9OOnh5eiA9IDEuMi4zDQpkb2VzIG5vdCB3b3JrIGluIEtpcmtzdG9uZSBidXQgd29ya3Mg
aW4gRHVuZmVsbCwgbmVlZCB0byByZXBsYWNlIDogd2l0aCBfDQoNCg0KRklMRVNfJHtQTn0gaXMg
c2lsZW50bHkgaWdub3JlZCBpbiBLaXJrc3RvbmUsIHJlcGxhY2luZyBfIHdpdGggOiBtYWtlcyBi
dWlsZCBoYXBweSBhZ2Fpbi4NCg0KSXQgaXMgdW5jbGVhciB0byBtZSB3aGVuIHRvIHVzZSA6IHZz
LiBfIGluIFlvY3RvIGZvciBLaXJrc3RvbmUsIGlzIHRoZXJlIGEgbGlzdD8NCg0KIEpvY2tlDQo=

