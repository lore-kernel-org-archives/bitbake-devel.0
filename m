Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F59C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 12:29:36 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.87])
 by mx.groups.io with SMTP id smtpd.web11.21386.1701433768473403986
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 04:29:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ACiTsNV5;
 spf=pass (domain: siemens.com, ip: 40.107.15.87, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9QO4qHPiBZ/LLfFBrskakoGAFY1k0uPLN1OVHXGOiVG+KZEEAc2o5BbYhuQmKbgJo2ar4g7kEJFu66efDoQ7y/hhEDIV/SIpZn1CaTVf0BL5k0nyMePVvgfVVhfFTv9D+NvE8k0WlCBeHREsrg3jRSz/t2KMLSq0biB4iESVGw6MDFiK8G82KUV2nXsjLSWwPO40kwcMyiS8JW4spn4Bp0sWJrxlXijN5fb2EQnUGZ8mLm1DS3ep/tAHOCerzdIc8uTNMxWshX3olXdENdlyZC3j5cFeNyyp//kvZ89BzC5tdKeVBgj3UQRLjVV89O5qEt0SW0MtJzR9t49HF+elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MveUgqnotKS33qd4IXT6ajYDTlG588AwqN1QdRxUgE=;
 b=JsUXMoAqKOCcd82RNt4BP2+/eL6lTkJkNf16Rt4ixg78+bzOll7lDjnTdzqD5vpG7MzyUb2WRmRAQnZ+LfybCQqkhI+CiXjZvu0htbJTntE2E4kmL9FaHRRtGkHOlD3PBGDCWyk+kqgjz+0hFPT0SZm60sF2xB4Jbg1RmepmLEKhX0akG2DB3sxfIPiT6N3PhBKmQ7M4A6wL7LACBA9JHEZRkl1BHGS1QRDbyC34MSS+z7bvKMdcU403Z9aaYS6GTb/lCt423OqAGR0qKDvIiJCgiummw83xS9nTUPINUWDKYUIAOhoWZUs9VdGprmBYsCkhZMGIQTU+0Z9w97oKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MveUgqnotKS33qd4IXT6ajYDTlG588AwqN1QdRxUgE=;
 b=ACiTsNV51dkZOAr22gYn6+VcVmahDJO6v7H8tFAm8sbjaWIts3P+ju2B/gN2gKZx+1mtkarkr8gUdWEmXwMdKN6BnEzPVYDF/9x23/caPnjSO3jms6dBWEUEyTfvb94EBVzdBTomW999SfwePCgvlrsWb56QFCXct8cINx3AfSXk2U+xNLQDSQl0armOX/KedyNTV87Zm/VGKIVYAW144hkDzio+4dv7BUwm7uRaVOtnpV9btHteiJz7HYDaRGCjYTEMNMmEniDgyHC5Y3+Gb63BiRQW9JIchtRSJrUz+L60LFd2IraAY9brOF4lj5nOOoooE69xSOcoRXG/iTlilg==
Received: from AS4P191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::7)
 by AS8PR10MB8017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 12:29:25 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::71) by AS4P191CA0038.outlook.office365.com
 (2603:10a6:20b:657::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 12:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.74) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 12:29:25 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Dec 2023 13:29:24 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Dec 2023 20:29:22 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.035; Fri, 1 Dec 2023 20:29:22 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "enrico.scholz@sigma-chemnitz.de"
	<enrico.scholz@sigma-chemnitz.de>
Subject: Re: [bitbake-devel] AUTOREV, PREMIRRORS and unavailable upstream
Thread-Topic: [bitbake-devel] AUTOREV, PREMIRRORS and unavailable upstream
Thread-Index: AQHaJE6V4kdaERLNoUar2ij7ZLZcZbCT0XsAgAADyYA=
Date: Fri, 1 Dec 2023 12:29:21 +0000
Message-ID: <79097bd03a108ad216ee54df76629e820aec8566.camel@siemens.com>
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
	 <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org>
	 <513a7d673eb8cdff5cc8ae0c5717ea3e81349da3.camel@siemens.com>
	 <CANNYZj-7f=a9Bj2Ec83qS=vyCU10Wz2zdn-vqey0ThbHUjn=tA@mail.gmail.com>
In-Reply-To: <CANNYZj-7f=a9Bj2Ec83qS=vyCU10Wz2zdn-vqey0ThbHUjn=tA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8370475ABD2A846A60983647E919A03@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|AS8PR10MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: cedbf652-6abe-4996-eeca-08dbf26927af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d0N6wBCR5ZK6mkgK2N98iEp82C3e2Y2DfRLft41gBP16Ykhe7hNNlszsgF/4G8DAca67CtqCuNMNihQd+SvObQrqPp0zBl4e8b0NnrJSl4c6m+HFTskpx6822rYGv+1gE0Ix4aYYz8CDuKeWmF22NKO95I653GzU7Xaj6uQNpzZXRW7kaq4le+taU8QTq2/BW0tgk1JvcKZKzTAb1dp5i99lQf6RtQBuZ0/GCNdI/UQnhGPmhXM1af7sI/0uEjLsMlSdcqUb1q0vwQUOqA3NUjOJ80vehhxFn9KcyrWlYObO6Ys14Z2poDpLLIwOIi9rtU9fcvVuCKMAF+5Evr/zbTHC8dmVJBtSvzPSbyCFEDW+EUH5IbfZ9NNAIXJaM71qxcWigIT/MkKyoUMnSELslFcpSDTyVtOn23dTPa396kKkN5mkQl63wQfV2TFCmzfw32t6UwhaQin4bHR1g8RnMBp57Z6RTm9Bfh8LSSRXDh06fYfbBT61HgS/GvI91iRWEetQMhPbefj4MsZlliejuW3zKEzL/Pr+qEAN+wqw3fYtQnKZakzNVbDcQR1cvy8+TU/tSaQvcZ9c8/ZTfeL1tKeer3MTSTVadLnL36JlXpq60quCXUI1QgvOj0aHcznNLjWLQoTyuWbAxbVzs2BFSWpz/M7MiWlwlKtBBoXwRC4xBIyDjcX0GQ8aTTrLjNBtAx3GSr/GIslUNHJVywjlvtoGoaWSqaMaYLMcbpQ34xeeBooz54RcVTFS55S7MFGuq9fAkw8KrCZ2BCxilyLigGEGdMkxtbuz7ngBBMrBcVA=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(26005)(36860700001)(47076005)(7636003)(356005)(7596003)(316002)(70586007)(54906003)(6916009)(40480700001)(336012)(70206006)(36756003)(2616005)(956004)(82960400001)(83380400001)(82740400003)(41300700001)(2906002)(478600001)(86362001)(8676002)(8936002)(4326008)(5660300002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 12:29:25.3917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedbf652-6abe-4996-eeca-08dbf26927af
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8017
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 12:29:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15601

T24gRnJpLCAyMDIzLTEyLTAxIGF0IDEzOjE1ICswMTAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gT24gRnJpLCAxIERlYyAyMDIzIGF0IDEzOjA1LCBGZWxpeCBNb2Vzc2JhdWVyIHZpYQ0K
PiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IDxmZWxpeC5tb2Vzc2JhdWVyPXNpZW1lbnMuY29t
QGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc+IHdyb3RlOg0KPiA+IHRoZXJlIGFyZSBtb3JlIGNhc2Vz
IHdoZXJlIGRpcmVjdCBhY2Nlc3MgdG8gdXBzdHJlYW0gcHJvamVjdHMgaXMNCj4gPiBub3QNCj4g
PiBwb3NzaWJsZS4gU2ltcGx5IGNvbnNpZGVyIGFpcmdhcHBlZCBlbnZpcm9ubWVudHMgd2hlcmUg
YWxsDQo+ID4gcmVzb3VyY2VzDQo+ID4gYXJlIGFjY2Vzc2VkIHZpYSBsb2NhbCBtaXJyb3JzLiBJ
J20gYWxzbyBhIGJpdCBza2VwdGljIGFib3V0IHRoZQ0KPiA+IGRlZmluaXRpb24gb2YgImxhdGVz
dCIuIEdpdCBieSBpdHNlbGYgaXMgYSBkZWNlbnRyYWxpemVkIFZDUywNCj4gPiBtZWFuaW5nDQo+
ID4gdGhhdCB0aGVyZSBpcyBubyAiZ2xvYmFsIiBsYXRlc3QsIGJ1dCBqdXN0ICJsYXRlc3QiIHJl
dmlzaW9ucyBvZiBhDQo+ID4gbG9jYWwgY29weSAoaW4gY29udHJhc3QgdG8gZS5nLiBTVk4pLiBU
aGVzZSBjb3BpZXMgYXJlIGp1c3QNCj4gPiBldmVudHVhbGx5DQo+ID4gY29uc2lzdGVudC4NCj4g
DQo+IFBlcmhhcHMgd2UgbmVlZCB0byBzdGVwIGJhY2sgYW5kIGNvbnNpZGVyIHRoZSByZWFzb25z
IGZvciB1c2luZw0KPiBBVVRPUkVWIGluIGFuIGFpcmdhcHBlZCBlbnZpcm9ubWVudC4gV2hhdCBh
cmUgdGhleT8gUGVyaGFwcyB5b3UgY2FuDQo+IHJlcGxhY2UgQVVUT1JFViB3aXRoIGV4dGVybmFs
IHRvb2wgdGhhdCB1cGRhdGVzIFNSQ1JFViBpbiB0aGUNCj4gcmVjaXBlcz8NCg0KSSdtIGFueXdh
eXMgbm90IGEgZmFuIG9mIEFVVE9SRVYsIGFzIGl0IGlzIHRvbyBtdWNoIG1hZ2ljIGFuZCBzb21l
aG93DQp1bnByZWRpY3RhYmxlLiBIb3dldmVyIEkgY2Fubm90IGVhc2lseSBjaGFuZ2UgdXBzdHJl
YW0gbGF5ZXJzICh3aXRoIGENCnJlYXNvbmFibGUgZWZmb3J0KS4gQnkgdGhhdCwgSSBtaWdodCBl
bmQgdXAgd2l0aCBjb21iaW5hdGlvbnMgb2YgYW4NCmlzb2xhdGVkIGJ1aWxkIHdoZXJlIHN0aWxs
IGF1dG9yZXZzIGFyZSBpbiB1c2UuDQoNCk1heWJlIEkgd2FzIGEgYml0IHRvbyBpbXByZWNpc2Ug
YWJvdXQgdGhlIGFpcmdhcHBlZCBlbnZpcm9ubWVudHM6IEkgd2FzDQpyZWZlcnJpbmcgdG8gZW52
aXJvbm1lbnRzIHdoZXJlIGZyb20gdGltZSB0byB0aW1lIG5vIGRpcmVjdCBhY2Nlc3MgdG8NCnVw
c3RyZWFtIGlzIHBvc3NpYmxlLiBJbiB0aGUgZW5kLCB0aGlzIGlzIGFsc28gYSBzdXBwbHkgY2hh
aW4NCnJlc2lsaWVuY2UgdG9waWM6IFVwc3RyZWFtIHJlc291cmNlcyB3aWxsIG5vdCBhbHdheXMg
YmUgYXZhaWxhYmxlIChkdWUNCnRvIG1haW50ZW5hbmNlLCBuZXR3b3JrIGlzc3Vlcywgc3BvcmFk
aWMgZmlsdGVyaW5nIG9uIGNvcnBvcmF0ZQ0KbmV0d29ya3MgLSB5ZXMsIHRoYXQncyBiYWQgYnV0
IGRhaWx5IGJ1c2luZXNzLCAuLi4pLiBJbiB0aGUgZW5kLCB3ZQ0Kd2FudCB0byBoYXZlIGEgcmVz
aWxpZW50IGJ1aWxkIHRoYXQgaXMgbm90IHN1c2NlcHRpYmxlIHRvIHRoZXNlIHNpbmdsZQ0KcG9p
bnRzIG9mIGZhaWx1cmUuDQoNCkFuZCBpbiBhZGRpdGlvbiwgaXQgYmxvY2tzIGFsbCB1c2VycyBm
cm9tIGxvY2F0aW9ucyB3aGVyZSBkaXJlY3QgYWNjZXNzDQp0byBhbiB1cHN0cmVhbSByZXNvdXJj
ZSBpcyBub3QgcG9zc2libGUsIGUuZy4gZHVlIHRvIHdlbGwta25vd24NCnJlYXNvbnMuDQoNCkZl
bGl4DQoNCj4gDQo+IEFsZXgNCg0K

