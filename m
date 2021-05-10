Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.66])
 by mx.groups.io with SMTP id smtpd.web10.28172.1620629116218214741
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 09 May 2021 23:45:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=B5O+i8j+;
 spf=temperror, err=temporary DNS error (domain: windriver.com, ip: 40.107.101.66, mailfrom: qiang.zhang@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms7eFyu0TddCqj+GTCE7H5m6xR8yxrTiFpZ7brBStKzE/VhpCdi1Y2+5xOXHP28tp3s2n47e1asiQDFIKPpgp7u5r9FQTV0zZZiZkPQvIgarUZQpAovd24eKm8mhV/AaaMtCmBR8mNynXPcmgZ1EaJQ7fQlJCisTAAb0CgBX7WL8gd7s53MMcGgPdBgopG/Ynz2MN/Ax44vWClnVLp4VoUrwDGN5QvMu3pnLkoCkaXIOfFDer1HG1DgGmbawlYIfQGIpHMvEdYnW5forDASOgHgq1EYzsu3WySicLv8tk9RQmKKa4tw4wsZKYJ1FCVKOb6PlY5qwUhZexvn5D32p1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js6lfPP5jKgQoa4kd39+plf5hn4QIAKHFZaaupBx+pc=;
 b=hYsHlMGXbQml1fNYSk3l1xtllgPMCZsLQwOopPDsu2OtorFkPIAdtTXWeTVCe61x647tenTfOwaA5yfGgDURuW1+1P5n42ib4JENTsho1K3aj+kUlXKsJXdNmoL6mUuvNlyrsTzb+IS0YfkSOaKfagx0hRoen8TAQ3emTHPIemfWflgs4TZoBzjZm2OoEWIVjdzfBJiNw2VOCpjPDOmA6YvHLN/9OosmpiOIFZ172BpU836gav/pnuEx2lY+wU/s7TW363un65/02BUVG6fYv4gf/Kug8oolEtIH7cmXOfoFxYvs2UXx3NHAKqxD6zyhAlbJCp6Ev97vgIer10jL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js6lfPP5jKgQoa4kd39+plf5hn4QIAKHFZaaupBx+pc=;
 b=B5O+i8j+jw9qBFLudHySwIqpcawdlBBpclpe45OP+Iel+Mgt93VbMh745b7JmvO9D3MKJaU+9/+RZmiMyycfd8pRt3rifJgC05dqVuWgv4pGWH+TNa0+3/ESLBCezNW6rLP1+Z2u+e5cGKpV2erhjnNj9s0WVjr1tlMYqA3sL38=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB2602.namprd11.prod.outlook.com (2603:10b6:5:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 06:45:14 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 06:45:13 +0000
From: "Zhang, Qiang" <qiang.zhang@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Help on Handle BASH_FUNC shellshock implication
Thread-Topic: Help on  Handle BASH_FUNC shellshock implication
Thread-Index: AQHXRWcGL94lvWbeakaKdeob07d48w==
Date: Mon, 10 May 2021 06:45:13 +0000
Message-ID: 
 <DM6PR11MB42025DE7A846AF975F14E0DEFF549@DM6PR11MB4202.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6ecf00-1bcd-40fc-d0be-08d9137f2a37
x-ms-traffictypediagnostic: DM6PR11MB2602:
x-microsoft-antispam-prvs: 
 <DM6PR11MB260282545589F7856924FCDEFF549@DM6PR11MB2602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wDRLizCylI5e7vdUAgwzvjZeBtkKGEMZy7urfxpoPNnKWvavBVwS9ywWJyuBhh7SsTPqJ9B2sFTDllwu9NV0I633/TR9nZiZ41IP0T4mbBMnjKB4QzxMMl6BBGzcrzX/jTcDJVS2821MDmBXcWC0A4Fn79k+nBs6EoLZ4jQfeGcAH0jMqzRAZoGxZG5lxN835/Ucswlg6uttykzWsKhjPfZGUhI9fLRllH4mcMCLr9H0lQcvef+4MAbu45cpGNk5BEJAup3YmRSeO8wiWRWHNHiHlsoDGtw89z7Tn0o+m5wV2UO7bj6x1ljr4UZFj/aZ0godESwiwbq0CZxox/jyrSBKJgjviY27KoQtm0dBApC6MYXnJ9rUIsWnCFQXe4CfmI1IA+LKiLRGXETfbAtrwjOcBO5iE+M1/XtKzBf0mWpoX7MpfP8l4MdPKaJFOiEP5E/pYSytANn5q7o7z0+EM3csozWOxXNB1nr6Vu7Wml58MsN2UMQzGmX88SAz56hfu/ckB5aopirXIFMrViA0spszYi0QwxKpRZJSLM5t5LIrgRXvlcCjZTYtjvBtJpW9moleYqj/hwqynQn8DoNPlWSllJvSzQHtXQh1lmxHCSX4hHY4z/y+PvQkIpbTcRVQ9TMyVB1SQxETrOXcWYwytISkxczlMhU9dm457PZhaO4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39840400004)(366004)(4744005)(71200400001)(66946007)(6506007)(64756008)(66556008)(9686003)(66476007)(66446008)(186003)(55016002)(8936002)(8676002)(38100700002)(122000001)(6916009)(33656002)(76116006)(91956017)(26005)(2906002)(5660300002)(52536014)(478600001)(4326008)(86362001)(316002)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?cHhLZFh6NFphaEU3N2lQU21WdDhaay9xK3hUMmZ0MGVxMFlHcXZDRlBZVS9Q?=
 =?gb2312?B?SWl5MFJvTTltN0NwVFZuTTNSZHF3UGY4eUlSc3FMQUxxOHRrS1ptL0VkNkh2?=
 =?gb2312?B?UWtucjBDTGZRVWxHMWc0b2tQRnR6OEdoTFNtZzhJaVhOaUZvZVh2eURvakx6?=
 =?gb2312?B?KzVZR01ONDFXWHNmcUk2TDZ3TFkvQUdhTEFqL3ZuMmZHZC9tVC9XdEJNMXVY?=
 =?gb2312?B?cmZmb2haTmJpZ05nZUFQUzZVbnNHQVF4V3grc3FZT2cvZkNDNFhUMkN0cGNN?=
 =?gb2312?B?aUFQUGlDN2VvdTEzRVBsS0Z1T1lKODJkdEJOQmpXNmtQT3VMNG1Md3dXbmdK?=
 =?gb2312?B?ZzI0V1ZrMzljNG14QXd6SGRwTUVLVnJOZWlMMUkvZnQzWkhYcTFCZmZYaTdx?=
 =?gb2312?B?VnFYWVErYVdsUHNzMFlrZC96ZGdxOHRCMVhQczIvSEJZa256ajVuR3RLYXgy?=
 =?gb2312?B?WkdhTXI2amszWDBCL0pER0pjeGl4TjNWQzJTdm8zTlRUN0NXQW1CTDYyTVBH?=
 =?gb2312?B?aGwwdDRsZmFQazJGemRrQ2M0SnhEc3Q1Y2gzWHM3N21md0dPRFZUNjgvSGFn?=
 =?gb2312?B?SE05OXlKV2h4ZHBRejZoeHRsM2hidFM4dzltTGNpZ0JwblFodjMyMEdrWWhT?=
 =?gb2312?B?bzEvbTRENnNwMnpKc1F3NnU2ZHRYSUhTNE1UTUF6WGxMUVdXWDhmWmZ2M2Jv?=
 =?gb2312?B?SzN6RzBBM2tSSEw0SlVoVGt1R0RjM29Wdm1sbVZGRkg4SVdkZTRjMmd2QjJD?=
 =?gb2312?B?UmhUOHZZNnVVTWU4SHptQ2l3YU9vb0YybXU5U250UVlXWDlUYUYyeWoycWp5?=
 =?gb2312?B?NUJXQkpCZjBkcm5wVU11S2x3MUtaVkljd2FtODBYekIwSWdlRkFEZHRkaHli?=
 =?gb2312?B?d3grMlVvaUN1eXRvdFJTeFNwdWFMaUN5NnZvMnRWdjV4YmNibk5DYjI1V2x5?=
 =?gb2312?B?dmsxSnR5RXVVREw3NE02cDg3RFlJOUxOSExQVHVNYzEyRnljcWRBaGhiNFdu?=
 =?gb2312?B?NUFGYjhoSlhBVi9UYy9YOWdQU0h3MG9jTm16TzcrbmhaQUpROTJ5N2YxNkt3?=
 =?gb2312?B?SG1HMXRoOEV0Nkp1M21JTkV2clp1eW9STU1QWW55cllBY0YzR09BZ0lvUzY1?=
 =?gb2312?B?ZXJyL0Jsc2VaL1F3Nk0vYVliVTBoSGp4VDZHTjBNRVFFWkdob3BVcGVPeGRE?=
 =?gb2312?B?UTJQYlVNc1hvT1pwakxzRnR2UVd1M3RncTl6aEYreXZaeVhlK250WGFZV1N3?=
 =?gb2312?B?cmk2czhTaG5qUW90SDJuMzBPVmw0Y1Exd09MLzQyN1JBUVBtYk10Q1RBcHJQ?=
 =?gb2312?B?ODg1WHBtREp4N1lKZVBZNDN0TzczbUtrV2svZTFmeGZUeExYa012Y2E4V3B6?=
 =?gb2312?B?azdWN3ZtYWRaWFJXRG1FcU01QXYxYndidjAxdGpKbXcvSmlRQzVhcC92WFFI?=
 =?gb2312?B?ZElGRzRpcDE4eDdtRzF5aGRzb1NwUGZrRXRkdlkwVlRSV3VpQlRMYVNKQ21M?=
 =?gb2312?B?dXpPM1UrOTdiZWZ0VldZWjZ2VVJYTDVYZTkxN21DZFoyMUhhRGQyNzNkK3k5?=
 =?gb2312?B?UlRNd2RmYjFrTTdiMW53Z1pabnlyYU5RcFRPazRZYnArSjNLMGpIRktPK3I2?=
 =?gb2312?B?YVNpVlFma1J3WVE4ZHMzRExFQ1ROdEJwaWlLK3ZFa1hLbEFleE0vbGN3NWVh?=
 =?gb2312?B?c1FGS0Rsd3lvS2tEZ2RMRHcxaHR0V0R1ampYRDFhRk9idVBUSlVHY3I4L0JM?=
 =?gb2312?Q?VJz8Yqig/LYo8Rz4Dw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6ecf00-1bcd-40fc-d0be-08d9137f2a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 06:45:13.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Oml/7gcG1JGffw8pfLl6DuuDdQIpg4eUrmUux1vG4CyRWlrqknlPrPz1S5bn3AWm6f9DYm8BjXQ0P6YPVgJco0Jd07jEYBjFa/Qzq306oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2602
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8gIFJpY2hhcmQgUHVyZGllCgpFeGN1c2UgbWUsIEkgaGF2ZSBzb21lIHF1ZXN0aW9ucyB0
byBhc2sKIEkndmUgYWRkZWQgdGhpcyBtb2RpZmljYXRpb24gOgpodHRwOi8vZ2l0LnlvY3RvcHJv
amVjdC5vcmcvY2dpdC5jZ2kvcG9reS9jb21taXQvP2lkPWViMmVhNmZkMmQyZGM2MjZlYWQxM2Rl
MWVjMzM0ZDQyMjA2NTE2MTIKCkluIFVidW50dSAxOC4wNApidXQgICBJIGVudGVyIHRoZSBmb2xs
b3dpbmcgY29tbWFuZCAsIGl0IHdpbGwgc3RpbGwgZmFpbDoKCmZvb2JhcigpIHsgZWNobyAiZm9v
YmFyIjsgfQoKZXhwb3J0IC1mIGZvb2JhcgoKYml0YmFrZSAtYyBtZW51Y29uZmlnIGxpbnV4LXlv
Y3RvCgp0aGUgZXJyb3Igb2NjdXIsIG5vdCBsYXVuY2ggbWVudWNvbmZpZwoKMDogbGludXgteW9j
dG8tNS40LngrZ2l0QVVUT0lOQytkNjc2YmY1ZmY3XzFiMTA4NTRhMTAtcjAgZG9fbWVudWNvbmZp
ZyAtIDBzIChwaWQgNjM5OCkKVHJ5aW5nIHRvIHJ1bjogdG11eCBhdHQgLXQgZGV2c2hlbGwtNjM5
OApjYW4ndCBmaW5kIHNlc3Npb24gZGV2c2hlbGwtNjM5OApUcnlpbmcgdG8gcnVuOiB0bXV4IGF0
dCAtdCBkZXZzaGVsbC02Mzk4CmNhbid0IGZpbmQgc2Vzc2lvbiBkZXZzaGVsbC02Mzk4
