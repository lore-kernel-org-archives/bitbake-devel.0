Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
 by mx.groups.io with SMTP id smtpd.web09.234.1606261346797654192
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Nov 2020 15:42:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hpe.com header.s=pps0720 header.b=n09T9klg;
 spf=pass (domain: hpe.com, ip: 148.163.143.35, mailfrom: prvs=05974f0549=javier.tia@hpe.com)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AONf5ux016602;
	Tue, 24 Nov 2020 23:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=yIiabxgl4nNE/25A2UYk6z5e2L3nJLoLMkwv2TN+Swk=;
 b=n09T9klgCVYDdwe2iGYKPqOn6NDKbQKdZlAcRnIH2zqI55yP0ClmDsaGxDgoTKORwhNs
 9OAKCmGR1ESvgzujZ+gQPVo5G4ukuLKYGV+bAu3+bJu1I7RFFM1O7SYdMOM/qkEjgMZA
 gCzpU9ZFBETrTRjiKSK/48DL4iWfeVsLmCwj1tZRp8NC8OLwOxpqMsa3EoYWtry9otZo
 VC0G1+krKio6AqY6I8o65gMBoWzNOGO311GrXAFpHXthE9NITGIvQktL8aEVC9ZdoYwp
 +EhyD+yiYpIJsxmML4o+Popln/99mxrhwKFia0iqyLCXd0otDWsLmwcivpOLNVDu+7bM +Q== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
	by mx0b-002e3701.pphosted.com with ESMTP id 34xsvnmqv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2020 23:42:25 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t5008.houston.hpe.com (Postfix) with ESMTPS id CD56275;
	Tue, 24 Nov 2020 23:42:24 +0000 (UTC)
Received: from G9W8677.americas.hpqcorp.net (16.220.49.24) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 23:42:24 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G9W8677.americas.hpqcorp.net (2002:10dc:3118::10dc:3118) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 24 Nov 2020 23:42:24 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 24 Nov 2020 23:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIjtvJtEsfG/P5qPiGYYygK1fUszXQjwQ04SbP/K8WlqQR/pKtg9uJw2TDRmwptY8UuIKV0+8g29w369vnqLMLdbXL386IRjf9eDSmP1jxSdmDioBNHjcf6UslwehT3EctT8gN2v2xhb+pCi+9a1/bYICIXYpz8/0IL2ObgO3qBQH6hNak8TGwbnMc8UYg92fz35JnfYp0VrFYqZu3SzD6PIZijKzO3PrcyK8OUylQHtYAC4ZNJ3C2midkFTSxYhOnEmeKE/duPl7SHNZDbbkbfUTIU5oap0Z/I4eh4fUzZdtT/B7uML9AC8Ai46kQWd1ONxZeVaDqCZzqLIX3Cpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIiabxgl4nNE/25A2UYk6z5e2L3nJLoLMkwv2TN+Swk=;
 b=j/6T7i6p6QrtQK9TcQIy9Hv5q1SToZV0WvlGp9ERmHV9OmLiBpU528QouFpDcSBYARq7gZHE+fH4j16/o+ZgOv/mz2jbFKgpwsKz/LOAilmZJjItjvX2N/E2+t+ylS9v4pIq1Lmwoclv1tqH0iw7nue5ISwwe9mM4GBfHejYy6rU71DaBESv+kkjx8WTgk8rp3Td65f81eFdZvs9sZHGDljzTNZiNLpodqRNLkPBbvlez1nEaCgVRe9fBFFzR1+jn2CcUFh/qeaWBSYBtmxPz3SZxQ5g//pUNb+M6WOXh8Xtv9Z3KbeOV6P1nX2V7GE7Q1+eeiakVwu9EQFUJ1MOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB0347.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7606::14) by DF4PR8401MB1289.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7611::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Tue, 24 Nov
 2020 23:42:22 +0000
Received: from DF4PR8401MB0347.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4cc:4e9:c375:2b3d]) by DF4PR8401MB0347.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4cc:4e9:c375:2b3d%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:42:22 +0000
From: "Javier Tia" <javier.tia@hpe.com>
To: Christopher Larson <kergoth@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] Add variable-key quality checker
Thread-Topic: [bitbake-devel] [PATCH] Add variable-key quality checker
Thread-Index: AQHWwqF/OPiSFheMO0G1VkcISjKna6nXxFyAgAAtSIA=
Date: Tue, 24 Nov 2020 23:42:22 +0000
Message-ID: <30468da2-d01a-7de1-adfe-3ac0588029e0@hpe.com>
References: <20201124203617.35637-1-javier.tia@hpe.com>
 <CABcZANmna7TCPY2yZKkzgUqTw6ofyKg_cOTJZ1uTBTik+1M0zg@mail.gmail.com>
In-Reply-To: <CABcZANmna7TCPY2yZKkzgUqTw6ofyKg_cOTJZ1uTBTik+1M0zg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [190.171.127.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 271a4571-2726-4278-e708-08d890d29750
x-ms-traffictypediagnostic: DF4PR8401MB1289:
x-microsoft-antispam-prvs: <DF4PR8401MB128914E6203875A1D404B37199FB0@DF4PR8401MB1289.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzF26qwR0rF5Ciq9EW9ZYzcKy+fZZ+yJjuVytmc5q5cU59bEhnTJPe10OAVaWoT7VgQ0zasfBqh8dTG6tmJC0F7rXXZioFJSY0fErWjSwt2ih4V75Lb4aukyD3bRXCJLbDcOSmNZK+JvS1+A+Zuo65Yq7o4XAWHTiez9YEh8k2DhVzUmYEc8Q8DsaMwBsqWC/FVs1mjrQt4G5t7EsXsja5xmRDE7HzqF5VgVjYEJYJwdEZ7nDMjIx+kwp2Wunaaw4pVFKfDRjZvi+TDV/1ZqfyRWokgOZOBwTKKtPkZHyqreIIN4Tsh6QCrD7cDik5tbWQANF/Oh2bqN+SW+Scs/UdOyLE+Udc9IDCmz5Ruu89vuMP6MsVkYHyF2LOA41X0T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB0347.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(376002)(39860400002)(186003)(6486002)(26005)(83380400001)(66556008)(478600001)(31686004)(86362001)(2906002)(76116006)(36756003)(5660300002)(66446008)(8676002)(66946007)(4326008)(6916009)(66476007)(64756008)(8936002)(53546011)(6506007)(2616005)(71200400001)(6512007)(31696002)(316002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vbUMGmx1hnOsQl3DMfSSvvG/l8powr4hDd9azWCEuO6U6vOX9mQj0elPoKgiMD76YO06Ta1ICkUcRQYWHOSqBkbj6EIRasbbDRUlMjrOH7X8lZuQlaDxAEF8h4OkflXYboFPEnLaGsQ+zhP9Kr8ftxiwNT392DMUemmn8mkW2x5GEhwsGXfsl7/ZK0WB74AGYe/g69CYz5VqGnpP1X4F0qWlSjFtzVRBV0UX3Gedl1iz0omdfI7k+Pp40vBaL1dw0h4/Fsc4mrDFM6RgqRH8r2AinQxe/WwjOHcE8stTh30Eikg1erFdSR3tCb39yo2Vhs1oUmIcdOq/66eEnSGVeA8CtFzkQFS46JOj8Ft7z/YbGXT47T2u6l/OvFwUKHQoAhi4uZzzfc/b2sNBXVjkv6LOERWqLAYKTs1ZrYOU5BOXuEhJKOBbl7cEoeoyQDl1CTlPr1hjO+Q61dWcDTPTXKe4LQRnATSyuQ8j6jqew8P1PlukTup68DhyJK8KcnMJ2vbm8U2dMGYkyfCwjIrfyjWTAap2LxGFfF7c3a74vsWXJU+/7Ld4xek2dgqje+j21a5pJRqLs574BbhQFJQPbQpirxrmFG0AaXneZ8T97WksjhQDk67s/dx74LA9y7Hz5jxWJMshjECGHdoe0HljczKPvv3hF5FBSL6cT+e3xK59JChju1sMxVOXc//RSsX/xtl+73dvhrZrCx23jSCZ2Vacpe337+hhepkpZ70Jv41z6d0Qbpof7c5tHL2VUl9/y31FXqhnpNHvcmqXD5GzYU55W2W7LmhUwGOyu8nRxJ+mnBISxlQ2yg/fdxWAM+BYeromOg4+siTmVaqZFhzSlusYCGL3QujahrU6wbemE56M2C3uLQsODxhRayapvrxlHHK9cnOENKfQ1A2WPRe/0Q==
x-ms-exchange-transport-forked: True
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB0347.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 271a4571-2726-4278-e708-08d890d29750
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:42:22.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OhGLFKITlMTA23A+lyT8ANWtpIDJsotSrMX/c1GcZnAtj8oCYExaMog4vOynpYO/7KE45omXrG25XaJ1OoTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1289
X-OriginatorOrg: hpe.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240138
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A56A46237C3CB4FBF098035A76E7AD7@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

DQpTb3JyeSBJIGRvbid0IGZvbGxvdy4gU2hvdWxkIEkgc3VibWl0IHRoZSBwYXRjaCB0byB0aGUg
DQpvcGVuZW1iZWRkZWQtY29yZUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIG1haWxpbmcgbGlzdD8N
Cg0KDQoNCkkgaGF2ZSBhIG5ldyBtb2RpZmljYXRpb24gdGhhdCB3b3JrcyBhcyBpdCdzIGV4cGVj
dGVkOg0KDQoNCiAgICAgbXNnID0gIlZhcmlhYmxlIGtleSAlcyAoJXMpIHJlcGxhY2VzIG9yaWdp
bmFsIGtleSAlcyAoJXMpLiIgJSAoa2V5LCANCnZhbCwgZWtleSwgbmV3dmFsKQ0KICAgICBlcnJv
cl9xYSA9IGFsdGVyZGF0YS5leHBhbmQoYWx0ZXJkYXRhLmdldFZhcignRVJST1JfUUEnLCBGYWxz
ZSkpDQogICAgIHdhcm5fcWEgPSBhbHRlcmRhdGEuZXhwYW5kKGFsdGVyZGF0YS5nZXRWYXIoJ1dB
Uk5fUUEnLCBGYWxzZSkpDQogICAgIGlmIGVycm9yX3FhIGlzIG5vdCBOb25lIGFuZCAndmFyaWFi
bGUta2V5JyBpbiBlcnJvcl9xYToNCiAgICAgICAgIGJiLmVycm9yKG1zZykNCiAgICAgZWxpZiB3
YXJuX3FhIGlzIG5vdCBOb25lIGFuZCAndmFyaWFibGUta2V5JyBpbiB3YXJuX3FhOg0KICAgICAg
ICAgYmIud2Fybihtc2cpDQogICAgIGVsc2U6DQogICAgICAgICBiYi53YXJuKG1zZykNCg0KDQpU
aGFua3MgZm9yIGNvbnNpZGVyaW5nIHRoZSBwYXRjaCwNCuKWtyBKYXZpZXIncyDwn5aKDQoNCk9u
IDExLzI0LzIwIDM6MDAgUE0sIENocmlzdG9waGVyIExhcnNvbiB3cm90ZToNCj4gRVJST1JfUUEg
YW5kIFdBUk5fUUEgYXJlIE9FIHZhcmlhYmxlcywgbm90IGJpdGJha2Ugb25lcywgYW5kIHRoZXkg
YXJlIA0KPiBzcGFjZSBzZXBhcmF0ZWQgbGlzdHMgb2Ygd29yZHMsIHNvIHdvdWxkIG5lZWQgdG8g
YmUgc3BsaXQgdG8gYmUgdXNlZC4NCj4gDQo+IE9uIFR1ZSwgTm92IDI0LCAyMDIwIGF0IDE6MzYg
UE0gSmF2aWVyIFRpYSA8amF2aWVyLnRpYUBocGUuY29tIA0KPiA8bWFpbHRvOmphdmllci50aWFA
aHBlLmNvbT4+IHdyb3RlOg0KPiANCj4gICAgIEFsbG93IHRvIHNlbGVjdCBiZXR3ZWVuIGEgd2Fy
bmluZyBvciBlcnJvciBtZXNzYWdlIHdoZW4gdmFyaWFibGUga2V5DQo+ICAgICByZXBsYWNlIHRo
ZSBvcmlnaW5hbCBrZXkuDQo+IA0KPiAgICAgU2lnbmVkLW9mZi1ieTogSmF2aWVyIFRpw6EgPGph
dmllci50aWFAaHBlLmNvbQ0KPiAgICAgPG1haWx0bzpqYXZpZXIudGlhQGhwZS5jb20+Pg0KPiAg
ICAgLS0tDQo+ICAgICAgwqBsaWIvYmIvZGF0YS5weSB8IDExICsrKysrKysrKystDQo+ICAgICAg
wqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ICAgIGRpZmYgLS1naXQgYS9saWIvYmIvZGF0YS5weSBiL2xpYi9iYi9kYXRhLnB5DQo+ICAgICBp
bmRleCAwZDc1ZDBjMS4uY2ExNGQ2NGEgMTAwNjQ0DQo+ICAgICAtLS0gYS9saWIvYmIvZGF0YS5w
eQ0KPiAgICAgKysrIGIvbGliL2JiL2RhdGEucHkNCj4gICAgIEBAIC0xMDAsNyArMTAwLDE2IEBA
IGRlZiBleHBhbmRLZXlzKGFsdGVyZGF0YSwgcmVhZGRhdGEgPSBOb25lKToNCj4gICAgICDCoCDC
oCDCoCDCoCDCoGlmIG5ld3ZhbCBpcyBub3QgTm9uZToNCj4gICAgICDCoCDCoCDCoCDCoCDCoCDC
oCDCoHZhbCA9IGFsdGVyZGF0YS5nZXRWYXIoa2V5LCBGYWxzZSkNCj4gICAgICDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIHZhbCBpcyBub3QgTm9uZToNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBiYi53YXJuKCJWYXJpYWJsZSBrZXkgJXMgKCVzKSByZXBsYWNlcyBvcmlnaW5hbCBrZXkN
Cj4gICAgICVzICglcykuIiAlIChrZXksIHZhbCwgZWtleSwgbmV3dmFsKSkNCj4gICAgICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBtc2cgPSAiVmFyaWFibGUga2V5ICVzICglcykgcmVwbGFjZXMg
b3JpZ2luYWwga2V5DQo+ICAgICAlcyAoJXMpLiIgJSAoa2V5LCB2YWwsIGVrZXksIG5ld3ZhbCkN
Cj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlcnJvcl9xYSA9IGFsdGVyZGF0YS5nZXRW
YXIoJ0VSUk9SX1FBJywgRmFsc2UpDQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd2Fy
bl9xYSA9IGFsdGVyZGF0YS5nZXRWYXIoJ1dBUk5fUUEnLCBGYWxzZSkNCj4gICAgICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBpZiBlcnJvcl9xYSBhbmQgJ3ZhcmlhYmxlLWtleScgaW4gZXJyb3Jf
cWE6DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmIuZXJyb3IobXNnKQ0K
PiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVsaWYgd2Fybl9xYSBhbmQgJ3ZhcmlhYmxl
LWtleScgaW4gd2Fybl9xYToNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBi
Yi53YXJuKG1zZykNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbHNlOg0KPiAgICAg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJiLndhcm4obXNnKQ0KPiAgICAgKw0KPiAg
ICAgIMKgIMKgIMKgIMKgIMKgYWx0ZXJkYXRhLnJlbmFtZVZhcihrZXksIGVrZXkpDQo+IA0KPiAg
ICAgIMKgZGVmIGluaGVyaXRGcm9tT1MoZCwgc2F2ZWRlbnYsIHBlcm1pdHRlZCk6DQo+ICAgICAt
LSANCj4gICAgIDIuMjkuMg0KPiANCj4gDQo+IC0tIA0KPiBDaHJpc3RvcGhlciBMYXJzb24NCj4g
a2VyZ290aCBhdCBnbWFpbCBkb3QgY29tDQo+IEZvdW5kZXIgLSBCaXRCYWtlLCBPcGVuRW1iZWRk
ZWQsIE9wZW5aYXVydXMNCj4gU2VuaW9yIFNvZnR3YXJlIEVuZ2luZWVyLCBNZW50b3IgR3JhcGhp
Y3MNCg==
