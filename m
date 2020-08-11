Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.59])
 by mx.groups.io with SMTP id smtpd.web12.16841.1597157809690943849
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Aug 2020 07:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=yMGw14ce;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUazdCc52LkxOURmlBVgBG49dyPiiiQ++MC1nja6R6eXjUwp4jBxFW6ILAlFfXRgyLrZsGhO+IUNDWyVNXFYOedHvalk3K3IxaOs3bV+Qk9xK+/hFiMWeN7MCJuq5pXgaRAtsv/qXeSaTdia8j4mo9cvWSJ6u8efwm+XXOGGLVlXqj+i7B44bI9gtdcS8X0lriswbW5cDTy/1W+tn84k4BMyyfDNlvRSwtJo/AgsJpChqRX9q+/boB7b09BEZPvSMiZizG/M86uPEJ8L0t/NHTr+7o4uO04PR8BKdea0/rj7nOy4QNNN6ryJYxwiK01qkvU/GGK0+/taYOO4bXzOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVDzQmlc9fAOM3M3dcySlPuJAp16NzeoBhWDL18pNpA=;
 b=cpft4PJ6rg52wyJH0O568cO+r6Qo1+3M8MqQiYQGLoLfNedP9D+P9eAmhJ8I0AhSl6d17+7lksgi90PfZh9Ax7393ZKtFiloH7EaAM57MtZ4kyFHhY3gtI6un3MgCHcOwDZ4tAYI6NTN9uroanrvginbcrJxCKIWz5tJflJD3PyEoRPe92VkvA1S4iEAn3fQY9CjA7AtcW8YuDZQWkmc1m98EXyEKXBWStAbFe5Reidy7oVqGANMRQHhnS9o73iRBjZHPyHhVEDiOC4ggFt8DQzLMVICBsSatiSoV8782+LpSEvHibFHw+jmCebYQWB0QqPHMRR5KotAo8jwiMUSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVDzQmlc9fAOM3M3dcySlPuJAp16NzeoBhWDL18pNpA=;
 b=yMGw14ceCoemS+NqGN3w+9rmp15pMedJStxRSUi1yfLSy39WvI/1Ze6pJ/457vBJJEF0GPYILNzFiK5FE5ZvK/tbsHcRBhHugOiKCbkDG5nNbtokYakKASGc6lbdD2y2iuw9tr+tHem/qAEiDdIhWhKVIACdTZgl016CngNW3RFXOWBKpbhxBtw5EFuK9hnVZYHByz7+HslJkB9Zs+T4Fy++dZZusgJNQ1eKBQBAtX1GmmT1QePW9YnOhIvzJLc+sfmBV3qMKmq5NJpr8UXs7krRckImykUJhIhmnb0Tg1agZnqEgqMPVTTTWTjbpWGG4QGGqZoHjnTKW7P2uy/qqg==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 14:56:48 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 14:56:48 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v3 0/4] [RFC] Shell func backtracing
Thread-Topic: [PATCH v3 0/4] [RFC] Shell func backtracing
Thread-Index: AQHWbzcYkH7KvFFdHkuPXVuGFDgKxKkx5xUAgAEZZfA=
Date: Tue, 11 Aug 2020 14:56:48 +0000
Message-ID: 
 <SN1PR12MB2480B6E762B515E9EF0FAC9A8B450@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200810165524.37417-1-chris.laplante@agilent.com>
 <7175d431218ff97c0c28fdaf40c89685feeb2f9f.camel@linuxfoundation.org>
In-Reply-To: 
 <7175d431218ff97c0c28fdaf40c89685feeb2f9f.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19878ce3-d5d5-444e-34ad-08d83e06c5eb
x-ms-traffictypediagnostic: SA0PR12MB4416:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4416BF6DE84A0F2856AF83908B450@SA0PR12MB4416.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WPcsdFhr+PKoRfm6xeuiWp+vQT36KJU3c3h1RP7sLItbwqcwCrokXLs00P+Kl2bPOCjrnY+X+nGMNU6JevMMxxu4vKkeUgwtlTQoDPv3o2XmPgB7pVdwdgS/TIA8e3Q47VHmapuJb5y+7KkvVFM8mSKuhgmDulAiN/jYbInmkdcztO5QOk6n6aqrh4/OSZUX2lxPYkTZKWi6Rnpi6L5YLbn4QhWzIxwJHWP0kVVc0MKb7jLsbA2av5lozgCsMYs0m2L26XTXHoHKijLaXk8T/8drifwl7CyDRooE7n8EqpNFivxGtQktVzQr90szkKM3d3jOpGHccE3YUS8SEUPJSIC5MgJsDYX3SEskDvRQj1T2lQWj0uN194GPQVeU/y5gwswOXPQHbfMgytUAj7lHUmO+KX2+Ha7tP7/55XCocAQ9krpysId0bAJ/G5hfBwLvCM8nCaOPAdpnIUNI06E5Ow==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(29502001)(2906002)(9686003)(966005)(33656002)(66476007)(55016002)(186003)(66946007)(8936002)(110136005)(66556008)(7696005)(6506007)(71200400001)(498600001)(76116006)(66446008)(64756008)(26005)(8676002)(86362001)(52536014)(5660300002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 bYc8XomCvgtxaivO+aiq2G1La7vpdc6of34a3aFfY5mcW9wujSLXfUm9XjBA7sixAmeOylNj+6SIdhWOqCt8kPAUlh/BDteUQ70VQrI54BP2W6uG7E5N1LUNCMOI6qBxM9U+HRHkPHl7RQDtXpuUcT3E2B8tc52a5CIZ05lBJLZ3NUpukEWFxTiShF/uInj0hsZMAo8fLeSN5b20I8xxpfSleGOrYgMDb++OrGN7ir43X6ZsyTrBTUl30v3YYUOG0Kl4Yw9gUn9+7jNu0Ef8ewbNqsh7A1jWvRbCjbfjRirwkS+UXCgfM7T+8tjfDX7RD6VTXKb1MEzxCoNNGB4llDP1l+z43CF7xgM6htFbZJfGGdYr/6341NJukIRPpUea992pg7PNYl73bNCDSO7jXTdquKelEOc2yxed9yUDG8mQdGQqIRpiIq8Tj5o64gi6HkXVhIRb9B9KRiaXs7U+CuSw8Rd+9eP/Shmed2/7YTHHrUgwsLiZhzpdeN88naF66wfHCEcDYhIMuZSX0WrIlSFb3jWpbPCNDytFEOpc2zpS1htS7rjPZ4rYdhYEkP08orO90oGorbbkhykuzr5IuGOwLJ3LR0EOR/HjNsg+rUdx74AE5/thfOovU+w5t2hfO8KoG9VFDYnLYl/hpBTo+Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19878ce3-d5d5-444e-34ad-08d83e06c5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 14:56:48.3327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uEa+k3/mTSXItmwYC/+Y02IyVdPTi3QTDiq2/viQVDcGGb/xOsU+cuIX9dpQ6FA3Wqsv2gZHixqs8cY+4v3cUVlucZ//rmR2eFZ41TRewU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBJIHN1c3BlY3QgYnV0IGhhdmUgbm90IHByb3ZlbiB0aGF0IHRoaXMgc2VyaWVzIHJlc3VsdGVk
IGluIHRoZSBmYWlsdXJlcyBpbiB0aGlzDQo+IGJ1aWxkOg0KPiANCj4gaHR0cHM6Ly9hdXRvYnVp
bGRlci55b2N0b3Byb2plY3Qub3JnL3R5cGhvb24vIy9idWlsZGVycy84My9idWlsZHMvMTI0Nw0K
DQpJIHRoaW5rIHlvdSdyZSByaWdodC4gTG9va3MgbGlrZSB0aGUgRVJSIHRyYXAgaXMgZmlyaW5n
IGV2ZW4gZm9yIGNvbW1hbmRzIHRoYXQgd2UgZXhwZWN0IG1pZ2h0IGZhaWwuIEUuZy4gDQoNCnN0
ZXAyYjogV0FSTklORzogL2hvbWUvcG9reWJ1aWxkL3lvY3RvLXdvcmtlci9idWlsZC1hcHBsaWFu
Y2UvYnVpbGQvYnVpbGQvdG1wL3dvcmsvcWVtdXg4Nl82NC1wb2t5LWxpbnV4L2xpbnV4LXlvY3Rv
LzUuNC41NCtnaXRBVVRPSU5DKzk2ODgzYjM4YzFfOWZjMmZiMmU3My1yMC90ZW1wL3J1bi5kb19r
ZXJuZWxfY2hlY2tvdXQuMzI4MjA1NToxOTEgZXhpdCAxIGZyb20gJ2dpdCBzaG93LXJlZiAtLXF1
aWV0IC0tdmVyaWZ5IC0tICJyZWZzL2hlYWRzLyRiIicNCnN0ZXAyYjogV0FSTklORzogQmFja3Ry
YWNlIChCQiBnZW5lcmF0ZWQgc2NyaXB0KTogDQpzdGVwMmI6IFdBUk5JTkc6IC9ob21lL3Bva3li
dWlsZC95b2N0by13b3JrZXIvYnVpbGQtYXBwbGlhbmNlL2J1aWxkL2J1aWxkL3RtcC93b3JrL2Nv
cmUyLTY0LXBva3ktbGludXgvbGliZXJyb3ItcGVybC8wLjE3MDI5LXIwL3RlbXAvcnVuLmRvX2lu
c3RhbGwuNjE0MDg2OjE1NyBleGl0IDIgZnJvbSAnc2VkIC1pIC1lICdzfC91c3IvYmluL3Blcmwt
bmF0aXZlLiovcGVybHwvdXNyL2Jpbi9lbnYgbmF0aXZlcGVybHwnICRQRVJMU0NSSVBUJw0Kc3Rl
cDJiOiBXQVJOSU5HOiBCYWNrdHJhY2UgKEJCIGdlbmVyYXRlZCBzY3JpcHQpOg0KDQoNCkkgZ3Vl
c3MgSSdsbCBoYXZlIHRvIGdldCByaWQgb2YgdGhlIEVSUiB0cmFwIGFuZCBqdXN0IHJlbHkgb24g
dGhlIEVYSVQgdHJhcC4gQnV0IHRoYXQgbWVhbnMgd2Ugd29uJ3QgYWN0dWFsbHkgZ2V0IHRoZSBs
aW5lIG51bWJlciBvbiB3aGljaCB0aGUgYWN0dWFsIGNvbW1hbmQgZmFpbHMsIHNpbmNlIHRoYXQg
aXMgcmVzZXQgZm9yIEVYSVQgdHJhcHMgOiguDQoNClRoYW5rcywNCkNocmlzIA0K
