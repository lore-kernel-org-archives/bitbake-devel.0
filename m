Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D103E7E644
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 14:39:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.20915.1695739185390738245
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 07:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kKtccCUl;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7633c6df23=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38QBvYDV016267
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 14:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=0rsvrL21foD38eN8GhW6HldN9Lx1enfVBc8X+LkLpDs=; b=
	kKtccCUluSaPrIr8WCdc+usRogDt/TwAy+bapZNR02HGtR6WlNyg/F7WNUqUkdTK
	5Y15IrKcsqNFm5f/BQrBwFaaA5UCksqHieLWsMNw1o9NbnLV344xkiTIewRQsj1Z
	6G7Vv80foE10MG4YFcwHptGYOSh5sgTzSUEdihOHH2TGJufb8rm+ukSEAJIteqyZ
	SO7au61rM0rPg6opcMY85jXJs8Bie5SFzW03NnX09bptohnEW0i7ZDflW5OLEKMA
	jldnRSNfGySx+P46OSwTyyzrsecNAyp8iG3hktzeKjWMVaB+4fgmxxcym7sDZesn
	TyithtjhecGVLuEoBycRbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9q06at28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 14:39:44 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 38QEbSH2016839
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 14:39:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9q06at27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Sep 2023 14:39:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EinhhGvpxq5nEuJx0lcy+PHycYInSSbwGzlvNqA1MOSgN0Np7De2mzkO1R5sUscK9c+2regK8MwpXFk9NpdfE57r8pxa/9WPwBDnAhSHu18GKWuieWI6KFRWUODFTP+hH+/idbWWCZkwlSmRG7gUQG9rJXD0MXeSf2efJVoAeKDdb4jeSpi5aKjGDOT+bkLcY8TKyWyr//JsU4QnqRpvzrTjNPY1O8Q1ZmKCq64lI5DbkpbrDGO9feMWAn33+06wTMl3U0pFkQqeaBA5VwX7bBNhiHeMmsFF21kHOE9WATP7qJQRoyzdeSdE4o3zDnF/y8KOVwpQXCaTTlPKDy+JHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rsvrL21foD38eN8GhW6HldN9Lx1enfVBc8X+LkLpDs=;
 b=Y0bx6Wf5S/M6zVhHrBD6sWWITA5jC5HOijRX/0jbeDpPwG9xUp9nK//ZX9YqoJ3EHtVBc7evV3zqgrnjzpzunNb/5rswxJogmknWLvD3yhrILf+nCRwWDtMkX70Z0dYrW6PX5yRzd6YL6VTcuMIJaTrt/qsZidgpF60ezst0IniSCAU73h0Af1mY1+syRjY9q6P0I9Hi0VVqs4/kwEF5JQY3wk3HhCjCzsiEKzTBYcfRvc/0edBb+HdRI+41yzz3Z9otn3NHu296tvrIks0ZiA6bswY2gJIk+F0yaH5dKfLCSmmYbv2f48J94iBnpsOykfH8iqSjm4+ybzagsqfzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.33; Tue, 26 Sep
 2023 14:39:40 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::da88:58a3:bc6b:2e3d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::da88:58a3:bc6b:2e3d%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 14:39:40 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH 1/2] bitbake-getvar: further supress
 warnings when quiet option is supplied
Thread-Topic: [bitbake-devel][PATCH 1/2] bitbake-getvar: further supress
 warnings when quiet option is supplied
Thread-Index: AQHZ8GJKSwQapHYjSE28JSup/lFd/LAs9/0AgAA1HJA=
Date: Tue, 26 Sep 2023 14:39:40 +0000
Message-ID: 
 <CO6PR11MB5602F8E71F64BD78BE57E334EDC3A@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230926101440.3610057-1-Qi.Chen@windriver.com>
 <289e9d07fda1186f4f01a753a81c5cfc05ddccb2.camel@linuxfoundation.org>
In-Reply-To: 
 <289e9d07fda1186f4f01a753a81c5cfc05ddccb2.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|SA1PR11MB7700:EE_
x-ms-office365-filtering-correlation-id: e60afffc-0137-49ee-9a4f-08dbbe9e6aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /Ld+atU8bmhU5AywN6pskxFKLj1uBX1mIrvCbp1Iiak9vigEAa+QoNSN6dDyTjscZMcmCau1YSrLBnEOYtVTxhj7G3gXH250mIpmT9uYNxWP9mdUNFJsqrjqTittsnL9sSjnVift6AB+n41q2ZSj6cgDm9xyu3FNX9sOpnjPlppGdauuA0VCCcrovxQ1qbLwqYwYnwOj6avBV10YEkRSny6s1QH5LMfKWoUzk10Ro4T296SjTl/7JErZ2Y58ANoCNCmqPhijVDMKMdnZQv/5BeGcP3J3gyjRw2/eiudocEYlabD6j7B15M42WV8ii9tAVB9KXbr1c5hpvutqzOvPVEmH+oPlhbEoojzEK6/h4Cjfw+DYS573rKvA/kycEaohxxF2ggSe5PG0jEcCZtau+Peh/zaSp+IST0cwOL3ybfKl8g0zDsbJ5OExFwF5OAdNSUe41eBxH6Cg9201f8lbXy95y2/bGZbvi4DuSs1dp1g2OsZgPjOuMWxgWAvREr/9IHsGq7HddIsMbG9gJ4tFrVai2Jfh+LyPoEaTTym06A8/F3UcN8mKoFdp2izmBtNjoJ403FlsS1Qr8GdFKwW/59kL5Kw3sILtaeRRNtSM3K/3qPbLEUlSys43/8NWpqnm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(478600001)(38100700002)(55016003)(7696005)(6506007)(53546011)(9686003)(26005)(122000001)(86362001)(8936002)(4744005)(2906002)(5660300002)(52536014)(66446008)(33656002)(71200400001)(8676002)(110136005)(41300700001)(76116006)(316002)(66476007)(66556008)(64756008)(66946007)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aXNPcE9ta3ZxeHYrNHArbjhHbDU0WTV1bXcvNXovRDVBT2RrOE9lTGVFRjE3?=
 =?utf-8?B?QzFaQ1gzVXFsN3lkVTlVU2l6SE9sRnRsQmJ3ZXZKMXdQUW9WdVB6bklMaUhC?=
 =?utf-8?B?RVJFUHBtRDBYTWU1aUdJdmtmaFprclR6S0tpWlRBUEd6cGhCREVJUXUzbEh6?=
 =?utf-8?B?UDlKTmlPakcrQjNpQ2VCOUhBNHI3cmhZVGlVaDJoUGxnOVR0NkxZanFxUXJC?=
 =?utf-8?B?NVp2Mkhka0xkaFZSLzljWHhXVHFub2tZMzJOSGUwUVI1amRKRllZaitBY0p2?=
 =?utf-8?B?OEl6Zm52WjlUWTdOWHJkRGwwRjJtNWtKNFVnV0hXY2Ewc25nZTBzN2dwajFp?=
 =?utf-8?B?R3RPb3J1NmR6RGtRdVNRUjNLYjJVeVBjNGQ1dVl4dHE5NGxlUUJWTk1qKysv?=
 =?utf-8?B?d0h1RnRGOHQ3aGxQYTRUYnFCci9RS0NmV25vNU82Zk5udkUydmgxWk00ZEg3?=
 =?utf-8?B?L2hBSGY2V2lOV2t2bElBSXArRHlaN2FoYS9XM1NwSytNUVJSWGY3UmtnZFYx?=
 =?utf-8?B?WlFnNGxRQzBIWVZBWGFhdGZqdmM1ejVoTStsVmtVN2oxbHNoek43OXFsK1B6?=
 =?utf-8?B?amtMZlcyYlpUdmpXREtrRDBNWkVvZ2xJcEprVlVsTG9pcmwxbmJxUWpHY0Jh?=
 =?utf-8?B?NkpjNEJHSm5selNRTzJURlVQT0dPVmFTM21POUdOVzJHTW9BeHhUcnZFRUVw?=
 =?utf-8?B?RWVpT1BmZUl6V0RiUTlSV3kyOUl2d0lQMzRqaC9YekVuQzlqVlkwVm9vT0sy?=
 =?utf-8?B?NkFlYXd4T2QzZ3lHVXRFMW4zbzdxUEJ2bWIxNituTHMrVmVFQXRwQXVTSCtz?=
 =?utf-8?B?NXAvMk1tcjZXSTVLc1hjVkQ1TFo0dkRKTDRyM0MvREh1emhraXJ2L2hGd1FG?=
 =?utf-8?B?OWRQTEQwaEpvdFdmcTkrbm11b3QrTkxnZy83TWtHRUU0R0RjTXkzQjJtdy9o?=
 =?utf-8?B?d2hXTnZRZHE1NVA3UFMwaTVmb1MwRWZMSGZuRGgrR2F0aXcxbVNCRkNkL3FZ?=
 =?utf-8?B?Qk9qMVV2cTlHQTk3aFR1TFFZbHJMamg3YWNxbmYvRi9mMTJRUk5uTy9laVUw?=
 =?utf-8?B?RExhWjlCS0pRcS9oVTFtdGZXazlnakREWWMyTzF6bVZHeHdSZU5QUDU0cFZQ?=
 =?utf-8?B?SFpPazRNYnNDdXJvZC8vQUl4U0xpckZ3bU1pYTNDWTFoWUpNcWhNc0hIYTVH?=
 =?utf-8?B?dldPMThaS0I1M3NYZDgvUmdjQ1dkZ2l1bDkwb1Y1TjJpc3J0UE82a08zc2Vz?=
 =?utf-8?B?cGpyQjAzOVVOK2tQVW1HMzBBcko0c3p0dUpDU2NOSmZrM2xvQ3cwcXhqQ1ZO?=
 =?utf-8?B?TU1nZ0JaWnlTOXp6OWxIME4wZ0RkSm0zeEJOaG9iWkxSY0hMRnRWWUptVkF4?=
 =?utf-8?B?ZWYvUlhPbnFXMlFCNlJSZTFvV2E1VTB3NWQvTUR4SW5NYXpKZ1FpWlZnV3Ur?=
 =?utf-8?B?QVJ0ZEJ3NHljczgxZVJMUG9nNUhudFhON1FWczVpL1hFR1F0cmoxaEdXckNM?=
 =?utf-8?B?eE5iN0EwOWhWbmRXR3QrQ3hIYkRNTzloWENNNW1MWDh0U1lNcTg1Mk84TVVq?=
 =?utf-8?B?OHJEM3ZYMTVvejBUU2NPTTFITUZVWVBQWkhPTFh6anM5RUo4SXpVTXBvZzdE?=
 =?utf-8?B?c0ZIcUtIOHM4ZzF4RUdrQnhHaHh3MnZ3ZTczTU9GVlFqZlhVSDFWc0FTcDFt?=
 =?utf-8?B?blIwUjlkRTNGQnNMS3VjMDdLOHVmQWxpVkxEbTQ0VXROQlcvS25WT0NQOERS?=
 =?utf-8?B?cVBGWllTSy9VUFd3M2hLSTZySVZ1bkpPVjZZdDFkSWlZYVBsTDVuMXZ6NVdD?=
 =?utf-8?B?b25jWkZNcFVJZ3FrNFNORG9JdGIxcjN6bFdXbDhtNkpnUlBjK09FTXJ0L2lo?=
 =?utf-8?B?YWpDWXNHejI3OEhHSENUN2RjL01DTFFtWHFub0VxenRwMWxFTXFnWlJra1ZH?=
 =?utf-8?B?VTlEMDBPUG1pbDlwN0gwekM2aFpEVEJBSW55VDVONVdCR0UyeVFwa3VDaVhs?=
 =?utf-8?B?VmtRQmdTbmQrNzlVRmpQSVFVTE8zKzBFbE1rdU1aUFZUYnBlcU9PMHlFNm52?=
 =?utf-8?B?SlNPdVVyWjhFMFU0Z2EybUpPZUZWVnNxQlVOeWZNNS9QTHJ1SVZwVGxzallz?=
 =?utf-8?Q?dVPlVZPeyoNv93NznNoq17Dr8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60afffc-0137-49ee-9a4f-08dbbe9e6aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 14:39:40.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLBLWFZz2Prne8W+l5PT7qAX5l49dNxeHOfRbVEZmv11VSi4sGubxiOfEXtdGPgGXLt9JALsZBd1uuj9rHUC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-Proofpoint-GUID: boRCkW7MMD8jiUnwrTFYlmq2m1KE5NS6
X-Proofpoint-ORIG-GUID: xJIdEzj0Mr6Is2ET64cW4DBZgFn70c5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_10,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=650 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309260126
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 14:39:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15131

WWVzLCBpbmRlZWQuIA0KDQpSZWdhcmRzLA0KUWkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24u
b3JnPiANClNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNiwgMjAyMyA3OjI3IFBNDQpUbzogQ2hl
biwgUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT47IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVt
YmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXVtQQVRDSCAxLzJdIGJpdGJh
a2UtZ2V0dmFyOiBmdXJ0aGVyIHN1cHJlc3Mgd2FybmluZ3Mgd2hlbiBxdWlldCBvcHRpb24gaXMg
c3VwcGxpZWQNCg0KT24gVHVlLCAyMDIzLTA5LTI2IGF0IDAzOjE0IC0wNzAwLCBDaGVuIFFpIHZp
YSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQp3cm90ZToNCj4gRnJvbTogQ2hlbiBRaSA8UWkuQ2hl
bkB3aW5kcml2ZXIuY29tPg0KPiANCj4gV2hlbiBzY3JpcHRzIHJlbHkgb24gYml0YmFrZS1nZXR2
YXIncyBvdXRwdXQgdG8gZ2V0IHZhbHVlcywgZS5nLiwgDQo+IG9lLWZpbmQtbmF0aXZlLXN5c3Jv
b3QsIHdlIG5lZWQgdG8gZW5zdXJlIG5vIHdhcm5pbmcgbWVzc2FnZSBtZXNzZXMgDQo+IHRoaW5n
cyB1cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoZW4gUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNv
bT4NCj4gLS0tDQo+ICBiaW4vYml0YmFrZS1nZXR2YXIgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpJIHRoaW5rIFBldGVyIGFs
cmVhZHkgc2VudCBzb21ldGhpbmcgYWxvbmcgdGhlc2UgbGluZXMgd2hpY2gganVzdCBtZXJnZWQ/
DQoNCkNoZWVycywNCg0KUmljaGFyZA0K

