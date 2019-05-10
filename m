Return-Path: <ernst.sjostrand@verisure.com>
X-Greylist: delayed 1031 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 10 May 2019 12:47:34 UTC
Received: from mx08-00271601.pphosted.com (mx08-00271601.pphosted.com
	[62.209.51.218])
	by mail.openembedded.org (Postfix) with ESMTP id 66A287E097
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2019 12:47:34 +0000 (UTC)
Received: from pps.filterd (m0107398.ppops.net [127.0.0.1])
	by mx08-00271601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4AC7olV003720 for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2019 14:30:24 +0200
Received: from eur02-am5-obe.outbound.protection.outlook.com
	(mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59])
	by mx08-00271601.pphosted.com with ESMTP id 2sd30k9pvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2019 14:30:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=verisure.onmicrosoft.com; s=selector2-verisure-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OuLJaPeltxFDOn9Y7oZh0iHXQ94HhlolcwAIGJcgvpE=;
	b=Jw7TPqomoUAD+Ng8nmoPcZJJd2dhCi0oJV3YVsXh5TayPB+e2Rbo3VuGZAEIF+VUD9DMJuEST3/Tr2MKSCHsPKCQ6PqM5ScaZYN50Twb56mB/JLo/ClMYvZl3jA5LzVCkY8g+o46f2wPoQsuZvTp7/3jpagseYHGhW08pG9fiZc=
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM (52.134.85.19) by
	AM0PR10MB3076.EURPRD10.PROD.OUTLOOK.COM (10.255.31.90) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.12; Fri, 10 May 2019 12:30:22 +0000
Received: from AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::ec92:cc01:62dc:5e6]) by AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM
	([fe80::ec92:cc01:62dc:5e6%4]) with mapi id 15.20.1856.016;
	Fri, 10 May 2019 12:30:22 +0000
From: =?utf-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernst.sjostrand@verisure.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] bitbake: fetch2: try_mirror_url(): Replace old git with
	mirror
Thread-Index: AQHVBywipuAddhz1uU+ksu+YsyOVZg==
Date: Fri, 10 May 2019 12:30:22 +0000
Message-ID: <d7b161c175927f11ad6933aa200f8aad79fbb30e.camel@verisure.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.170.189.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 426fb188-32b3-43cb-1d8d-08d6d5434557
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM0PR10MB3076; 
x-ms-traffictypediagnostic: AM0PR10MB3076:
x-microsoft-antispam-prvs: <AM0PR10MB3076BBF666F1F9464416EC07940C0@AM0PR10MB3076.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(118296001)(2616005)(476003)(478600001)(486006)(25786009)(71200400001)(66574012)(71190400001)(6116002)(2501003)(3846002)(6436002)(53936002)(66476007)(66946007)(85202003)(73956011)(76116006)(85182001)(6916009)(305945005)(14454004)(91956017)(102836004)(66556008)(64756008)(66446008)(316002)(6512007)(6486002)(5640700003)(81166006)(2351001)(8936002)(186003)(26005)(256004)(86362001)(14444005)(7736002)(66066001)(6506007)(81156014)(5660300002)(68736007)(36756003)(8676002)(99286004)(2906002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR10MB3076;
	H:AM0PR10MB2099.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: verisure.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kmm5r89PbD3tNPX0Lreutvr+LI+rW7Fv0zpJA6oiq6UpI7UKg7sxacAFKPYoSs6arYlPDlp2fvIDleITKGaExbPIExiWmRH4wiuJNBdrJH1vZlsrJTBMyAlUQlmk5V6aAPjWHVb/YBVJ05ixn+A+/AMR7r6sHB/a0RAO2Agq21Elc9Z4UYF4V4fKp7UjATn9uGLdY3hyz2GzyjuMQZWzgouwq+gmrnfwM7xGeOsQh5aT5BWHF3U+c1DQzheYBqzE9+iFGfTN1IpCHG0N/Oz8JLRxbOIe9iGkTaeX4cwA/HPndNd9jygHxOufqey7x6wsp2RIP1+z2DS1ys7PDE1ZwnQuyyKlv2Hpm5beX1CV+YsjaOe6sTxMNU71fohnTtq6145BPdLJK69+eAsfU1lNEVhqw31Km7J/KmjBHG9xHd8=
MIME-Version: 1.0
X-OriginatorOrg: verisure.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426fb188-32b3-43cb-1d8d-08d6d5434557
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 12:30:22.1006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3055fa7f-a944-4927-801e-a62b63119e43
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3076
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100087
Subject: [PATCH] bitbake: fetch2: try_mirror_url(): Replace old git with mirror
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
X-List-Received-Date: Fri, 10 May 2019 12:47:34 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A2F2D8D80B114E8BA61B2757C0924A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

SWYgd2UncmUgdHJ5aW5nIHRvIGZldGNoIGEgZ2l0LCB3ZSdyZSBpbiB0cnlfbWlycm9yX3VybCBh
bmQNCm9yaWd1ZC5sb2NhbHBhdGggaXMgYSBkaXJlY3RvcnksIHRoYXQgbWVhbnMgdGhlIG9yaWdp
bmFsIGNsb25lIGlzIGJyb2tlbg0KZm9yIHNvbWUgcmVhc29uIGJ1dCB3ZSBmb3VuZCBhIG1pcnJv
ciB0aGF0IHdvcmtzLg0KUmVtb3ZlIHRoZSBvcmlnaW5hbCBjbG9uZSBhbmQgcmVwbGFjZSBpdCB3
aXRoIGEgc3ltbGluaywgbGlrZSB3aGF0IHdvdWxkDQpob3BlZnVsbHkgYmUgZG9uZSBvbiBhIGZy
ZXNoIGZldGNoLg0KDQpbIFlvY3RvICMgMTMyNzggXQ0KDQpTaWduZWQtb2ZmLWJ5OiBFcm5zdCBT
asO2c3RyYW5kIDxlcm5zdC5zam9zdHJhbmRAdmVyaXN1cmUuY29tPg0KLS0tDQogYml0YmFrZS9s
aWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvX19pbml0
X18ucHkgYi9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCmluZGV4IDcyZDYwOTJk
ZWIuLmJlMTIyOGQ2ZDUgMTAwNjQ0DQotLS0gYS9iaXRiYWtlL2xpYi9iYi9mZXRjaDIvX19pbml0
X18ucHkNCisrKyBiL2JpdGJha2UvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KQEAgLTMzLDYg
KzMzLDcgQEAgaWYgJ2dpdCcgbm90IGluIHVybGxpYi5wYXJzZS51c2VzX25ldGxvYzoNCiAgICAg
dXJsbGliLnBhcnNlLnVzZXNfbmV0bG9jLmFwcGVuZCgnZ2l0JykNCiBpbXBvcnQgb3BlcmF0b3IN
CiBpbXBvcnQgY29sbGVjdGlvbnMNCitpbXBvcnQgc2h1dGlsDQogaW1wb3J0IHN1YnByb2Nlc3MN
CiBpbXBvcnQgcGlja2xlDQogaW1wb3J0IGVycm5vDQpAQCAtMTAxNSw2ICsxMDE2LDExIEBAIGRl
ZiB0cnlfbWlycm9yX3VybChmZXRjaCwgb3JpZ3VkLCB1ZCwgbGQsIGNoZWNrID0gRmFsc2UpOg0K
ICAgICAgICAgICAgICAgICBpZiBoYXNhdHRyKG9yaWd1ZC5tZXRob2QsICJidWlsZF9taXJyb3Jf
ZGF0YSIpOg0KICAgICAgICAgICAgICAgICAgICAgb3JpZ3VkLm1ldGhvZC5idWlsZF9taXJyb3Jf
ZGF0YShvcmlndWQsIGxkKQ0KICAgICAgICAgICAgIHJldHVybiBvcmlndWQubG9jYWxwYXRoDQor
ICAgICAgICBpZiBpc2luc3RhbmNlKHVkLm1ldGhvZCwgZ2l0LkdpdCkgYW5kIG9zLnBhdGguaXNk
aXIob3JpZ3VkLmxvY2FscGF0aCkgYW5kIG9yaWd1ZC5sb2NhbHBhdGggIT0gdWQubG9jYWxwYXRo
Og0KKyAgICAgICAgICAgIGxvZ2dlci53YXJuaW5nKCJSZXBsYWNpbmcgJXMgd2l0aCBsaW5rIHRv
ICVzIiwgb3JpZ3VkLmxvY2FscGF0aCwgdWQubG9jYWxwYXRoKQ0KKyAgICAgICAgICAgICMgV2Ug
aGF2ZSBhbiBvbGQgZ2l0IGNsb25lIGhlcmUgd2hpY2ggaXMgYnJva2VuIGZvciBzb21lIHJlYXNv
biwNCisgICAgICAgICAgICAjIHJlbW92ZSBpdCBhbmQgcmVwbGFjZSBpcyB3aXRoIGEgc3ltbGlu
ay4NCisgICAgICAgICAgICBzaHV0aWwucm10cmVlKG9yaWd1ZC5sb2NhbHBhdGgpDQogICAgICAg
ICAjIE90aGVyd2lzZSB0aGUgcmVzdWx0IGlzIGEgbG9jYWwgZmlsZTovLyBhbmQgd2Ugc3ltbGlu
ayB0byBpdA0KICAgICAgICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKG9yaWd1ZC5sb2NhbHBhdGgp
Og0KICAgICAgICAgICAgIGlmIG9zLnBhdGguaXNsaW5rKG9yaWd1ZC5sb2NhbHBhdGgpOg0KLS0g
DQoyLjE3LjENCg0K

