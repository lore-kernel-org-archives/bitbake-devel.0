Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0065C001DF
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 07:56:36 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.9374.1691049389692458439
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Aug 2023 00:56:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=apbVnKA/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7579963e98=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3736xHGg015751
	for <bitbake-devel@lists.openembedded.org>; Thu, 3 Aug 2023 00:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=DDLGdDlXhdXLhyhW6BFKVsy+vEm2TXYanhiqHZ4ml+E=; b=
	apbVnKA/kePCt7Pb8RYlasdTDuNY7kxXLq6byuxx2IU77ZHX/iH2bOqU5VmCKOa7
	nwWBqTsCl9X0EkrAIxk7kM3vyaCu6LzNPraZn0iOBvEfajAOI5zLNCk2BVUCTmDy
	KFkEBRCWI9EKNY1+p+okvYSUsg6tx8WqDxNjHZRyhFi6u89pPwJ4zyHBhNkqb5Sn
	T6Hl0GDkuMY0hhxvt989NNF5JTbr/GMBsvdfdpV58BdZw8s4B2Wn1fvqfFZkzIfi
	UUlc4QzF/iafaSaFmg7lIesRh0vLWtRO6Dq7EhL1X/nTIuVWIL6TzJrkC+K1ryoM
	Q8CTYXpPdms2VjVaFeGuYg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s6daqtxsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 00:56:29 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 3737tA3M031692
	for <bitbake-devel@lists.openembedded.org>; Thu, 3 Aug 2023 00:56:28 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s6daqtxsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 00:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrKVzle0Y7hUgdsKseHFi3xj/19eHDbcnrDdqL2EGifDhTkPZv4DymTfLgUSjgF++GOLY62qgmLNaZ9U2pYn3RQ/14LsKvftjT6syiL2Fm2+Rv6yXHmjIOAji7hNdNGmntHLvFgOqja6fW01Gm/wzVYXEJHKQZSKoYOM6IzA1+p3cgmYalgdhvBzvdY+1DjgKzIE8Q6sBD6rk66pQcqmW0Fb0bg1WGDf5djqxOanUgFz6cA2E9aPPWDD/ddMygTZ/+/Co4zy88Mgqs6WIJYfF/0szx48mwRNJga0naj64uQ+R84iTz1+BKqGe4RefXCHG+Q+OSlD/6exzFlk9OQWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDLGdDlXhdXLhyhW6BFKVsy+vEm2TXYanhiqHZ4ml+E=;
 b=c6ewm/42dSyq8zWDs81lS+SHZB9NWFhrv00jjh5Ui8xSuEgO3NZUv30DMHOsWQWLJHS3vVbn2dj8gVDQf9n0Cb2aXypJ7+gx7mp8QmrwxUfSztyFo/uZ2hOo8fFRVgabnK0o4I1j5608Mx/jIR4hnA9J7oos3aDmXu2jVfH0k/KSofRl52t4OhiPzN4M3rpwgnu89Z8I0wCVsKNo7O8mGrHFJB2igAtv98D/SMb4S4LHo+GnTMoXCyYbYhpI4/05Qaq68c0FZoWncCuYdlv1cXE0s3AYsLaiAdrbzKg+6QpuMFZaAFs7j0pBQcS8VPUnCfS1vlRUkFnVDcuK36gCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:56:26 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:56:26 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: "Chen, Qi" <Qi.Chen@windriver.com>,
        Richard Purdie
	<richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>
Subject: RE: [bitbake-devel][PATCH V3] runqueue.py: fix PSI check logic
Thread-Topic: [bitbake-devel][PATCH V3] runqueue.py: fix PSI check logic
Thread-Index: AQHZxcoX3UcotR1GvU+sNQhDbQ/dga/YGVMAgAAEcSCAABXKwA==
Date: Thu, 3 Aug 2023 07:56:25 +0000
Message-ID: 
 <CO6PR11MB5602C9B0DA08EC4008E9E9DAED08A@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230803051916.1640841-1-Qi.Chen@windriver.com>
 <24aea6c874b03d9993b0d84dddc207afcdbccb4e.camel@linuxfoundation.org>
 <CO6PR11MB5602693BCAE0AE6CA7A659D4ED08A@CO6PR11MB5602.namprd11.prod.outlook.com>
In-Reply-To: 
 <CO6PR11MB5602693BCAE0AE6CA7A659D4ED08A@CO6PR11MB5602.namprd11.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|CY5PR11MB6258:EE_
x-ms-office365-filtering-correlation-id: cb8cac8d-50ec-420d-fc7d-08db93f72316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HEVJ1CODl7o6S9TNjs14zKCOXRbtR38LrHnya82J6G6VAWMx9Da9RQ8jCAqVzVwOHlFqETUUEflpdr4tVHxv7zKuWYTm/vFBKmwmwZPnyHCGZoFpwiL5bTELJLJ5L2hCsVMg+aXTu0yKD8vkIimXa5G9C757P1fY5effag/ET8JdlutPt5+kcnRTX7506/h3PIjKQKYB32Nb4J8tVMKUWFOPGutxno7LYBaxR3mnZddqN13ed0eiyFp3nkWhqr2m8Em3santN6KRs+WeimNm5HUZ5lrK8rIuTiGaKqN1cPaFHc/qGc6BjDgSlV2GmGGArzWFZMYZaWQbAoIjkqWTNN5xzH36RmYoq+0CAb8MMi9YLMPs7H5uwMrDV+JEn7vBpRmtjaWNpSPtVwKV1lxxZuEPDL2oPCb6qHgCd5kEtW78/lO5AfI5boAKid74FPZpBz7bhe2baTSwB05Wczd8j+Q1YVXaK9/HVBLHVXLUR5O0L1kbWWMIUpxG+64L4Xi8602EHDpeWu0Zfnyxxa3QqEEdX1PVNQ3S8+uIlPOPB/CwN+agomSkpGdfys3X9F605xcfnvqtFSnMhqLVR61hLO4ATurASveCCbBhRTFASAGhaHzCcl48zOcN4a9ypDSr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(451199021)(2940100002)(107886003)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(76116006)(2906002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(7696005)(71200400001)(52536014)(9686003)(110136005)(478600001)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VmNkU2RicS9NM1BkUVV4clA3emxTQ0tDb3FiVUwrMmpCN0tWNFVJOXlKYzla?=
 =?utf-8?B?c3ZtcndHQWxGTUhzTVRYNE1RMHVtMFpTY25ybjZGb0preW90U01YSFR4aksy?=
 =?utf-8?B?V3Vvc2xXaVk5TUJsK3A5WFdackkrc2hwOEh0OXJmRVhvSHdNaGRyTmR0MkVV?=
 =?utf-8?B?SjZyNUZNVnhJOWgxQmtGZHN5SlZwNk1aWGFGMXY1UU04WjRKa3FDdDFnaDZC?=
 =?utf-8?B?ZmFiRFRtc0wxTUl6Y2lEZ1BmTE9mckQwVDNQWHZFRUJUTmJwYXpCa2o0UG5H?=
 =?utf-8?B?dTJmbTVVa250NmMwalB4WDBXRFFITkU1R1ZhbEQ2MXROZWF3QklteHdzWVU4?=
 =?utf-8?B?VGhDSTV6cXNGTlBzbDBRMmhpM0JhOXc4TkRzMG12NFpXUWYrWWY4MWs0TjVD?=
 =?utf-8?B?Z3YyNGVZNXliTC9LWDhKeGRweTBHUC9XNnRwQXlIczZzbnlrSE9Id3JpVDVU?=
 =?utf-8?B?WEdIVEVQeElmOTljTWFPd1RCQ3pqYVZvMmhRTTJKV0RzSnVWYVF2ODRsTk8x?=
 =?utf-8?B?cjRMZG1XRVFydGFQaGZUOXNqUG5ESUI2cG9nelRFbEVkUHVRZ2k2dGp5Wnkx?=
 =?utf-8?B?MW9mdytEamFiVDRsNHZPdFlGT3FUQzBJaERrUFV4TkRoM2kwNkJIa0pzT3hy?=
 =?utf-8?B?dHQ1R0F1cTMyUmdscmJVc0xaNURDYy8zb1MzTlY0QzArcXhXSHVjQ0t0VzFp?=
 =?utf-8?B?NC82SGdMaXB6TmloWndyUEFmK2hzQUpKZENWaWtBL2xaWTAzbGpUbUtwQWR1?=
 =?utf-8?B?MFZ0OGo0SzFnNnNESldhZTZoekhKc2tqMEtWMW5lRjVxUjVnT21WVlR5OHhi?=
 =?utf-8?B?Sk5rQ0dDQTN0VlFOM085SW9mZ1VJTG56RXlBTUxDdGFXbzcrWE4yUmI0OTk0?=
 =?utf-8?B?WEQ1TGxYbTNyRlFDWkZObXlYUlgvSXVlS0tiVFVKcTVvRnJwRGl6dUJYMDZP?=
 =?utf-8?B?Y1QxSTBIUnU5NXJhc2VyZk4yUzJwTHIrcHQ5a0dMWFFMTXNKMFJVeXBHcFFU?=
 =?utf-8?B?UEJaT0t2YlY4OGhYS1Q0bE1PZGZMa1dGdzIwN0hLS05hTHJUL1lWT0luV1h2?=
 =?utf-8?B?UkhzcDlRVTU5Y3lCSHlDek5pUStlTDZyeFFjbzNiQ3M3T09TYUJuQVB5eUF6?=
 =?utf-8?B?eG9mQVBzb2NFV0FUcWFTN3M2N2N5ckZ1bkc0UUdhbWx4VEVRWlB1WE1RTDNG?=
 =?utf-8?B?eHdldVNUZ0lqekxOZGJ0OUw4N3lIYU9GdTN0QmNneDcwWno2VGo2T2dJMjAr?=
 =?utf-8?B?bUlxM2ZhSGtTUGpxcDNwLy9mWFZwdGdjZWFoRVVSNE9pdTBDN0lBZDhKaGVO?=
 =?utf-8?B?WHNGcGgyVWhIQ1VwbU0xNVk4aXhrb3M5N1pMNmNGQWwwdEJ0VHRSVFd5RHQv?=
 =?utf-8?B?Z20zRHc0SCsxTzZQb1FSR2FpSU1nUUlRcVk0dmRWTTRQQ0NUcVpKdWNFMlRW?=
 =?utf-8?B?b0tCVHJmbEErU05MZmUyeTRDSDZFNExlKzhYcW9ZcDlaSlVQM2pKS0g1QVJ1?=
 =?utf-8?B?RVVab2kycXo0aVJoNUdmY3BRK2ZSWkNoK0o1Z21xVEk4aC85RmNSRzdUNnFv?=
 =?utf-8?B?YmZDWDNSMHFGRUlZNFE0ZEZBSjR6ZC8xcXVadHE1bzJNLy9IeEV6LzdDY3RT?=
 =?utf-8?B?WTFndjB5cjlrcUdtT0owV2REeVZoSGVqUlhjbFc1ZktWa0VJdDhJMEpuOG05?=
 =?utf-8?B?QVJZQUNSazFSUE5YTVVFYjFoTlFsUTcrRHkwTzliR3o4Qys3WHI1UEdKbkR3?=
 =?utf-8?B?aERoRXBoN3dibzJZNkdjTERxekFxNjcvaEtacVM3dVY4QmpTSU84MVAxZ3Vm?=
 =?utf-8?B?SHVCVjRzR3Y3NG9SRGhDVzUrSjBNTlFNclRjU1cxWUtMSHgxdWh6S2ZOeGJ2?=
 =?utf-8?B?VndMckZjSFo1eXJ4WHdNdFg1cnUwU01KSlhTVHVUd0MwWTlKdWdLMFZGZkRk?=
 =?utf-8?B?T0gzWWxYeGN2VkI2Nlg1VnZrV3JkbGtGaTJZRUo4bWdKY3RPYmtmWnBpOUFW?=
 =?utf-8?B?bExtNG9NcEFVdG5CVUJUS3pPY3RLL0NDYjdRQVdrTFpNL3lSMUJqc1VGU0tl?=
 =?utf-8?B?RWcyN2d4bjJ3aVY1ekd5NkQ0cFpqT0owZzIvYzFqOW1KRUJBRUc0VmxSd1Rl?=
 =?utf-8?Q?H1OP3QoMrRNstUEmpVjqr2Y4y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8cac8d-50ec-420d-fc7d-08db93f72316
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 07:56:25.7873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOu6ThHX8T23TJRhqNswnhi7b3E+xSK7Y/EyrSRw9iT9l0Pva91Xmve+Bt5i+cioqI1Aj8i9/xa0Fvnyn8eTkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-Proofpoint-ORIG-GUID: SYu6hXiCboudXEiRyI4LrC5ZDFnw_07T
X-Proofpoint-GUID: R8O5ms53AIN0UBxlY8lWB9o-MD08_oPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308030070
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 07:56:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14912

QWZ0ZXIgbW9yZSBpbnZlc3RpZ2F0aW9uLCBJIGZvdW5kIHRoZSBwcm9ibGVtIGlzIGEgbGl0dGxl
IGNvbXBsaWNhdGVkLiBJZiB0aGUgdGltZSBpbnRlcnZhbCBpcyB2ZXJ5IHNtYWxsLCB0aGUgcmVz
dWx0IG1pZ2h0IGJlIDAsIHJlc3VsdGluZyBpbiBhbnkgc21hbGwgbnVtYmVyIGhhdmluZyBubyBl
ZmZlY3QuIFRoaXMgbWVhbnMsIGV2ZW4gaWYgd2Ugc2V0IEJCX1BSRVNTVVJFX01BWF9JTy9DUFUv
TUVNT1JZIGFsbCB0byAiMSIsIHRoZXJlIHdpbGwgYmUgYSBmZXcgdGFza3MgcnVubmluZyB0b2dl
dGhlciB0aHJvdWdob3V0IHRoZSB3aG9sZSBidWlsZCBwcm9jZXNzLiBJbiB0aGVvcnksIHRoZXJl
IHNob3VsZCBvbmx5IGJlIDEgdGFzayBydW5uaW5nIHVuZGVyIHN1Y2ggc2V0dGluZy4NCg0KU28g
SSd2ZSBzZW50IG91dCBWNCwgd2hpY2ggYmxvY2tzIHRhc2sgc3Bhd25pbmcgZm9yIGF0IGxlYXN0
IDFzIHdoaWxlIGNoZWNraW5nIHRoZSBwcmVzc3VyZSBldmVyeSB0aW1lIGlmIHRoZSB0YXNrIHNw
YXduaW5nIGlzIG5vdCBibG9ja2VkLiBUaGlzIHdvdWxkIGltcHJvdmUgdGhlIHNpdHVhdGlvbi4N
Cg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBiaXRi
YWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZz4gT24gQmVoYWxmIE9mIENoZW4gUWkgdmlhIGxpc3RzLm9wZW5lbWJlZGRl
ZC5vcmcNClNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMywgMjAyMyAyOjM4IFBNDQpUbzogUmljaGFy
ZCBQdXJkaWUgPHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBiaXRiYWtlLWRl
dmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCkNjOiBNYWNMZW9kLCBSYW5keSA8UmFuZHkuTWFj
TGVvZEB3aW5kcml2ZXIuY29tPg0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXVtQQVRDSCBW
M10gcnVucXVldWUucHk6IGZpeCBQU0kgY2hlY2sgbG9naWMNCg0KVGhhbmtzIFJpY2hhcmQuIFlv
dSdyZSByaWdodC4gSSdsbCBzZW5kIG91dCBWNCB0byByZW1vdmUgdGhlIDFzIHdpbmRvdywgdGhp
cyB3aWxsIG1ha2UgYml0YmFrZSBkbyB0aGUgY2hlY2sgZXZlcnkgdGltZSBpdCB0cmllcyB0byBz
cGF3biBhIG5ldyB0YXNrLg0KDQpSZWdhcmRzLA0KUWkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRp
b24ub3JnPg0KU2VudDogVGh1cnNkYXksIEF1Z3VzdCAzLCAyMDIzIDI6MTkgUE0NClRvOiBDaGVu
LCBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1i
ZWRkZWQub3JnDQpDYzogTWFjTGVvZCwgUmFuZHkgPFJhbmR5Lk1hY0xlb2RAd2luZHJpdmVyLmNv
bT4NClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF1bUEFUQ0ggVjNdIHJ1bnF1ZXVlLnB5OiBm
aXggUFNJIGNoZWNrIGxvZ2ljDQoNCk9uIFRodSwgMjAyMy0wOC0wMyBhdCAxMzoxOSArMDgwMCwg
Q2hlbiBRaSB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0Kd3JvdGU6DQo+IEZyb206IENoZW4g
UWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCj4gDQo+IFRoZSBjdXJyZW50IGxvZ2ljIGlzIG5v
dCBjb3JyZWN0IGJlY2F1c2UgaWYgdGhlIHRpbWUgaW50ZXJ2YWwgYmV0d2VlbiANCj4gdGhlIGN1
cnJlbnQgY2hlY2sgYW5kIHRoZSBsYXN0IGNoZWNrIGlzIHZlcnkgc21hbGwsIHRoZSBQU0kgY2hl
Y2tlciBpcyANCj4gbm90IGxpa2VseSB0byBibG9jayB0aGluZ3MgZXZlbiBpZiB0aGUgc3lzdGVt
IGlzIGhlYXZ5IGxvYWRlZC4NCj4gDQo+IEl0J3Mgbm90IGdvb2QgdG8gY2FsY3VsYXRlIHRoZSB2
YWx1ZSB0b28gb2Z0ZW4uIFNvIHdlIGNoYW5nZSB0byBhIDFzIA0KPiBjaGVjay4gQXMgYSBidWls
ZCB3aWxsIHVzdWFsbHkgdGFrZSBhdCBsZWFzdCBtaW51dGVzLCB1c2luZyB0aGUgMXMgDQo+IHZh
bHVlIHNlZW1zIHJlYXNvbmFibGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFFpIDxRaS5D
aGVuQHdpbmRyaXZlci5jb20+DQo+IC0tLQ0KPiAgYml0YmFrZS9saWIvYmIvcnVucXVldWUucHkg
fCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQpJIHRoaW5rIHRoZSBjaGFsbGVuZ2Ug
d2l0aCB0aGUgMXMgZGlmZmVyZW5jZSBpcyB0aGF0IGl0IHdpbGwgY2F1c2UgdHdvIGRpZmZlcmVu
dCBiZWhhdmlvdXJzLg0KDQpUaGUgZmlyc3QgaXMgdGhhdCB3aGVuIGl0IGxpbWl0cyBwcmVzc3Vy
ZSwgaXQgd2lsbCBrZWVwIGxpbWl0aW5nIGZvciBhdCBsZWFzdCBvbmUgc2Vjb25kIGFmdGVyd2Fy
ZHMuIFRoYXQgbWlnaHQgbm90IGJlIHRvbyBiYWQsIGl0IHdvdWxkIHBvdGVudGlhbGx5IGp1c3Qg
ZGVsYXkgYSBidWlsZCBzbGlnaHRseS4NCg0KVGhlIHNlY29uZCBpc3N1ZSBpcyB0aGF0IHdoZW4g
Yml0YmFrZSBzdGFydHMgZXhlY3V0aW5nIHRhc2tzLCBldmVuIGlmIHRoZSBwcmVzc3VyZSBvZiB0
aGUgc3lzdGVtIHNwaWtlcywgaXQgd29uJ3QgYmUgc2VlbiBmb3Igb25lIHNlY29uZCBhbmQgYml0
YmFrZSB3aWxsIGxpa2VseSBoYXZlIGV4ZWN1dGVkIEJCX05VTUJFUl9USFJFQUQgcHJvY2Vzc2Vz
IGluIHRoYXQgdGltZSwgbGlrZWx5IHB1c2hpbmcgdGhlIHByZXNzdXJlIG9uIHRoZSBzeXN0ZW0g
d2VsbCBhYm92ZSB0aHJlc2hvbGQuDQoNCkkgc3VzcGVjdCB3ZSdyZSBnb2luZyB0byBoYXZlIHRv
IGNvbWUgdXAgd2l0aCBzb21ldGhpbmcgZGlmZmVyZW50IHRvIGhhbmRsZSB0aGVzZSBpc3N1ZXMu
Li4NCg0KQ2hlZXJzLA0KDQpSaWNoYXJkDQo=

