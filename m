Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A6C77B7D
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 11:40:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.14127.1683718820074048104
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 04:40:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=HD3NIZCI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4494f80ab0=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AAr4OY022213
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 04:40:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=tryAZQpPLEKTt9obD/He3IYVPyafQCwI+5bjs2o1qnU=;
 b=HD3NIZCIMFecclM6LUSKOtaBo68kWH7WuFCXVYbEnuR9g+P7GAy0DfhmuyqGvwpjXS6L
 kCHp4oBkFtDO1819kLjk0EeSeUMEUyGYW+4etgUv30ipAeN1RGLRyY/P5eZ7kGzAvFiZ
 n+gK4V+K0iBIwQmsZVE8oowdBSoEtMZ+gE+s4sBqBp4imd6qGWoRx6YormAKL+wS0nb+
 2kIom7ROKz8HVj3V9sU5cYlmDDwVo+hgqRzbEGcrCck9obwlTu+D3o0EsNY57waifzkM
 ZXKIQ8VoJNPXigYilu03+WxgKpzHkY22JEKFY5UAiyYnBqMpJCMTqaXMBaV8L9HGUQ7a 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf7ucskv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 04:40:19 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34ABeIcW019667
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 04:40:18 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf7ucskuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 04:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaCZ3U3a6mP32xAQAfULvKf6OK6j0jyuOGlsGYFlYPMfSfbkZOuC1HschwoHihU8UGPprq3/bRQFTQkoSYvOABdQ9+TgNcUYxDNe0s4sjpDgZJ320IwqhssbOw//OYt9Kz4RU3vb5R68/9/yz9PIecLk869CD08QM/dWk/+bVsAC0Mpiss2dL+RObEc2il4qAjguJbosIMUTqBIPfz+t0sbHcfH70JnIbpRk4lll+ANkt7xpoQ3jss1GGI1O3iVHbfb+rjFYch3B5vL/SlSLdYSgHZMYfTeEzSABQ0eKEoI0fDYomJ89eYV+7IRisKArdn6acqhG/pTZZBi+kaX5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tryAZQpPLEKTt9obD/He3IYVPyafQCwI+5bjs2o1qnU=;
 b=XCjmxquTTdEsrbfARk7rnOZXKxp5SVFwwoFWD9RTOQ4ceJlrYqSGf3edwUSDkW4QhavQOceajwngHna2ZnkzSwx5CWwOLTW3xxvMGlgyrOCpAmVtlmeTCCQ2mrTTj2k6mt34hj783m0Re2+8E60IANsWkt84AEVVqhcNh8El1FZWKUcre971PxYWUBn3O8KrI2rE2dLLXJxSFTeCmYeU5d6TDbE5ed411E9JJF4YvKFa0YmrqftiQ7FDYaYDyrF9D+n00399LGTrXMRc+s5A81sy3wwsTdjnhXpISnX+Nll7ppT+VqpGcprLc2mqt6rnp6VFnnRwGgHCk86obww1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 11:40:15 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:40:15 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
Thread-Topic: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
Thread-Index: AQHZgu3bSz9m6E31EE269Fy78ZjP3K9TIsMAgAAWdMCAABdMgIAADqAA
Date: Wed, 10 May 2023 11:40:15 +0000
Message-ID: 
 <CO6PR11MB5602EEFA3D556B53B31E47E9ED779@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230510031631.1813338-1-Qi.Chen@windriver.com>
	 <25b122740ed8d9d0c62068542da4fa99c53e2dd9.camel@linuxfoundation.org>
	 <CO6PR11MB56021F72AD89D4BC727C33CAED779@CO6PR11MB5602.namprd11.prod.outlook.com>
 <dc333728ed8a71d512609709ce6603e7c0b3e188.camel@linuxfoundation.org>
In-Reply-To: 
 <dc333728ed8a71d512609709ce6603e7c0b3e188.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|MW5PR11MB5858:EE_
x-ms-office365-filtering-correlation-id: 15d1c71e-7769-4524-2e8b-08db514b52c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lZJo5YWlBA/gm+pn3/p5NEJ7LPrdy4nOGyYrTJHShtDLgBzE17sRm04pwSpuwTp5fB4tuGB7+agS4+Gjkz9Lq6gWBe5CoHjwglrcgqIrGSIlEeOd+JAUWhNNQC/XEX53/2nAmrETXQ2WVvvPk+2EVDopfIvJVs/VWZlnH7GzWfRxD9dnTXm7cLInQd4vzp5XaemPqesR102SI49ERNSd08E37ygbQMUMs5Imnk13JWhKkzot24u0Ydyw0hshr0mJO23J0NTVjV5GZr0UzxR4JNGNcsEF0YKhoRxwFigCFxms2VmoMPq6BOO+Ty5uEDlvNr8DUIrZl+Rcq2euGIZARS2caV9UqcL5bvg7LqA4hw/pA28celegupTeqQZL7xUWjhTupN83+8WFStV9m0RvhbxVUuFPAOA6SF147reoYxNzN0+gHNaS3eNWMjiub9k7Pvrvdq/lQzgS9QN6RNJJsydqb0E7qdnNXolesp8SDY8f+T1hK1VFkubqONpwEUZarW9wqSJT5wF0wpLvUTddiBkwyA9T9bSNMmJiSqYjADLHble7N3SO7QZBQ9mRoyixKXhMxWO4xriHHEd5YgIPlxgUVtvoaWaheDYGm4HOLE3I6loKozf1gWYQLh/Y0+ul
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(451199021)(122000001)(33656002)(41300700001)(2906002)(26005)(53546011)(186003)(9686003)(6506007)(5660300002)(71200400001)(52536014)(38100700002)(38070700005)(8936002)(55016003)(8676002)(110136005)(478600001)(83380400001)(66574015)(7696005)(86362001)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TXhTQTdkRjJZTnp0MExPUHg1RWVVaEZndk1JQkVWRXpTLzBJdHhMd1pNWGdi?=
 =?utf-8?B?UlViSFJ2aFlkcFhGTkNFamNhdTBNVlFLK0RDM2J1ZmQ1MExEU3lzTGl6c2JE?=
 =?utf-8?B?RkovOWZtT04wWjVBUFR4SFlKNVFwUFU2NmJtWGxHQnB0ekZDb3hwOTRmRVdR?=
 =?utf-8?B?ck9kWEVtTUJHYnZWSnRzSUloVVlmWGViNm5EWk44VGVYdFhRaWZNTkRMWFh0?=
 =?utf-8?B?cDV2RythTjByOE83cjBtVktmeWhka2syNisvTjNUWUFIOTlhelFXaTd3Zlo5?=
 =?utf-8?B?aFNXNm44TjYwN0g3cmZOeGVVbkRudkhCNDRxaGZmNmJOUmhiVi9vKzV3Ry9M?=
 =?utf-8?B?ZWNoZndSSjdmRjB3YzBWenVDRkJWUmdiQzVIRThEQTBCT29VTmxtTVY3dVJ2?=
 =?utf-8?B?bE8rQlpGYmUvMElFcTJ5Qi94eUlZaDViRWZ4SU1EZjBXaFJrWlgzek1tSUpE?=
 =?utf-8?B?NXFkRUpORDkxMHB5NlM4M0I0Nlk5UDM0elA5bHBGdjh5Rzlwc29IYjhMdXBy?=
 =?utf-8?B?N0hEanVHUEFkZ2lnU3NWYU1zbVJjYjNPMkxEVTNRaWFiMHpWMDNxNndmamk0?=
 =?utf-8?B?Q1d4S3dzVktSL1BlLzJVVHMwUGdMMEpsZlVoR2k1d3BwR2R6WEJrOHljVjIy?=
 =?utf-8?B?WDRoSjluWDBWM2tzOUhWNWloMW9pN2ZIa2RQRS85b0s2ZGdhd1hEcWc2T0ZM?=
 =?utf-8?B?aWp2QjJDN3dqcGYxUVcwV2F0NmVWeGVhdGxtaTczRkIvRk1YSVY0TU5VUVd4?=
 =?utf-8?B?UE1hQWxYcTNOK2hGRVhaUGhtMzI3UUtlQ09wSDlrMHdKdlZhRTVlT29la1F0?=
 =?utf-8?B?MXZDdE1Ka3kwWERJdFZwVEFkNCtpTm14V3hoSlRWeTZEMUJvek1JQnZiZHJo?=
 =?utf-8?B?TklzaU0xOTNzT1F4dm1ra01BcytQTWRMTThrTmNTTFBadm9JNUQ5Uk1sbGhH?=
 =?utf-8?B?Q1BYa3k4TlNjWVZnVC9RTFYxQnNBTlIvNndJeWljTndtV3p5d2NaZ0lMM2NB?=
 =?utf-8?B?YW5kSVMwMFN6RzlNaEdJZmNiQng3NmFxd2hKdkR4bmlZQVZTclZUcGxqYktJ?=
 =?utf-8?B?Qm80eGVYR1NMeDBqTlludjA3TE5XelJ6RDZ1cEJPYlZYVi9PY0V4K21vbnRr?=
 =?utf-8?B?YWh0alYrNWhXWXp2amZHd3pxWlkzZ0hyRE05cGJ5YzM2L3lheHFrVnpudEpn?=
 =?utf-8?B?MGdKOE9VYklLWmI3K296YmZ3bXdZT25iQmROQzhIWGVLZlliZ01CWm5WTTY3?=
 =?utf-8?B?bUsyd2QrNkhaRzFZQjczWlhKUXJIMlcvbThuVWxJbVV0RGd4SGJHY2ZjcG5x?=
 =?utf-8?B?aXpsYmY3andvSzZwNUp6RzNNeURjeE9XZGRhZ0hRREpydjhiMml4ZHNJYU5L?=
 =?utf-8?B?NWEyR3hyb3FMRFB1L3o0Y2huOXFHQkdHc0hZZ2YycU03Q2szMkNVMzRlMmxS?=
 =?utf-8?B?RGpXbVk5dHNCN3FKL2Q3YUFEaGdxTGdVdzBEVTFMd3dGR3ZLeHZ4cnd3TS9K?=
 =?utf-8?B?a3E0N3hsUW1rNlJWRHpEQjVvb05ReElERWVlbTZLdEs4NVFBUTFxVWdTcmRM?=
 =?utf-8?B?SUU0NW1OZEh6TjhSOThQTXRiUDNpVmg5ZHpsNjRmR3dpQUpyUy9GTVE5Skph?=
 =?utf-8?B?MmtyZFl3Y0g5VFpxOG5MelJGdUxRdGJRVHlpbUQrRVl4eVNDSlhDVW9yMHRh?=
 =?utf-8?B?YlB6RUN0ckpsRGNMZ0hkSjZiSlVobEF6eURtS3lMdTYzSFRsVlNsRXNPeGxu?=
 =?utf-8?B?VlAydUJHM2hPMTZmUm1Palp6WTd1VDFFV1R6RHozNHllMkkvWENRRCtZdU5J?=
 =?utf-8?B?M3diYkdtOUVtWlgyZnNuenRsQ0ttQ3dJMGdCUWY0V3JWR0k5Tm9QZzVPYVQr?=
 =?utf-8?B?aGxHRFVDRWQxVTc3aXZISktLNld4ZGZRb1hhT2d5T1ppTm5PVENkSmxMMVVV?=
 =?utf-8?B?TjVjcTJTak5zNzNzMU5HaU5kK0xIMWdUVXBNQlhJUEp5NW1LRkVkY0Y3VW1O?=
 =?utf-8?B?RHZvZ3ZESnpQNWZ5MGRsTWdEd01LOEkrMCtJVjdYRWk3MXVna1p3Qi9pS1pk?=
 =?utf-8?B?R1dMb1BLanJLYmhFV0FMR0c0VUNXWVhFbHA3VWsyTmJKNERpNW5KNWZIc3lI?=
 =?utf-8?Q?/WQ0+s66dOtqlRTlSlIe5r2CI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d1c71e-7769-4524-2e8b-08db514b52c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 11:40:15.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4gxWhEF20PKxSTe7R7llMbyqFchXd/mKa5FBg2aDyhIBbPfiVk+gMeaUaVxZdFh9PZlnq7neBmtRrFjhtvZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-Proofpoint-GUID: 20GVorTqlMs88k4pej19a-okAtLBZVur
X-Proofpoint-ORIG-GUID: XjiZzN0eKvwH6eWXV0-EjMtSsboRtPnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100092
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 11:40:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14776

SGkgUmljaGFyZCwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5LiBJIHRvdGFsbHkgYWdyZWUgdGhh
dCBpdCBzaG91bGQgYmUgdGhlIHNlcnZlciBjb25maWd1cmF0aW9ucyAoZS5nLiwgQkJfTlVNQkVS
X1RIUkVBRFMgZm9yIGVhY2ggYnVpbGQsIHRoZSBudW1iZXIgb2YgYnVpbGRzIHRvIHN0YXJ0IGlu
IHBhcmFsbGVsLCBhbmQgbWF5YmUgUFNJIHJlbGF0ZWQgY29uZmlncywgZXRjLikgdGhhdCBzaG91
bGQgYmUgYWRqdXN0ZWQgdG8gYXZvaWQgc3VjaCB0aW1lb3V0IGlzc3VlLg0KDQpUbyBhZGQgbW9y
ZSBpbmZvcm1hdGlvbjogdGhlIHNlcnZlciBJIHVzZWQgd2hlcmUgSSBzYXcgdGhpcyBzdGFydC11
cCB0aW1lb3V0IGZhaWx1cmUgaXMgMTI4IGNvcmVzICsgNTEyRyArIDQgUkFESTAgZGlza3MuIFRo
ZSB1cHRpbWUgdmFsdWUgd2hlbiB0aGUgdGltZW91dCBoYXBwZW5lZCB3YXMgYXJvdW5kIDUwMC4g
VGhlIEJCX05VTUJFUl9USFJFQURTIHJlbWFpbnMgaXRzIGRlZmF1bHQgdmFsdWUuDQoNCkkgYWxz
byBmb3VuZCBzdWNoIHN0YXJ0dXAgdGltZW91dCBpcyBtb3JlIGxpa2VseSB0byBoYXBwZW4gb24g
bWFjaGluZXMgd2l0aCBtb3JlIGNvcmVzLiBCZWNhdXNlIG9uIGFub3RoZXIgc2VydmVyLCB3aGlj
aCBoYXMgNDAgY29yZXMsIEkgaGF2ZSB0byBzdGFydCAzfjUgYnVpbGRzIHRvIHRyaWdnZXIgdGhp
cyB0aW1lb3V0IGVycm9yLg0KDQpSZWdhcmRzLA0KUWkNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogUmljaGFyZCBQdXJkaWUgPHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRh
dGlvbi5vcmc+IA0KU2VudDogV2VkbmVzZGF5LCBNYXkgMTAsIDIwMjMgNjozNiBQTQ0KVG86IENo
ZW4sIFFpIDxRaS5DaGVuQHdpbmRyaXZlci5jb20+OyBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5l
bWJlZGRlZC5vcmcNClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF1bUEFUQ0hdIGJpdGJha2U6
IGFkZCAtLW5vcmVwbHktdGltZW91dCBvcHRpb24NCg0KT24gV2VkLCAyMDIzLTA1LTEwIGF0IDA5
OjQzICswMDAwLCBDaGVuLCBRaSB3cm90ZToNCj4gSGkgUmljaGFyZCwNCj4gDQo+IEl0J3Mgbm90
IHRoZSBiaXRiYWtlIHNlcnZlciB0aGF0IHRha2VzIG1vcmUgdGhhbiAxIG1pbnV0ZSB0byBzdGFy
dCwgDQo+IGl0J3MgdGhhdCB0aGUgJ3VwZGF0ZUNvbmZpZycgY29tbWFuZCB0aGF0IHRha2VzIG1v
cmUgdGhhbiAxIG1pbnV0ZS4NCj4gRnJvbSB3aGF0IEkgc2VlLCBvdGhlciBjb21tYW5kcyBmaW5p
c2ggcXVpdGUgZmFzdCBleGNlcHQgdGhlIGFjdHVhbCANCj4gYnVpbGRpbmcgb25lLg0KDQpUaGUg
dXBkYXRlQ29uZmlnIGNvbW1hbmQgZG9lc24ndCBhY3R1YWxseSBidWlsZCBhbnl0aGluZy4gQWxs
IGl0IGRvZXMgaXMgdHJpZ2dlcnMgYSBwYXJzZSBvZiB0aGUgYmFzZSBjb25maWd1cmF0aW9uLCBp
dCBpc24ndCBldmVuIHBhcnNpbmcgcmVjaXBlcywganVzdCB0aGUgYml0YmFrZS5jb25mIGFuZCBs
YXllci5jb25mIGZpbGVzLg0KDQpUaGluayBvZiB1cGRhdGVDb25maWcgYXMganVzdCBicmluZ2lu
ZyB0aGUgdHdvIGVuZHMgb2YgdGhlIGNvbm5lY3Rpb24sIGNsaWVudCBhbmQgc2VydmVyIGludG8g
c3luYy4NCg0KSSdtIGEgYml0IHdvcnJpZWQgdGhhdCBpZiB0aGUgc3lzdGVtIGlzIHNvIG92ZXJs
b2FkZWQgaXQgY2FuJ3QgZG8gdGhhdCBpbiA2MHMsIHdlIGhhdmUgYmlnZ2VyIHByb2JsZW1zLg0K
DQo+IFRoZSBzZXJ2ZXIgd2FzIHN0aWxsIHVzYWJsZSwgZXZlbiBhZnRlciB0aGUgc2Vjb25kIHdv
cmxkIGJ1aWxkIG1hbmFnZWQgDQo+IHRvIHN0YXJ0Lg0KPiANCj4gSSdtIG5vdCB1c2luZyBhbnkg
c3BlY2lhbCBjb25maWd1cmF0aW9uLiBBbGwgZGVmYXVsdCB2YWx1ZXMuIEkgZG8gaGF2ZSANCj4g
ZXh0cmEgbGF5ZXJzIGFkZGVkLCBzdWNoIGFzIG1ldGEtb3BlbmVtYmVkZGVkLyosIG1ldGEtIHZp
cnR1YWxpemF0aW9uLCANCj4gbWV0YS1icm93c2VyLCBtZXRhLXNlY3VyaXR5LCBtZXRhLXNlbGlu
dXgsIGV0Yy4NCj4gQW55d2F5LCB0aGUgdGFzayBudW1iZXIgb2YgYSB3b3JsZCBidWlsZCBpcyBh
Ym91dCA0MDAwMCsuDQo+IA0KPiBJbiBmYWN0LCB3aGF0IEkgcmVhbGx5IHdhbnQgdG8gZG8gaXMg
dG8gc2V0IHRoZSB0aW1lb3V0IHRvIGJlIHNvbWUgDQo+IGxhcmdlIHZhbHVlIG9uIG91ciBhdXRv
YnVpbGRlcnMgc28gdGhhdCB3ZSBjYW4gYXZvaWQgdGhpcyBzdGFydC11cCANCj4gdGltZW91dCBm
YWlsdXJlLiBJZiBzdWNoIHBhdGNoIGlzIG5vdCBzdWl0YWJsZSBmb3IgdGhlIG9mZmljaWFsIA0K
PiBiaXRiYWtlLCBJJ2xsIG1ha2UgaXQgYSBsb2NhbCBwYXRjaCB1bnRpbCBvdXIgYXV0b2J1aWxk
ZXJzIGFyZSANCj4gY29uZmlndXJlZCBtb3JlIHByb3Blcmx5LiBEbyB5b3UgaGF2ZSBhbnkgc3Vn
Z2VzdGlvbj8NCj4gDQo+IFRoYXQncyBhbGwgdGhlIGluZm9ybWF0aW9uIGFuZCB0aGUgYmFja2dy
b3VuZC4NCg0KV2hhdCBpcyBCQl9OVU1CRVJfVEhSRUFEUyBzZXQgdG8gYW5kIGhvdyBtYW55IENQ
VSBjb3Jlcz8gU3Bpbm5pbmcgbWVkaWEgb3IgU1NEcz8gV2hhdCBhcmUgdGhlIHN5c3RlbSBsb2Fk
IG51bWJlcnMgd2hlbiB0aGlzIGhhcHBlbnM/DQoNCkkgdGhpbmsgdGhhdCBpZiB0aGlzIHN0YXJ0
dXAgdGltZW91dCBpcyBoYXBwZW5pbmcsIHRoZXJlIHdpbGwgYmUgb3RoZXIgaXNzdWVzIGFuZCB5
b3UgbmVlZCB0byByZXNvbHZlIHRoZSBvdmVybG9hZGVkIHN5c3RlbSBwcm9ibGVtIHJhdGhlciB0
aGFuIGp1c3QgbW92ZSB0aGUgdGltZW91dCBwcm9ibGVtIHRvIHNvbWV3aGVyZSBlbHNlLg0KDQpD
aGVlcnMsDQoNClJpY2hhcmQNCg0K

