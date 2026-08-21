Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C40C5DF8C
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 17:27:02 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com (MW6PR02CU001.outbound.protection.outlook.com [52.101.48.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63.1787333220317643313
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 10:27:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=aTQZDTbY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.48.64, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR3L4S36uZZXGrRXk5VjeOaWq5SLYMJTfqd8L40LR2R6WxiNKgENviUMD55pmslDWUEGhdUb94aIBkqKFrpLnxjV51Jg3UjrqelNPP8QtyOJfie1d0+wtFUlYPTcWnNQnVW2E1a3PxKY2FQasog6c5XhKbGO0hrDbaY62G0JXzcXrzNuouVijSxEUP80edxDBRM9kdlfB0nM+uwquZVoDpaculWReAB0/AiBWPD6GPJF2Dhdzq5eYzfgZ+OQ1UfbvOnlSu5ogzLRjPyy605/izVX5k1lR6+MufGt/0pVKshJiuKAuVm9fbPrtxLaCFuAZ9ss18DrA6XQ3MrZ9jzWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESnLSCVS/3ToiZHE63KJnJixV334gvIlVDcaTR1tejo=;
 b=ZoplJDo7pKIY94lwsvGet5SxEgN2JTddVhHiaT2C+hsMZhmQJxIz24qdnL4ip6heVKbAERcmf3qxJuKttpnQLmnJatv3KCFz3RipjuglGhj87rXJuBqcx4esuEmIoaMjO6wz0vp2THxKMESHcBrkWK8aj1BBKSIy1ol7ffJdKNfbwZ898UIqDTpQD3AAGoF4kjtktvVFjOGv9bvi7H0MYqQ8tS9ANk62rnNh8zILycs6e6UsPmRmPLqZ9nEiAVFpcb4xD1zUD1qcDfrMjhhcCYD4sJZO+nxdDnxwIsALzTLnIrTtVJmsyol+Mr9AVST2LHY7Ok6klLscqbWNKX4doA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESnLSCVS/3ToiZHE63KJnJixV334gvIlVDcaTR1tejo=;
 b=aTQZDTbYSgxgvbNd4VGwZ4LiAvP9X7alSogCySgKVy5UR734cWoR3SlmklkwhtnUrw5Do4PSorvZ+NWcmk/aicSWOe+WGAghYuzjU8cLT/Bcgxpyln32sfElsHwScWvcBZGhG3OCPsx6V8niN+390n9qwLe0xggwP8gnND2iyNIONOesi0WvRZKpvqodLX1BqHOb809ZPf0KycNOzg5VG2ncjk6RlRUulWDZ1DWjJUlBtN5ZDa55ROFDBkmYs+Bme4sJY17SuguhtxwFatOK/RbedJvNucGNulAT62vXrICTqE9m7n7F9+P/UMs2G+6QTBbwFg/xbJm3Hth4rfAauw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 17:26:57 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 17:26:56 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 0/3] Remove bb.fetch compatibility shim
 module
Thread-Topic: [bitbake-devel] [PATCH 0/3] Remove bb.fetch compatibility shim
 module
Thread-Index: AQHdMY9vbE+D9Xvefk6mY6MNiXRsNLaovtMAgAAAZRA=
Date: Fri, 21 Aug 2026 17:26:56 +0000
Message-ID: 
 <DM8PR12MB54303D8EC454EA621D9171028BA32@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
 <CANNYZj9wrRh4JR3cuwKchRFXEKEKa+oyCSh1XMN=tWJihY-8Ug@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9wrRh4JR3cuwKchRFXEKEKa+oyCSh1XMN=tWJihY-8Ug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=a7f19e99-a0ff-4e77-b8bd-9269ee884e5c;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-21T17:19:06Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|MW4PR12MB7334:EE_
x-ms-office365-filtering-correlation-id: 9211c88d-cdb0-44fc-98b1-08deffa9668a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 
 GbRUvmgusPhbeF00T6HLV3G0uye3Enerla/k6Q078dBVS2XtXvmupJLuPUd/RyJqO+MVJcfeNAQUDwa5NaaeZPTv5ENGASih23g9qQXI8vGrTWPctaH/OaKRvW7ZNEuEKi1SIMxecHVjU0eiXtkKxe6NxFIReY475JiVunaIca0mhrUdV8a+NuOV489UKJEBimCLkf6ux/BL8j550BZ6C5J8W8rt4Pv0cTu46e8EfOwl6DrErX7LjrAGiheywdawIh+F1Z9quWkrbeiqkOOeWEQqPUNT2PYSf5xG1tua31UdGuLkFicKaZbuIAOW9e3oQ8BsJAH6uwLUWDK1HvcHkIRJ7/1BQLYhQQIGmpV/VwqZiu2YOnlxQ61jMof1Qy+W4nBCZI664s9nm8GFMjbgcBAMCD+/iU4tUvlB7yh1LA/3K0bzAI7x1I3M9dRSL2tntLp5XcBBcAh5K4mJcIQC/QaKpkWZB96kko4SMCXD+h+tZPzQjwOmpPr2cqVwJbBNLNeMU9A8E7xboizBj/1q7qd3WK7BIrA8vs4JK9hRVH+SbKeh/ov51fjrCxnU5/kj5tWjO3a9ZeLVr5KcdrTu47V9M56GhWj5fQy7cCzeEcxpCBgu1g2c/D0nVdL0a10xCF0dxBNUVkBy1cWWv2QTfEbzHUkfGIfzi4pZmlmKlEs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QURCV1o4OUhvWUZES01aZ0NLVGJZRjRvekZ2QVpkUHhkVm9USm5Qd1hWTUpo?=
 =?utf-8?B?SDFYZW9uQ0hnV08vZGlEaXU1ZVNONzZQaWpTaHFnSXNYd2FrblBmV2YvSlJI?=
 =?utf-8?B?MWtYcWZXMlJ1S0ZaWUN6K2x1SEhGWGl5czAraWh4Tys3ZU9kK3M1VEFNSmJC?=
 =?utf-8?B?MnBvajNpN2J4bUpjRUQrcXZKU3J5a1VjQ1hqQ3g3SHg4UmIzd2ljdy9DQ2sy?=
 =?utf-8?B?WnpwY0tiSFhTVFNIVHZTY1JUNmlSY0ozMUJvcXJFQlRvem8rdUZ0YkR4aXJx?=
 =?utf-8?B?N29IdE5lTzEwbnZ1aHdlWGQzc0ZMYlBvZml4Y1YxSW1TTTg2Mi9hc1BHOTJQ?=
 =?utf-8?B?dE9JTk5aYTcvVVdtc1pOY2FpdFZ4eis0N3Z4bWdVWTNVWWhMa0RDY09ZQytO?=
 =?utf-8?B?cjdXWVc3NEZQeE9QSnVPbzZOeUl4czVUcU1BcGdwK2g2SzEzYzBhYllkVWQr?=
 =?utf-8?B?L0IvMEhad0Rnc0RXWWFBVCtPZ2o3ekE3R2p3SzM1c1ZUUmM1UjJjL3h2SzJk?=
 =?utf-8?B?OUgrRE1DUHJtamlldlhpbzFEWEY0QlV1M2txZFlzWW5aNFhFWDNDQmI1R21t?=
 =?utf-8?B?aEYyVkJHNGlnZlFXbm1vVjFnU2FtM1RHQjVmeFpRWC94b3hXWnozVzBwVTVG?=
 =?utf-8?B?UTVMaE5MOHJWSXYxM3ZqOHplZ2RZdmtySXl1YTRjQ1dTbFliMExaczQ0WTA2?=
 =?utf-8?B?b2hGSzNoc0hiaStVRWorSTNZck1yTWVJVjJJUFd6L1FOTDVjMSsvM0N4U2x4?=
 =?utf-8?B?eDNUN3VpVExlVUNMTHAyWHUyWS9sQXUxYUFGVkl2VnpMTElsNG1XNm9ZMUdz?=
 =?utf-8?B?Z1JVN0dSdi9LVFdtWDUxSGl0aUVNTHFjZlVGT252VWpjOFRxQVJnYjcrT3J2?=
 =?utf-8?B?NjFoaDVyVm9ncEJUWTJFcXI0YjF0TUpPK0c4cUg2UUNsYkhlTEpTb1FzcHkv?=
 =?utf-8?B?WGxhVkZHZSs0ZGtsSnhURmpGdFQyQno5VU9iOFgxTFQ3STg2c0ZSOE1ieVBm?=
 =?utf-8?B?ZzJOVW02RVRrVTdqSmRJQlJSdjZpL0p4NjFhL2ZZdVJ1TnU4LzhQVnRGZ09H?=
 =?utf-8?B?cGlZQ1Z0cW1NMk5ZSGZlWVpjZWtVeHVrRVNtaXNQS2NuUFRlM2NibnRMRGo3?=
 =?utf-8?B?TGoyZWlrTUtiTDVTY3BTQ0xFNUo3dTNvNWZsOVI5cDdYdTdxaHpla3lnYUNU?=
 =?utf-8?B?bkt4RkQ2L0JiaGFTTDhON3NZQm9JeUVzSFRiQ1BlZCt2MjRUSDBqeXhzRVY0?=
 =?utf-8?B?dnRtYUhWN1huVjFUNEdaUjdMZmtCa2RaczhyRmxPNEh5cUdvQTcvNEE1RnZU?=
 =?utf-8?B?V2l0bzNlQ1d2N2dydEtrU2M5UC8zbUJlQ3ZnQ3JGdTllcmhUWWFCcmtRY29y?=
 =?utf-8?B?K1ZBQ1k2K3ViZEppU2NlRGovVE56RTVYUUl5UStZbG1vOHljbFF6cTREbFN3?=
 =?utf-8?B?aFJnNWJtT2MvRE9vQjB1RkVHZ2EzV3BjVlhLMlAzVlRpbXRwdTlVbzBFYWV3?=
 =?utf-8?B?Q21RYUUwd1EvTVRNTTRyZzdVVlAxdkp4SnA4OGdsMVlTejdSWXlNZldNQ05z?=
 =?utf-8?B?SGtSK1BpMFU2Vjl6d2tWMlI3ZnR4M25mKzJOOEpwRU5acE1WMk91Z3pBSHUr?=
 =?utf-8?B?NUliU0hvOFV3Wkdia0dOTDBsN3o3NGh6Q2JMcktMQ3lIUkYrZjVGM0tLSEhG?=
 =?utf-8?B?aC95OVYraUp6Z1UvZEkydi9PQnY2QVU5dDJDKzZlc080NmR0SkJMYmhleUM5?=
 =?utf-8?B?anRGTmRZWm1HaEpuZWkyUFVJMng0cGRXREpCT05QNzBETDdPZGNZeE5KVjZ0?=
 =?utf-8?B?QzlQYnZSNXgvOGxOTGhIdHEzaHhqK2g3RVNqRWYvdlhmNFhOK2RPWjdDU0Iv?=
 =?utf-8?B?cmdpOUF3dm1kQUtOaWw1SUkrVTUybFRGRnVYejM2SHBWS3ZSY2NsUzZaN0E1?=
 =?utf-8?B?czhLV3BtaUZFL3JGK1lMcDVRTkVvL1V6N0UzaFp4TmJpUGFXWlgweUVOcWw5?=
 =?utf-8?B?L1NJUGJ3Y1JEUzMrNXNqQlJXSm1qZXhQV09qTFFnbUZlQ1dTeDE5RUhQNlNn?=
 =?utf-8?B?dUJyT3JTbDRkci91UHlwa09kY1NnZGJubDJwaG9TZngzTXo2dW9EbzQ1ME81?=
 =?utf-8?B?M1NRVVBIdEI2RUp4emhlOVZHT216aVFsaU1xcTUvZ0loRHMyTm1OY0tZdWl0?=
 =?utf-8?B?NDdCMzQ5aFJoSVdQdUtTVlR3TWVMbkNwS2swdTVBNkZ5WnpIZlpOWEJwYjlH?=
 =?utf-8?B?Y2NzZm1sNmtrcGNCcWx1am1jTDdxZ0owNllwQTBZWFdHZFpPcDJ0bHpLZGM2?=
 =?utf-8?B?L2VTbDVNbjF0TU5VRTgxTEF4d29PMUplUXdGTjVFVTNiUHdjVXVWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9211c88d-cdb0-44fc-98b1-08deffa9668a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 17:26:56.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKFOMGa/O1ZCaXBxGiklNbXAnGv9QvFqju09gACDC9sGxHgjokt6LiDvRjptt9Jn6k2xITbp4S5SefJIQp2OjhyWStwM5/Z8hE2jdoZbOD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 17:27:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20013

SGkgQWxleCwNCg0KPiBPbiBGcmksIDIxIEF1ZyAyMDI2IGF0IDE5OjA2LCBDaHJpcyBMYXBsYW50
ZSB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KPiA8Y2hyaXMubGFwbGFudGU9YWdpbGVudC5j
b21AbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+ID4gZmV0Y2gyIHJlcGxhY2VkIGZl
dGNoIGEgbG9uZyB0aW1lIGFnbyAoMjAxMikgc28gSSBhcmd1ZSBpdCBpcyB0aW1lIHRvDQo+ID4g
c2F5IGdvb2RieWUgdGhlIGJiLmZldGNoIHNoaW0uDQo+IA0KPiBXaHkgbm90IGluc3RlYWQgcmVu
YW1lIGZldGNoMiB0byBmZXRjaCBhbmQgZHJvcCB0aGUgdW5uZWVkZWQgJzInPyBJcyB0aGVyZSBh
DQo+IHJlYXNvbiB0byBrZWVwIHRoZSBudW1iZXI/DQoNCkkgdGhvdWdodCBhYm91dCBpdCwgYnV0
IEknZCBiZXQgJ2ZldGNoMicgaXMgbW9yZSBwcmV2YWxlbnQgdGhhbiAnZmV0Y2gnIGluIHRoaXJk
LXBhcnR5IGxheWVycy4gV2UgYWxzbyBkb2N1bWVudCB0aGUgbmFtaW5nIGNob2ljZTogaHR0cHM6
Ly9kb2NzLnlvY3RvcHJvamVjdC5vcmcvYml0YmFrZS9iaXRiYWtlLXVzZXItbWFudWFsL2JpdGJh
a2UtdXNlci1tYW51YWwtZmV0Y2hpbmcuaHRtbCNmaWxlLWRvd25sb2FkLXN1cHBvcnQuIFNvIEkg
dGhpbmsgaXQgd291bGQgcmVzdWx0IGluIGJyZWFraW5nIGEgYnVuY2ggb2YgbGF5ZXJzLiBXaGVy
ZWFzIGlmIHBlb3BsZSBhcmUgc3RpbGwgdXNpbmcgYmIuZmV0Y2gsIHdlIGNhbiBwb2ludCB0byB0
aGUgbWFudWFsIGlmIHRoZXkgY29tcGxhaW4uIA0KDQpUaGF0IGJlaW5nIHNhaWQsIEknbSBub3Qg
b3Bwb3NlZCB0byBnb2luZyB0aGUgJ2ZldGNoJyByb3V0ZSBpZiBwZW9wbGUgcHJlZmVyIGl0LiAg
DQoNClRoYW5rcywNCkNocmlzIA0K

