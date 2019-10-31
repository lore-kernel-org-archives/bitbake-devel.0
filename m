Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
	by mail.openembedded.org (Postfix) with ESMTP id 942107FA6F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Oct 2019 18:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=nSnJ+KrijQDtxCr1XGe6HXGfGcRCADLGDghTa1YnKRFd+dE6HCMR6yLVneeBgnSFgKSYa2U1OMFUqgBMCAeuEjhlvwEAb84aG0/S966B0M0Nb95s9yOqdTlq7sFdF7xQc+bAo+oyvLqs/IZ7ZzQ8hE6CyV9TwgYTFJzfIu7FM0Jjx5+CedScQsWdFd5cYufLBwlow8g2mLxSGjM7dWCtKEHXkCYOxT4wY6268qjWYWMWI+VX5MKdipKAArHrHbtaSNeOjgVDEiPM6WMHPwA3P6bk5Q8ZdBknSttGtrjgWCrVZ17a1QVzhx9qTOCshiqTMLJsKy9uviMCV4mmef8i4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OZdDMJVQkpg2epELTozyC8+g38xIcl4QWznNaxo00SE=;
	b=CLyN5Q229yNJlTTtRKF9G5iIaINK8OIpPW24A+4XsTC8oVdEfBAuPZUmxdbpHCBZdSjpFmP/Bw68nCm/FOJNQVtz0xbf4xPnVc7pNS9VRAZzxxR/L2rdy/Kjk+SeFZo/2+kuchGmUqGZXLpdMbMVm3jiYYK3FOsSTh4RwwDCBjPdq5ObG8/kTo+kdsX6vhw98c7u+/Tcs2imxZbNREVy+jorQXcb25MOzH1YJ5+yrjmNDA7cuz4WHUr8/4F/e3+L9zhw3vlkoIiUqEDMhvvz/kcXWIGEDjevNOlCtHubOVL0eUNOKQ9nBjv4EiRfbKCyzQ+Zh7dnO6XW0cCnuRy2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OZdDMJVQkpg2epELTozyC8+g38xIcl4QWznNaxo00SE=;
	b=VLQ46xNAlX8sC3MNOq+1kXOW6MkkmuLrAGEm2/VE9Bus1BCxKRYZUfL1x8II+V9UTn090AI+Rz0rVzF0ZmhON+p4vRUaza2PZuiNMFmMuIn4jYRxN8UPPekDUCZTBQXIgeD/nE3I9yT6NzdsQHPAiONxAnuE8mJkHqmFxPE0Qm8=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1640.namprd12.prod.outlook.com (10.172.72.136) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2387.20; Thu, 31 Oct 2019 18:16:48 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::fdcf:99b9:ab44:4986%5]) with mapi id 15.20.2387.028;
	Thu, 31 Oct 2019 18:16:48 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: command: add getOverrideData
	command
Thread-Index: AQHVkBG+ZtQDzdJ3tkeVmF9E32Yz26d1DgfQ
Date: Thu, 31 Oct 2019 18:16:47 +0000
Message-ID: <CY4PR12MB165395F03AF67093B489A54C8B630@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
In-Reply-To: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcd9c2ba-1b38-474a-13b5-08d75e2e7eb5
x-ms-traffictypediagnostic: CY4PR12MB1640:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR12MB1640ED505CAC4FB684E52A1A8B630@CY4PR12MB1640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(366004)(39860400002)(376002)(396003)(346002)(29502001)(199004)(189003)(102836004)(99286004)(186003)(6436002)(26005)(6916009)(5660300002)(4744005)(2501003)(229853002)(14454004)(6506007)(305945005)(81166006)(81156014)(74316002)(7736002)(6246003)(6116002)(476003)(33656002)(8936002)(8676002)(966005)(5640700003)(3846002)(66066001)(71190400001)(71200400001)(486006)(52536014)(66476007)(66946007)(66556008)(9686003)(6306002)(7696005)(256004)(14444005)(478600001)(55016002)(86362001)(11346002)(2351001)(2906002)(76176011)(64756008)(316002)(66446008)(446003)(25786009)(76116006);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1640;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+nidQ2IpR6HXVPoHxAY9Aju2OYch3/fwSb7ZM7tv9pEHjtwkoRDmQUww4EOnumBX5Hv6BhCFDLCxDF9qldiePMG6qzsCvIq7ZFgDcwwPC0x2MAAYxM7Q/Ozmgo+zMEOWJx+hWoIOC1XHHP05ZW/kEVhf+/m0nmodUVKoeFOQ59qvSYBoSGdyuw/Y8vK4HAPG/SMbFJ1Zq4OQvS7ZWCh5y6GBPPqgBZr1HJk6EYqtD4DQFENht0Fi6LW9twQYghiLuUQoPb2jUFxSjz2gADARs40y6+g2u4tAivm+kmtBeWyRMJm+1pj7u7g+Onml90xWqmruOiEC94SoMw5OyJsWb2dzIpa5wYoiaSMBFFewsXiCG38xKfBYlvr0BSM9Iqz8Oj+oJImImj5Hcp+jMgG00/KM0XaL+4R+82R9mxjTVLBzR7jVVomF6wJzXsx5/s2LRHblh30WTQRtU5SBR/72lrgRizbjuNv0hxfAKxudxeZWuimpnLB4goNvZvcfo38
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd9c2ba-1b38-474a-13b5-08d75e2e7eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 18:16:47.9719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrICcY0xwYhF1wYD5WLpWCzoGP+y5c/fy9f+SDvhctDt2CPriSQTiCgHovGMzq8l8fzYSdVVoOpDJ+aZ1WyyT41scCM/SRhLuofGH+PIUUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
Subject: Re: [PATCH] bitbake: command: add getOverrideData command
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
X-List-Received-Date: Thu, 31 Oct 2019 18:16:48 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Sent: Thursday, October 31, 2019 1:36 PM
> Subject: [bitbake-devel] [PATCH] bitbake: command: add getOverrideData co=
mmand
>=20
> While working on a script using tinfoil, I needed a way to access the
> overridedata for a given variable. Unfortunately, I found that
> data_smart does not have remotedata proxying for it.
>=20
> By adding the getOverrideData command, I am able to use a method like
> this to access override data (either for a particular var, or all data):

On a side note, can anyone explain why my patches are being identified by P=
atchwork as coming from Nicolas Cornu? See: https://patchwork.openembedded.=
org/project/bitbake/patches/?submitter=3D12924


