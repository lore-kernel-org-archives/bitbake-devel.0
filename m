Return-Path: <laurent.bonnans@here.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0109.outbound.protection.outlook.com [104.47.2.109])
	by mail.openembedded.org (Postfix) with ESMTP id B293479986
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 21:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com; 
	s=selector1-here-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ucIjD3eDzsbRXtS32iJTmWzd9ifICA4wWUnPcVq8f7U=;
	b=0GkO9HNP5f+Flac4fMXf6B/aFrLA3x99yfvWGLCHTJlhpYtguBOFen/doU16bmq5hEaL2hV4+ZG/riJVpVaYcfJmmIG0Iv6XlDPNLH/Z7JcVxIUixVpB/TV0SlTZsebTi2/7QpFtDlJXPdaBNGIz3Yf1GVnj8Zr6CDzU4uCuO/s=
Received: from AM5PR04MB3283.eurprd04.prod.outlook.com (10.173.255.154) by
	AM5PR04MB3092.eurprd04.prod.outlook.com (10.173.254.159) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.21; Thu, 4 Oct 2018 16:28:38 +0000
Received: from AM5PR04MB3283.eurprd04.prod.outlook.com
	([fe80::94d2:1ef9:140:e118]) by AM5PR04MB3283.eurprd04.prod.outlook.com
	([fe80::94d2:1ef9:140:e118%3]) with mapi id 15.20.1185.024;
	Thu, 4 Oct 2018 16:28:38 +0000
From: "Bonnans, Laurent" <laurent.bonnans@here.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] git submodule fetcher regression
Thread-Index: AQHUW/x48QL9JSxMxkqkszt8eHwgIaUPRp+A
Date: Thu, 4 Oct 2018 16:28:38 +0000
Message-ID: <69b4b130-96b1-cea3-f4ec-b22e9777397b@here.com>
References: <bfa936254124b13689c89dcee2a4e427@agner.ch>
In-Reply-To: <bfa936254124b13689c89dcee2a4e427@agner.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0048.eurprd09.prod.outlook.com
	(2603:10a6:7:3c::16) To AM5PR04MB3283.eurprd04.prod.outlook.com
	(2603:10a6:206:d::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurent.bonnans@here.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.191.159.149]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5PR04MB3092;
	6:cuxekFOaDeiL4iH53xc8rd1nmZcvN4MPb6Z1V9y/JV3lUIq61+HzqSn37ZqauYmX9+KThI9SW7fAJ8I/WawqUE1et0/uUDnc8arsMx25VsCZC/aEXfl2aiaq7joDpVT2LWfTV7ynkBN9odHdhfLuo0hFVznK6l/AtBVSV8dX5Gs53tmU39TYJT+7BvsWm5xYdDWM14jM4T9cylwOTR11hwlzHTqwAl2dyt06MLZsOWjoPyH+Wv/OAszwkTnIx1RCYcQkSDwnEc/YfB8I7xND9fUeUAlmhZUlLUVAXhLjtZKqMcjTJVdgCoIJjtPxZqyXTOe5Pki8GCvOSsJprH+iKJ7zHF2gN92WhmdimetvDTgcaRfDHvabBxY1scxpTdUO6708UeI1mBCybxjI5YAhmvZ5Fu+k3inc2KWUBgaEn68Fb7gom1UuZTatEf3sEE6GGHKVpttfP1zo/gtdIn94qQ==;
	5:v9GVO06hi4s05x9VVz5akdKyTerOn+p6AhD9Ltg395NVLqu2CWN5SeCCIj5a7us5P0Rl6CV76PTOQjgIvk5H8SFoBsmsskAq6B29LyQmFk1xFFYdLsSa8zvVKVNpW241LpvYKjmbNOzTyiQLJuMY/Mwd5r6ZFSDLRCg2quSeWkQ=;
	7:VHGyKfyNXG5EQNtykSD6sHkqLHn6h8+HEKf1/zJacoIKfMY5atBHu/K28GRzIGa9RJmDE2JR0vtskfe5Q3mvtcM+fGl5T3dQkCTtkrVLYzTcj/4MYIf3CGpNEm9CnRlk5S0dZZl5vZRoLXAGczsamhsIeWpTCRECfYPbx61q/ezXhfh3Xy+pZ3pp/nZKmFePZ7VlQGD+AVq2ItjBqqmRvVptJIm9YHrijqPUZTQ0Uy78R91/yrKlqP3Xbpv+z5nl
x-ms-office365-filtering-correlation-id: ce5afce1-919b-4308-c25b-08d62a16701a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
	SRVR:AM5PR04MB3092; 
x-ms-traffictypediagnostic: AM5PR04MB3092:
x-microsoft-antispam-prvs: <AM5PR04MB3092A904E4B6570CFA49C4C885EA0@AM5PR04MB3092.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);
	SRVR:AM5PR04MB3092; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB3092; 
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(97736004)(14454004)(316002)(229853002)(2351001)(105586002)(6436002)(106356001)(6486002)(6116002)(3846002)(71200400001)(6306002)(71190400001)(5250100002)(305945005)(7736002)(2900100001)(53936002)(2501003)(6512007)(102836004)(31686004)(476003)(486006)(256004)(14444005)(81156014)(31696002)(386003)(26005)(99286004)(81166006)(36756003)(76176011)(4326008)(186003)(11346002)(6246003)(66066001)(5660300001)(6506007)(53546011)(8676002)(68736007)(446003)(25786009)(8936002)(6916009)(5640700003)(2616005)(86362001)(52116002)(478600001)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB3092;
	H:AM5PR04MB3283.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: here.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: aqsoTDJfGz/VB8tqeO7Z3oZbJbzeQf6r2dKutgTPJC0dQr64sTrXyW0NhiXXS3h5PJWqIRLiidiN9klMZ+m0we7y4Pix5XUnI3qepero8nmJ+zlW2gPw0nvjxV03Ce9OIgqIyWNPzwtjc1R0nqfzNJDVjaSIMBpLW6uFycVONGqbTUnqjb4OXPKMLY1UeFkKt6RledYv1sepQj3uFW2W4MCLDUfYQB7YBG630h75Tlkkx+VCaseji9zAgB490TIerRjZ6hK+tg7SqkOpA6X3uozN2kI2H+pBcViFGByebqf159liyaMFcvKn2x6eCgyExYyxLq/FpzDGpmIBkbeSvuobzWExlPOUkzC6wZ0YmiE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5afce1-919b-4308-c25b-08d62a16701a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:28:38.2165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3092
Subject: Re: git submodule fetcher regression
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
X-List-Received-Date: Thu, 04 Oct 2018 21:01:32 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <57CA946E74AC334BAB303789852BF996@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

SGVsbG8gU3RlZmFuLA0KDQpPbiAxMC8wNC8yMDE4IDA2OjA4IFBNLCBTdGVmYW4gQWduZXIgd3Jv
dGU6DQo+IEhpLA0KPg0KPiBJdCBzZWVtcyB0aGF0IDljNmIzOWFkZjk3OCAoImZldGNoMi9naXRz
bS5weTogUmV3b3JrIHRoZSBnaXQgc3VibW9kdWxlIGZldGNoZXIiKSBicm9rZSBnaXQgc3VibW9k
dWxlcyBpbiBzb21lIGNhc2VzLiBNeSBwYXJ0aWN1bGFyIGNhc2UgaXMgYWt0dWFsaXpyIGZyb20g
bWV0YS11cGRhdGVyIChodHRwczovL2dpdGh1Yi5jb20vYWR2YW5jZWR0ZWxlbWF0aWMvbWV0YS11
cGRhdGVyKS4gRmV0Y2hpbmcgYWt0dWFsaXpyIHJlbGlhYmx5IGZhaWxzIGZvciBtZSBub3c6DQo+
DQo+IEVSUk9SOiBha3R1YWxpenItMS4wK2dpdEFVVE9JTkMrYTk0YTE1ZTMxZi03IGRvX3VucGFj
azogRmV0Y2hlciBmYWlsdXJlOiBTdWJtb2R1bGUgdGVzdHMvdHVmLXRlc3QtdmVjdG9ycyBkb2Vz
IG5vdCBleGlzdCBpbiAvaG9tZS9hZ3Mvb2UvZG93bmxvYWRzL2dpdDIvZ2l0aHViLmNvbS5hZHZh
bmNlZHRlbGVtYXRpYy5ha3R1YWxpenIvbW9kdWxlcy90ZXN0cy90dWYtdGVzdC12ZWN0b3JzIG9y
DQo+IC9ob21lL2Fncy9vZS9idWlsZC1jb2xpYnJpLWlteDcvdG1wLW9lL3dvcmsvYXJtdjdhdDJo
Zi1uZW9uLWxtcC1saW51eC1nbnVlYWJpL2FrdHVhbGl6ci8xLjArZ2l0QVVUT0lOQythOTRhMTVl
MzFmLTcvZ2l0Ly5naXQvbW9kdWxlcy90ZXN0cy90dWYtdGVzdC12ZWN0b3JzLg0KPiBFUlJPUjog
YWt0dWFsaXpyLTEuMCtnaXRBVVRPSU5DK2E5NGExNWUzMWYtNyBkb191bnBhY2s6IEZ1bmN0aW9u
IGZhaWxlZDogYmFzZV9kb191bnBhY2sNCj4gRVJST1I6IExvZ2ZpbGUgb2YgZmFpbHVyZSBzdG9y
ZWQgaW46IC9ob21lL2Fncy9vZS9idWlsZC1jb2xpYnJpLWlteDcvdG1wLW9lL3dvcmsvYXJtdjdh
dDJoZi1uZW9uLWxtcC1saW51eC1nbnVlYWJpL2FrdHVhbGl6ci8xLjArZ2l0QVVUT0lOQythOTRh
MTVlMzFmLTcvdGVtcC9sb2cuZG9fdW5wYWNrLjM1MTQzDQo+IEVSUk9SOiBUYXNrICgvaG9tZS9h
Z3Mvb2UvYnVpbGQtY29saWJyaS1pbXg3L2NvbmYvLi4vLi4vbGF5ZXJzL21ldGEtdXBkYXRlci9y
ZWNpcGVzLXNvdGEvYWt0dWFsaXpyL2FrdHVhbGl6cl9naXQuYmI6ZG9fdW5wYWNrKSBmYWlsZWQg
d2l0aCBleGl0IGNvZGUgJzEnDQo+DQo+IEFueSBpZGVhIHdoYXQgdGhhdCBjb3VsZCBiZT8NCj4N
Cj4gLS0NCj4gU3RlZmFuDQoNCldlIGFsc28gbm90aWNlZCB0aGUgcHJvYmxlbSBhbmQgc3VwcGxp
ZWQgYSBmaXggdG8gdGhlIGJpdGJha2UtZGV2ZWwgDQptYWlsaW5nIGxpc3QgKGFjdHVhbGx5LCB0
aGVyZSB3ZXJlIHR3byBzZXBhcmF0ZSBpc3N1ZXMgaW4gb3VyIGNhc2UpLiBUaGUgDQpjb21taXRz
IGFyZSBjdXJyZW50bHkgc2l0dGluZyBpbiBtYXN0ZXItbmV4dCBicmFuY2hlcyBvZiBiaXRiYWtl
IGFuZCANCnBva3kgYW5kIHNob3VsZCwgaW4gYWxsIGxpa2VsaWhvb2QsIG1vdmUgdG8gbWFzdGVy
IHNvb24uDQoNCkxhdXJlbnQNCg==

