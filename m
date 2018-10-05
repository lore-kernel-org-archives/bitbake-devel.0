Return-Path: <laurent.bonnans@here.com>
X-Greylist: delayed 26160 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 05 Oct 2018 16:09:06 UTC
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr20102.outbound.protection.outlook.com [40.107.2.102])
	by mail.openembedded.org (Postfix) with ESMTP id 1DE8479A63
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Oct 2018 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com; 
	s=selector1-here-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ov9D/mbdY0l7WWjamBNL9t3A0K/L4cyxlTBP+lBNBoY=;
	b=I4merJWtPeETOi2bN8ti1bDf5rtisBWPu/M2PjJt4CFAsV9NUt7nvku+pu02Z2jecUCGxtbBPhcLBM3kbwx6oDcX3Fvghos+pEHp0q4gQYgNxIW+1AuuQYEBkr3ocagCybFpqSjy2DkqwRXvkoNOWRWW+M3t3hQw870gaCZNPgY=
Received: from AM5PR04MB3283.eurprd04.prod.outlook.com (10.173.255.154) by
	AM5PR04MB3298.eurprd04.prod.outlook.com (10.173.255.157) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1207.18; Fri, 5 Oct 2018 08:38:05 +0000
Received: from AM5PR04MB3283.eurprd04.prod.outlook.com
	([fe80::cdb6:3ab9:3933:1ca4]) by
	AM5PR04MB3283.eurprd04.prod.outlook.com
	([fe80::cdb6:3ab9:3933:1ca4%2]) with mapi id 15.20.1207.024;
	Fri, 5 Oct 2018 08:38:05 +0000
From: "Bonnans, Laurent" <laurent.bonnans@here.com>
To: Mark Hatle <mark.hatle@windriver.com>, Stefan Agner <stefan@agner.ch>
Thread-Topic: [bitbake-devel] git submodule fetcher regression
Thread-Index: AQHUW/x48QL9JSxMxkqkszt8eHwgIaUPRp+AgAAEvACAAAODAIABBpgA
Date: Fri, 5 Oct 2018 08:38:05 +0000
Message-ID: <bbea5568-6173-516a-51e6-842a367f8375@here.com>
References: <bfa936254124b13689c89dcee2a4e427@agner.ch>
	<69b4b130-96b1-cea3-f4ec-b22e9777397b@here.com>
	<c84e653d352a71888547e5dd1ac06d5b@agner.ch>
	<4184b6d1-6531-5011-4087-61bf5e0fc761@windriver.com>
In-Reply-To: <4184b6d1-6531-5011-4087-61bf5e0fc761@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0110.eurprd04.prod.outlook.com
	(2603:10a6:803:64::45) To AM5PR04MB3283.eurprd04.prod.outlook.com
	(2603:10a6:206:d::26)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurent.bonnans@here.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.191.159.149]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5PR04MB3298;
	6:kZ23nsZyou0xKs3x9wiDjNXKnPAkRRM10wVWsRKKepSIDtudD6pT4UPHmbniXjkzLDXO372iqteh5bWzDboUCvHm9fhCJXwvG/Y4ZJgM0QMuHo6sS8ls0M4lPiiJCSNPM5tffpCNbqq1Td4WIUpHi8wb9uc38gbrqdpr+d7vIF1CjvvrU0A/hgrNEYBw32c34k6+KAtQEB/cDXWwUoVYUyTf5vkeVXO28hoUBoyGAZJkkZOzAC7jB6NQAraktV8MXmkJgo2C75QL1JqdTUgONys6f93nvRX5NcRJAKBl2B2+kGHHv7rY1Z6z9cb13EnxJv2UPD1Db3oUsLNq8+p/wHdw9EK9W0fIxYGV+rlXDLjcIypcVvQnHD2lz/cOtR9+XUxwPLAERWvdXPIh7FR3AiONdM8Bgw3KFu9vGnfydCTIGIlt5NhsJfqfiNNRQo3Cguq2FQJdgtQly8HrcEg1Aw==;
	5:EJK/iieIj2zPiuruwAYHsemu8ePzlGVHSdVHu6IfZkwbY4YdpfHFVKf2iU5o78jGA94O/WPIEIdTYCqXPy6FK0UIPz1wslioYCnT2B/CH92FoF0USKLonCk2STTu9jJ1Vgdvp8Ik0kuwVUB8APN8aj82/oi2FoNn8j4aXY+GNEE=;
	7:Ikf01gWNsQOHj0BV/mXjPXagwgntGwqmhIzy8jFFZCVdMQkvFEqAqvZw4pUemw5+JIgqMyW2pFXrre3W+auyADZs7hWWdOvlIEtFdsxGkZbUq3V/f4E9anC9DYZn/XmqiknVwCjNsMiaWCoyu/DGh2esZdWmsUooIinZQYpL69r6FB6vL+HtKVv5d3ZA4WH4oK42xlaWh3PrztTLPs2MZQagj0oKNb5UmbUz3DfbYKwBExzwmAqL3zfQpYX9ME39
x-ms-office365-filtering-correlation-id: 4a2d5c61-95dc-46bb-07a4-08d62a9dde81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
	SRVR:AM5PR04MB3298; 
x-ms-traffictypediagnostic: AM5PR04MB3298:
x-microsoft-antispam-prvs: <AM5PR04MB3298A18D28D0938FE67CBA5F85EB0@AM5PR04MB3298.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(4982022)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051);
	SRVR:AM5PR04MB3298; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB3298; 
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(25786009)(14454004)(478600001)(5250100002)(66066001)(71200400001)(71190400001)(93886005)(102836004)(2900100001)(26005)(316002)(54906003)(256004)(5660300001)(53546011)(110136005)(99286004)(14444005)(106356001)(97736004)(386003)(6506007)(105586002)(31686004)(966005)(76176011)(52116002)(6306002)(68736007)(81166006)(2616005)(8676002)(81156014)(446003)(476003)(86362001)(11346002)(575784001)(186003)(486006)(8936002)(6436002)(3846002)(305945005)(6486002)(6512007)(7736002)(53386004)(36756003)(53936002)(4326008)(2906002)(229853002)(6116002)(31696002)(6246003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB3298;
	H:AM5PR04MB3283.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: here.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: qH30tqXSi6PCAR8I8eeFVEOyRoVmq6KGpKvVEyNu5Ol7O4WOplWtsMAe/7w4og8iPcrquR0aJiGq1LAQADwqCoIM0kkfA7LYoKvNGTgHAZkdmXm73lGhpjaOXOM3s1hsRdFDE1cW0nWXfZNEVAGgY7SAq3B7VkAR9XAygSmYmS/FChZhvnBu5VRATctLhhjA2/ePJFBwEaqMff40itsyjtqBbRBTGT2lelNaiKZUzgKkvB4JxegaicyhplZeXgDdSsb4TDuTRSReZOigoq2uNIpGm5k6xOydzMTwY4iJdXVWZhYStUttHxUQQptf8df9SmIzc37l2whtoEmxE4L0yYElO8hWAglpyWX5U21h6IY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2d5c61-95dc-46bb-07a4-08d62a9dde81
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 08:38:05.4640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3298
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Fri, 05 Oct 2018 16:09:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACB8335D1196E84F8EBC721EA7E1E5C6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

SGVsbG8gU3RlZmFuLA0KDQoNCk9uIDEwLzA0LzIwMTggMDY6NTggUE0sIE1hcmsgSGF0bGUgd3Jv
dGU6DQo+IE9uIDEwLzQvMTggMTE6NDUgQU0sIFN0ZWZhbiBBZ25lciB3cm90ZToNCj4+IEkgZ3Vl
c3MgeW91IHJlZmVyIHRvOg0KPj4gZmV0Y2gyL2dpdHNtOiBjaGVja291dCBzdWJtb2R1bGVzIHJl
Y3Vyc2l2ZWx5DQo+PiBmZXRjaDIvZ2l0c206IGhhbmRsZSBzdWJtb2R1bGVzIG5lc3RlZCBpbnNp
ZGUgc3ViZGlycw0KPj4NCj4+IFdBUk5JTkc6IGFrdHVhbGl6ci0xLjArZ2l0QVVUT0lOQythOTRh
MTVlMzFmLTcgZG9fZmV0Y2g6IEZhaWxlZCB0byBmZXRjaCBVUkwgZ2l0c206Ly9naXRodWIuY29t
L2NhanVuLXJhdC9IZHJIaXN0b2dyYW1fYztwcm90b2NvbD1odHRwcztuYW1lPXRoaXJkX3BhcnR5
L0hkckhpc3RvZ3JhbV9jO2JhcmVjbG9uZT0xO25vY2hlY2tvdXQ9MSwgYXR0ZW1wdGluZyBNSVJS
T1JTIGlmIGF2YWlsYWJsZQ0KPj4gRVJST1I6IGFrdHVhbGl6ci0xLjArZ2l0QVVUT0lOQythOTRh
MTVlMzFmLTcgZG9fZmV0Y2g6IEZldGNoZXIgZmFpbHVyZTogVW5hYmxlIHRvIGZpbmQgcmV2aXNp
b24gMGI3NzhhOThjOTBjZTU1Mjg1Y2IxY2I2ZmU1MGUyYjI1ZGZkNTdhZSBpbiBicmFuY2ggbWFz
dGVyIGV2ZW4gZnJvbSB1cHN0cmVhbQ0KPj4gV0FSTklORzogYWt0dWFsaXpyLTEuMCtnaXRBVVRP
SU5DK2E5NGExNWUzMWYtNyBkb19mZXRjaDogRmFpbGVkIHRvIGZldGNoIFVSTCBnaXRzbTovL2dp
dGh1Yi5jb20vYWR2YW5jZWR0ZWxlbWF0aWMvYWt0dWFsaXpyO2JyYW5jaD1tYXN0ZXIsIGF0dGVt
cHRpbmcgTUlSUk9SUyBpZiBhdmFpbGFibGUNCj4+IEVSUk9SOiBha3R1YWxpenItMS4wK2dpdEFV
VE9JTkMrYTk0YTE1ZTMxZi03IGRvX2ZldGNoOiBGZXRjaGVyIGZhaWx1cmUgZm9yIFVSTDogJ2dp
dHNtOi8vZ2l0aHViLmNvbS9jYWp1bi1yYXQvSGRySGlzdG9ncmFtX2M7cHJvdG9jb2w9aHR0cHM7
bmFtZT10aGlyZF9wYXJ0eS9IZHJIaXN0b2dyYW1fYztiYXJlY2xvbmU9MTtub2NoZWNrb3V0PTEn
LiBVbmFibGUgdG8gZmV0Y2ggVVJMIGZyb20gYW55IHNvdXJjZS4NCj4+IEVSUk9SOiBha3R1YWxp
enItMS4wK2dpdEFVVE9JTkMrYTk0YTE1ZTMxZi03IGRvX2ZldGNoOiBGZXRjaGVyIGZhaWx1cmUg
Zm9yIFVSTDogJ2dpdHNtOi8vZ2l0aHViLmNvbS9hZHZhbmNlZHRlbGVtYXRpYy9ha3R1YWxpenI7
YnJhbmNoPW1hc3RlcicuIFVuYWJsZSB0byBmZXRjaCBVUkwgZnJvbSBhbnkgc291cmNlLg0KPj4g
RVJST1I6IGFrdHVhbGl6ci0xLjArZ2l0QVVUT0lOQythOTRhMTVlMzFmLTcgZG9fZmV0Y2g6IEZ1
bmN0aW9uIGZhaWxlZDogYmFzZV9kb19mZXRjaA0KPj4gRVJST1I6IExvZ2ZpbGUgb2YgZmFpbHVy
ZSBzdG9yZWQgaW46IC9ob21lL2Fncy9vZS9idWlsZC1jb2xpYnJpLWlteDcvdG1wLXRvcmR5L3dv
cmsvYXJtdjdhdDJoZi1uZW9uLWxtcC1saW51eC1nbnVlYWJpL2FrdHVhbGl6ci8xLjArZ2l0QVVU
T0lOQythOTRhMTVlMzFmLTcvdGVtcC9sb2cuZG9fZmV0Y2guNDE2NzMNCj4+IEVSUk9SOiBUYXNr
ICgvaG9tZS9hZ3Mvb2UvYnVpbGQtY29saWJyaS1pbXg3L2NvbmYvLi4vLi4vbGF5ZXJzL21ldGEt
dXBkYXRlci9yZWNpcGVzLXNvdGEvYWt0dWFsaXpyL2FrdHVhbGl6cl9naXQuYmI6ZG9fZmV0Y2gp
IGZhaWxlZCB3aXRoIGV4aXQgY29kZSAnMScNCj4+DQo+PiAoSSBhbSB1c2luZyBtZXRhLXVwZGF0
ZXIgYzQ5MDIzOTRjYzY2NzNiMDdhZDVlZTg3NTcwZTAyYWZiZGY3YjAyMiBhbmQgYml0YmFrZSBt
YXN0ZXItbmV4dCBhcyBvZiBub3cpDQo+Pg0KPj4gSSBkaWQgdXNlIC1jIGNsZWFuYWxsIGJlZm9y
ZSwgd2hpY2ggaG9wZWZ1bGx5IHNob3VsZCBiZSBzdWZmaWNpZW50Pw0KVGhpcyBzaG91bGQgYmUg
c29sdmVkIGluIG1ldGEtdXBkYXRlciANCjhhNDRjOGEyNjk2NmQwY2I5YjU3ZWExZWY0YzZmMjVj
MmE5NDRkZDggYW5kIGJleW9uZC4gSSBiZWxpZXZlIGl0J3MgdGhlIA0Kc2FtZSBpc3N1ZSByZXBv
cnRlZCBieSBKZW5zIFJlaHNhY2sgb24gT2N0IDEuDQpXZSBoYWQgYSBzaW1wbGUgd29ya2Fyb3Vu
ZCBpbiB0aGlzIGNhc2UsIHNvIHdlIGRpZCBub3QgaW52ZXN0aWdhdGUgdGhlIA0KY29yZSBiaXRi
YWtlIGlzc3VlIGF0IHRoYXQgdGltZS4NCj4gSWYgeW91IGFyZSBzdGlsbCBoYXZpbmcgaXNzdWVz
IGZyb20gbWFzdGVyLW5leHQgKGJpdGJha2UpLCBjYW4geW91IGRpc3RpbGwgZG93bg0KPiBhIHJl
cHJvZHVjZXIgcmVjaXBlPw0KPg0KPiBBbGwgaXQgdGFrZXMgaXMgYSBtaW5pbWFsIHJlY2lwZSB3
aXRoIGEgU1JDX1VSSSBsaW5lIHRoYXQgdXNlZCB0byB3b3JrIGZvciB5b3UNCj4gdGhyb3VnaCB0
aGUgZG9fdW5wYWNrIHN0YWdlLiAgKEkgZG9uJ3QgY2FyZSBhYm91dCBhbnl0aGluZyBhZnRlciBk
b191bnBhY2suLi4pDQo+DQo+IHR5cGljYWwgcmVwcm9kdWNlciBtYXkgbG9vayBsaWtlIFlQIEJ1
ZyAxMjk0MToNCj4NCj4gU1VNTUFSWSAgPSAiTGlicmFyeSB0byBhY2Nlc3MgQmx1LVJheSBkaXNr
Ig0KPiBTRUNUSU9OID0gIm1pc2MiDQo+IEhPTUVQQUdFID0gImh0dHA6Ly92aWRlb2xhbi5vcmci
DQo+IExJQ0VOU0UgPSAiR1BMdjIiDQo+IExJQ19GSUxFU19DSEtTVU09ImZpbGU6Ly9DT1BZSU5H
O21kNT00MzVlZDYzOWY4NGQ0NTg1ZDkzODI0ZTdkYTNkODVkYSINCj4NCj4gREVQRU5EUyA9ICJs
aWJ4bWwyIg0KPg0KPiBTUkNfVVJJID0gImdpdHNtOi8vZ2l0LnZpZGVvbGFuLm9yZy9saWJibHVy
YXkuZ2l0Ig0KPg0KPiBTUkNSRVYgPSAiJHtBVVRPUkVWfSINCj4NCj4NCj4gLS1NYXJrDQo+DQo+
DQpIZWxsbyBNYXJrLCBoZXJlIGlzIGEgc2hvcnQgcmVwcm9kdWNlciAoYWt0dWFsaXpyLmJiKQ0K
DQoNClNVTU1BUlkgPSAiQWt0dWFsaXpyIFNPVEEgQ2xpZW50Ig0KREVTQ1JJUFRJT04gPSAiU09U
QSBDbGllbnQgYXBwbGljYXRpb24gd3JpdHRlbiBpbiBDKysiDQpIT01FUEFHRSA9ICJodHRwczov
L2dpdGh1Yi5jb20vYWR2YW5jZWR0ZWxlbWF0aWMvYWt0dWFsaXpyIg0KU0VDVElPTiA9ICJiYXNl
Ig0KTElDRU5TRSA9ICJNUEwtMi4wIg0KTElDX0ZJTEVTX0NIS1NVTSA9IA0KImZpbGU6Ly8ke1N9
L0xJQ0VOU0U7bWQ1PTk3NDFjMzQ2ZWVmNTYxMzExNjNlMTNiOWRiMTI0MWIzIg0KDQpQViA9ICIx
LjArZ2l0JHtTUkNQVn0iDQoNClNSQ19VUkkgPSAiIFwNCiDCoCBnaXRzbTovL2dpdGh1Yi5jb20v
YWR2YW5jZWR0ZWxlbWF0aWMvYWt0dWFsaXpyO2JyYW5jaD0ke0JSQU5DSH0gXA0KIMKgICINClNS
Q1JFViA9ICI3OTI0NmI5MzBhMWI1YjZmOTU2YjY5Zjc0ZjFmMGM2MjA2MDA2MWRmIg0KQlJBTkNI
ID89ICJtYXN0ZXIiDQoNCg0KVGhlbiwgYGFrdHVhbGl6ciAtYyB1bnBhY2tgIGZhaWxzIHdpdGgg
dGhlIHNhbWUgZXJyb3IgU3RlZmFuIGRlc2NyaWJlZC4NCg0KVGhlIHJvb3QgY2F1c2UgaXMgdGhp
cyBzdWJtb2R1bGUgZGVjbGFyYXRpb246DQoNCltzdWJtb2R1bGUgInRoaXJkX3BhcnR5L0hkckhp
c3RvZ3JhbV9jIl0NCiDCoMKgwqAgcGF0aCA9IHRoaXJkX3BhcnR5L0hkckhpc3RvZ3JhbV9jDQog
wqDCoMKgIHVybCA9IGh0dHBzOi8vZ2l0aHViLmNvbS9jYWp1bi1yYXQvSGRySGlzdG9ncmFtX2MN
Cg0KV2hpY2ggaXMgc2V0IHRvIHRoZSBjb21taXQgMGI3NzhhOThjOTBjZTU1Mjg1Y2IxY2I2ZmU1
MGUyYjI1ZGZkNTdhZSwgDQpjdXJyZW50IEhFQUQgb2YgdGhlIGJyYW5jaCBgZml4LWNvbnN0LWNh
c3RgIGJ1dCBub3QgbWVyZ2VkIGluIA0KY2FqdW4tcmF0J3MgbWFzdGVyLg0KDQpQbGVhc2UgbGV0
IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBkZXRhaWxzLg0KDQoNCkFsc28sIHdoaWxlIGludmVz
dGlnYXRpbmcgdGhlc2UgaXNzdWVzLCBJIG5vdGljZWQgdGhhdCBgY2xlYW5hbGxgIG5vdyANCmRv
ZXMgbm90IHJlbW92ZSB0aGUgZmV0Y2hlZCBzdWJtb2R1bGVzIGxpa2UgaXQgd291bGQgYmUgZXhw
ZWN0ZWQuIFNvLCANCnJ1bm5pbmcgYGZldGNoYCBhZ2FpbiBvbmx5IGRvd25sb2FkIHRoZSBtYWlu
IHByb2plY3QgYW5kIHdpbGwgcmV1c2UgDQpjYWNoZWQgc3VibW9kdWxlcyByZXBvc2l0b3JpZXMg
aWYgdXAgdG8gZGF0ZS4NCg0KDQpMYXVyZW50DQo=

