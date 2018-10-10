Return-Path: <Edmund.Nadolski@microsoft.com>
X-Greylist: delayed 15489 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 11 Oct 2018 00:50:23 UTC
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-by2nam01on0129.outbound.protection.outlook.com [104.47.34.129])
	by mail.openembedded.org (Postfix) with ESMTP id 60C5879A16
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Oct 2018 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=feQ1f5YKcYIx61HCk+JlIHR/b254AAvaNGw+Yf6wDL4=;
	b=XItBNBzenb8KrIHva7V1rnshjSFxh7czyW9uB4heshAUPSBFHFE5GMLNzTzDLi4rjRIutaPFyN6pjQn5uE/0GcWKv8lp8krMsNsUUzJL2DeTBmrdJhwI1ZApsMpWgmGIeGEIfHitKr6/BpRoQ8w6c9JtmRTTPnyp5RtIRrTt8fw=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (52.132.128.16) by
	DM5PR2101MB0808.namprd21.prod.outlook.com (10.167.110.156) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.6; Wed, 10 Oct 2018 20:16:25 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
	([fe80::75f7:82ad:3336:8ac2]) by
	DM5PR2101MB1047.namprd21.prod.outlook.com
	([fe80::75f7:82ad:3336:8ac2%3]) with mapi id 15.20.1228.011;
	Wed, 10 Oct 2018 20:16:24 +0000
From: Edmund Nadolski <Edmund.Nadolski@microsoft.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: git repo directory naming?
Thread-Index: AdRg1G96iupX0c1uRvi1/O6w5DKxLw==
Date: Wed, 10 Oct 2018 20:16:24 +0000
Message-ID: <DM5PR2101MB1047F9ECE058FEAB420714AEE5E00@DM5PR2101MB1047.namprd21.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=ednadols@microsoft.com;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-10T20:16:23.2026509Z;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft
	Azure Information Protection;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
	Sensitivity=General
x-originating-ip: [2001:4898:80e8:f:949e:763:8d7e:3b42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0808;
	6:hopaljn8/G8TZC3OEeWGBLNpy8VC0Dt1G9OwUzXB46/KEy+wv8xawKTRu5x2S44doFnJPkMB8FWU8D0rF6DqqdU1bw5vPTAFf1dOtxB1nx2KmN4lC6/HwQF5omqz9tMBsjadZKRywa1RMmBDzMVRrQdDOmRHKrHKhOfFfc1Pxu/dK34QxD3oM+gMIVrgIvw1f1hl2E6qI0VBZcNVyUgBHxm2/RKcpdl9VGCXcIJJjzi4D9q4YevveQ7fINPOm4JYwLAI+3DpvkXi4vMZgy2j+5DGzdPyPFrF1D1kA4VwuruUZQOkL1qqxazM3jMKxtbAnTvFthJdc5pn8qC+T0VLyCkXiCQMMRUMA89RK+yE+et2Hrzx5bYHu979PLtTKL7e5iKBGJA0Pu+V6Co3jbxBNvDnGfcV9OedTIX8Nbh4yiDl7APK7cXcQ+LZk4eQJ/igK8znJbTEAP58GdfppFiWBg==;
	5:ZmcOeXozVL9IZ8RCbUgReN6hsCMl2PlbBwPgo4BuHR3fWzwHfQdwMLYnbqLpeOJzklegEwFFDsaezf4KTGI4TFZGJQO2q1n5ZbXuGLLK+dVr749EdOZgBBnq2UJWgC0t8n1avm5korX1byRZrRb27nDJieM4YDAw4cLutFv60vs=;
	7:9cqhBYlHNYV7+/6SYvUHrJCpfP1XTy2rAJWKNKfPvdyaa5GF/+pqxSExPqpjMn76RyMXu5JkaG1rXa22VaBlAIU1cdn20QEvm/HV2F0pqTs05U+dpyM2lyGgsCdkLVAqUIr3CdLwPx5c5iGQ/LQjJLll14NwYgif81+eRi1kqeHIkXKX7+7J4YBiRhirfU7lNoK/OWysahXLqWaCioxGgBTpzXr93F0Tu2imxvKQEw4hS5JvmbAF6zVwWliIjlXf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 88150736-8609-4f8b-1104-08d62eed40df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);
	SRVR:DM5PR2101MB0808; 
x-ms-traffictypediagnostic: DM5PR2101MB0808:
x-microsoft-antispam-prvs: <DM5PR2101MB08081CEBE9F6A7CAEC5852B3E5E00@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991055);
	SRVR:DM5PR2101MB0808; BCL:0; PCL:0; RULEID:;
	SRVR:DM5PR2101MB0808; 
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6346003)(33656002)(186003)(14444005)(3480700004)(74316002)(22452003)(102836004)(2900100001)(8936002)(14454004)(478600001)(256004)(55016002)(7696005)(53936002)(8676002)(81156014)(99286004)(25786009)(5640700003)(81166006)(8990500004)(71190400001)(71200400001)(6436002)(72206003)(305945005)(97736004)(2906002)(486006)(6506007)(2501003)(46003)(476003)(5250100002)(2351001)(105586002)(106356001)(316002)(5660300001)(10090500001)(86362001)(68736007)(9686003)(10290500003)(6116002)(7736002)(86612001)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0808;
	H:DM5PR2101MB1047.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
	permitted sender hosts)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Edmund.Nadolski@microsoft.com; 
x-microsoft-antispam-message-info: o0HkHkSRMUIjjyufTJiEUcg/TrVU4DRc89vyssf8chqdzeha6WZ6dgS8YsFkeLSWnqCdzFk7tV2HC6s+TtmVvWcCBfn81KJp5N6HhUM62KTvi1lrcSDwJOo+Agp/aF5CIF2p4JkzNgpHofcrug2pFnnZ0Uwb2GajRohb3Jq7v63pitlCO/InOX3CHEBQSPOSp51y2psQenAez0dK8syCXJwPRtOZc6OzDw6Q0SyBrdrKo20xG+iwfwDZelORMUQP5luwDhH8IbLxPmhRfoDvIKT7ASRqg06xjtPlcCA6puQ9+KD4bZb6pd55ZHTOcn6zvBQVL8LFpWXbK7fGFwuqHH5T4C5yIOrA1nnY745e8CE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88150736-8609-4f8b-1104-08d62eed40df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 20:16:24.9080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
X-Mailman-Approved-At: Sun, 14 Oct 2018 22:42:08 +0000
Subject: git repo directory naming?
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
X-List-Received-Date: Thu, 11 Oct 2018 00:50:24 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello list,

(I'm new to bitbake/yocto so this is my first question.)

In bitbake/lib/bb/fetch2/git.py I notice that bitbake uses the following to=
 generate a git repo directory name from a url:

gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.=
').replace('*', '.'))

Are there any ways (env vars?) that allow a git url to be mapped/translated=
 to a different gitsrcname?  Specifically, I am thinking of a case of a lon=
g url but the repo name length is limited to e.g. 64 characters.  Or is git=
srcname always per the above replacements?

TIA,
Ed



