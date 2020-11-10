Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.43])
 by mx.groups.io with SMTP id smtpd.web12.34443.1605044180307644074
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 13:36:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=FT7AbEhK;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.43, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiTj6ztUSbhW5xYkliiRWJmB+EtZRh+ES+zmlhQmcSVIm9j/H4FY8t+zb3rWME6sMMSSbVcfYfJJNrAFcxCfMAsIOhqfwpKTLEcpsMaSF2dRJJED5v/ldZBnm1RR3WBD1Dc2xG1poL8eK16e0iCAzOkEArNsjfkKoGHFFAQ8roo7B9VyUiQHFQc+0ql2PiuA2Lwfeyf51wKfFKf/JicGTqU09m6VEsfnF5+9z9uoyCnFv9f5rd52EPLdjfyO9q3AY/95v3oTulD64btoNmZVvn+z0gaRuDikjvCpOBgWZZJ7UZQ1fz48SOY/pvlwAV66RowIVtESv/BCBTqfWZfs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvnqh6QeJB5cOEc/e68FT4QC2doVJYdylZxcSn319Zk=;
 b=Q2VZp53xsZ+ZSPm7vES9pW2he3Z9x7zTQYC8jqWRZP0olYGdwO/ptLw3UCX3lnUa7nUopX+0D4JwGCuZrhAUybWZl9O3otwm5zIJPbXBh+TKZT1FobwcJsVvdh5C/UNPl0d30jJTFHELrht+6FfUMzetnbLIwOjbsYqMp2bu2LSA/I6umsX965UYox2S1SFoPIFGdRGKFLLi0PZi+FtUCatKFs4AC3hWVMy4iTo7fupBHV6aNwo/DCL7jQNGPXUrNNar9sOGP8B7wOe0yQ7o86d2hmHKCy2FlFgD/OvKXzeV1L8idWw8HAKGQbv3A4hveqjxrC9AyhMMkHj6idUzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvnqh6QeJB5cOEc/e68FT4QC2doVJYdylZxcSn319Zk=;
 b=FT7AbEhKebofYMnwfuy/B7RztwwGyGMCXJyN9z0fhOfscV8aCupG9WrgkF3TbhYpvSt1T2QI82HB58OaRCoHUr0Pg67W77y0YeCAYaUdKFnL9uqxom9u7BkKKwmhONVti7pna/fhb7fSfn1NJZbhMDfRLm3NIzzN2+BaYcfNqtIKS8QBFc1oh76OQ1dgpJiwx5pUt/8rG/wf9SiiiliJxVwsarhdgkvzzODb4CK7G3o6UZQlfFpU5HcR0LeVPdPhSb6CZet+UGWu4MC2Eqr4aUkuB2asw9LlfmoORUZ7tcuTHpcJ+8hiXbZRtdMwZitNvZuQ4Kmuas9iEmggEEA2Vg==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 21:36:19 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 21:36:12 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Index: AQHWthw4kN7CZJaZ2EupBAhsiadueqnB5geAgAAAlHA=
Date: Tue, 10 Nov 2020 21:36:11 +0000
Message-ID: 
 <SN1PR12MB2480CCF02BF05CEF114235E58BE90@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
 <6e2971889629724071065f7011efab293a4bd546.camel@linuxfoundation.org>
In-Reply-To: 
 <6e2971889629724071065f7011efab293a4bd546.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8dfc1a7-fe1f-49df-e056-08d885c0a552
x-ms-traffictypediagnostic: SN6PR12MB4720:
x-microsoft-antispam-prvs: 
 <SN6PR12MB47208655FB9547B1D262A5208BE90@SN6PR12MB4720.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6IxKIxtZLkZfrKs0F2tIP/AYPWSkFYoQ+Cxt42owoxIgDZeTcNP1pb08O7App5cJ1NR4uacAbf8Y1IiVHDhy2S3GGeR8Zketyn8DcRYgz7FrP7BF3pUYJuX4cMEk+OGkvY8HSHUSNhk/PUOBq3L73uUGgTpfeIPpfHO8fZ7ew330rwf4ZMLOww579YMMpx3/NuVVIISbQPoq3vxucQGMxbdvQK2ufVNw/PiFX5R/KndTzLRfiQNoAZWZOE8vq8hSsKidA+e69Sht9TDXw5N8Hsq6AR3wp5pOW+hHadpSyywIEGLrfy1/19TjC0AXWl4lSeo489VAdans32sFT7AEdUG07uLWTdXqI4ccDfGhB1fbDOQDpKKvj2eXPJUZqR4rjMHmUxoYy0Qd9BxT90JHj87IFXWoysE/F9FkTdtKTEN3r7V0Bn/Hu/Tu82+4WfM5aDKAbi5/8mre0b7KRAqPaA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(29502001)(26005)(186003)(4744005)(8936002)(110136005)(55016002)(478600001)(45080400002)(33656002)(316002)(66946007)(52536014)(966005)(66556008)(7696005)(8676002)(66476007)(5660300002)(6506007)(66446008)(9686003)(2906002)(64756008)(71200400001)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 4VfLsJZa65remc6tZqQcdf8BOTIAMnUFK+824GSI672yXdo5FPDL/Sehv7TA4/N5WRXMcUWZgZ+7CEKr1qGeBxChsyWHhKieP8HTPv9pjTG+VWE03mgD7nJnXsm900FZPgB8Qx4+b7oveawGZbxUyB+NtEDCzdix3S2SzGrUqNShcfE2mfSSJ3/s7PIzJgYFUUJLvup3CtONVm6Uf/DLBTHlovC7dCQX5Wu1UHEbiBgmuu6oOxGXfnCRZDFA44sAUHiYC5+lun8Z5SGLqrdrI6rBnnjrky07AAFYK/mqZ9qSZ+qG27nhEsH206pjrgjqqBAOrfTLrsaaKJSw1KZb1aeU2/Z/gNXeAhqyQuOn6Samr+MmBAUtGQaOBOkThTB7Clw9TTEccdANmTV+CHDn9rQCGkFbBCs+gPaeTHsJevOxCv+DnZXfeQkO6wx0F40NBJ9aOteLXmAQIgwvsYa4boVu7MTFi/ojVCfgr6xT+5p2ATyUjBVHPQKxwaRjom2AVzOgxJFDk6X31BYpL71kjSGCSQ0YeuK3X0OV09403oI0BkwaUiXIOERdErNYExzEgRqNp0z48iGAayj3jrwiq5z45MahQXJbFZAFEbsDHcfoi4BPct6IC5daQI5X2dO6X42mcEIJMYs+YdldiGeY/JdQbtVilAqcXLQDOKW78/x4O2jDMEphAJ/GoIepVj8GUqGrDwRBkWQpkRrnQlVpzRQgAeyC50JvCK9lxognTH7x3ocpWwtXC1LrE3Tq2JlqfxlYuP/Q1norOLwBApRKHIjBUkrf33ChOYc/Qqsut8c0WaPBU2gHN19dsc19Pv/4Vj+YabZ7MeeFjrO56BMxNdQ1bEbEDuPkHMbsYO2h7qGfiik8EMSFoeuRaawN1qMDvzYdrz+W2PWaW4eF+20bfQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dfc1a7-fe1f-49df-e056-08d885c0a552
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 21:36:12.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urmXTY+wCy3R38LON2dNqv4HgnsOBE3PP2IsPQaFUOmvvOZT5cEnOMzg2lQgPi4tnUE7pZMjcwfXNxFaNTtee9CtIJc5HVXV0eZ/I8pQCBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4720
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBVbmZvcnR1bmF0ZWx5IG9lLXNlbGZ0ZXN0IGlzIHN0aWxsIHRocm93aW5nIGEgZmV3IGlzc3Vl
cy4gSW4gcGFydGljdWxhciwgIm9lLQ0KPiBzZWxmdGVzdCAtciB0aW5mb2lsIiBpcyByZWxhdGl2
ZWx5IGZhc3QgYnV0IG90aGVyIHRpbmZvaWwgdXNlcnMgc3VjaCBhcyByZWNpcGUgdG9vbA0KPiBh
bmQgb2UtcGtnZGF0YS11dGlsIGFyZSBmYWlsaW5nLg0KPiANCj4gaHR0cHM6Ly9uYW0xMi5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGYXV0bw0KPiBi
dWlsZGVyLnlvY3RvcHJvamVjdC5vcmclMkZ0eXBob29uJTJGJTIzJTJGYnVpbGRlcnMlMkY4MCUy
RmJ1aWxkcyUyDQo+IEYxNTMzJTJGc3RlcHMlMkY4JTJGbG9ncyUyRnN0ZXAyZCZhbXA7ZGF0YT0w
NCU3QzAxJTdDY2hyaXMubGFwbGENCj4gbnRlJTQwYWdpbGVudC5jb20lN0NmMjZlNWNjNGI3NWI0
YTI3Y2ZjMTA4ZDg4NWMwNDNmNyU3Q2E5YzBiYzA5OA0KPiBiNDY0MjA2OTM1MTJiYTEyZmI0YTVj
MCU3QzAlN0MwJTdDNjM3NDA2NDA4MTAyNjExMDg2JTdDVW5rbm8NCj4gd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMQ0KPiBoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9cHFwSXRra1B1JTJCbnRnTzFsciUyQmlD
TA0KPiBVS0NTcGh1bmlVRkZyY1R0U2p2dGpVJTNEJmFtcDtyZXNlcnZlZD0wDQoNCg0KVG8gYmUg
aG9uZXN0IEkgZm9yZ290IGFib3V0IG9lLXNlbGZ0ZXN0Li4uIEkgd2FzIG9ubHkgcnVubmluZyBi
aXRiYWtlLXNlbGZ0ZXN0LiBJIHdpbGwgcmUtc3BpbiB0aGUgcGF0Y2hlcyBhZnRlciBhbGwgdGVz
dHMgcGFzcy4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==
