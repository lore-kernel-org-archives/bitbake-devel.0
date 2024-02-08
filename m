Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D530FC48260
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 11:14:56 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web11.15594.1707390885888468902
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 03:14:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=A24C6gP1;
 spf=pass (domain: axis.com, ip: 40.107.22.61, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUVQAa7hsRs6DRA8pmDyN0eDgfl3Mqn73aW7CWf+UZdC01j1rVXLvZGTkWv8Q4QUGwktN92JHaNAwXLAeT0CjEABdC+jmTV2jQICZemncF/mR2to54gwRRIMr2vb1eedTlDpb0erOFgmlGQctQ9eowOb4KeHDm0vJe0kyMf3hGQOFYQ2F+xLbMkzMAJvKLUmCeE2o3CBg3QvXZlZfYyGHnBVKeWedROcGTxQs8Ut7ZAeYilHwa1D2QEFWsK/h4PNyUNNBRBrXmRFMsD/K6tMII5veRsuldh0zn9xux0aKwhxQBuXvPekxYNqSN+hP7eryyfeyS5FeturK/kUKdZlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY+LcNJ6pDLXG/mO0OryJX43TcvDpjpHmLcyGckcnw8=;
 b=gh+y8+wGNd3vhYyVpJ+7+dt8pMscryxcvA7RdZx02TB3wNREn11fspY8WTMZXJNlWTbPOYySv6yRkvg0NZ18yg0QBNKZdQw1PaaSz+n2IAKVw7gj+s33iZAexPn8f06MlLePOQMXTwSI2fvt7HyrHhk4c90xmLkR3HGbfHX7Jz4/Mg/yl/+aTTy56NEdfXdZfadpJFVF17zoQ/3/iXhhSmKCkyW+hHjQxCBuxKrhpypeBkSizoIGE2wpNGj0dvPzxibrNhXvGMQwylBn/KdVFP0VLaDMln06ZzWunjtZLoHXa11rXRkYXEkWUHJCdOima3IYtFALKepciqtNdBPb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY+LcNJ6pDLXG/mO0OryJX43TcvDpjpHmLcyGckcnw8=;
 b=A24C6gP1UgDXKDDQKwpJTbJlquaajNe7zLvP+giwGjggjiu2/pLs5Um/xM420yHGiLtad+ldc1gfPVXYdpWPo2QxajFcWhO9l1QQWWHQPaEXI9O858+f+sc2hfykvlnSbxlH2TXgK7TC9MQzAmj5dqwxZE8hYtZggfuPivZWBbA=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DB4PR02MB9597.eurprd02.prod.outlook.com (2603:10a6:10:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 11:14:42 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::5b1d:259f:4ba1:8906%2]) with mapi id 15.20.7249.027; Thu, 8 Feb 2024
 11:14:41 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Ross Burton <ross.burton@arm.com>, Alexander Kanavin
	<alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake-layers: add show-machines command
Thread-Topic: [bitbake-devel] [PATCH] bitbake-layers: add show-machines
 command
Thread-Index: AQHaWeoYbsIpT7k35U2wSUDfGvNis7D/SZyAgAD4UoCAAAm2YA==
Date: Thu, 8 Feb 2024 11:14:41 +0000
Message-ID: 
 <DB5PR02MB102132093EB30F98C3B01C064EF442@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240207172121.4044574-1-ross.burton@arm.com>
 <CANNYZj_vLSgRzA6EE5v0dccF8hs+DD3Gwxfs5ATCVGnszW++Nw@mail.gmail.com>
 <53F93B66-BBA4-4FFB-8550-D95AA14ED957@arm.com>
In-Reply-To: <53F93B66-BBA4-4FFB-8550-D95AA14ED957@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB4PR02MB9597:EE_
x-ms-office365-filtering-correlation-id: fea87121-8179-4dee-1dc3-08dc289725c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IzFTvpN4/fr/g+A/TX5hRpSHIAGNkvgzH2/LZ3wcAwyb/whzzFFgFJwMZTkKEbQ0b62HNvs/Q6gOt1id6KI8DrU98DcP44h3iQ9nmiRdnBFGX3KpBUba2095ZzjcQtFKXDZ5AlXByFxgt7BdfN7HSKWcYtWrsnY9NKIJgRYK5ie3QcTTD4L63E5Mb0TD+Zz6/D5tRMqVd1lxSEfjd2BNakB99al3ruWoQqNeV/qBZMt0Qf0QIRbpzaHZKAi++gU9IA5QlLPqo9PuhnLR3ACHwwrgPDFW2WPBdG+yOTLZ+FvyiaujR1dMM5MzYu230jDysDrmkPi3qGov4CA/PbXyC1l0OdtR52wKJSckEsjSnhbHKV0FVcusRsK6IleI1c0GocqYwfgBxUMPqNPDbmTGqlu/ymHjD9c7jpxjETKVaH2kx6JXAMJyyH9syw93wPCPBEHOI5RimKEwyv0d80509h1Y8yOx+VcswRdjoaEXzyBeasoKSMhqCoM2sz6XTFJHepzAdD+5tGtQsPzhFFVep7ao7kiR+oz/W0QZfkHskUGAgZVWpE8nG1Qb4vUPrR3yfdFEJDNX47Qu+PVvZdnroj6tZVzbt+RZNjhN1ked6Ig=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39850400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(122000001)(55016003)(53546011)(33656002)(83380400001)(38100700002)(6506007)(7696005)(86362001)(26005)(41300700001)(8936002)(52536014)(8676002)(9686003)(4326008)(71200400001)(478600001)(5660300002)(966005)(2906002)(66556008)(64756008)(66946007)(66446008)(66476007)(44832011)(76116006)(316002)(110136005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWtnMGpxTU9KTDYxK2xsRW02aXVmNkd1aU9QZGcvYUFmcDlLYVVFQUFJZUU3?=
 =?utf-8?B?TXhKbEF1ZS81c0UxaHo3M3dkUFVSL1M2eU13OUphcEhqWTNEQ3R3Z2QrN3Zu?=
 =?utf-8?B?d2RVZFFBQUdOQjdBK0R2RFJkNzFmZ3ZzRTRTSmxsK1BqbEtMbjJ0ZDQ3N3Az?=
 =?utf-8?B?RUI4SEVvd1A0ZVk4VFRZOWpwODBzWlVXM3YzOXRFZGZQcjVBeHNMMDBYQ2l5?=
 =?utf-8?B?cmxSNVYrUHprMlZwd1RUTHh3Ly8rNHFyUlF5YTcxRGlSZ1d5eFhWOXFwNTFk?=
 =?utf-8?B?TEFzQkhYQjRmYlAxWmFRYmtSam5SRVJNWXhaRllKOUFYYWFxQWcrVlBWdjh5?=
 =?utf-8?B?SkI4cjBINXUyU0UwQTJNY0t4R2lLcGlCSEJPREtWbkVuWnY3VlhUOVRUWUpq?=
 =?utf-8?B?R0M0aklMZ242V3Vic0JpUkl4d2Q2SWE3VStIQkY5cG5QL01QMVJBZTJhdGZ1?=
 =?utf-8?B?SU01MWxNZVpRSm9yTFRoWlB5dS92MkV4NEFIemVpaUhZdWkwb25DWmd6N0Jm?=
 =?utf-8?B?c0ovSC9lajBlYkNqVWZZWXpOVEpIN3c1Rjg0VmpvTEZHM21VVnVBc3ptY1NH?=
 =?utf-8?B?Z2dNS01Pd3VybDdNaTY1bDQ4dkZyU2tiUGUrbVRhNWlqdkRpRUJFb0VqelJB?=
 =?utf-8?B?NnpMZmNINXRpZ0xxS042Z2dRUkhLejRDSm1udTB5R0VwWklDakdvSm9vaG9N?=
 =?utf-8?B?ejZLUzEvNEI2QjFxbW80aXpLM3ljRGRzRlB1TXNod2dMVEthUU51NDZON0tm?=
 =?utf-8?B?K2hTUHRCcHh3bWI2UG9odHljYVNYdi90QTAweDB2OTd4b05wZHREYlhtVlhD?=
 =?utf-8?B?UFJzUkhZenVtRGExT0dYb2xEcDZabXd5MFk5cE12RHpzQk9sOVpjSnUrZDM4?=
 =?utf-8?B?RzJwdE1LalFEb2duc2JmdnRSNjBmdlRRUWJYMHBBMnQ2UFFoVkRCM2ZTcWdn?=
 =?utf-8?B?VnI2RkZRbUppQ0VsWnBFenIwT2pIeGZsWVgxQ0tvcHh6SWJnUXpxQjhubnhJ?=
 =?utf-8?B?c3h5b0JDMzc1Z3E2OHhqWXRmY3ZseUF5cUloYlc0Y0dJNEVqOGVnTWN3cW1G?=
 =?utf-8?B?YStsR1czdFF0b0haaVFEeWZNU0RJWUxUL3NlUFJ2MWhvOUZoZFFHSkxSUU9X?=
 =?utf-8?B?djN1TzRHRUwvSXJJUVJUTFZRNHNyVnlnc0U3K21KNGloc0dVd01vMEhRVWd3?=
 =?utf-8?B?cWlJRnJkZEZCK3JaZzE5K045TmdVcTI3YXRFWDR6ZXlxa3cxd1hXRldKWTNQ?=
 =?utf-8?B?Vzd6UXhETmZsSnpoN0tKanFQbVVZTkFQc2lncHlndVRiTURzK3RLVDNyeEk1?=
 =?utf-8?B?aDd6d3hlb3dDRnRHNXRNWEdXUkNIeGFSTWFSdzB5blo3YW5EYjd1U1R6TXIv?=
 =?utf-8?B?ZVhmSkx5M2xYZVAwbkxnYXdZMkRtWkxUZFlML0U4ZWlBb1ZnN2V3cUVEZzdU?=
 =?utf-8?B?M2oyK3pvNGZrcjh0Tlo3eEtKVWdUUHRvUE9QOGxpOVhocW1rWWJUYXZEcG9I?=
 =?utf-8?B?clgxdUlPdWdZb1czK3M1UFFWYW95WkNYKzR6RkNTNmE1WVlGTDJReWxyQ2ZE?=
 =?utf-8?B?RkE4aFFrbHVPV29OYXhPbktES1UrL016NGc4T1F6bVpMbStXWXdKanVyWjRT?=
 =?utf-8?B?bTB4M0hIekJuMjNxbGQ1Rm1iQlBmdUJBMERHK1UrMkZsdW50NlJiSjh3azRa?=
 =?utf-8?B?YnJLL3oxZmIxNmRhcmQ5cWprWDFWTHZCUmFPY09oNDBuZTR1WUFsWUlQMTd6?=
 =?utf-8?B?NFMrSlZGU2lSeUZONzFoYURtVFdGVTJmTlVBblhrUGZHcUVCaWhPSVZGK0w4?=
 =?utf-8?B?c2JzWlNjRmw1U00xTWczUmFFU3QyRStydDh6VnlhNThKbm16NjRXMW9EOEsx?=
 =?utf-8?B?SVVReC9MelVqbzlLM3pJMTd3VFh1QU45bCtXWGpETnBXU2FqYkhxdU5aNVFs?=
 =?utf-8?B?TDduTE1icjBJdm9iWWxWMjB3QStTWlZlVGsxTHhnUVBnQlFzaFgrR3ovdGtU?=
 =?utf-8?B?S0ZQSEROQlpobktERW1CckVUeXBOUlVvdXRiN3dhMmxKZDJuSlN4WmtZbExi?=
 =?utf-8?B?YXZNK1YrNStVbkVBY1lieFYxREl5RTlUUnhSWTVmQTdYNkVLa0FJVXZKWDVO?=
 =?utf-8?Q?6hU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea87121-8179-4dee-1dc3-08dc289725c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 11:14:41.8425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1lrxwoSXIbD190DRfSUBEiIK5c9BvszYyYflMChOinbpxSMomz7l3MgPO3JiKNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9597
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 11:14:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15840

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtDQo+IGRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IE9uIEJlaGFsZiBPZiBSb3NzIEJ1cnRvbg0KPiBTZW50OiBkZW4gOCBmZWJydWFyaSAyMDI0
IDExOjM4DQo+IFRvOiBBbGV4YW5kZXIgS2FuYXZpbiA8YWxleC5rYW5hdmluQGdtYWlsLmNvbT4N
Cj4gQ2M6IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSF0gYml0YmFrZS1sYXllcnM6IGFkZCBzaG93LW1hY2hp
bmVzDQo+IGNvbW1hbmQNCj4gDQo+IE9uIDcgRmViIDIwMjQsIGF0IDE5OjQ5LCBBbGV4YW5kZXIg
S2FuYXZpbiB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiA8YWxleC5rYW5hdmluPWdtYWls
LmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiB3cm90ZToNCj4gPg0KPiA+IEkgaGF2ZSB0byBh
c2suIEhvdyB1c2VmdWwgaXMgdGhpcyByZWFsbHksIGlmIGl0J3MgYSBiYXJlIGxpc3Qgb2YgLmNv
bmYNCj4gPiBmaWxlcyB3aXRoIG5vIGhlbHAgZm9yIGNob29zaW5nIGZyb20gdGhlbT8NCj4gPg0K
PiA+IFNhbXBsZSBvdXRwdXQgOikNCj4gPiBodHRwczovL3d3dy5pcmNjbG91ZC5jb20vcGFzdGVi
aW4vM01tWU51QUQvDQo+IA0KPiBDb25zaWRlcmluZyBob3cgb2Z0ZW4gd2UgZ2V0IGFza2VkIOKA
nGhvdyBkbyBJIGxpc3QgdGhlIG1hY2hpbmVzIEkgY2FuIHBpY2sNCj4gZnJvbeKAnSwgaXTigJlz
IGZhaXJseSB1c2VmdWwgdG8gcGVvcGxlIHdobyBkb27igJl0IGtub3cgZXhhY3RseSB3aGVyZSB0
byBsb29rLg0KPiANCj4gQWxzbyBJ4oCZdmUgd3JpdHRlbiB0aGUgc2FtZSBzY3JpcHQgaW4gc2hl
bGwgb3IgcHl0aG9uIHJlcGVhdGVkbHkgdG8NCj4gYXV0b21hdGljYWxseSBidWlsZCBmb3IgYWxs
IGF2YWlsYWJsZSBtYWNoaW5lcy4NCj4gDQo+IE1hbnkgbWFjaGluZSBjb25maWd1cmF0aW9uIGFs
cmVhZHkgaGF2ZSBtYWNoaW5lLXJlYWRhYmxlIGNvbW1lbnRzIHNvIHRoYXQNCj4gY291bGQgYmUg
ZXh0cmFjdGVkIGFuZCBkaXNwbGF5ZWQuDQo+IA0KPiBSb3NzDQoNCkluY2x1ZGluZyB0aGUgY29u
dGVudHMgb2YgI0BOQU1FIGFuZCAjQERFU0NSSVBUSU9OIHdvdWxkIGRlZmluaXRlbHkgbWFrZSB0
aGUgDQpjb21tYW5kIG1vcmUgdXNlZnVsLg0KDQovL1BldGVyDQoNCg==

