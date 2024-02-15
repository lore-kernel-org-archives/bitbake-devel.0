Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D130C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 17:25:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.78])
 by mx.groups.io with SMTP id smtpd.web11.20122.1708017940142704870
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 09:25:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=CWDn1EjF;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.78, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jsg4LGNKt0q5Lf59D4u89NDlEwVD1kmPtbSY33iGgtd8ZFaqWy8YNr2BJ7OcZD97mPHwpdkhWYp/NFYmBh/SjPRMqjQ8pv2aFDqcwraSKY3JV1tscsZTZI2KhwiWVrpcle3yoTk8ajuTac0Ksg7PBMzJDOklpeRbSCK2wwLv9YEKEi5YWiQVCSoujX/BmwyzHmcMF8O2rjUOZP/estpGEoDVBw/EbH7pp0yASLnDza+9hPMccFTTxNYR7g+NIqX2RRxKgnhYxe4Or3QPj58CFng6rc7KB/2nYU977iiN2BwFvtQQEdu8WzVP6q/z5Ty7k7lqXHU2sDkfMyXU7O8sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=motf0THocyudquoyYCSUoI4Omg/70DJU/H2JHT0MiqQ=;
 b=k4+Y5yNn1RKJYYM9t0xGnvjcPzffLmOcImAAwLfxhimlFqxc7pLXgxV6ppnWwpMn1L3Dm3NDSsYuiNZJt9M9H21hjfPcxmKBSMl40x4j7xPd+737UzP9uIzWo+YkCZwHD9gll8+pxLtLeCQblHu8y+MbfEKW43cVTjnRGhbuC4SMnZyJOxsGd+nmo6D5n3HExpas8BQ7Ip//9+NNgrV1zFe9FfZgRK6auFxxC/kn39S15xHh/o94r83ekF7YT8TcnPTYBIPKItA1CjCWH97JPBPqkxYONUsQ5f5y0oofPdILhV7iufEjZ0/PGc0al9p/kS0UQ2Q0bAWColP2CGDc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=motf0THocyudquoyYCSUoI4Omg/70DJU/H2JHT0MiqQ=;
 b=CWDn1EjFTvyJU3BzNQzDhFvTZ77mSxjUU7pr/+su+wa9dtWt2TmvUO5eomP8i/CK8F9sEfHD1TY1iGyfxquJG4L5hEVfaCQRuqbvhTlckoq8JKL5l7flOeICGhG/ueScxwtM5jeSPoMvVCHDAIcMfH/6X/W3aExaVMT74CwJGR7D1ABwl66pQ9nPeotEwmSgfBbvuWq175yz6lYLhKbcIKOhBK2u57LMh1yEMpLm9/BcoFd1GOGmHg/xUg1vlNfnAcUQXvslSpnRMnuA5yOZFsgwXtiPbkNK++kkWFpf4QlK0R/v1naQ1uHj9x/14CYuviqvdDW/UsGNuH3RiNjb9g==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Thu, 15 Feb 2024 17:25:37 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 17:25:35 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "behanw@converseincode.com" <behanw@converseincode.com>
Subject: RE: [bitbake-devel] Online tool for playing with variable expansion -
 first steps and where to host it
Thread-Topic: [bitbake-devel] Online tool for playing with variable expansion
 - first steps and where to host it
Thread-Index: AdpfZydm5aBLa/+zQN6kD8lbigwWlgAu00QAAAAV4sAABDt8AAAACVTQ
Date: Thu, 15 Feb 2024 17:25:35 +0000
Message-ID: 
 <DM8PR12MB5430C2D2BAC610486096C7F48B4D2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <4ab357d878fad09b44149179e532608a1c329e81.camel@linuxfoundation.org>
	 <DM8PR12MB5430121AAE8FABC5D834CF8F8B4D2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <7ea7dc754fda197b9f911bb287b1398114dfc0c1.camel@linuxfoundation.org>
In-Reply-To: 
 <7ea7dc754fda197b9f911bb287b1398114dfc0c1.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=5ffbde2f-efed-46d6-8fca-b60f1cf2a9a5;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-02-15T17:24:46Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS0PR12MB8272:EE_
x-ms-office365-filtering-correlation-id: 1abcba97-2160-40ec-6700-08dc2e4b1ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1dkUN5aMh9IpjkFjaHePAO47x8rDK/87CzXTVA+A+wPmfKe7popIM9VYLQNyHy55WSqNn/pwU52IadpNhMKvjbMYA7SPc9ctHWzl1Y+Ao3H5VwhEzphVKBkIvjlz1NbEAMhC3O/o7UNbvJy5YAI9BgYozpRmvIgXTHZfHY3rARKcN6xdUgJMdWY5j72T+/cA7dPFpMd/qi+xBHHbNJlLIA5ZwJ7IkEw4cixX1o4PyUZOaqa/A4fjw89l3l9ejJM8qOBEBGI9WGZQbxQbgNB8vwC78WvFd3HGJnDwYm06XI6HeYaMIwJWRzupqOo/nQStdfCTjNIA1/hcP/kIIjkhqBPGDMQ25ucTqp8oLETY7AL09FBuRv+673NqweMre2GKNp0y+IW7IaUexDuBa8j68bmWqo9RSD6kOo1+iliAJwTUtZz9gm6RGmhznX+QK8Q4MbeAJN90wUdJX415AeNG7j7QbAWK70Jh7Euc90oLNmodZ4pHzLYF1u+/dZxzwtVysVZVxKx05EnhMv90ZU1eFG6xd2f8hZzh/PuNpY91/xAs+nqWnxFam7ZIhqu72U8ofzEm2+hClw+0bKQ8tJw8DoSc184pWsF6D+wxHXfLjge3Ros5by2LOZMc+ALDa/O+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(9686003)(478600001)(41300700001)(71200400001)(55016003)(4326008)(38070700009)(8676002)(8936002)(52536014)(5660300002)(2906002)(4744005)(76116006)(66476007)(110136005)(316002)(64756008)(7696005)(66446008)(86362001)(66946007)(66556008)(26005)(38100700002)(6506007)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UUdUZFZIQi81eUwyUVhENWdFMGNiNkVLSzVvUzI2dmRaRnhBamtlbWdMSUhy?=
 =?utf-8?B?SFB5eGwwMHZoVitzR29aQklCWEtaZE1WaDAvaTBVdDNnTE1qcTFJY2lpMnZk?=
 =?utf-8?B?RStBVWlvdW83QTA0Zk5jWkxwcWZFaWVYZnRlOGo0dnUwVjJYU0g5clhHV1Er?=
 =?utf-8?B?TkREL3JEVTVPTDRGNHVmNmYrMU9xZkkvMHFxaEQyYXFic21qZDgzNjNlY21y?=
 =?utf-8?B?ZEFnZ2JGTFV4MTFBekpzY2VvYkxSQkVTakNTWVlOdzE4ekVaMXJuZnN1K3pX?=
 =?utf-8?B?MDRPTHpZVzl2M3RyUDNNc3VjMXE2TG5pTHN5NEpocWtPQUp3YjBYQWN6ZVFX?=
 =?utf-8?B?WjhlZXRvbmc4bno2VFBaOXZnWGFRaE5MQ3IrOVNwOUdjTnE1amhvWkhtWWNZ?=
 =?utf-8?B?UFppcGQ1WVRkbWJuZnJYYTJGeFdjRk5tMThVVXhKam9HaEZHREhOb1h1L1d6?=
 =?utf-8?B?eXBFQmFwSFJTOWJ2RVFOZnRpbXlpbTBFQXpHdHBJbWxDTEs2WXFnK011TGZl?=
 =?utf-8?B?ZE84Y1NQSUR4WkgyR0dIYU5yRld1eHVkMjdjTlFFdEtJU25PQXBXSTcrUm5C?=
 =?utf-8?B?U2pnV3FWeDZvbG9qcjFnZUdwRnpRSDJGa05kSXNNSm5MRmtYMW1mVFdMajVS?=
 =?utf-8?B?OHhGZFU2NGJFdHpza0kvM2E1eGNpYzQyQ3JzY0FDcitxUExCbkZYQUFlNGdM?=
 =?utf-8?B?N0RNSnFhMWdsQ2tDMVVFQWZEUkxhd08yaVk4WGYxTVVpR2VjTXJHRkthVS9R?=
 =?utf-8?B?dnY0OGF1NHpuYmhyb3YwbktzajM3QUFpZnQ0N0pQMFF2amY0VjJZb2FDSUtt?=
 =?utf-8?B?Z1JUSHByTllWeUJEU1JRQXpFOTNmWGhnQXVjMkozMXRCUXNIaXFJSHRPaUJj?=
 =?utf-8?B?aE1VdGVhbzlqdjhzc21HUXZPc2h5dFl3Q2d4RzUxSVdTVzQrK0k2MVdoemNT?=
 =?utf-8?B?L0JYM2ZxK3kyeUtuaXBCRDQyWlVWM3NqU09QbTVlbThMVzM2cS9oS0ZhYk1q?=
 =?utf-8?B?RGJZY1hncWFrNHVhbFZVc1A1K1VaMmtvQUxFY2FiYU5XY0hVSWFUT0xXR1hM?=
 =?utf-8?B?VlFiZFpVRmgzanV1cUNqOE92NXBsMm1UbkJINWxpMU5RU3c3NzRSTi9rNXI4?=
 =?utf-8?B?YmFnc29HREtiZWpscm40NUNNQlIrOGdnRVpxUGsxcFFGelU0UEVMTnZab0E3?=
 =?utf-8?B?L3BobGNRdnI5RDgwUzZDU2ZBWmhYNzYwc2tVRUkyeTdtWlRQNXh6MjNUaHZ5?=
 =?utf-8?B?Uk94OW1JajI1b09uVElyZFNZem9oN0hZeUF3NHpjRnk4TUdkaHRTY2NrWFpP?=
 =?utf-8?B?bEo2Smw5TkppNGdrK1ZVU0kvV0tKR2lPdUlMd3NyS2djWWhHSlJKa1J2bHBt?=
 =?utf-8?B?NzJON2pIQ2pPZ3lSVDB6bTZFOTM3djAzZElOOEg3N0tVWkloWG5lM1VqSCtZ?=
 =?utf-8?B?bjgvUVhpbEhNZGFKVUx6SVFOSUM0ZnRwOTM2cmRFckVZVTJxV1hRS0loa0dn?=
 =?utf-8?B?cTRjQUZ0ZEdlNW5aVkFoODRpKzFkZ1p4NTdkNXF0QnFsZnpjb01CRmMwSzhF?=
 =?utf-8?B?WGYzemIwU3dQZ1pzNDN4TExlSWdwbjNSenRFQUtNeGtucUJ1emhwVmxXcjdp?=
 =?utf-8?B?L3V6YzN3eGk1MXpRZ3F3dmlvNVBBZHdDdUd3UVhweHZwU1dMVlVVMjlDcmlQ?=
 =?utf-8?B?TDNQaE45Z3lXV283aFZZdFdtZ0ZtS2dOckk3a2ZDdmtaZytLeXhtMFR2ZUJ5?=
 =?utf-8?B?d3A4S0lNMnNtZWdtdGFhV24yTHJhaG45WlE0OXZYY0RhcUNoUDJwL2RxTW5U?=
 =?utf-8?B?QVRPczczYndXNWFHN3ltQnIycDUxNzNXQWNvL3k3NzhWTlNMN3Q5Qi80NzEr?=
 =?utf-8?B?WFJsSnhoL3ZwTEdwUkFzaFpMM0F6UVNBT3BXYXA1TnBCVUR5SkdFOExsdDU2?=
 =?utf-8?B?dXA0NEljNnFKZlpSNC9aVTh5dXNoN1FiR21uUGZ4ODFiRGcrejVOYWdmbFQ1?=
 =?utf-8?B?ajVYK25ZWHgvdzNGamQwLzg0U1Q2UjVLdllQMnI1SzZBY2RWeWJRY0xva2h6?=
 =?utf-8?B?Z09FVENWU0QxVzFQSm03MGZ2c0E3VXBzRUVFQThvMG1nWDJCcVJMN0c0a0Vl?=
 =?utf-8?Q?iKRFCTCKpEeQNH/jqb0dOnjFx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abcba97-2160-40ec-6700-08dc2e4b1ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 17:25:35.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWBL4MDhyobdIstREnywo3cX4Urn5XOObdTil3cDSflzBv7Jwy8+YpwIky/k22kIryvJAAGP6NhLIKQHDWc9nmzXnv0CyQpkFdc2f8lSFPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 17:25:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15898

PiA+IEkgYWxzbyBkb24ndCBoYXZlIGEgc3Ryb25nIHByZWZlcmVuY2UuIEkgZW52aXNpb24gZXZl
bnR1YWxseSBJJ2xsIGFkZA0KPiA+IGxpdHRsZSAiUnVuIiBsaW5rcyBpbiB0aGUgQml0QmFrZSBt
YW51YWwgbmV4dCB0byBjb2RlIHNhbXBsZXMsDQo+ID4gZXNwZWNpYWxseSBpbiB0aGUgY2hhcHRl
ciBvbiB2YXJpYWJsZSBvdmVycmlkZXMsIHdoaWNoIHdpbGwgdGFrZSB0aGUNCj4gPiByZWFkZXIg
ZGlyZWN0bHkgdG8gdGhlIHBsYXlncm91bmQuIFNvIEkgdGhpbmsgbm8gbWF0dGVyIHdoZXJlIHdl
IGhvc3QgaXQsDQo+IHBlb3BsZSB3aWxsIGV2ZW50dWFsbHkgZmluZCBpdC4NCj4gDQo+IFRoYXQg
ZG9lcyBwb3RlbnRpYWxseSBjaGFuZ2UgdGhpbmdzIGEgbGl0dGxlIGFzIGlmIHdlIHdhbnQgdG8g
bWFrZSBsaW5rcyBmcm9tIHRoZQ0KPiBvZmZpY2lhbCBwcm9qZWN0IGRvY3MsIHB1dHRpbmcgaXQg
c29tZXdoZXJlIHdpdGggb3VyIG90aGVyIHByb2plY3QgcmVwb3MgZG9lcw0KPiBzdGFydCB0byBt
YWtlIHNpZ2h0bHkgbW9yZSBzZW5zZS4NCj4gDQo+IEkgc2F5IHRoYXQgYXMgcGVvcGxlIGRvIG1v
dmUgb24gYW5kIGRvIG90aGVyIHRoaW5ncyBhbmQgd2UnZCBoYXZlIG5vIHdheSB0bw0KPiByZWNv
dmVyIG90aGVyIHRoYW4gY2hhbmdpbmcgdGhlIGxpbmtzIGluIHRoYXQgY2FzZSwgd2hpY2ggd2Ug
Y2FuIG9ubHkgZG8gd2l0aA0KPiB0aGUgbmV3ZXIgdmVyc2lvbnMsIG5vdCByZXRyb3NwZWN0aXZl
bHkuDQoNCldvcmtzIGZvciBtZS4gV2hvIGRvIEkgdGFsayB0byBhYm91dCBnZXR0aW5nIGEgcmVw
byBzZXQgdXAgb24gWW9jdG8ncyBHaXRIdWIgKG9yIHdoZXJldmVyKT8NCg0KVGhhbmtzLA0KQ2hy
aXMNCg==

