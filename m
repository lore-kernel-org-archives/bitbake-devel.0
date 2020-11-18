Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.52])
 by mx.groups.io with SMTP id smtpd.web08.27538.1605719314535308770
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2020 09:08:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=idrxouyb;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.52, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiGdEDhxLjUJQ5Qp/Z9YzB7erdwPJJ/HRf/wqBSxTavXP0wFUdim8D3+ozkI23mCtkXOd2+daK+WFtCyFr8mj5n937juMkIfClP1n0jx6N5ZOG5tHtnB6clGOYLckfWzhIHQ4SdKx3rNpKUrRR34PQK4PzGxDr4xQ9hxS4MBZhNIh7Vb2/mLbaHIn58cPk4oLb3lFKm+5x77xW6wBQjQuqi8tv6kWhFIjTdiwWFRtwR8cXWrXYd6Uo9toGK3/JQbxYuGMs3aOv8q72gwHhA6xQuX3NqrtUNovxZHVqRM8mB7ypMOX9jTEiYYsfOPDWdrUTIfjqDej1YucWQ95QrMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6z7QwBasbdXgzOPUV5wrs8hfyfbnLTlLOk7nStb+oE=;
 b=ar58zRmAgKK7w7IvpdC20N4Q8AQ1NX3KSiafAN7EjHyB6zIZhgK6CTn/jlNacFtMctk+u/+PsUGE0kJpzCwi+2N0b1ExBdIId1bFfBnAnRomtXi5CeO5VUx0HQueywWK1B6oQ1QBXOV4BpBiQu8BcsQiYYFI/noYDFdUip1a1mRSoiZPiAKSqz6JgbWjTAfciGGm8carW67DnUkLhlWEYleFA5Fv7DMFzoBziUEZQYJZACxCe5mbAPHPBepUhXaQKjH1LdIiaROrvd1aLCBUSi+MWjs+IpR7H51WSk3e6W+FJtRJvGSR3FP/TuiAJZiE9iWwlhVlgN39gir+GmlKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6z7QwBasbdXgzOPUV5wrs8hfyfbnLTlLOk7nStb+oE=;
 b=idrxouybSCahvJmI+9YoDlCgDBVqP/0LAIGZws4GwbQfqFoWC1YM8Jahf9H0k0+ac+wOdZ4NgR7YC7AJGIKxDQSlO5Z5S78y6R+mwP4yTU8YvhFot9yBBPgNWBUanVjO5pIaMwgRP/GXZoe9heuCU+KrT49kS3kRPsX9dqdDcNCf9ZVOz/s9Taz4g8hPrRmcv6pgAgHEEVp64+jgLPXuRkZf5ksP25Rwcph632OGkqSYuLUPqrwdZZAaC3NxPq/khOcVQ+rwF+0AzjBGu/jnnRBh1I0der9KNLcwJ5WefK059SNy+pQqK/C8pGRoZqZ5c3adLed/7O+zWy8IffvVQQ==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 17:08:33 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3589.022; Wed, 18 Nov 2020
 17:08:33 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Index: AQHWthw4kN7CZJaZ2EupBAhsiadueqnB540AgAw8oTCAAAPkAIAAAXzwgAAE6vA=
Date: Wed, 18 Nov 2020 17:08:33 +0000
Message-ID: 
 <SN1PR12MB2480796288BDF804F44092C78BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
	 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
	 <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
 <710819fcc1b29838ea7d2f2b332fdd44495219c7.camel@linuxfoundation.org>
 <1648A9226B93C86E.28066@lists.openembedded.org>
In-Reply-To: <1648A9226B93C86E.28066@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96bf45dd-a7fa-4f82-9339-08d88be494b4
x-ms-traffictypediagnostic: SA0PR12MB4381:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4381D402B906099A9ACA4B0E8BE10@SA0PR12MB4381.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4ki2B5GlSzzFGfOyb0miJx4Soh0n8ivBQJwBEy2Ne7WAL6shUPgbkIgVg/KmeSH18nYqgxRxXsXbMkCzcReZn73TLFWdvhn+I4lzpoL2eCVqIw1KLVEDdmUBCDSncAtTxbjoKLA5Q3UhWA1w7U396OSQbB9nX2MqvHgxprJ1ot0O/fBpeyW/2BqgC7HQSoafX3ctT9UleuKC45xjwsXtNbHw0uVetcIean2rFNc6fFgAnAJR7MmSsS6OBAqAhN/zP0BZzjgIcWh8XHTa2wxKdNcKBkh908dQJFREDSQ1zDgiiYWtNU0V9+9z/XBJS/9NbtHx0DlPC8Wiji+UDTuG6cGHPYzYQEIt6VP1P4G6K9pE/NfVR7lvhcmqz8Ldb189
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(29502001)(316002)(8936002)(6916009)(33656002)(83380400001)(7696005)(4326008)(52536014)(5660300002)(76116006)(66946007)(66476007)(6506007)(66446008)(66556008)(64756008)(8676002)(26005)(86362001)(2906002)(9686003)(55016002)(71200400001)(478600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 BwHOKgPzz1Vk6frB3U9sgTE1ETatr+xkAbaXLZmPs0K/sGMDFSk9y4XZ6okSOZ+fI+FLhMejg9/v1TAi4Zh/jzzmjLahT20mANvDNcYklCYX6rcSOkKNcus4EPD07pXeBt/mp8jsLFb4LPX5U2NT6uZNkZyvNUkvJKAL62IlzoPEqffZiEBm2KM/2zKt9aK25ctEb47rmIbG8mXksle4TFKFM7htKCO2lbiJ0aLCwOV2EYqidiHoQ1cvpgS+8sxMdQ2SYhAcP2uCOs1Ry202aOfwyXaxrwnOCIweXbDr3Cg3oZDe32UNnHH//T6OEh15F0tkiAQ1D6Y+SXzQOx3XQVRRd6wcx6HG5yckVzxuIWuJ34jhsFMf5wPy38mgu8MdS59V2Vhu9Lc4RuFNcdrc8SHnBV1W1mDwdSX3qhlL0LiAFve86i/7X8tBjjc+V8wB2uXZ3D4wlg2xXg14F3Yf9MkxVdMPTzbbX+3pdEromt/f/abLl0MQNFDSrSP7oJPvx35Id5CDXI/MJC68OniOMVIvc3z9owZHWY/+BZh0I3vhUuWAbd3/kL3rWPLx2VtMXXFizqpa9HeLNBXZKinUNDxqIQLqdPx7pCnEGot6puTvM0KnaOzghFdFAgQoS90Ht07Yp821o6FOLdtZxgGGTw7WSNaegRjijjdGOJfQEHNy3QDhgKYt8Ab6kpBdzT2qROEtSeXkj8PvODyfKFj2Eyhn0kFDhhfL7y9aX5LlADoolFrl647kU/FrBbySrEs3sLDytgiT6nvJa+qOwRaSYlXiQLTlcUTjNjoN4ELGXOXc0MU1BxJMNSrq1T2/o0+p9Bd1jFaKLNDFcO2Vv5h+CGrWN0Ox+hq0oreFLxw19QoQzKETXyUbYIB+70RAINADnl508kV3RgKAyosRS941Kw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bf45dd-a7fa-4f82-9339-08d88be494b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 17:08:33.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1QamIBzmc2GV/vkNqvD9BpfEA3UY4t6AfWxExuHC6vceezhEs1B7omkUxuKZHDHHiKuk/nONru5WfxSZFOjRYyERHyf8AftmAzjIJOFDq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBVbmZvcnR1bmF0ZWx5IEkgZG91YnQgSSBjYW4gZG8gYW55dGhpbmcgYWJvdXQgdGhlIEROUy9T
UEY6KA0KPiANCj4gSSdkIHJhdGhlciBhdm9pZCB5b3UgbmVlZGluZyB0byBtYWtlIGNoYW5nZXMg
dG8geW91ciBzY3JpcHRpbmcganVzdCB0byBkZWFsDQo+IHdpdGggbXkgcGF0Y2hlcywgc28gSSds
bCBtYWtlIHN1cmUgdG8gc2V0IHRoZSAnRnJvbTogJyBoZWFkZXIuIEknbSBnb2luZyB0bw0KPiBz
dWJtaXQgYSBwYXRjaCBzb29uIGFzIGEga2luZCBvZiB0ZXN0IHRvIHNlZSBpZiBpdCB3b3JrcyAo
dGhvdWdoIGl0IGlzIGFuIGFjdHVhbA0KPiBwYXRjaCBmb3IgYW4gaXNzdWUgSSBmb3VuZCwgc2Vw
YXJhdGUgZnJvbSBhbGwgdGhlIGFyZ3BhcnNlIHN0dWZmKS4NCj4gDQo+IE4uQi46IEkgcmVhbGx5
IHdpc2ggZ2l0IGhhZCBhIGhvb2sgdGhhdCBydW5zIGF0ICdzZW5kLWVtYWlsJyB0aW1lLiBBcyBJ
DQo+IHVuZGVyc3RhbmQgaXQsIHRoYXQgd291bGQgYmUgdGhlIGNvcnJlY3QgcGxhY2UgdG8gYXV0
b21hdGljYWxseSBwcmVmaXggdGhlDQo+IG1lc3NhZ2UgYm9keSB3aXRoIHRoZSAnRnJvbTogJyBo
ZWFkZXIuIEkgdHJpZWQgdXNpbmcgJ3ByZXBhcmUtY29tbWl0LW1zZycgdG8NCj4gcHJlZml4IHRo
ZSBlbnRpcmUgY29tbWl0IG1lc3NhZ2Ugd2l0aCAnRnJvbTogJyBidXQgdGhhdCBkaXJ0aWVzIHRo
ZSBsb2cgYW5kDQo+IGJyZWFrcyAnZ2l0IGxvZyAtLW9uZWxpbmUnLiBNYXliZSBJJ20gbWlzc2lu
ZyBzb21ldGhpbmcgYnV0IEkganVzdCBkb24ndCBzZWUgYQ0KPiB3YXkgdG8gZG8gdGhpcyBhdXRv
bWF0aWNhbGx5IHdpdGhvdXQgd3JpdGluZyBhIHdyYXBwZXIgc2NyaXB0IGFyb3VuZCBzZW5kLQ0K
PiBlbWFpbCwgd2hpY2ggSSdsbCBwcm9iYWJseSBlbmQgdXAgZG9pbmcuDQoNCg0KQWgsIEkgc29y
dCBvZiB0YWtlIGl0IGJhY2suIEl0IHNlZW1zIHRoZXJlIGlzIGEgc2VuZGVtYWlsLXZhbGlkYXRl
IGhvb2suIElmIEkgY2FuJ3QgbW9kaWZ5IHRoZSBtZXNzYWdlLCB0aGVuIEkgY2FuIGF0IGxlYXN0
IGVycm9yIG91dCBpZiB0aGUgJ0Zyb206ICcgbGluZSBpcyBub3QgcHJlc2VudC4NCg0KQ2hyaXMN
Cg==
