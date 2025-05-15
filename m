Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A9C3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 03:29:26 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.4953.1747279765364466174
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 20:29:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7230864b24=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F2mEpO023669
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 20:29:25 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbca23su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 20:29:24 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54F3TOKp020410;
	Wed, 14 May 2025 20:29:24 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbca23ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 20:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS0BkSj78rO3OjXDHFOlv0RNiq6xlUNQ5XR6X9tj5c9YOnasmoZn7T45wKYhMpXCIcMu/NJ/0IPTQqpgpZoeYRiy3/VNGgpW6aZver0ahChJHplT4nfJ8/WtyE0Kjy1jiG/GaCyf54VyHSTHgrTBYjRXyHNv58JJxNQIzTX14yjL/C4Ao7XL+4wLA5/H2gTRM/kK6VAa4ingK/oOmgB2ZQh12qbtuue/tAq63VzfJ8Gq7QisULwd7cejDusx3wj+D5Uz+H4q7DXOMD1zdeDG3STdwBjGG+9HMtjaV90W4kdTjFkZL5/22fN4l4JWqxRT2f9b6xb/FeVeokttSpYlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+IDfw+OpXJEkai4Uso3+Id3Ur9Kd4KuzFXKVMKycMU=;
 b=zUXBpIga2qsPH8Bj/RkEzUYDngOtIrc/aVsueeB/UYk/JVp6WgNaIHxPrjwkDKk+eSdNgySkLAeX/4vtpsDmhlPxBIOatDRRPwZ9Gikc+cVPMEKOBuZJeOYEJ2Ea0fMwrhQ8pny15ZztfrUsDlhLRIy5ysK1mto/g0zuCPMIGg29DNl81Y5JGs0H49WjqmYQK5SqfNqrX32gd2cLlS2f3fxLBaMui0UDzQ8axB65m20312QYpnxR2w3GypFZ/1fpXhbXuQlBIr29760JKmBaEgSrGKcrB5RxL87Jxd6YaqSYcmWlYUsiTraBupBKwSEtlI7JppOlx5Q3IwMmwIg5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 03:29:22 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:29:22 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: "raj.khem@gmail.com" <raj.khem@gmail.com>
CC: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
        "Yang, Liezhi"
	<Liezhi.Yang@windriver.com>
Subject: RE: [bitbake-devel][PATCH] fetch2/git: fix shallow clone for tag
 containing slash
Thread-Topic: [bitbake-devel][PATCH] fetch2/git: fix shallow clone for tag
 containing slash
Thread-Index: AQHbxI5XTAdDrQKG6Emsxx0pMBhfr7PRqc+AgAABSgCAAK2vAIAAsQsQ
Date: Thu, 15 May 2025 03:29:22 +0000
Message-ID: 
 <CO6PR11MB56029C6C19AC445F913698D2ED90A@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20250514050900.2096691-1-Qi.Chen@windriver.com>
 <49e877afefd86763dc916c0f5f6445026986c752.camel@linuxfoundation.org>
 <b680eae5-c7c5-4fdc-8934-d4f8acdfe7fe@windriver.com>
 <CAMKF1sria5rq-i_d=MKcqNgfH0t2azWyYR380AeXgviXeT+9mg@mail.gmail.com>
In-Reply-To: 
 <CAMKF1sria5rq-i_d=MKcqNgfH0t2azWyYR380AeXgviXeT+9mg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: 6c234b35-ce6a-4a98-d357-08dd9360af56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Q1o1bmhCbEZQZXN6eURSdCt5SVAwYTA2NUtDWCtEZFFIa1VpRWIrbE1NaFha?=
 =?utf-8?B?cFpqTFp6UFB5cnJqM2lnOU1vTUswd2hWWG0wQmhvaUpYZVZQeFBRZHdKR1pk?=
 =?utf-8?B?UHl5cnpUNlpJZ3p5TXp2Sk1peGhpMTVmV2FKS2poTG1VSkcrKyt4anlOSHNI?=
 =?utf-8?B?VzZHSFAwaXZ0YUFpcVhiVlZacDJRRTlVd3QzU3piMWpUWXVHT0ZmaldFL1BH?=
 =?utf-8?B?U2l6Tzg3M21uZWZ1UFlYTUdzOHZwRzREWG44bS9Ib1g0V3Jvc0dBSkVUTmlt?=
 =?utf-8?B?dkFndUtqYjB3cG02V2daeUdOR2s3L0RtMXV4SnNrZ1d3YmdyVmliVnZ1cldx?=
 =?utf-8?B?NW91R2FyM0drbWVDRTB0M1pUblhIREJQY1d3czNLdFdkK1lpaEVpVkdJVGdD?=
 =?utf-8?B?b3dpUTMzT0tXWUxCUXlncUpnd0REU09TTHFHQUJ0Y1FaSDZQL2hxQjVETzZI?=
 =?utf-8?B?TW5ydTljQzI2eWhxUnVuUkJ4OFdNZm9RNGtmY3lWNFEyZUFFWmorY095SjR4?=
 =?utf-8?B?QVJ1d2k3MUduakJNaXBpS1NvM2VIc29VRmN3blU1ZUVBcjNWZ3VUM3l4R2Zl?=
 =?utf-8?B?aVZsYTZDdmhqV1R3SG5TSEU5SytQTjdrN1RySXJ1bzQ0ZDF5NlRnRktQdkZj?=
 =?utf-8?B?WWtxYytLMVorZTQ4Q0NZVWpVOGI2OTJGWFBpMk1jYVgxVDVmNUJhYk94YWty?=
 =?utf-8?B?Tk1XOTFFSWl5QUxCcUFuMW1BM1JqQklFRFRWak9XNHVxY2YzRTRWbW9hdmM0?=
 =?utf-8?B?dUlHTTJhRVlHQk1jazdkTEtWSkhMd0ZQZVZMRDFjZEFGWFRMWE5hanIrK1hX?=
 =?utf-8?B?RDJLODVzeHFWSEZXR2lBT3ErWGRudUh1dU5UKzlLd09OV0pEQitFMXlXS09I?=
 =?utf-8?B?MkcxWWVCdzNsSEIxWmtyTGg0REFsNFhxWXNlL2Izclp2eHZ3UkY3a0xEM202?=
 =?utf-8?B?UWpJN3I3UGZTUTBTa2I0ZlF1eUplMjdEQjNpMGltSHMrcmFsK25sblpybG1B?=
 =?utf-8?B?KzJQV09HSWE4OS91SGR0Q1dhRUxnODVpZER2SlhiMGk5Zm5IOVljQnJqQmlN?=
 =?utf-8?B?ZDJGSmhEQVRGR3VGZ0xJbmwzSTJ6YW9PTlF6M3doNFhLUjlRVm0zbjhUU0VM?=
 =?utf-8?B?ZStlaEhZRC8zMWZhWm0rMHRQREZQL2UvSTcvOWNaTGlCY09DTithaVhqRFdL?=
 =?utf-8?B?Ym05V1dJNU0vN1VIVnpqSWdzVFYwcms3NHFnUGxZVzRSR3NXemk0Q3NCaUZQ?=
 =?utf-8?B?U2lPaDZRczljaTBWRFFJSUdXcUVDQVdINStzdzNab0NETnB3YkxUTUJrQ2ps?=
 =?utf-8?B?VlQ1cG1KVlUxV3I1b0hIbVI0dE83T0VYenNqK2tnazlEdGpiN25aNTdyN3Q5?=
 =?utf-8?B?SGdBNGk5WjZLYzRPQmJuQUwveE1wZ0VrSFJFWVBrTGZqQkRBVXNiUGFlaTYy?=
 =?utf-8?B?T3oyZ0tvVmFwOTBIOHFMM2xrWkQxT3FjRkpzODZuNHhGcmYrOWpGSWZPTlNv?=
 =?utf-8?B?WDVZa1ArYXJOMHRsUThYWGl1cE5lTjdVYWJvRzBNVWRseWxUQUs4QUY1bW13?=
 =?utf-8?B?d202SStrWHE2S0ZINjhNL2lCTVVneTNDbUtRY0JMRkYvZHNWTjlKQk01MUcw?=
 =?utf-8?B?cUVYUU01STZtYlFnNkR3LzlMTUN5N0k1S2ZZQUVMMDNrV2ZRczJ2ZGdGaHdj?=
 =?utf-8?B?TTBIcGd1OVhxNUpEc21ScnZJMnBkMVhtQmNWT0Q2YzlqbHFkamloT01LMFA5?=
 =?utf-8?B?ZTc0UUluOTRRNmRRcEQxVFZFdHZLREJuVmZkU2VUZzVxV1FMNmNpWUV6WEZl?=
 =?utf-8?B?UVd0SzJ6MlpubGQvNTQ3Y1lXdXIyT3pPMUllUkhhOHl1MlA3aTFSRldUeUpJ?=
 =?utf-8?B?Mit4RUtabkJ5a09SSGV6d1pKcWpXOFU2bXNhQ3RVQmJyTHQzRXpQTkppSnFN?=
 =?utf-8?Q?OlP8ydf8NG4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eSsraFZrc25yZkhCRWpTUXR2SGlNaXVRTGkrKzE4ZHB4NzFER1ZVUk0wYnJE?=
 =?utf-8?B?MFhTVlZieXhpSEJ6VC9NeGdRSkdxVlZkV2JuUk9HNzhvamZnYVQvM3RIZzE3?=
 =?utf-8?B?REJ0TGM1OHVqaUkxNmE0Tks1aFQ1RzJ3RWtjazE2SmdKeDFod2JOZ0RyeEVM?=
 =?utf-8?B?OWc1RzUzMm5ZQkZuelN6REQ4QUdxWk5JTDBYYzR5L1pZRU9LTFZTckFUVmh2?=
 =?utf-8?B?WjhNa3gvTkVWUG9iNU1wa3hKS2d0M2JOMUdmbjE3TDFta1d1QTIyT0g5UWVD?=
 =?utf-8?B?UXJ6MmZNYXJjelpHQUNpZGxON0JOWHIxNktUT3JSaHRtbFdjekZLUkYvRnlP?=
 =?utf-8?B?aE9wMENjZy8vQzE4SGtEdmV0UzNsQmFPNHlIV3hnaU9GVUxxVFoyOXZhSFJD?=
 =?utf-8?B?KzlLV0JPVW5iK2U4MVl2NEFVblpoRTZSVnJod2NDQkFIR0xVaUgvSnpSQllp?=
 =?utf-8?B?dmRMVWN2MjZXcnZOa216WUhZVTlOY2xGOTZ5eUluaytaWVdzNzErcmQ2UXJr?=
 =?utf-8?B?T1VpSDRGYUZFZ2E0b01HQVNFYXUwZnVBbnJFZWxscUl5RTRaSm40NEtZRFda?=
 =?utf-8?B?ek5SelNtQ054cTE4b3RWVWNKRFNNeFpocUI5aUFwUnMyOTBGWm1FenhkWlVW?=
 =?utf-8?B?MHVlUXdPMDkzMFZJWTFZZ1NOc20vUG5vU2V4anE2R0pVYWtaSzJQRWNjMXl2?=
 =?utf-8?B?SXNqWU5sOHhyZ1pTaHRwemRwZnJRaksrbnQ1WkF4VjBiZ2FXbFFvc0RxOEFN?=
 =?utf-8?B?TnQveUxYZk1OMnRYSWtrMHkrZk9nMmV1d2NqRDl6QmF6QzRGcXVYNDdQSmxP?=
 =?utf-8?B?cWl4TVJWQ0NYRnhZNURzRUJjOFdYcWk4YXRBY0YyUUMzcDY0b2Z4VWpVdUgv?=
 =?utf-8?B?a2VpS3ZEOWVSRktIVGQ3TWV3R1RJYzVWY25waDJCbFBoSENTNUVzYUkyOTY0?=
 =?utf-8?B?b2NrSmcxMkZWa0xFbC9Gb05naDdCbFkzNnBETHBSWkZlZkdMQ2tIUEpCeDJT?=
 =?utf-8?B?SWFVVUhtQjdmZTBkQ3pWR2lFNGlra3FBYlczSXkxQlh4VE1KUTRCTHAvQmtt?=
 =?utf-8?B?eTZVZTEwekEvbVZZSHM3VjkvOUpSbzBGMUpvS2dHd1NabEplajM2YjI1alor?=
 =?utf-8?B?cDc3aG1SdEhVdkdLZGdjOFhJV0hQdzhoMmVxMFRJN0NBRGF3ZXhOaVRXVnMw?=
 =?utf-8?B?R3U2bE5YUlhVSzM2Z3ExY2ovb0FWTHV5ZkpLWXkvMjNmenRBdHdlZFFqNDFC?=
 =?utf-8?B?TTJ6bzA0eGdnZ085K2g2SzZjSWREV3dyK21SVDZWdUVVS3V5RXdleFhRWkF6?=
 =?utf-8?B?Sk93c0lRYTE5OVFwemRvbjBMV1VtZEJwZE1wQ2dqRzg2OTJ5azlWWE1Ocktm?=
 =?utf-8?B?OFNDbDl5aGRnclBhRGJ1NVJjeThXMVVUZHJwNjZBckdjbGhDeXRKYUZvTDZZ?=
 =?utf-8?B?UnhJSzVJNTVWL3dUL3AvVzB3R0trUkVOV0E5a1VvWmNGVjNxNGZudWxLRC93?=
 =?utf-8?B?VnhRVzVHdlJaUGhMSUc3M01oaGZROG9yNElGZTR1SlVNdTF4Qno2N3RXODFZ?=
 =?utf-8?B?TWp4ZzFDRi9Lb2dteUdlQnBaR0NwNDAvY1haNStjRVNuSXVoOXN1M296WlhU?=
 =?utf-8?B?N2FqWWcvcFpHY0QrYWN1ZHNLbkVaUUtCYVVpL0JRYk5jTUFJU3JWNlN1c204?=
 =?utf-8?B?bHRMamJ4Q0FNUGZmenZZVWxnVUJ4bUFZSXNVeFV5Y005Q2tOZlpCdzdaS0ZP?=
 =?utf-8?B?Q29mSk9KUUhZK3RZVWNjRHhqN1JuczVrTjY1dS9CbWRSSTNZbUJYSTFLWmh2?=
 =?utf-8?B?TWpLWmJ1bHI2SjQ4ZlBVYS9wQXRScEc3VmJaUHUzT0ZiMUtpbzZpcTJNU0ph?=
 =?utf-8?B?VFZEZUxaUHozQXptZERjSmx5SUpmME54cUloN3F6Q2w5VWhES0dOdEtudmV1?=
 =?utf-8?B?bDd4NEd4andtcnVWR1dFaGk3Y1VldkI1WXBQY0NMbi9rRmsyL1NnbWdjNllZ?=
 =?utf-8?B?cmVlZzBjUitzU3V1ZkJkZHJ0NVQrZU5KTU81ZUxYQ1A1UzFBWmk0OEJmQjAx?=
 =?utf-8?B?V0FCQTJlU0JHUDQxQks4M0ovcEpybERBM242QmxBWVRwcEFpOFlHU1lvMXl1?=
 =?utf-8?Q?uUcvZCu7mjSuWSmjvK+yRbAMC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c234b35-ce6a-4a98-d357-08dd9360af56
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 03:29:22.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kktnvOxUfVFzQmw8WQrJuJBxZDfwSmFyf8TE7TDl4C4dJ7J50rXF0nk9XiTFy7Nemog+5SlE38JPr5PCEO1wHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-Proofpoint-ORIG-GUID: 4wGKGKwHjSuBYJVvjzp8zdy6pnuJA8WC
X-Authority-Analysis: v=2.4 cv=P446hjAu c=1 sm=1 tr=0 ts=68255f94 cx=c_pps a=DnJuoDeutjy/DnsrngHDCQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=ageTkQx_Iwc3BMkOQMUA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: NmhCHprIZ_Z1tGJlE6D4ni3j8ejlL46y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAzMiBTYWx0ZWRfX9KmlpAHPxOtu 6gUKC/ykeBnkabKhBRBFVtGGlWT2q9q82Qst2N3UDxJijrFfbjkUIDVK8HuxilTCubmduhvXkqb CjJHLlJYA0MHvRfh/kGoMcMfswQLwOwFrl1tnhxz7592OTABSCnZGW/dCcffMnZgkrsvJoXK/tu
 Lb+cZPyfTROVCNdmvab/Yzczqg6smdYaxbEuQewPSn15SJhNqskwaddvKoPA3iuto5JjiyZjuNM tFwQ+XFTtdaHE2LMXZEnRd4RDSGgxKLiQHSwueKGTn0pFCqfpHZWSSH3EidTP1de4F/eIvl/qCr 24itVWAOys3mug4YagMj8CFualDxN0xfG4m/wmZ2Pnz+/T6dMGy+h2tN8+XH2ETSl0Pu6mOO8Jb
 qPMTZZBVJNn9e1vyNHA1KINE7NjBDsFhvmY7JQocqbDP4pQPmsDJj+r0fh/GYe8jmi8NShtW
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_01,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505150032
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:29:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17615

VGhhbmtzIGZvciB0aGUgaW5mb3JtYXRvbi4NCkkndmUgdXBkYXRlZCB0aGUgY29tbWl0IG1lc3Nh
Z2VzIGFuZCBzZW50IG91dCBWMiBwYXRjaHNldC4NCg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRl
ZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gT24gQmVoYWxmIE9m
IEtoZW0gUmFqIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQpTZW50OiBUaHVyc2RheSwgTWF5
IDE1LCAyMDI1IDEyOjU1IEFNDQpUbzogQ2hlbiwgUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4N
CkNjOiByaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnOyBiaXRiYWtlLWRldmVsQGxp
c3RzLm9wZW5lbWJlZGRlZC5vcmc7IFlhbmcsIExpZXpoaSA8TGllemhpLllhbmdAd2luZHJpdmVy
LmNvbT4NClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF1bUEFUQ0hdIGZldGNoMi9naXQ6IGZp
eCBzaGFsbG93IGNsb25lIGZvciB0YWcgY29udGFpbmluZyBzbGFzaA0KDQp0aGVyZSBpcyBhIGJ1
ZyBhcyB3ZWxsIC0gdGhpcyBzaG91bGQgaGVscCB3aXRoDQpodHRwczovL2J1Z3ppbGxhLnlvY3Rv
cHJvamVjdC5vcmcvc2hvd19idWcuY2dpP2lkPTE1ODYyDQpzbyByZWZlcnJpbmcgdG8gdGhhdCB3
b3VsZCBiZSBnb29kDQoNCk9uIFR1ZSwgTWF5IDEzLCAyMDI1IGF0IDExOjPigK9QTSBDaGVuIFFp
IHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxRaS5DaGVuPXdpbmRyaXZlci5jb21AbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+DQo+IE9uIDUvMTQvMjUgMTQ6MjgsIFJpY2hhcmQg
UHVyZGllIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAy
NS0wNS0xNCBhdCAxMzowOSArMDgwMCwgQ2hlbiBRaSB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9y
ZyB3cm90ZToNCj4gPj4gRnJvbTogQ2hlbiBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPg0KPiA+
Pg0KPiA+PiBJZiBhIHRhZyBjb250YWlucyBzbGFzaCwgZS5nLiwgZGViaWFuLzUuMjIsIHRoZW4g
c2hhbGxvdyBjbG9uZSANCj4gPj4gZmFpbHMgYmVjYXVzZSBpdCdzIHVzaW5nIGEgd3JvbmcgcmVm
Lg0KPiA+Pg0KPiA+PiBUbyByZXByb2R1Y2UgdGhlIGlzc3VlLCBhZGQgdGhlIGZvbGxvd2luZyBs
aW5lcyBpbiBsb2NhbC5jb25mOg0KPiA+Pg0KPiA+PiAgICBCQl9HSVRfU0hBTExPVyA9ICIxIg0K
PiA+PiAgICBCQl9HRU5FUkFURV9TSEFMTE9XX1RBUkJBTExTID0gIjEiDQo+ID4+DQo+ID4+IEFu
ZCB0aGVuIHJ1biAnYml0YmFrZSBkZWJpYW51dGlscyAtYyBmZXRjaCcuDQo+ID4+DQo+ID4+IFdo
YXQgdGhlIG9yaWdpbmFsIG9zLnBhdGguYmFzZW5hbWUocmVmKSB3YW50ZWQgdG8gZG8gaXMgdG8g
cmVtb3ZlIA0KPiA+PiB0aGUgc3RyaW5ncyBzdWNoIGFzIHJlZnMvaGVhZHMvLiBTbyB3ZSBkbyBp
dCBleHBsaXRseSB0byBmaXggdGhpcyANCj4gPj4gaXNzdWUuDQo+ID4+DQo+ID4+IFNpZ25lZC1v
ZmYtYnk6IENoZW4gUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAg
Yml0YmFrZS9saWIvYmIvZmV0Y2gyL2dpdC5weSB8IDIgKy0NCj4gPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBh
L2JpdGJha2UvbGliL2JiL2ZldGNoMi9naXQucHkgDQo+ID4+IGIvYml0YmFrZS9saWIvYmIvZmV0
Y2gyL2dpdC5weSBpbmRleCAxMWNkYTIwMDdkLi43ODRhNDViZGEyIDEwMDY0NA0KPiA+PiAtLS0g
YS9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvZ2l0LnB5DQo+ID4+ICsrKyBiL2JpdGJha2UvbGliL2Ji
L2ZldGNoMi9naXQucHkNCj4gPj4gQEAgLTYzOSw3ICs2MzksNyBAQCBjbGFzcyBHaXQoRmV0Y2hN
ZXRob2QpOg0KPiA+PiAgICAgICAgICAgICAgICAgICBleHRyYV9yZWZzLmFwcGVuZChyKQ0KPiA+
Pg0KPiA+PiAgICAgICAgICAgZm9yIHJlZiBpbiBleHRyYV9yZWZzOg0KPiA+PiAtICAgICAgICAg
ICAgcmVmX2ZldGNoID0gb3MucGF0aC5iYXNlbmFtZShyZWYpDQo+ID4+ICsgICAgICAgICAgICBy
ZWZfZmV0Y2ggPSByZWYucmVwbGFjZSgncmVmcy9oZWFkcy8nLCANCj4gPj4gKyAnJykucmVwbGFj
ZSgncmVmcy9yZW1vdGVzL29yaWdpbi8nLCAnJykucmVwbGFjZSgncmVmcy90YWdzLycsICcnKQ0K
PiA+PiAgICAgICAgICAgICAgIHJ1bmZldGNoY21kKCIlcyBmZXRjaCBvcmlnaW4gLS1kZXB0aCAx
ICVzIiAlICh1ZC5iYXNlY21kLCByZWZfZmV0Y2gpLCBkLCB3b3JrZGlyPWRlc3QpDQo+ID4+ICAg
ICAgICAgICAgICAgcmV2aXNpb24gPSBydW5mZXRjaGNtZCgiJXMgcmV2LXBhcnNlIEZFVENIX0hF
QUQiICUgdWQuYmFzZWNtZCwgZCwgd29ya2Rpcj1kZXN0KQ0KPiA+PiAgICAgICAgICAgICAgIHJ1
bmZldGNoY21kKCIlcyB1cGRhdGUtcmVmICVzICVzIiAlICh1ZC5iYXNlY21kLCByZWYsIA0KPiA+
PiByZXZpc2lvbiksIGQsIHdvcmtkaXI9ZGVzdCkNCj4gPj4NCj4gPiBUaGFua3MsIEkganVzdCBz
YXcgYSBmZXcgcGVvcGxlIHJlcG9ydGluZyB0aGlzLg0KPiA+DQo+ID4gV291bGQgaXQgYmUgcG9z
c2libGUgdG8gYWRkIGEgdGVzdCBjYXNlIHRvIGJpdGJha2Utc2VsZnRlc3Qgc28gd2UgDQo+ID4g
Y2FuIGVzdXJlIHRoaXMgZG9lc24ndCByZWdyZXNzIGluIGZ1dHVyZT8NCj4NCj4gR290IGl0LiBJ
J2xsIGFkZCBhIHRlc3RjYXNlIGFuZCBzZW5kIG91dCBhIG5ldyBwYXRjaC4NCj4NCj4gUmVnYXJk
cywNCj4gUWkNCj4NCj4gPg0KPiA+IENoZWVycywNCj4gPg0KPiA+IFJpY2hhcmQNCj4gPg0KPiA+
DQo+ID4NCj4gPg0KPg0KPg0KPiANCj4NCg==

