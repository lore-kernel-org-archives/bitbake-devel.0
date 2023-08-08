Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA8C001B0
	for <webhook@archiver.kernel.org>; Tue,  8 Aug 2023 08:53:58 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.57130.1691484833371130433
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Aug 2023 01:53:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=fPgfA70w;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7584e0cf5b=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3786q37F002937
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Aug 2023 01:53:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=QE7CtWKoIIf5R5J0AeUHZ9wPDr3XU960dWds5ajnI4Y=; b=
	fPgfA70wVzy9dzPj16dvlBZXUXTU9b+F8q+IYYRpLwuGKTiAHZ40XpJfKHWkMBTt
	f/AGZimHhhhcKvA5mQ4IZmUMy6boxsFn8x/HKkxo7qKdImIwmP3e0wKrTPwjivku
	OHjqxPm7K9VEDg89aTOWjDP2z2R2HxeIiN3PBL3Rfo6jTs4WkWV0Y35ge9qm/ntt
	f9W0TgiZmh7FiJNsYC3fT858vOIA2rsmneg0HHOLrYoxaGpImCnRgEz3mGQuGjOH
	OuTdns+sbSC2t8Wl2Rrn7iyPTayqfcox72NIpx+ivd/RIGQBr1oxP53dQ7yx2g0i
	pWrBZWkjEh73PmLVSvWnrQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9nxfj3ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 01:53:52 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 3788rqBW012613;
	Tue, 8 Aug 2023 01:53:52 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9nxfj3cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 01:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDc/9FeanwjD5GET7x6JJR0PfCqZ4wOMmmpISqv2Ufq93u77fldFWlSEYdmNI1p253FdRmoscdLr13rkIz6uRHYotuTmNR4UaujfibHmVfgwbSbhrMdvnmBhmgmXO9tnnXB2PcUkPviCOvCkBK1b4/JOHa1lZyGLGFxLCBMpqBT/xw+y9ZAlqs4pcoMsLTMerktFgkJbBfRgTGMF+2mv0Ux8uCENI9DsSl5bFlkOuOn+nyQ6IrzqhXAHm+/r5BXM9iWcAVSVwupy/qrfjsftppREiE6aUOCLyTNFWHTj5RYIlXk75B49gMyyBpmv7SfO3O1lQHejbKryn1H1+9dOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE7CtWKoIIf5R5J0AeUHZ9wPDr3XU960dWds5ajnI4Y=;
 b=Spdc6ep0Qx40pnEzSx4SPke8hvkKgO86wo/zw3URfjF2oDgvXSPZwa8pu3JZwrrepbshz67pf7YmLZ6YP9JSTdoVHtw4JWYy9wxkHj1McT8NLZJHkxGgy8JYC/4XSsPvzEkh0iKNcIhm880jvaPaF4SnntMXalnJT1bV+x3wgRxJuiynWt5LS7QGfIrSOzgCmP4csKQpiIg1kKQCjcS6+kg1uVRsra4k/9Gweu4gEfwxJbDoQBmqpcoyrVvGBTvT+DuPy9WmHRzSg0fOcBicO1eX810ELG9Wa/WwUCw4TwtmhyokG1NTPVs+3i3+AE0I8AMCk5JbMPbUo590Fwnk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:53:50 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:53:50 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: "Chen, Qi" <Qi.Chen@windriver.com>,
        Richard Purdie
	<richard.purdie@linuxfoundation.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
Thread-Topic: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
Thread-Index: AQHZxeASrO2VB6BZf0euz/CiEGifbK/e232AgAEQZ5CAADNfAA==
Date: Tue, 8 Aug 2023 08:53:50 +0000
Message-ID: 
 <CO6PR11MB56026E369192F6F2BEF2F3DCED0DA@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230803075638.2355913-1-Qi.Chen@windriver.com>
	 <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
	 <1c7bfcd4-3880-55a0-61d0-06d934d3e98a@windriver.com>
 <eb48693137116c26346d2eb07d726022d3525f50.camel@linuxfoundation.org>
 <177952C9153B6115.10230@lists.openembedded.org>
In-Reply-To: <177952C9153B6115.10230@lists.openembedded.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|CH3PR11MB8381:EE_
x-ms-office365-filtering-correlation-id: 2f349318-795b-44bb-8113-08db97ecfc29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qPG5IhXZ9RBniy80S1lHACgcVCyAF1FoVQrG5uaaaJW1ixYI4e+Tl5izsCGbovTI1JlBfuG9tNLcPLoWHrM6D2iUm1e5zadveYejJvAG/X+j5610waT6nGXnd6FplKngD2lPuhTrCvW8UfWl7Yj/G4tL6ifzWbFvBdFIZFWWaYMQswsDpm2m9vU9tzXsxbMr1Ccp/RoDFZrB+1EsH6MvRxCaBI0McZ+LEXuNZ9O4v+MR25MAIa8fz0HlbQvp0vbU3iAGJOXTTr7M8h84aQ6WojlkHyVh6BVfh6gpZETwA7KhifmR/3eaVgTwjrqwaBlyIBrlyN1MYPPbRsa5OG0EIDuNBgRwTf+/0Nh/hjmRIiAk1QucUnUtI7Ay2yKrsintVoax8ohq20ou6JmYPMjj/vsjWE60aVqEG8pjhYPBvoN2P9t8uQvfNzKyhpoaQiMFuxYXLCZkbGvkEBT4eRJnAVCAQkY3SRuzcDTSXy3G/Jgj8+aFlsJ0g7nGa2VVxioKjMKkv9wXojtCQlCHbR1RLUBjYzanJWobWH7yEAguiNMVfx9Tw62FIpB22h3B1y/2SJYDSJNUhqVZX5zBR7ycmA+1o1dH8Q1ZfvvCpWXWZP97TfEP4F6xSyVis5Iud5dtZsspb1HF06xm9eg15YmdLw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(186006)(1800799003)(451199021)(6506007)(26005)(53546011)(9686003)(71200400001)(7696005)(966005)(122000001)(478600001)(33656002)(38100700002)(110136005)(66476007)(66946007)(66556008)(76116006)(66446008)(64756008)(316002)(41300700001)(8936002)(8676002)(52536014)(5660300002)(38070700005)(2906002)(83380400001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QXVwVmE4bVZ6enBFQ2plV0ZOM01FV3FLRXVoZU9tcjhZY2cxSGQ3OXpoYUtE?=
 =?utf-8?B?RHZPb0x6ZDM2L2xTdE40NUdndzZEVUQ1T2FNTGtUWnczbVRYVmxobWZtU2FQ?=
 =?utf-8?B?WDQxMnN3VG1Pb3RDbGdza3NJdUdWTldSY0dQeExtejZwaEVUOFJBbFZUeSto?=
 =?utf-8?B?QmZoTnhnZ2tlYkl4OW50NTRleVpWcDdCMExJWUZSa1NwNkYyazM3UXY1aDhy?=
 =?utf-8?B?cWc3TVJOcWJMM3FSRmo3eEF0eHFzVGRxcGw2QldIV0hyRUt1NG9lUXAyNm9O?=
 =?utf-8?B?bVYrQ2RTV3lqcTRRbWtmUU8xTnpja216T3VGV2gzVkgxN2RtWFhIbXBKVTY2?=
 =?utf-8?B?b0U0VkZLbU5LcGFoK2lZRDJPYTU2d2RaYkNGS3U2S2VBOGkvSENIcnFGcXFK?=
 =?utf-8?B?MzkyUUFEQzMyZFZUNTRFOGhQa2dqY3N1MXQ3T1ZEWjB2emlnc205OXVMOVpp?=
 =?utf-8?B?Q3h3dnU3NnNUTDFQZHhtV3dRQ1NweWhQb3FEVHp3ZDdpZGwwOS9aeXViT25Z?=
 =?utf-8?B?c1hqb0JZbGRKajlnaXFjNXdqK3QzbXB0V3NwaWhUQjd0TWhsUTdZbnhtTUht?=
 =?utf-8?B?TG50eFpzRXNxMEwwMU9PYVZEQWdWdUZxUGhBSysreHZLOWd0Y2wxblRwWWd4?=
 =?utf-8?B?V0tyeWZvU1dQL3Q5SXVLTGhjUG1DM0h2c2t0akRnak1paEMxQVg0RU1Qd2pY?=
 =?utf-8?B?a2hjTU9ueXRJWHFrSHF3WXlNNzlLTkI3ZWpPT0RaZGlTT0RMSUQ1TVNENjQr?=
 =?utf-8?B?b1lDWElkMjFoU0FESDJEMkFGWE9sbWNRTUxqZml4VjZ6Vlo4eENNbURWdGM3?=
 =?utf-8?B?V1Vwd2g0WlZoeDZta2JXay84M0IyeEllY01WY21ZbFo2TTR1ZWpJOXVCMXBJ?=
 =?utf-8?B?TzZndUh2U2pSN3lZVEZWbnNETWg3aHh1YklEaU9XUVdDa3V4QlNxamlrV1dF?=
 =?utf-8?B?OFNPZkdva01LQmZsY3VzT1QwVjdiclBQWHgxbitscFVLdmE4Zy8yY3NaTkFE?=
 =?utf-8?B?S2RaclVQZ3lYYTYxdGp0d2RYQm5VUWE4czUzako0UllTK2F3aDlwakxXNE9l?=
 =?utf-8?B?cnVoK1VrUFZzRDVwREpDTXpUUGpyTS9JRDZiN09jMXRpSk50YVppcVNMS1pz?=
 =?utf-8?B?WkV0WnBORjgxU0xsbk8wRUxaS3E0U0F6WCsraWpZM1RyUWFBTUVXTWFucDVM?=
 =?utf-8?B?NkpkT2JFbFlNNm15L1B1VW83Ry9DcFBzM3I1c0sxdGx2R2JWTnNQWWJXa3dB?=
 =?utf-8?B?ZG5NaEk1V093U2ZHaU9aSUIwU2RkRlVjRHUzU01SU2Ewbk1JRVBYVmhzbUl0?=
 =?utf-8?B?aWQxME0rdEdrMk5FR2EvOFZCL0xzTWVEdUF0T2dHNjlJV3lPbktWZU1sMGF4?=
 =?utf-8?B?VXpBa20rd1dKb1RHVGZpRW1IdFNlOUpseTNsdnpERmRSZVh2R2tuN0JGOXFZ?=
 =?utf-8?B?NXdVakdLazVDVjJuc2wyMHJsR2JoU1lzRzZSeVF4cUQ4cXVyakJUay9adnhV?=
 =?utf-8?B?eks0VWUzV1oveW96S3A2dnA2YjdjSmZraVBjaHpIUU5CbnlBdHBIb09Mb3RQ?=
 =?utf-8?B?TEJ5K3pYR2dsMTVTZGF2UFJpcE4vb2l1aVJvVlNDSjFIRzRhajNXc2M0K2hE?=
 =?utf-8?B?RlhEQ2daNTBseFp1YzlOcnlERDNPL0VOY0R5bzR0ZmhOYmI1bGwxTG1XVi94?=
 =?utf-8?B?SmYzMFErb0puYUxwZ01Ibjc2NmJ1V2JIMmhRekVvWEI4cSsxWlIzOTdkZUps?=
 =?utf-8?B?eVF6Ump6Q2ZYby9La015M0pvaDVsSTZUaE9SZTJDTjhZcmdJMWNzdm13Nys3?=
 =?utf-8?B?Z0VldHh3Z2RxOE5Ea0plVERYdkhRbitPemhydTVNVkoycEhvQTZ1MFJqODkv?=
 =?utf-8?B?Z1NCRVRpb2pRZldzSm0yNVBUYW5lYzF6N1pFeG5kb1ExOEF1dEdxa0JhSC92?=
 =?utf-8?B?YXd3UHVRWExWdnpyT1J6VVcyWmpmMUhISFFBbE9wc0Jxa0U3aS9EWnRwVGU0?=
 =?utf-8?B?M0JMa2t3eG43RlgrL3hPL1Z2Y0Uwa2Q5LzJWNzg2OStqREFGN1NnMURtRVdX?=
 =?utf-8?B?SUhQc2JTM084bUt3Q2tldEViVzcrcUNUMDRkT2pGcnNUeTZpeThDdHQ1eWYy?=
 =?utf-8?Q?6eYP/k/4Ay62uUc1qAG7NxDlI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f349318-795b-44bb-8113-08db97ecfc29
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 08:53:50.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iOd/EX5KmgiCDxc6t2U3jims//hDpZQGMBM9OP3ZrDR7hV8/DRkaV6jy1pin8kWht/4moCt+SveyRu+Eltd/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-Proofpoint-GUID: UjmTQ1eUotQ9lkceLWV8vBFZEuJa5eGV
X-Proofpoint-ORIG-GUID: RmoOa-oxExywu6yr8aqkD6HL4Lay-RF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_07,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2308080079
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 08:53:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14926

SGkgUmljaGFyZCAmIFJhbmR5LA0KDQpJIGZvdW5kIHRoYXQgdGhlIGN1cnJlbnQgY29kZXMnIGFj
Y3VtdWxhdGlvbiBsb2dpYyAoYnkgYWNjaWRlbnQpIGNhbiBsYXJnZWx5IG1pdGlnYXRlIHRoZSAw
IHJlc3VsdCBwcm9ibGVtLg0KVGhlIG9ubHkgdGhpbmcgdGhhdCBuZWVkcyB0byBiZSBmaXhlZCBp
cyB0aGUgY2FsY3VsYXRpb24uDQoNCkhlcmUncyBzb21lIHJlc3VsdHMgd2l0aCBleHRyYSBsb2dn
aW5nICh0aGUgbG9nZ2luZyBjb2RlcyBhcmUgcmVtb3ZlZCBiZWZvcmUgc2VuZGluZyBvdXQgcGF0
Y2gpLg0KDQpXQVJOSU5HOiBpb19wcmVzc3VyZTogNjcwNDYwLjI1MTkzNzUzMjc7IHRkaWZmID0g
MS4xMDAyNzU1MTY1MTAwMDk4DQpXQVJOSU5HOiBpb19wcmVzc3VyZTogOTkzODc1LjM5MTk5MDk4
NjM7IHRkaWZmID0gMC4xMDE1NzEwODMwNjg4NDc2Ng0KV0FSTklORzogaW9fcHJlc3N1cmU6IDk5
NjIwOC40Njc2NjA2NTE0OyB0ZGlmZiA9IDAuMjAzMDAyNjkxMjY4OTIwOQ0KV0FSTklORzogaW9f
cHJlc3N1cmU6IDk5MzY0Ny41NDcxMjMyMjAzOyB0ZGlmZiA9IDAuMzA0MzMyMjU2MzE3MTM4NjcN
CldBUk5JTkc6IGlvX3ByZXNzdXJlOiA5OTQzODQuMTE0OTg0NDM7IHRkaWZmID0gMC4zODQwNDI3
Mzk4NjgxNjQwNg0KV0FSTklORzogaW9fcHJlc3N1cmU6IDk2NzA4OC4xNzU0OTg5ODM0OyB0ZGlm
ZiA9IDAuNDkxNjUzMjAzOTY0MjMzNA0KV0FSTklORzogaW9fcHJlc3N1cmU6IDk3MTgyOS45MzI0
NDgzNzgyOyB0ZGlmZiA9IDAuNTk0MjM1NjU4NjQ1NjI5OQ0KV0FSTklORzogaW9fcHJlc3N1cmU6
IDk3NTMxMy4yNjU4MTY3Mzg0OyB0ZGlmZiA9IDAuNjk2NzgzMzA0MjE0NDc3NQ0KV0FSTklORzog
aW9fcHJlc3N1cmU6IDk3MDUxMi45MTQ5MjMxNDUxOyB0ZGlmZiA9IDAuNzk5MzU2Njk4OTg5ODY4
Mg0KV0FSTklORzogaW9fcHJlc3N1cmU6IDk0OTY0MC40OTM3MDg5OTUyOyB0ZGlmZiA9IDAuOTAx
OTIzNDE4MDQ1MDQ0DQpXQVJOSU5HOiBpb19wcmVzc3VyZTogOTE4MzI5LjE3MTk5NzYyMTg7IHRk
aWZmID0gMS4wMDQ1MjU0MjMwNDk5MjY4DQpXQVJOSU5HOiBpb19wcmVzc3VyZTogMzEyNzY5LjIw
NTE1ODAzNjI2OyB0ZGlmZiA9IDAuMTAyNjY5OTU0Mjk5OTI2NzYNCldBUk5JTkc6IGlvX3ByZXNz
dXJlOiA0MDU0NDAuMTM3NzExMDgyNDc7IHRkaWZmID0gMC4yMDU0Mjg2MDAzMTEyNzkzDQpXQVJO
SU5HOiBpb19wcmVzc3VyZTogNDMyOTEwLjYwNjgyNDI5NTY1OyB0ZGlmZiA9IDAuMzA4MTYyOTI3
NjI3NTYzNQ0KV0FSTklORzogaW9fcHJlc3N1cmU6IDQ0MjE1MC4xNjU2NDA1NTAzOyB0ZGlmZiA9
IDAuMzc5NjYwNjA2Mzg0Mjc3MzQNCldBUk5JTkc6IGlvX3ByZXNzdXJlOiA0NTY0MTIuMzI0OTcx
NDQ3NDc7IHRkaWZmID0gMC40ODc0NDA4MjQ1MDg2NjcNCldBUk5JTkc6IGlvX3ByZXNzdXJlOiA0
NTkzOTEuNTc2Nzg0NDc1MjsgdGRpZmYgPSAwLjU5MDI4MjkxNzAyMjcwNTENCldBUk5JTkc6IGlv
X3ByZXNzdXJlOiA0NjQ1NDQuMjk0MTk4MDYxNjM7IHRkaWZmID0gMC42OTMwODEzNzg5MzY3Njc2
DQpXQVJOSU5HOiBpb19wcmVzc3VyZTogNDU5Mjg1LjUxNjk2MTg2OTk2OyB0ZGlmZiA9IDAuNzk1
ODA5OTg0MjA3MTUzMw0KV0FSTklORzogaW9fcHJlc3N1cmU6IDQ2MDY5NC4xNzI0NTk3NDMzMzsg
dGRpZmYgPSAwLjg5ODUyNjY2ODU0ODU4NA0KV0FSTklORzogaW9fcHJlc3N1cmU6IDQ2MzM2NS43
NTA5Mjk1MTU7IHRkaWZmID0gMS4wMDEyMzkyOTk3NzQxNw0KV0FSTklORzogaW9fcHJlc3N1cmU6
IDQ5OTI5MS4zMDA1MzMwNTE7IHRkaWZmID0gMC4xMDI2OTM1NTc3MzkyNTc4MQ0KV0FSTklORzog
aW9fcHJlc3N1cmU6IDQ5ODg2OS44MzQ2MTk0MjA0OyB0ZGlmZiA9IDAuMjA1NDA0MjgxNjE2MjEw
OTQNCg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBi
aXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZz4gT24gQmVoYWxmIE9mIENoZW4gUWkgdmlhIGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmcNClNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA4LCAyMDIzIDE6NTYgUE0NClRvOiBSaWNo
YXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz47IE1hY0xlb2Qs
IFJhbmR5IDxSYW5keS5NYWNMZW9kQHdpbmRyaXZlci5jb20+OyBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcNClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF1bUEFUQ0ggVjRd
IHJ1bnF1ZXVlLnB5OiBmaXggUFNJIGNoZWNrIGxvZ2ljDQoNCkhpIFJpY2hhcmQsDQoNCkkgaW1w
bGVtZW50ZWQgdGhlIGxvZ2ljIHlvdSBzdWdnZXN0ZWQgYmVsb3csIGJ1dCBJIGZvdW5kIHRoZSAw
IHJlc3VsdCBpc3N1ZSByZW1haW5zLg0KSSBhbHNvIGNoZWNrZWQgbXkgc29sdXRpb24gc3VnZ2Vz
dGVkIGluIHRoZSBwcmV2aW91cyBlbWFpbCwgYnV0IHRoZSAwIHJlc3VsdCBpc3N1ZSBhbHNvIHJl
bWFpbnMuDQpTbyBJIGFkZGVkIG1vcmUgbG9ncyB0byBjaGVjayB0aGUgUFNJIGRhdGEgYmVoYXZp
b3IuIChJIHJlYWxseSBzaG91bGQgaGF2ZSBkb25lIHRoaXMgYmVmb3JlISkgTXkgc2V0dGluZyBp
czogQkJfUFJFU1NVUkVfTUFYX0lPID0gIjEiDQoNClRoZSByZXN1bHQgaXMgYSBsaXR0bGUgc3Vy
cHJpc2luZyB0byBtZS4NClNlZSBodHRwczovL2dpdGh1Yi5jb20vQ2hlblFpMTk4OS9wb2t5L2Js
b2IvaW8tcHJlc3N1cmUtbG9ncy9jb25zb2xlLWxhdGVzdC5sb2cNCmFuZCBodHRwczovL2dpdGh1
Yi5jb20vQ2hlblFpMTk4OS9wb2t5L2Jsb2IvaW8tcHJlc3N1cmUtbG9ncy9pb19wcmVzc3JlX2dy
ZXAubG9nIHdoaWNoIGlzIGRlcml2ZWQgZnJvbSAnZ3JlcCBpb19wcmVzc3VyZSBjb25zb2xlLWxh
dGVzdC5sb2cnLg0KDQpUaGVyZSBhcmUgbGluZXMgbGlrZToNCldBUk5JTkc6IGlvX3ByZXNzdXJl
IGlzIDUwNDQ4LjAwMzk2OTg4NDQzOyB0ZGlmZiA9IDEuMDc4MTM5NzgxOTUxOTA0Mw0KV0FSTklO
RzogaW9fcHJlc3N1cmUgaXMgMC4wOyB0ZGlmZiA9IDEuMDE1MDY4NTMxMDM2Mzc3IC4uLg0KV0FS
TklORzogaW9fcHJlc3N1cmUgaXMgNTA0NDguMDAzOTY5ODg0NDM7IHRkaWZmID0gMS4wNzgxMzk3
ODE5NTE5MDQzDQpXQVJOSU5HOiBpb19wcmVzc3VyZSBpcyAwLjA7IHRkaWZmID0gMS4wMTUwNjg1
MzEwMzYzNzcgLi4uDQpXQVJOSU5HOiBpb19wcmVzc3VyZSBpcyAxMjQyMzYuNzkwMTU0NDExOTQ7
IHRkaWZmID0gMC45OTk5MzcyOTU5MTM2OTYzDQpXQVJOSU5HOiBpb19wcmVzc3VyZSBpcyAxODYz
NDYuMjY4MDEzMzU1OyB0ZGlmZiA9IDEuMDAwMDIwMDI3MTYwNjQ0NQ0KV0FSTklORzogaW9fcHJl
c3N1cmUgaXMgMC4wOyB0ZGlmZiA9IDEuMDAwMDg5ODgzODA0MzIxMw0KV0FSTklORzogaW9fcHJl
c3N1cmUgaXMgMC4wOyB0ZGlmZiA9IDAuMDc4NzQzNDU3Nzk0MTg5NDUNCldBUk5JTkc6IGlvX3By
ZXNzdXJlIGlzIDAuMDsgdGRpZmYgPSAwLjAzMzQwNTU0MjM3MzY1NzIzDQpXQVJOSU5HOiBpb19w
cmVzc3VyZSBpcyAwLjA7IHRkaWZmID0gMC4wNDkyNjE4MDgzOTUzODU3NA0KV0FSTklORzogaW9f
cHJlc3N1cmUgaXMgMC4wOyB0ZGlmZiA9IDAuMDEyODE2OTA1OTc1MzQxNzk3DQpXQVJOSU5HOiBp
b19wcmVzc3VyZSBpcyA1NDk2Ni43NDk5ODA1MjUxMjsgdGRpZmYgPSAwLjExOTM2MzA2OTUzNDMw
MTc2DQoNCkZyb20gdGhlc2UgbG9ncywgSSdtIHN0YXJ0aW5nIHRvIHdvbmRlciBpZiBub3QgdXNp
bmcgdGhlIGF2ZXJhZ2UxMC82MCBQU0kgZGF0YSBpcyBhIHJpZ2h0IGNob2ljZSBpbiB0aGUgZmly
c3QgcGxhY2UuDQoNCkJlc3QgUmVnYXJkcywNClFpDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRp
b24ub3JnPg0KU2VudDogTW9uZGF5LCBBdWd1c3QgNywgMjAyMyA5OjMzIFBNDQpUbzogQ2hlbiwg
UWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT47IE1hY0xlb2QsIFJhbmR5IDxSYW5keS5NYWNMZW9k
QHdpbmRyaXZlci5jb20+OyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNClN1
YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF1bUEFUQ0ggVjRdIHJ1bnF1ZXVlLnB5OiBmaXggUFNJ
IGNoZWNrIGxvZ2ljDQoNCk9uIE1vbiwgMjAyMy0wOC0wNyBhdCAxNzowNiArMDgwMCwgQ2hlblFp
IHdyb3RlOg0KPiBPbiA4LzYvMjMgMDE6MjksIFJhbmR5IE1hY0xlb2Qgd3JvdGU6DQo+ID4gT24g
MjAyMy0wOC0wMyAwMzo1NiwgUWkuQ2hlbkB3aW5kcml2ZXIuY29tIHdyb3RlOg0KPiA+ID4gRnJv
bTogQ2hlbiBRaTxRaS5DaGVuQHdpbmRyaXZlci5jb20+DQo+ID4gPiANCj4gPiA+IFRoZSBjdXJy
ZW50IGxvZ2ljIGlzIG5vdCBjb3JyZWN0IGJlY2F1c2UgaWYgdGhlIHRpbWUgaW50ZXJ2YWwgDQo+
ID4gPiBiZXR3ZWVuIHRoZSBjdXJyZW50IGNoZWNrIGFuZCB0aGUgbGFzdCBjaGVjayBpcyB2ZXJ5
IHNtYWxsLCB0aGUgDQo+ID4gPiBQU0kgY2hlY2tlciBpcyBub3QgbGlrZWx5IHRvIGJsb2NrIHRo
aW5ncyBldmVuIGlmIHRoZSBzeXN0ZW0gaXMgDQo+ID4gPiBoZWF2eSBsb2FkZWQuDQo+ID4gQWdy
ZWVkLCB0aGVyZSBpcyBhIHByb2JsZW0gYnV0IHdlIGRvIGhhdmUgdG8gYmUgY2FyZWZ1bCB0byBu
b3QgYSANCj4gPiBtYWtlIHRoaW5ncyB0b28gc2xvdyBzaW5jZSB0aGUgZ29hbCBpcyB0byBoYXZl
IG1heGltdW0gdGhyb3VnaHB1dCANCj4gPiB3aXRob3V0IGhhdmluZyB0b28gbXVjaCBjb25nZXN0
aW9uIGFuZCBjcHUgc2NoZWR1bGluZyBhbmQgSU8gbGF0ZW5jeS4NCj4gDQo+IEhpIFJhbmR5ICYg
UmljaGFyZCwNCj4gDQo+IElzIHRoZSBjb25jZXJuIGFib3V0IHRoZSAxcyBibG9ja2luZyB3aW5k
b3c/DQo+IA0KPiBJJ20gdGhpbmtpbmcgYWJvdXQgbWFraW5nIHRoZSBibG9ja2luZyB0aW1lIGNh
bGN1bGF0ZWQgZnJvbSB0aGUgDQo+IGN1cnJlbnQgcHJlc3N1cmUgZGF0YSAmIG1heCBzZXR0aW5n
IHZhbHVlLg0KPiANCj4gVGhlIGlkZWEgaXMgKGN1cl9wcmVzc3VyZSAtIG1heF92YWx1ZSkgLyAo
Y3VyX3ByZXNzdXJlICsgbWF4X3ZhbHVlKS4gDQo+IEluIHRoaXMgd2F5LCB0aGUgYmxvY2tpbmcg
dGltZSBpcyBpbiB0aGUgcmFuZ2UgKDAsIDEuMCksIHRoZSBiaWdnZXIgDQo+IGN1cl9wcmVzc3Vy
ZSBleGNlZWRzIHRoZSBtYXggc2V0dGluZywgdGhlIGxvbmdlciB0YXNrcyBhcmUgYmxvY2tlZC4N
Cj4gDQo+IFdoYXQgZG8geW91IHRoaW5rPw0KDQpJIHdhcyB0aGlua2luZyBvZiBzb21ldGhpbmcg
YSBiaXQgZGlmZmVyZW50Lg0KDQpJZiBjdXJfcHJlc3N1cmUgaXMgbGVzcyB0aGFuIHNheSA3MCUg
b2YgbWF4LCB3ZSBleGVjdXRlIHRhc2tzIGFzIG5vcm1hbC4gV2hlbiBwcmVzc3VyZSBpcyA3MC05
MCUgb2YgbWF4LCB3ZSBjYW4gaW1wbGVtZW50IHNvbWV0aGluZyBsaWtlIGEgMC41cyBibG9ja2lu
ZyB0aW1lIGFuZCB0aGVuIGZyb20gOTAlIHRvIG1heCB3ZSBjYW4gdXNlIDFzLg0KDQpUaGUgaWRl
YSB3b3VsZCBiZSB0byBvbmx5IHVzZSB0aGUgZGVsYXkgaWYgd2UncmUgY2xvc2UgdG8gdGhlIG1h
eGltdW0gcHJlc3N1cmUgdmFsdWUuIFdlJ2QgbmVlZCBzb21lIGV4cGVyaW1lbnRzIHRvIGRldGVy
bWluZSB0aGUgcmlnaHQgcGVyY2VudGFnZXMgYW5kIGJsb2NraW5nIHRpbWVzLg0KDQpIb3cgZG9l
cyB0aGF0IGlkZWEgc291bmQ/DQoNCkNoZWVycywNCg0KUmljaGFyZA0KDQo=

