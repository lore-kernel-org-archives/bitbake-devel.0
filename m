Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.85])
 by mx.groups.io with SMTP id smtpd.web11.1953.1596845965626074846
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 17:19:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Q7PVOS+Z;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.102.85, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGi2/MoM//WSre51TC+wBhGWJ2dnLbhijz6b0NfgKqKqcIbU+RCYNkpVEwplvFnAHCkqioBlyrL15trBviZKVFzvLA3o8R+ItWveTxK1rhx892C09m2IAcOtPnUp6pwTUFI83RvX2CS1FvD1dSu3LtD64pImWfQsGCSHNhWRvjJfQ2Fac0k8IoSI7oASCtAIzgv4yrWsBLNad7tYeFoOLaZQDqgni0uzmy4aFFQkaVBqzX5K/9AsLuC2oRQoP5jKcvr78KWWIZWnbQgoS15poS2puRcz0UB3PR5gZf6zd/54KeQMrClDv/Tapu4oTsrA5jgi+U1fa/PEHD3QduzW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuCpFdq88Q7qRqRl+d+8gC4QbDHpsx8Y5hvxDqr9Gug=;
 b=UTKqpAU/A0ISsH7MAO3fhhyky79/kf4EeMxxjzh3wHYy5Z7rjVZh8OMCyoNUfmWwblORc7sJBmjmUjkTvwXq6gU5LIsonCBaYD2aI0KCJfpC5lhC/r6nsJN5r6kPdci4BWimQOy4sBwp4+faKVRjhIeKO0BAZZ+azEiTNEQP1JJzW2kZbcx8ZbmB3xJlbIown5v960XIrN77L2vEIXYfyrqCgSo/nJwVPnKHSPtIuxGOCTeeniPimepA8nlPVfUGNDSLhs6inIOQHEqH5WsiMj31iWfvNsYlkuH3R/fj0lMcbyodT/GzFzJSUJ4oLs0C7QkBzO+VRuDTDw0p/zt1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuCpFdq88Q7qRqRl+d+8gC4QbDHpsx8Y5hvxDqr9Gug=;
 b=Q7PVOS+ZWp5Kad1VE2FzZB7lQNgLvn1SGXC+OP+73qux1HzEtYVYHiu5Bg/sn7TtHM6F12ApHZ3m4GnCwDjXoEviGLnOV/i2f5A+p9HpwlEwOUoplwTkbG8z01oGBeSKP8XCZFms+xeLP3OSiMLtejxDUMyVqRPIh4kWjslBU6NBnOEXXaAA5acth3ukNeKli9CYGhqFL25SpHcG34vZqBHZoEi85BFIwz+doHlng8OEFGRvcQv0BIqdDkz1TkYsTaS3i/sDv2l4ILUXf2hnI0ipaZ73VcUk5tdKE64Mb0ARcXrm46Shp2FRmoA/sFbCHPdm9tcnsC6gNJ5hzSB9jQ==
Received: from MW2PR12MB2474.namprd12.prod.outlook.com (2603:10b6:907:9::13)
 by MWHPR12MB1503.namprd12.prod.outlook.com (2603:10b6:301:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.21; Sat, 8 Aug
 2020 00:19:23 +0000
Received: from MW2PR12MB2474.namprd12.prod.outlook.com
 ([fe80::e804:6c93:92b:a68a]) by MW2PR12MB2474.namprd12.prod.outlook.com
 ([fe80::e804:6c93:92b:a68a%5]) with mapi id 15.20.3239.023; Sat, 8 Aug 2020
 00:19:22 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Topic: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Index: AQHWaNouv1V2TYM56Eqj6fr3Jx/DCaktJiUAgAAKPxCAAAB/gIAAMCww
Date: Sat, 8 Aug 2020 00:19:22 +0000
Message-ID: 
 <MW2PR12MB2474D07083D73046771266858B460@MW2PR12MB2474.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
	 <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
	 <SN1PR12MB248071CBED17813537857DC48B490@SN1PR12MB2480.namprd12.prod.outlook.com>
 <31be36c0a9c86f735e8dbc56053a011fde0c0bee.camel@linuxfoundation.org>
In-Reply-To: 
 <31be36c0a9c86f735e8dbc56053a011fde0c0bee.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e16f486-e713-418b-0cb1-08d83b30b372
x-ms-traffictypediagnostic: MWHPR12MB1503:
x-microsoft-antispam-prvs: 
 <MWHPR12MB15038C5D34D2CACFB742EDFE8B460@MWHPR12MB1503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /N7mDLaRMQmIEcVrXzUJ31YA9sIN5sZUi5Zm/4T/+euK9QKh3nCaiflc0s8fJSD40JOLbMjNTqnVsdRlQ3GlO7pQL1jBSyqLnG7PR3lxePFV/JQiNqs/NhMva03y5K6GkIOBuz4gsGkgrbG+BzfTBW1lxSKUqeEN+5Lcw+dURqgV+FxEHBiZxuUOWXbtOfltdjObvaRw/8/X41gdgPRcxVsIs/M2sdDjKWc6JEYdZIjZyam0uC2eqTHxU0M8pMIIJZTUwjpf6kAL6HKWx4VvqTsS9T81QQ5zrQ6e37Qj57cDVS2u8namzcK59PxcY2/t6AqZZV2Jap/rxnfDCLmoo3iqg6xfF+KoU+/sLTBPatbpvFupsGQQ3kqQAnHR3QKddQWrAuP81UkSLmKiHai1tqRC8GBwZ+oTYLunq1CzyggDXK/K3kZ3/ZRpHlNQ31ekQR67FTu+M9hejy9CItRJtpE8qt16qw9MdNZgB7zBOY4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(29502001)(316002)(52536014)(66476007)(66556008)(64756008)(66446008)(66946007)(5660300002)(86362001)(76116006)(83380400001)(33656002)(6506007)(26005)(186003)(7696005)(478600001)(55016002)(8676002)(2906002)(8936002)(9686003)(966005)(71200400001)(110136005)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 SdsMbfZ/ddE5AaEB+JstnCLHvZB+bdrgQT2RZ/5oN/fVbFXwPoJgIE6v+V8UvcUTbdDqjj3dodvXKYCX8iTQGpyj/0VegTSCZHcJSXExQcELKC5g3FceNUV6f4gM9fLL8u4PACgqO4foHYOm8GN8CR8pJ3bdLU0oa4BW4JpT3ML3gpYLlSVyGUt++HwPXwIMeZ2jA4+6QNKsfOvmaxZZZlNTWRpOie1rQqG4CEK4ihrclSOd3sM7XVmjCgYWRkr7IWTt9GLYgokdtnlm6jDMipn7Wiy+4+89oQfPYl1j9Hyz2cOfXxglZ+YCgEXJJf1MKQZdiCYlzT3uE6qowrqXaCR+6QfQueRWf4KyQ3fA+8rmOV898Bg0rPLS13fRgSriMvToDyKqnXuqAEZBK/9+MytZnBaLx/UFgmwRjnXqmm9gBLG5OdpvAIC9mdKs6lIBrVIlFIh3mEzO7Xx8iXowPA/iBRKGEXLeGkh93CgVeavrH9YEvaalekXHl9D7MKGqnkZc8/0bHYi3oE5GAopfCCctZ64X73LKA3DPWpAqyBfVJvGvgDJq7RzbJ24h2xhtf8pY/a+rWOm24+L4pPmEIjm1KFfIU1Omp9fEm9dAm9a/EFpu6mEX1QNLRiv67UVWHFsPexfuzBRwsGOO5xGynQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e16f486-e713-418b-0cb1-08d83b30b372
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 00:19:22.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOpaoPDQfpJHAIHfxOt3EFsUbLMfN5SqS06NnfmiRCSjvB30vh98IgrAF+IqVDG17Bkan2x38Usryo8O+vLhsTsv7VCHbwyy8Eih+39qxU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1503
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+ID4gVGhpcyBkaWRuJ3Qgd29yayB3ZWxsIGluIHRlc3Rpbmc6DQo+ID4gPg0KPiA+ID4gaHR0
cHM6Ly9hdXRvYnVpbGRlci55b2N0b3Byb2plY3Qub3JnL3R5cGhvb24vIy9idWlsZGVycy84My9i
dWlsZHMvMTINCj4gPiA+IDM5L3N0ZQ0KPiA+ID4gcHMvMTAvbG9ncy9zdGVwMWINCj4gPiA+IGZy
b20NCj4gPiA+IGh0dHBzOi8vYXV0b2J1aWxkZXIueW9jdG9wcm9qZWN0Lm9yZy90eXBob29uLyMv
YnVpbGRlcnMvODMvYnVpbGRzLzEyDQo+ID4gPiAzOQ0KPiA+DQo+ID4gSG93IGRvIEkgdmlldyB0
aGUgbG9nIGZpbGUgaXQgdGFsa3MgYWJvdXQsIC9ob21lL3Bva3lidWlsZC95b2N0by13b3JrZXIv
YS0NCj4gZnVsbC9idWlsZC9idWlsZC90bXAvbG9nL2Vycm9yLXJlcG9ydC9lcnJvcl9yZXBvcnRf
MjAyMDA4MDcyMDI4NDMudHh0ID8NCj4gDQo+IFRoYXQgd291bGQgYmUgdGhlIGRhdGEgdXBsb2Fk
ZWQgb250byBlcnJvcnMueW9jdG9wcm9qZWN0Lm9yZyBidXQgdGhlIGFib3ZlDQo+IGxvZ3Mgc2hv
dWxkIGhhdmUgYWxsIHRoZSBkYXRhIHRvby4NCg0KL2hvbWUvcG9reWJ1aWxkL3lvY3RvLXdvcmtl
ci9hLWZ1bGwvYnVpbGQvYnVpbGQvdG1wL3dvcmsvY29yZTItMzItcG9reS1saW51eC9kaXN0Y2Mv
My4zLjMtcjAvdGVtcC9ydW4uZml4dXBfZGlzdGNjX21pcnJvcl90YXJiYWxsLjkxNzU6IDE4OiAv
aG9tZS9wb2t5YnVpbGQveW9jdG8td29ya2VyL2EtZnVsbC9idWlsZC9idWlsZC90bXAvd29yay9j
b3JlMi0zMi1wb2t5LWxpbnV4L2Rpc3RjYy8zLjMuMy1yMC90ZW1wL3J1bi5maXh1cF9kaXN0Y2Nf
bWlycm9yX3RhcmJhbGwuOTE3NTogU3ludGF4IGVycm9yOiBCYWQgZm9yIGxvb3AgdmFyaWFibGUN
Cg0KU28gSSBndWVzcyBpdCdzIGEgJ3NoJyBwcm9ibGVtLiBJIHRob3VnaHQgSSBoYWQgdGhlIGNv
ZGUgc2V0IHVwIGNvcnJlY3RseSB0byBoYW5kbGUgc2ggdnMgYmFzaCAoc3BlY2lmaWNhbGx5LCBi
YXNpY2FsbHkgYWxsIG9mIHRoaXMgaXMgdHVybmVkIG9mZiBmb3Igc2ggc2luY2UgaXQgZG9lc27i
gJl0IGhhdmUgdGhlIGJhY2t0cmFjZSBjYXBhYmlsaXR5KS4gQnV0IEkgZ3Vlc3Mgbm90Lg0KDQpD
YW4geW91IGNvbmZpcm0gdGhhdCB0aGUgYXV0b2J1aWxkZXIgaXMgdXNpbmcgc2ggYW5kIG5vdCBi
YXNoPw0KDQpDaHJpcyANCg0K
