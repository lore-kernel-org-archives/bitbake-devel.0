Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700087.outbound.protection.outlook.com [40.107.70.87])
	by mail.openembedded.org (Postfix) with ESMTP id 804427F642
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2019 20:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Nr267aR0o5wBzxcgyjZ2dKtaQhk5oX2SAXRyXBOa2IUcpSvBER3oO3mKmavxwaEXSmCRFN2dQo/uqz7Z+b3UOo/BTCqaBVGYrtiXYsMnlcaYZu01AiZyYO2pPCKOwgohIMzEc26EafHFL8zy8HzAed8oM+IWXkcdN1WdQZyopD4BP81ny8aDxtoIOG1CeAcAMJN/OvrNwLp622GDbY062PSYT4d+Ou3plS81T7xFILc050Z2VW5OJN0tq8ox0ZXSRBiOJFiQ6Yvff5+gsL2x4BAPq0b5vdENYC0S/Vklf0SIQjv1jLKAlUpbBRzX3ui+8B0LGfxjkLs6fu3K0BPQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=uq5BTGqpPn9b2eTRAYU+W/2hOG98pMFlFBxHbyPm5j4=;
	b=CEfgj3k0s7CWnRiwO/sQ7T5dXes0eY2ZElcJplfeHKfuEZMzIvLVsSZVMS4kCBJupyWew8UKMLvIWoMwbJXVi1wgrqAr98IWEUp0GWGqjn2xDgdvprKBKnMAm8QbmtYN72iSLGwI2mkwC0rgmpsO1CFkqnjlU99V0Q3ruKKSj/pql9UqyXmuqe6Fb8wU5ODSDzrla7BPHj+0mznHwbhhVxC44wZ2ztEKc2T5457kleCzWYjkecpS7lBkpYzUP7Oh4nqA6DLHNsOyHiY1fsNNHmONtAYyx5njeomzs0YeF069lE0h/vAaNLhG9jhH+pzlRI5HzUNQXxOFBKPg8ijE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=uq5BTGqpPn9b2eTRAYU+W/2hOG98pMFlFBxHbyPm5j4=;
	b=GUrsw8OUeruYWcxlz1c8PM+Gcv32OIoOFO2EyCZOhBJPSkTDmJYXwfE+bIhZO5Xrd7+9FO017VQzGJw+A61XNyPBCcfPzZ72nWagZHcOFPGoiBJY35CzTeHxKwInG0cdfvG4vANLLnG+p5tX8vaJUgyPeTz1o5z6A2+1UZjUK4w=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1253.namprd12.prod.outlook.com (10.168.166.149) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2408.24; Thu, 7 Nov 2019 20:48:28 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::38c8:b362:f0b6:5134]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::38c8:b362:f0b6:5134%8]) with mapi id 15.20.2408.028;
	Thu, 7 Nov 2019 20:48:28 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH v2 0/9] BitBake Vim indentation plugin
Thread-Index: AQHVlaPnAOve6ca5k064d7BXhv//5qeALhJA
Date: Thu, 7 Nov 2019 20:48:28 +0000
Message-ID: <CY4PR12MB16539BDE0C7FA79922C041188B780@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
	<CY4PR12MB16530118DE572B2CC64389008B780@CY4PR12MB1653.namprd12.prod.outlook.com>
	<a1a450081b95cd56557a5c0341ab46ed601b059e.camel@linuxfoundation.org>
In-Reply-To: <a1a450081b95cd56557a5c0341ab46ed601b059e.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6bcb110-99ab-4e09-bee1-08d763c3d7c1
x-ms-traffictypediagnostic: CY4PR12MB1253:
x-microsoft-antispam-prvs: <CY4PR12MB125359A235342FFA4117B8C58B780@CY4PR12MB1253.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(29502001)(305945005)(6506007)(476003)(52536014)(229853002)(71200400001)(86362001)(186003)(26005)(66476007)(55016002)(99286004)(6436002)(2501003)(76176011)(102836004)(81166006)(64756008)(66946007)(14454004)(71190400001)(81156014)(8676002)(66446008)(66556008)(9686003)(316002)(7696005)(8936002)(76116006)(66066001)(446003)(11346002)(110136005)(5660300002)(486006)(6246003)(2906002)(6116002)(3846002)(478600001)(7736002)(25786009)(256004)(558084003)(33656002)(74316002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1253;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRwyUQqXdq+lEbUllHERqbQWlvstPKRMvJ758vw/3AcAPrQnKEBnjb6fZAvJCw1/eqNy3h3CYb550HzYi+FPrEQIUjC+IIKx4xdcYfixtlTAuip+YCaEkQZ+sOuSDHY7uUmNzJDb5n0nv61yNULBZnGx02ZL9gppxH3gHkECnqUsnn/cesDyJkqXswz1tZivdx6rzKQjKPVm4da8KfGof+iWZwNgymSNQyIYxXp7zMknqilJpiZGCeSolODiAhD6Eyba8d8eGOzUQB9bpOLzNSDMMHQWlYqPPrljyZgcJNK/JTdGtyOp1e2B1/u140lzMb3GWZCPK4AylNhHLQqhNPOuiDN7CSHHnHkGRfdSGamtoqoEolRp5ToANy97fPDNT2pssIQHNjnMIpztsx11UUbPI2UY8ChMS7bmv9BVmQR5tW+04D+pu3vbLA9sYHuro7X7kc9hgko+ALto71p8Lw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bcb110-99ab-4e09-bee1-08d763c3d7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 20:48:28.4696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nOVvGVgXTj5JqhAIqZosyqC7mTCob4Rrk7i5B/ZCo59uTSE3VJWTHt4xq+sJn2NJJOGjjkbmazEQPw10Kc2nyeK3iGuF2PW9AkL/cnLdks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
Subject: Re: [PATCH v2 0/9] BitBake Vim indentation plugin
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
X-List-Received-Date: Thu, 07 Nov 2019 20:48:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBGaXhlZCwgdGhlIHJlbmFtZSBpbiBwYXRjaCAzIGJyb2tlIHRoZSB0b29saW5nIGJ1dCBJIHNv
cnRlZCBpdCBvdXQNCj4gbWFudWFsbHkuDQoNCkFwcHJlY2lhdGUgaXQsIHRoYW5rcyENCg0KQ2hy
aXMNCg==

