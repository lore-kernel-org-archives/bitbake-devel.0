Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED841D2ECE9
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 13:48:26 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6649.1768916904803243982
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 05:48:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=f8hdrq10;
 spf=pass (domain: axis.com, ip: 52.101.66.2, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbmZoftvWB4ZIuSSdpgQVoiVWPAIqqkBMNHBCeHW0s93H2m1v5JPwqiYnF8TdTNUH2lwxp+fgj8EkHhkqDM8//yX87BYgaJOMAG/EmyP0/nexrKyvkl86KZ11iqfS8rsU+/agJ8Rk/us81vTlr1udnjiSaTHAIxOrrnt+w6Yz06xMx7U4+pmnsxurQFssmQa8ezTFgNMe108LnZ2m4Y+SPHTx3pSmMoJnhQJtiwL073GzT5f3w2NQvmb4HGJ/cdeTxIMx5Na1UjazGDjyrlcV3oftJeajPHLqFVquZeZb37w2pU+G16uwwVexSXH27TJTwvcXUFRuIPan55f1uT8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQXf60V3RHFK3tcFj317S1XSvM7lnnKdGxpancCDEHQ=;
 b=GE5xdF5b6/dIzHcoi6/5CkA8y5ap7q6u4hLRI0xO/imFBdUua11uJ7lHoEzANHvYZfwD/mKT7mILOGgn/Wojwk5K/KsnCWASuVr37oUmCSVHOMceQl14Cxg5SiAOXEvv6LkkWguLzc8qn0OKUKwnda90ByWj5PGeYUeAuQBlrSo9BMXK5fID1/YY3QWw+rhi7ZztkzJepT02WX5HCtgCW0rS+P9HyMzgyWYaebjd7glh3yT050mPRPw/FY/KDaVTRBm08JbinECSg3LzeePTWjrv2oLo4NNiEGLys1jNgk95Ynjuq+iZq0fUUkTAqsbGkXENPU8MYrwB+nW8HL5Gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQXf60V3RHFK3tcFj317S1XSvM7lnnKdGxpancCDEHQ=;
 b=f8hdrq10ipi8uBA+ZOyXktZElP7+HD8Xy1noXEEivnabHEEZu3XILYLF3HK5Rmj1E6frw5pxbUuQ5RW/cgQ6KwjkPLC8eTg6vXkf7KmAJWqwIiL9GObSuUxb8chh8DiEKwWAWOfe+5OjB3pUNYB65s1ggQjajxg1fIdLU0mRWsI=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by GV4PR02MB11326.eurprd02.prod.outlook.com (2603:10a6:150:296::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:48:20 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9520.003; Tue, 20 Jan 2026
 13:48:19 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "uvv.mail@gmail.com" <uvv.mail@gmail.com>, Alexander Kanavin
	<alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Yoann Congal <yoann.congal@smile.fr>
Subject: RE: [bitbake-devel] bitbake-setup update problem
Thread-Topic: [bitbake-devel] bitbake-setup update problem
Thread-Index: AQHccyDvmDSJG5dctkCNDN3fz4V8KrUtXygAgAABNgCAGuoU3IAPfbGAgANzlgA=
Date: Tue, 20 Jan 2026 13:48:19 +0000
Message-ID: 
 <DB5PR02MB10213E60D96F5D4AE9C5DBB93EF89A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
 <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com>
 <1883858B93EFC423.1614991@lists.openembedded.org>
 <188385EDFF4B6429.1342979@lists.openembedded.org>
 <18870377D56AF168.1986633@lists.openembedded.org>
 <CANNYZj8+msix6SFiCH=4UcLogt-+zA6=keGtXtBPbTE8vKTqoA@mail.gmail.com>
 <df05a1fd-23ba-45be-886e-886e4a79cb74@gmail.com>
In-Reply-To: <df05a1fd-23ba-45be-886e-886e4a79cb74@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|GV4PR02MB11326:EE_
x-ms-office365-filtering-correlation-id: 957b41ca-38ab-4bc6-ec6d-08de582a924d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OTJZUmtiWjJ5ZlZjSmRNQTI1dmRlWXRJZU9qcEJ0UlZ5L3RDS3JmaW1vaXlU?=
 =?utf-8?B?aUlEd1VOdVYvbTJkdHdoSS9BUFBES3I2SUJ5TTFlZm9LNHZmeDVaVUNFNjVY?=
 =?utf-8?B?MmtBSDQyN1REZjR1Y0JuQkM4NFQrZllEQUxXQTdjTTNmWUhyRnR6SzR6Q1pI?=
 =?utf-8?B?V1NOazdGMmtINEM1c3gxUDQyYjFVamxXWWFaaHJhQXVFRVlabTYwTGRDWTVY?=
 =?utf-8?B?bkhHbFJCa0p1aFlPaTZmVjl2U1B3STVLRGdFdjNQaEhsUXkxbHZQd0NVOTRw?=
 =?utf-8?B?NXp3enlSa24xbGxBZGQrRW5TYmJoQVZvbm9MUDVqQVQ5aHZzd3orUWo4aFhJ?=
 =?utf-8?B?Sm9vMmpaKzVYdWliQnpoZG5pMFNlZm8zRnBIZmhjcXVhbXRwOWZBR2Z2d1Fq?=
 =?utf-8?B?cmUxc1NybUNCY1I2RlEyZy83TkdhZlZnUTJPR1A3ZVdybG9UT3oyczNkRFU0?=
 =?utf-8?B?UVNqc205THR1MUVCM0NvVUtmYVRLR1A1SnFSOEM5a3FvR0owVWlnWGNRc05P?=
 =?utf-8?B?R1MxdktOaWVsSTFNSUY2bkZ6TXpQdzF4ZTMvb0ltMHpxTXJrSmVWS2pDN05S?=
 =?utf-8?B?enVyTExCZ0dBV2xHZnkvMHI1NVhLeWdXRncxNWttL1pXZWR0eHV6U1RyNXcz?=
 =?utf-8?B?d2tXZ0F6R05hVzZaaXU1UEcvWUc0bEcvZkkzcGFBcDFXOHFVQTdkVmZtTi9C?=
 =?utf-8?B?UnlkUnljY1ZzQUJxZVBHd1FwN0Ntb0VLY0N0ZnFZVFJZOUdWRDhGNkFSWlV2?=
 =?utf-8?B?bkNPTHRFVVJWbmQ3NDJ1bjZnQlV0cmVoUjZ1RC9EVlVFLzBQaEp0NWlZNWdV?=
 =?utf-8?B?NWlpNSszQmZ1akY0OU5CaVl6Y09adEVHaGVKaUE5c3ErTlFCN2p0dW13VGlt?=
 =?utf-8?B?dk1wajk5WkxHRzcvc0FDSU95QmdXa01pb09QRGRnSmxpTDJ6Ryt3eVBSNWJG?=
 =?utf-8?B?am55dXN5ZHEySk05RCtTbDZMQjNRWm5GZGQyeXRBbkNQUkZNak1samtGQ1B6?=
 =?utf-8?B?bUhtd3JnTjAzanZ3Rmd2MkZjT00weEt2VGV6cFhuZnl0STNaVU5DbnQ4dFJz?=
 =?utf-8?B?ZXJWZUtGRy9KTlpRODVOdDZtTmtMaVhycU52RjRBTDd3MHNJSHVzSVl0T1dQ?=
 =?utf-8?B?NFkzeTlYdGZRbm0ra3pZampzaWk0SnBxbjlveVpaMGNYWE5VUXVsN3REMHJS?=
 =?utf-8?B?dzdxbEVpL1UrdW5sZXlSdm9HenZ2c3lKZ25MZzlOMlUwZkMxRFI4d3VzVG5B?=
 =?utf-8?B?RnZuZjdGclhlY0pVcThxQXpTZW1GVEc5R2JFWUF0T0N2MGthdStPUGltOTJ4?=
 =?utf-8?B?WGpMSG9CRG9UVVA2SGFvRk9QRmdKUHYyVEdDUE9hWWNSU3A4VVBKS243UUpY?=
 =?utf-8?B?WW5CT0VIaXhZSkEyL09uM0ZaVGo3aUo4bVRRdis4ZEhGcXhaRWJuR1Vsbkda?=
 =?utf-8?B?L2xDZCtvUkN6ZjZBYytYVWZMTVNXQmxhM1BzOE8zR1ZJeTE4T1Z0bTBUL1d4?=
 =?utf-8?B?dk5SVXBJZFJBbDJYZjN5d1hCblVrdWZodkpldVd0Y1htaDZLdFdRbXM3M3BV?=
 =?utf-8?B?SjRkbFpFUEs5dGZnZHBXVllEUjRIYlFxT1NlejlPVllZUVpoQk9DbFV2c0k1?=
 =?utf-8?B?UlVNQXpweklFMjRaZFZKYi9UcEVZSDJJTmNxNU9YOWxrQkkxeXAxSnJHS1Rq?=
 =?utf-8?B?VUVIMFJnYTg5eXIzS05DVTV0WVF1S3NPUEVXTmVvV0VGVDYwY25pTmhTQnc5?=
 =?utf-8?B?aElDcnNwRW0rQ3Y4VHF0YzkwRTRwb3FneVhYK3BZdTlVWnV1SlU0NG1EeXc0?=
 =?utf-8?B?NTlaNW5KZm5helpQaDBXR0xaaVkyMVQ0WXpYMVBkZ2crWGVMeTFRLy9oZXNq?=
 =?utf-8?B?ci9kb3FOYXJsNW1SLzF3YXNEeU9PTEhOT1pBckxYOTJVMjU4UEdqWFN1N29S?=
 =?utf-8?B?M3NXaTN6eE03ek9pc2wrWjdOM2hQbmlnZ3RRWCtnOTVZa1h2N3luM3hhTml2?=
 =?utf-8?B?b3Z2TGw3MUx5WnhTai9oTTBGcE5hZmpCMXAvOWNMaktsMHVrdzVXaVlXdkJ4?=
 =?utf-8?B?dnpHTXFreWhhWmxDUjRXbldCU2o1YmQySjNhL0wzeE5ZamIwQVQ5Z0FaSDVS?=
 =?utf-8?B?RlR0aXdsUnZpbzZzQWtMd1ZqVzAzbWRINkRmdldyZnNncDlubXF6Sm00eGVX?=
 =?utf-8?Q?W73wcynuuqRK998QAr34Fro=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VEd4OER4amxTWXhiUjZRWXlJSVdLbkxCNFYwOWhHNG05Q2REMW9aeVhSa0Zv?=
 =?utf-8?B?WXUwS1k2d01RalFMMVBXcG52SmZ2VlZSRjRzM20xeU90RHA4cVZzR0ozMjZK?=
 =?utf-8?B?cW1CS1YvdUc4TC8yRWVHSSsvZElzMUE1TTNqak52TjlueU1tZlliK1lmQisv?=
 =?utf-8?B?NmRzL1FqS0lJNWswaWNXODBjYU45MmxGaWFDamVhWkhBN3Q2czJCaFg0THhS?=
 =?utf-8?B?Yk9rZDNlamhKS2pQdTJ4djdqMW1zM1o1d2NvTDR3VHgwRlFjaVUzWmpYb0lO?=
 =?utf-8?B?dG9iSUhkYlVMRGl5MU80dXZxYnlvMFlob29uTS9vaWF1bDJCT0NYOHdhZ3Y1?=
 =?utf-8?B?NE94NDZra2tGQ25QUUlyVmR5NDZFWTlWaklNMGxMcFNnKy8zSElFOHlrNnk0?=
 =?utf-8?B?dFQvY1F3eG9mV2l5ZkdEemFGV1F0WUZ0TTBzNG1NWFl0S0tENkhjQVMrM0s3?=
 =?utf-8?B?cnYzY0NyaHRwdlhkdngwN3JTUmx3bkt4UStFeWV3T2RPbzAreFg4WnpNZytQ?=
 =?utf-8?B?TDNxSnJhOHY2MThHVEJJbHZMdEo1YVlOK0w3NjFKYnJNazgwWDEzMzE4MGdC?=
 =?utf-8?B?L000eXpvczVVdFI4c1BpWU13cHJXakJXdS9uMit3aHlZcVpBV01YT3N1eXJk?=
 =?utf-8?B?WEt3S2dRUXoycVJYSTNrVU5ianQzN3ZoNDgvVGRkY1NhZ2xPUWJRdDRtWDRu?=
 =?utf-8?B?RnNWcy9aNWRkQUdmQ25UVFhWR241eExSYmtwQ0VCZFdmOXJQTG5YaTYyZ0dP?=
 =?utf-8?B?S2pkd3A1RGJnd0NMUjF1QnUwTnBBQzhjSWdGU2FBcGFOYzJsQmNMM0lyTTdL?=
 =?utf-8?B?T3dQaEx4MXR5cThtT0VMTVg1akJHek9iT1R5NDFCR1ROYXR2RTBBcmxia1g1?=
 =?utf-8?B?QmNWaGp6VUMzQnNISEdxK21vRzhBcXlBN2VUaHIyS2JQSHZMNGRtRm0xYjhx?=
 =?utf-8?B?dEdjMHNIOUNhd3BBOEZtQy9QeHd6V1pJWEFTVGxpUk1lVzhiMkZKUS9WMTNk?=
 =?utf-8?B?M2gyOWdnTDVFT3ZYaWY5aGVtclNFS3RRZkg4dVUxRG0vVFdCbm43V3BuWkxr?=
 =?utf-8?B?aW9kU1RPQWJWa0VPQUVOREZKOWhsREkvdkh4czdvSDhQUVJSVENuU2hvTm0z?=
 =?utf-8?B?ZzJHZzEwZlpNV0VQQ3NEdDloRlhCcm81ZFdSTkwwTlBEbnJzT0g3OUxvd3k1?=
 =?utf-8?B?Q1NQNHh0S3c5TzFYWHN2UUNVMG5Hc0xVSXVMTStKdytiR002dEsxSERIWWJk?=
 =?utf-8?B?eHBIL3NvSXZscEMrc2pYaCtZcFRaRzVkUEJ6M0hTVUdpM09aaDY0WmtYaTJH?=
 =?utf-8?B?RlU4MUxPRGFyMHBoSUp6dmFPcGZYRTRENzVpU2p2TjFwWlkxZzc0Z1NWQ0wy?=
 =?utf-8?B?U1E3RldpN25oM2dla1RscjNOeFVibmFKcHVPWmZOSC9VY1k3cXd0allvRTY3?=
 =?utf-8?B?OVpEd0VPSG4yb2NDcDlYVys0ZDRVU3hQbm5Pcy9FMDBUMHc1ZzNGQVB6dzNy?=
 =?utf-8?B?cm5TOWNETG1HdDk5b2FHS2JuMy9qMUpEQXRYYWoya2pXTEkrb1ZKSG5xRTdF?=
 =?utf-8?B?TWNxVTErWFpzZkM1Ry92K1dxYk1PVUYrSVRaVUZMSlR3dW9oN0pzMngvNWVZ?=
 =?utf-8?B?T3JMdnMrRmpXN2xuUHRCOEgyOW56MFJMN2xvSHd3TjlxSHlpamVGa2oxU24x?=
 =?utf-8?B?QjNmM21hRkREd1NSWHRjNkVPRVpyeTdLZ3h1a1N3SXFNOVZwdUpuRGJIUEFO?=
 =?utf-8?B?aldEVWg0cDJzUS93Zm9uQSt6MnpiVnpmbUVBUHZkTS9FRFczQVlIUmM3NjZE?=
 =?utf-8?B?OS9MZmp5TWo2cTQ2Sm5NQ0hCT0UrdWs2VjNGbHJmWktaVGhJYzhodlFUeUh0?=
 =?utf-8?B?amwwSlBXTlEvcTNPVTBtWEJWQUxUUWp0WTZuK2MwWGlTa1l6Yllvci9Pbko5?=
 =?utf-8?B?QkVQVzV1NkE4QllrQkpFL0lId25QZFdwczhhc2h3R0d4VHdDOGg3bmtVRG85?=
 =?utf-8?B?QjNlZ0JaM2NBd1kvTk95dXY2Z0Y2eFlvSkJrQmJHRndQTWZRS0lWTkt1bGFX?=
 =?utf-8?B?dVA5SE1DWCtUbDF2MXA0R1BVSnNnTkl1eDhGakJDTkZQQklwR0dydVl6WjRy?=
 =?utf-8?B?V1R1MFF1aDNkWTVKTzJPTUZNazBIU2VDS2hLN1RIRno1M1JjVHlLMTlqZ3Vi?=
 =?utf-8?B?OHNmek1sUlgzdUxjMGhCbjA3SnRzejRnWk1sa3BONytTY1ZreEx6Tmh4dVNx?=
 =?utf-8?Q?H2nC/72PFsDkUp9CGV1oAO236tjD2Hs5SMdzO0nQw4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957b41ca-38ab-4bc6-ec6d-08de582a924d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 13:48:19.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Si6Si/tsWGQevudBkqsP2Fhu5ABaM49DxIB6L4gFpYqGKWoh+tphYn9HQshSQ8bp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR02MB11326
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 13:48:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18820

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIFZ5YWNoZXNsYXYgWXVya292IHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3Jn
DQo+IFNlbnQ6IGRlbiAxOCBqYW51YXJpIDIwMjYgMDk6NDgNCj4gVG86IEFsZXhhbmRlciBLYW5h
dmluIDxhbGV4LmthbmF2aW5AZ21haWwuY29tPg0KPiBDYzogYml0YmFrZS1kZXZlbEBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnOyBZb2FubiBDb25nYWwgPHlvYW5uLmNvbmdhbEBzbWlsZS5mcj4NCj4g
U3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBiaXRiYWtlLXNldHVwIHVwZGF0ZSBwcm9ibGVt
DQo+IA0KPiBPbiAwOC4wMS4yMDI2IDEzOjE0LCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90ZToNCj4g
PiBPbiBGcmksIDIgSmFuIDIwMjYgYXQgMjE6MTksIEFsZXhhbmRlciBLYW5hdmluIHZpYQ0KPiA+
IGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPGFsZXgua2FuYXZpbj1nbWFpbC5jb21AbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZz4NCj4gPiB3cm90ZToNCj4gPg0KPiA+PiBJIHBvc3RlZCBhIHBhdGNoIHdo
aWNoIGFkZHMgdGhlIGxvY2FsIG1vZGlmaWNhdGlvbnMgY2hlY2suDQo+ID4+IFVuZm9ydHVuYXRl
bHkgSSBjb3VsZG4ndCBmaWd1cmUgb3V0IGhvdyB0byBjaGVjayBmb3IgYWRkaXRpb25hbCBsb2Nh
bA0KPiA+PiBicmFuY2hlczogaXQgY2hlY2tzIG9ubHkgaWYgdGhlcmUgYXJlIHVuY29tbWl0dGVk
IGNoYW5nZXMsIG9yIGNoYW5nZXMNCj4gPj4gb24gdGhlIGN1cnJlbnQgYnJhbmNoLiBJZiB5b3Ug
aGF2ZSBpZGVhcyBJJ2QgYXBwcmVjaWF0ZSAoc2ltcGx5DQo+ID4+IHJ1bm5pbmcgJ2dpdCBicmFu
Y2gnIGFuZCBjb3VudGluZyB0aGUgbGluZXMgZG9lcyBub3Qgd29yaywgYXMgZ2l0DQo+ID4+IGZl
dGNoZXIncyB1bnBhY2sgZmlyc3QgdW5wYWNrcyBtYXN0ZXIsIHRoZW4gY2hlY2tzIG91dCB0aGUg
ZmluYWwNCj4gPj4gYnJhbmNoIGlmIG5lY2Vzc2FyeSwgc28gYm90aCBvbmUgYW5kIHR3byBicmFu
Y2hlcyBjYW4gbWVhbiBubyBsb2NhbA0KPiA+PiBtb2RpZmljYXRpb25zKS4NCj4gPiBUaGUgbW9y
ZSBJIHRoaW5rIGFib3V0IGl0LCB0aGUgbW9yZSBJJ20gY29udmluY2VkIGdpdCByZXBvc2l0b3Jp
ZXMNCj4gPiBtYW5hZ2VkIGJ5IGJpdGJha2Utc2V0dXAgc2hvdWxkIGhhdmUgYSBjb21taXQgaG9v
ayB0aGF0IHByZXZlbnRzDQo+ID4gbWFraW5nIGNvbW1pdHMgYWx0b2dldGhlciBhbmQgdGVsbHMg
dXNlcnMgdG8gdXNlICdiaXRiYWtlLXNldHVwIGluaXQNCj4gPiAtTCByZXBvIGxvY2FsLXBhdGgn
Lg0KPiA+DQo+ID4gVGhlIGxvY2FsIG1vZGlmaWNhdGlvbnMgY2hlY2sgc2hvdWxkIHJlbWFpbiwg
dG8gZ3VhcmQgZm9yIGNhc2VzIHdoZXJlDQo+ID4gdGhlcmUgYXJlIHVuY29tbWl0dGVkIGNoYW5n
ZXMuDQo+ID4NCj4gPiBJJ2xsIG1ha2UgYSB2My4NCj4gPg0KPiA+IEFsZXgNCj4gDQo+IFRoaXMg
aXMgd2h5IEkgZG9uJ3QgbGlrZSAncmVwbycgYW5kIG90aGVyIHdyYXBwZXJzIHRoYXQgcmVxdWly
ZSB0aGF0LiBJDQo+IGRvbid0IHdhbnQgdG8gdXNlIGFub3RoZXIgdG9vbCBvbiB0b3Agb2YgZ2l0
Lg0KPiANCj4gU2xhdmENCg0KSSdtIG5vdCBzdXJlIHdoeSB5b3UgYXJlIHBvaW50aW5nIGF0IHJl
cG8gaGVyZSwgYmVjYXVzZSB0aGlzIGlzIGFjdHVhbGx5IA0KYSB1c2UgY2FzZSB0aGF0IHJlcG8g
aGFuZGxlcyBleHRyZW1lbHkgd2VsbC4gV2UgaGF2ZSBiZWVuIHVzaW5nIHJlcG8gZm9yIA0Kb3Zl
ciB0ZW4geWVhcnMgdG8gbWFpbnRhaW4gdGhlIG1hbmlmZXN0cyBmb3IgYWxsIG91ciBidWlsZHMs
IGFuZCAoQUZBSUspIA0Kd2UgaGF2ZSBub3QgaGFkIGEgc2luZ2xlIGNhc2Ugb2YgcmVwbyBsb29z
aW5nIGFueSBkYXRhIGR1ZSB0byBkb2luZyBhbiANCnVwZGF0ZS4NCg0KV2hhdCByZXBvIGRvZXMg
aXMgZmlyc3QsIGlmIHRoZXJlIGFyZSB1bmNvbW1pdHRlZCBjaGFuZ2VzLCB0aGVuIGl0IHdpbGwg
DQpub3QgdXBkYXRlIHRoYXQgc3BlY2lmaWMgcmVwb3NpdG9yeSB1bnRpbCB0aG9zZSBjaGFuZ2Vz
IGhhdmUgZWl0aGVyIGJlZW4gDQpyZW1vdmVkIG9yIGNvbW1pdHRlZC4gU2Vjb25kLCBpdCByZWJh
c2VzIGFsbCBsb2NhbCBjb21taXRzIGR1cmluZyB0aGUgDQp1cGRhdGUuIFRoaXMgY2FuIG9mIGNv
dXJzZSByZXN1bHQgaW4gYSBjb25mbGljdCwgd2hpY2ggdGhlbiBuZWVkcyB0byBiZSANCmhhbmRs
ZWQgbWFudWFsbHksIGp1c3QgbGlrZSBhbnkgb3RoZXIgR2l0IGNvbmZsaWN0IHJlc29sdXRpb24u
IFdoYXQncyANCm1vcmUsIHJlcG8gYWxzbyBoYW5kbGVzIGEgcmVwb3NpdG9yeSBiZWluZyByZW1v
dmVkIGFuZCBsYXRlciByZWFkZGVkIA0Kd2l0aG91dCBsb29zaW5nIGFueSBtZXRhZGF0YS4gVGhp
cyBpcyBiZWNhdXNlIHJlcG8gYWN0dWFsbHkgZG9lcyBub3QgDQprZWVwIG1vc3Qgb2YgR2l0J3Mg
bWV0YWRhdGEgaW4gdGhlIC5naXQgZGlyZWN0b3J5IGZvciBlYWNoIHJlcG9zaXRvcnksIA0KYnV0
IHJhdGhlciBpbiBpdHMgb3duIC5yZXBvIGRpcmVjdG9yeS4gVGhpcyBhbGxvd3MgZm9yIGdvaW5n
IGJhY2sgYW5kIA0KZm9ydGggaW4gbWFuaWZlc3QgcmV2aXNpb25zIGV2ZW4gd2hlbiB0aGVyZSBh
cmUgY2hhbmdlcyB0byB3aGljaCANCnJlcG9zaXRvcmllcyBhcmUgYmVpbmcgY2hlY2tlZCBvdXQs
IHdpdGhvdXQgZmVhciBvZiBsb3NpbmcgYW55IGRhdGEuDQoNCi8vUGV0ZXINCg0K

