Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.73])
 by mx.groups.io with SMTP id smtpd.web12.10701.1596912049855206597
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Aug 2020 11:40:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=DqpleWPD;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.73, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFS3XClGtrOYpOuN2269d5MqX2CGxorUjQOZdsRybx2+vxWowLVC+7BFMScj5n7+ZvRJo62pFfYVb0c5rJQAbyPRYTNs+73/G3URrxfWtmyW9glA18Dpv68kjXZgEn8KXtzrYa2pH/JtAwNAEXs2i2DQ7qNomMQYvnwrXrx1VV3a3LbDEMjEG5XDw6j+Y3GwJjjM7RKZZfU7I7wYQC2UEKS1k5dXPF7sNI4Rr1LC3beJLjQMYhmxCAuJyP5MkZ5EiBpWnmnI0n00sOY5A+UNi44ai09MChBeH0dOPAvW87rwZG5abXSoonzI+DGRY7T/tKvArTuRp9cuV+2xbx+f5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zmBtZaw7pp3gsVfTApjvgtDksNWH0kwv5fnHO3Y4a4=;
 b=HlqERIYh/g2kmME6r9ggk9mjq1KIQnDtx97M1B0eEe4XAcmdZ8v45aaioTtRLAFKEtgwpgL+Aqe+Thtwa+z2GOEO5cQhvevrFvUqEC7XA9BrQH/WSvjjwA+IyQgKdQFXxMlduZuKdOqVlIGezwV3Qafkj19UvLok09rsC9p92O5Ur28jYG+c9BuifGSRXlgh9Sa0JkvQAm6C8Ql/YyFn4INpqDmo/RVXWp1f3BCM34p4KWQ0PieEiH9I8XE5zqcuG4R367Nfjm2OyJ2JRwmWQBUviKyYDUStw+VKgUkjlZkBGMz0su7i8R6+zWW0rlKBrckLEbbreqVlnbVdD3vqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zmBtZaw7pp3gsVfTApjvgtDksNWH0kwv5fnHO3Y4a4=;
 b=DqpleWPDLNciGvxwwDSCPy1t8kBwjQQwHR9N0mrcIFGfrvFEO41H4mamrphTCgmpGRFjlT43fTrnaC0017MDFuYF+f9QK/zG0WMfo+i1fvpJ3SoyPa1tCEyALejsDqQr8U4h9b0KfPgdWqQ1qIcoFJ6eKtOOVcc92gg5vC3x1oQee1fktiaHq+U8RZ7h8GQPGZ5pF5ex5ugjUWY3BTLukXw6h07sDeCoIvXvMJb6/VimXXn+b9wR2QYmUC0ny0sWqU4L03wModDhiTBNUE/SwYdsT3QWbGgzXr0csQoF4D76274S2AQeOAWyUPYTVqoT5wb0eOdCOrceZW84sQIYYg==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Sat, 8 Aug
 2020 18:40:48 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 18:40:48 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Topic: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Index: 
 AQHWaNouv1V2TYM56Eqj6fr3Jx/DCaktJiUAgAAKPxCAAAB/gIAAMCwwgABtWoCAAMVwoA==
Date: Sat, 8 Aug 2020 18:40:47 +0000
Message-ID: 
 <SN1PR12MB24803805C0F12CF4F833C8838B460@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
	 <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
	 <SN1PR12MB248071CBED17813537857DC48B490@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <31be36c0a9c86f735e8dbc56053a011fde0c0bee.camel@linuxfoundation.org>
	 <MW2PR12MB2474D07083D73046771266858B460@MW2PR12MB2474.namprd12.prod.outlook.com>
 <dcc49121d8f04e3886533ff31a61185657cbd2e1.camel@linuxfoundation.org>
In-Reply-To: 
 <dcc49121d8f04e3886533ff31a61185657cbd2e1.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [69.2.185.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71b822db-4ac9-42fb-5a98-08d83bca9166
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-microsoft-antispam-prvs: 
 <SN6PR12MB2815CDDE90709FC187A528C68B460@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YzZYkcqx1eFr/ykO8LVrEVRcXLi4lfxmBxEJefJ3ug8ANbIHkzCruDAKm9a0ajnkPcecajN1Lz2gH7Bmh4QPI02RPF3D6dcNF5UC/J7tRknsZPq4+xzFjQWqCFcphKuaqm0C3Ji6wksQRnj7C76aowwj0O3d9KLBzw/0jRkhLLqVKA5OnFzGluhot5FTxXaIuqWVxuAqfY/snjBNYUIgAlLapSZP17VPJipSHyk5bqc/IUCEzVxnJj2Lgw7gXDUJsqz5kdeiPK8jxGI8tiTJZqRLpZPsW1DqmTkaQ9+ijORa801oN6Mb7wqox8Q9HxvddzqiS72KM1Ilf35Bh3WI6pkLgh+ev5w2/W8l+xQN6/p1kCnhoIR1tUsikuY2oqxV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(29502001)(5660300002)(52536014)(186003)(6506007)(478600001)(7696005)(26005)(66556008)(55016002)(66946007)(9686003)(76116006)(4744005)(66476007)(66446008)(64756008)(2906002)(86362001)(71200400001)(110136005)(316002)(33656002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 fP83Y3oBmZJcrCakTHp3FLImnTLxiFaRg+k+6xj+Z854xlYibmPpuZcFtFRNTR5txe6H7DCITxkmU8WIGKJ982cHp9N8M+Jld0RGQAeUxmSZMVlXssRyLeYDINAelRKYO0h7aNt9awhQKxtv51Tw7fhMbFd11hwv1Ca3ZJOJue1U5YClB1dGWySZ2Q+zVIPex5FJeKGcsN5DRHVDp4k9iXY5lXewtWqkbH3cjd74plAS2CdXVp/UNVg83Q8IdZtKuP6ssVG8DeR/lohkT3bvwwi1qGuUrFAqOA+qX77hJ0F0NyIeWHGxO1X64MtkQZZzbyOjac1sKhzz5afRiImuCJDpUfuCbhe27JntXK438HfXySDovtF6w9I9qbQSaMtb41V0adsmlgkRRz6ga20zpE47asn5qdgXuroIxnzS3MuVj0mlcbFRxBLhNe0gOLJ2iZPGIcURlum4KGz2lMiEdizx3lRI8/6rmo0P1ObqyD3guP+v+jJ+yJaUcKd7f7xfKdDBWBYiBbaw9bLiQkxBP8pQtiuaUEcE+xHdeHeyeepdtVXa0u1sEaabotkxUP2LXkqvWQpb37vvaDaOvCgGpnNJYCdR9U+AhJXnVVKJYmTp5WRGAnidI208aYtp+QWZS+kigB2q9bgwRSlA3myQeg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b822db-4ac9-42fb-5a98-08d83bca9166
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 18:40:47.9923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xMKNBEGIvZRN4FmEfQDXdz5D3zw/imxOBmERapTzjqLz8QcKGhvIuWhxaFIMRaopkg9dBBvqJkX8u0grfVyUDT0oa9rkd6ShUWtwaNR6t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBUaGF0IHdvcmtlciBoYXMgZGFzaDoNCj4gDQo+IHJwdXJkaWVAZGViaWFuMTAtdHktMTp+JCBs
cyAtbGEgL2Jpbi9zaA0KPiBscnd4cnd4cnd4IDEgcm9vdCByb290IDQgSnVsIDEwICAyMDE5IC9i
aW4vc2ggLT4gZGFzaA0KDQpPSy4gRXZlbiB0aG91Z2ggZGFzaCBpc24ndCBleGVjdXRpbmcgdGhl
IGJhc2ggcGFydCBvZiB0aGUgY29kZSwgaXQgaXMgc3RpbGwgY2hva2luZyBvbiB0aGUgc3ludGF4
LiBJJ2xsIGhhdmUgdG8gY2hhbmdlIHRoZSAnZm9yJyBsb29wIHN5bnRheCB0byBiZSBQT1NJWC1j
b21wbGlhbnQuDQoNCk9mIGNvdXJzZSwgZGFzaCBhbmQgdmFuaWxsYSBzaCBsYWNrIHByZXR0eSBt
dWNoIGV2ZXJ5IHBpZWNlIG9mIGZ1bmN0aW9uYWxpdHkgSSBuZWVkIHRvIGltcGxlbWVudCB0aGUg
YmFja3RyYWNpbmcuIFNvIG9uY2UgSSBmaXggdGhlIHN5bnRheCwgeW91IHN0aWxsIHdvbid0IGFj
dHVhbGx5IGdldCBhbnkgaW50ZXJlc3Rpbmcgb3V0cHV0IGJ5IHVzaW5nIHRoZSBhdXRvYnVpbGRl
ciB0byB0ZXN0IHRoZSBwYXRjaGVzLg0KDQpUaGFua3MsDQpDaHJpcw0K
