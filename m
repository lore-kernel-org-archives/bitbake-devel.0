Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E19C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 12:05:06 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.85])
 by mx.groups.io with SMTP id smtpd.web10.21181.1701432299141879116
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 04:04:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fVf3kb+R;
 spf=pass (domain: siemens.com, ip: 40.107.105.85, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te53q+D7GJVahIIt7E3d/oioO9BK5y1QUyIY07E8OKqNL/srZMS0YW5qzvT6mud4naV2NsFxDLHtU7R8T4bn75jyXx2YI/3mJgxVM76JhteSqFhba23PkU6LsSqvlUvFfR7KlC22c7fnetSTa2gHjCdx9ppHy/+iVnWvcSGxs3oNq+eb6MPnQlLvUoi5TfPNpX1QVey3zlISo015xEoXZ1sCuGQX8aVCxzoofeslCQnOIWdQNnyyGt1+ey4fcfwG3iX/ju0P2hpclzdcDi69CEbZy+oqWO8xP+g42bdPBsf0tW0JFrkEH/tTWuWROXpUj93femE2HMW3KLRPAFPhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyTUABeXewouPgxKzP0CsT+/psHIqdSuA2PRMGytIgo=;
 b=PnbpA2jgP73YiTm0z8SNct7Z7VPdc+3zNskJTE7lFGFBsBGpz3ULdYSIX93UAvfIiN99hs1bCRGVH2RW2lJq4QqnB22lMcjRoknRKLODIvg5oTFogXrb9tVxTnDSUWC6FyyfghnNF2qWkGSWXfvBUU1ps+vvAH6Lr9RTuwjTO5wHaHm9BmcLJeERUb0I5p9Waiz6fQS2nxVdtmM/oBvMX3xZgIxHUCr7KzYv4y70tH9aivUu9JOhDZQI7fPWoYREykp4rR77MEnIDv34FdoEvqzCNMt8+ArE2krHhClb385WRHIVhvyMG2WqiJ7uClkNSxC2/cXo1jxEPvChbn7UHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyTUABeXewouPgxKzP0CsT+/psHIqdSuA2PRMGytIgo=;
 b=fVf3kb+RVvO6DCPQfy78XdNlwp8ZTVU0RFUJ1FPfqMGENcnUJmpCqDwEOHIE06dGefp3AQynXIqiLggKnrfQ36l5n0rzvTWqUfRlipqzkWrTbe5pTc2mnJ8CgyqnVJw1FJvFDC1VkRftEZF0XdGf3czG999y+uYGVeDSIhEKMi/jroia/bOVlfgaq6JMMhlqltl6s9v2Zb75VGx4Hma9/zMk8zkc9xJuzHH9j901JzMIF2l99Jc+c48ByY2HCSuNXN4ymMsMKhaLS7lFHXKgpme4SZ44jtql54QGgfVBvNqi1Ozzebl/ChX6NgGjYDivAyU/mS4/NCCl3HM3rgjwPg==
Received: from DU6P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::11)
 by PAVPR10MB7186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:314::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 12:04:55 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::9) by DU6P191CA0001.outlook.office365.com
 (2603:10a6:10:540::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 12:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 12:04:55 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 1 Dec 2023 13:04:53 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 20:04:50 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.035; Fri, 1 Dec 2023 20:04:50 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "enrico.scholz@sigma-chemnitz.de"
	<enrico.scholz@sigma-chemnitz.de>
Subject: Re: AUTOREV, PREMIRRORS and unavailable upstream
Thread-Topic: AUTOREV, PREMIRRORS and unavailable upstream
Thread-Index: AQHaJE6V4kdaERLNoUar2ij7ZLZcZQ==
Date: Fri, 1 Dec 2023 12:04:49 +0000
Message-ID: <513a7d673eb8cdff5cc8ae0c5717ea3e81349da3.camel@siemens.com>
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
	 <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org>
In-Reply-To: <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5417F07D0A67574A9953C7895949D23A@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|PAVPR10MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 650de1d3-82fc-49aa-99a7-08dbf265bba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HLcqjGbRr9iCaNcXdFEhf7re/sFiqAmkmeAQGZ68gQWJP7zvyUAX/3TG4cAAa/6IdUw5NkV4i8OB7XlX6uANBl+ewZKtAPpG6cXSaxHC85MZvCXfZD8jiRds8EHjQ22pE+3LSfUe15WbC0D63ZpLvECN5SaIiDbHB44RAJEH0aJ0awfmlEComxSaZT+7mjn02BvW/8hZtl62cxSJDcyzIpafD7IeE0VMj1/v9JP/CBC5ij2FOGide/tQCZGa+AvXcUOYEB90FLrvLBGRjQMmiEsnqCBxScuAXHSwOtU1L1/vfhAQ+QaKV3Nd5J/NRhLLnJnPmMYpk1DuoJoGbl7gTPZaKVb5rnL9WDsv1TwmpYrBMMcCtj+GThy5Uql7xKmBX+wh235d7MdgiP+s41iZaZ9/yiXxcnm4rucLzr461uP/z/OkzrIjAPMviFk2Wmv/734sf29J+BSfIifel0PzrnrQ2t8SRbLt9Mi1r2eD8y0TQZl3k/gjsju1ZTTw1z8WFCLoH54DRPRh/fuyfc3oXbILznxPT22cqoT8vOVJ5HcDLo/whravGB6XIhLSJJYgQ0SYyc9K3+/Ss3F33B3ScvdWTRxTFmIyJ2sCU9cc4Pvc/tjt5I/CH5QgPjo4zI3M7+ebAKuf+OAD6jzZaReSMUxBGSx1uLGkPe5A2K+udCExmlLaUHykyLCB3QV3JpT+xMPDhT2mfUpb6bHp+S8r87n/UZsE2zgjeeebgcwGYSPawhH3+AC52HuctDTbC1Kr
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(956004)(26005)(8676002)(47076005)(36860700001)(83380400001)(41300700001)(2616005)(8936002)(2906002)(966005)(110136005)(478600001)(5660300002)(316002)(70206006)(86362001)(82960400001)(70586007)(356005)(36756003)(336012)(82740400003)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 12:04:55.6021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 650de1d3-82fc-49aa-99a7-08dbf265bba4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 12:05:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15599

T24gRnJpLCAyMDIzLTEyLTAxIGF0IDA4OjI3ICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gRnJpLCAyMDIzLTEyLTAxIGF0IDEyOjE2ICswODAwLCBKYW4gS2lzemthIHdyb3RlOg0K
PiA+IEhpIGFsbCwNCj4gPiANCj4gPiB0aGlzIHRvcGljIGhhcyBiZWVuIGRpc2N1c3NlZCBhbHJl
YWR5IGxvbmcgdGltZSBhZ28gWzFdLCBidXQgSQ0KPiA+IGRvbid0DQo+ID4gZmluZCBhIGNvbmNs
dXNpb24gdGhhdCBoZWxwcyB3aGVuIHRoZSBvcmlnaW5hbCBzZXJ2ZXIgaXMNCj4gPiB1bmF2YWls
YWJsZQ0KPiA+IChsaWtlIGdpdGh1Yi5jb20gZm9yIG1lIHJpZ2h0IG5vdyB3aGlsZSBzdGF5aW5n
IGluIENoaW5hKS4gV2hhdCBpcw0KPiA+IHRoZQ0KPiA+IHJpZ2h0IGFuc3dlciB0byB0aGlzPw0K
PiA+IA0KPiA+IEphbg0KPiA+IA0KPiA+IFsxXSBodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5v
cmcvZy9iaXRiYWtlLWRldmVsL3RvcGljLzcyMTEyMjMwDQo+IA0KPiANCj4gQVVUT1JFViBpcyBk
ZWZpbmVkIGFzICJnZXQgdGhlIGxhdGVzdCB1cHN0cmVhbSBmcm9tIHRoZSBTUkNfVVJJIi4NCj4g
VXNpbmcNCj4gbWlycm9ycyB3b3VsZCBtYWtlIGl0IGluY29uc2lzdGVudC4gSWYgeW91IHdhbnQg
dG8gbWFrZSBpdCB3b3JrIHdpdGgNCj4gYQ0KPiBtaXJyb3IsIHlvdSBuZWVkIHRvIHBvaW50IGl0
IHNwZWNpZmljYWxseSBhdCB0aGUgbWlycm9yLiBUaGVyZSBpcyBubw0KPiBndWFyYW50ZWUgdGhh
dCBhbnkgZ2l2ZW4gbWlycm9yIGhhcyB0aGUgImxhdGVzdCIgcmV2aXNpb24uIFlQJ3Mgb3duDQo+
IG1pcnJvcnMgd2lsbCBvbmx5IHVwZGF0ZSB0byBwdWxsIGluIG5ldyBjaGFuZ2VzIHdoZW4gc29t
ZXRoaW5nDQo+IHJlZmVyZW5jZXMgdGhlbS4NCg0KSGksDQoNCnRoZXJlIGFyZSBtb3JlIGNhc2Vz
IHdoZXJlIGRpcmVjdCBhY2Nlc3MgdG8gdXBzdHJlYW0gcHJvamVjdHMgaXMgbm90DQpwb3NzaWJs
ZS4gU2ltcGx5IGNvbnNpZGVyIGFpcmdhcHBlZCBlbnZpcm9ubWVudHMgd2hlcmUgYWxsIHJlc291
cmNlcw0KYXJlIGFjY2Vzc2VkIHZpYSBsb2NhbCBtaXJyb3JzLiBJJ20gYWxzbyBhIGJpdCBza2Vw
dGljIGFib3V0IHRoZQ0KZGVmaW5pdGlvbiBvZiAibGF0ZXN0Ii4gR2l0IGJ5IGl0c2VsZiBpcyBh
IGRlY2VudHJhbGl6ZWQgVkNTLCBtZWFuaW5nDQp0aGF0IHRoZXJlIGlzIG5vICJnbG9iYWwiIGxh
dGVzdCwgYnV0IGp1c3QgImxhdGVzdCIgcmV2aXNpb25zIG9mIGENCmxvY2FsIGNvcHkgKGluIGNv
bnRyYXN0IHRvIGUuZy4gU1ZOKS4gVGhlc2UgY29waWVzIGFyZSBqdXN0IGV2ZW50dWFsbHkNCmNv
bnNpc3RlbnQuDQo+IA0KPiBUaGUgY3VycmVudCBjb2RlIGRvZXMgd29yayBjb3JyZWN0bHkgYnkg
b3VyIGRlZmluaXRpb25zIGV2ZW4gaWYgaXQNCj4gZG9lc24ndCBkbyB3aGF0IHlvdSB3YW50L25l
ZWQgcmlnaHQgbm93Lg0KDQpXb3VsZCBpdCBpbiBwcmluY2lwbGUgYmUgcG9zc2libGUgdG8gZWl0
aGVyIGNoYW5nZSB0aGUgZGVmaW5pdGlvbiwgb3INCmF0IGxlYXN0IG1ha2UgdGhpcyBjb25maWd1
cmFibGU/IFRoaXMgYmVoYXZpb3IgaXMgaW5kZWVkIHNvbWV0aW1lcyBhDQpzaG93c3RvcHBlciBv
ciBhdCBsZWFzdCBhIGh1Z2UgcGFpbiBwb2ludC4NCg0KQmVzdCByZWdhcmRzLA0KRmVsaXgNCg0K
PiANCj4gQ2hlZXJzLA0KPiANCj4gUmljaGFyZA0KPiANCj4gDQo+IA0KPiANCj4gDQo+IA0KPiAN
Cj4gDQoNCg==

