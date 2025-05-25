Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00ACC54E90
	for <webhook@archiver.kernel.org>; Sun, 25 May 2025 13:40:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.69])
 by mx.groups.io with SMTP id smtpd.web10.9267.1748180423025933678
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 May 2025 06:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=SMjYWZjP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.69, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRXng39s/dftBcuJC1TK9NN+FoUna1qlvgYv+eOdzJaHhx1PiRHZZdb+AJ47hlz4w/qwlDsJ2PiyAQOEoP2XpkR7xymiM2hLYxHnXt7xBWJhFgvlfxtGGO8LSBek3ETtf1ldgojQ2tduGzSCqzGpohBJs4ajs9I4nLYODkKMK1OOlm/i4FL0RlbSutBmUkcnvLgsqAx8i6Wgen56JQ/h0dSFcvnhfyi5QH0Vd3G1Vof7PTpuhrRoMc+OajhBOwspUJHRs6MIrGTvSAN8MCYBZcsW467HuR/iE/docZ4ZJkyt5gm1di6z63CNR5CR3g741ineZGuiM/0gQtRc3G6u8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyCzPfTRGuARUcZngRtUdmO5S33pNIEwT+JctqHbwj4=;
 b=EjdG+MbBCzUGp+y/iEC7b+rAl9xsh33VlIKDzW/M0bhq1ARdVv3bKdAWxYp6nqe/jD3JtTTGfJ2nrpyE2EkRI4v+5KbIbrInDaybshUbPUQhqiNdJC95J7wpT5jPMj2JEweKvLlBNgiG8LDB4PL9TANMLNGALtFRR4ZzFf8Den3GNLnXY1AaabwG4wHzElx5Y6SB0OPpVA7K9/XlOlVaSfN6gzhgObq3qBVzGXr97eaCt6ZCwf/lVz3TTssSKv9bOBcQ8+/HGppkp/Arhe7J5WGd82S8ZKkYIKkoJkTB+LWfq/3BYzyfKZ24CV6ouMo0Uo0Rpt/mj+TB7Bf8VBRSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyCzPfTRGuARUcZngRtUdmO5S33pNIEwT+JctqHbwj4=;
 b=SMjYWZjP1BJK4/YD3tjjKjJvZkK3gTco81YS9mJX34M6VDIczqH/aLh8Ue8Y4XAfaK7q7ryQgeS43L92qtAKzpWMnnIiWk29JDiQf+5TPxp0PQ9z5IRdn0VedCA+oYYeY48UTyogyXj7n7xY0vBkRyz+LfhSd2NvQO/BCXRerovd6FKgFXAIkXlDuGj1xOuCMr6JdGENPHJpENWVoL6W27j/wHgavqdQwb9Cbr3y4Okr6QdzgLal9CECvXNEttEZj2Ej4NqN3+7xY2MMZ9xYhyCUOdJvMF+4e0ffMjowFbgHNK9wuo/POmuqfTRHV/jeBQTcGrvovZ5CsFPpAW2Hlw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Sun, 25 May
 2025 13:40:19 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%7]) with mapi id 15.20.8769.021; Sun, 25 May 2025
 13:40:19 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] Why doesn't BB_WORKERCONTEXT cause task hash
 mismatches?
Thread-Topic: [bitbake-devel] Why doesn't BB_WORKERCONTEXT cause task hash
 mismatches?
Thread-Index: AdvL5Q968bqCFz3UQxqpJVzshsFbIABZFM+AAAwz6FA=
Date: Sun, 25 May 2025 13:40:19 +0000
Message-ID: 
 <DM8PR12MB54301F0296D2101CFAFF2E168B9AA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB543079199282BB54BBB054B68B98A@DM8PR12MB5430.namprd12.prod.outlook.com>
 <4dbdecf888d3d81cb0bc81d172c45f410e8b5667.camel@linuxfoundation.org>
In-Reply-To: 
 <4dbdecf888d3d81cb0bc81d172c45f410e8b5667.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=1e91a6ed-482a-45d8-8086-f408932ba505;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-05-25T13:37:45Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA5PPF916D632A9:EE_
x-ms-office365-filtering-correlation-id: d6955355-a32e-4c09-2fbf-08dd9b91b0aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cHQ2eEMrTE9tNWp1NW5kamZDb3VlQnVQaDlna1NhTXlNTTFwQWcwQmFVZnVQ?=
 =?utf-8?B?UUNmbElyNmxid05xTFdsRjQ5czh4STYvQkk0TUVjTFpuNDlwT0lhT3N2VEZn?=
 =?utf-8?B?V0k0dFhFenpPK0xLUE12a1Z0enVUSHZJQlovMUl1T0NZQU80Y29MY3lPNXNq?=
 =?utf-8?B?QXF5UndFYkJBUFFocTFWdnNETzhRRy9xVmxUZ0g1NEM4YjNKck8zUDhNdXZS?=
 =?utf-8?B?WWJPRDZGT3ZnY2p6UG9TY1pHQTkyTFIyd1M1bk40dUp3YjNVdHJpQTJyeFJ5?=
 =?utf-8?B?WFVDQXpKQmJrS3hTVE5XZWpvT0U3R3pjaFBhL1NZWW9wZ245cVVnUmFrME50?=
 =?utf-8?B?eXZnUnM5bGJmNFIyWDFvb0VZNGMxYUQ4UXhnYWRhYmkrMlg1VktkNy9ONjJG?=
 =?utf-8?B?WnZIYlVKUnZkZDZqQklWekVKZk55T3FkNmdLREdYSjJCWXZxRnR3bHgvZERN?=
 =?utf-8?B?RUc2ZUVqRDFUSmJxc1k4aHdaalBTYXVGbncrMlFoM09sL1N4LzA0bE5RcWU3?=
 =?utf-8?B?TXdTUEtSNkw1RHdiQ1RyVDNqUUpEOFNCMzJiRE0xbjJkWGNKWHovakhpam1p?=
 =?utf-8?B?dnltY05QdlJ4Rk9IZEZKYSttcUZqWG1SUmFKVi9pVHZuai9ucFpISlNvNkh0?=
 =?utf-8?B?RUxlWCszcXhyN0ZiYlZQSDNIWlFkdWQvWTJHQ1pHdnZGRnBDajJ4NE0yS243?=
 =?utf-8?B?dUtBWUhKTmVDOHI3VHJ1bFhyZXVmOFp0amVSVzVLcVY4NTd6eTFLS0Z0Rnd4?=
 =?utf-8?B?OFltbXFyRHNoK1AxdStQeEJZaGNhNU8vTEU5bE16S3lyT1hhUWU0U3VZZ2w5?=
 =?utf-8?B?VCtMS0c5alU1UE5acDFYVVhKNjA1bXd0SVZubk5zYU9pWnlIZHh1ZTBFMzNx?=
 =?utf-8?B?M2haUWU0M3VHODlBTDJ3clhGeEphUWNXalV0V29ydXJkWDVrL3VlWTB6YlZT?=
 =?utf-8?B?aWsybWZJd2hCQjZJYWdiZDBIVUJ1WU9HRFF5VzZad3NLRVVuQm1Ub0VvcjND?=
 =?utf-8?B?bGNYQUkxTUl4MTJSb2JiL2dRYzBqNmNlNE52dFJ4TERYaytmQ0JIN1VUbWlu?=
 =?utf-8?B?OHFRcmpMdk0wL2VvRmxJSnpLMVgzRm0vTGxLc0VCUG5vb2k0Mk9saVkvUDJp?=
 =?utf-8?B?Z3pyTGgxQ2Z4N3Rla3kxVG1CaDJLTE1VNFo5WjlrUEEwWHBJQjFZQzVSVkJh?=
 =?utf-8?B?Nmsvc3RGZXJ1NHRiQlNKUVo2S2xUMG40NGNPRUtUbHRkb1Z3TnA4RDM3RThn?=
 =?utf-8?B?VzhGZmhYR2tjbXVRVVRaOC9BN2hHSFNiQjQ2MDJuZ1RoVm1YbVhERFc1TFZK?=
 =?utf-8?B?OXFVK3kybU1YV3FSNTZ6d3J5clJZcjNNWThtTWxNdG1HUFRnaEJNZXpUV2pB?=
 =?utf-8?B?eE1JVVpWdGdlWXVjL21mT1ZOQlk4RzNza1R4YUxnMnliWkF1aGNDR080YitE?=
 =?utf-8?B?N211cEJpRXNvdkU4Nnk5Zkd1d3JNeExxRXdqMDdxRldqazBQR1o2a3ZQWHNV?=
 =?utf-8?B?OFI2L0NBbWZyVlpBTDZtemZmTFlTZWo4MHNCbWpSWis3WlRLQmlvak1zRzJr?=
 =?utf-8?B?dlZrS1FUL3hUQlRnNWdFUkp6czJndnR4dk01aUNSdGc0SVE0Qm5iZ2piTWJT?=
 =?utf-8?B?emJIWnpuaHV6bGYzbmJEN3FJZlh6YVlYeTM2VkkrdUJDdDI4UHQ3VGdEeERW?=
 =?utf-8?B?N3h0QTJSWlVJYjVPSm5Xd2l4c0xaQytZalQ4eUxreEZ1WHBVMTRvTkpqUVpt?=
 =?utf-8?B?Sjg5RzloN1lOVEZkamFTalNoeTN0N0w5K21ScDk0TStpSExaQkRzWVJlS3B4?=
 =?utf-8?B?SEVyWTdKNHRYM2JwYkdCWFJ2dk9hYVk4VlQrelVJNEowanRRYVRoVGtYK0ZD?=
 =?utf-8?B?aTE2WVVtM3V1VWgvYndVUCtFN09KOHljL2YyYWZCSmFDMWZkdmljNm8yVXlU?=
 =?utf-8?B?ZTVnekF1TlpmTW1vaG52b2dBSnpIdUJwQjIzVEY2cjZiMzE3SkN2eWNhWXVa?=
 =?utf-8?Q?AIkhlFXuMjADJLYZgco3+MMS/Iiv7g=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ekk1NUlyakJGNkwwQkJFQ2V0TmxSVmhKdDIzRGRtY3lWbzNkYnU0eHNJTDI3?=
 =?utf-8?B?enY5RjdsVDBML09aT0QzV2JObFVCWWlUU3RteVpQQ3U5VDBEV1cwdFZ0c21N?=
 =?utf-8?B?VDlXbCtmY3NlTVVDMUxCZ3locU0rdkQzQ3ZNT29NWUM2SnFmL2dkbjloUExC?=
 =?utf-8?B?QmtSbnpCVW11RDNiR1NHUmVqRUMvTC80WnJoUUNiOTJvYk5xcHN6ZzM0ZmdC?=
 =?utf-8?B?RW1WN2ZrQmJ5QytJRWcyd3lWeDVCSEQ3RExVSGJHTnF5NWdwWlUyRjlQbFAz?=
 =?utf-8?B?c0pUbElyWkdTOVIvZkNURHB3MmVlK0lNTjJ2ZGl5c0M0cytVVkI3R1ZjSGxr?=
 =?utf-8?B?OGJnVENrM1N4MTRXVmxLTG4zdWF6ZmUzbXBYM0pxQ21VSlpNWjA2eXBUcDlK?=
 =?utf-8?B?MHh0Z2xXck8vOXlTVU50enk3TGNuRldobExxbjdxTXZNVWh3RjdPUlFUWStl?=
 =?utf-8?B?bCs1cmVONk1XTVBpMWZIdUNQUnJRTW5tYjRranlDQ2xJREQyWDRFU3ROUXZx?=
 =?utf-8?B?M29lYUxFWEtqaUpJakpOYVJEc0NEdkI4Sm9YdTdyZXk2SEowSXVQeUFMMURI?=
 =?utf-8?B?ZVRhQ1hRbGp2U08weE80TnJ0T2tEU01ZYzNUQzROUG5CT0E2VUpXMUVYUldv?=
 =?utf-8?B?SmVzMTVURDM3cFFJc2VLb2d3M2dIL2pBSHRzblE2V3hFMGd2UEdsNGRxaWVS?=
 =?utf-8?B?TmEzdlJaV3oyNmRMWlIwQ3pDd1NUd2FFRXJVTE8zNGx4OVMyemVxRGhyUkRn?=
 =?utf-8?B?NEhVSyt0SzVpNWJVM1FEdDBoK2d3RW04eng1Q0xrL2Q5aURUbTN1T2lRU3Z5?=
 =?utf-8?B?MDFJNDl3amxrZ0tCMkYrclV3MG9DZ1oweHYrTXV5VmhkR2hJeTJnTEFxTEMz?=
 =?utf-8?B?YUh5aUlodHUxenRmWXpoMGtGNGZKVHJ1dmpFejBoeklBU2M0bHdWaEZneVBT?=
 =?utf-8?B?ei9nbE9ubkllTG9DcGl2ZzVUUmVmdVlHczZkcWNMMGhBWFYvcmN4T2xlOTVK?=
 =?utf-8?B?S1lnT0h4OCtYcnNsaEYzV3JjUnRlTTE0dUlTdUd3S3pWcVNRNzhHZ0NZSzkz?=
 =?utf-8?B?SnJ4MVFxOGI3ZTNtUXdHL1JZKzZ5em5hb3EzaTc3NVdGbTNyTTkvbzlXR0hB?=
 =?utf-8?B?YVBCU29tOEhFT1ZVQVBmYzlpdmRiZ3NUQVRGTUpxeXBPd3JZNmJmSmJ3dnlh?=
 =?utf-8?B?QzFLT1JNS05PZDlic1ZJUXZscndNQ1ZBYkxnMTRwdTVKakpwRDZkaUNscGI0?=
 =?utf-8?B?WEFsd1ZMRGVCUjYxS2lHYkJERWFQd3NoRjRjMlBNVUQwai9hMXJhRVRGMDV5?=
 =?utf-8?B?bUtpcmI1R2xldE90Yy8wdW1ROEQzdUNqVENjTkxQdUF4NW16OWxpRkhSbzlz?=
 =?utf-8?B?QzVTMTlGdTN2UnJkMlZUSkhOWEd2S3l3alRwZWwydmdkOVFCS1g5SjNTT3dD?=
 =?utf-8?B?RG03VURwT09YK1luMTUxRm9RNUtQMlc1Y1pkSHJWRmlkSzhjRk1vSmhRdFl4?=
 =?utf-8?B?dHpEaFI0dmtDOGV5WlAwWUpOYy9nRjdOSmxlMFhENlgyZ1RZYXdPN0xsd25q?=
 =?utf-8?B?NlFPR25UbkJuUUtGM1h2MkhGMFJsYmxlUXVDaHd5VktweDN6Mmk2d3BMbmdH?=
 =?utf-8?B?YUxNM2FOakZiSldTbkVCcVlOUmNiTDFOOTE3ZFIrUFJPWUJXNzZSdVVFcVQv?=
 =?utf-8?B?RDlaSGV5UE5pNW5UY2ovbndvRXQ3K0YvWCtJRmYvZWhoVEdTNzRmcndwUFFK?=
 =?utf-8?B?R04vSWJwQmljdEVKRFd3RllUcXNQVUFpRm5NRTVicU9XVy83Y3JIdjJtRStu?=
 =?utf-8?B?SjRVSnk2RllmV0F4ZHAyVHZvdGZpNHVKZlJqSVp6UDUyVHVuVDNxbGNNMnJB?=
 =?utf-8?B?cDMvMFFyZzIrVFZQeWl0dC92QTA5ZE5DazJpUEdPa210TjFJc0lsSnpVdy80?=
 =?utf-8?B?SGxucDNDVHRMcmpjeEVGcURpbDNaajJ2NXFwL1NqQUtHT3IvUVdGMENPUUdX?=
 =?utf-8?B?Z3Z5YTVrUUdBSHJPVjlnNE1XS1g4bDlnMisxUHhKNm5tdjJrcGpvY1RCY0xl?=
 =?utf-8?B?bGF0SzByM2U4YXRlKzUvdENrZmtIbHgwdjcwTTFkV2k5NDhtUnFxZ2EvL3pJ?=
 =?utf-8?Q?6ykB4j8UzufmsC0Vk9pwSHeQe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6955355-a32e-4c09-2fbf-08dd9b91b0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 13:40:19.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZANimeIZCXRKJOooHVWBuFXiAssFOzKDLQF1f6wJmQPeMTHHlTscu2bUp32GCSpB1HnRjQFskeiBzqkptBVMOwWnGbWX+aclWID2iJ4izw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 13:40:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17638

SGkgUmljaGFyZCwNCg0KPiA+IEnigJltIHRyeWluZyB0byB3cmFwIG15IGhlYWQgYXJvdW5kIGhv
dyBCQl9XT1JLRVJDT05URVhUIGRvZXNu4oCZdCBjYXVzZQ0KPiB0YXNrIGhhc2ggbWlzbWF0Y2hl
cy4gRm9yIGV4YW1wbGU6DQo+ID4NCj4gPiAjIFJlY2lwZSB3aGljaCBkZXBlbmRzIG9uIHNvbWV0
aGluZyB0aGF0IGRlcGxveXMgLmJpbiBmaWxlcyBpbg0KPiA+IERFUExPWV9ESVJfSU1BR0UNCj4g
Pg0KPiA+IGRlZiBnZXRfZGVwbG95ZWRfYmluX2ZpbGVzKGQpOg0KPiA+ICAgICBpZiBkLmdldFZh
cigiQkJfV09SS0VSQ09OVEVYVCIpICE9ICIxIjoNCj4gPiAgICAgICAgIHJldHVybiAiIg0KPiA+
ICAgICBmID0gZC5leHBhbmQoIiR7REVQTE9ZX0RJUl9JTUFHRX0vKi5iaW4iKQ0KPiA+ICAgICBy
ZXR1cm4gIiAiLmpvaW4oZikNCj4gPg0KPiA+IEJJTl9GSUxFUyA9ICIke0BnZXRfZGVwbG95ZWRf
YmluX2ZpbGVzKGQpfSINCj4gPg0KPiA+IGRvX2hhbmRsZV9iaW5fZmlsZXMoKSB7DQo+ID4gICAg
ICMgZG8gc29tZXRoaW5nIHdpdGggJHtCSU5fRklMRVN9DQo+ID4gICAgbHMgJHtCSU5fRklMRVN9
DQo+ID4gfQ0KPiA+DQo+ID4gKFllcywgdGhpcyBpcyBhIGNvbnRyaXZlZCBleGFtcGxlLCBhbmQg
aW4gcHJhY3RpY2UgSeKAmWQganVzdCBleHBhbmQgdGhlDQo+ID4gZ2xvYiBpbiB0aGUgZG9faGFu
ZGxlX2Jpbl9maWxlcyB0YXNrLikNCj4gPg0KPiA+DQo+ID4gV2h5IGRvZXNu4oCZdCBCaXRCYWtl
IGZsYWcgdGhpcyBhcyBhIGhhc2ggbWlzbWF0Y2g/IEVzcGVjaWFsbHkgc2luY2UNCj4gQkJfV09S
S0VSQ09OVEVYVCBpcyBpbiBCQl9IQVNIRVhDTFVERV9DT01NT04uIFRvIGJlIGNsZWFyIOKAkyBJ
4oCZbQ0KPiBncmF0ZWZ1bCB0aGF0IGl0IHdvcmtzIDopLCBJIGp1c3QgZG9u4oCZdCByZWFsbHkg
dW5kZXJzdGFuZCB3aHkuDQo+IA0KPiBCQl9IQVNIRVhDTFVERV9DT01NT04gcGFzc2VzIGl0IGlu
dG8gQkJfQkFTRUhBU0hfSUdOT1JFX1ZBUlMgYW5kDQo+IEJCX0hBU0hDT05GSUdfSUdOT1JFX1ZB
UlM6DQo+IA0KPiBCQl9CQVNFSEFTSF9JR05PUkVfVkFSUyA/PSAiJHtCQl9IQVNIRVhDTFVERV9D
T01NT059DQo+IFBTRVVET19JTkNMVURFX1BBVEhTIEJVSUxESElTVE9SWV9ESVIgLi4uDQo+IEJC
X0hBU0hDT05GSUdfSUdOT1JFX1ZBUlMgPz0gIiR7QkJfSEFTSEVYQ0xVREVfQ09NTU9OfSBEQVRF
DQo+IFRJTUUgU1NIX0FHRU5UX1BJRCAuLi4NCj4gDQo+IHdoaWNoIG1lYW5zIGJpdGJha2Ugd2ls
bCBpZ25vcmUgaXQgd2hlbiBjYWxjdWxhdGluZyB0aGUgaGFzaGVzLCBib3RoIGZvciB0YXNrcw0K
PiBhbmQgZm9yIHRoZSBiYXNlIGNvbmZpZ3VyYXRpb24uIFNpbmNlIGl0IGlzbid0IGluY2x1ZGVk
IGluIGVpdGhlciB3b3JrZXIgb3Igbm9uLQ0KPiB3b3JrZXIgY29udGV4dHMsIHRoZSBoYXNoZXMg
bWF0Y2ggYW5kIHlvdSBkb24ndCBzZWUgYW55IHdhcm5pbmc/DQoNClNvcnJ5LCBJIG1lYW50IHdo
eSBkb2Vzbid0ICAnQklOX0ZJTEVTJyB2YWx1ZSBjaGFuZ2luZyBiZXR3ZWVuIHBhcnNlcyB0cmln
Z2VyIHRoZSB3YXJuaW5nPyANCg0KVGhhbmtzLA0KQ2hyaXMNCg==

