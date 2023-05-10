Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ECDC77B7D
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 15:06:09 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.19911.1683731164845129090
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 08:06:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=dzwBinb2;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4494f80ab0=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ACh6xh023346
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 08:06:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=86Qjd6dHCUqO0my50c0Jo63yLU8+At5XJuEhz1ooTkM=;
 b=dzwBinb24wpWM6RuYnEu+T+Gc10PjIdGx3MBzojJIZZ8ltqc04g6XSzU0ug6dpjhxjWQ
 jsWaV0xdJy7F34p4IFdo1r43n/KrBkn6IERgGczJPgMlyVaMBflYoTktv+Z2pyY/IsB+
 Ctlp6dtlA21VuSqJKzWpkTH4purzxE00QVYqXOF+/pvciBdvqHkSv03LsKcGNw2KGa3r
 GDgpudE2Sq/iPKusGIIZgJdEj2oaaPyHWLrkKRepfFOoY5Zz8l/WmBRzQweCCdRHIMjz
 3R4I2xTTPlDtiaEfQWrbRvXbAoWEy7n+20fRRDvcueGlHGCqm7//s90W2gTL6frDjKRH OA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf81jss8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 08:06:04 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34AF638A001194
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 08:06:03 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf81jss8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 08:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RadVTJLfDwDGSAb+8KiJt8MWJepOpxxpLPBfS0En96++e2gotDEgElzoESim+52bcD1UAK8abXrzdX8uD7UOSCsRONmNfOVio+/k/IsHE8fxjEoqhzTi6ZOgDkZA81c3sGMkm2LirlMlHmKsnyr7jQgNk7EL2zHFNw2e4WzAG/WGv+4XGugmPpkjGB+yDGvvi/631VYoONpjiQJ4eEWJec3kB/HvmxyJ1D4cYLjbBdKvmtdZwJLiKB2wZlrT6x6gvPmnqa0GiKmuqB5IY5xiWWQbX3If0hF5fLIvqUJzpzACxgoJLAAVty6bWJLtAeJpVibNetx9B+HhcfW8wmv3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86Qjd6dHCUqO0my50c0Jo63yLU8+At5XJuEhz1ooTkM=;
 b=acnZHSMqed8QSeOmMF4Fi4Q7Knhusk4a310kggLqB5EEerFJSpZkremdtyObfj3jz560odEEcTNJVCtzdZgLPsjJRRA0Uy+OUeoXr/bvLUIxP03ptncRbS/jzaXO7fhlRDLZA0xrRRInxvnxbnDnfrm+WtnjtS3FuHfK2Cz8e/BGxWkU6FpiI17OgXAM96YGXUCHBoZFJwWCPMVT0EBYQdyHKdnufAqfl2RQpcOigb0o4uhCNHl8zmS0Dk+yWWkCI+Dd4E3tuxknAoNlvv9w5MUj1tMrw/bRenny2ZdcQ1YVjZvYE0XqUg5VYGPto2HOF8fL0UzmPxLsPyjKGJZ9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 15:05:59 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 15:05:59 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: "Chen, Qi" <Qi.Chen@windriver.com>,
        Richard Purdie
	<richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
Thread-Topic: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
Thread-Index: AQHZgu3bSz9m6E31EE269Fy78ZjP3K9TIsMAgAAWdMCAABdMgIAADqAAgAA7dJA=
Date: Wed, 10 May 2023 15:05:59 +0000
Message-ID: 
 <CO6PR11MB56027195BD2DA96E48864117ED779@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230510031631.1813338-1-Qi.Chen@windriver.com>
	 <25b122740ed8d9d0c62068542da4fa99c53e2dd9.camel@linuxfoundation.org>
	 <CO6PR11MB56021F72AD89D4BC727C33CAED779@CO6PR11MB5602.namprd11.prod.outlook.com>
 <dc333728ed8a71d512609709ce6603e7c0b3e188.camel@linuxfoundation.org>
 <175DC558A674BAA1.32438@lists.openembedded.org>
In-Reply-To: <175DC558A674BAA1.32438@lists.openembedded.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|IA1PR11MB6324:EE_
x-ms-office365-filtering-correlation-id: 77c0433c-7936-4881-8008-08db5168104c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zj4KPxTgCGgOFts80mvOJCiwCWvpwCzktNwj/zweLYrI7UxvGNzwnIn7ucP1tTrdU/O1x72CRdDFbSB+h2/T1BN0HrYMQaWZk5iW5vn9zLwR7CtSxzGOKgY26vDRfki3AyA4pZsj4L+IQYN6iCr3XfckstfrPQY4j26FVMGv5C6CljEMbweW/v+SydIpvqQo2bQp0sADOw+rCKpp/Tw9tZjcUGlnJzYEDSyeXXue3S4mC0xNlXm+EM6XgGErrOpRlZgEmxxJYXA/oaOyLOJy7JyPNirzBL34OVLFKetkgVPA8DcITGUUj9WXSPr3Uo0M6yDAyuzL1QR1XcNvSydWZNw8v4oZnNoyGv47w+NiTmZyATfJLQx1q7hVDThNZn5x0HmkaC8dqppHkZ+U/QAGeqY87eQUi8zUzxoh0bgGw4PWdSDI2ggQMhCfyMg0GgR2K/sBFxL9aNcgrO/QwhwrQKX9OK0nwSTqKsRZxoESGnlDxO4GvuLnEu62QMOQlRmRMMUQ/DvDGCxOf4ZCO6ZzeJGLFsWuGbVt7phk3PrV2+Yma3+a3QIQqHbBVEFWzZnADw+aeZsOfQtENWnkT4b74fkNgAjVp/4pcXnQirJHc4w9iDnMcOnXwUbROtSZsC0/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(451199021)(66476007)(86362001)(33656002)(66446008)(110136005)(76116006)(66556008)(316002)(7696005)(66946007)(478600001)(64756008)(55016003)(5660300002)(8936002)(41300700001)(52536014)(66574015)(71200400001)(8676002)(122000001)(2906002)(186003)(38070700005)(38100700002)(26005)(9686003)(53546011)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTN6SHQvbGorTDgxMXBwTnA5aTgrZHZraHNxcUxZZ2g1b0pxZUpPTlM2cTd2?=
 =?utf-8?B?TFV4SEFZL0MwMjNjMU85TW5Qa2Y1dFI1eXlobjREKzcyMUg5OWdQVU5YaHNB?=
 =?utf-8?B?c29rbXZnM29iM3BPblprMC9zQjE1b2dIZkt0Q1pER3hMTEN1QVI3OEt4bUpx?=
 =?utf-8?B?cTd0Z0x0amVIMzQwb295RzdINHJIcHFjdmo0Zk9hb2FXRnR1K05DOXcwWVpX?=
 =?utf-8?B?Z2hLWWI1dUpqZ2dKNUZwNWFuZ2QvQ28yTlJ6M3pOZDNUY2NaNWF6UlVBbUQw?=
 =?utf-8?B?dHNZSXNzWkxhQ1g2UFlaNUQ0Z3VTL0ozNTRaTXRTL0NVVFNQZ2d2Nmc5dENt?=
 =?utf-8?B?RkhWQ1gyWEJ1Vis1VndwcDNIKzZ6MU5vMktRQUFwNmRGK0lNQ0hKb0NxS2dI?=
 =?utf-8?B?Tm1tUW9qa05HVG5wdnN0SHB6VVVicHpMNVY0UXBGNXNkNjl3WTlGZEVQTWdj?=
 =?utf-8?B?SGhCT3lhM2Y0SVdzdEVzNjVmckFGQk5jZU90eVB2a0hUSjNxWjlCcGVFZE1D?=
 =?utf-8?B?WjF5SXNxa3J6bTVwcVdvMGZHQWlaLytzbTQwMnJvdGZXRCtSbXlPZG15RXJU?=
 =?utf-8?B?bjBrSE5WNEU2aHhuNW5wVVRRdmFCdTNZUFhZOW0yU0lnTTlRZ1VVUmt0aUxY?=
 =?utf-8?B?UmhBdHJ1ZnR3SmtKTmVIYXJLakFQSjZUUmd4Z1MzQzVmSHhKNWQ5cmNpV05B?=
 =?utf-8?B?VzFkaitWM2wyUHVwcU4xQXpKWjAyYVlwR3JqcVMzVGdWbG16eXBSdStmUU12?=
 =?utf-8?B?NlpJRUpCSFMyL28rQU8xcEF1UHN5TElaT2ZGTEt1RVdJdnIwMTZiM2lNZ0Jv?=
 =?utf-8?B?bjBQUjNjcDdxcmtQUGQwbnFiRjI0Q1lYUEt0VUloaVYvTVRPZDQ3OFhMZTlB?=
 =?utf-8?B?d1hxMCtSNGsveHhORW00V2RoUnhKYW8xZ3BMU2wyb0xpdTlKRWZBYXFuN0lx?=
 =?utf-8?B?TmpaNS9VQzhzdkh4UlM3bjhBSGtXSUlvajJMbmdIVXgyd0lQb1Z6bTdaOUsy?=
 =?utf-8?B?a0gwNXBoWVlSMVR2UTdtODYzUTd2eG5RaFkvN0Z5SkdIYXA4NFNWVFErQjhi?=
 =?utf-8?B?QWpxVy9TcFd4MnJtSkJtOUY1TzZrdEZaTUVoVzM1aWY0T21SWmhETVVxUklZ?=
 =?utf-8?B?Sm8vQVpqMXJNeURxL2ZyUjlpb21RdzlRTTM2SFNPVTJNTXU4Q0c0ZVJITjJl?=
 =?utf-8?B?R3VNaXlrMVJZcFhOV1Y4bys0SXFMOUczejZIeWNSTENneFQxQnMwRDkwY1ND?=
 =?utf-8?B?UmtoRmduK01SRXVjWDh3VENPRXlBdGs4U2RjdjFja3JQdk1FYUcwMk4zR1FR?=
 =?utf-8?B?c1FJYmVpL3k1amlkcWtqTEZtY2JweW9SY044Y1YxOGxrY0FmN1JUUXlEY2hj?=
 =?utf-8?B?Z2c3ZFNmWWIybElCaWZLSnc3ZEI4NlpGaWdqTkErcEVsTEpmS3c1cXVtazJq?=
 =?utf-8?B?RUJlaTZ5b0RDL0RIWnB0RjV6VUM3VHZkckNXRExWbmZ5NE5MZHVZcSszclRT?=
 =?utf-8?B?aWRjS0ZWTU45Y1RRVm0xaVVLdHhONU43dVNxTmllcWRUc3h4b0hXd3FNMTlY?=
 =?utf-8?B?OFpqY2VnVmNsWHl5Q0o4ZmtQTFdxVzYxV2ZING5hZzIzRDdXandxbHZzalZw?=
 =?utf-8?B?ZU1UK1Boem9XQUxlN2QwMDlWSXpFazhYSG80bnNvNmJpNTEybFFXS21NUmFp?=
 =?utf-8?B?L2JWYnRyeFVtUmFoL2o0d2FpaUlMMlN0T2duRThzRmh5UCtMQ2NVak9YWE9O?=
 =?utf-8?B?Zzh2Yitzbm1nOGxDTWg1NUUrYjdRUzhxeDlzQU52b2lzVk5NR2VRVGpnL1Nw?=
 =?utf-8?B?ZEJ3cUYxTDhtOWVEdWNLeWVyR2JoejVlZ3NQbWFNcTFSR2x6enJKTERPdU5L?=
 =?utf-8?B?TkZxYksxUUlpdmtLQU1FM1RLdU8vZElna2h6TWp5ZUc2UkZBWmRSUmNLanNu?=
 =?utf-8?B?TXQ2d3YrWFpQZlVvdGthUmhoeXA0NENKTFJkam4rd1lVbWlFRCtBdmJzaFJy?=
 =?utf-8?B?MFF2QTUxRjFSdVVCWGtmdUtsWWEwYzN2Wk9xZllZZ2RHdlpJaTgyMWlzN0U5?=
 =?utf-8?B?SEt1a3RVWmk1REhPZG52c3VvbE1CQnI0UUR2VXN5NW4yditXdlhHWHpjUXU5?=
 =?utf-8?Q?QinESuiQCvLkwrEvN/AdZ01yk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c0433c-7936-4881-8008-08db5168104c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 15:05:59.4609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU2PEoD22HtOytLFY8PeSZgCrhy/XER/rCRtisY0Wr0o44CIh8OXm1veOC0YkUwoijFZGp12BSPYc6b89K+eHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-Proofpoint-ORIG-GUID: H-MdPPJM0BrI43xsjOeFYj6yHwLtjRyX
X-Proofpoint-GUID: WjC57csMDdaJRQ4NiFvzVYdDY8I9fEMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100122
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 15:06:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14779

SGkgUmljaGFyZCwNCg0KVGhhbmtzIGZvciB5b3VyIGluZm8uIEFmdGVyIGNoZWNraW5nIHRoZSBj
b2RlcyBvZiB1cGRhdGVDb25maWcgYW5kIGxvb2tpbmcgYXQgbXkgcHJvamVjdCdzIHNwZWNpYWwg
Y29uZmlndXJhdGlvbiwgSSBmaW5hbGx5IGZvdW5kIHdoeSBteSB1cGRhdGVDb25maWcgdGFrZXMg
c28gbG9uZy4NCldlIGhhdmUgYW4gZXZlbnQgdHJpZ2dlcmVkIGJ5IENvbmZpZ1BhcnNlZCwgYW5k
IGluIHRoYXQgZXZlbnQsIHdlIGRvIGZpbGUgc2VhcmNoLCBtdGltZSBjaGVja2luZywgZXRjLCBh
bmQgdGhlbiBzZXQgQkJfSU5WQUxJRENPTkYgdG8gVHJ1ZSwgd2hpY2ggdHJpZ2dlcnMgYSBuZXcg
cGFyc2UuDQoNClJlZ2FyZHMsDQpRaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxiaXRiYWtlLWRldmVsQGxp
c3RzLm9wZW5lbWJlZGRlZC5vcmc+IE9uIEJlaGFsZiBPZiBDaGVuIFFpIHZpYSBsaXN0cy5vcGVu
ZW1iZWRkZWQub3JnDQpTZW50OiBXZWRuZXNkYXksIE1heSAxMCwgMjAyMyA3OjQwIFBNDQpUbzog
UmljaGFyZCBQdXJkaWUgPHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBiaXRi
YWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNClN1YmplY3Q6IFJlOiBbYml0YmFrZS1k
ZXZlbF1bUEFUQ0hdIGJpdGJha2U6IGFkZCAtLW5vcmVwbHktdGltZW91dCBvcHRpb24NCg0KSGkg
UmljaGFyZCwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5LiBJIHRvdGFsbHkgYWdyZWUgdGhhdCBp
dCBzaG91bGQgYmUgdGhlIHNlcnZlciBjb25maWd1cmF0aW9ucyAoZS5nLiwgQkJfTlVNQkVSX1RI
UkVBRFMgZm9yIGVhY2ggYnVpbGQsIHRoZSBudW1iZXIgb2YgYnVpbGRzIHRvIHN0YXJ0IGluIHBh
cmFsbGVsLCBhbmQgbWF5YmUgUFNJIHJlbGF0ZWQgY29uZmlncywgZXRjLikgdGhhdCBzaG91bGQg
YmUgYWRqdXN0ZWQgdG8gYXZvaWQgc3VjaCB0aW1lb3V0IGlzc3VlLg0KDQpUbyBhZGQgbW9yZSBp
bmZvcm1hdGlvbjogdGhlIHNlcnZlciBJIHVzZWQgd2hlcmUgSSBzYXcgdGhpcyBzdGFydC11cCB0
aW1lb3V0IGZhaWx1cmUgaXMgMTI4IGNvcmVzICsgNTEyRyArIDQgUkFESTAgZGlza3MuIFRoZSB1
cHRpbWUgdmFsdWUgd2hlbiB0aGUgdGltZW91dCBoYXBwZW5lZCB3YXMgYXJvdW5kIDUwMC4gVGhl
IEJCX05VTUJFUl9USFJFQURTIHJlbWFpbnMgaXRzIGRlZmF1bHQgdmFsdWUuDQoNCkkgYWxzbyBm
b3VuZCBzdWNoIHN0YXJ0dXAgdGltZW91dCBpcyBtb3JlIGxpa2VseSB0byBoYXBwZW4gb24gbWFj
aGluZXMgd2l0aCBtb3JlIGNvcmVzLiBCZWNhdXNlIG9uIGFub3RoZXIgc2VydmVyLCB3aGljaCBo
YXMgNDAgY29yZXMsIEkgaGF2ZSB0byBzdGFydCAzfjUgYnVpbGRzIHRvIHRyaWdnZXIgdGhpcyB0
aW1lb3V0IGVycm9yLg0KDQpSZWdhcmRzLA0KUWkNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogUmljaGFyZCBQdXJkaWUgPHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlv
bi5vcmc+DQpTZW50OiBXZWRuZXNkYXksIE1heSAxMCwgMjAyMyA2OjM2IFBNDQpUbzogQ2hlbiwg
UWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT47IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVk
ZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXVtQQVRDSF0gYml0YmFrZTogYWRk
IC0tbm9yZXBseS10aW1lb3V0IG9wdGlvbg0KDQpPbiBXZWQsIDIwMjMtMDUtMTAgYXQgMDk6NDMg
KzAwMDAsIENoZW4sIFFpIHdyb3RlOg0KPiBIaSBSaWNoYXJkLA0KPiANCj4gSXQncyBub3QgdGhl
IGJpdGJha2Ugc2VydmVyIHRoYXQgdGFrZXMgbW9yZSB0aGFuIDEgbWludXRlIHRvIHN0YXJ0LCAN
Cj4gaXQncyB0aGF0IHRoZSAndXBkYXRlQ29uZmlnJyBjb21tYW5kIHRoYXQgdGFrZXMgbW9yZSB0
aGFuIDEgbWludXRlLg0KPiBGcm9tIHdoYXQgSSBzZWUsIG90aGVyIGNvbW1hbmRzIGZpbmlzaCBx
dWl0ZSBmYXN0IGV4Y2VwdCB0aGUgYWN0dWFsIA0KPiBidWlsZGluZyBvbmUuDQoNClRoZSB1cGRh
dGVDb25maWcgY29tbWFuZCBkb2Vzbid0IGFjdHVhbGx5IGJ1aWxkIGFueXRoaW5nLiBBbGwgaXQg
ZG9lcyBpcyB0cmlnZ2VycyBhIHBhcnNlIG9mIHRoZSBiYXNlIGNvbmZpZ3VyYXRpb24sIGl0IGlz
bid0IGV2ZW4gcGFyc2luZyByZWNpcGVzLCBqdXN0IHRoZSBiaXRiYWtlLmNvbmYgYW5kIGxheWVy
LmNvbmYgZmlsZXMuDQoNClRoaW5rIG9mIHVwZGF0ZUNvbmZpZyBhcyBqdXN0IGJyaW5naW5nIHRo
ZSB0d28gZW5kcyBvZiB0aGUgY29ubmVjdGlvbiwgY2xpZW50IGFuZCBzZXJ2ZXIgaW50byBzeW5j
Lg0KDQpJJ20gYSBiaXQgd29ycmllZCB0aGF0IGlmIHRoZSBzeXN0ZW0gaXMgc28gb3ZlcmxvYWRl
ZCBpdCBjYW4ndCBkbyB0aGF0IGluIDYwcywgd2UgaGF2ZSBiaWdnZXIgcHJvYmxlbXMuDQoNCj4g
VGhlIHNlcnZlciB3YXMgc3RpbGwgdXNhYmxlLCBldmVuIGFmdGVyIHRoZSBzZWNvbmQgd29ybGQg
YnVpbGQgbWFuYWdlZCANCj4gdG8gc3RhcnQuDQo+IA0KPiBJJ20gbm90IHVzaW5nIGFueSBzcGVj
aWFsIGNvbmZpZ3VyYXRpb24uIEFsbCBkZWZhdWx0IHZhbHVlcy4gSSBkbyBoYXZlIA0KPiBleHRy
YSBsYXllcnMgYWRkZWQsIHN1Y2ggYXMgbWV0YS1vcGVuZW1iZWRkZWQvKiwgbWV0YS0gdmlydHVh
bGl6YXRpb24sIA0KPiBtZXRhLWJyb3dzZXIsIG1ldGEtc2VjdXJpdHksIG1ldGEtc2VsaW51eCwg
ZXRjLg0KPiBBbnl3YXksIHRoZSB0YXNrIG51bWJlciBvZiBhIHdvcmxkIGJ1aWxkIGlzIGFib3V0
IDQwMDAwKy4NCj4gDQo+IEluIGZhY3QsIHdoYXQgSSByZWFsbHkgd2FudCB0byBkbyBpcyB0byBz
ZXQgdGhlIHRpbWVvdXQgdG8gYmUgc29tZSANCj4gbGFyZ2UgdmFsdWUgb24gb3VyIGF1dG9idWls
ZGVycyBzbyB0aGF0IHdlIGNhbiBhdm9pZCB0aGlzIHN0YXJ0LXVwIA0KPiB0aW1lb3V0IGZhaWx1
cmUuIElmIHN1Y2ggcGF0Y2ggaXMgbm90IHN1aXRhYmxlIGZvciB0aGUgb2ZmaWNpYWwgDQo+IGJp
dGJha2UsIEknbGwgbWFrZSBpdCBhIGxvY2FsIHBhdGNoIHVudGlsIG91ciBhdXRvYnVpbGRlcnMg
YXJlIA0KPiBjb25maWd1cmVkIG1vcmUgcHJvcGVybHkuIERvIHlvdSBoYXZlIGFueSBzdWdnZXN0
aW9uPw0KPiANCj4gVGhhdCdzIGFsbCB0aGUgaW5mb3JtYXRpb24gYW5kIHRoZSBiYWNrZ3JvdW5k
Lg0KDQpXaGF0IGlzIEJCX05VTUJFUl9USFJFQURTIHNldCB0byBhbmQgaG93IG1hbnkgQ1BVIGNv
cmVzPyBTcGlubmluZyBtZWRpYSBvciBTU0RzPyBXaGF0IGFyZSB0aGUgc3lzdGVtIGxvYWQgbnVt
YmVycyB3aGVuIHRoaXMgaGFwcGVucz8NCg0KSSB0aGluayB0aGF0IGlmIHRoaXMgc3RhcnR1cCB0
aW1lb3V0IGlzIGhhcHBlbmluZywgdGhlcmUgd2lsbCBiZSBvdGhlciBpc3N1ZXMgYW5kIHlvdSBu
ZWVkIHRvIHJlc29sdmUgdGhlIG92ZXJsb2FkZWQgc3lzdGVtIHByb2JsZW0gcmF0aGVyIHRoYW4g
anVzdCBtb3ZlIHRoZSB0aW1lb3V0IHByb2JsZW0gdG8gc29tZXdoZXJlIGVsc2UuDQoNCkNoZWVy
cywNCg0KUmljaGFyZA0KDQo=

