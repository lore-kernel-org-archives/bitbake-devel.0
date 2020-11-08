Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.74])
 by mx.groups.io with SMTP id smtpd.web12.1750.1604866277977453496
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 12:11:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=w7dwvleG;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.74, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghX7Rci/RFotF3zuLr1eq8XS0plwOh9X1OW8XwkCQtyswz4q7eMHrgTK7vEd7GfVIliiFTsWu1dcFN55BPHArv2/JU9KN6CUtJDWcKuXoFt3cdXL8fobvrpjb8JuXI0sulUmhEDj7qUhfuOKaWdj0J1bAfBb+zgYpmeRUJOYFh5nQFivTlli4IFP2hwCblVG0Fsq8BMofi2r/1xDa72B6Xc7DUVtiLYbby4fUQ0Ut/B3GK6v0FQWU0NJIHEDL59qeTT1mp6cx2uOhVLbBzdsIZYpoMRo5VeDJgVc3mQ5OiNcrdPQASZO7Dal+Dn2azq2WJJU0Et4EdqXCuuOGdHkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n76TB5lcYV+ZKbiMTtGTnOx/ZbfwagDVms6aCe0AUio=;
 b=HLi3m5H3s6woMfdS8hT/FdtkAN3eUBkV1pjdPuTtFiEcQLy1SsQf8Euqn1W+9BjLXQxSpZB+J+t2AlwPQmoah0bm9bu6Y4TpcZcKHO94SdqqKc3Jmq1/WrGVwbCvjWZPJN0/Wk6dvreH157Kw497Vk9XDac8unSSQHlAeZ+AtDden0FN0yb+cK15H2043lmKDero2ADsJ1OVX5S0n6e0RcmFZqpIBi+X9nVhRat+iwF1Di4jF5XW+DeZW1n3v5cHi89FZH6rKMTSbxOaKOGKCXBdWIHO69hDMNGTuMnUHLNVAoNeArwXH5bBVfbkfR3zNvU8Bti7R3lijDqSNmkj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n76TB5lcYV+ZKbiMTtGTnOx/ZbfwagDVms6aCe0AUio=;
 b=w7dwvleGmu/GV4GxT7cBp9fRmJgc5GAGEU1xiz5Tf99moTBz86d73gQg+NHt/nNDezS7MMaMsNaSK7SWFDyC1Hw6EHSi/to9p1z8FUIFWUszAsRAHcLDNWw1X7iacxcvipIJZeWybEj2Pke/2TloaMwwhSUk73nCajiP4QPv0aYDnHTCGPKMAwCrzZyv11YS2Tb0ieRj+dO8ttZsYO1Z2bdQZvwvRbAI0KMeqBD4MFXEtxKUL1GOYfX+MULclh2crAQha9EPUsE0KK//Bv9yCG8PdkL9MBNe/yrvzOrkTE8ZgYfTeOePSnjgQIbpYpCRnC8ToQz8AiEL3UrhdFE3MQ==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 20:11:16 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 20:11:16 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/5] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v2 0/5] optparse => argparse
Thread-Index: AQHWtKyryzZ/lY5OUky4A++HgjLt4Km+baCAgAA+UxCAAAD4gIAAACeg
Date: Sun, 8 Nov 2020 20:11:16 +0000
Message-ID: 
 <SN1PR12MB24801BDF14EC97CAA8A254018BEB0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
	 <c332c4a65509274710a782edf25d9f47af4aa7d9.camel@linuxfoundation.org>
	 <SN1PR12MB2480AFF5381B01CD820B27FD8BEB0@SN1PR12MB2480.namprd12.prod.outlook.com>
 <a91001f466bded3e426a579bacdfb11d6ae61ded.camel@linuxfoundation.org>
In-Reply-To: 
 <a91001f466bded3e426a579bacdfb11d6ae61ded.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 721d552b-4000-457f-ec03-08d8842272f7
x-ms-traffictypediagnostic: SA0PR12MB4542:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4542A33EF051A4F3686D52AA8BEB0@SA0PR12MB4542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UByj3202uvmzQk10kpoEaF8bxVqaPuX/21udSz1bRRrwuDYxfNwaOXqsTW3cLo3pi0iw7etecRyVgRNu3rNJUQjudMBsHypkcB2Y8IGpF30v59srbpep0mqOyvFo2mKbaCI1q1K5GYLrvHuzuiMGwhGiUZR+IaT+6FxtlgYoefGIkxqIYzZsghCHuHQDpBqPWpZqYTTCLr4wBJH3ZcNW0RbdPZnrRY6GAkYfuyS3mqrdP9kAKd4ZTxFfroTn+ASBvs9GBUi7YHHuj+LerVAHlTd5A6ye15OyQHvz8uw1sinLcfPy8fC+XU/AcLJzSnWfyQIbA+/nucJRDsT+R3UHwBmxYFFBk3eL9QXOUiQX2gM1i4JwirHZGtmZeaj8wDmg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(29502001)(66556008)(66476007)(5660300002)(66946007)(64756008)(66446008)(478600001)(86362001)(110136005)(76116006)(83380400001)(9686003)(71200400001)(52536014)(2906002)(33656002)(55016002)(7696005)(26005)(8676002)(316002)(8936002)(6506007)(4744005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 EmbMeTn45RWEjw8hSrxLhkbzT22h2jIgwMF7hFRqJgF6obv69MNQ3+GLTHRF8ewKDpSLh97d5k3qMtYtGZWCh+hH0UOe2t5gA85RJlhIKfQOwbP2fiNNDpgBBIDPue4CL/SyxrxMYtOtOW+bVKlILum+NXqJ5Y6XPllncz1b0SHyFaqPGyxmkEQDaN9FL/ltTOzm57gAlzR+ecCv3SmXLjpYD0vsLZvksA2385QdsQOka7aD7mlMr6mV7/RheDc/xigv3l/DqspxRrRo7EtNqxO+i/DX9O3cJJXT1Ajs8Fk0hL1QQPLWQawGIY/J7RyWGmXlfmzUpewscWV8rN5e/+fTFPNyUMUfT3jMx0I7dj+PhKUuj0OmUjh7ssS6OQ9mvtAEdCZV8ibqoBrBY62hawBJUobz0wrJsBswq8ZMC/olTUXuOP1TmbYi9i0cbdZbc3DH2bBCeQBzRRqAnoAYJu34514Kqmsdx52XEiZ0CSp2YjO63DdNAiUJEfuIAqQUVczJwoLd1NIzQf1ygc+o3ALzALYgPKZM9MgcCWTxGwCe7TnGLh2hG0D3WOlBg2XuE2AMmkbC0I/iDBjrbxegh89l7yprG4LsKNpYToFr38n8nKwcXaMe+VDzmFn1EAImYEtr0NZ8fiLKG90ISfu2DA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721d552b-4000-457f-ec03-08d8842272f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 20:11:16.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvkN+zRx7QBEKSMWJ6iAAXl62lLoyFsCZXCQyOyFTP5qjF4UN279rNiO7NKU3+hqgDoXzVg6gl0apn9xWHtR8j4VHqHxHmE5cjGU678aCYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IElzIHRoZXJlIGEgd2F5IEkgY2FuIHdvcmsgb24gYSBicmFuY2ggYW5kIGRvIGF1dG9idWls
ZGVyIHJ1bnM/IEkNCj4gPiBoYXZlbid0IGNhdWdodCBhbnkgb2YgdGhlc2UgcHJvYmxlbXMgeWV0
IHdpdGggYml0YmFrZS1zZWxmdGVzdC4gSSdkDQo+ID4gbGlrZSB0byBiZSBhYmxlIHRvIGl0ZXJh
dGUgYW5kIHVzZSB0aGUgZmFpbHVyZXMgdG8gYWRkIG5ldyBzZWxmdGVzdHMuDQo+ID4NCj4gPiBG
b3IgZXhhbXBsZSwgSSB3aWxsIGFkZCBhIHNlbGZ0ZXN0IHRvIGNhdGNoIHRoZSBpbXByb3BlciBw
YXJzaW5nIG9mDQo+ID4gJ2JpdGJha2UgLVMgbm9uZSB3b3JsZCcuDQo+IA0KPiBJJ20gYWZyYWlk
IG5vdCwgdGhlIGF1dG9idWlsZGVyIHJ1bnMgdGFrZSBob3VycyBhbmQgd2UgaGF2ZSB0byB0ZXN0
IHBhdGNoZXMgaW4NCj4gYmF0Y2hlcywgd2UgY2FuJ3QgdXNlIGl0IGZvciBpbmRpdmlkdWFsIHJ1
bnMuIEkgd2lzaCB3ZSBoYWQgdGhhdCBraW5kIG9mDQo+IHJlc291cmNlcyBidXQgd2UgZG9uJ3Qu
DQo+IA0KPiBJIGFtIGhhcHB5IHRvIHNlZSBuZXcgdGVzdHMgdGhvdWdoIQ0KDQpObyBwcm9ibGVt
LiBBcyBsb25nIGFzIHlvdSBkb24ndCBtaW5kIHRoZSBjaHVybiBvbiBtYXN0ZXItbmV4dCBJJ20g
aGFwcHkgdG8ga2VlcCBpdGVyYXRpbmcgYW5kIGFkZGluZyBuZXcgdGVzdHMgYXMgdGhlIGF1dG9i
dWlsZGVyIGNhdGNoZXMgcHJvYmxlbXMgOikuDQoNClRoYW5rcywNCkNocmlzDQo=
