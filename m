Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C3C5CFCF
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 14:35:32 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14198.1786718126059605604
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 07:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=GODZSm2b;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.62.25, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrG45Te1rm+B7lhcB+YHzrL3XVfkN3b53cffPnxq/DEqQ73dezH2acb604Ezb/30c219Cy7WGIdahB3i5EAy4ZgZXWpJnmZjfa88bYftVveq/yEyBIhifVcwnFQW/kyo70XFFnf/6DBc2NQQWbqHZgo93nHuaDZMf7A6pOJSaeHV8bQqJm8AP+WXiJjSotVWUHv3nrt4MS0LwaDKN4m80G5fNVFEHPvnAVGvDr12EjcicdDSWM9qOMhYey5GiVwwHEoIWJ8Lc+Si9KAoHJs+RkapaMXw7xRL55f2w97g594EievkzWbYbZTndhPhv6MjLs1VFcnyyx+kyyrxyhkYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz/jJcw+UwhFoYHyAYVzjASgRk5kNv0Bp2+v+81ifSU=;
 b=tQobQM8hPemTsW3vI8VmY7NI6YREdSOpl9J5XlXp39bukydAMBqIGKlAimPNs/WBhtC4D0MXVu89zkxzoTn5XPOhWSWQ48nr4lasbB6aREXLdHi/dCijqgzdoK7RHlDaGW7w0pp1yN6Q8yQVbHG2EOCMrzxF8WmyuLImIAIcMOSIcB7KzNZyw4jExUQKCWu1h37Lz0DfktmD8IxiFdVEWZjoMyXbtVN/UuX9wt+cUr9Vze9C7F5E8dMDidOf0nWNqaspQjAvpgtsQKOIYMC+4sDZHU/6PkmalWsOpFSeIQ8ksbGeFllpsnvZe5OKsoSfMYQ6iZJ6YkKbtTYq8pENhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz/jJcw+UwhFoYHyAYVzjASgRk5kNv0Bp2+v+81ifSU=;
 b=GODZSm2b6rUlAbNkgTiQyUoEFYpNuJef0e2yagnWqffM9l7QJHkuPCA8PU/bI4UZWr1lW475LVkB3Vyq4DnCQvXerXu4D7ewru8+uqPpaSDXCUxpPt4AZt3t6TCuwOeK848PhqJtQ5cefGdfSIJPtXazow3pt9qA8pVjCwZ4yoB+pxPgpVEhyOA0CY9Oim+clbC6a8gWVXAtnmGNiQLfPXSB7HQXkVkPjX8DKNS1glJCEMmCT8gi1xvrnDyE6TQXmVJm1cu3uf/hSbP8AWJxsrY5sivpAH/4iqlJmGOhzzD3gMbjya7EaeVEiPVITIH6X04QCZwIhhNuTmGwcH9SBQ==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DSVPR12MB999262.namprd12.prod.outlook.com (2603:10b6:8:422::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 14:35:22 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:35:22 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "rob.woolleywr@gmail.com" <rob.woolleywr@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/2] pyproject.toml: add setuptools to
 requires; fix project structure
Thread-Topic: [bitbake-devel] [PATCH 1/2] pyproject.toml: add setuptools to
 requires; fix project structure
Thread-Index: AQHdKpMIoHV0mo8UGECxk6go0SZm1bacpB8AgAD3yvA=
Date: Fri, 14 Aug 2026 14:35:22 +0000
Message-ID: 
 <DM8PR12MB54309AA576EBC6F6EF5051BA8BDA2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260812194433.40594-1-chris.laplante@agilent.com>
 <CAGAhMBw3AeCPhybRpGBz+z-vp3xs8wWzaUvkCWaPwWhHqpxCrA@mail.gmail.com>
In-Reply-To: 
 <CAGAhMBw3AeCPhybRpGBz+z-vp3xs8wWzaUvkCWaPwWhHqpxCrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=50cf3420-6d27-4668-8c3a-66fe0c48ab85;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-14T14:23:51Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DSVPR12MB999262:EE_
x-ms-office365-filtering-correlation-id: 453f84d3-9760-4be8-6494-08defa114585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 5282H0UOFUZC24Vz7oqfWn0dThzIqj5WzLTMvqimmUZDsijkbrwzjiiIJgZwbnni1sOC7ET8+tdU/uRjsV7NvyYROaj2EvI5cYaYRMbJwOjYNxBv55yArUH45LyecavN26ePVwko1ISwKbYhK7WePysb/TyN/KRMZUafzE1y8TBoUwWcxN1mbsQdZ8/fQjEtT+ektAav1MkljsXvXgjPRGwBUyvQuGuyOhFtYino4pekY8H4/LmhOlnuWimMOhX5f0xuIznL0PQr9urEipErd//VVtP2vWzeJzw/yUCWaQuFD0euGXZg1b38HdjGwUceAqa1OzqRhkp3/o0NSmqBk5noTCyc+c3au89cMpachK8fQoaENmB9b+/0ac9zkKl8NsM8LhcLl6UsyddtGzflbrYeSzCjIwbMnQR1/2NbwmovqYrzUG292wzdCeMpww2XW8lg3a6BXRzD2CptVMgYEtoFMbhNItKujtGHWGth8lJIA3lhY9ut/H8fCoxMFZG/CQtl9ROh5s9ziQCnG8sLVeZiW/Aoqaz6iE8TVEVuuw2qhbKO6TwdHjE403Mu9LreVCHywmLCxPh8bxvE0DOxlMuS4DDl8A0YAtjm5IilRXL3RHSbo/qAPwPxIxtCT6uUgScNO1HshsA10z9hbm2ux+dMoeycts5TSvW9qubDWimN3NdDHsy5YyLcsu28QG/ng+wS1djRPFJlBGDY66qYhzX2lWT7ERQL6hWRctIzQWg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cFk3d2dHYjVZU2pJYXRZSzRUZFI0OVhzOGFwRlJLdUFwQXljaDduYVBMRExq?=
 =?utf-8?B?NVlKRXhoUmtwQ3hwVkpncmR6OXF1WS9WN2xXdzIvR3ZRbmZoclRtNkxoY2Za?=
 =?utf-8?B?UEsxam9oUnkxTXdEZ1pzNlhDS0FQTzhFWUMwRXRodk9sSmg2KzVxU1JnSnV5?=
 =?utf-8?B?UkJCWTI5V1VSazNPNDh5UDJKNnp6akorZ3d4YmdNL0s3bHJlRkZxS1VXRlVQ?=
 =?utf-8?B?YnkyTllIekkrTUZLNExIbnRrUlB6ZW05a2xob01hRU5kMWZsM2c0Tlo3d3BW?=
 =?utf-8?B?RUtZb0RyalhqZFhDTGNodVRNUmNLNlpBWVRDTDJLdm5iQzZaT1RzcVVUNVNh?=
 =?utf-8?B?cklOUXBVOUFSVS9mZUxyWm5sWEFScnJBQ3RLSzJURjNER0lXbElSM0FhcDdi?=
 =?utf-8?B?VllWS1Mxa0NkWG1RbUEyMHhHWGpZUGhzZEV1SmRSWlJxcUMyTEYxMW1jRkEr?=
 =?utf-8?B?UWtXR0E3UjFwU2hManBTU21VVTFEWDBBTlk5cVU1bE5hYjh5aS80RHM3ckRj?=
 =?utf-8?B?Ymc4Z3VHRDQveGVaam1lajR5ZlQ4alNNY2dtVER2K3NZL2RqdDNvdHYrbmxQ?=
 =?utf-8?B?RzkyNUVRZzRoWUJFN1hFUTYrSDdXYld6eXIralNjd2tWRDhiSjNvcGwzRXpz?=
 =?utf-8?B?MlJBcGMwL0xacjJFVW53aFYrL0g0bk8vd2lEdXUyT09hQzBRNTdFYk5DVjM5?=
 =?utf-8?B?b2dtUWtnVVg5UkNKZVhvNEZobk40cVpRVGJlYzNrWWVaY3RlNVRVY2NHM2Zn?=
 =?utf-8?B?Ym5Tb3BXQnIxWmErejlCZlAyMkxxeit5WHY2ek9TWFF6b2dTVUtLMEtsNitL?=
 =?utf-8?B?UXU1c1V6a1N1WkdzWEtMVjdURU14YXNHQi9uNHpsdnNQSGpydEhFNWdWRCtM?=
 =?utf-8?B?VjBKVnBRTFNYNzBWM2Q0RWdkZjVBMmk3eUMzS2ZNeWJiSVRvc3pSaWN3UFpm?=
 =?utf-8?B?eUlES1JiZUMvV2JoY2x2ODIyYkNMd1lMSW1waWNHMUhLTWl2bnBmMUxacUgw?=
 =?utf-8?B?QVkzSzdzOTNsL2FxMlk1dU1lTFQ0aC9pUm5YZ1ZjNXExUGFsRUNRb0IvMmhs?=
 =?utf-8?B?U3hMU1pLT2VkS3p3Vm0vSXlBeENuWk1wa0xIUnJQS3ljOUVTRjVUR3djcmIz?=
 =?utf-8?B?UGluUFV2SjBXSDJRMnAwN1U4YmZNWTk2dnp1K0tNcmFHcTlvbDhkc0xVVmdi?=
 =?utf-8?B?eWNiaXBrekxQSk1WL3Rkell4cWFsOGk4Zyt1Wi82Qm5KTHRxZmg0bldCeVNE?=
 =?utf-8?B?SzNmR24zWSsxZHlUVjZMeXllSUlaMFIxS2RKdDdzZ3VCYjFKdWdYc2NxQStL?=
 =?utf-8?B?cFVyc1BzZzZ6VjZPS21ETjdNeVZPTWRNaGZoMFNLY2dYUHVrdlc3dGN2bzdT?=
 =?utf-8?B?Y083bkw4cjY1TkR4U1BSZlg3MFo0MFZNSVZmaVA4N0d6VStFSUVSWHNFWHdX?=
 =?utf-8?B?a0FLYUJ4TE5PakxxKzYwZFNHTVpWQXBvNnhjQUM1VG0yWXFYRk5uQnRkSXRT?=
 =?utf-8?B?SEx0Z1lhN0RsdEJGNFU2bFBWdHJ4TkQyU3FJamxYTnQwYThqTDA3TVJNNG9q?=
 =?utf-8?B?UDVLeVh2OVErdEJzVlE4QlNVVWt1YmVpQmhVSkpFTy9Zc0hBRDJ1MlNGdCt3?=
 =?utf-8?B?aEpzVDVDMDhpOW5EZTFjVFBUM2g1bk1pVWxmU05jMytSZGMrS0tWNTcxUU5G?=
 =?utf-8?B?ZmFKRmlpQnhnVHBaMFZPWHg2d2lEK3dLT1R5V3VNU2MyQ1k4d1A4T0VFazVr?=
 =?utf-8?B?YjBzQmkrS0RPcGZxVjRURVp0V3FSTTF4Wi80ME5FSHhOY2xnR0NVSGdiU3dh?=
 =?utf-8?B?ZFFEaEhFRGRVMktLMk5vTE9pSmMvZFZxMml1OGxWY1NwQ0I4NGEwTG5QNXRY?=
 =?utf-8?B?cjhKS1l1OFBjZU5IYm1GSXJpVnFzZ0ZVZ1dPbU1ZQXJiR3NPaENPVTJQb3Bk?=
 =?utf-8?B?a2tLdHArdE9OZ1lIcWNISXhKMW1XZ0R0Y1MxWSs1b0gzb3Vvai9QSS9hcFo2?=
 =?utf-8?B?azNqeE1kR0xtWVdNUUdoM1lQQUVhMmJkbXJGUWRRNlBWV3JNSUNiTHEzb3dh?=
 =?utf-8?B?eitLRS9OdTF5WUtwT3IxWkh6dDd5VnBpVmZPWTk5VDhJSnl4cFFmd24rLzEy?=
 =?utf-8?B?NTJiY20wOWNBTVZtUUZDcTE2NXlvTjBNRHdIc3JYSUV1RGsxcmhTNDREQmtC?=
 =?utf-8?B?UnJMUmhKMzJxcitxdXVhYU1WaHJqVkJSblhDU1VGZ2JnSUdmNDl4cHhCWU5S?=
 =?utf-8?B?eXJwUFdFaTcrczdyVkJXYnZ6dmFrY05iTExweENWV1ZRWnpLa1hLR0dKR1F2?=
 =?utf-8?B?UFFEVmRROFV3V1JBUXNHWWZRZWJkZ0wrZW5mMDdJcUtxdGEzSXZoQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453f84d3-9760-4be8-6494-08defa114585
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 14:35:22.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ab7H3bcnPU5MzM3Fx0Yo2OBMLumNQ1ZLrqgzpWpI9/r77TKi9zhs0dFsr/yeNdkhCPY5g8HiFnDCdplQwnxzMWk4VFDvBPngOytXrLvRPb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999262
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 14:35:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19937

SGkgUm9iLA0KDQo+IEkgdGhpbmsgaXQgd2FzIGEgbWlzdGFrZSBmb3IgbWUgdG8gaW5jbHVkZSB0
aGUgcHJvamVjdCBhbmQgYnVpbGQtc3lzdGVtIHNlY3Rpb25zDQo+IGluIHB5cHJvamVjdC50b21s
LsKgIEkgaGFkIGl0IGluIHRoZXJlIG9yaWdpbmFsbHkgdG8gdHJ5IHRvIGltcHJvdmUgdGhlIHZl
cnNpb25pbmcsDQo+IGJ1dCB3ZSBjaG9zZSB0byBpbXBsZW1lbnQgaXQgYSBkaWZmZXJlbnQgd2F5
LsKgwqBJdCBpcyBvbmx5IG5lZWRlZCBpZiB5b3UgaW50ZW5kIHRvDQo+IGRvIHBhY2thZ2luZyB3
aGljaCBpcyBzb21ldGhpbmcgd2UgYXJlIHRyeWluZyBub3QgdG8gZG8gd2l0aCBiaXRiYWtlIGl0
c2VsZi4NCj4gDQo+IFdlIGhhdmUgYSBzZXBhcmF0ZSBweXByb2plY3QudG9tbCBmaWxlIGZvciBi
aXRiYWtlLXNldHVwLCB3aGljaCB3ZSBkbyB3YW50IHRvDQo+IHBhY2thZ2UgZm9yIGNvbnZlbmll
bmNlLg0KPiANCj4gSWYgd2UgcmVtb3ZlIHRob3NlIHNlY3Rpb25zIGRvZXMgdGhhdCBmaXggdGhl
IHByb2JsZW0geW91IHNlZSB3aXRoIFB5Q2hhcm0/DQoNCkkgZ2F2ZSBpdCBhIHRyeSBhbmQgZ2V0
dGluZyByaWQgb2YgdGhlICdidWlsZC1zeXN0ZW0nIHNlY3Rpb24gbWFrZXMgJ3V2IHN5bmMnIHdv
cmsgYW5kIFB5Q2hhcm0gbG9hZCB0aGUgcHJvamVjdC4gKEkgdGhpbmsgd2UgbmVlZCB0byBrZWVw
IHRoZSAncHJvamVjdCcgc2VjdGlvbiB0aG91Z2guKQ0KDQpXaXRoIHRoZSAnYnVpbGQtc3lzdGVt
JyBzdHVmZiBhbmQgJ3Rvb2wuc2V0dXB0b29scycgZ29uZSB0aG91Z2gsIFB5Q2hhcm0gaXMgYmFj
ayB0byBub3QgYmVpbmcgYWJsZSB0byByZXNvbHZlICdpbXBvcnQgYmInIGltcG9ydHMuIEluIG15
IGNhc2UsIGEgLmVudiBmaWxlIGNvbnRhaW5pbmc6DQoNClBZVEhPTlBBVEg9bGliDQoNCmRpZCB0
aGUgdHJpY2suICBCdXQgdGhhdCBpc24ndCBzb21ldGhpbmcgdGhhdCBzaG91bGQgYmUgY29tbWl0
dGVkIHRvIGdpdC4gSWRlYWxseSwgd2Ugd291bGQgYmUgYWJsZSB0byBhZGQgYmFyZWJvbmVzIHRv
b2wtc3BlY2lmaWMgY29uZmlnIGZpbGVzIHRvIGJpdGJha2Ugc28gSURFcyBjYW4gYW5hbHl6ZSBp
dC4gZS5nLiAudnNjb2RlL3NldHRpbmdzLmpzb24gZm9yIFZTQ29kZSBvciAuaWRlYS9tb2R1bGVz
LnhtbCBmb3IgUHlDaGFybS4gDQoNCkknbGwgd29yayBvbiBhIG5ldyBzZXQgb2YgcGF0Y2hlcyBm
b3IgdGhpcy4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==

