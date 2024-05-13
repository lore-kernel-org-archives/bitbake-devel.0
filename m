Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54617C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 16:20:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.84])
 by mx.groups.io with SMTP id smtpd.web10.65036.1715617195448822481
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 May 2024 09:19:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Kvs9Cs8j;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.100.84, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez6Sr1u1cY/cux11rMAgfw1/6GLxVX+n5CLqJG8lGA4J6carCzmXCVVZfEchShL/H7rpSMsbdBpuV624zYCJWzYKySd5u9kVVqgEo2+oxhhXWlfSSd4IXJSjV9tSrMyeC4Fk72lv7O3dWLS4sOiks27xgsxoPTjrm5uAxjfLpcDLXCPloL6eazSMVcn2ac0TfUmQosnKEpvdRZZOadzzxtZYEVl8Kf865Ax2xEiQFQIDPY5XLPgdPjreNhfzaGR7Nio4gfU+Yl6siZ4v4zOKbQbYpZfIyX70ZgDApvEkJ0eeJRoCT/EBSyZ2hm13G9p0Kn1KKir7l/kfyVLEL+awOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmC1jRV5jahlCKjAkxe3UPLVDaV0K0aNsu3psFRRSBQ=;
 b=d1fLkvtJfOry3v8UVrNZQcaGGgf4amOKCsmZ5Uwu2wV2SN/a6toqiCxL5HQoDKiZxF0OyoJuvFjITUKLnwnro7aiLknKlkgliy5aHJdMkcLCnxl3FP+vkbtWbqdPgsV3Va8tm2rqJ5DDbUQqaX6awPhaDIw567wZpCWKtfM7Cm+aejMHbLwV25/6sVZ/fi5BPYrd+kgI24t1jBPgLDRqSGZ+Ig0LD1ciMgu6E2z6CrBUj+QEqtXfSsjy6nc5LUyMY7OvZrjyI4lPJ09GTGgEILx7KXdDXnSbCPjmaZ9pVIsywJCIbitdinYK1PxvrOlZU/F9qppI7i1XgNrd9H1Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmC1jRV5jahlCKjAkxe3UPLVDaV0K0aNsu3psFRRSBQ=;
 b=Kvs9Cs8jP6dBvl+YqaGVAUjqiMTaiFUny7HK2OSAWDSWklqKD6gZsYq+9KUiD1LYjTwezXSBMT06Ij1trJ4mK6ZADGrEQjn26gBFFuJAkQfrae3nVmFABiQQ5f8Q/zDHwsFQ8yTZmld15sGvKF+SbvigCW9867ghYqkkOhUNyO+2ihdh53432aA3VqqBRAhJD5/29IlxKFlCyTWSbWeRwOG1/t2NZT+m4Yq87CTHj1yf3Kk8NJQ8RmcNXMnYUjMpLGN3MGAWhYFN+wjjNZfmlrkfvait3P8Xh1v7PVNLPjw0e2farWW/PmGl6Ha+ykJdnvbQfEQAYwmW9c1eK2gtUg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 16:19:50 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::52e3:4980:d382:6e60]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::52e3:4980:d382:6e60%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 16:19:50 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Michael Halstead <mhalstead@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "behanw@converseincode.com"
	<behanw@converseincode.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: RE: BB Datastore Playground preview is now live
Thread-Topic: BB Datastore Playground preview is now live
Thread-Index: AQHapUWWn41IqKNp/kuGIX4/Fwdjr7GVVHeAgAADYGA=
Date: Mon, 13 May 2024 16:19:50 +0000
Message-ID: 
 <DM8PR12MB5430CB5D36F560E1E0ADA3B78BE22@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DM8PR12MB543006B728DBC2C6E7077D7A8BE22@DM8PR12MB5430.namprd12.prod.outlook.com>
 <CADfgfoZjbarji4my4mx74Fap-nx0c+xqO1GNTAyrOMqk4j1BfA@mail.gmail.com>
In-Reply-To: 
 <CADfgfoZjbarji4my4mx74Fap-nx0c+xqO1GNTAyrOMqk4j1BfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=325f7759-7a89-4d65-9e5c-bf1f72281a48;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-05-13T16:18:29Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA1PR12MB7199:EE_
x-ms-office365-filtering-correlation-id: f8327ac3-e666-476f-d052-08dc736883e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UTJCL3J0L3lLcnBvWEdzQzBXSWFHV29iQWhWTG1adGU0NnlRNE9SemZMQTY2?=
 =?utf-8?B?a2hRMkNyVmVWZTJQUmxoMGZqSnZDZjM0bC9RZFgwTEVJNzNPVk9HcCtaeVFu?=
 =?utf-8?B?a3ZYUll1RUNHN1NLSVRsVWZJTnF5Qm1CSzc0eU5CdWtka1B6MzRnZXVPN05S?=
 =?utf-8?B?ZzBGRTRxckxVL1RRMDZKai9tbURNeUozRktUek9YNDVIK1plcVYvWFBlZHRH?=
 =?utf-8?B?OVc4dnN6YnVHbWM1eGo3UmtOVWNsWEw1MUVGUHYwZERHQXBMY3puU3JENXg0?=
 =?utf-8?B?U3doU2tLeXJNNFVyYlR5bEJTelZjY2JvaFZKcTVVR3FZR1d0VjhJaW1QYTY4?=
 =?utf-8?B?Zmw0RUJRZUtkemtidWdHZ2o0QlZnNmVYOTR3L2kzWm0vZWNqK2VGOGNSOFI2?=
 =?utf-8?B?OUtsM2l3d3ZxYktiU0YyVkFwczBjSVlRcTI3azJQWGxwdEhueThNM0lRVnl6?=
 =?utf-8?B?MzMyVDN2UWZudzJFc1h0TVN3cS9UUVY1OFZVNnRpK0JIY2Q5Z2t1RkE0RWxi?=
 =?utf-8?B?TmtLTHNxWTZMTVNYL2RmakxlRGlHVVRnM1FNQm9IR1pEaUxVVURzaEpDOU1N?=
 =?utf-8?B?TkhiY3NRWG9uNS9vb01qWkJvaGNvR3JyZWY3QUJNcEU4MFlHSHdIZVFQU3hx?=
 =?utf-8?B?ZXM1VC9JYzl3T3JVL1Z3cDh2OHF6MDBkdmJZYjZSRFRGQ1hCYmxKNXRaazJx?=
 =?utf-8?B?aGVVUXZBZFlHUWtmdnBtTXU3VG1KZVlyNkMxWjVMY3ZkKytoK0NPOGRqdmJo?=
 =?utf-8?B?bkdkU1JFcXpvRHU3L3FCT2lBTHhzMm9ISVEvTklxcm1qREhhUXQvVjJmaFp6?=
 =?utf-8?B?UnNSbUZkN3J6UDVuL2hxcTExWlFIL25LUlQ0dXJ0YmJvR05yTjVGaUg4UExD?=
 =?utf-8?B?ZVVYQThKN0xzaGRvcDN2ckV5bUhMU3JteXNUSng2dXZVNFdybzhoT3Bnb0Nr?=
 =?utf-8?B?YTJqSDdjQTBuRVZVY0xXT1k1ek1tYklPaThBOTlhZmNDemRCUmdGb0oxcitk?=
 =?utf-8?B?ZFVXeXU2eHdWQnpNemp3UGx4NkM4YmRGS1EvK3FHY0RvclZIN09xK3hNU0l1?=
 =?utf-8?B?aXRwT3dWMXlGaTZyVDNxeXNBNmRyNDg2RnlJSVNJSFh1bnE4dVBiSjNMQ3Qr?=
 =?utf-8?B?akNmckNEczM0QzlwbEZpUFdwYzV6aWRoYnJvdHBRbVBQeGY3SUVJNlVGZm9T?=
 =?utf-8?B?SlBWZ1VaVXBjZURPUVQ3QmxJRWh6REN1ZU9hTllGT3NlZFQ3UWcwREVWWFEw?=
 =?utf-8?B?cnkxUm82ZmFxaFM4NVVlQUxWMG5tZzhOb1dUbUJtZ0QwSTZyZG92cG5aVGVC?=
 =?utf-8?B?UVNkNjVneVF6ZFdYUlZrZlpQbEpkRWx6VGM2ZmVtakM2bWVJckIzRklCMGVN?=
 =?utf-8?B?SndvWWlOZDQ1TnB6TkFHbFhWZHo5NTNnVmQxS0pwbXFDN1gzZEZhNkl0TWFZ?=
 =?utf-8?B?UkFzcmFXdnY1b0dta1VjRmFzYUMzTDdxSW1ENExQN3kyUFJUVUNZM3IyZWRK?=
 =?utf-8?B?TVBuTlh4UzdQblJQeTNJVUZSYkUvUloxZDRDWmNjWjBTU0RodVE5eUxVSjU0?=
 =?utf-8?B?bElGaTNCSXp1blBiTjEyU0xmR3BacUd2NDlwRGJ6SW5yU3ZrNDVoVzgzZURm?=
 =?utf-8?B?NGREZzlUaU5XV2Z3OWIwRktxTm5XSXFvZEtHNTBWOWQ5YWlQalNJVE1PWjFC?=
 =?utf-8?B?ZjNUU2F2YmIwRy9TYVJicWxha09hR0QxSWtIcXMrdlF3MEhlSWFQS1JRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dGpEWkVydStabExGQTB2b0ZuQWVnTUphTFZZK1N2L0hQVFQyRTZNMG5xUURH?=
 =?utf-8?B?SUwwNHA0cEMwbEdUa05HWDZua2w5QXJES3J0VVE2UUQ1ZWRQMldzUWRVbmtO?=
 =?utf-8?B?bFZzTmEzVUE3OXVnbXhHSW5lVnNzWDUxM1ZueEdNVHNkdmo0aHYwbkdHWHZ5?=
 =?utf-8?B?T2R5VTdYRjB0QTZYYmZnbm5hbTZ6VXVTUE9UejFNQnVzbnZoTjBxa0p1cHJB?=
 =?utf-8?B?NjlJaUdobjZTYVY3RHZUbkpzRkFWYXFLSFhkSitDNjNTZ2JPdytESENzWElw?=
 =?utf-8?B?ci9QY251TDNkeW5RQzZHaHZPekdKMkNCb1Yveml1eDJWRXJGTHBrYWpSblYz?=
 =?utf-8?B?S25mTzlCRnFlQ2ZWTWtyRWdoNkMxQTF5dnpPUEJreG9ML09McFF0L1VkK2J6?=
 =?utf-8?B?V20wYTJTaU45UzdzbTN1RkEyOUc1MFFLaXJqa0ozcS9sRGV6NEE4ZENtUER2?=
 =?utf-8?B?YnpHNHNWV1RONnZTNlNsK3Bid2RPblloSFRqcjA1VWJ1cklnN092TGRzZXBm?=
 =?utf-8?B?VHkvSFZmNTZxUmgxREdQekIxdmpNdGZucnJ5SDJqckxFZGVObWU1dGQxWEVo?=
 =?utf-8?B?dXpld0pNS2UyK0pTbzd0MXp0aUJ1NjgwNTR1ZXRsSVpRQVZqcWNwT1lIOEtZ?=
 =?utf-8?B?SG95UGJLeVVKUmlxbElvWjVRS3d4cU1BaHJxZW0yMjJPNlNVL0FFazNaL3Bz?=
 =?utf-8?B?czk3UVNCN0JqeExaUE9wZm1peWdTWVJaaUgvc1lFRCtvTzBITFhjQ2NUdFhp?=
 =?utf-8?B?UThzTUNGdnQ1a2g0aTlOTmMyK3N1bVNmY0NYQURsSzcyWjhRbnIrRytFRUQy?=
 =?utf-8?B?VXlDMlpOb1ZYNktGbWJyTXQrL1NBaGd1a2FNcFQ2eGxnZ1pzbmVxN2xWYzNL?=
 =?utf-8?B?djlOU2x5MmloaE1XY0l4TGhoeXl0Y2FGOXppVnhPQ2x1NUJMQmxUKzMvL2FJ?=
 =?utf-8?B?cWUvODZtRnFaT2plREZLUVI4Z2tRTTNySkR2cHZjSXd6YTV2aWdBcW9KMlhI?=
 =?utf-8?B?Q1lrRHBoK3RBK2ZhY0tkQ3lvODlheDBhQVQ3ZmI5Vmp0TklydTl4YTlWWVdk?=
 =?utf-8?B?MktjT3cvQzg1ME5DU2hKeGtmekVSMWtVUnVSN1VQcllNeTNLMzA4Y1p2Tklj?=
 =?utf-8?B?QXg1NEloU0dyaVMySHBOMGx4U1Z4S0dESFdWU21uelBiK1czOGgwZUhXTW94?=
 =?utf-8?B?TlRvUTJCUzNBVUd0MmNlM0lGcFd4cVVSRVZKekY0L21kWDNpKzBvT2RHZkxR?=
 =?utf-8?B?MFhxUzJIS0kvRTgvTElsZEcrSkNSdW5aUDFHN3BVN1djVml3M1lQMEo3ckZL?=
 =?utf-8?B?TjdqMERMdVJmZ3huSjNpRkVjWWI2ajk3RHVxMkh3THV4TDRwZEpiVVNKWStS?=
 =?utf-8?B?U3p0Y2VCaW1NL09KMDRqa1VXTEpGMWtVd3JVcE5nZVZYUDNjQkUxUVo1RWdx?=
 =?utf-8?B?UzhmM08xUjRXczVzWUNVY25jVDF1eDlWUy9tdERRTzBVMVphcEdVUjJENHRq?=
 =?utf-8?B?TllSMTArNGRnLzZtdDA3T3pMNzR3NTNOejE1Q1RJYVZuVENqN1NBR1hCZ2M0?=
 =?utf-8?B?MlI3QnpqWTh6d29JRFV3VmhNYnR1a2hOUVF3ekVoclpha3VtRTdya1Qyck9k?=
 =?utf-8?B?STNwWnorb0ltN2Njb0cxa01GbkpzTzAySmkvaHJUMDJaajhWTUIwTnAzVUtO?=
 =?utf-8?B?Vm5JVUpJQUd3MDBLVmFyczhEZk9aZmFyTUk1cXJmLzBITEYyb1FpYUkxUGpR?=
 =?utf-8?B?QytwREdubkpYWWxJWno5NUdUWW9mamlyM2QyYTEwdkFuSzJVdWl5VS9GaVE0?=
 =?utf-8?B?WWJKdVpqRUFDUVZFUDAvQTZ2dU84SktOOWxaM1B3TjZ2MVNSNHkwTWpYRTk1?=
 =?utf-8?B?dWY3NlZsRmVwNnBhOU5NemkxMFdoZDRLSWJoc1FWWVlKdXE5aVJxTDNVRmhZ?=
 =?utf-8?B?QXYzZnh5L0Z0KzBSOHpsWmFpVlljS0luSmpJYmgvZGlxbVUrcVdIajNmNGlX?=
 =?utf-8?B?OEVYeDUzeE5SeXRtbUJabkd4TzJla2tQZDIway9rcEJub2hoTUVLYW50eWVK?=
 =?utf-8?B?cnZIbDhSTHZacFlOK1BJUWttRk9TTm1HV3pNZnFMTzVmWkhqd1VqUXJtWGtn?=
 =?utf-8?B?UjFOa082bkcremlLd0x3Znc2NGk4M1J3MzBnMVVvUE56N1FyTGxvaWtwdGkw?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8327ac3-e666-476f-d052-08dc736883e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 16:19:50.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJevT71Y8b8qqd1K9ptwLDp9aYMtK3vg70r3MFQzt+XKtK0oBRLgzW9GkvM82RsZIXE5xtKIbvqjsDJhVpgvE18CkEzlNGL4ccZ0boLF6yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 May 2024 16:20:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16210

Pj4gSXQgaXMgdmVyeSByb3VnaCAtIG5vIHN0eWxpbmcgb24gdGhlIHBhZ2UsIGFuZCBpdCBkb2Vz
bid0IHdvcmsgb24gbW9iaWxlLiBCdXQgaXQgaXMNCj4+IGFscmVhZHkgdXNlZnVsIHNvIHBsZWFz
ZSBnaXZlIGl0IGEgdHJ5LiBJdCByZXF1aXJlcyBhIG1vZGVybi1pc2ggYnJvd3NlciAodGhvdWdo
IEkNCj4+IGhhdmVuJ3QgY2F0ZWdvcml6ZWQgd2hhdCB0aGlzIGFjdHVhbGx5IG1lYW5zKS4NCj4g
DQo+IFRoZSBpbnRlcnByZXRlcsKgd29ya3MgZm9yIG1lIGluIENocm9tZSBhbmQgRmlyZWZveCBv
biBGZWRvcmEgNDAuIDspIEl0IHNlZW1zIHRvDQo+IGhhbmRsZSB3ZWlyZCB3aGl0ZXNwYWNlIGZh
aXJseSB3ZWxsLiBCb3RoIGNvcHktcGFzdGUgYW5kIGFycm93IGtleXMgYXJlDQo+IHdvcmtpbmcg
YXMgZXhwZWN0ZWQgdG9vLg0KDQpUaGFua3MgZm9yIHRlc3RpbmcgOikuIEkgY2Fubm90IGNsYWlt
IGNyZWRpdCBmb3IgdGhhdCByb2J1c3RuZXNzIHRob3VnaC4gQWxsIHByYWlzZSB0aGVyZSBzaG91
bGQgZ28gdG8galF1ZXJ5IFRlcm1pbmFsIHdoaWNoIEkgYW0gdXNpbmcgdW5kZXJuZWF0aCB0aGUg
Y292ZXJzIDspLiBodHRwczovL3Rlcm1pbmFsLmpjdWJpYy5wbC8NCg0KQ2hyaXMgDQo=

