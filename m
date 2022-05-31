Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262A0C433F5
	for <webhook@archiver.kernel.org>; Tue, 31 May 2022 01:38:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web08.44208.1653961124202663716
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 May 2022 18:38:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=kgk+thBb;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=3150dfc232=david.reyna@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 24V1c2Ke001857
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 May 2022 01:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=185RyTqdrRg0gGAiBN3OIJta94hKmDsJfSaK1ALTqls=;
 b=kgk+thBbp6JLxSIuePRVhE9xFqOEnaUfbgg1EYxKAsKKeVxyZlMGKIAh2BOCNInopgGR
 /FEe+N1/8Q6GSJQCD+fGQvmOwAWuIYwf3RoOw3HL9L0QZ3QrCdMWaPM97uq2yYJtN8nd
 vc0dhIwsYt9GAvXNwvHjuz+hk/6oUKkG3ZmWLVh+meUngMtlva8QYWpJSLs+825/b7dq
 lVtZkObpEEggqu0S9FIW8elKGkkH94iKEOjwyF3TBo5yl+0siZwDyBVJlDfj8Acwt6pW
 Sw58HtDMY+/xOmHiuLoVK8eaUslnNwsfsjVSmFSNI4/4gaE7m3HlQvoxsXWU+9LrOgUj sw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gbbxk9pch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 May 2022 01:38:43 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24V1cgvS002061
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 May 2022 01:38:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gbbxk9pcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 May 2022 01:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPn8503V/MvY4/0LRxWtZgneqbUO6BS4VBLut10vQQvm13RsnZruBbV/sOsQSh2LRZvgaua/ImDlu3DBpms8RqwusK5zPCeNoY8nLWJrA2O1kMYFyDjApvTKzUkhYq64w5Xqy0knMRZFUUqOlY5cyZZ7xS/bcfac4FjnfCTkvDwaeXp+USeOFm+p5VLWsYr7mA6A+/eOGPzjldrqdLSa85S/kSeU4Py0Ob21f/c35PvA3P72cOTZVqFJNDGBXuwHau5XsSZ3ENqQTGDIrkHU4uyZu8qDMY2HoOmbmGBm/QfhFNJsG6PynfuF44BWem1opO4cwWBOa3BUpx6jad2jCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=185RyTqdrRg0gGAiBN3OIJta94hKmDsJfSaK1ALTqls=;
 b=fmiYA9xAwkHhJWMwJxlXEvVnrrstp9l658UbW5nNweI46Fy3dhB/fctJwM6eFdAvi3UWrtex5bSuB1249jvmeHklIeAr+w4eXHmg0e1lEvdxaYsGp+dIMUCfbrR6PW3c/RVAQt5/tBFnU1WYxJ0I79oMI0njw/8YpYojIBLNgucRxszI7TDrt6FcK8Uly0tue6k7cOHQVHUsFduj2eHBEAKdi1nSbYl3SpNnr9RqPCADxro+4LN8Vo0LDg4lHJbDQUPapEB2gK5bW4PPuStgo5r9hQjPNi4sTXYdUB9tngpCcatXmD1CaON5O5RGCictD3yvh4QxGBcTwonZyIs9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by BN6PR11MB1379.namprd11.prod.outlook.com (2603:10b6:404:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 01:38:40 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::996b:4c93:a787:8ba9]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::996b:4c93:a787:8ba9%6]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 01:38:39 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: Jacob Kroon <jacob.kroon@gmail.com>,
        "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/1] bitbake: ncurses version of
 taskexp.py
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake: ncurses version of
 taskexp.py
Thread-Index: AQHYdAEGQwlmvR5wyUGYeAO+AcQ9vq04Mv6A
Date: Tue, 31 May 2022 01:38:39 +0000
Message-ID: 
 <BY5PR11MB416714B8D3BE5CD3A92140AFEADC9@BY5PR11MB4167.namprd11.prod.outlook.com>
References: <cover.1653802954.git.David.Reyna@windriver.com>
 <af83d503f04b2064c8ad0f005fa526185e231619.1653802954.git.David.Reyna@windriver.com>
 <b631915a-703c-28d1-7320-74dcc62c362e@gmail.com>
In-Reply-To: <b631915a-703c-28d1-7320-74dcc62c362e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ca3d5ec-b1de-464f-3f93-08da42a649df
x-ms-traffictypediagnostic: BN6PR11MB1379:EE_
x-microsoft-antispam-prvs: 
 <BN6PR11MB1379E3A577E47B89F16E3A52EADC9@BN6PR11MB1379.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aLwmCvpkXYLLe14QSIhLmT4iWlGOe0ZhkI+K4pntgYPo7rnOp+gAAAnTGOszOQlCFptkkMSOzxi55buXsVb4al8D3tlyXevnUFYw8SnYeEOir0UYES8tLfJ+cgrlcfvnXr9ge7jCqIidznZPhfGfNrtVjtnZrHrmIneHKbsuf7D73uilZl5VZvo3oqSEKeopeQCDu7NvIEmQNU7DZbVKtObnR/yj7ZzzuMVE+aKM54GHWdj7gtnOjSIrV2+M1twK582DCJlAmNdNBI73d0WJiUAoS8L190eTdiY08WFbT1oCog4HSH+Vg9+53tJa4IruE9A9ljmJachPcNCi4lb7jYTeE1B2Cw9lLoRaOMfS8ax/VpMYKUfv+gF6Dz2NtlnystSmf6f34YAtH8kn3rEZU9AWnvBDAlUl09253H9lR43GSGsPMujh1OGH8mnXSiOrHg+7MDug/c2EhQJOhhZh5VnCgQkiD3nqXbuEZXJWm/ehGLW3O1VrAogAY8pj3WCyMkY2K+NIn3F7NT/7SIo1Jiwpx6TYBMwimyGm0c87hgOxd+gul2WxvHH3zHnhhLUCIjn6Uapnhje+87EzBZqE0Dq+Drz8ISA6KYDmn4cULGbMFPsC/qP1EbsngJct9afla+rx9/7VHxLx12wWOV2r2inJrOQQTCtP0Yb/BsgqAYQGAorYfAZELAWgJGpaIf53Y5cuFO9Nqv5zuccbBPp+5g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(33656002)(64756008)(66446008)(66476007)(66556008)(110136005)(8676002)(122000001)(66946007)(76116006)(316002)(6506007)(9686003)(83380400001)(86362001)(53546011)(2906002)(5660300002)(55016003)(71200400001)(508600001)(7696005)(186003)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cHVSaktLLzQ4SStlY2dKNXlNbmdOem5DWnZJTkhLZVQ0bDh3Q3Q0Zm0wSlFJ?=
 =?utf-8?B?ZU8vRmdWM2haOFhENkRzUENKQk40a25DbThKRk1USSt3Nkk2S1ZVakJKcEg0?=
 =?utf-8?B?SVhGSXc2L2FSdFVYYjNlZ1k5NkRwWVFOQlNBdHRicEtFMHBWZTlvRzh1T1Bw?=
 =?utf-8?B?Wmc1S1BGckoycFppNW1WM3BxL28vV3g1Mm1ibmZ6YzluWWhsU2xMYlB0c1ln?=
 =?utf-8?B?eGJjVHJPdEN3T1QvMmhhcitJdEd3bVpZNEJoRDI5NzZRdkRTdU4yQ2gyc0Nl?=
 =?utf-8?B?YzBGZ2FwM0lZLy9SUU0rU1dmMVBTUEdDd3QrbjlrYzZyUTdrVzNqYUhIL3J4?=
 =?utf-8?B?NjdPUzZISTRDWXFkMVVSd1hxSDlTdXpsUEM4ajBrRVhFdE4zcS9ucjFIby93?=
 =?utf-8?B?Yml0b0w0bW1DSExXL1E4NXkzMGREYTMyUFEvNTJTZWlIa2NBbVNVYVJJZmNG?=
 =?utf-8?B?dm5KL1FTQm9Uc2dLS3hSQjBCNXNYVjNHNGxMcWZ6NW9sNEFOTUg5dTB5WHBG?=
 =?utf-8?B?QmlpS1VlZEkzNjlFZFdIMEEvSkpWQzVWcTBiclEwYWlJWVUrcFUra3Erbm1k?=
 =?utf-8?B?d2ZGNjBGcFJBL09kWlVaTGNtdFAyd2tBZ1M4R2VVMEZEMTZzUEZld1k2SWZx?=
 =?utf-8?B?K2xCN3dUVWRJc2k2TUxaKzN3Mi9DdmRPSzd0Y0lub0JYZ1dQejBtdVA0OGhn?=
 =?utf-8?B?bEh6VHJHL2djVU9ZYXdkbllITW03V1RSYzBsUWZmYlB4bEtTZVVmSUIyeFRs?=
 =?utf-8?B?Uy9TclU1VCtlbGhsTVROVzdJU09pcWw2NW5wYWJtOEhLcWdoY3oreGV3MVEy?=
 =?utf-8?B?MENKQlcyaEtadkc0dHR4bDdMNE5GV0dSQzFDbUpDUFBlMFdneW5waVJsa281?=
 =?utf-8?B?OW4wZnRyN3JOTVhrQVVpZFV2cnd5QXJ3K1BkdERyVVZkS3pQUGJKdlNhbHZU?=
 =?utf-8?B?WDMxOGx0L21GN0pwbmtBRWwwRE5SSlFFendlcmRmRlFqVWwzN0ZYYmMxKzZ3?=
 =?utf-8?B?U2k0eVNSdE1Qd0JHM0I1MWJ2Zlo3dnkreFhCMFFwTkVtYmhYZmFSLzlRdzc1?=
 =?utf-8?B?T3ZMYlgxYjNYK2pGbmRlcTBPdnFnNEt4N21LbENvT2dPS0NTNW9RMU5ZdDVj?=
 =?utf-8?B?allnYlVBVkxVSUhTQWQrSWZ5MWJmTUJGYjh3V3dpa3ErbDk3cjk5V3JGQ21Y?=
 =?utf-8?B?N0ZHQ09IQUd3elF4Tm12aDRJN1lLRGM3aVNLMklFUjBDTHYvaWQ0RWQ1TXUz?=
 =?utf-8?B?Y0FmYXZtdWhrWHJOU2thTm1sWlB4ZWV6YzBYMHNxZ2FsTGdMWlQyRzZ5MTVI?=
 =?utf-8?B?eFJweldnZFY5dkc3SFduK2pxRVRHbmh0ZlBzRC85TDMrN2pSYVh4RGlZU1Vo?=
 =?utf-8?B?eHRGQnQxNklkaVhyRDFhb0Z0WUxmcHVRSW5KNXBNejhEQ0dGT1h1R2ZETERv?=
 =?utf-8?B?eXk5QzhwenRZWmNSNG1HcUlQbjFFU2NjOUw3MUlESkRQZERESlRQVjhEQnZr?=
 =?utf-8?B?djB1bFF0WU9jK1JaUmUwUmNqUnBNODdSS01JUVRsQnhZblBzTWVZb0p6VmJX?=
 =?utf-8?B?YzdVQXE3bllMUEZiMUxTcGFVUXplWlVVUWRJY2YrNjNlcDFESFY5NW9Rc2Vv?=
 =?utf-8?B?TGRtOU5JTzVFWTVXNlA5M05BTWZCWjB2aWpiVVJ5ekhtaWNHUUR3YjBJR3Yy?=
 =?utf-8?B?WFcxdUNINFVIWk9PektjZUczdFRLd2F6OGoxdnVYWWswNWN1bGVHakhHU1pa?=
 =?utf-8?B?WTVlS01mRzk4RHNHajU0UFdCdFp6N1NXM0F6NWNMcThvTzhPOEVIcHRabm1q?=
 =?utf-8?B?LzA2eElvLzM5c1R0OHlGdldQWE5wS1l1cVNCWWR5RndlQjQ5Z1U3aUxjMktI?=
 =?utf-8?B?RjNLN1pQVGVDbUVIQzVFQXBlVENmTHRPT2UxMGxoY1dHbDExNVcrbEJpK0oz?=
 =?utf-8?B?b3lEYTYzN1ZmRmVnUDJqcU5wUTU4NnJUME40WUpkSk5WeHdFN2RubUdPZ1JF?=
 =?utf-8?B?SnZxUFVEN2QxV0pkeXcxR1RkZGJSVTBHSzVGMjhxZ0lMdkg3bUNGdGpkb1Jr?=
 =?utf-8?B?cFV4MDdBTkJUSmJRcXRrcE9xK1dMNlVGdXNjOGNOcCs5QUZyaEZueFR6UzBY?=
 =?utf-8?B?V3B6d2dPZ3FUZTRuQkJDaGx6Q2paNFlrc0VudXI3anRiVjRLSTlRUGJpRDBZ?=
 =?utf-8?B?V1dUYURVUDdianBKOVZmeFFmRDcrSkE1MUdmekxwenBpeTIzbUhvNEs5S3Ax?=
 =?utf-8?B?OXdzU1RJWnRXclozV0FVdEs3SnZaTDBuN3I0TG95M2tYZXdWdEluUXdDc2Qw?=
 =?utf-8?B?TEMxVHNzWi9qRzlHV2hGZHZjZUpSQ0VTWGZWZWtCd1k3czFpYlRQSTdPVkVK?=
 =?utf-8?Q?FOvEKazSOXpZBM68o9tQhZSvExIJ7C7V+DVgE6ZP4hRfe?=
x-ms-exchange-antispam-messagedata-1: lE3tQM7B9SadhErez7VDThx2HtA0RKx/Kzg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6ca3d5ec-b1de-464f-3f93-08da42a649df
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 01:38:39.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ac9rSHiD5vuP1O2pRbABTvoJsG4SkL6v2Ydg4b2ilScPhV/Jpnean8ZPEs6pzBt+VwBL7+2RIFR1dWM2lpkpPDU0OUygrCuwJ5YPHSskgoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1379
X-Proofpoint-GUID: JnT9yvBnMB6wJsdvo7SC3hQgk7hOMUQC
X-Proofpoint-ORIG-GUID: XiMG-U5TCtCnnj2DwO6-0P-bxcgSRTPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-30_10,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310006
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 May 2022 01:38:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13722

SGkgSmFjb2IsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBub3RlcyENCg0KPiAiQ29sb3IgZXJyb3I6
IElzIHRoZXJlIGFueXRoaW5nIHRoZSBzY3JpcHQgY2FuIGRvIGhlcmUgdG8gaGVscCwgb3IgaXMg
aXQganVzdCBhIHVzZXIgc2V0dXAgZXJyb3IgPyINCg0KSSBlbmZvcmNlIGEgY29sb3ItZW5hYmxl
ZCB0ZXJtaW5hbCBiZWNhdXNlIEkgcmVhbGx5IGxpa2UgdGhlIGNvbG9ycywgYW5kIGl0IGlzIHVz
dWFsbHkgc2ltcGxlIGVub3VnaCB0byBmb2xsb3cgdGhlIHRvb2wncyBhZHZpY2UgYW5kIHJlc2V0
IHRoZSBURVJNIGRlZmluaXRpb24gKGFzIHlvdSBkaWQpLg0KDQpPbiByZWZsZWN0aW9uIGhvd2V2
ZXIsIGNvbG9yIGlzIG9ubHkgYSBuaWNlLXRvLWhhdmUsIGFuZCBvdXQtb2YtdGhlLWJveCBvcGVy
YXRpb24gaXMgbW9yZSBpbXBvcnRhbnQuIEkgYW0gdXBkYXRpbmcgdGhlIHRvb2wgc28gdGhhdCBj
b2xvciBzdXBwb3J0IGlzIG9wdGlvbmFsLCBhbmQgd2lsbCBtYWtlIHRoZSAneHRlcm0tMjU2Y29s
b3InIGp1c3QgYW4gYWR2aXNvcnkuDQoNCj4gIlRoZSB3aW5kb3cgd2lkZ2V0IHNpemVzIHNlZW1z
IGZpeGVkLCB0aGV5IGRvbid0IHNjYWxlIHRvZ2V0aGVyIHdpdGggdGhlIHRlcm1pbmFsIHNpemUs
IGlzIHRoYXQgaW50ZW50aW9uYWwgPyINCg0KSXQgaXMgaW5kZWVkIGludGVudGlvbmFsLiBJIGNv
dWxkIGhhdmUgYWRkZWQgYW5vdGhlciA1MCBsaW5lcyBvZiBjb2RlIGFuZCBjb21wbGV4aXR5IHRv
IGFsbG93IHZhcmlhYmxlIHdpZGdldCBzaXplcywgYnV0IGdpdmVuIHRoZSBsZW5ndGggb2YgdGhl
IHRhc2sgbmFtZXMgYW5kIHRoZSBzaXplIG9mIHRoZSBkZXBlbmRlbmN5IGxpc3RzIChhbmQgdGhl
IGZpeGVkIHNpemVkIGZvbnQpIEkgZmVsdCB0aGF0IHRoZXJlIHdhcyB2ZXJ5IGxpdHRsZSByZXR1
cm4gb24gdGhhdCBpbnZlc3RtZW50Lg0KDQpJZiBob3dldmVyIHlvdSBjYW4gbWFrZSBhIGNhc2Us
IEkgd2lsbCBjZXJ0YWlubHkgdGFrZSBhIHNlY29uZCBsb29rLg0KDQpEYXZpZA0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFjb2IgS3Jvb24gPGphY29iLmtyb29uQGdtYWls
LmNvbT4gDQpTZW50OiBNb25kYXksIE1heSAzMCwgMjAyMiAxOjQxIEFNDQpUbzogUmV5bmEsIERh
dmlkIDxkYXZpZC5yZXluYUB3aW5kcml2ZXIuY29tPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVu
ZW1iZWRkZWQub3JnDQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCAxLzFdIGJp
dGJha2U6IG5jdXJzZXMgdmVyc2lvbiBvZiB0YXNrZXhwLnB5DQoNCkhpIERhdmlkLA0KDQpPbiA1
LzI5LzIyIDA4OjE1LCBSZXluYSwgRGF2aWQgd3JvdGU6DQo+IEZyb206IERhdmlkIFJleW5hIDxE
YXZpZC5SZXluYUB3aW5kcml2ZXIuY29tPg0KPiANCj4gKiBDcmVhdGUgYW4gbmN1cnNlcyB2ZXJz
aW9uIG9mIHRoZSBHVEsgYXBwICJ0YXNrZXhwLnB5Ii4NCj4gKiBBZGQgdGhlc2UgYWRkaXRpb25h
bCBmZWF0dXJlczoNCj4gICAgLSBTb3J0IHRhc2tzIGluIHJlY2lwZXMgYnkgdGhlaXIgZGVwZW5k
ZW5jeSBvcmRlcg0KPiAgICAtIFByaW50IGluZGl2aWR1YWwgYW5kL29yIHJlY2lwZS13aWRlIGRl
cGVuZGVuY2llcyB0byBhIGZpbGUNCj4gICAgLSBBZGQgYSB3aWxkIGNhcmQgZmlsdGVyDQo+ICAg
IC0gU2hvdyB0aGUgdGFyZ2V0IHJlY2lwZXMgb24gQk9MRA0KPiAgICAtIEFkZCBhIHNlZnQtdGVz
dA0KPiANCj4gW1lPQ1RPICMxNDgxNF0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFJleW5h
IDxEYXZpZC5SZXluYUB3aW5kcml2ZXIuY29tPg0KDQpWZXJ5IG5pY2UgdG8gaGF2ZSBhbiBuY3Vy
c2VzIFVJIGZvciB0aGlzLg0KDQpXaGVuIEkgdHJ5IHRvIHJ1biB0aGlzIGZyb20gd2l0aGluIHRt
dXggSSBnZXQ6DQoNCkVSUk9SKFRhc2tleHBfY2xpKTogUmVxdWlyZXMgMjU2IGNvbG9ycy4gUGxl
YXNlIHVzZSB0aGlzIG9yIHRoZSANCmVxdWl2YWxlbnQ6ICQgZXhwb3J0IFRFUk09J3h0ZXJtLTI1
NmNvbG9yJw0KDQogRnJvbSB3aXRoaW4gdG11eCBJIGhhdmU6DQokIGVjaG8gJFRFUk0NCnNjcmVl
bg0KDQpJZiBJIHNldCBURVJNIGFjY29yZGluZ2x5IHRoZW4gSSBjYW4gcnVuIHRoZSBVSS4NCg0K
SXMgdGhlcmUgYW55dGhpbmcgdGhlIHNjcmlwdCBjYW4gZG8gaGVyZSB0byBoZWxwLCBvciBpcyBp
dCBqdXN0IGEgdXNlciANCnNldHVwIGVycm9yID8NCg0KVGhlIHdpbmRvdyB3aWRnZXQgc2l6ZXMg
c2VlbXMgZml4ZWQsIHRoZXkgZG9uJ3Qgc2NhbGUgdG9nZXRoZXIgd2l0aCB0aGUgDQp0ZXJtaW5h
bCBzaXplLCBpcyB0aGF0IGludGVudGlvbmFsID8NCg0KUmVnYXJkcw0KSmFjb2INCg==

