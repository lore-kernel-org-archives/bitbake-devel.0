Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.78])
 by mx.groups.io with SMTP id smtpd.web11.6135.1596835461029238296
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Aug 2020 14:24:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ONfMJ81F;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.76.78, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDSIcSMFvmxqOqRaLRupPjxVtHViXTnX5/lYlo0nkKkLqqvr5Bmjrp7o/NWT2/m4FqKsRam0n2Y3p3PjXISmPMXHUNVWiqsVCfuIHOwS5BP7UW5OxZW1wQuhamXIMRo4jL5lUD6WTVQFJ7tv00SWBMgRiNMflr/QqPTHqZiWXLvctfPUt2zh1mDB7QkVoQNjZPBJySg4rMQG5ian6O7iqdTzR8YoTQalbY4f/YxagyiL48ZmFshcMsmMoLXO+WVIZMcPmbPxrX07mmjO0PTAl5PQGDGB0J4Z+rHTbHnE/N/0BLFTwM8ab6D6F7MYggaAsD0ApSK1M0rpKiv6bK30Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prDtz5QYl1f/tGo915Y4yXZAUnUVn7HSBY9XhpIALFA=;
 b=EyXTk41regDJIxrD+ozJezu+kOWUhH+963M9WdhCvxXQ9+lOgsVzwosUXnmmAytHphQ2kkuANU2vTobzp2VWthhvXdMjL0HlxDBWtZzZJCILAQBDH746X+OhHUHs6raoUEzqKCzFspZ6p2vwuVdsgd5xenaLP9tzp+WhMnDOY9UcKGV6Tpjzbb3nfMdC/fLob5C2k7qrw2B31IDpV1vn9xpemhM3XV4qENIu0Q8KC3Ulo2RqnB0qCFhAuKLjZK+DiKoxwaNGd7kA6xxAD66rMytV6ryBaichKIM9X8zeggufcBKUuCgW/QGyEysF5opiWoo2Kk3r0bvBOK386GupmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prDtz5QYl1f/tGo915Y4yXZAUnUVn7HSBY9XhpIALFA=;
 b=ONfMJ81FPMlx667dkZ48dNbi6bAWV8+EEd9e2kdRRYJMqPGMBsW6zJbpYtHqgxdzQNEJzZxruFvqpsTZxukVvYjEebvEJxu/Na/qHhbNV5P6vxg8JtTSRRCk/AXuItt5ip9hjssz0WXgP7Azrq/D5tuk3Hh0mBmKg8Fdh1zt5tHgGjW6gMXdI3dJQ3kmh1nmUyDnS8ReNvYDoWzB7JmDDjkaOdC6LKMovul63mHw6G80cnqeBtAu5tMn8FUZ4viDgoUJ0CkJE0tXiqjDQwJrlbjBTBXNHI3Xociw9yWVpiay6lJVMT9/4WQKqgS1ArIer2vEQ4fs0sylOwSQGMSUrw==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 7 Aug
 2020 21:24:19 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 21:24:19 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Topic: [bitbake-devel] [PATCH v2 0/4] [RFC] Shell func backtracing
Thread-Index: AQHWaNouv1V2TYM56Eqj6fr3Jx/DCaktJiUAgAAKPxA=
Date: Fri, 7 Aug 2020 21:24:19 +0000
Message-ID: 
 <SN1PR12MB248071CBED17813537857DC48B490@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
 <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
In-Reply-To: 
 <db9d507a16a5cc57634642dc2245df1a05eab447.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e700c095-9f83-45c6-3d98-08d83b183f08
x-ms-traffictypediagnostic: SA0PR12MB4462:
x-microsoft-antispam-prvs: 
 <SA0PR12MB4462860FAD6C5D68D03E7B7C8B490@SA0PR12MB4462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ki7WKUdUq1mWURA5J4TXb4Hwmr1OATt6zZrz/3acWPINuJLmlfM309g/91ElkcDFdpjgnmHB6LAQKl04uNRj7EryE6r4y2+brlJ0yQLGqDsPd3K+DEqU+IEZCm1hJE+Eys6C/XOpcGkGudRbao0kIlgGqlGf53JRUj1DdOpuqvfsJ+YC9r+isg3DBfcOHCJomJzBccLY7iwIw3itetYKAszE4gQOM0KfXT0Cfi9bhkVtv2heYmUFP01GXGbUdij7XIT1FyXyynGxU4OwIISpeY543BSN5HSWzooDtGLG59WPB+1eHh0CpJP0vMX3WTF+x+hJHblFrm3cfBm5bdHz0zmK7Nn4MpiNxrthKIjo1yrFl95hrRIjoDEJOiaHJE0HBB78TpDLEURuW5QkLNJyDljetGsEKUFwa162uXH9H+FOPCbY+zOz/40IdLAzCQYKijVCzNZ5QTydeoay6ccMUJzGb95ZY2rP8V/0LvB7zvs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(29502001)(7696005)(6506007)(110136005)(316002)(71200400001)(4744005)(186003)(26005)(478600001)(8676002)(9686003)(86362001)(33656002)(2906002)(8936002)(966005)(5660300002)(52536014)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(55016002)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 3hVp2i/fiPPJb9d0aBd7FBrtVVAiM1V9h/58BUzJNzDpnOTter8rZMO45Ao+oGfQsvbv39HLqnmKNTNOMapkXZgBDJ+So24HzUk5b20UVhDUx1f6Z+oWwCY8tiaOpAkxLdr41urKPInRMiljyr2FqS/73ZUyn8NrCcvSxDZnAWGFljlq/WGygrD3qoM94j8YgwML9mroCWmMa8Y4q51YkMBD1VBpQRe52w8kzwZ7Cyd4oBgcF9oHyGOKJcoS4VAoNofJv52tAJPlNK95hb/1PL1fFYT2m8Rcg9gjUZ4b7vJuk+cYdi7+4RQCZDfo2/q0wAUEqaqO9BIGtehXofFN4NHjUkyIyd6Qk8sjq4aj73EnPnizvMK0ZkS9+EJv221Uxep0Ab9bt24ZisASdMpHdg9lfV7g3aB1FgkRjLiMXOWcRaIcl7LxifiGu2vtU02LUOTVQcyCjvxONoFrFKW+oFk0DU0iDHFRyWzdl6H+LWau+WwP0FkS8m2xLY4RAO0qQX5tClacGmZCKoNqStOip7DZAFXFTft9BL0myxg5TKQo9Hl6vkCpeN25vpGa5J+NkJslrPDDZ8Hmna2B5ow4P8ELQALA/+3sIA4silkC1tNDbczWi8jdbrZqOHdWMGmOZVlvZ6hSjEAGdTwy/DOsQw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e700c095-9f83-45c6-3d98-08d83b183f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 21:24:19.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/WZseWGHF263Qvt6R/hyuyJBchj+UEYW4SIMSZ1QYwF5fzltoSode3EWSwJDThXaBd0VKoNIDS/BUNHNAN8r6RzD898nJZn0CnR4fBUkg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBUaGlzIGRpZG4ndCB3b3JrIHdlbGwgaW4gdGVzdGluZzoNCj4gDQo+IGh0dHBzOi8vYXV0b2J1
aWxkZXIueW9jdG9wcm9qZWN0Lm9yZy90eXBob29uLyMvYnVpbGRlcnMvODMvYnVpbGRzLzEyMzkv
c3RlDQo+IHBzLzEwL2xvZ3Mvc3RlcDFiDQo+IGZyb20NCj4gaHR0cHM6Ly9hdXRvYnVpbGRlci55
b2N0b3Byb2plY3Qub3JnL3R5cGhvb24vIy9idWlsZGVycy84My9idWlsZHMvMTIzOQ0KDQpIb3cg
ZG8gSSB2aWV3IHRoZSBsb2cgZmlsZSBpdCB0YWxrcyBhYm91dCwgL2hvbWUvcG9reWJ1aWxkL3lv
Y3RvLXdvcmtlci9hLWZ1bGwvYnVpbGQvYnVpbGQvdG1wL2xvZy9lcnJvci1yZXBvcnQvZXJyb3Jf
cmVwb3J0XzIwMjAwODA3MjAyODQzLnR4dCA/DQoNClRoYW5rcywNCkNocmlzDQo=
