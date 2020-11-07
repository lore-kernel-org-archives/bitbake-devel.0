Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.73])
 by mx.groups.io with SMTP id smtpd.web09.6458.1604713824002732184
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 17:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ohyLVZ1d;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.73, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpWGiqptGmvgtN1AGXs+4smKXriCAuS1sN+tp9892H+rMRNzHdbXq5NUpLTuBa1vNCizDPMn1xzoTpIyMU0N1SyEH1sYDRi72x2b/8Rxx5fuXz0T43kDROgyHp718Arg1bp0DmEM6SHSnmCQfrkBdtbUeipnkbgbH9sl/DIzThD9gtjiLmhuc0xWY19MHVgOwnTbtlaBHpf4azhnsBcSMQGVvqEWmi+OeKueDTibgTj3qdUmDoukKwIuJHuSQezAxD84YgCXjrL8I4A2R90WTOZYdkJjTwltmuNux7mcwaE32O0+GpJejed11viLKhpJU/IffhrVmaGH4HY0S7tt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncebkaBkV7VsEKToxKARDOG++iTI7FDWd4BxaerzQIg=;
 b=TkktkvGwPJIaIaHkPH/Bw+xDilYjzw2e/O7FzkF2RqIKbaoi29uGQwl393mX+ToZdOUrxfJuFEA0XLUvhwl37kwAhcl+8fFSPkYyjgAqWXKY+OKAy3fM9SbmYbfMtAPbkd/Ob9HXBvNA/6BgFWbo+2SAu5cPdtfQ2HpksdXNBCffT7RPyrI46ypqPqXl14nO6gVEdY+6G+rrPetqCl5r6L2LOvyFQOZGm9KAwUX5ghK4wjDdXALmvsZqMD3tfDjBaWNxCOhqE5K4o3uTmk1kG0yvB5AtucnrtDwJCyGWkwo97FvYgCyYQYpvKtqR9fecJZAU4OJXpQTOVxY4+EZTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncebkaBkV7VsEKToxKARDOG++iTI7FDWd4BxaerzQIg=;
 b=ohyLVZ1dsAEs7GJ31HciO08Z1EOHzbrbI4amjVHv+M4vNyNwSuSfzYAZsJtzhHA3d2+OVukLFdoQZZfr4TFN8g9jIjSan4+09ZYlndQbakza7HVCVrBqS1SujVdYFG4HQ2mJnnX1j5ddpmWve+kS4f++vMVn3ZYjkmlVbtgajSBbOkVBdTreAjFywUu2psDjKkunnQR9tBJ2ZzAfdeuMVoVTHEPdI5IEZLwdB5k+Drl0huN+DxUS4VFhzZtqJQQ65r63rmQDMtMzDX+YuDJFMsp82tpPcZ3AGZgZwaKq9kZXnOz3VPBFVmQRlHeNHsAgb7dSl/RQPvNbmH5xaMhtxA==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Sat, 7 Nov
 2020 01:50:22 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::5dc7:be80:e39f:5be1%3]) with mapi id 15.20.3541.022; Sat, 7 Nov 2020
 01:50:22 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] main: migrate from optparse to argparse
Thread-Topic: [bitbake-devel] [PATCH 3/3] main: migrate from optparse to
 argparse
Thread-Index: AQHWtEoTnM36S05q4Emn5NnXxk/Syqm70psAgAAVBFA=
Date: Sat, 7 Nov 2020 01:50:21 +0000
Message-ID: 
 <SN1PR12MB24803FFE65F5B9C58E1286E48BEC0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201106143457.81958-1-chris.laplante@agilent.com>
	 <20201106143457.81958-3-chris.laplante@agilent.com>
 <af501cd1ff6fd7422f44367bd9bdc53c81558fbd.camel@linuxfoundation.org>
In-Reply-To: 
 <af501cd1ff6fd7422f44367bd9bdc53c81558fbd.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9c33c0d-f9d7-4241-6c7e-08d882bf7d29
x-ms-traffictypediagnostic: SN1PR12MB2350:
x-microsoft-antispam-prvs: 
 <SN1PR12MB2350F8344BA61C362D71B9AA8BEC0@SN1PR12MB2350.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rh7ngPr4OT/MipdgLyDRWUT0WOLpRkT22GEFd5pmaLyiJ4iBd2ZTO/rYrbPKsme/VKO/QP3rcD40XIxubuQluYE1FR4FjUWffjTqnjcwGvFrARci0zwCXUi4eJ09J6JFDbteR/oTWdVPGUHLyFcGNPpkPdL7W9tdoyZxMhNdhbEjYmBXsW5ApVlJa6fEY70TBFumIlbrgjrDu+7Gdw3/8BdRZfBidaegSSkeKiw8EtPQnW49b/cMvh0DcSPb1VG0pvXOU0fH0/nkhHF0G/aEPDBgFB5SLfrNZ81mxmvoZXPL30+yO5/jrlelYh2RgO8zaPdrJNG9rTh++bzz2VT0fyT9cKoYd2OQ3FlUrC49dlzpz/tY/+WeTvDF23ezcLw71PtH+EB4jFgFEaNh9/CyTytivRNE0dipc9qgYyRI58mX08QSO4+Bwa+aUEdssOGn75+yoava+50eHCUipAKRiw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(29502001)(55016002)(9686003)(316002)(110136005)(2906002)(8676002)(52536014)(45080400002)(966005)(8936002)(478600001)(5660300002)(66946007)(66556008)(66446008)(64756008)(66476007)(26005)(186003)(76116006)(33656002)(86362001)(4744005)(7696005)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 b30AURVWckTG1v/n5Ejfx7FA4mDMKW54lRlB/Jze0jYjAPwe8yonbnfEBBlv8gIMMyRClYm98wltYvMO47bWAq9sz19n1WXyVZdX6gb1bf+Me6aAesa3S0Wj/RuQpHeYw76BjJ1WKhQjLTOTewYIii5YtmKArs5XqhY2zmzLojz8aAK4TfGItVTbKJHMgiM6bEHnuksmNhch1r0NlhUx4pNMIEc0adlo3rVveL+Cqc/2xotqdkrH2MwGx0zvJMfKUdLi4h7aLA0UZNLeZ4wGVa0Y3UaeMhyPBAFCL/GRYSPHtvCDAzZnp+CnAQ6BMP+kvsIBSZ2I6U+v7lsh6vHVO3UPf0vdSFGQlQFZee7to69VFA4OcYBILwAcV/wSAWQcMzgIhYgMcv1kNIU9H+YvArd/vZWOdfovUm1x/k9JVXTh1mEy1dqoZ4D7HdetwdvdbTtXSaax6VMKbPM84ZaZFn62WV6B7JS0ooCamNifpY19etClvIcKsI71uq6pc+8y5qS8U86FL3zva3Zgplq/S2QiEpK0HyBVI4HTb4iH4th2LuYJKAevs83byRmlGI7iC/KHJSMnpS4veAtjitfErEQEr+exszdZF/Dz6+shgE8dwG01MfPBBoY7j+XllM8yDC7ivo5DZeOSAHjMkINGGQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c33c0d-f9d7-4241-6c7e-08d882bf7d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2020 01:50:22.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lgll3v2y4ZvBlwiGhXfuq/InyNABr6IrDWzb5wlrdEEUDXc/vQs15SWALP9S0DAmYWp78NvWxUBFtL0cwx8CFJcPbh6AGnyoxMwbWEXwUjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBJbiB0ZXN0aW5nIGl0IHNlZW1zICJiaXRiYWtlIHdvcmxkIiBubyBsb25nZXIgd29ya3M/DQo+
IA0KPiAoZS5nLg0KPiBodHRwczovL25hbTEyLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZhdXRvDQo+IGJ1aWxkZXIueW9jdG9wcm9qZWN0Lm9yZyUy
RnR5cGhvb24lMkYlMjMlMkZidWlsZGVycyUyRjM5JTJGYnVpbGRzJTINCj4gRjI2ODMmYW1wO2Rh
dGE9MDQlN0MwMSU3Q2NocmlzLmxhcGxhbnRlJTQwYWdpbGVudC5jb20lN0MyODIxZmRkOGUNCj4g
N2Q1NDk2MTIzYmUwOGQ4ODJiNGJkMDElN0NhOWMwYmMwOThiNDY0MjA2OTM1MTJiYTEyZmI0YTVj
MCU3QzANCj4gJTdDMCU3QzYzNzQwMzA2MDA2MTI1NDM3NiU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU0NCj4gQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMTAwDQo+IDAmYW1wO3NkYXRhPTJla1Y2RFJWJTJGQlpxREFOMzdj
V05JY1lZVngyRE1XZFZCdnJ1Z1VxVFRtYyUNCj4gM0QmYW1wO3Jlc2VydmVkPTApDQoNCg0KSG1t
IGZvciBzb21lIHJlYXNvbiBhcmdwYXJzZSBpcyBjaG9raW5nIG9uICdiaXRiYWtlIC1TIG5vbmUg
d29ybGQnLiAgIFRob3VnaCAnYml0YmFrZSB3b3JsZCAtUyBub25lJyB3b3JrcyBmaW5lLg0KDQpT
b3JyeSBhYm91dCB0aGlzLiBJIHdpbGwgaW52ZXN0aWdhdGUuDQoNCkNocmlzDQo=
