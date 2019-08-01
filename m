Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr740058.outbound.protection.outlook.com [40.107.74.58])
	by mail.openembedded.org (Postfix) with ESMTP id CEBAB7F562;
	Thu,  1 Aug 2019 18:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=kuP5MkRJRNLVUb+RkvQNfRvmeszuYj3zNOpVYgRqAfeOqU4bVIGRAHE0Ag1PkMmWHNsCJ08oANeupymIsTry+94bC+03qjkqQUfOevb/JtBix81of2cGjaHCgbPYjF/woMdtoQOJchiCVvHfs5rdXgdC+V0OGgdze7vcNVe4vrKPo6FHRaMi8zE6d7d0YOHYR3oDWB/camLOc1McCFNj2YNJt9XiBsnpt7TyDhJCdUnOHxPDMcP7IsTpuCn6P9ge8hcZHnP9FGl0s/341vdG+ES7QOQJNJinjk7iBMdKUmDCBsrAxqLCCkf5kk/4TpXC87jK817wqeK7STPgJm2rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=sTeVsSxYi5zAtJ9JEQhyQYmt8vf0uWK8pBy9Z1tpEFU=;
	b=YbRRLOu3er5KT32mY8LAcwZCTfzR0iLVtCrIFzMtILRTDIZqUFQ3IN1pTEMBnWd6VEY+JueYA03ZxT/dWzA0wUIpaHRAACjjFiRdUPE/EY0DoqzduseGorjYnztRPji4fsbxVa3q5eC3vD0dgCaNzC1CyG177pwNFpJ93nuaPCC3yYsNq0niraTRH28mpEufHjqBDKy8Yh6xP0fXmgk8+IW30V6RJJrtYAzO4D/FXOzzZeZvVW4a0SY9daayNFyzK9YNq4F18ugC1nhD5LX4QAv+uRHMg5+IwnvUsvmg3WC85DVg+GSbY2ZwzC/UIvRCVHegkGgPM2L1+MXbpn4wTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=agilent.com;dmarc=pass action=none
	header.from=agilent.com;dkim=pass header.d=agilent.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=sTeVsSxYi5zAtJ9JEQhyQYmt8vf0uWK8pBy9Z1tpEFU=;
	b=PF2eK/uncPVPW1bWu8+IGIAIiDLFRDF+pUev38eiBIovQdLarHgvFHIgHzN4BlWB4mMGjbdx62mIvjwaA5JOkeyCHpAFh3JOlyEgaGAr1CKxA/T8qLZrxAjRYa4PKEbEjwH/4svAxDERmMFWH9ErX+1q3AnUyOagRR2GBdFAEHY=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1573.namprd12.prod.outlook.com (10.172.70.151) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2115.15; Thu, 1 Aug 2019 18:03:04 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc%9]) with mapi id 15.20.2136.010;
	Thu, 1 Aug 2019 18:03:04 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Mark Hatle <mark.hatle@windriver.com>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: UNVERIFIED SENDER Re: [bitbake-devel] RFC: exposing information
	about the SRC_URI(s)/branch via buildhistory (or similar
	mechanism)
Thread-Index: AdVIiV4bZ0XUaI6MTqawP3i+Dxw25gAAV48AAAIZtdA=
Date: Thu, 1 Aug 2019 18:03:04 +0000
Message-ID: <CY4PR12MB1653E78A4333D0184E5A67178BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<baa880f5-9f42-9364-dd23-325837f791c5@windriver.com>
In-Reply-To: <baa880f5-9f42-9364-dd23-325837f791c5@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [68.80.99.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efc85748-676f-433d-a363-08d716aa804e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1573; 
x-ms-traffictypediagnostic: CY4PR12MB1573:
x-microsoft-antispam-prvs: <CY4PR12MB1573BBD945AD0A67988D3B998BDE0@CY4PR12MB1573.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(54534003)(29502001)(2501003)(8676002)(4744005)(76116006)(186003)(110136005)(6436002)(476003)(229853002)(11346002)(68736007)(26005)(316002)(14454004)(52536014)(81166006)(486006)(446003)(7696005)(7736002)(478600001)(256004)(6506007)(2906002)(33656002)(76176011)(8936002)(81156014)(2201001)(3846002)(66946007)(25786009)(66556008)(5660300002)(74316002)(6116002)(9686003)(305945005)(99286004)(66066001)(53936002)(64756008)(66476007)(102836004)(86362001)(71190400001)(66446008)(71200400001)(6246003)(55016002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1573;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M1bJA4g5Y2XCrenxjVACaD0+Ccdwx+OqpeRhPVI73pe7PYHxjneZdTSMPsaMxfrlqQ60US7J68t0zitYOPhLV46my9K5hgmJX6G2nxgCZ199EfAnZbqKG0OuPujqyL5oaI9+J/D+IVA6il1Urgm/gfXx2mmaiY5ha3bISR+LBnHcGQTMeGplFZl0aFsLe/Bsw1PVSma9nvhHDvX8tacEglmm8cGSWG17teRyid4fFhZd/A5Hv0rGafrEtrcn0ecq2nnXrov67UlKevlLFVgT3Qjkw+J7sTkDuRNGJQvmDTcKqaGqnQ2OfLKDdV29uFFU632FsoZTtZXYCLz1nHb3nYU7LGy5luZHXNDJmmo1NbBm0W8Bx6ZC/GArmOXCC2e7t9XHzrwL611QbdASx+IqTcBnDFlTw4BDXIGm04f3MVk=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc85748-676f-433d-a363-08d716aa804e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 18:03:04.6834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
Subject: Re: UNVERIFIED SENDER Re: RFC: exposing information about the SRC_URI(s)/branch via buildhistory (or similar mechanism)
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
X-List-Received-Date: Thu, 01 Aug 2019 18:03:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> I've had some thoughts of capturing that same information, as well as
> automatically generating a changelog (from short-commit entries) from the=
 last
> build to the current one use standard git commands... but I've never had =
time to
> implement anything.
>=20
> When I talked with RP about this a while back, he mentioned it should be
> possible to extend the functionality of buildhistory with an additional c=
lass.
> So the user could opt into extended functionality by including more then =
one
> buildhistory class.
>=20
> So my recommendation, store the URL you pulled from along with the SRCREV=
 (if
> it's not already been stored).  This can then be used later to investigat=
e -- or
> extended [internally or externally] to create changelogs.

Wouldn't it be a bit overkill to add a new class just to handle SRC_URI? I =
would think it would just be a little extra code inside write_latest_srcrev=
.

Chris=20

