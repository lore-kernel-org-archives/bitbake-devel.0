Return-Path: <chris.laplante@agilent.com>
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr730088.outbound.protection.outlook.com [40.107.73.88])
	by mail.openembedded.org (Postfix) with ESMTP id 026847CDAC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 20:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=ZMCRJmqKaeRMoF3e71VRp7jFFyYbJdiX9Zx1evDLAvPyh0oTA5P6wcok2iFTJCNP4nRrqK2izRunBsBntODyVAJCcsJqkvneiP5+LOTz0f2CvD0cTeuVwfJxNBUsVjX3qWY5B6p/5+3EmUQohvUeYlcffM5cNlcW51otzqkMViFHxfygSOHxhkRwcjGs2RFCklk/IonsvnU54mKFdpWMOCplxe1/xmwoB7l1zUNViYKUGqNsIEgWd9RtEc/sxz+6jA0cd4CQCGQSb1B/DUZctZSDjfszR1yC1N2mWGEVH4Pw/iZizHV1NtMSEalZDQraY4jCUs14PddXS3lupx4GYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=vSPGG9/SlwtduZWfuo6JAW6FY4R0N37xntyKQeGwEFg=;
	b=i8rMH7kXXeUOCoc8wH2IZheIBe4tBzl3pxHpmkseAaBBqabdrNWZIyyzzgfi5M5BaMyMu95L5uUZatIDDSlepy1AuZxCipCA4eL9NqVRiJ+UwJXi1uSfK0l1qQPC1FkTp4dhpe7wlLCgdUxnpGIDG1KpO+2Smi8vW15Bv3MZdN8vZswNOn0C3KV0d73lrIBHuTPg9ol+7MiUQro2Q798DfJ3i9k2gCUIQsRBQ5AoOYUglsJNmwsFd1PT8mUmlzwtHftx1cCFgSF7XEjgklfSr5OmjtB0bA3L79UmbkvhKP46m2kSGAokmwmJlXyQkBGBM2aAiPtSBxiZXhgTBvFtNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=vSPGG9/SlwtduZWfuo6JAW6FY4R0N37xntyKQeGwEFg=;
	b=NejGXH0/wq1yHQUhLOugK+0JKy01zN0rpCX9efvmwA42kKE0nowbq/t9Ggzkcwws9uQ0UNEBFLDTJLvMsRuDgmNJXg0xeBzlZyD8MvIaUmOx6E43kiBdIXp7x328wF03E8HjHUXMoaZh7qUJURBQ1zQvfLPQpupe2iw9D3UfbyQ=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1272.namprd12.prod.outlook.com (10.168.167.149) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2347.16; Fri, 11 Oct 2019 20:27:49 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986%5]) with mapi id 15.20.2347.021;
	Fri, 11 Oct 2019 20:27:49 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Paul Barker <paul@betafive.co.uk>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/9] bitbake: contrib/vim: initial
	commit,	with unmodified code from indent/python.vim
Thread-Index: AQHVgHDcc4q7rBTzm0SLUMaonUhwgqdV4b6A
Date: Fri, 11 Oct 2019 20:27:49 +0000
Message-ID: <CY4PR12MB1653AD537BF091F17D9214F58B970@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
	<d14ef26853f00ec375884830e627c2c7a454cb5d.1570810590.git.chris.laplante@agilent.com>
	<b243b0e4-2415-4556-a665-4c58d2d43e01@www.fastmail.com>
In-Reply-To: <b243b0e4-2415-4556-a665-4c58d2d43e01@www.fastmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 971365f2-7373-493c-d53d-08d74e897bef
x-ms-traffictypediagnostic: CY4PR12MB1272:
x-microsoft-antispam-prvs: <CY4PR12MB12728DF566070A5C95BA448C8B970@CY4PR12MB1272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(29502001)(199004)(189003)(71190400001)(71200400001)(7696005)(76176011)(305945005)(7736002)(102836004)(256004)(486006)(26005)(74316002)(186003)(66066001)(476003)(6506007)(6246003)(11346002)(446003)(14454004)(99286004)(478600001)(66556008)(66476007)(76116006)(2906002)(66946007)(33656002)(9686003)(64756008)(66446008)(2501003)(229853002)(86362001)(3846002)(6116002)(4744005)(8936002)(25786009)(5660300002)(110136005)(55016002)(81156014)(6436002)(81166006)(52536014)(316002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1272;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2U2NYHIYrd+jjW1+LD3crxYF7vqoo4JxsejeLi5wGGCEU+1ImD6Ph99WW4Z+zCGFZ8jdJCVvnuSNwL2ySMXacK9gQBi/211Ir91qS/hjOyU86kNivXnBHpB+woRrsmfK+vxAEuwcELRgc4TSoHUs6KO5hqwMKoU6lLBTLkkrde/QGRPRK6ByCNtK9DW5KyMjwr7LHYTlzVyFXpJAkDiW1XxCz+Q6dctbK8FXqJc2RAWjnvNOgvXrZRdz/ObT8wcypa0gzKpgO5oYxzyXfg8ODd7TEfc3MGASrsA4PcjopM0+2guUgIKOKycFfvLwAeffXvzRdQR/8OYK/YEnBqm8WkWmeGZw9wLL/M2YLU3FjkPRzelWBbamX/zn0sxetXbfZ9yeDB8pMZxTqQAoientFTmxhkVeQrGLoxDI5SmQo20=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971365f2-7373-493c-d53d-08d74e897bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 20:27:49.2196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6d13eBcyuZW2m77VJgAyOXkviCA4AxD6LqcKCQwcwFycQfumwGf4buGptimP4oftC/REjhI1AOwedxyMTHgwjPP+4p219XWWHLtzcAP+Yiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1272
Subject: Re: [PATCH 1/9] bitbake: contrib/vim: initial commit, with unmodified code from indent/python.vim
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
X-List-Received-Date: Fri, 11 Oct 2019 20:27:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> It would be good to record the license for the imported code along with t=
he location of the original python.vim (I'm guessing it's in the
> vim source tree but I may be wrong).
>=20
> --
> Paul Barker

Good point. The revision info is called out in the source file, but I shoul=
d also add it to the commit message. And I'll be sure to explicitly state t=
he license as well.

Thanks,
Chris

