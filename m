Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF91C5DF66
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 19:36:38 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3105.1786995393324490221
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 12:36:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=vnwDSTPR;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.201.71, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGngVwpWUffWTIKBagN+DaZuVglNEPPk7KufunRPBynXDa12Y8WuGeeiW/d0rgG/va1201oHOcZiLmOn7HuNuZ5zHZ2euY1srNAW0McG3vPi0lAUy82ZLutXTAT9TvdsW3mtzzpdfUWIOE0yQI6YJjFeC8jcGNoAgkpF8v4/dNXXG56T5dpCNxKQTTt54NCAGSiem5uddk2xBzeHPjPwasSEW2YNMhfH+PgUqgG+nIVA042hd7p2UIy5YoW8E2pd0UOpmwEUNgoPYyJslX4RPDPcRKweNZFeSuSI+u8jhYrXBs1OOKwWID12mzbBjsg3Be435kjqJUXjyUiJkNz0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nB5nb2N020PXHJEVb/10ww9VSULe9uOkkntsCGnv2J4=;
 b=BLe1tv3ffNmJ9dQ/PCLCKa2p5ZCuteBTiX4xqf8pTIeRVp5peKpcfOaYzMHjOZj8RJj5q2tg7HPySKCHU+fI3AvC3Lexk5KXRFE36/yf87HXsMomKcvEUUR45THC3P93kCtG0EVrlq6J+3E927/W+S4VNwSxzaFU2+C9YJV4AKA/9iRiKEH+aKtSvJSSib31agPT/tqhuLz/lR+LmAgSGtVaOuo8OVoTgia+62FyQrYoFoIdpZOQxrxg8n/BucTi+7t1ktPPexAxem3Ct+h3qSrWEUwCtbZO4Niju/0wt4mRYV9fwZz3mMt/joA8cxcTXzdMEqIc/QRLtQ1IvFhnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB5nb2N020PXHJEVb/10ww9VSULe9uOkkntsCGnv2J4=;
 b=vnwDSTPRfGAVL+VKYwZE/LnnStL7vmBQXu6SMHEwp7dlqXPog+Mmf2+1pB9ne0PG0BSTGlHC8GvpNR0QYREDNW88xa7ICTIP/Ua9QUZmSYqB1/gAIH2du5bA82wbva1oj9xuF7RnqXXSGOGUuyiGMMpqIVnc27c2dHH+kGw5Aw5GAGlPzRLZFNFbzZeQyo/NR1K6s9EOm8KqJEpkG8BUb8tvkxdGRtVcN4ROo1OmoVZ931+5pbUJt0ZGeuwvvvmzN7kf3xfO6qg6Qd5MCSqmvo6+glV8+1CK29ULHaqJWTQbiWiqXIYtmArcUklV4RP0HksKGH0w0lZZ+mHRhlElRA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 BN7PPF39B20C1D8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:36:28 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 19:36:28 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Fredrik Svensson
 (svsvenss)" <svsvenss@cisco.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: 
 =?utf-8?B?UkU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0jCoHYyXcKgZmV0Y2gyL3dnZXQ6?=
 =?utf-8?B?wqByZXVzZcKgY2FjaGVkwqBIVFRQU8KgY29ubmVjdGlvbnM=?=
Thread-Topic: 
 =?utf-8?B?W2JpdGJha2UtZGV2ZWxdIFtQQVRDSMKgdjJdwqBmZXRjaDIvd2dldDrCoHJl?=
 =?utf-8?B?dXNlwqBjYWNoZWTCoEhUVFBTwqBjb25uZWN0aW9ucw==?=
Thread-Index: AQHdKnxaqgOfbFZ0Nk+1fTBcZToMq7aiSJ6AgAAG972AAAE6IIAAWPyAgAAAfxA=
Date: Mon, 17 Aug 2026 19:36:27 +0000
Message-ID: 
 <DM8PR12MB5430FFACCAFA9084E00AC7CE8BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <DM8PR12MB54309AEE365DF999981829528BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <DM6PR11MB39628059FA2D29F9B3F74295CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <DM8PR12MB5430D56BA600CBBB0DB41C428BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
 <09f0be3fae9caaa9cc033c4d939f74027157df1e.camel@linuxfoundation.org>
In-Reply-To: 
 <09f0be3fae9caaa9cc033c4d939f74027157df1e.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=aee93b3e-150c-4ec0-b21a-2efc2a2a071d;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-17T19:35:59Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|BN7PPF39B20C1D8:EE_
x-ms-office365-filtering-correlation-id: 1f5cdb65-367b-4f28-e6e5-08defc96d4ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 oqmbD9aOP2F/kAbVtRaaW12WxuohFuvAnf04eghYfFzF7xt0CyixsL9Nm0Uydz3A9m6BLurq0lIfIp+GL78VaKpXIE2w91ZvTgt34OH4dUyZtV6rwe4GT/Wd7FUsTMcDGbjoaj+L/YN0iqqh4kfxfDQzL4xxMGIImd/EBKa/uykSd+DPTG1+vHdeilYELwotKh0Un1K+lO+aAnyhN/uRMfoaRkGPeJTdZa1hPk6oQRsa2GJrCFwegqDsWGB5JUiWrOOwv5yTiIphUvYl2Sa//vBLcxeRWz/RVD1Wliu7OyW5AF0rC7JhrCfOmpFi0tbSbnaMa/nSm5o9uLL0TKE2RKZwZ6Pr7asiarE53B0VxI/uHtj2DmBrOJ5WIEpQmbfXyoKJOB5ThmqqPpFlL6BEFFGIfr88K/581CNX3ULnHhftkuGAXMFVv1wbFua8hZBsU7BNW8U09R9Kq20gcLprERiKPJTCpUe9/H656QZobW1nOcp6M4EICx9cO9rUG2CWVxnC7EANYCYD0wGFZ+UyzGDHZ+GBGrRP6IMd03oC6JtTwdqQbC1xQ19uJimIaRV7oRXxvh7XEhJ9jOy1jpjsJfxMP5SgWVXUXtF5Fz/GdhXPGJDq1bMv6uDhhmTUsrrv3KEOXg39Gnv8kCi36ZlWpK3H0F4itTJu8OwpNkit5hyx/o0E/Nk0Xt6CCBqaRNsQKLMlGw89wQaYU/sPml1ZyVLjD+4jGP2U0pYAYcupICw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U1BuYlMzanFFb3U4eDU5bmViWHR1b1VRMUtQQmw5Zk9EYnBNVDdJUzgxSVFL?=
 =?utf-8?B?cTQ3c3laQ1hmZ3MycUJ2S0pGbEt4WlFsOVkxZnFkQ0FadElmN1BId1I1K1FO?=
 =?utf-8?B?RHllbjB6NDU4OTYxS1hwQllGOUE1QytNdEJRK0JKNTlZSHBGMHFXbW5tei9w?=
 =?utf-8?B?alpyQmpJMitLQzJOZlhCUi94cmV3YlV2dlM0R24raTFqbkxreE0yMGFPTWVp?=
 =?utf-8?B?dm5La1lwMG9vSmZMcy8vcW54b00ydGphSHhJL2dKK3hsUHQyRGJNbWoxMTlE?=
 =?utf-8?B?Y2F3RGRkZk1QbjZSazErTlYrU1VVNFZZSUxYVEtqNFo2REhQejhuVEYwU0dC?=
 =?utf-8?B?ZGwySjFqa2VPUmh0TnhhQitjU1FQQ2w0UTV6RGJHUUJzaTZVVDhqc2EycDJY?=
 =?utf-8?B?Y0lpTjJGbkhsaHNpaHpuK2U2c0JoQ05tT3c1UGN6bk82ZHpSQVJxLzdWTnZq?=
 =?utf-8?B?OGsrWW05VFhUOXVEbUpYWWdseE9paWp0T24xUXBCUkRibVIyRFhkTklVVXVy?=
 =?utf-8?B?MitKbFNwbWlEQU1mcUFHVlNlbDQ4YTI4NGwvclRhNGRCUzgrQmhwdTd0eVlC?=
 =?utf-8?B?Z21ueVBna1FBQTlpSU1aS0tZOHY3YXNmcFFxYUtLYTlpdFJmQzFaSTVEVTk4?=
 =?utf-8?B?K0JDVjNMc3lQc3dUNDZxS05rc3N5d1hqMzBpSExmUTlzV1RaYXFldVF3dkV3?=
 =?utf-8?B?bzk2Nnc2VndaOGlONjBkbjFYY3FROW1vazlnbks4UTh3NXFpc2wyekQwTVZ3?=
 =?utf-8?B?U3R5RmNoYi96SE1TTUFJUXJHWGtCT3NmcXEzWGlmM0RJWGIzSVF5WmpEazZI?=
 =?utf-8?B?WmM1YlVJK3p6WGxIRzV4YTU5V0hmdXBFaHVqWkRUZFRQN0t3S0xuZkcxZUZ1?=
 =?utf-8?B?b0MxcG9GU3dvTERQWTg5SDZaUytXbEY2Mm5hMTlGa2tCOUpWMDdaVkRsR0da?=
 =?utf-8?B?VmNYL2JHTms3cDZCWnlUSGhRUHNtU3gvaytCMHBMczUwOHJQYlhGVmp3RzNT?=
 =?utf-8?B?TDAyeC9tVkgzVUlDRS9jbk4xMlhPSnNFMVRHSzh2VStlK0Z5TXJUdjBvY0Mr?=
 =?utf-8?B?akxjREVmSDU4S2tYbndlczNYdDJTanEzQUxuSHpGMWVhbDNoNlM5NzF6a01t?=
 =?utf-8?B?cVZnNU1xVGNVdWJHVzBxL1hyN010UkJpV3V0Nllyc2ZwWWE3d0p3UzVSYVM2?=
 =?utf-8?B?SFRXQmNWREVZdXh3QWlyQ0h4TTlINEdKWkh0U3ZJMHovbHA4WUpDa1B3cG9s?=
 =?utf-8?B?d0lQc0hZbjNaRFR1Vlc2bFcreVZjdUZYTkZKS2plb01McXJXc0J2U3JDL25w?=
 =?utf-8?B?bkVuZDJwZGxBVEk0R1ZzZjA1Tlg5eUtvdnNrajNKT0syMEVXL2krNkpJUmx2?=
 =?utf-8?B?bFB1VXRRa3dkSitQNnd6YnJjWUt4aEtPYjJiM0FRb1NGb0RWTUFZTDEzdWd1?=
 =?utf-8?B?VDk1RWlqZTFQTFplU0FRT2hmYW1TMFhISnpGYU80TjBzSzNaTGNaUm9HcjQ5?=
 =?utf-8?B?dVVVMTdsS2hyNGtJbjl3TjVCZ3ZoS0xwbGd5aklIeTRGN24vbHVSQTRzL3Rm?=
 =?utf-8?B?aEVQa2JnWEYwV2ZSVFp0VkZlQndNczRqT3pzbGdLOTFRMGRSbEhqSVR2ZHZl?=
 =?utf-8?B?Yi93WlFWYXcrZEdqK08zTlBzcGtiQnBPOUIyZjY5VzhBWlY0SHNkZy8ralZk?=
 =?utf-8?B?elZ3akRrZWRVV1o5M1hLbzRHaFY0Q1BMdUhGT0pHeG1RSGdQSE1BNm1pL2RM?=
 =?utf-8?B?NGxVZmRHU0VRREkzdXIxeHJVZjFXYjJwKzlHc29GWU1KSEQveGFHSGpINjha?=
 =?utf-8?B?NUVjU0tMU21GdmxsR0xEdkN5dVMzZkNlRSszdUdsanptb2lTUGZXVkxWa2hH?=
 =?utf-8?B?bks1VEd0bXcwQUsyREEyc0ZSaHhmRE40eXBieXRtSlpwb3pkUHJiY2ZjbkRE?=
 =?utf-8?B?Ni9aMm4ybG5YVG1JL0U0K05oUnlIdW4wVGFoSHZSUWt4N25RODNCUmdzR296?=
 =?utf-8?B?T25GRU9TRXN3REI3YndkMVBIV3pFR3hwRlF3K1NvL2VRVWJ1RkFoLy9FQVlF?=
 =?utf-8?B?cEl2SHZlZkExeFNnbUZOWUlBT3NRR0VkUSs0SFEybXFIelJTZ0ZmazNBTHIr?=
 =?utf-8?B?T0pieVlGZGdOSVp2UWxrREV5dThRcXFXWW84TVAxdGpmbFZzTWx0K3VUVHJq?=
 =?utf-8?B?Z3BPTUFMSkEzODVQVzhaZDFWY3pXYUNzOHVtRjBzUHRqZXpjK1RmcXNFRlh4?=
 =?utf-8?B?UTJ5ZWNPNmJGUnRjc054cjZ2VWRYSW51STBXbktTK3dtUTBEaUcrSUh4NnE4?=
 =?utf-8?B?cmFnK0lkMDVJMVRnL29FbWJDYms1VXdqYmZvTXk0bGp6Y1NoNG5Zdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5cdb65-367b-4f28-e6e5-08defc96d4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 19:36:28.0470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96iwcMODsd7DGzfL9181ZXtSG+0qgcSq5F5DM5BRUocFIZ3MX1C6V733bQ0wupm20iuT0ZaEnVwMVCuNsl53eSXrX/92LDOcvydRE614J20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 19:36:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19974

PiA+ID4gRnVubnkgZW5vdWdoLCBqdXN0IGxhc3Qgd2VlayBJIHdhcyBhbHNvIHBva2luZyBhcm91
bmQgaW4gdGhpcyBhcmVhDQo+ID4gPiB1c2luZyB2aXp0cmFjZXIgdG8gZG8gc29tZSBwcm9maWxp
bmcuIEkgd2FzIHByZXBhcmluZyB0byBzZW5kIGENCj4gPiA+IHBhdGNoIHRoYXQganVzdCBjYWNo
ZWQgdGhlIFNTTCBjb250ZXh0IGNyZWF0aW9uLCB3aGljaCBvbiBteSBzeXN0ZW0NCj4gPiA+IGNv
c3RzIDEwMC0yMDBtcyBlYWNoIHRpbWUgKHNpbmNlIGl0IGhhcyB0byBsb2FkIHRoZSBjZXJ0aWZp
Y2F0ZSBzdG9yZSBmcm9tDQo+IGRpc2spLg0KPiA+DQo+ID4gV2lsbCBkby4gSSB0aGluayBJJ2xs
IGhvbGQgb2ZmIGEgYml0IHVudGlsIHlvdXIgY2hhbmdlcyBsYW5kIGluDQo+ID4gbWFzdGVyLW5l
eHQgdGhvdWdoLCB0byBhdm9pZCBtZXJnZSBjb25mbGljdHMuDQo+IA0KPiBJIHRoaW5rIHRoZXkn
cmUgYWxyZWFkeSBpbiBtYXN0ZXI/DQoNCk15IG1pc3Rha2UsIEkgbWlzc2VkIHRoYXQuIFdpbGwg
d29yayBvbiB0aGVtIG5vdy4gVGhhbmtzISANCg0KQ2hyaXMNCg==

