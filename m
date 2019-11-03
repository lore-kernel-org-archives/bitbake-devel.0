Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr740087.outbound.protection.outlook.com [40.107.74.87])
	by mail.openembedded.org (Postfix) with ESMTP id E6D28745BF
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Nov 2019 13:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=AgfTd/FNDG9GeAVqcPwtFrAWVoogwRlNe1BLFrl+8PvQqpZzCFmc6wjiH987HEykT0YP318CwAXH4OPUqIFX4JW0bIElyymFK5mcZZTelF8vZ7sKBB7Q8E+hiA66GR+C8I3tHUvTGCP2tLSKfRVilyZtWuNXhE7SJNqlas7pgG5zmNb/i9uZpg6WGLSzHEdPO6TBCq/aImP4zfux6+/dFtw4Eh1lqbdNBFMMtdfi8uYQ2vjzTkgdPsn9YJaAH0qyerFILnhqYnNpoGOaEVsPq5V1BIuTl4o5tSHolk2XQBOL37PF6JyzNxdIkHynBuwcgaoikDJsHUSqZrsjIHtA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zuBFKpOUIxdj+WwoVmVUeMIAKpQQctzOrR7hu4Hm4XY=;
	b=IsFrVjDvPA0s41/uzX1IROVtvl8YV1QcPWyNRFV18Tf6Y5/ieeqFVkzm3g1qN4olxVAMmly2zouCcBTZxxw6dgMv4gn5HebbYy+nMVSQXywSm0LldzbJ66qB4FiLXqqX7I9vV8N+/SqEBdztqXRDQZ5G2NklCyHZCujYBTCbAaHuR62hzJk6D2s9gvlNHxxxD8aPBd3hGpzFqP78kFcvondLBbKUnUrVtteGUN6QEnOCsQXq70dlOQUwsdn8vbljk4mgU4XMRsou+kYk1SG4PM8T6W6DSNkrCFBYx4RkzA2WZtpDi7EokeZC7AcdQb8pmHzF6DDOskxlK98KRnEqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zuBFKpOUIxdj+WwoVmVUeMIAKpQQctzOrR7hu4Hm4XY=;
	b=N7b1vmcpguixp4HzQgMpGaHxSUFtmg3HTZNN25FKdIjgfSvSTsoAhTcg5qhN0r2wF268P250+xFwHMjVdo06zYjrLQ0NLMY3TBINO2fzZHZnGzCcZ+8n4yJJAxVzdN7kD0YahEgXHbFIapefinvhyKiSOEIkLIZWrfsA0NmRvpE=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1288.namprd12.prod.outlook.com (10.168.167.20) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2408.24; Sun, 3 Nov 2019 13:20:39 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986%5]) with mapi id 15.20.2387.028;
	Sun, 3 Nov 2019 13:20:39 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: command: add getOverrideData
	command
Thread-Index: AQHVkBG+ZtQDzdJ3tkeVmF9E32Yz26d4XCAAgAAmxhCAALN1AIAANnqQ
Date: Sun, 3 Nov 2019 13:20:39 +0000
Message-ID: <CY4PR12MB16533C2D7C7BB75812EB7D3E8B7C0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
	<5375964a726a0a4790c99137a52227a66e09b243.camel@linuxfoundation.org>
	<CY4PR12MB16530722ADF132F7AE920D908B7D0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<c032a294dd1e26fd5061d850f9d5322a79de0c14.camel@linuxfoundation.org>
In-Reply-To: <c032a294dd1e26fd5061d850f9d5322a79de0c14.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fd30d1e-7263-4af2-706a-08d760609ee6
x-ms-traffictypediagnostic: CY4PR12MB1288:
x-microsoft-antispam-prvs: <CY4PR12MB1288D64EAA770C615C2938AA8B7C0@CY4PR12MB1288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(366004)(396003)(136003)(346002)(29502001)(199004)(189003)(76116006)(81156014)(71200400001)(476003)(76176011)(102836004)(305945005)(6436002)(478600001)(6116002)(66476007)(66556008)(64756008)(66446008)(7696005)(66946007)(5660300002)(186003)(66066001)(3846002)(33656002)(6246003)(6506007)(99286004)(26005)(25786009)(2501003)(71190400001)(8676002)(316002)(81166006)(52536014)(486006)(256004)(7736002)(14454004)(229853002)(9686003)(55016002)(11346002)(446003)(110136005)(86362001)(2906002)(8936002)(74316002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1288;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lrpGw0cDTjTSIChofZBeoqbUPIU8UyfzrQae+Et8yMjqLokvRN9/XkZMM73a6fsOATL0mi1GhoXKXNCEJG1diQ4Eag+L+zVk6iojQCh7WI49b6xMhn8VIT5lUweocTcFcLMgRs/mpU6MAvBUI1SAnaTt5EwPzEfgKflhuJzLFBLzje3UOhX6/IQsYE2rU725jDZK0MVP57uEeVjZFIfTyZXfRlyVHFY+QyOtoT86aA2bAOKCuZACoeNGCMzGdxnI9T6zKkkxL7OFqgoqOPsV58XE7aMIgFbiIN6JuRyQds+HXmkeXF9m1T1q0taeotAqhnVXkYJ+m0w7xQxCnhra48Nc2ySnozoVCxMVoTR348+fGa8AiBgTjXDj8HGSo48mYeH0LY/xPS7rZP3YZ560LEDO4Ek2REGZvZgQSb+nhuYT9C8gEi4w3kIC2gbpq+lnY7iiQ20R0mRaSyL2USyuIA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd30d1e-7263-4af2-706a-08d760609ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 13:20:39.1845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGeLZg/lmEYSzurksHju8n+Fw3UmFzPLeuG8v7sIA53x8cn3lo7ZHNGT6eMGz1twXm6j+YG9hEs4viUI7FkrWhF+NUZtZ/POJ/mmSS6RAbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
Subject: Re: [PATCH] bitbake: command: add getOverrideData command
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
X-List-Received-Date: Sun, 03 Nov 2019 13:20:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IE15IHBhcnRpY3VsYXIgdXNlIGNhc2UgaXMgdGhhdCBJIG5lZWRlZCB0byBpZGVudGlmeSBp
ZiBhbmQgd2hlcmUNCj4gPiBTUkNSRVYgaXMgZ2V0dGluZyBvdmVycmlkZGVuIGZvciBwYXJ0aWN1
bGFyIHJlY2lwZXMuIEZvciBpbnN0YW5jZSwNCj4gPiBzb21lb25lIG1pZ2h0IGhhdmUgYWRkZWQg
YSBTUkNSRVZfcG4tcmVjaXBlIHRvIHRoZWlyIGxvY2FsLmNvbmYuIEkgYW0NCj4gPiB3b3JraW5n
IG9uIGEgdG9vbCB0aGF0IHByb2R1Y2VzICJidWlsZGhpc3RvcnktY29sbGVjdC1zcmNyZXZzIi1z
dHlsZQ0KPiA+IG91dHB1dCBmcm9tIHRoZSBTUkNSRVYgY2FjaGUgaXRzZWxmLCB3aXRob3V0IGFj
dHVhbGx5IHJlcXVpcmluZyB0aGF0DQo+ID4gYnVpbGRoaXN0b3J5IGlzIGVuYWJsZWQuIEl0J3Mg
YWN0dWFsbHkgYSBnZW5lcmFsIHRvb2wgdG8gaW5zcGVjdCBhbmQNCj4gPiBtYW5pcHVsYXRlIHRo
ZSBTUkNSRVYgY2FjaGUuIE15IHRlYW0gdXNlcyBBVVRPUkVWIHByZXR0eSBleHRlbnNpdmVseSwN
Cj4gPiBzbyB0aGlzIGtpbmQgb2YgdG9vbCB3aWxsIGJlIHZlcnkgdXNlZnVsIHRvIHVzLg0KPiAN
Cj4gSSB0aGluayBpdCBkZXBlbmRzIHdoYXQga2luZCBvZiBndWFyYW50ZWVzIHdlJ3JlIGV4cGVj
dGluZyBhcm91bmQgdGhpcy4NCj4gRm9yIGV4YW1wbGU6DQo+IA0KPiBweXRob24gKCkgew0KPiAg
ICAgaWYgZC5nZXRWYXIoIk1BQ0hJTkUiKSA9PSAiYmFyIjoNCj4gICAgICAgICBkLnNldFZhcigi
U1JDUkVWIiwgInByb2JsZW0iKQ0KPiB9DQo+IA0KPiBSZWFsbHkgdGhlIG9ubHkgd2F5IHRvIGJl
IHN1cmUgaXMgdG8gcGFyc2UgZm9yIGVhY2ggTUFDSElORSBhbmQgc2VlDQo+IHdoYXQgdGhlIHZh
bHVlcyBhcmUuIEkgZGlkIHdvbmRlciBpZiB5b3UgY291bGQganVzdCBzd2l0Y2ggYmV0d2Vlbg0K
PiBNQUNISU5FIHZhbHVlcyBidXQgdGhhdCBkb2Vzbid0IGV2ZW4gY292ZXIgdGhlIHB5dGhvbiBh
Ym92ZSB3aXRob3V0IHRoZQ0KPiBkYXRhc3RvcmUgZmluYWxpc2F0aW9uLg0KPiANCj4gQmFzaWNh
bGx5IG15IHdvcnJ5IGlzIHdoYXQgdGhlIGV4cGVjdGF0aW9ucyBvZiB0aGUgQVBJIGFyZS4gV2hp
bHN0IHlvdQ0KPiBtYXkgYmUgZmluZSB3aXRoIHRoZSBsaW1pdGF0aW9ucywgaXRzIHRoZSBtYWtp
bmdzIG9mIGFuIHVuc29sdmFibGUgYnVnDQo+IHJlcG9ydCB0b21vcnJvdyA6KC4NCg0KWWVwLCBJ
IGRlZmluaXRlbHkgZ2V0IHlvdXIgcG9pbnQuIEkgcGVyc29uYWxseSBhbSBub3Qgd29ycmllZCBh
Ym91dCB0aGUgbW9yZSAicGF0aG9sb2dpY2FsIiBjYXNlcyBsaWtlIHdoYXQgeW91IGhhdmUgYWJv
dmUuIE15IHRvb2wgYmFzaWNhbGx5IG9ubHkgY2FyZXMgYWJvdXQgb3ZlcnJpZGVzIHRoYXQgb3Jp
Z2luYXRlIGluIGxvY2FsLmNvbmYuIEJ1dCBJJ20gc3VyZSBtb3N0IGh5cG90aGV0aWNhbCBjb25z
dW1lcnMgb2YgdGhpcyBBUEkgd291bGQgbm90IGFjY2VwdCB0aGF0IGxpbWl0YXRpb24sIHNvIEkg
YWdyZWUgdGhhdCB0aGlzIGRvZXNuJ3QgY29uc3RpdHV0ZSBhIGdvb2QgbG9uZy10ZXJtIHBsYW4u
IA0KDQpJIHdpbGwgdGhlcmVmb3JlIGtlZXAgdGhpcyBwYXRjaCBhcyBhIGxvY2FsIG1vZGlmaWNh
dGlvbiB0byBiaXRiYWtlLg0KDQpUaGFua3MsDQpDaHJpcw0K

