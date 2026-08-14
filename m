Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB59C5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 14:44:22 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com (MW6PR02CU001.outbound.protection.outlook.com [52.101.48.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14404.1786718658665296100
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 07:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=xVwADB2o;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.48.40, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJpzPzvl5i9nTu5l/OI3f9Kme3gydOW7sr7ptCy/c4Oa65ru1SczhjqBWJgHGi9SKdd7csERo4yOiaRmxK8SRCzZo4mS+eu7ZBfV6B7qKWDh9yHtNabMATlmalbcC+zbRS72BhLtZSgTulNWHzlBCBjlF3Nj6QJD79CWxMwXcPBrtui7vrj+1MRPy3jBhE3T0Ctb0rghN0jg7sbFZAU+9HguZGX+QM7Cgvr0XQMWAwh3S1ZJEePt8F93Z6PYbxKWXsymenVFTUV5cWBQk3YWjNbiITPELD60mhDgODgd7nwx2+ipG/SZwraIEr3E/F910jyPxRAOw5QH/sC+AXoxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjq6FGH3Hu+BME+qVvuKA1VHW3yj+bx59oroGM27b5Y=;
 b=Ie6rNsxIjFlFfS69HEbhGYRYDKarCiePPL6q5cQFSpmoYxpP3tQ0Q+hYcqyd2Y2XbTBXfqFwvWlUazsC2Y2VuQgEsnz52fdDObaA2EtyA8Awi/jCZi27k12Mr4RTzOrU+TIHxO48Vf98ppo2sfyqNWwi1ssz591OukNJss4aEeAVRYOsxBLD7ppSqBL8q5pHGlT9rqsxN8o9My1ONAL7GOvJul8v/ps/nqAbEg7TQrLiTzQbyhZM8bDOBxNacfkuB2N49x97s2CITiXJLT6QF2i+bkpLdZi5Ct3E2WXIEpmVReGYJa9vI4wQI0wYcZLFmx9VG4Wz78l2l9+ojcyirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjq6FGH3Hu+BME+qVvuKA1VHW3yj+bx59oroGM27b5Y=;
 b=xVwADB2oRHubV6rFQtTDNaeC8S8n3+PC6qkdklJ95xMqfujm/5eDkmETp3LESKyShdjNmjbrpyFVqz16COTfBJ0zozXbm/WPtnYBEXg8MlWtdMdAaFSr5HhCXe5gvVds9xFlR9xDZvcPoEwbyGNAMCysco6OvMmBKGgjNHRF+secWcJ0/AZKOEV4MNOfu1sGWeNfbGW31o+XxbGGtbdbIjRIeIxHcmcvArZEUUHHyho5wBF7XRO1HlJ0ougWS+RgGOg/RUWovzhcisORhIFMIlnz7nJKrhcsE/HgStuFqXpwlrIqwlGwCixq4Ka/lM9ureMTKdCSjrP7G53J9wScGA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:44:14 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:44:14 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Rob Woolley <rob.woolleywr@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/2] pyproject.toml: add scripts
Thread-Topic: [bitbake-devel] [PATCH 2/2] pyproject.toml: add scripts
Thread-Index: AQHdKpMIGlVKDBaQbEuEnwildltu3LacpqEAgAD4j+A=
Date: Fri, 14 Aug 2026 14:44:14 +0000
Message-ID: 
 <DM8PR12MB543024C7AE039640D4BFC00B8BDA2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260812194433.40594-1-chris.laplante@agilent.com>
 <20260812194433.40594-2-chris.laplante@agilent.com>
 <CAGAhMByMYPx=gUNTfNxrtdox7MkX4OHM2PhLo45Kipx=t1e7WA@mail.gmail.com>
In-Reply-To: 
 <CAGAhMByMYPx=gUNTfNxrtdox7MkX4OHM2PhLo45Kipx=t1e7WA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=202b8b5d-bcff-4313-aff3-1842586577b9;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-14T14:35:36Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS5PPFBABE93B01:EE_
x-ms-office365-filtering-correlation-id: 2ce1d1d7-5131-427f-840c-08defa1282e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|38070700021|6133799003|10067099003|5023799004|11063799006|4143699003;
x-microsoft-antispam-message-info: 
 9e/K5oq/7NfgpbgfmFJ7Eisckcmxf4QkBPdrb+bH2oAbFBMHM2fkOfGYqczotFN5T8q1OUezhsPvb0XZfbu3APrChno9OcbHMXbHUkw8g36i6q4BWqKWJfjTsb8+V9CLPEd917x9MfUEoyH+9V5O5Dmbah+mwm2eAXrN1V8otrzet5FPpZdMmTcHGq1LicsR7drKki7jRhAmMclBBzP2a+wzXU79s4iMi+ZjabUg6d4sXGES1MsyjarqhngJ+UqiV9dpPwi1IKl3nng3yuQsvT7Zm3blYKx/+drOKfQGFh+VukGsaP3ag7TYks8Tk31vHkrgcNbaqOpb4UqlDuRHaRh2aAXSY425QBSmQFx0nK7OdKeG6GsTL3eGLWgqLOw3mK5D+ybj/aNVvgbRhd/enNQgHj8KwZvy7RqHDHHgagQb/KSOXN0rwVATkebSIBEh44E64PTOTIGsGmXSccEp+Rmm58AxWc2pW6ItwE4mhHH0s2il6+0cnZzdXm5BdKAxu0VfhWWNdfHPHZACVm5tMD5b6pL5EPR97nxK7ZlUNKvhxIjuBxuCy2VKtZmugS33vm8lPzw0UM6qrNiGDx7JSNF+sUsNM5YgCQnRmsxNx8oM6AHucrRBK2zcTsAz9lJgwiL80jTWIDx+EvvwG4tdj56aHPueoBE1D0XZ6bRXaYqPl5nHRlaKkwVQNwBHtEEz1gYV3PQ4+tWRXRxb3Iq4+RkL7Pviq1X9qRiof9jrQlc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UkhQbFJzMnMzc3Rpa1Rvb0x6YzZ1ZkpxSHpKWEpDTXQ0WENKZHdRSnRVZk0w?=
 =?utf-8?B?TkpLbVBoUWdsUkdWRWFRcFJqLzVWa3NWZEpzaTdPZUxQbTdqSHVTKytySVZJ?=
 =?utf-8?B?cEVSSUgyemNVeHZ2c01nanFQQVl3WGdQVlowVVY5anNRN3JJMFczaWlpZ2Zu?=
 =?utf-8?B?V2MrbGpTcGpkTVdXSkhJV1NlK3l4RVpDa0ttTjdUeFg0U285blhkWmdZdTBG?=
 =?utf-8?B?cm1ySmlZb3h1MEpxS2UrSGJGVWNWNzlsT3lkUHpGa2dFNmZvMDZ3K1pJMVFH?=
 =?utf-8?B?dUNhNDNwOWpHWVRmQWN6SWU0cjJTVFg5SHYvdnBLMXU3a1VHYWlpZngxcFl5?=
 =?utf-8?B?NWtNZERBOURFcktuL2VQekkxUXgzU2tUNnlJclovck5NQVVXT0l5bGU2K05k?=
 =?utf-8?B?azlyNndsbFZwd2FhWG1BRnBqeG5TT2xLb00zMjRNTnJ2cG1paUptZmRocWNj?=
 =?utf-8?B?SFRNWXJIWlVNbW9qSTNERWJYQ0VObytYa2ZXUVFCZ0xsZmxSUWliWGZHWStI?=
 =?utf-8?B?SDZEc3ovb2hCSGZhUHJaR3VoSnQwSEhwYmIvL3hSK1g0eHNDUWpiMlc3dGJa?=
 =?utf-8?B?SUdtN0hIcFJqMXFIQUxqNElXUldBbHZYeVFFT3VYbWV1elBDRjl5QlZaR3d3?=
 =?utf-8?B?MWtXMmVaSlE0MkNTK0xJVzdPMVVZZ3VHSjFrTllTc2o4b1RES3R2VUUwUXJC?=
 =?utf-8?B?VmIzMVJRbE5vVjBZU04vN2gwRWFDNHZPbzNUT2NYdytSWHdhbGlmdUsxdCtK?=
 =?utf-8?B?c3VGV1hvTjY1T2sza0ZGMk1TaGlXVTVVMzE5N2pLZWx3S0NrampoaUJhWDFr?=
 =?utf-8?B?RjZMVDlMS053OHFvLzNaYThncjZUVnM2Tk54YjNzZmlPU3Ayd00vQlh5bjVH?=
 =?utf-8?B?ZEMrQ3hQWG1BeHF4Yy9MZkRubk5QcEpsZVIzc24vOVlBTW50WUgrcG9ocit4?=
 =?utf-8?B?T29YSi9kQnlHRGhoRVdRQk5vMHd5U2tyODc1cmlwWWp4YXlBR3MrVnUxaFlq?=
 =?utf-8?B?cmhBRW9FcHpQem9ZYUM4d214Z3ZEN2ZhbTJTRFhkVUlkMnc4MXBFQ0lMc2Rj?=
 =?utf-8?B?UjZZSU1hV3phN2FCVzd3TC9pcmVHL2p3VzBxMTUxVHczVTJ4ZnVqY3VoOE9m?=
 =?utf-8?B?VUh2ajZDRnhySVN3ODhuT1R2TVFFbUh4NW95Wk14bzIxRFNzT1NSWUxQVDZL?=
 =?utf-8?B?ZjM4S3Jkd0ZaV3pCVEIzNlB2VGQ4d2VTeG9mODhPSmFORldncGttc1ZVcnpm?=
 =?utf-8?B?aWdtcjJQM3MyTHVsQnVKUWlRL2tDdGJkaVIvdHZsQXdkK04xcHdpejBib05a?=
 =?utf-8?B?T05FVXE5L0xYZlplQnhERjdQQ1dvZ3FUUjZuczAvVklLbE43QjRLK3QyV2x6?=
 =?utf-8?B?MEEwMThTd3hyTHhjNlVENVdrSklNZ3N5OGdEUG5jUkhJQm9GOEtuS2JKZm85?=
 =?utf-8?B?eGZrMEFUdEsyQjRKb05CWE04a08xd3c3Q3V4RytsK0IzR1BrSWk3TTh5d1pw?=
 =?utf-8?B?Z1NMb1R3anl4eGhBUml1QjcyU1ZjVDNPbzR0OEQwZUpqd3JqQ0g4cjZxbmxq?=
 =?utf-8?B?Q3YrL080bVdZNzFyUjdCRXJVODRJVjFXWTBKV1dIaXUraVoybWtmUUx5M3BK?=
 =?utf-8?B?M3N5cmpnbk9pWGliRHVGSnNId0V2ZlFadTBHVzJlZmZzMkNMbzhubk1HR0dq?=
 =?utf-8?B?N3lhU2k3cis4Y1RQYUVtS2hEZW1GSTRXQVNwOWx5MjM5Y3BFbzJTUlAwQUY0?=
 =?utf-8?B?YTVvL01hTGc0RUZyL3Z0VXlHbDJnYjhwUTJUUnFKWWh5MEd6UXJuSy92OVlt?=
 =?utf-8?B?N2x1NW41K3hPTlVqTlJiOXBBVUxpRUxyOUh2Y09xRWNwMVIxRjVvUW1aSkxJ?=
 =?utf-8?B?eGVlUzNwODBGc3lqUkY4ZUdYamU2UHlRWWZQNjNCUGhtWEtBN1duWS9VdktP?=
 =?utf-8?B?c3dPWDJCVmJIK3RjMCs2cEFIcDRvbXVzWHhqRlpyZWxOa1cxbVd0aEQrT0xP?=
 =?utf-8?B?bk00SnFTUndKQUYyRnhWdXJuYTNSajY4RkJzcjNSK3NobThwTzNLb2RyR0ZJ?=
 =?utf-8?B?c1lzSFNFMkN1ckt6dHJ0RnFKSE5CMmtlRXJXY0hCSTlVR0daMU85YjJJb2dN?=
 =?utf-8?B?bVpXdlQ4NXNva3I5c2tpT2FYRiswVkk1QTI1MVQxUSsxSEdNbWsySW55WUd3?=
 =?utf-8?B?U3FiOS8rTnEveDZZRGNGQUpYK2grc3g5VjdMTFB1QXBkNEUvUjJiMllkTGJ3?=
 =?utf-8?B?SDBqSnIyT0RIb2o1ZkVEN0Fyb3gyTmU1eGNPdXhrakx4RWRCd2R4a2E2dWY1?=
 =?utf-8?B?bUdOR3ZmSFFJTkVGTTZPa3VvL2g0MUQ5UWo1Um5EOFJ6eENBZE00Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce1d1d7-5131-427f-840c-08defa1282e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 14:44:14.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucqGKk82KqH1sLHc4+eg0C8lwGkSI2CiOWAN+tljC5g5YR8YiRhH19a0kWf2CNPeDkgBiADKqQ5jQ8oaD7q8HEIko73Z9gxN49gP0RVDq24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 14:44:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19938

SGkgUm9iLA0KDQo+IEkgdHJpZWQgb3V0IHVzaW5nICJ1diBydW4gYml0YmFrZSIgYW5kIGdldCB0
aGUgZm9sbG93aW5nIG1lc3NhZ2U6DQo+IEVSUk9SOiBUaGUgQkJQQVRIIHZhcmlhYmxlIGlzIG5v
dCBzZXQgYW5kIGJpdGJha2UgZGlkIG5vdCBmaW5kIGENCj4gY29uZi9iYmxheWVycy5jb25mIGZp
bGUgaW4gdGhlIGV4cGVjdGVkIGxvY2F0aW9uLg0KPiBNYXliZSB5b3UgYWNjaWRlbnRhbGx5IGlu
dm9rZWQgYml0YmFrZSBmcm9tIHRoZSB3cm9uZyBkaXJlY3Rvcnk/DQo+IA0KPiBJIHRoaW5rIHNv
bWUgb2YgdGhlIGNoYWxsZW5nZXMgd2l0aCBwYWNrYWdpbmcgYml0YmFrZSBpcyB0aGF0IHRoZSB2
ZXJzaW9uIGlzIHRpZWQNCj4gdG8gYSBzcGVjaWZpYyBZb2N0byBQcm9qZWN0LCB0aGUgc3lzLnBh
dGggaXMgbW9kaWZpZWQgYXQgcnVudGltZSB0byBmaW5kIHRoZSBsaWINCj4gZGlyZWN0b3J5LCBh
bmQgdGhhdCBpdCBuZWVkcyB0byBydW4gaW4gdGhlIG9lLWluaXQtYnVpbGQtZW52IGVudmlyb25t
ZW50LsKgIFRoaXMNCj4gY291bGQgbWFrZSBpdCBkaWZmaWN1bHQgdG8gd29yayBpbiB0aGlzIHdv
cmtmbG93Lg0KPiANCj4gT3V0IG9mIGN1cmlvc2l0eSwgd2VyZSB5b3UgYWJsZSB0byBkbyBiaXRi
YWtlIGJ1aWxkcyB3aXRoIHRoaXMgc2V0dXA/DQoNCkFsYXMsIHlvdSdyZSByaWdodC4gJ3V2IHJ1
biBiaXRiYWtlJyBkb2Vzbid0IHdvcmsgZm9yIG1lIGVpdGhlciBhcyBpdCB0dXJucyBvdXQgOigu
IA0KDQpCdXQgJ3V2IHJ1biBiaXRiYWtlLXNlbGZ0ZXN0JyB3b3Jrcywgd2hpY2ggaXMgdmVyeSBu
aWNlLiANCg0KVGhhdCBiZWluZyBzYWlkLCBnZXR0aW5nIHJpZCBvZiB0aGUgc2V0dXB0b29scyBz
dHVmZiBtZWFucyB3ZSBhbHNvIGdpdmUgdXAgdGhpcyBhYmlsaXR5IDovLiANCg0KVGhhbmtzLA0K
Q2hyaXMNCg==

