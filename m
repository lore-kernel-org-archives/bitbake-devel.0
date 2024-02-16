Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D27C48260
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 13:46:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.41])
 by mx.groups.io with SMTP id smtpd.web10.19033.1708091204672230911
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Feb 2024 05:46:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=POMYwNtJ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHIiIRkiRBhY1aDKqr1UIOh9FwiTZMrbAd7PCM6Nj1S9m5tsqWQRLEv9IxhH7eYux9ARingCHUtq+UNjd0qxZBIizEt3vbcHuAv/AaZTj80SRxVN/ueVSdnk9XRwr8Lz34Pvx18Ym/M7p9825ss67wuRvh/COgjuMdOSGRi341KpNHfT0QHzF6iL0NjVWqenQBb4P+bOb1feOv9XfRmfKNLnJQLpH7ntlzO91weW5TGnv0j/zuxxQLC4mSz3jTiEEFU3ZT16kX781JfbMUSInbk+b4K8jzyqaA29CH3Y6yyblJuhKjpJ/sXC/vg7AfRgKdeM1BgBViDQVo38ur+mYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLZv0p9jLwPJNhKncbLIUX0g1m294eSwZPY4Bx9tBY8=;
 b=mrKVsVc6JVTAWMRd9bGpamPlQZvSDb1UWZIozqa+SmCYq1DOsabOCMB32P6o++7RBl2D+XzLdbvYNvq99ynjDORpjnR+1NBEolmY9lVaUA9d+I2+pBdfy3OA8iM4SFQsD8RevL/saRU5atfmSMOSE9Tu3d/O7Du924iRb2swVatOaaRVIjDg2tj560x+NganyspjrYWKb2LYIKv9Pj2K8lhSwkt2/tWJxTGxKeeJZ9Qb5ThCp74mDfMShskUEpgfvy3oZ5DpEhPGq58A7nio+W/Z+KuxufKtJj36xHrQ+cj0IUynam0JolLLRYINCJ/hozdboIDqcm4vaBkgkhGT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLZv0p9jLwPJNhKncbLIUX0g1m294eSwZPY4Bx9tBY8=;
 b=POMYwNtJoqcL2dCE2CUtpFTCZlU4S5GvHSpQadqgQsJBXKDY+gH+cvB4U72E1720PpS0FrNAj5eMOO57CDnavT5lPqRIaInKag8vYVpebw0e4nx+M42BcYWi1MzKsgPQdqlqo8p9xsaHAP4IgzzczRRR4qpoJOAoISNOE8VsR32l5rmkLm4CBpycQTH9KGfA5/vSMuTEla75Xd2WRnu/e4zzgsy91XvXeuBoGFSD6hLL7kIFVJEtb9B4ALn4lAJkBIl3noqGCbRNz/8ZxrQUa1FNPAw18HUHPsk/O9A9hrr04BynQk0V8cba8h4zGa5AO4YDzsKZYddzGOvNKtqZlg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.12; Fri, 16 Feb 2024 13:46:41 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 13:46:41 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "behanw@converseincode.com" <behanw@converseincode.com>, Michael Halstead
	<mhalstead@linuxfoundation.org>
Subject: RE: [bitbake-devel] Online tool for playing with variable expansion -
 first steps and where to host it
Thread-Topic: [bitbake-devel] Online tool for playing with variable expansion
 - first steps and where to host it
Thread-Index: 
 AdpfZydm5aBLa/+zQN6kD8lbigwWlgAu00QAAAAV4sAABDt8AAAACVTQAAAlBIAAKn4/cA==
Date: Fri, 16 Feb 2024 13:46:41 +0000
Message-ID: 
 <DM8PR12MB54304EA88B155F32A8620FDB8B4C2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <4ab357d878fad09b44149179e532608a1c329e81.camel@linuxfoundation.org>
	 <DM8PR12MB5430121AAE8FABC5D834CF8F8B4D2@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <7ea7dc754fda197b9f911bb287b1398114dfc0c1.camel@linuxfoundation.org>
	 <DM8PR12MB5430C2D2BAC610486096C7F48B4D2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <65cfd68e97fa5cf84b759a1502b78e92e4d44dbf.camel@linuxfoundation.org>
In-Reply-To: 
 <65cfd68e97fa5cf84b759a1502b78e92e4d44dbf.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=589637f9-8351-4071-b0a0-6acea1b100bc;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-02-16T13:45:37Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|PH8PR12MB6771:EE_
x-ms-office365-filtering-correlation-id: b5d11dc9-8e8b-4606-8d93-08dc2ef5b4c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uLXXXdmPp0dADqKiVFnFtOF3lKhN2ArBzy2WZZrDONkss948VA0zy9qLDdEHNS0/6j1JsFpessoRaUe6dvjuPoN1H30bKsuoAdSz098k31xpvKw02aVoNa21gY3W+euInH+IOwpXVjxqr1AQRefuI68cVjtX29D7mmTfUVzrEGm2B1S5KcjH3aNSAeqBTOfJFLJPpa/ntAXQmpbqgRIX7qMqONnM/bpPP51EtIYuE0u/NKD2xkh8kF0iS1G1ZNAuEtxMlSiVkt2+3Wlp6a8WdUBOELroUvjM0S3alU1xwOSqNRy8ObdOrbbVWSLdSSdHVHVDgH++f/5GQ2tHLqQDUSzL0KpBgCGGX8fxJgNZ8Yusl/TtmQ3You1Edp7/Hv5b1htTV6/WfT7nva/TYZi4kuCpzbfV0a54z7CrCtU5Leu8fNk7lvDr5Co8Nvk8oKyIcPu+TkqdVGiAHeYfwOlsBPYYwXqCJclPHALjov9aJ7rxQRWhRtkzTelb9l9E7g65uHv4dSfCAk2atRSUYBeQgFdVJON56ycU8HOnnFQrzEBWv301hPf1D5vOYRdk8OJ3oSFt4qJtw6gKTCNDaIAN6OXGg15/kuuuKCNBfbevpvHREGnUdar3Oiy04NbvXc51
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(64756008)(66446008)(76116006)(66556008)(66476007)(41300700001)(55016003)(38100700002)(122000001)(2906002)(52536014)(4744005)(38070700009)(86362001)(8936002)(4326008)(5660300002)(316002)(8676002)(54906003)(110136005)(71200400001)(7696005)(9686003)(6506007)(478600001)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z2dlZG1WZ0phODQvdUtFQXNQaUpFVTZhelBOR210eTRIOEpPQ2l5YnNzWDJO?=
 =?utf-8?B?NktJeG9ndXV4ZU5ZZXBpZDNGSDBMek1zdERFSzZvS0lPVzFHbDdDQXpYN2Zk?=
 =?utf-8?B?NlFSYnVtOWc2dm9PUkEyVTFPZVdka0ljNWhPTGoyaUdQalJIQUlRZ1ZlZzdz?=
 =?utf-8?B?Um5ERWU3TGxMU24xVkZSQVpzbUIwTVcxRWVRWVhmL2NLSEx4bllyc3RIalZQ?=
 =?utf-8?B?d2VDeEpiTFF4SDlTUjlDaytxem1sSkI5Z0hOMnI5cDJkQnR4ZUl1U1VYWVN4?=
 =?utf-8?B?VmVtRWwwRk11Qy9ybTluclFSeXJWK2V4MEphL2VFQUUza0NEWmV4MHBjdmND?=
 =?utf-8?B?NUFlWmpyT1ZPdDFOeDRUWFF2YXZSdWlrKzVweHNuQ3NJbTNIMnY5QzA5VVdR?=
 =?utf-8?B?bkEyMTExei9WMWFmRUg1cCtkRTBQME5YRFV3UUQ1bi80OXZsbkRneGZlY015?=
 =?utf-8?B?TExrL0FJUlhxRFJ4UE1yWklTaFFrRVNWRWcvZ2lHNWpueXNRa0NOSGQ0S1Vv?=
 =?utf-8?B?ZlMzZWZCZ2o4dUpMTWpyQUNQUTZ2a3IxQWVYaHN0K2I3U1RLZXM5NFh0cEU1?=
 =?utf-8?B?YXA0SForRXZGSFdLWXp6Vk5KeU1CcmhicmgySmtNcEZsOVhnbnhFRkUrODN1?=
 =?utf-8?B?TEhTNnVQNEpFNWNrMms5YlFGWUV2YitJSnh0UU9jcWVsMC9zT3RDYi9ORW0z?=
 =?utf-8?B?L0VkdWhNbGErSU8xZlBxMXZSU3JrUW5lT0xJcUYrUlBiUzhTK1cydWVJR2NK?=
 =?utf-8?B?Z0FlNU00SmkvbUJMenJFMUdXZGtBUkF3Y0tuNFl4TzhyNklRU0FUOFQ4dlJI?=
 =?utf-8?B?Y1hxVUh1M1NhUWlIVjFURkk5ZTFPNjdiRDg2bHhIRWt2MjVFWGttUXlWNktV?=
 =?utf-8?B?bitDUXRybjNUSlFpL3NzTFltR3BMVFhzKytyLzU2SWttSXk2Q3ZOVXRzc0NJ?=
 =?utf-8?B?RURQK0lhOWtnTDVBalZSSktTVU5kRkwvd1FzbFU0andXRld5bHlldWdnT1V3?=
 =?utf-8?B?V0F3RU9PVms1YSs3U2l2NEZMZks3NDFJaVArR21TY1lPbXdOM05OZlBlOXA3?=
 =?utf-8?B?N0EvOFlwVzhrZFAyTy9GWi9aV3E0U2lkNDFmOHViY1VMZ3lSTSt5U0dVSFkr?=
 =?utf-8?B?VGp0Zysrb1JXN01zdXBHQ2NPbzgvTUV5dUZMSU5JVnkxYUwrMDA4MG4xWjJO?=
 =?utf-8?B?WTJJMzJ4eGVTNDVySERVbkQxSGcvNW9mVlBXVHo0RVkvZTJxODFIRDZreldF?=
 =?utf-8?B?cHlUclQ5NFhNeGQyUzdMT3BDS1F2RUhvMVJydWQvelZYL0hjTlRhd2ZaZnFG?=
 =?utf-8?B?M3Z0UWZzam9wT3k5WEJtdnRaa0lpMGRuTzZEeHkxSWxrZzB1S1VKaDlLb1Rz?=
 =?utf-8?B?NnNVdDZMcExpS1ZZU0puZWdsVmFzenIybWNjbmQ1Mm1YWW1hT090YTRwVFds?=
 =?utf-8?B?MlU4TUl1Y3Jsd09UNTZpdG1GUGpsNFYvTWJ2Q24rMU1YZ21ub05wcDVGN0Rn?=
 =?utf-8?B?S0l0Wkk5TUI3MXRGeXovcHo2bDlXY2FnNU5vcDZCMEJkRFhOSGcrYmYyQWtv?=
 =?utf-8?B?bTUzaVl1UlMvclorbmNRQ3AxVE9nZmZHRDhHRzB2L3RpZjVoRUl2Zlg2Y2Fo?=
 =?utf-8?B?VWo3WDdLa1pWblZ4aUFQb0hYblpRMm15WFhlcGxVOU9PTkVzTDdPdHhkSWhY?=
 =?utf-8?B?bmVJMDI2ZHRldjBmS2M4YmJCQ3hFa2UxL1F1NUkzbEswSkJ0cldTTTNvcjA0?=
 =?utf-8?B?Um5UTE1WbmRROHlsM3ZXNTZDdklNbk41R1UxZE1QbkxSRU5pajgrWUFkeWZS?=
 =?utf-8?B?dlJ2R2tQL2I1YXQ2T0txWjE5ZG1DMHhOWE1MRm11RE8vMFp1Vmw0T2xnckNP?=
 =?utf-8?B?cmlhb1AzR1V6bFE5cUpta3ZSaUF5VFRFR3FGbWxQZHdJb3FFQUcxQnk2bHN1?=
 =?utf-8?B?ZmNYNW5zT3lTVG1LanorbUZlUFlsMllaUE45SzFtVlN6ZWJ3T0pkMk1LdW9Y?=
 =?utf-8?B?bHQrMk9lUUc3VFpzS3plYm5UU0FjWUpsNUZrQ29sSTFVRktHaUV0a0xCOUMr?=
 =?utf-8?B?a2V5ZlZpeW9XUko1OCtxVG9FdFB5dit2dzVBM3k2WU9wb09jMWloWWNyYWMw?=
 =?utf-8?Q?GqK0+vRxjAY97RwwzUgNQVkNJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d11dc9-8e8b-4606-8d93-08dc2ef5b4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 13:46:41.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMoiRMlM7L/fL32WNlHGueqO4TYxVFwji1yJ+ixMKFWpr7OsoUEnxPqCi1O0z9Wt8Z47DRtpafQS0TFKoPTZw41/gr1G5K4gXl9FvI+4qsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Feb 2024 13:46:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15907

PiA+IFdvcmtzIGZvciBtZS4gV2hvIGRvIEkgdGFsayB0byBhYm91dCBnZXR0aW5nIGEgcmVwbyBz
ZXQgdXAgb24gWW9jdG8ncw0KPiA+IEdpdEh1YiAob3Igd2hlcmV2ZXIpPw0KPiANCj4gV2UgYXNr
IE1pY2hhZWwgSGFsc3RlYWQgKGNvcGllZCkgd2hvIHdpbGwgbmVlZCB5b3VyIGdpdGh1YiB1c2Vy
bmFtZSBhbmQgdGhlDQo+IG5hbWUgb2YgdGhlIHJlcG8gd2Ugd2FudCB0byBjcmVhdGUuDQo+IA0K
PiBJJ20gc3VwcG9zZWQgdG8gYWdyZWUgdGhpcyB3aXRoIHRoZSBZUCBUU0MgdG9vIEkgdGhpbmsg
c28gSSdsbCBmb3J3YXJkIHRoaXMgdG8NCj4gdGhlbSBhbmQgY2hlY2sgdGhleSBkb24ndCBvYmpl
Y3QuDQoNCg0KQXMgZm9yIHRoZSBuYW1lIG9mIHRoZSByZXBvLCBJIHRoaW5rIGp1c3QgYml0YmFr
ZV9wbGF5Z3JvdW5kIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQsIGNhcGl0YWxpemVkIGFuZC9vciBw
dW5jdHVhdGVkIGFzIGRlc2lyZWQuDQoNClRoYW5rcywNCkNocmlzDQo=

