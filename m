Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.43])
 by mx.groups.io with SMTP id smtpd.web11.27245.1605717465172796244
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2020 08:37:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=CP80x6+n;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.43, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipRQCPlrPiHJO5FJjpZczfZG1CQeOIfpqORPBRiE17K5vAFfEl1wU5rebn04d23ITi65IMijlvmaMIjZIFmt43mbCw0DLKaUqDlwB0V+5XStGwxPjkC2/YD/b9RMzilwshllmDXRRmWYvXTbNVHH1NtsN+BOysNCS06AHv3VPYVx7R1mjxx7dNQnQf5hTA+KpzeG9VXpwLWL0Y4o+JGJjZLYvRXJx21bohHGpBzVS3QXavdDtBRmUxOqFcUTtYNGWcRkZJnFLdBeh16yDbonWx99nVYWl+O3pOa9iMv4Hu/eqO7VqVNIExnKRLm20CsU8UZZh24wQxtc5A0so8RKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUWqMJNoc4pPhsz1MxQ0QGJuEwRONbkr5Y+8/9HB/M0=;
 b=J+3+/K+1VuHhazO2z6btlu4P5d23ybO2cp/RhR2nTnVNWvkbm4/5VXncbKZfq8VFiEHZqiXlqIBonPr2zOPs/+21CZSfgljC1SsdSUMuuL2+qpm44lMy+W8fqOlEDKVGYLQdOOIa0dJ2ojSAYMKO8Gm4z0aDnNgdIS+OXn1JDVefVEkFlxut/9hasOWuizLiW38fHwcbgBQLTcMcp0VQAy+jyhtuQpVK1r/pJfgwybm69H8YRyXdMb2/3Yt/zo6ClUo6rTvMRvO2/5pswUICx/rVThTjcZ1EpRU4ksrSylQpsKPwIxZsEksM4z70DzhrnKvzzzrJk4Oxa7K8hZgZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUWqMJNoc4pPhsz1MxQ0QGJuEwRONbkr5Y+8/9HB/M0=;
 b=CP80x6+nEYq4blYFrLqqpkpyuC9izpLI5NunVMFyUdNotkMa+KxQvGEOSD2DZUOaXQ3F2L+Tc1X9T1slBa1WIH7WNyHU8Jcwuxt7kYHsVR/nBC+wunEcoBh14yq0vMKx/Cz8we/KjMySOUTYdc6vwvpwYnaMq9zwJvUByGiXW7WMKUVkqbqti1Fk50K/VOxDCaHbmXM0cksI2ure6cU5ux/EhmPTn9+De1EGdNR0JiWMuv/3Ikg/JsUM/B7ecxdwxARYmOheZQ+iGC/NJ03V2fzbMl7ZoqbtQYHyKzsZ+0aKbOzHGyrBG4OAOYeB9EvK6sME6c4uQd0fRtNqreyJZQ==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 16:37:44 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3589.022; Wed, 18 Nov 2020
 16:37:44 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Topic: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
Thread-Index: AQHWthw4kN7CZJaZ2EupBAhsiadueqnB540AgAw8oTA=
Date: Wed, 18 Nov 2020 16:37:43 +0000
Message-ID: 
 <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
In-Reply-To: 
 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63c14e66-a06e-4f09-da55-08d88be04644
x-ms-traffictypediagnostic: SA0PR12MB4541:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4541341E3798219215F743C98BE10@SA0PR12MB4541.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AIQ39OaSUejqaay5+LIF8Rr0biHpbu2CDX51tI4H9VZ0rmshRxeZ2w8P2cOzM/OfCM6NM6aIvzkDM8Cmxy6wYAWmt6w8K6ryp+WTXHgZGj0nQUjZtrv2V8h7aPLp94s9OUxAOT+Y+CU98GcYmhqADaiyzFCvEKjrPNIcjpcsuYmFho1/drx6cpWJzUY7T2PY/xG/5cWiwexPJ0AnYwjiP2TvPN6ynOa7ztSJ1zqg95qPMNx5uxgcFlsKbhVWSnT0A97AUkyvkdd7ls/D0FKO+YxXSHCZ6LIwjfPGzwfWOZIka1jdl6LR7YrBStWJQ4aQ7bZfukDB1QZm1SGAt/VOcXvKqXRCRGAOLlofC6UBjosDpW9rQZevouj9PxpCfpqM
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(29502001)(76116006)(316002)(4326008)(7696005)(66946007)(66446008)(478600001)(83380400001)(64756008)(66476007)(66556008)(33656002)(6506007)(86362001)(5660300002)(71200400001)(9686003)(8936002)(52536014)(2906002)(26005)(6916009)(55016002)(186003)(4744005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 IV3YdXSINIvsmNtZ21X375Q9bPfE2iZmoJcCvmkcMFWjSbDLOe0HfxncZUjCyifs718i59s8zcYnoc4JUE3fz/I7qjBPT1omZ2z/s7EUrEp9/MH4GANDeq/qL7Rmp+b3SKC9E2f5/jo4fC0uLy0mk1KKHjBjZEl5UMqkeSsB+PG9dXcY6oJ0bCPtBKKb9hlpp+KiYGDNSDasLAoCFr0kZKgc9F6QgHSh7VceKonp3NUBXt5xCMhtBGDb0icxQczS0OGLLvdszZoWsUe/gLYb4ecydzQwSC0sRbKZZEzGBMfbpreAgwc2G0S1cQtmOvn5H+9iW4OFsSh6eeVl9xwnyMVmLo9olbXhouAcYfzWD4Ax2YCY9PHxWI4lpKtm/wMoh+2PWUUCKy+CcMcoOSOMRM8qW1rewL/CRDpTE7YowfAKopqqH3bdhwelT6Nv4JnwFqisA0W8GO4aqaXiJzg1Td7H8L8C52pTc8w688imJgCL0xUbV645VwVHbZvX/OuAeYlYwisAGQcJaRAI9nsKUiP9v7qg7LZB6v8pWM8fnF98WDqh0m7+2pqAk1QMhcbqIlqlhCZ64uQ+b9N2Ova4ZkdEZM+f9L6Z10nTJn3srYyQgOrtdf+V6nui+Z9gZ9M0Yi5HIBITANOXBuS26wP0tAjHxfHK0RnUcIzsUNm/CpxYppBb1TzDVt8/IdNBbWz8bRFPOsJPwXs/G8pJkTd42w4XurVVmtwJXmWchAoe+0/ld6kApblzRNWqNmPNsWc8+DmxqY/6J7o6BW3vggTbvbMk3Mo6OVFZqfkR/J9nk6Z+jY78xNJ/mYlfs5hFUyN0Z0QoaMEkxfpkqH2jTzLfCD/Gct6tPkx9q+UaQf1QODUjAphn9h9mDW7k+7ryE+iz6OC0wCrq5a5x3+3P+rb/Xg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c14e66-a06e-4f09-da55-08d88be04644
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 16:37:43.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54864f+xjhXpB7XauhNvDftdrNoBauRpwYnaKufFQi54vJFnLgz2kBOefJqBwc41AiGlInCUxMjch3pkerhBA/xwGhCfDcpHUuQnu4bCPlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUmljaGFyZCwNCg0KPiBPbmUgb3RoZXIgdGhpbmcgd2hpY2ggd291bGQgcmVhbGx5IGhlbHAg
bWUgaXMgaWYgeW91IGNvdWxkIGVpdGhlciBmaXggeW91cg0KPiBTTVRQIHNlcnZlciBzZXR1cCBz
byB0aGUgbGlzdCBpc24ndCBhcyB1bmhhcHB5IGFuZCB0aGVyZWZvcmUgZG9lc24ndCBwcmVzZW50
DQo+IHlvdSBhcyAiQ2hyaXMgTGFwbGFudGUgdmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPA0K
PiBjaHJpcy5sYXBsYW50ZT1hZ2lsZW50LmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiIsIG9y
IGFkZCBGcm9tOiBsaW5lcyB0bw0KPiB0aGUgc3RhcnQgb2YgdGhlIHBhdGNoZXMgc28gdGhlIGF1
dGhvciBpcyBzZXQgY29ycmVjdGx5LCBvciBDQzogbWUgZGlyZWN0bHkgb24NCj4gdGhlIHBhdGNo
ZXMgc28gSSBnZXQgYSBjb3B5IHdoaWNoIGhhc24ndCBoaXQgdGhlIG1haWxpbmcgbGlzdCBhbmQg
YmVlbg0KPiBtYW5nbGVkLg0KPiANCj4gSSd2ZSBiZWVuIGZpeGluZyB0aGVzZSB1cCBtYW51YWxs
eSBidXQgaXRzIGdldHRpbmcgYSBiaXQgd2VhcmluZyBnaXZlbiB0aGUNCj4gbnVtYmVyIHlvdSd2
ZSBzZW50LiBJIGd1ZXNzIHRoZSBhbHRlcm5hdGl2ZSBpcyBJIGltcHJvdmUgbXkgc2NyaXB0aW5n
IHdoaWNoDQo+IG1heSBiZSB0aGUgb3RoZXIgb3B0aW9ucywgaXRzIGtpbmQgb2YgaW5ldml0YWJs
ZS4NCg0KQ2FuIHlvdSBwbGVhc2UgdGVsbCBtZSBzcGVjaWZpY2FsbHkgaG93IHRoZSBwYXRjaGVz
IEknbSBzZW5kaW5nIGFyZSBnZXR0aW5nIG1hbmdsZWQ/IEknbSBoYXZpbmcgdHJvdWJsZSBmaW5k
aW5nIGluZm9ybWF0aW9uIG9ubGluZSBhYm91dCBob3cgSSBtYXkgZml4IHRoaXMuDQoNCkkgYWxz
byBjYW4ndCBmaW5kIGFuIGF1dG9tYXRlZCB3YXkgb2YgYWRkaW5nICdGcm9tOiAnIGxpbmVzIHRv
IHRoZSBlbWFpbHMgcHJvZHVjZWQgYnkgZ2l0IHNlbmQtZW1haWwuIA0KDQpUaGFua3MsDQpDaHJp
cw0K
