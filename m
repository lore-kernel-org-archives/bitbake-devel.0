Return-Path: <ernst.sjostrand@verisure.com>
X-Greylist: delayed 1924 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 18 Nov 2019 13:12:12 UTC
Received: from mx08-00271601.pphosted.com (mx08-00271601.pphosted.com
	[62.209.51.218])
	by mail.openembedded.org (Postfix) with ESMTP id 3DE6D7F976
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 13:12:11 +0000 (UTC)
Received: from pps.filterd (m0107398.ppops.net [127.0.0.1])
	by mx08-00271601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
	xAICOVfM019722 for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 13:40:08 +0100
Received: from eur02-am5-obe.outbound.protection.outlook.com
	(mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50])
	by mx08-00271601.pphosted.com with ESMTP id 2wahxbngpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 13:40:08 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=H9CxurSXeW/kxBH8/L4MwHMi0bWUd9EdZzBrPg0hjPPk6Pl3+C1QLJIFrXWuYnMOgLjGbuQqfsNZNs1DSwft55y46e98UCmmR95PIewfL1i39UE32URG4ARfr8L1pop8+IargBe1bRvWNh6nHm81ST2gRzriQ5ssQ5zm9vzGi5DkLRWVAbWOSNvipx8hDXH7vmPqvPMRLNXldE8D7lPd48vxbVU6tvf83ed8IHrLodJGktvDDSH5TG1e90sM6aAJGI4vdVbueDE32JBHS29E08/dzWJDUIgjeeS+ABfmZsNIaDzTm4dXicd/MzvZCjo8ku9J2DQDmKD3J5tB7sVWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tOnRXNvpmZvnML0Vh2Du2Z8SVlckx8CupzgvRyra6wM=;
	b=HoKw/bjLberkMNlIP55/1ZrkIQaLpTkEzxEUswSTssz+cAXVbFkYT56A7+ZiE4dLkK/uMW7E7hHV3VCWYOYiA0eZj2oMKdRFKl92c6VUINxonxKv3hMNoLvUdkmx5+AzBYH8WNNgS0VOYET3xjEXCnbFTIOQhoLB9lqrerPcHzgwrYZB23Sb6C0WWvZXw2EeRXHKMaVkJ6oKtfwX1pgC1fjSmw1Qf9V4s0xKJDeUlF4ySUYg+nH9AAGf7+SYVKy08zZl5TAWifGVuvOI3siCQguP2qmB1VZ7pBPa3LJUhzIcv7bLNRgncFdwgV5pRAa2PTDSHw04K6tAoSbHQB/8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=verisure.com;
	dmarc=pass action=none header.from=verisure.com; 
	dkim=pass header.d=verisure.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=verisure.onmicrosoft.com; s=selector1-verisure-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tOnRXNvpmZvnML0Vh2Du2Z8SVlckx8CupzgvRyra6wM=;
	b=KDMrgq3y7HJQbT4hGGG+4OEtOROPvBGXDQKjwfo7tfYnP0/eCy+jx3kemO32PCu+e7ntlurTyaflVgx/IGyoDnvwf4vWQJMspq7qTf2TpGjoJT0ol+jMdKrYTUpW7Oi9R+UnTEHeAaAGcYGIAU1wLfm/pFCKS1Y7sckH+Nwmce8=
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM (52.134.85.19) by
	AM0PR10MB2402.EURPRD10.PROD.OUTLOOK.COM (20.177.110.224) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2451.29; Mon, 18 Nov 2019 12:40:07 +0000
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::bc11:d703:c672:3d62]) by
	AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::bc11:d703:c672:3d62%4]) with mapi id 15.20.2451.029;
	Mon, 18 Nov 2019 12:40:07 +0000
From: =?utf-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernst.sjostrand@verisure.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch2: try_mirror_url():
	Replace old git with mirror
Thread-Index: AQHVBywipuAddhz1uU+ksu+YsyOVZqb+EE4AgJP79gA=
Date: Mon, 18 Nov 2019 12:40:07 +0000
Message-ID: <a35696e71f079ccbad42d2b7a5d832d1cb04b62a.camel@verisure.com>
References: <d7b161c175927f11ad6933aa200f8aad79fbb30e.camel@verisure.com>
	<47c4899e5dbc672058aa01733c1b6a9731b8e8b2.camel@verisure.com>
In-Reply-To: <47c4899e5dbc672058aa01733c1b6a9731b8e8b2.camel@verisure.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.13.16.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c4c15fd-9067-413c-a21f-08d76c247165
x-ms-traffictypediagnostic: AM0PR10MB2402:
x-microsoft-antispam-prvs: <AM0PR10MB2402CFB7562D4B0BBD29E557944D0@AM0PR10MB2402.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(7736002)(6512007)(486006)(54896002)(118296001)(476003)(6486002)(2616005)(446003)(76116006)(5640700003)(14444005)(76176011)(85202003)(6506007)(71190400001)(71200400001)(6246003)(14454004)(81166006)(2501003)(186003)(81156014)(2351001)(8936002)(102836004)(26005)(229853002)(6436002)(6116002)(5660300002)(478600001)(236005)(8676002)(256004)(6916009)(11346002)(99286004)(86362001)(85182001)(66946007)(66476007)(66556008)(2906002)(64756008)(66446008)(316002)(25786009)(66574012)(66066001)(3846002)(36756003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR10MB2402;
	H:AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: verisure.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEZbm8wPSL0EGVrKUTLwrDk2gBZxC6Y/kuROddN/cDQrcvNNYXQSLKi+kvudC3FpsEKwcoCB1ja2FKZ3k+e5J/ja9L6Gb27T2xM03X1fFDWgb4D8Covqvhxr/rffFz3on0m/UsKmlueuPCS5DX4w23++E5ahua/xl0FfgVlGRJiLIMgN0THbVDHG7QKLxvZdQf3qIVHUHw08mLnnMK2W3MAbjudA9dkdw9VDFi8cSsiwAqY3JabOOPjq2JICzKhBPJPuoQmeHYNYdJqMJNwF8oO47gDVXa0GSzkjNM3UG7evhYLIIF1qrs1BWu4FmZLSuTUJYF7ulTej6/LcPVF4dPOa0fnYUPzeYW9W9oQQA+GKw8nt+B4oyZ1d0yELmjmF1EjpQLstUjIBuyapXBVgKVbsFYSvzj38KrhkVyDCxdKbXNFqy7NKruHnxssk9IuV
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: verisure.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4c15fd-9067-413c-a21f-08d76c247165
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 12:40:07.2743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3055fa7f-a944-4927-801e-a62b63119e43
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPFJl+hhNYSfuSEfzRBlpV5E3ddqa7mzckbqSNxNQ8BZWTA6hnFvAVJswLTAdP5q/KuojwRBUQ5gQJdILKo/7Kn2pPRssrRwLqMAGG6EjsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2402
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
	definitions=2019-11-18_02:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	mlxscore=0 phishscore=0
	priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
	suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
	impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.12.0-1910280000 definitions=main-1911180114
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
X-List-Received-Date: Mon, 18 Nov 2019 13:12:12 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_a35696e71f079ccbad42d2b7a5d832d1cb04b62acamelverisureco_"

--_000_a35696e71f079ccbad42d2b7a5d832d1cb04b62acamelverisureco_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UGluZyENCg0KZnJlIDIwMTktMDgtMTYga2xvY2thbiAwODo0OCArMDAwMCBza3JldiBFcm5zdCBT
asO2c3RyYW5kOg0KDQpmcmUgMjAxOS0wNS0xMCBrbG9ja2FuIDEyOjMwICswMDAwIHNrcmV2IEVy
bnN0IFNqw7ZzdHJhbmQ6DQoNCklmIHdlJ3JlIHRyeWluZyB0byBmZXRjaCBhIGdpdCwgd2UncmUg
aW4gdHJ5X21pcnJvcl91cmwgYW5kDQoNCm9yaWd1ZC5sb2NhbHBhdGggaXMgYSBkaXJlY3Rvcnks
IHRoYXQgbWVhbnMgdGhlIG9yaWdpbmFsIGNsb25lIGlzDQoNCmJyb2tlbg0KDQpmb3Igc29tZSBy
ZWFzb24gYnV0IHdlIGZvdW5kIGEgbWlycm9yIHRoYXQgd29ya3MuDQoNClJlbW92ZSB0aGUgb3Jp
Z2luYWwgY2xvbmUgYW5kIHJlcGxhY2UgaXQgd2l0aCBhIHN5bWxpbmssIGxpa2Ugd2hhdA0KDQp3
b3VsZA0KDQpob3BlZnVsbHkgYmUgZG9uZSBvbiBhIGZyZXNoIGZldGNoLg0KDQoNClsgWW9jdG8g
IyAxMzI3OCBdDQoNCg0KU2lnbmVkLW9mZi1ieTogRXJuc3QgU2rDtnN0cmFuZCA8DQoNCjxtYWls
dG86ZXJuc3Quc2pvc3RyYW5kQHZlcmlzdXJlLmNvbT4NCg0KZXJuc3Quc2pvc3RyYW5kQHZlcmlz
dXJlLmNvbQ0KDQo+DQoNCi0tLQ0KDQogYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5
IHwgNiArKysrKysNCg0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KDQpkaWZm
IC0tZ2l0IGEvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQoNCmIvYml0YmFrZS9s
aWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5DQoNCmluZGV4IDcyZDYwOTJkZWIuLmJlMTIyOGQ2ZDUg
MTAwNjQ0DQoNCi0tLSBhL2JpdGJha2UvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KDQorKysg
Yi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCg0KQEAgLTMzLDYgKzMzLDcgQEAg
aWYgJ2dpdCcgbm90IGluIHVybGxpYi5wYXJzZS51c2VzX25ldGxvYzoNCg0KICAgICB1cmxsaWIu
cGFyc2UudXNlc19uZXRsb2MuYXBwZW5kKCdnaXQnKQ0KDQogaW1wb3J0IG9wZXJhdG9yDQoNCiBp
bXBvcnQgY29sbGVjdGlvbnMNCg0KK2ltcG9ydCBzaHV0aWwNCg0KIGltcG9ydCBzdWJwcm9jZXNz
DQoNCiBpbXBvcnQgcGlja2xlDQoNCiBpbXBvcnQgZXJybm8NCg0KQEAgLTEwMTUsNiArMTAxNiwx
MSBAQCBkZWYgdHJ5X21pcnJvcl91cmwoZmV0Y2gsIG9yaWd1ZCwgdWQsIGxkLA0KDQpjaGVjayA9
IEZhbHNlKToNCg0KICAgICAgICAgICAgICAgICBpZiBoYXNhdHRyKG9yaWd1ZC5tZXRob2QsICJi
dWlsZF9taXJyb3JfZGF0YSIpOg0KDQogICAgICAgICAgICAgICAgICAgICBvcmlndWQubWV0aG9k
LmJ1aWxkX21pcnJvcl9kYXRhKG9yaWd1ZCwgbGQpDQoNCiAgICAgICAgICAgICByZXR1cm4gb3Jp
Z3VkLmxvY2FscGF0aA0KDQorICAgICAgICBpZiBpc2luc3RhbmNlKHVkLm1ldGhvZCwgZ2l0Lkdp
dCkgYW5kDQoNCm9zLnBhdGguaXNkaXIob3JpZ3VkLmxvY2FscGF0aCkgYW5kIG9yaWd1ZC5sb2Nh
bHBhdGggIT0gdWQubG9jYWxwYXRoOg0KDQorICAgICAgICAgICAgbG9nZ2VyLndhcm5pbmcoIlJl
cGxhY2luZyAlcyB3aXRoIGxpbmsgdG8gJXMiLA0KDQpvcmlndWQubG9jYWxwYXRoLCB1ZC5sb2Nh
bHBhdGgpDQoNCisgICAgICAgICAgICAjIFdlIGhhdmUgYW4gb2xkIGdpdCBjbG9uZSBoZXJlIHdo
aWNoIGlzIGJyb2tlbiBmb3Igc29tZQ0KDQpyZWFzb24sDQoNCisgICAgICAgICAgICAjIHJlbW92
ZSBpdCBhbmQgcmVwbGFjZSBpcyB3aXRoIGEgc3ltbGluay4NCg0KKyAgICAgICAgICAgIHNodXRp
bC5ybXRyZWUob3JpZ3VkLmxvY2FscGF0aCkNCg0KICAgICAgICAgIyBPdGhlcndpc2UgdGhlIHJl
c3VsdCBpcyBhIGxvY2FsIGZpbGU6Ly8gYW5kIHdlIHN5bWxpbmsgdG8NCg0KaXQNCg0KICAgICAg
ICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKG9yaWd1ZC5sb2NhbHBhdGgpOg0KDQogICAgICAgICAg
ICAgaWYgb3MucGF0aC5pc2xpbmsob3JpZ3VkLmxvY2FscGF0aCk6DQoNCi0tDQoNCjIuMTcuMQ0K
DQoNCg0KUGluZy4gSSBjb3VsZCB3cml0ZSBhIGxvbmdlciBleHBsYW5hdGlvbiBmb3Igd2h5IHlv
dSBtaWdodCBlbmQgdXAgaW4NCg0KdGhpcyBzaXR1YXRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdl
LCB0aG91Z2ggdGhhdCdzIGF2YWlsYWJsZSBpbiB0aGUNCg0KYnVnIHJlcG9ydC4NCg0KDQpSZWdh
cmRzDQoNCi8vRXJuc3QNCg0K

--_000_a35696e71f079ccbad42d2b7a5d832d1cb04b62acamelverisureco_
Content-Type: text/html; charset="utf-8"
Content-ID: <ADAA4ED8FA69F1449F2390F2321EE9E1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

PGh0bWwgZGlyPSJsdHIiPg0KPGhlYWQ+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUi
IGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+DQo8L2hlYWQ+DQo8Ym9keSBzdHls
ZT0idGV4dC1hbGlnbjpsZWZ0OyBkaXJlY3Rpb246bHRyOyI+DQo8ZGl2PlBpbmchPC9kaXY+DQo8
ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj5mcmUgMjAxOS0wOC0xNiBrbG9ja2FuIDA4OjQ4ICYjNDM7
MDAwMCBza3JldiBFcm5zdCBTasO2c3RyYW5kOjwvZGl2Pg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZjZiBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxwcmU+ZnJlIDIwMTktMDUtMTAga2xvY2thbiAxMjozMCAm
IzQzOzAwMDAgc2tyZXYgRXJuc3QgU2rDtnN0cmFuZDo8L3ByZT4NCjxibG9ja3F1b3RlIHR5cGU9
ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Yg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQo8cHJlPklmIHdlJ3JlIHRyeWluZyB0byBmZXRjaCBh
IGdpdCwgd2UncmUgaW4gdHJ5X21pcnJvcl91cmwgYW5kPC9wcmU+DQo8cHJlPm9yaWd1ZC5sb2Nh
bHBhdGggaXMgYSBkaXJlY3RvcnksIHRoYXQgbWVhbnMgdGhlIG9yaWdpbmFsIGNsb25lIGlzPC9w
cmU+DQo8cHJlPmJyb2tlbjwvcHJlPg0KPHByZT5mb3Igc29tZSByZWFzb24gYnV0IHdlIGZvdW5k
IGEgbWlycm9yIHRoYXQgd29ya3MuPC9wcmU+DQo8cHJlPlJlbW92ZSB0aGUgb3JpZ2luYWwgY2xv
bmUgYW5kIHJlcGxhY2UgaXQgd2l0aCBhIHN5bWxpbmssIGxpa2Ugd2hhdDwvcHJlPg0KPHByZT53
b3VsZDwvcHJlPg0KPHByZT5ob3BlZnVsbHkgYmUgZG9uZSBvbiBhIGZyZXNoIGZldGNoLjwvcHJl
Pg0KPHByZT48YnI+PC9wcmU+DQo8cHJlPlsgWW9jdG8gIyAxMzI3OCBdPC9wcmU+DQo8cHJlPjxi
cj48L3ByZT4NCjxwcmU+U2lnbmVkLW9mZi1ieTogRXJuc3QgU2rDtnN0cmFuZCAmbHQ7PC9wcmU+
DQo8YSBocmVmPSJtYWlsdG86ZXJuc3Quc2pvc3RyYW5kQHZlcmlzdXJlLmNvbSI+DQo8cHJlPmVy
bnN0LnNqb3N0cmFuZEB2ZXJpc3VyZS5jb208L3ByZT4NCjwvYT4NCjxwcmU+Jmd0OzwvcHJlPg0K
PHByZT4tLS08L3ByZT4NCjxwcmU+IGJpdGJha2UvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weSB8
IDYgJiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7PC9wcmU+DQo8cHJlPiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCYjNDM7KTwvcHJlPg0KPHByZT48YnI+PC9wcmU+DQo8cHJlPmRp
ZmYgLS1naXQgYS9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHk8L3ByZT4NCjxwcmU+
Yi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHk8L3ByZT4NCjxwcmU+aW5kZXggNzJk
NjA5MmRlYi4uYmUxMjI4ZDZkNSAxMDA2NDQ8L3ByZT4NCjxwcmU+LS0tIGEvYml0YmFrZS9saWIv
YmIvZmV0Y2gyL19faW5pdF9fLnB5PC9wcmU+DQo8cHJlPiYjNDM7JiM0MzsmIzQzOyBiL2JpdGJh
a2UvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weTwvcHJlPg0KPHByZT5AQCAtMzMsNiAmIzQzOzMz
LDcgQEAgaWYgJ2dpdCcgbm90IGluIHVybGxpYi5wYXJzZS51c2VzX25ldGxvYzo8L3ByZT4NCjxw
cmU+ICAgICB1cmxsaWIucGFyc2UudXNlc19uZXRsb2MuYXBwZW5kKCdnaXQnKTwvcHJlPg0KPHBy
ZT4gaW1wb3J0IG9wZXJhdG9yPC9wcmU+DQo8cHJlPiBpbXBvcnQgY29sbGVjdGlvbnM8L3ByZT4N
CjxwcmU+JiM0MztpbXBvcnQgc2h1dGlsPC9wcmU+DQo8cHJlPiBpbXBvcnQgc3VicHJvY2Vzczwv
cHJlPg0KPHByZT4gaW1wb3J0IHBpY2tsZTwvcHJlPg0KPHByZT4gaW1wb3J0IGVycm5vPC9wcmU+
DQo8cHJlPkBAIC0xMDE1LDYgJiM0MzsxMDE2LDExIEBAIGRlZiB0cnlfbWlycm9yX3VybChmZXRj
aCwgb3JpZ3VkLCB1ZCwgbGQsPC9wcmU+DQo8cHJlPmNoZWNrID0gRmFsc2UpOjwvcHJlPg0KPHBy
ZT4gICAgICAgICAgICAgICAgIGlmIGhhc2F0dHIob3JpZ3VkLm1ldGhvZCwgJnF1b3Q7YnVpbGRf
bWlycm9yX2RhdGEmcXVvdDspOjwvcHJlPg0KPHByZT4gICAgICAgICAgICAgICAgICAgICBvcmln
dWQubWV0aG9kLmJ1aWxkX21pcnJvcl9kYXRhKG9yaWd1ZCwgbGQpPC9wcmU+DQo8cHJlPiAgICAg
ICAgICAgICByZXR1cm4gb3JpZ3VkLmxvY2FscGF0aDwvcHJlPg0KPHByZT4mIzQzOyAgICAgICAg
aWYgaXNpbnN0YW5jZSh1ZC5tZXRob2QsIGdpdC5HaXQpIGFuZDwvcHJlPg0KPHByZT5vcy5wYXRo
LmlzZGlyKG9yaWd1ZC5sb2NhbHBhdGgpIGFuZCBvcmlndWQubG9jYWxwYXRoICE9IHVkLmxvY2Fs
cGF0aDo8L3ByZT4NCjxwcmU+JiM0MzsgICAgICAgICAgICBsb2dnZXIud2FybmluZygmcXVvdDtS
ZXBsYWNpbmcgJXMgd2l0aCBsaW5rIHRvICVzJnF1b3Q7LDwvcHJlPg0KPHByZT5vcmlndWQubG9j
YWxwYXRoLCB1ZC5sb2NhbHBhdGgpPC9wcmU+DQo8cHJlPiYjNDM7ICAgICAgICAgICAgIyBXZSBo
YXZlIGFuIG9sZCBnaXQgY2xvbmUgaGVyZSB3aGljaCBpcyBicm9rZW4gZm9yIHNvbWU8L3ByZT4N
CjxwcmU+cmVhc29uLDwvcHJlPg0KPHByZT4mIzQzOyAgICAgICAgICAgICMgcmVtb3ZlIGl0IGFu
ZCByZXBsYWNlIGlzIHdpdGggYSBzeW1saW5rLjwvcHJlPg0KPHByZT4mIzQzOyAgICAgICAgICAg
IHNodXRpbC5ybXRyZWUob3JpZ3VkLmxvY2FscGF0aCk8L3ByZT4NCjxwcmU+ICAgICAgICAgIyBP
dGhlcndpc2UgdGhlIHJlc3VsdCBpcyBhIGxvY2FsIGZpbGU6Ly8gYW5kIHdlIHN5bWxpbmsgdG88
L3ByZT4NCjxwcmU+aXQ8L3ByZT4NCjxwcmU+ICAgICAgICAgaWYgbm90IG9zLnBhdGguZXhpc3Rz
KG9yaWd1ZC5sb2NhbHBhdGgpOjwvcHJlPg0KPHByZT4gICAgICAgICAgICAgaWYgb3MucGF0aC5p
c2xpbmsob3JpZ3VkLmxvY2FscGF0aCk6PC9wcmU+DQo8cHJlPi0tIDwvcHJlPg0KPHByZT4yLjE3
LjE8L3ByZT4NCjxwcmU+PGJyPjwvcHJlPg0KPC9ibG9ja3F1b3RlPg0KPHByZT48YnI+PC9wcmU+
DQo8cHJlPlBpbmcuIEkgY291bGQgd3JpdGUgYSBsb25nZXIgZXhwbGFuYXRpb24gZm9yIHdoeSB5
b3UgbWlnaHQgZW5kIHVwIGluPC9wcmU+DQo8cHJlPnRoaXMgc2l0dWF0aW9uIGluIHRoZSBjb21t
aXQgbWVzc2FnZSwgdGhvdWdoIHRoYXQncyBhdmFpbGFibGUgaW4gdGhlPC9wcmU+DQo8cHJlPmJ1
ZyByZXBvcnQuPC9wcmU+DQo8cHJlPjxicj48L3ByZT4NCjxwcmU+UmVnYXJkczwvcHJlPg0KPHBy
ZT4vL0VybnN0PC9wcmU+DQo8cHJlPjxicj48L3ByZT4NCjwvYmxvY2txdW90ZT4NCjwvYm9keT4N
CjwvaHRtbD4NCg==

--_000_a35696e71f079ccbad42d2b7a5d832d1cb04b62acamelverisureco_--
