Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45FFFD4614
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 03:59:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63591.1772078350556905788
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Feb 2026 19:59:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nQXBv5wU;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6517ac9bc0=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q3xApb4133691;
	Wed, 25 Feb 2026 19:59:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=cTRRwORc8cMdUPYMwKbMrcMLh7taLjL2MmFMEU+sMSY=; b=nQXBv5wUFGdA
	qyBBt2S1RrsfxYEHgAJubhZADE1X1u0y//cnrz2pMqNb2LnxW/V4NWcx1VEorOE2
	7jh6tY0J4xTYSnX9q5jGNYBfGFRXEDX+p28eRTQsAIRY13UhFhW8qHP2g1lNErEB
	yjYsyrmJm+qc4MslFtikZ+0+M1lCy8Uv4UTCinDWase7vxAryX0zFhWKsdzjQg9U
	ahKFgwiU0vnGS1clvTyPB36bWF9V/SNBpXgnOFaUMdACGdgTV7X+7UPttZaO7HE6
	Dlw8d409eBAxp4MFRy8KayYudu+PDRu5cploW8mlzRyFaH4sQ0vCJr0tdWz2Crfp
	7fKm1V/nig==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cjdyjr19f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 19:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyzl/MhB0weSjRHJKgQKZwaOKu6/Fq8VEJLzebNY8gv0ZNc80JiFuhlnk4xqW26N8BuO/1/BYTyBLXoO9LFpDJfum9j79rjPCaqGqXRRNZrXApIQLDJMWSEj/ldzp/rve8Vk9nkGGgAayEhOaZfYQlVi/lPCP5i6SQ13xwfBOTVUagbDbLN/yxvAloGOPbqRoa+chZNdHgjsXlkckq9kqP2M+R7KTJxeFlsHE7D54BNHuksxVH5OgCjv1PzqvVpWJFNYstOInlW26QKrtHjJFLyNdoXAKnWl32VXoh5PU3fncsq/mX4Ac2ZHohQ9n040NWIOlRjFnGT2BfCx6YAf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTRRwORc8cMdUPYMwKbMrcMLh7taLjL2MmFMEU+sMSY=;
 b=eSyz7cjVtWHFLI4kvusJSR5rTInICXb4Aekj17sQlysqWF9k1sGZNZOohkF9X3FIQukC9gUU4I7oY8WLtK0L7Ld8LvbGuZzxPJFPlYc5VMfGoYAH0rzWbnryKGGbwzxCFtdA2KwJcSMonlVrSzjBZWIxWF4C3IUgr4iHiRvnfhWiZoruTq6hWfshMoNZK0KUcDFj0T3LOYsa+a5m5vO+eMte83tNKjZ6bQGPDYUgOg8Nk74uK5E0c8SkmBVFdWxHp76TBUHslq/a7ajy5bjnNh+2WrJm1yzDC5o8AkR/PBpiXBAHYlXNDDlzhp+ZPVeVeuYlhVqMEP6o6uIe5w18Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 03:59:07 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 03:59:07 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Paul Barker <paul@pbarker.dev>,
        "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
Thread-Topic: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
Thread-Index: AQHceTenUE7+ibmcs0aE1+6v9iakyLV98D0AgAx3rACACk0oIA==
Date: Thu, 26 Feb 2026 03:59:07 +0000
Message-ID: 
 <CO6PR11MB56027EB3FAB9649BCD1AA4ADED72A@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20251230025413.1293484-1-Qi.Chen@windriver.com>
	 <0251564542cdad8e2c571c2c153dda82a11ee715.camel@pbarker.dev>
 <46db4b51fc653faaae80906facf37baf4a1a431f.camel@pbarker.dev>
In-Reply-To: <46db4b51fc653faaae80906facf37baf4a1a431f.camel@pbarker.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=61100d8e-a6ca-4f7d-beb5-b1445a55370b;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-02-26T03:55:30Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|PH7PR11MB7123:EE_
x-ms-office365-filtering-correlation-id: 870b2275-2105-4d16-8c09-08de74eb639c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 iaKzG2koExVIOHcTMIzMdQFwdHJZl2CmWqJueBE8R3+ZGJdNAzKJPZmvGT8jgSgh4go0xMOv9CWr+5vIgait1wtkgcKDbJH7twAiD5hbeC+UB6pCOMrnI2W0O/zbNzW3ZQH+rcMCyXqZWnk/zFdB1V59g5x326nnI6YsYkweUa1Ra+9iYnYPqR9U+4EkBvifRslSI8NOguTgQTFfmXSWzylfPYLXhvC+wglU113gFAIp1jiC+B0i4eU8eWKsnhurO9mTXcJLFvxqs3hRYx1uGmQIC0xtLl9RqwjTUHEvg8d54841zKZfC2TembBbbKAn9ylSVXVqFvPAeBZmvVH2iBDfRDRW5O/X8k0c+G1AONLACRHApC/st74h17Y0T8KY/Yo5omD4KzK61nwXBtKc32pKtCztd2nqIxbD7dZkI2AaXzaG+I9UNSkoaGPhKq65MWeoyeziYRVmMBHjR1GQnMBSaBRBivSeAEnc6PeTp3u5es0QSPHpp6xbWOTZvdCvT+o1NFSK0zKotenI0Du+Zm7a5OsOyYvTsOindnzdDvxyUkMzB9yL3wLujbb714yHCrO6Ukvw19GP0lq4dm2OZR0YQR8HsLJn1674tvwIgW00N6QNcNl8FZSg7XQsYbJtLVe/wwXGmZEhD+HXycXuWt1x+DcUfDu+DgmZf897c/fsT1rqxg8Ovfc8vsuNj5CV7tN9cDIOaba3R/HSQnjWb/rqkzlt4vhxNwMqDNrZXKDVuZ1bZBjbRJ+1AI3RhXIxaohR+BWNf8Jj4LGIsSgOfH/FcEJhl5hQI3c3uyBGjpM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eHNHcWdFcDdTUnpONDdTWXZqU3Z6VWZpS2VmSFpUK013MkNBWWJvSjR3YUxr?=
 =?utf-8?B?NlVsazc1ckR2SlBGaUNGRjVhVjhsNXMxbmZKZmt4T2I0RnRiU3NEc2w0Unpq?=
 =?utf-8?B?WlFncWdzYUNuRkt6WCtqcG5nZFJUTXVOTjIrd0F3cTRTZUlqVmFNdVAzYnRk?=
 =?utf-8?B?bVh3blk5d1MxeUM4KzV1R1QyT3QxVFV5RzU2alZRdmpYSWxuTGpGME0yeG15?=
 =?utf-8?B?Z3RIWDNTZkRsUjNCejhPNDlpVGluL2ZkZ0h3cjlCK0RZVmNCaHAvWnhpRU5o?=
 =?utf-8?B?QVMxOG8wNktjSFRQT3Q5UUFEWUdEYnlBQi9UMmpQTnA0OE9BenZ1b0VHWlFw?=
 =?utf-8?B?NE0xUFlSUHd6QlBub1JiTmhoNnQwbS8rNnloemdNMld0TUdMZnRnQUNYODBY?=
 =?utf-8?B?OStJcXhOODhLMWRPejZhaUJXT1RCQ3RSYU1ST2pSNXdJNzg4aHVDZklYdVp4?=
 =?utf-8?B?a0dEdzhrb0p0bFBuMkpCVlZ0MUtvK0pOc1FNNmpVQWdyUU1FeTFpTFlPeDEr?=
 =?utf-8?B?eFQyTUcvcmRTL1Vla1I3UEQ4dm5rVUV1Y2RpdlIvQVVZZ1E0amdTYndoVURO?=
 =?utf-8?B?ZTY1WkxjSHJvNW80K0dIOURhYjFGV2xIS2xFeThJUy9QNER4a3BpcWFNMU1O?=
 =?utf-8?B?ZEpiUEhMOVNFNE00dmZQRWNMYzZKZkt1WlRGNnl0KzRBcjJjT2J1RzlQQUdD?=
 =?utf-8?B?cWFNaExQTVhQTmZGNWRvWmkwMS92RVJBenA5RWQxWGd3TWFKNUpqNGNIaGJH?=
 =?utf-8?B?eHk1TFY3cURvWnN3VFc2UWpDQkRjZkNyK3NVemtUbmJqNlp4bU84QnI0RS9q?=
 =?utf-8?B?bmdKWEQweUVjQWJobFlRbDBkTFkwU2tuYUFOK3MzZEQ2NXh5cnBpQ0ZOUFhP?=
 =?utf-8?B?RXRBUEg1ZUVaRGZFL1hZUGM1eU1VUXcxdmJlMkhBSVRac1ZBd24wMTFlNGFL?=
 =?utf-8?B?akJQeHBuUEFabzJELzlUMGFWd1FhMHdoRGpRUVBwdUhYNGZsbDJCS0VJMWdO?=
 =?utf-8?B?U0RENzJ2bitNYm5iRHlDcG13OHVFTXMwVkZzZ2NRb0ZZaEI1VEtpUUhFb2tm?=
 =?utf-8?B?T1lxbjREVFVkUngzVjlGSkt3NHF0dmQ0Uk5NU3FBek1YU2Q1R3dNc2RieFpV?=
 =?utf-8?B?UjgzQkN4eVlseUt4KytxQzhPaGdNUEoxVUgrT0JkdWNLM3RMMjdqaEdMbUFn?=
 =?utf-8?B?K3BZT1JBcTJDMmNhSXMrSEI0aWpUYlB3OTVxK1BNL3NLUkx1Z0E5OThKaExE?=
 =?utf-8?B?TDJPL1VFclVVRFBTWmNycWE5UzAwSWdVRnprcGhxbXV4QitHUU9LQkt0YVZu?=
 =?utf-8?B?QzJpMWFNT3FiRUs4ZWNmc2VFRm9qaUJCSGpJVjQyUHdKNk1HeVBDYkFwSnNo?=
 =?utf-8?B?SGNqNW5uOFoydzhjSERIdzJTTnRoL2ZYUXRkeXFaT3VkVWlwc0JYRXZoZnF0?=
 =?utf-8?B?c09oQ2ZGUjVhSVJsdnZ1cWd3aWVTS1dXeXpUWTFpUGdhdlZtS1JvT2VzSnow?=
 =?utf-8?B?WUxLKzZhYkVldmQ1QnNDZmpQVDlpbWJkbkVtbm1xOWJzOVNxazExODlPN05o?=
 =?utf-8?B?NWFZejc2cXdmSE9vbnV0Njh2aHhwcktiRlAwOEg1YSsyd2poUUtES3ltcFhn?=
 =?utf-8?B?SCtybjFhSXFldmovRTI3WTd0SmdhaTRlMSs1VmpTeCtlcExmOXA4TWNpQUhu?=
 =?utf-8?B?MDdkbkRTMEV2czF2cEM5Y3hqcGlvYXhmbldqZjlJOUJoakk0bU0xVkkzOTQr?=
 =?utf-8?B?OFMzM3g0eCtxM0Z3WjIxT2VPcmVOUmo2WDdHQllaY2NaOVBuZjZBSjFjTnF0?=
 =?utf-8?B?SWpTSlhaTCtMV01JSFIreTVYTTRDMEpLMEdXYnZaOGdabHZmVGU5NzNzV2V0?=
 =?utf-8?B?Q2QwQjJ6Z2NzN1NycDkvWVZJTlB2NFlVbHdzdjc1eTZJaXNBNVFtaStJUVpt?=
 =?utf-8?B?ejJ1ckZaUEdyQ0creFJ3T2hUNmdocmxIWFl5NE1jN1NGKzUzdTEvNlZSVy8w?=
 =?utf-8?B?Njc2U3MzditrbGQ4ZDNabjNINTh4NVpISnZQU29uV2tUOXErVVZ2cXJHSkFm?=
 =?utf-8?B?RjlwQ0Q4MEF4UVlLNnV0N0ZDbTBCL0VHNmEvU0FmY0dsUnB5K0h4MVBWTElX?=
 =?utf-8?B?aVliaDEvb2N5bUQ4VVRKUzdsSWxoTlcvQmI5VFAyWFN3TXFMNkVPRlJUR2VW?=
 =?utf-8?B?TGxYRld1UnJWc0dldlYrVkVWZHhEVno4Y1ZjcFd2WHhxcGJtYjZhdVZaNjE1?=
 =?utf-8?B?czJQUzlha2dtZmVjNW9lamgxaGg0cEtjWERvSGN1eVdRVnNKMUMrVjFHbmgz?=
 =?utf-8?B?UEdIQ2Q1K3VqdzFpdzJRcXVhbGRjdjlETi9RbHhRYkhnMGNFeklNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870b2275-2105-4d16-8c09-08de74eb639c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 03:59:07.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOWsMLPe9Lg3e1Wh3SSoK7iCzA/x3o07FcB0fffUhCYMbQCakOl/PkAWKI7RyUHZh1z5SvWZwZDTNlUdNepqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAzMSBTYWx0ZWRfX+df4IoFWVZ57
 xWAiFZyEWUIL7QYzRqG8tNr1h5abmvdtwYxxPjYWXlTGAvK7kOz6Aea8Mz9fsFAwWnB4rFGpUcs
 /oLcDH30JYRAikCfxZelRCsCp0M8QrP1r6/OMU5dyYFWIhUqG3S5ui7v0Gm/QXSPxVg499k1AZH
 PBYSINkoZ7md/jVoKMoVUDZNC4GhEL2JeRB6Ln0k+2hbtIIEG0atRk3LSQdAngTopAivt/Ci57B
 UPB6xtJEGklWt8tL+GbtLoodZFi+Nu4mywUFCCdf9SXvzpcCeQuiT2MNCInt5UidoRdwAKHuAeM
 Nnxyk+VP3MNzhaEC1mHNyFu3me7K2tzfmEzVUvnh0jq6fgZVaBaDjvpkqP8MgX8mxiwhtN4osMu
 0W352jHSWZj0MfIn6/Mnv02rGjQS3Izc6iPbT2qEiDWKeJuNjNaBxV80uQeQFOf1z7LsLboQDt9
 XgUfXd6DonT90wYHYIQ==
X-Authority-Analysis: v=2.4 cv=Cv2ys34D c=1 sm=1 tr=0 ts=699fc50d cx=c_pps
 a=Ja4avHF4q49+S+GKa94BQQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8
 a=9tW1x-25GcnGO8B5WRUA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-ORIG-GUID: rptZG11qM5raWaOaBEwKjeuSdeB9JznQ
X-Proofpoint-GUID: hMnakh0KYG3d015aqJiSLlqwUOlQapGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260031
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Feb 2026 03:59:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19085

SGkgUGF1bCwNCg0KWWVzLiBJJ2xsIGFkZCBhIHRlc3QgY2FzZSBmb3IgaXQuDQpUaGUgcHJvYmxl
bSB3YXMgcmV2ZWFsZWQgd2hlbiByZWNpcGVzIGFyZSB1c2luZyB0aGUgc2FtZSBTUkNfVVJJICsg
Z2l0Oi8vIC0+IGZpbGU6Ly8gUFJFTUlSUk9SUyBzZXR0aW5ncy4NCg0KUmVnYXJkcywNClFpDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVsIEJhcmtlciA8cGF1bEBwYmFy
a2VyLmRldj4gDQpTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTksIDIwMjYgMTA6MzcgUE0NClRv
OiBDaGVuLCBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnDQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdW1BBVENIXSBmZXRj
aDIvZ2l0LnB5OiBmaXggdXBkYXRlX21pcnJvcl9saW5rcw0KDQpPbiBXZWQsIDIwMjYtMDItMTEg
YXQgMTY6MTMgKzAwMDAsIFBhdWwgQmFya2VyIHdyb3RlOg0KPiBPbiBUdWUsIDIwMjUtMTItMzAg
YXQgMTA6NTQgKzA4MDAsIENoZW4gUWkgdmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gd3Jv
dGU6DQo+ID4gRnJvbTogQ2hlbiBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPg0KPiA+IA0KPiA+
IFdlIGNhbm5vdCBhc3N1bWUgdWQgaGFzIHRoZSBzYW1lIGZldGNoZXIgd2l0aCBvcmlndWQuIEZv
ciBleGFtcGxlLCANCj4gPiBpZiB3ZSBzZXQgbWFwIGdpdDovLyB0byBmaWxlOi8vIGluIFBSRU1J
UlJPUlMsIHVkIGlzIHVzaW5nIGxvY2FsIA0KPiA+IGZldGNoZXIgYW5kIG9yaWd1ZCBpcyB1c2lu
ZyBnaXQgZmV0Y2hlci4gSW4gc3VjaCBjYXNlLCB0aGUgdWQgZG9lcyANCj4gPiBoYXZlIHRoZSAn
c2hhbGxvdycgYXR0cmlidXRlLiBBbmQgd2UnbGwgc2VlIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+
ID4gDQo+ID4gICBFeGNlcHRpb246IEF0dHJpYnV0ZUVycm9yOiAnRmV0Y2hEYXRhJyBvYmplY3Qg
aGFzIG5vIGF0dHJpYnV0ZSAnc2hhbGxvdycNCj4gPiANCj4gPiBMb29raW5nIGF0IHRoZSBsb2dp
YyBvZiB0aGlzIGZ1bmN0aW9uLCBJIHRoaW5rIGl0J3MgdGhlIG9yaWd1ZCdzIA0KPiA+IHNoYWxs
b3cgdGhhdCBzaG91bGQgYmUgY2hlY2tlZC4gU28gdGhlIGxvZ2ljIGJlY29tZXM6IGlmIG9yaWd1
ZCBpcyANCj4gPiB1c2luZyBzaGFsbG93IGFuZCBpdHMgZnVsbCBzaGFsbG93IHRhcmJhbGwgZG9l
cyBub3QgZXhpc3QgeWV0LCANCj4gPiBzeW1saW5rIHRvIGVuc3VyZSBpdCBleGlzdHMuIFRoaXMg
c2hvdWxkIG1ha2UgbW9yZSBzZW5zZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFFp
IDxRaS5DaGVuQHdpbmRyaXZlci5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9iYi9mZXRjaDIvZ2l0
LnB5IHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9naXQucHkgYi9saWIv
YmIvZmV0Y2gyL2dpdC5weSBpbmRleCANCj4gPiA3MDljNjkyYTguLmYyODhhZmI1MSAxMDA2NDQN
Cj4gPiAtLS0gYS9saWIvYmIvZmV0Y2gyL2dpdC5weQ0KPiA+ICsrKyBiL2xpYi9iYi9mZXRjaDIv
Z2l0LnB5DQo+ID4gQEAgLTM1OSw3ICszNTksNyBAQCBjbGFzcyBHaXQoRmV0Y2hNZXRob2QpOg0K
PiA+ICAgICAgICAgIHN1cGVyKCkudXBkYXRlX21pcnJvcl9saW5rcyh1ZCwgb3JpZ3VkKQ0KPiA+
ICAgICAgICAgICMgV2hlbiB1c2luZyBzaGFsbG93IG1vZGUsIGFkZCBhIHN5bWxpbmsgdG8gdGhl
IG9yaWdpbmFsIGZ1bGxzaGFsbG93DQo+ID4gICAgICAgICAgIyBwYXRoIHRvIGVuc3VyZSBhIHZh
bGlkIHN5bWxpbmsgZXZlbiBpbiB0aGUgYFBSRU1JUlJPUlNgIGNhc2UNCj4gPiAtICAgICAgICBp
ZiB1ZC5zaGFsbG93IGFuZCBub3Qgb3MucGF0aC5leGlzdHMob3JpZ3VkLmZ1bGxzaGFsbG93KToN
Cj4gPiArICAgICAgICBpZiBvcmlndWQuc2hhbGxvdyBhbmQgbm90IG9zLnBhdGguZXhpc3RzKG9y
aWd1ZC5mdWxsc2hhbGxvdyk6DQo+ID4gICAgICAgICAgICAgIHNlbGYuZW5zdXJlX3N5bWxpbmso
dWQubG9jYWxwYXRoLCBvcmlndWQuZnVsbHNoYWxsb3cpDQo+ID4gIA0KPiA+ICAgICAgZGVmIHRy
eV9wcmVtaXJyb3Ioc2VsZiwgdWQsIGQpOg0KPiANCj4gSGkgUWksIHRoYW5rcyBmb3IgeW91ciBw
YXRpZW5jZSBvbiB0aGlzIG9uZSBhcyB3ZSB3b3JrIHRocm91Z2ggdGhlIA0KPiBiYWNrbG9nLg0K
PiANCj4gVGhlIG9ubHkgcGxhY2UgdXBkYXRlX21pcnJvcl9saW5rcyBpcyBjdXJyZW50bHkgY2Fs
bGVkIGlzIGZyb20NCj4gdHJ5X21pcnJvcl91cmwoKSBpbiBsaWIvYmIvZmV0Y2gyL19faW5pdF9f
LnB5LiBUaGlzIGlzIGNhbGxlZCBhcyANCj4gb3JpZ3VkLm1ldGhvZC51cGRhdGVfbWlycm9yX2xp
bmtzKHVkLCBvcmlndWQpLCBzbyBjaGVja2luZyANCj4gb3JpZ3VkLnNoYWxsb3cgaW5zdGVhZCBv
ZiB1ZC5zaGFsbG93IGxvb2tzIGNvcnJlY3QgdG8gbWUuIEkgdGhpbmsgeW91ciANCj4gcGF0Y2gg
aXMgY29ycmVjdCwgd2UnbGwgdGFrZSBhbm90aGVyIGxvb2sgYXQgaXQgaW4gdGhlIG5leHQgcmV2
aWV3IA0KPiBjYWxsIGFuZCBob3BlZnVsbHkgZ2V0IGl0IG1lcmdlZC4NCg0KV2UgYXJlIG1pc3Np
bmcgc29tZSB0ZXN0IGNvdmVyYWdlIGhlcmUgYXMgd2UndmUgbmV2ZXIgc2VlbiB0aGUgQXR0cmli
dXRlRXJyb3Igb24gdGhlIGF1dG9idWlsZGVyIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLiBUaGVy
ZSB3YXMgYSBzaW1pbGlhciBlcnJvciBzZWVuIGZvciB2MSBvZiB0aGUgcGF0Y2ggd2hlbiBpdCB3
YXMgc3VibWl0dGVkLCBidXQgdGhhdCB3YXMgYSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24gbW9k
aWZ5aW5nIGxpYi9iYi9mZXRjaDIvX19pbml0X18ucHkgKHRoZSBhcHBsaWVkIHZlcnNpb24gd2Fz
IHYzKS4NCg0KV2UgZG8gaGF2ZSBhIHRlc3QgY2FzZSB0aGF0IGxvb2tzIHJlbGV2YW50IGluIGxp
Yi9iYi90ZXN0cy9mZXRjaC5weToNCkdpdFNoYWxsb3dUZXN0LnRlc3Rfc2hhbGxvd19taXJyb3Jz
Lg0KDQpBcmUgeW91IGFibGUgdG8gbG9vayBpbiB0byB0aGlzIGFuZCBleHRlbmQgdGhlIHRlc3Qg
Y292ZXJhZ2UgaWYgbmVlZGVkPw0KDQpCZXN0IHJlZ2FyZHMsDQoNCi0tDQpQYXVsIEJhcmtlcg0K
DQo=

