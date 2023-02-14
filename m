Return-Path: <Joakim.Tjernlund@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72FC61DA4
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 14:22:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.67])
 by mx.groups.io with SMTP id smtpd.web11.7988.1676384530888649889
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 06:22:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector1 header.b=mpjfO5k3;
 spf=pass (domain: infinera.com, ip: 40.107.244.67, mailfrom: joakim.tjernlund@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoW8g713+9oJt+1P54S9qBG/1ih9VsZkLFuKI26Hheg7/WvsSgLYI4gKSq79HLW9/vr6X5h3g1uKl2gGSxDLGIwaLjLuYzj2hXDi82utRvnCWgy2aY8b15svW2xVNYanbdN2eTD67mg4iwNshVJlyZ4RIP0SFwXqzVC1jV8IVdzPIrdON6GzbvcXVJ6VSWM1E3L2MSp+g50JRx4vSQF4IWqer2WHj43/Bf5drJC0tkqzZfvqxgSxQwJDaLEt6BW/yfeZWFFJcYlH6yQVSMzpmTH7G/cDPWNZ/MqkRj6bIYj7ShKtVCtoEvywpQ7HqKMG0JBEMPhZ0wARI/0gxb2nNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNYzk5VBGQPzt6D2MJrdKnfjlgm8j57dlSH4wQsonL4=;
 b=lChtZEzPCGdG5Wd5SeuramMM8U7fudSl+1BZob4aZyPBubFuMzUX8ZMF9R1yl8kSGegBosS9zqtabiW9CH4qbSg0pJObhJ9GEwcIUdP/XZO54J3y+68JC9aTNlnM2MXps8dQIrjEt3XAEv9GNNg1dmWzKNetzU7cVMRylj6vdmNmG5eFP31YMkNsqJeY1ZK9SeG3/sUY0yYGlL3FHCOtfr7ifOUJ17cwqugTV8FghaAcp+VtElqmo2Tbj1aY8uoHP0KRbxrDAHiTCiNhw5+0RYzmNz6OqWJfhHfCMcrwryFe9APccmzCWkxYcWQSRxUO8Ibrt0myWSR7Y/BgE8qLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNYzk5VBGQPzt6D2MJrdKnfjlgm8j57dlSH4wQsonL4=;
 b=mpjfO5k3nzLaqa+iCpS0jxke4/sEtE3LQewY9IrP2C7EkERepA7u+zJRrDbyYo1HbnL/ohbo1ppGrYhXS/0PpbF92adTKOG6+TGyOsGnLiw2ch8j4TC/+WozhkT58P3WRWGzTmNOJxfx2S6wM5xnIOM3P3MlAcT9mn4bk/L85bFOLQQ2nhahU+302S2sjRkIiBA+g6kraog7W/CfnAY0vnD8GJb+HnQ3gBlK2bo0oEe4g8iDxk6R3qiE6+Hi/vwIgFvUuFeDhfgR2BLjXXhkGT2AR3Oc+sU0gIlzLy9BbxKSSqZmWoxIocVQLLgBVw4LD9B2aqce38JUxGIrDnrXtQ==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH8PR10MB6575.namprd10.prod.outlook.com (2603:10b6:510:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 14:22:07 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::84a6:e9c3:8c53:8369%8]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 14:22:07 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: kirkstone DEPEND problem
Thread-Topic: kirkstone DEPEND problem
Thread-Index: AQHZQHz/vCDk3+MvBUi910NR0enI/a7OfnQA
Date: Tue, 14 Feb 2023 14:22:07 +0000
Message-ID: <913e646320fa02fd174566d8bfc5ca04cae269a4.camel@infinera.com>
References: <50f86c1869166da73d083d3c2e86f112faa978b9.camel@infinera.com>
	 <0c4d7472e556e555ef57032d7af7a9377c05fbc7.camel@infinera.com>
In-Reply-To: <0c4d7472e556e555ef57032d7af7a9377c05fbc7.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|PH8PR10MB6575:EE_
x-ms-office365-filtering-correlation-id: f1426af7-459d-4c85-7918-08db0e96da81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YPCL4+a5q61BuZrMUD/8TBvZbW9my3IE5nVT45HbUI2NeRXSf5BFTGeK8bg2WZzV0G18wbeLtLarybnVrbF/ORT8Rj3NdJTlHov3ry/1ById/u+DhHLoFlFmSqd2A2qbXtFe+5dR4gw4Lczw1TW9rImDSPjUCq2thQQjChAWtk7IR333qQKBMTo9qCx5wiTsgQdPNdQzGRqppvYAaAuUvWDErtwcQvw5bWZASvDmxkpvcRDbRweFChkzodeD7JTskavNKn/VXjzXn2SLsXG5lXieyc4k0mMWMkzqKou1TAsz+Z44DlsStH9X9wq+cSsyY1mJK4qvI3onQXXL4YYUswxARJ6GF3/Qna2a7VxB4D9K5nOwZafldUsu7wwgbvPwfsvpO/ZI9sTheiQfCR+B/RYWcYjbCj/sjfSF29GWr2DK1tCtZhRLIt16gQPkjCQbKA/0zB51rygq6N5PNtYRQtPAVJSWFFJUIg6F31zx/ej4N6Jj5n7dZ4llAtZ7sSXQMvu9JCxTAYJuLnk5TquCErVB9AoggV70InhIEAa+86L5smuBN4L4zTOkso8o71oAfMmr3heQgVNrKSRhGrQaFmPfmqSGMVBYahqB5Pr9LvHoyogU9dw9IAXdBTA0iehTnDODNA52TDf7IPDZfoN+/rPjWh8xgG8JzGqvI+iPGkyy/Qt0Bd9smFIDnNhzz5RB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(3480700007)(186003)(6512007)(6506007)(2906002)(83380400001)(5660300002)(6916009)(38070700005)(8676002)(66476007)(64756008)(66446008)(66946007)(66556008)(2616005)(8936002)(36756003)(478600001)(76116006)(6486002)(41300700001)(38100700002)(122000001)(7116003)(91956017)(316002)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZEZqNXpIRGFRdEJqZTJOaDAxNE5PSlRDQXIwRFVicmtkamV6YkhNVmZZY2Ja?=
 =?utf-8?B?cmdnaWxncXJha3UzNnFPQ3pXQWREWldqLyt4UGVuRldua0wrQ1lFR2JFaEhz?=
 =?utf-8?B?TC9DV0V5VlZYOHNxOUZsdnFyRktEcU9sNjBiTFJMRGFjd3FtNUkyYXpBUFFM?=
 =?utf-8?B?SVZuaWFVb0hSRWlFT1o1TU9YSU5qNlRGYlc5R1kxTVVxNHl1T2pwOUhiY1Fj?=
 =?utf-8?B?c2FGZzlCa0NiVFcvZUZ4YW9udVA3WDMwc3QzRTdNcVFWdThhNFJqL3piUnhj?=
 =?utf-8?B?Rjk1MGpaSFlVZjlrV3l2S0hrS3RaSHdhbUpySzA0ZDRPTmhuVzVqWmFJN2Iw?=
 =?utf-8?B?YzM5L3pIU282ajlKa0tTekVjT1dFT2Yzek11L0doM1p6bVkrcDI3S0ZYV1ox?=
 =?utf-8?B?ZTdiZEp3MlBoRzZIY0pDc3djcmIzUVJrVjhEeEE5VFg4b0ZoVWQ4eGNRVnBC?=
 =?utf-8?B?K09LRy81MzNsMjFNWWZRaDllV1p0OHJVZm1hSnJ5QmJTb0pMdzNNUHA4SHoy?=
 =?utf-8?B?dXFVU1orQXlUb1RoaTJqZjI5bVUwOWZxMW5yOFNLM3ZOK1RkYTNzV2txY2lK?=
 =?utf-8?B?VUxLSTAyRndUOGdsb1NPd0hvTEpjdnF0YWpObGZWU1BmRlpwSFd3R0EzdjJk?=
 =?utf-8?B?c09jSytJTzRkTGxyMVZYSDV2WGx6VHlTOVl4R2J2b1lHKytQZkR4V1lqTEEy?=
 =?utf-8?B?d2tqZWhWU2JTeWhXdjE3U01Eczh0ZkVBdUtUaFVJU29yOEh1M2ttNWxDdmpa?=
 =?utf-8?B?eExSQUgwem9ld1VLemIwUFZ4OEdYdklPRERYTlU2K3JjMjMzU2VlcUtpQkRm?=
 =?utf-8?B?MWdrMHNYd0FSNWliQXFPVURXMUFVWUJJNHE5SEJIR1g2dDJNRHE4MGNLOXNN?=
 =?utf-8?B?MCtXQVpBeW5SUDlJZXJnYVJoRmhGelFCZzNYYUpxSmhGMEhXWEJkaVVObTFB?=
 =?utf-8?B?cE5nbTFKZFMwY0FXSkhjY3VnSEdKR3BjdEFuTFlrMG5SYUVpQWM2MnNSSlc1?=
 =?utf-8?B?RTI3a2s2V2tkUzdyM0JGdWNQeDVMTmQ0ck5sYkx6Qk1NZE5PdGNtMkRIU1BJ?=
 =?utf-8?B?amMwcTJiYUtXaXp0Um1LZVhyWUJKVFBQUlpIc3RLU2RvNnkxdkk5TkV6aUJh?=
 =?utf-8?B?S01tdEFvUGJWbURVVi9nQUJPN08wRTZjczNlNkluVUNacVprdTRjdDh0T0lO?=
 =?utf-8?B?NnFRdEdTWWNRUlI1MDJZakducWZKWVVuTWNSTHJaYUFJNXNHQjRKYVpuVC83?=
 =?utf-8?B?OTFGRElBUWJvZTcxdjU1NGtoYTlVYkxWdjRlVkJFenprSCs3S3VXTHNtMldP?=
 =?utf-8?B?Z1pRRFZadko4cFBEaFpXZVdRWkd3V0VZYUpuWTVwcDA4aVdTcFhaMUdpajM5?=
 =?utf-8?B?cFE4a09pZlNEdXF3dFRXcis0Wk9uL240dE1kcTZ0b0RzaUFIcFQwelZlT3ZM?=
 =?utf-8?B?WnZxT0YzVWF0TktCdFlaN0Rsb3dWTHZRVkZvRWRrOEQyVlQvTEgrNkdrdytr?=
 =?utf-8?B?eUw3NVF3OHg5by9OWDJZd3lrbklZRll2SFBZT2tGanVYcmxTTitwYlRTTVEv?=
 =?utf-8?B?QkREdzZkY3UyaUNsYlA2MGVBekR6WWNZRWQvQ3c0QXVqN2cwVEFNcWNPOTRK?=
 =?utf-8?B?WTF4ZVlSdERsdGR3dGdNRSs4S1FIRDNoL1ZmYVA0K1pYYlBKemIyU1h4SU5P?=
 =?utf-8?B?ZTg5c3hGcnpmb3NYa1B3RTBmZlAwQlRwcnhWWm8vQUpENmI1c1dqRlNGd01H?=
 =?utf-8?B?ZmV1b0ZoaVVhcDJUOVVtK2dmRUhzS2JHMmZQTmcreHRTd01wdDJxZmZldFZp?=
 =?utf-8?B?WUNUc1BUeVV4S25RVTRyMkwxWmFkNHNBZUNnZTIyUFZLUGtldkFPS0FFcG9G?=
 =?utf-8?B?cWY3cHNGUE12Rkt2Wm54ZU51bXZoMmo0b3lUN1Z4cURFYWRHOEpLdHN3cjRn?=
 =?utf-8?B?UVltQ2x0ODhQZHJSR2FNZFhEVyt6eFRwNTJxb250ZG92MEpON1lWZzNyU2tM?=
 =?utf-8?B?MTQwazBseG42Q2tWQWc5dnZSTGoveHBTQ2Q0Q1FyNmlLN0ZFSlZYQzNrQ0N3?=
 =?utf-8?B?Z1U5Wi9iUTFLMmpqZkNocG5wbVBTbGlja3VUc3J5bXEyaDFmMjVoYU9RM2pJ?=
 =?utf-8?B?VTg3eHRFWEcyazNMaUd0L0U2QXBqMksxVW1mT1JZQWdTbDlYNlR3cDEwc0RK?=
 =?utf-8?Q?nnTHN+0QTs54X4/wktXnEXFpFy7E2eo67WZ69gmgx3l4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE7167E1CD9BD54F832C59DF8CD9DE56@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1426af7-459d-4c85-7918-08db0e96da81
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 14:22:07.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atxD3X+pqXfIETn/nfP+fsUfyb1QaaawZua7JxzsEM2ceeAYNSsbdG9BIUPetXJZyS/tYXdGIRyF7LZnnFG0lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6575
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 14:22:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14409

T24gVHVlLCAyMDIzLTAyLTE0IGF0IDE1OjA2ICswMTAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBpbiBzd3VwZGF0ZS5pbmMgdGhlcmUgaXMNCj4gICAgIGRlcGVuZHMgPSBkLmdldFZhcign
REVQRU5EUycsIEZhbHNlKQ0KPiAgICAgcG4gPSBkLmdldFZhcignUE4nKQ0KPiAgICAgcmRlcGVu
ZHMgPSBkLmdldFZhcigiUkRFUEVORFM6JXMiICUgcG4pIG9yICIiDQo+IA0KPiAgICAgaWYgJ0NP
TkZJR19SRU1PVEVfSEFORExFUj15XG4nIGluIGZlYXR1cmVzOg0KPiAgICAgICAgIGRlcGVuZHMg
Kz0gJyB6ZXJvbXEnDQo+IA0KPiAgICAgaWYgJ0NPTkZJR19TU0xfSU1QTF9PUEVOU1NMPXlcbicg
aW4gZmVhdHVyZXM6DQo+ICAgICAgICAgZGVwZW5kcyArPSAnIG9wZW5zc2wnDQo+ICAgICBlbGlm
ICdDT05GSUdfU1NMX0lNUExfTUJFRFRMUz15XG4nIGluIGZlYXR1cmVzOg0KPiAgICAgICAgIGRl
cGVuZHMgKz0gJyBtYmVkdGxzJw0KPiAgICAgZWxpZiAnQ09ORklHX1NTTF9JTVBMX1dPTEZTU0w9
eVxuJyBpbiBmZWF0dXJlczoNCj4gICAgICAgICBkZXBlbmRzICs9ICcgd29sZnNzbCcNCj4gDQo+
ICAgICBpZiAnQ09ORklHX0pTT049eVxuJyBpbiBmZWF0dXJlczoNCj4gICAgICAgICBkZXBlbmRz
ICs9ICcganNvbi1jJw0KPiAuLi4uDQo+ICAgICBkLnNldFZhcignREVQRU5EUycsIGRlcGVuZHMp
DQo+ICAgICBkLnNldFZhcigiUkRFUEVORFM6JXMiICUgcG4sICsgcmRlcGVuZHMpDQo+IA0KPiBU
aGlzIGZhaWxzIHRvIHBpY2sgdXAgZGVwIGluIGRlcGVuZHMgdmFyaWFibGUsIGJ1dCBpZiBJIGNo
YW5nZSAnJyB0byAiIiBsaWtlIHNvDQo+ICAgIGRlcGVuZHMgKz0gIiBtYmVkdGxzIg0KPiB0aGVu
IHN3dXBkYXRlIGJ1aWxkcy4NCj4gDQo+IFRoaXMgd29ya2VkIGluIGR1bmZlbGwgc28gcGVyaGFw
cyBhIGJ1ZyBpIGtpcmtzdG9uZT8NCj4gDQo+ICAgSm9ja2UNCj4gDQoNCkNvcnJlY3Rpb24sIGJp
dGJha2Ugc3d1cGRhdGUgYnVpbGRzIGJ1dCBiaXRiYWtlIGxpYjMyLXN3dXBkYXRlIGRvZXMgbm90
Lg0KVG8gbWFrZSBsaWIzMi1zd3VwZGF0ZSBidWlsZCBJIGhhdmUgdG8gYWRkIGRlcHMgZGlyZWN0
bHkgdG8gREVQRU5EUyB2YXJpYWJsZToNCi1ERVBFTkRTICs9ICJsaWJjb25maWcgemxpYiINCitE
RVBFTkRTICs9ICJsaWJjb25maWcgemxpYiBsdWEgbXRkLXV0aWxzIG1iZWR0bHMiDQoNCiBKb2Nr
ZQ0K

