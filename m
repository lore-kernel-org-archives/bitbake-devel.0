Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.50])
 by mx.groups.io with SMTP id smtpd.web11.569.1588111631093631089
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2020 15:07:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector2 header.b=pKoO9qVC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.50, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmBJwoWaNnE2q3de7riHzKvT/e1eWGS5KrUSLbigwr60Z8kC1g722vYkZaTr8kw47jIIfxRZbfx7d2pXS3bLkRpZajSs8jN3eIBIcC6hqCdqU3N451Mkx8povyE/uPaw3PuGM6hWG1tAAIZzL0fn89MR/qtzsYL8kVLk/nGVKDNOPZnL6pjOhdSUhgDlrvHOoE5pfMJM25Od+8wG7gyYHaGijNYwJWJjLKT4LGQL4hxEGUJp5xmy5g5ufiVJchbNdbWh5OZeqxAlDfsH8hNU8acQg5u7z7RK8XgVP/vAA/M0+xdJbTv3J5YrCjrezoyaW4+sdd3Y/JUioeuan8SwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y72tCSx0ZzrGnk+V0lwn6v1nn6YPRi5WrOH+LMhX/LE=;
 b=MMFx+NS8IJtwue03HwRrfmIrazt5ynZjHf+ZlP3IZqYhrYoV/duPA5qjx5pqou53W9eAGIwnKFpp3efZjMnvcE/GOnc3KI2zldvLkGLMcKAHJky7iyMMx9pwDK9lyUEnsUnPuchrVo6ZVU40/w3IHhiKLsVCRPaZz6HIVTGRuLbRwpx+fTHLusVS7Y6q+IuWz7zt695PUzn1UlOzS6KZIrKrKuXBtwMU1jdZtqvcL49zE9JvS7UmPiVJoZpV2O9fUyCcr6e1WOunRJlKkQluiE8XWfT1F9lWZ5Yb65Csk3X7Be2UOn/MszLJRaP9e4nIeYOTiSXySHxF1RFiLqU+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y72tCSx0ZzrGnk+V0lwn6v1nn6YPRi5WrOH+LMhX/LE=;
 b=pKoO9qVC0jM4y35t/yBaXWAXBfW8kpyvTh3m6ed/YcRikKpehqmJNyF2EkZ/prVQDXxLDYs+yRw4cmGggpkxnW9wXz4+fwV16wdoHMS4b9hn4PVVOSqeVRPPXSPSZG88HNpTclN8taxM4ky/c00SoQp7i4iPd9F2ZaRWF/mric0=
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 22:07:09 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::b1d0:1320:b3eb:183c]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::b1d0:1320:b3eb:183c%2]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 22:07:09 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Andrey Zhizhikin <andrey.z@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: ui/teamcity plugin is broken on master
Thread-Topic: ui/teamcity plugin is broken on master
Thread-Index: AQHWHaju3+3gUKQQf02x6I0NvbD9+KiPFuWg
Date: Tue, 28 Apr 2020 22:07:09 +0000
Message-ID: 
 <SN1PR12MB24804AF999291543ACA14B9C8BAC0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: 
 <CAHtQpK54tCZf3PHY657cjARhj_j2X6SM834yybiCyk2EPO2Srg@mail.gmail.com>
In-Reply-To: 
 <CAHtQpK54tCZf3PHY657cjARhj_j2X6SM834yybiCyk2EPO2Srg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39c90bd6-5415-4026-0bf3-08d7ebc07f07
x-ms-traffictypediagnostic: SN1PR12MB2397:
x-microsoft-antispam-prvs: 
 <SN1PR12MB23979E14C16AB4E7748109A38BAC0@SN1PR12MB2397.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(136003)(39850400004)(346002)(29502001)(9686003)(186003)(55016002)(8676002)(478600001)(76116006)(52536014)(4744005)(8936002)(26005)(86362001)(316002)(66476007)(71200400001)(7696005)(66946007)(6506007)(64756008)(66556008)(66446008)(5660300002)(110136005)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dIyQwTwW9ToCHxyizC78UPwQzYuyB80PUTzVYrkktqFO7NcC81c9UMY8bRE3tiK/JrfObdSyr5IeXOYoVHJBPpmeQTd/+OrWYtFYBjNoY0CG+ZlO/ciRfcpgdqcWo8ALrNUBpC4xl+o5+xnfWgsloKwUa7+H8AkOXEqYQntLHazPwC3pmS2puTbWI8KVicAWp9LPLPnEo9CTKHoIh2Af/1mwwAcKrvY5Q+7igXkwHBmYk7FdTazExFWQaBnf8Y/NxEMfHzKi+Gx5mQ256uXZ5SmKSHwyUxrlJyvplQS6EC0sP/Y6+L2l8uuL+gcibitK7AcOtZvLDINRMLByFooUfjJZz7JAj+N0ZlhiVZsH1pN3Z4Awy1rF1N3d+kpE21dcmQA7NCXEnjuIvnWWey0U18WKZ284a6QtYenPnCMnFFrAYY2083iLx09bNYiX0b6PQA6ca4qo9NwexLYrCCvpRch4+14OMOBTL7qWK89xivYOVZ9dSQNftnNNL2rs9HNw
x-ms-exchange-antispam-messagedata: 
 In5Zh5InEfYyYN2OdeaSSmZubmBBYCKi61ZRvAp0tAQ95M/Wf5cc6VGk3Kf+uBnfA5xeIccR2Ex7+bGcBFRZuRj4bwZUg45dDXanyIT9hD9Ge45oLmBoZ0U4Ih7ib013sAdPanKw1kOXgcexlPLduwrV6wlvacKPY3CBpvEFsfnxgHeRDERdvu4evPaxBVlECUtA401Bx9EikrPFoNBc3foCJeHZ6gHMdYY7N7k9wK4eMsTVOz+jGYwO9JFiPD9+cjK1SAsI72mVsD/h+O792T6UENE/70ibLrrc00K6smYbhF8iBIHbKbE3cZJSlKVvnu7GwqRnm0OKiyBJWHF+wjtZVfaj9jIhgSuqWWj/2moPV7VMGmoDhlZW0ZkfXX80ZcJ+nnicz/ZJVwhLowKC2DhBqubhpCWVEVT3M+Cpb7PuwzmiXlDjgssl4flr20xEmAOvh0fP7TwBQmSF1A6C4kPHBdX1TaCIjVm3+t5WpkwsW6Jcq8wZa3D2qgi4ON78JOlzKLL1KwNuXwOWkfYKyfvvimxRS23bUjI1UzFKBLjpiRgy651c1HY9C0RhrhyX/pBiq6QT/ioIv9CgEV7j66qp5z/TeOIX5LJjDyJLR3IkyDR4c0pf6BSKpNiAECS0Do/o1bQYVU7+tRisQ87gQRSVPHhfm4pocJV+HEsj7SUHmiducs/JpaXE9TjoMUMdQvNQyDyKEvKRiNIf+Nvo5kVnXARMThvPN/J3AltBiA7tRMDCH90yTyHLYaMHUGdiuam7LeLlbog1GAnBcyjGxlS/4A3v4GN3eaDTfX6gYvo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c90bd6-5415-4026-0bf3-08d7ebc07f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 22:07:09.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yS0QYf+wmzooTfhmM+RctF+X+ukEq1hM5tWBUy++4xtmamb8NMDjPyycaD/PzCgGTDGLEht+NN0gqDL7QNFjsljhi/YaF/AQrWZ22pOkAmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQW5kcmV5LA0KDQo+IEl0IGxvb2tzIGxpa2UgdGhvc2UgZmlsdGVycyAoQkJMb2dGaWx0ZXJT
dGRPdXQgYW5kIEJCTG9nRmlsdGVyU3RkRXJyKSB3ZXJlDQo+IGRyb3BwZWQgd2l0aCB0aGUgY29t
bWl0IDE0MzY4NWRlMWI5YjAzODZhNGRjOGQ0MDRiZGYzNDJiNDViN2MwMzANCj4gaW4gdXBzdHJl
YW0sIHNvIHRoZSBwbHVnaW4gc2hvdWxkIGhhdmUgYSBncmVhdCBkZWFsIG9mIHJld29yayBub3cu
Li4NCj4gDQo+IEkgd2FzIGFibGUgdG8gYnJpbmcgaXQgYmFjayB0byBsaWZlIGJ5IHJlbW92aW5n
IGZvbGxvd2luZyBsaW5lcyBmcm9tDQo+IFtiaXRiYWtlL2xpYi9iYi91aS90ZWFtY2l0eS5weV06
DQo+IC0gICAgYmIubXNnLmFkZERlZmF1bHRsb2dGaWx0ZXIoY29uc29sZSwgYmIubXNnLkJCTG9n
RmlsdGVyU3RkT3V0LA0KPiBmb3JjZWxldmVsKQ0KPiAtICAgIGJiLm1zZy5hZGREZWZhdWx0bG9n
RmlsdGVyKGVycmNvbnNvbGUsIGJiLm1zZy5CQkxvZ0ZpbHRlclN0ZEVycikNCj4gDQo+IEJ1dCB0
aGF0IG1vZGlmaWNhdGlvbiBpcyBjb25zaWRlcmVkIGEgaGFjayBhbmQgSSB3b3VsZCBub3QgZXZl
biBkYXJlIHRvIHNlbmQNCj4gYSBwYXRjaCBmb3IgdGhpcy4NCj4gDQo+IEkgd2FzIHdvbmRlcmlu
ZyBpZiBhbnlvbmUgYWxyZWFkeSBoYWQgdGhlIHNhbWUgaXNzdWUgYW5kIGlzIHRoZXJlIGEgcGxh
biB0bw0KPiB1cGRhdGUgdGhlIHRlYW1jaXR5IFVJIHBsdWdpbiB0byB1c2UgbmV3IGxvZyBmaWx0
ZXIgbWVjaGFuaXNtcyAobGlrZSBrbm90dHkNCj4gY3VycmVudGx5IGRvZXMpPw0KDQpJIHdpbGwg
dHJ5IHRvIGdldCBhcm91bmQgdG8gZml4aW5nIGl0IG9uIG1hc3RlciBzb29uIChidXQgbm8gZ3Vh
cmFudGVlcykuIFdlIGFyZSBzdGlsbCBvbiB6ZXVzIGF0IHdvcmsgLSB0aGF0J3Mgd2h5IGl0IHNs
aXBwZWQgbXkgbWluZC4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==
