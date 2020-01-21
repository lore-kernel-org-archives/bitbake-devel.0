Return-Path: <chris.laplante@agilent.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by mail.openembedded.org (Postfix) with ESMTP id CE0A07FB78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2020 14:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=KGhQmDKNpKpYmVxhvAd5lYCSHYLK3o1P7wUby+0hyZQBrXsm1CgNgGpUpKqhoBfDlWd7Ie4GnahWkbcnVjNuu/e210CKKMqfot25nFBPKmH5vrTxfJQXgBEr8sZapYVai2+iq7FyixUec6px8lo++q079w72kPc+jQAhn8hwh8HW0BRMKjOsjTbU7XV0Nk7FvIirfH9i4+D7hkSpTaep6XiN4uduPb3hLo6pCwR6boF+RhiVhuqvjYChOXCDZ+Bso6ZsN90SFyYnfn3nGL+5p1ZzeldhvRMOp4m4K6lE5oB9KTy10TfDzechyEoZ18EUIo6X+3cvBeDDIRaSJwL6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9gzEfwWm2Y6ASSmc4w8StSJ16x7WRuoCFGnsRR5y4wQ=;
	b=GjaNnIIis3VEjcFZsBSzei4nabdOHyyJMQGwQCl371S8RXEztqixRpt0wKZAmwB/KGSmLxvHKkhfnuB7eaOaLETyLSOWOxI1E1NV/W0hwvXsT78aleE7LQgnFiAS1yuwXJDMarce3JCs9GLfNjfF84gFymNSuiPjtnfP26BAqqgHofigMvmDxwIBDLrX7eYoiR9Q6URXC09+DY+K33Njs9MGl3zmThMUgIJcOl+CZEQghMURZYf0/VIZCQ9JIbxqubCO+KCqY9ZksM0hnHU2RLLUdbBtMTpOH+Fim5b1OK5LYRvz9H9ZI85xoxsII55xC4jDl175ah6Rj1NhK2EUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9gzEfwWm2Y6ASSmc4w8StSJ16x7WRuoCFGnsRR5y4wQ=;
	b=MNHGnGBkhaQ2NvjTIaQKqSWT6uYdjCaMklO4Yk8/BAX+YIJ3Hh5/vqkZLa3vZuE9yzpE58Z732sXu4/ZsfCpn3kVHYZZvsjlhkdE2a2Bt3IMw9gVisGWzQLKK2AWjN5EushNbzRBDnS42PmkjdrpmThGxULgxGc1+cP2OeyqAuU=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1735.namprd12.prod.outlook.com (10.175.63.13) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2644.25; Tue, 21 Jan 2020 14:30:46 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::3c16:3c42:ee9f:b486]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::3c16:3c42:ee9f:b486%9]) with mapi id 15.20.2644.027;
	Tue, 21 Jan 2020 14:30:45 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] build.py: record time spent executing each function
Thread-Index: AQHVzk/UviyzOepWnki5zcAR3u5NfKfxP3sAgAHtRICAAgVIQA==
Date: Tue, 21 Jan 2020 14:30:45 +0000
Message-ID: <CY4PR12MB1653F078FA4980624C8D6E5F8B0D0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
	<CY4PR12MB1653C176011A53D5E6A523568B330@CY4PR12MB1653.namprd12.prod.outlook.com>
	<7a8eddab-af95-21b2-6392-aab5c8ed7348@prevas.dk>
In-Reply-To: <7a8eddab-af95-21b2-6392-aab5c8ed7348@prevas.dk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc58591a-d9d9-410a-a243-08d79e7e80c9
x-ms-traffictypediagnostic: CY4PR12MB1735:
x-microsoft-antispam-prvs: <CY4PR12MB1735D248A72D100D734754CE8B0D0@CY4PR12MB1735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(29502001)(199004)(26005)(186003)(478600001)(6506007)(7696005)(66946007)(8936002)(55016002)(71200400001)(52536014)(110136005)(86362001)(316002)(5660300002)(76116006)(2906002)(558084003)(66556008)(64756008)(9686003)(8676002)(66476007)(33656002)(81166006)(81156014)(66446008)(4326008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1735;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khWolX2VSJoYLaPd4nFn55LMMzP9Xu4eaZBfFalMuEHd2AvwcPrPbsQqCuylhUz8hc5hu0X/sM/MtyFcxBv8M1dDtO6kM/sN7HN1evrhIhztKtUBNFW+koAxfKd9GM8vl7Rn19Z4GqB/9VNduL7faKWv3o7Z6G8/rRq4FGWN8E+zcL4FprmpBxX7+q7Khr8FhKy4jN5oZxTFhgOEbbP9/vdbmrtYHb2Q6ytQPtNa+Vh/+ZaVR5Sf6gFxBQOzwY8ZaibwHaK7CWieubpMqSVlSitVVlBi69HBGl/IMThHG9MBhVSe3iU9oWwW2CMTQ2lJ8aZnwzKsDr1fpk4EozDzcLdThrWVx1AiWr3Q3CwtLf7MGiYWAKL31z5u289k0ok8U4Hmt5XHrTg55DggoH7yv0tH2kbM/tFrDolRt+v4wve7po9N9d8uwLz9ltwgU/ZqHtvVgjUya3GOzg9lohpQWDChGuhQ9FMSpVR2IuMGe5v4PAQAv3cD9h5ErtjqhxZh
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc58591a-d9d9-410a-a243-08d79e7e80c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 14:30:45.8511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLTR+zXPkwowEHe+K1uxeTf5TUFm776/qg7GywZ0nR/A0lsEavleGrMxkiBoWio/IqOTY7/at6m1b2aoSnevVLbApv6yQ3HaqVoUwAJvjKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1735
Subject: Re: [PATCH] build.py: record time spent executing each function
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
X-List-Received-Date: Tue, 21 Jan 2020 14:30:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > Not sure why you sent this to me, to be honest.
>=20
> Lacking something like scripts/get_maintainer, I resorted to cc'ing the
> last few people to touch that file.

Ah, gotcha :)


