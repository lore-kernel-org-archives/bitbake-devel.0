Return-Path: <ernst.sjostrand@verisure.com>
X-Greylist: delayed 2233 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 16 Aug 2019 09:25:23 UTC
Received: from mx08-00271601.pphosted.com (mx08-00271601.pphosted.com
	[62.209.51.218])
	by mail.openembedded.org (Postfix) with ESMTP id 71E2B7E507
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 09:25:23 +0000 (UTC)
Received: from pps.filterd (m0107398.ppops.net [127.0.0.1])
	by mx08-00271601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
	x7G8hLtZ027156 for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 10:48:10 +0200
Received: from eur03-db5-obe.outbound.protection.outlook.com
	(mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
	by mx08-00271601.pphosted.com with ESMTP id 2ubf8cucck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 10:48:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=WykkehHe6LlPjNBk31gYH49VxMofSmPmLuaufHsOfs1mBafL1W/q+RoaRY9ezYaoR69QLGgix1UBOmTSoxArUGsRpowY8eQX8GHsDH0aLYQWUgAtOoUrDnoVYbfd3306v8a+5hB7nfZCbz2QVPu7E+MDUKzUJ4M3/V4S18Rc5z2FxwPgdaUiiRlbcMPbIfMd7GX0oQKM+2AXaPHnZcNJgr8ENBQsgtPLRW46B0u3b2CiGh1lY1IlmUQOkiM4C9Ny25N65VfHTbrFL6t15gkZCDIPc27RbpOaGdOBoYbYOazO2fWtijc+CAU6zxJxNvkRrbVCyUVCU0nGn35EgiNE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=YIHfSx6th5dpL8k2Ps6vYDDiDzFN1wXJaQgazZLZkdQ=;
	b=NQCUuNxzF/JwQQbp9txT6sne3Kf/Di5/zJI0Bp1mrWC9gzBtOlYXWzAJns0NF0KXknzWTzHbfW2+SlslrNUQ7UtO35GEwoEpYoNpt7TbsensezHNJEEdBFPUfehwEwetA2aU97bNfpGlOJtZ62W6yb9xONPE+N4JRlsGsAWJNulROByH8iBcgDiU1aV6KSS4n5HOcOCLTiHDCXmG//g77+6PqpNMdPYj2dbm8fM2C0mwIWLraKY23EH6/itF1jX6ShKpMR4SNRLMVGOY2W+HoTHBdtI+vpP5E/3t48P0+PK+125A9CRLUFikqHUBBvsWRb0xHCI/0XJMa+8hqxlO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=verisure.com;
	dmarc=pass action=none header.from=verisure.com; 
	dkim=pass header.d=verisure.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=verisure.onmicrosoft.com; s=selector2-verisure-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=YIHfSx6th5dpL8k2Ps6vYDDiDzFN1wXJaQgazZLZkdQ=;
	b=oFGkzTH7CU7tku3ThmJ1TevHYc1wCzrt0tJAz8ttZtuy9ziRgtwDPttvBsXPH8SEnQPgBHgRDtkogcnidX1vfufaqMcJwlX1ijupIqx7uqRRvn6jxFokJXpW12Bg0v2ctCz04XW5+4UG84NYrFm6gz5J+tzWk17sH2zzDB4+evQ=
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM (52.134.85.19) by
	AM0PR10MB2579.EURPRD10.PROD.OUTLOOK.COM (20.178.202.25) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2157.23; Fri, 16 Aug 2019 08:48:08 +0000
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::e8ec:cf21:82dd:d2b4]) by
	AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::e8ec:cf21:82dd:d2b4%6]) with mapi id 15.20.2157.022;
	Fri, 16 Aug 2019 08:48:08 +0000
From: =?utf-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernst.sjostrand@verisure.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch2: try_mirror_url():
	Replace old git with mirror
Thread-Index: AQHVBywipuAddhz1uU+ksu+YsyOVZqb+EE4A
Date: Fri, 16 Aug 2019 08:48:08 +0000
Message-ID: <47c4899e5dbc672058aa01733c1b6a9731b8e8b2.camel@verisure.com>
References: <d7b161c175927f11ad6933aa200f8aad79fbb30e.camel@verisure.com>
In-Reply-To: <d7b161c175927f11ad6933aa200f8aad79fbb30e.camel@verisure.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.170.189.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5572cae3-77d5-4f8b-6a55-08d72226768e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR10MB2579; 
x-ms-traffictypediagnostic: AM0PR10MB2579:
x-microsoft-antispam-prvs: <AM0PR10MB25798351A1DA6F93B0795EE694AF0@AM0PR10MB2579.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(85202003)(6246003)(2616005)(5640700003)(486006)(6916009)(53936002)(476003)(446003)(478600001)(99286004)(76116006)(186003)(66946007)(2351001)(102836004)(6506007)(118296001)(8936002)(91956017)(316002)(14454004)(26005)(229853002)(81156014)(25786009)(2906002)(6486002)(6436002)(66476007)(2501003)(7736002)(11346002)(76176011)(5660300002)(8676002)(66556008)(6512007)(71200400001)(66574012)(86362001)(81166006)(6116002)(36756003)(85182001)(3846002)(14444005)(256004)(71190400001)(305945005)(64756008)(66446008)(66066001)(524014004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR10MB2579;
	H:AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: verisure.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d9LmRTyq5chIo+6zf9QkPs4+vkdGZRf8PFnh5HVDa5zj3VAsjfBr7aiTNatrsPY5LzeMcJuESAI+qmKBOTMMjcx0aBcz5iG2M7NqjyIZ0Dzi8HMBbcQiec+NIFjjKcC5plw1gKFI7A1YXkzTuS+AcSF6QVjyRc7DZaEWIH8zNmHtXhl/owJg+P67uzuLHZtYd6OurCIl+aHJgxXqGvnFnInSMDYUtqp/5E7MSkcxgJiWQXFBlaXVJos9R46bwxPfhzcL5NZxHyuQeJA4Yr2KxDbhH5b2U7kpRauh3GrAliDFiUnR/qOaqjp8qIAIJGC8FbP1kIfGaMNZXiwKilzsSt36W31HkL9XZMG5hKaspF/QHWXbnVYJ2moX35bYZhHnhv6SF7OEwMOrhNLavccu5X/+K6k15Ik4mj20hQqX+j8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: verisure.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5572cae3-77d5-4f8b-6a55-08d72226768e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 08:48:08.7931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3055fa7f-a944-4927-801e-a62b63119e43
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUQXB6YlW6sabu3/DjPeolzB5E+kH+ILj3x69uB7rBQ/tk1oQvND36/0Bp/J778vFvIcMzbWWrk+Oo5jvt6Jxzb5WYrdekuTcc/ZGWFHZtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2579
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
	definitions=2019-08-16_05:2019-08-16,2019-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	phishscore=0
	lowpriorityscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
	clxscore=1015
	mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
	impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.12.0-1906280000 definitions=main-1908160092
Subject: Re: [PATCH] bitbake: fetch2: try_mirror_url(): Replace old git with mirror
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 16 Aug 2019 09:25:24 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F5E720A368BE0408E3F71509C322D3C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

ZnJlIDIwMTktMDUtMTAga2xvY2thbiAxMjozMCArMDAwMCBza3JldiBFcm5zdCBTasO2c3RyYW5k
Og0KPiBJZiB3ZSdyZSB0cnlpbmcgdG8gZmV0Y2ggYSBnaXQsIHdlJ3JlIGluIHRyeV9taXJyb3Jf
dXJsIGFuZA0KPiBvcmlndWQubG9jYWxwYXRoIGlzIGEgZGlyZWN0b3J5LCB0aGF0IG1lYW5zIHRo
ZSBvcmlnaW5hbCBjbG9uZSBpcw0KPiBicm9rZW4NCj4gZm9yIHNvbWUgcmVhc29uIGJ1dCB3ZSBm
b3VuZCBhIG1pcnJvciB0aGF0IHdvcmtzLg0KPiBSZW1vdmUgdGhlIG9yaWdpbmFsIGNsb25lIGFu
ZCByZXBsYWNlIGl0IHdpdGggYSBzeW1saW5rLCBsaWtlIHdoYXQNCj4gd291bGQNCj4gaG9wZWZ1
bGx5IGJlIGRvbmUgb24gYSBmcmVzaCBmZXRjaC4NCj4gDQo+IFsgWW9jdG8gIyAxMzI3OCBdDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcm5zdCBTasO2c3RyYW5kIDxlcm5zdC5zam9zdHJhbmRAdmVy
aXN1cmUuY29tPg0KPiAtLS0NCj4gIGJpdGJha2UvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8
IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQo+IGIvYml0YmFrZS9s
aWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQo+IGluZGV4IDcyZDYwOTJkZWIuLmJlMTIyOGQ2ZDUg
MTAwNjQ0DQo+IC0tLSBhL2JpdGJha2UvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiArKysg
Yi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCj4gQEAgLTMzLDYgKzMzLDcgQEAg
aWYgJ2dpdCcgbm90IGluIHVybGxpYi5wYXJzZS51c2VzX25ldGxvYzoNCj4gICAgICB1cmxsaWIu
cGFyc2UudXNlc19uZXRsb2MuYXBwZW5kKCdnaXQnKQ0KPiAgaW1wb3J0IG9wZXJhdG9yDQo+ICBp
bXBvcnQgY29sbGVjdGlvbnMNCj4gK2ltcG9ydCBzaHV0aWwNCj4gIGltcG9ydCBzdWJwcm9jZXNz
DQo+ICBpbXBvcnQgcGlja2xlDQo+ICBpbXBvcnQgZXJybm8NCj4gQEAgLTEwMTUsNiArMTAxNiwx
MSBAQCBkZWYgdHJ5X21pcnJvcl91cmwoZmV0Y2gsIG9yaWd1ZCwgdWQsIGxkLA0KPiBjaGVjayA9
IEZhbHNlKToNCj4gICAgICAgICAgICAgICAgICBpZiBoYXNhdHRyKG9yaWd1ZC5tZXRob2QsICJi
dWlsZF9taXJyb3JfZGF0YSIpOg0KPiAgICAgICAgICAgICAgICAgICAgICBvcmlndWQubWV0aG9k
LmJ1aWxkX21pcnJvcl9kYXRhKG9yaWd1ZCwgbGQpDQo+ICAgICAgICAgICAgICByZXR1cm4gb3Jp
Z3VkLmxvY2FscGF0aA0KPiArICAgICAgICBpZiBpc2luc3RhbmNlKHVkLm1ldGhvZCwgZ2l0Lkdp
dCkgYW5kDQo+IG9zLnBhdGguaXNkaXIob3JpZ3VkLmxvY2FscGF0aCkgYW5kIG9yaWd1ZC5sb2Nh
bHBhdGggIT0gdWQubG9jYWxwYXRoOg0KPiArICAgICAgICAgICAgbG9nZ2VyLndhcm5pbmcoIlJl
cGxhY2luZyAlcyB3aXRoIGxpbmsgdG8gJXMiLA0KPiBvcmlndWQubG9jYWxwYXRoLCB1ZC5sb2Nh
bHBhdGgpDQo+ICsgICAgICAgICAgICAjIFdlIGhhdmUgYW4gb2xkIGdpdCBjbG9uZSBoZXJlIHdo
aWNoIGlzIGJyb2tlbiBmb3Igc29tZQ0KPiByZWFzb24sDQo+ICsgICAgICAgICAgICAjIHJlbW92
ZSBpdCBhbmQgcmVwbGFjZSBpcyB3aXRoIGEgc3ltbGluay4NCj4gKyAgICAgICAgICAgIHNodXRp
bC5ybXRyZWUob3JpZ3VkLmxvY2FscGF0aCkNCj4gICAgICAgICAgIyBPdGhlcndpc2UgdGhlIHJl
c3VsdCBpcyBhIGxvY2FsIGZpbGU6Ly8gYW5kIHdlIHN5bWxpbmsgdG8NCj4gaXQNCj4gICAgICAg
ICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKG9yaWd1ZC5sb2NhbHBhdGgpOg0KPiAgICAgICAgICAg
ICAgaWYgb3MucGF0aC5pc2xpbmsob3JpZ3VkLmxvY2FscGF0aCk6DQo+IC0tIA0KPiAyLjE3LjEN
Cj4gDQoNClBpbmcuIEkgY291bGQgd3JpdGUgYSBsb25nZXIgZXhwbGFuYXRpb24gZm9yIHdoeSB5
b3UgbWlnaHQgZW5kIHVwIGluDQp0aGlzIHNpdHVhdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Us
IHRob3VnaCB0aGF0J3MgYXZhaWxhYmxlIGluIHRoZQ0KYnVnIHJlcG9ydC4NCg0KUmVnYXJkcw0K
Ly9Fcm5zdA0KDQo=

