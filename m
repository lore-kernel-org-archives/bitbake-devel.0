Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02423CD342F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 05:26:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6961.1778217965736622984
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 22:26:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=gjTufxft;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=95881349f0=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6483iZw31953070
	for <bitbake-devel@lists.openembedded.org>; Thu, 7 May 2026 22:26:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=u2HMr66zDi68ZFqVCvETcWXnU/916tH3DkfnACt2h/0=; b=
	gjTufxftruvGGeVjnkHvVuayXS0cHaqux4XSw9+L+6EZAk66gNDV76PHm3EPeA3d
	rhUQxfj2h2PiNf1OG8Gyiev4EN//oQNGmVM5dHbAYfqPus9cqzebOCrR3M+036jO
	kwyD5Epq2yEemaBrD7DhWBF/vIjESEDaE36NsG+EOSHTDbn+4dsoMA1L4/TpDcAs
	nDXCcTXEGQCUtFKklpSqde8ISrfVEHCdlYc1cLPa2jpNr/gU0o7KISVuq+BehP4A
	6zo77ij3SrC+NajhKKWp+AVZPfmiNdH/FqQOGyROV+LM6rlvhsbtt+JVFd+3e75L
	mG+GG4ejQzVzfi1zW7txjA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwgsdfd1d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 22:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOzk60iMi4BmtK0SEj50+ZPiBxjnQF0UeiGlO7eL20G/KXCtcVoLAFW7K2hvORE0Y/kF2M2EZ0g/dEa2/uXDEIhpL1Tz5d0OLA5LgH/vfleb/XONyIMQdXQRNaEXWegKGc8x0d9fuTRLlWPdaWc41OrIcX93ForMS3mwrfTWiBXBlxOkE69eJ5oPktLuALqLSvypMQaqt12ektWpXrW4HQOWnv5t54vExwZoEYXEaHwmNPVzWw+P6QVN4aeAfHE5QJpX1PJrs1Mg4ciJeoU1XWSfxx5KP8ZduseTCdLyUGdYF/tqyI5bP7v9KnqXFCKnR/oCBaM4h2hsp8qMLiNHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2HMr66zDi68ZFqVCvETcWXnU/916tH3DkfnACt2h/0=;
 b=ZS9c29h+1oQz/l2DsoSAbeBC1R7HxnTEg6dQsrdzEPbcQguGkNz+682KTDpmv8RB8sF/dLZAGrGLOgWtvdRHPAxInj6c0OZyx+zfMLLd69fjA9AF8rYbIulTbbfBzL2vEe6ePIuYJwBLvDBJfYhSYK67TA8Rdy71rv9rovlYpaXh/NgRRaJ6/LPz6v31jaHe+3/UwdMuq/MO+lrUuBg1RyKt7akpwfQgFohbDCFIgPLx/l0y2zoviMSTJua9hk/1Adyg7fiVF/7nd42FswkcMl0fW5+iotXQK/uegnzTvj+yHAd92msgxTpD4YEzLv9Aim7nBvycHcgCJI3YM831ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 05:26:02 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 05:26:01 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>
Subject: RE: [bitbake-devel][PATCH V2 2/5] fetch2/wget.py: add filter_regex
 parameter to latest_versionstring
Thread-Topic: [bitbake-devel][PATCH V2 2/5] fetch2/wget.py: add filter_regex
 parameter to latest_versionstring
Thread-Index: AQHc3elok/poPmeWtkKG5IILFyH6zbYCYNuAgAE5fNA=
Date: Fri, 8 May 2026 05:26:01 +0000
Message-ID: 
 <CO6PR11MB5602943EB4E823A8DD375DFEED3D2@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20260507061845.1460893-1-Qi.Chen@windriver.com>
 <20260507061845.1460893-2-Qi.Chen@windriver.com>
 <CANNYZj86Swp0qkKi2U_3zusvGm2cXXeSg3iMd6fRLN05uCKwfA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj86Swp0qkKi2U_3zusvGm2cXXeSg3iMd6fRLN05uCKwfA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=2e32a999-c032-4efa-b123-0be1bc65853b;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-05-08T05:25:29Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|SA2PR11MB4985:EE_
x-ms-office365-filtering-correlation-id: a8c1f120-5f32-4278-1fad-08deacc24b3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: 
 TyQG+yWAH+k4mpnGEBd91Pj99RcxuLPL0vF/MyxlHAWtDA2wc9sLVtN76N9bNDNI4Z65IEZWDxBLhKTtXBxP9EEjpVpEX2TTP5BonbYz6cupr57Z6JeZfR/xkVthRH5Mt6X3L8VRwSXGC+jQYIXCL7m2KMYk1FtYl2M3ITtPiGD2nwGfuE7vf4FDm8OkfHhrmRNKmBsUd6U0SeaHR2ST/fQlBX0GNc2Z8/jPZXz5+N4atMCW3UgaxxZf3lHDjewDPVb3tQFABH/Vln59pXuiOmDq6AnGwYTnjhUVp5Qv9NepE9lGtHTZWBxiDtokFq3pE1QBLgnE/ztZrNZVuIhnozHfIqOpl9KJ0wfwN5Fb1YIngkZvUezXyzLxdxgQH9TzumtiLU7tEDVNt+I52XP7jVN5WX4LiOEjTqj6EZrzTQgZc9jadUK8UnWT5+39vmjymfNhUXks/F7ROKEUMIiFSxutIdLxo3/JVQYscA5xep454W57TKC4SwOpQRyxl1RlV+/LCbwckZM/oostu8FOXtxWl8K0sd2N6xmt1u/dyzVxV/wWuajN+h6P5Y7MJ7HG4aVAhIxYcUf2NHs5ZisAwzAUOFKVdA2kbHoSJp53OEh6M+DyoghTBDdyym2R90veOOy8gfCwlx2yA7ncGEbhxXoyQkZ8PmdluoBbdL9goXVdPxyz++uBffE0vcslTFR83rdI/nNjmNeEgv23vpAPXdVUV0npfU/XIBlPGfFMol2V/gPdEyIaXcgNMfjAz6w5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RThGWkZyQ05tVjVGbFo3dEl1eENxdW9uY0lnZmdCYmpKOUhQaVNrR3NSRXlK?=
 =?utf-8?B?dmxMZi9PR2FnRkFyYVAzRERSV21FUTZ1bDlONHc5NTRhQk1pVkMxMk1xV1hz?=
 =?utf-8?B?eVhLQ0pxY1FYL0ZBV0t4YjR1T0hFK29lV0xMQnI2bUV5eWZjZ0ZuMVBackFM?=
 =?utf-8?B?aEdVQzJDenlNNk9oUVRvMUN0bDQxYTBLQmVmTlRzV29rd0QyL1VlekNoeGxU?=
 =?utf-8?B?WEZTTlpyQ1VoVkExYXJ3NTVYYVFRY3VVTC9kdDNzVGtCMVR6Vjdyb0Npekk3?=
 =?utf-8?B?SGk5RldVcXd6UW9pSlhnMFlBUm8yYzhob0d2eDNOd3h6K0xrK2xuS2RGUmRt?=
 =?utf-8?B?ZERMMUtRcEZTVndjOVFhQmdjMUU5L25NcnVKbmZKTWp6SnBUWVhDNk41TGpk?=
 =?utf-8?B?V29aYmVqVWY4RzVicDVSNzVqb2ladmtKbEJkT3M4eURzTHJlQmZFOEduQUZm?=
 =?utf-8?B?dWRZd0ZScFN1eS8zaWUwUyttcll3ZTZWamI3WTRLcG5rSmFhZUtSTitNbzZ4?=
 =?utf-8?B?RzMrdEtKNUtBWDVJQ09nUUowMjM2ZjI0MURzdWlHV3loVVZ3RHNpd2wwaHBi?=
 =?utf-8?B?cGc2TlBtZ0luWVkvMEgxRmp2UjNmMzZ1R3BKR0xBR3UrOFBPNnJVNk14OXBq?=
 =?utf-8?B?QTUvS3FFUUNYRVRoaytYLzdFSjFySG9tZHE3QmNoanlnNDAxN0ZxN3E2ZGxv?=
 =?utf-8?B?UXNneFdQS1FpMERIbDgzMlQwMHNZZ3h3R0taOFczdFFRN1ZNUW00RTllS1JS?=
 =?utf-8?B?UW5Scm4vOW9mNVZXZEs2dHNURG1KTVNTcENOcXRkaEdGMkxlYjBMcGRkV3hU?=
 =?utf-8?B?RUw5NlRtZUtBUFlEaG5RelJWVitaU3JObUp3VFVrZFpBNGNmUmNrL2Z5SkJq?=
 =?utf-8?B?aXNKZGpoVVA1dGcrZUFLQUdGcTB4UVAxNEVWdEJOZFNUV2Jxc3hWS3ZYOXJJ?=
 =?utf-8?B?dzNJZUR6OENHa3o2VFAvek9PVktMcTArLzdadFh3a1VITW5OWGxwd0lzN1NY?=
 =?utf-8?B?cWFYamJRd3hpa3NTVVBsL1pvb2o2c3NVRmNGeEg2K0xrZ3ovYUN1bWVkMVRD?=
 =?utf-8?B?L0JXejFkWmdBSVFzN0JERFNqc216Y1Z1S2dkTEpnTUZOeGRxbVpPNEIxbzBt?=
 =?utf-8?B?VUJMK0lPTlNkN1FRMjNsWG9mTWdBNGZyMjhvR2w4bTdmeXQyUFcrKytwczJh?=
 =?utf-8?B?Y0VpeVIwZ25vSVpYTmhXc0VubURUNGhWaTJhQVlyMnhyeUxkYXMydDJQY0ZS?=
 =?utf-8?B?WXBWalZ5Y2t4Z1IzTWhYUnBWQmNnaC9paUtLVnNXa2d3WXc0bDkwMVBEdVcw?=
 =?utf-8?B?TVFGSlVhUGRoQ1lLc1BzVkxRNWNyUWlWRS92UG1uTERxRTZkTEthRUhFYVZB?=
 =?utf-8?B?cFBzOHlzQiszSWRMUFZjOHp6T29xZVUyUkx3YS9MUkkyRFJnOGRJVmQ1WFg4?=
 =?utf-8?B?VzZaaFlNS0dDY2ZVU0dzaER3KzRBZ3AvTmFlQkJHMnh5SllsaStGQ1hsZ1M4?=
 =?utf-8?B?NFdjN2FRQ2xlQlAvdmorVXd5cTB6bEt6THI4QnRKSU9vVGt5NzAzRi83STJx?=
 =?utf-8?B?Z3pucXAxSk9Jd0RGVTBMUktFZmN6cjgra1BGbytRSHVrcEtjR1hoZzBDVHhm?=
 =?utf-8?B?cXZmVVU2SjlkSitPdHozejVZUC9Va2pHbFdBZkVTaGJCZERoRGt1UGl6azNl?=
 =?utf-8?B?Tll4SGI1aFJaWkRPenFMWHhrenREWVFKL3ltaTdLbEI1bXZJdFdjNGx1b1dk?=
 =?utf-8?B?aWhRVmt5QUh2OGwwSnVrYkVEekE0VUlhdkk5SkV6aFFnZjJYRG51a1JNZ01h?=
 =?utf-8?B?bFlrbCthQW0vaGMzbkt4R1hlYXc0UXhIaGczcjB0bkwrczZVYjkrWWJpNUpy?=
 =?utf-8?B?WFB1S21IcFdMbk9sQWRRTFd4UUROZlNoMDRlOFdjSDNycmVNeWlPcy85WWNm?=
 =?utf-8?B?cDZQTnVEK0ozSytOeGp6VnhuZS9kRytqQkNVZk4yaFB1NFZNSEpmd0tqMXFs?=
 =?utf-8?B?UjdYL3U3bEhpZjhyc0hENkducmI1MEJKV1o1VXZYRUNaVTJBc1YwLzFuNEdx?=
 =?utf-8?B?YjVQbi85TmFMUVBKTVJMZW0yMHRON29Nb2VINkFIQjJkMVpBUUxYdWREM3R5?=
 =?utf-8?B?bXZua0JUWWR5b0VZMVZoTXI4eTdWL081c0hORW1oUk51OG1QQUs4Ui9OSDZF?=
 =?utf-8?B?STJ5dERaN3JLVE1UTW1TNFhpVGdtWEZVN2Z1RUJzWFFtOFhiSEJvcXRhZjhu?=
 =?utf-8?B?NlNKMWZJdFkvYnNKUHJxOThqOS9MKzdWUkw5N3ZpL2xtd2dUOEpUcW5lZ3lL?=
 =?utf-8?B?bmhNelNCK1FHOFZ1aUw3RHgvUGs2MFBRRGZVODYrczNaUGtVdDkwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	OQiof2ptYe6PGy2PeYGIpiy7zO1x2DiRZwEbfy6/o7lvmrvpFOw8py/GyPu1eTj/yz32wPBlFwOKDA0CVzdzmLyjEGlKEFuVaWbIH8b1USqavgFwV6vDU7Xzww5grt34uG7yyG4J/nMtjG0weu48tqz1dmVc+d28MXPHxs63MC63ZkjFj/EJ5FiFEGVYhdNwljaHWdStl5YXFhhFmH9RnCl4SQG7DMEvC86xuQG0GpoAUXjOu7Rooxks3s9E8dAn/cRgUXnP8jPs9+8Cz+CBtNPwFbdDK1WpxtHWVkjqK+NUP1dlOKBGvi7hLKYI3xVKVfADcW5NL4uK5X1T2yjWfg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c1f120-5f32-4278-1fad-08deacc24b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 05:26:01.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubP8W521ZeIL6R57TzswJ4/xJ/1uHJH18+12AVo//xtnsX1y71RINFDXCZVLeBZ9Up1Ib0nVZbJfvrAubozk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4985
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: GBbYbpgnKtZn_cCK3zxCgDXtCGIXBDSB
X-Authority-Analysis: v=2.4 cv=JeGMa0KV c=1 sm=1 tr=0 ts=69fd73ed cx=c_pps
 a=Vx/W+/sNOQWsPBnrpFcqzw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8
 a=9xlCMBgcyVpouKsEUYUA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-ORIG-GUID: Ub-xGg9hbNRZ4ZHrlI9UZ-IfYb9kTTsq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA1MSBTYWx0ZWRfX79fBqMpPdOtG
 EafwDSaqHs5hloMwv3r2Lga+/idhVqhb9ge7oLv4Af7Ieh7lFyIDKEjSe0xU/JAH2Ogu8nUnIUt
 ndMecKEbaF+w19zBP4z0pEszu6VOPjDCDAWnTOl1v3EpGinNSwqaMC9hsAmKsxHOG1Qb4zBjWLm
 /H7mOrjf8eYVRHM/8IUv3mZ4L7wTAbTx8ucs/j5RiuG6C58sbJa92o3FHM6p6i5gWhiNXCMGSlY
 UDbTgp6bdMM8OtvyS9/h3XPRUgb/PYJCbWAcKMj2YVv2FcK7zyiKHIvyvWJc0AS08ToYw+e9YKw
 b24snHa8uo+8UkrklpH98iXqxO3r1OhkDuTeAkfG+qNYiCrvVMhYRt+bK+vk7HP8E1PstpDPLl+
 W6R7q0N4QLtdQNx1vFXS1FMJH4kUTWVgC2cyxNM4240Vk60r4y+PBc7RByhPvJstERBMl1rxpdX
 vj7J38l21gqwzYINS7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 05:26:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19472

SSdsbCBhZGQgbm90ZSBhbmQgc2ltcGxpZnkgdGhlIGZ1bmN0aW9uIGNhbGxzLg0KDQpSZWdhcmRz
LA0KUWkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXhhbmRlciBLYW5h
dmluIDxhbGV4LmthbmF2aW5AZ21haWwuY29tPiANClNlbnQ6IFRodXJzZGF5LCBNYXkgNywgMjAy
NiA2OjQzIFBNDQpUbzogQ2hlbiwgUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCkNjOiBiaXRi
YWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmc7IE1hY0xlb2QsIFJhbmR5IDxSYW5keS5N
YWNMZW9kQHdpbmRyaXZlci5jb20+DQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdW1BBVENI
IFYyIDIvNV0gZmV0Y2gyL3dnZXQucHk6IGFkZCBmaWx0ZXJfcmVnZXggcGFyYW1ldGVyIHRvIGxh
dGVzdF92ZXJzaW9uc3RyaW5nDQoNCk9uIFRodSwgNyBNYXkgMjAyNiBhdCAwODoxOSwgPFFpLkNo
ZW5Ad2luZHJpdmVyLmNvbT4gd3JvdGU6DQo+ICsgICAgICAgICAgICAgICAgaWYgZmlsdGVyX3Jl
Z2V4Og0KPiArICAgICAgICAgICAgICAgICAgICBpZiBub3QgcmUubWF0Y2goZmlsdGVyX3JlZ2V4
LCByZS5zdWIoJ18nLCAnLicsIG5ld3ZlclsxXSkpOg0KDQpUaGlzIG5lZWRzIHRvIGluY2x1ZGUg
YSBub3RlIGV4cGxhaW5pbmcgdGhhdCBmaWx0ZXJfcmVnZXggaXMgZGVyaXZlZCBmcm9tIFBWLCBh
bmQgc28gdXNlcyAuIGFzIHNlcGFyYXRvciwgd2hpbGUgdXBzdHJlYW0gbWF5IGJlIHVzaW5nIF8g
YXMgc2VwYXJhdG9yIChhcyBzZWVuIGJlbG93IGluIHRoZSBjb2RlIHdoZXJlIHRoZSBzYW1lIGNv
bnZlcnNpb24gaGFwcGVucyBiZWZvcmUgdGhlIGRpc2NvdmVyZWQgdmVyc2lvbiBpcyByZXR1cm5l
ZCkuDQoNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNrYWdlLCBwYWNrYWdlX3Jl
Z2V4LCBjdXJyZW50X3ZlcnNpb24sIHVkLCBkKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBhY2thZ2UsIHBhY2thZ2VfcmVnZXgsIGN1cnJlbnRfdmVyc2lvbiwgDQo+ICsgdWQsIGQs
IGZpbHRlcl9yZWdleD1maWx0ZXJfcmVnZXgpDQoNCkhlcmUgYW5kIGluIG90aGVyIHBsYWNlcyB5
b3UgY2FuIHBlcmhhcHMgc2ltcGx5IHBhc3MgaW4gZmlsdGVyX3JlZ2V4IHdpdGhvdXQgbmFtaW5n
IHRoZSBhcmd1bWVudD8NCg0KQWxleA0K

