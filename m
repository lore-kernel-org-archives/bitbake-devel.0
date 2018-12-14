Return-Path: <raphael.lisicki@siemens.com>
X-Greylist: delayed 129559 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 16 Dec 2018 07:11:46 UTC
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
	(mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
	by mail.openembedded.org (Postfix) with ESMTP id A82196BA7C
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 16 Dec 2018 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=siemens.onmicrosoft.com; s=selector1-siemens-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lmdLjF0tGezHWA8pzM0+l57Xa79+Qkiq0C0Ih/8w0V0=;
	b=DV7pWX3MD7Ya9NeBft83eZ5fYUbWNop1yqSyEaL2TaCLnytxxKse6i7kn/Ah9Yx500ObkCH07QZ36JSuvpDd5zPbrw35X/4c6PPSXfo3AJLxsDlgk2R8aJoaurH+cZHKkRWh67IOxJ2pJ6UkQe0ea3/NIBCbMCBh9e6PF8DZ0QM=
Received: from VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM (20.177.62.75) by
	VI1PR10MB1775.EURPRD10.PROD.OUTLOOK.COM (10.165.194.152) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1425.19; Fri, 14 Dec 2018 12:37:48 +0000
Received: from VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM
	([fe80::d123:4e05:1797:3a0e]) by
	VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM
	([fe80::d123:4e05:1797:3a0e%2]) with mapi id 15.20.1425.021;
	Fri, 14 Dec 2018 12:37:47 +0000
From: "raphael.lisicki@siemens.com" <raphael.lisicki@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: gitsm: orphaned submodules WAS: Sumo to Thud migration: Fetch
	failure from gitsm.py
Thread-Index: AdSTqV0UDYxI9dewTkCcHKa88UwW7g==
Date: Fri, 14 Dec 2018 12:37:47 +0000
Message-ID: <VI1PR10MB2287E378DA3E6ADDEB09F8FDECA10@VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-sodocominimumclassification: NotClassified
x-document-confidentiality: Restricted
x-originating-ip: [80.146.228.119]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR10MB1775;
	6:bT3JdZdIyo65KkRMwRPy4ZNmOGzxO+i3XW7BivUFwTH8ooRsOhVsZB7ux69uoSzOEBvjPomU/Em/inF+Qd5o2kXZvn6TtD6jJq/aHW+jmNsNU3aXQnhKcBXQoAQQxmqPIAzHuIK2caqyxXfz+AsD8ohuFLjiEQgH4BtUudPlZT/2nCnlPEgaLiLWvbbT3MsJxu0ESKiDEIi25o+ub5YCLytubn82ALrI17udImjaeKHZ9I5hHbLhEyNXFhh4DDAkzb7qu3mKoOyEDmbJgkeg9ArKx1Ry1EyhW/yE7+FoqWOdJ1TPHXnnfNh6XCZkjeHXUIA3MgoMWWN2+5PKy0A3yJtFXREpcBXjBRSwcEEN/7nHsfrY99cLMz7CSjE8sR/xVNLUwbZoZNeobCcWs/FohE74gJcAe8ZjCGkItdWMN0vtfWrd3ez5G5a1B0bGMRQ3HzsjDaUOpWpBOvG2vIVaoA==;
	5:ZjiZ9eS0h0PwzHkoe8WLZgOdZirXx3DM7BfhkmvlPT/nS3M9CH3Zb8TwasXtjNDdI4Hl5DOvOAQEIkwMOhRbQHDi2n+Zo+Jb1rhpb5xevIWQQ3Cw09nNXGHnzDbpNnEXaE7igW1HFxMbDT6NgHmlJJGGTaNJfilXY06Dha+BBtA=;
	7:pstWmdQ1h5ybBJyRR0u5EEG1FHkESFirJ4RnfzQFmiF0GWWc+jrBlnknNq9F2p5us/BQWuIS7cgjCCN99GYmuWUPoB7c26hpQMIiJMHtWNqbdcHxQmiFgHgOQghpvTgR+NN3ttp1EW9MxVEQZztH1Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 39b93b9e-2c9b-4c38-291e-08d661c0f430
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
	SRVR:VI1PR10MB1775; 
x-ms-traffictypediagnostic: VI1PR10MB1775:
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=raphael.lisicki@siemens.com; 
x-microsoft-antispam-prvs: <VI1PR10MB17755D30D7A19645960D8B29ECA10@VI1PR10MB1775.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
	SRVR:VI1PR10MB1775; BCL:0; PCL:0; RULEID:; SRVR:VI1PR10MB1775; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(55016002)(5640700003)(8676002)(9686003)(305945005)(33656002)(97736004)(6436002)(7736002)(6306002)(53936002)(786003)(105586002)(106356001)(8936002)(81166006)(6916009)(81156014)(2351001)(3846002)(316002)(6506007)(186003)(2906002)(102836004)(26005)(7696005)(476003)(99286004)(71190400001)(71200400001)(6116002)(486006)(256004)(86362001)(74316002)(2501003)(25786009)(66066001)(5660300001)(68736007)(478600001)(966005)(14454004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR10MB1775;
	H:VI1PR10MB2287.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: siemens.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: e+tLZ3QdhscmCtv3E1qk4l1D0ECX2Y+jKS2lokscujHdFtvaqjcF1uf+w89yibWnbE0df32KlLqnrQd3ZRBfR/nApy8D1bF0UK/le/ptALdIz34tW076Op1LuqW2D1agp/GdrhMpaQCy/AES97GD8+ogWJp5sE9XGfitsvQ57dbeWMiDYuJY7Gi4qf0RimsF+Q6akuwgNiu/WfS7SnprlZlhSP6xQNT0mecKsexC9Qd3bmcaa0QGxF+Dt1w4azI3iXe1DnAsWTBsVO0nRX0AEtKiM4aA1x7X9brJXuR2x42Qi7mZqMuOa7eJcYymWlrE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b93b9e-2c9b-4c38-291e-08d661c0f430
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 12:37:47.5774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1775
Subject: gitsm: orphaned submodules WAS: Sumo to Thud migration: Fetch failure from gitsm.py
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 16 Dec 2018 07:11:47 -0000
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

as Josias has already pointed out, the new gitsm fetcher fails if there is =
a submodule entry in .gitmodules, for which no actual submodule exists.

I created a dummy module that shows the respective issue: https://github.co=
m/ralisi/submodule-test

This repository is shown correctly by github and cloning it with git causes=
 no problem. I think it should be possible to fetch this repository with th=
e gitsm module.
To do so, I think the loop iteration at http://git.yoctoproject.org/cgit/cg=
it.cgi/poky/tree/bitbake/lib/bb/fetch2/gitsm.py#n87 can be skipped if modul=
e_hash is indeed an empty string.


Best regards
Raphael Lisicki

