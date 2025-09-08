Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8411CAC586
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 11:16:43 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.8])
 by mx.groups.io with SMTP id smtpd.web11.10694.1757330200881398437
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Sep 2025 04:16:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=jvG5u73f;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=jvG5u73f;
 spf=pass (domain: arm.com, ip: 52.101.72.8, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hFkN5Z1AtoBdVtJlddEwAhvOlHlvLZmZweNzJobrqcC/xBXKpQzpYL1fPqG6WVYQc0tfM6DyLAqRkLg6mtD2Y/DO9HX5aAf79fydrjpIrVd8VwmE9gY8qhoZJgoBk4EaPCjXTzs2dx7mvLHWQuhByZg41cJzQ44FzPaoMRYfwxjd7lD3BmJom1j4IJZa1dshBek9BKq4fo4x0ZiSFxZXtpeyTARfK4/DSRUlUtUUeT+MT4ZunRSPLGQqjRDQbESneTmJTLwOs5/LecAlI7Sdn/qCrrEzVYgJs1ckoGYI3/lxe9fhhEkLf/eE4zKOqT5U6mqIHlDgP0zCuWNdx/9AsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvk2Slu95HyR44aLiBIlaFA3M4Ejf3ioHEwGMrDXuVA=;
 b=uePt7fNkMPla+NUFe+fS0/MpMOk1R9U9yryUXJ1v9pSsQ2g6OY2oq52Zt3JuOAbYlF9hxtFanmGrEBP5bRr17Cp15xWwJ9jtmkj2GMiyECcnw0qE3MmWCAd32g1z9caXWkESMvOSikTiwGBXCCKsN7MgHhHqn64O+M5qKLlukoxZ3ZSckmusMvdASE5WJnui6decStGvMlOMz3XIK22j2LLOXcPVD1ak7CuTq0LnHtaJv/NguK5JTuLoYymQFq0R3SASa8/sd5tYz2D7vH/UUdSYrSJddMOPpUE16h+zknlYWmumYLYr26OxQVNe/MB62BG1Pw8ND1pj1KHygUmBLA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=freemail.hu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvk2Slu95HyR44aLiBIlaFA3M4Ejf3ioHEwGMrDXuVA=;
 b=jvG5u73fZgDPQWKpv2uZWrT9jxZmKPD1jHRnU0+OcXuTpf20yg8ogdVWY1GiXXHJFakR7YLIORdH2BJ8rl2MdXx4nSQ9pqIX6PTgPedh8QLPWAoEqfu1sdbuO1yihvK47z43xv2qGP1gr1Kh1W4gkJMxhorYPkCrw0DiINq+6RM=
Received: from AS4P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::11)
 by DB3PR08MB8964.eurprd08.prod.outlook.com (2603:10a6:10:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:16:36 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::c2) by AS4P195CA0006.outlook.office365.com
 (2603:10a6:20b:5e2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 11:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/y7bt8ga4LCSz3/6LxttWd9c2Fabb5z8fG2i2pUAw4dy8e5bq7DHgfZSCBhD0JFD6iaCHe7xMwlNC5UJabRnsL84wgZEXkSTfUw39H07jWHXS6JsujziS1FVeipMksBeEPIg78kvrc4jKcGLG294SlwwgN4I/VOqX242tmsY+60C57NpMZ1EFQx81NamFkt/FToO4wJEjzeJy8ABmlNxAnzh1Uxf/S6ryJElW8Fvf14E/S/pkDM5DZyXgCJYPgt6lSK0o438SIDjGBpCTTSchAcCWreGpJs2SD1+8vlfc+t+tEHGL3hP5ph3ApicpF8cuMePpUaHcAQBkrVzkOuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvk2Slu95HyR44aLiBIlaFA3M4Ejf3ioHEwGMrDXuVA=;
 b=b+7aqnyCVGsMDr+coTB/40RlHJyFIWJzU3AC1kESAR70pzdKJK8mzSgdpcp1g66fsrK3HYeurG03jendl5MFDVKMBroLSDNTdlRW9gVLRC2UBDuB4Lm4sGx7UCMvvnxxclyVll/DEpH0K11nYHQkiKBqfJgTh0GU60f14+tE6csYWFO/TofyNdfReQ4bFLTkmAUdkUw/UynCdEKsBov8+Bo9thPFc7lZvnyEA0z86/akM/KIMbQeYnirwb1oDJGaY+zTlR0fmP+bjYCg9lcRQS8EQI+JdFvo1xappz+HZq7735PD/QkFdju+LYoMdeHK46Vgy9dnEubq/9Or+VbpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvk2Slu95HyR44aLiBIlaFA3M4Ejf3ioHEwGMrDXuVA=;
 b=jvG5u73fZgDPQWKpv2uZWrT9jxZmKPD1jHRnU0+OcXuTpf20yg8ogdVWY1GiXXHJFakR7YLIORdH2BJ8rl2MdXx4nSQ9pqIX6PTgPedh8QLPWAoEqfu1sdbuO1yihvK47z43xv2qGP1gr1Kh1W4gkJMxhorYPkCrw0DiINq+6RM=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by GV2PR08MB8678.eurprd08.prod.outlook.com (2603:10a6:150:b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:16:03 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:16:02 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "egyszeregy@freemail.hu" <egyszeregy@freemail.hu>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: cooker: Fix performance issue in
 EventWriter() class
Thread-Topic: [bitbake-devel] [PATCH] bitbake: cooker: Fix performance issue
 in EventWriter() class
Thread-Index: AQHbbyBbI00F+WjgWkS0zNLtnw7hY7SKhZ8A
Date: Mon, 8 Sep 2025 11:16:02 +0000
Message-ID: <76CB8223-6F82-4D51-A783-D0E3D1FE8031@arm.com>
References: <20250125115640.1302-1-egyszeregy@freemail.hu>
In-Reply-To: <20250125115640.1302-1-egyszeregy@freemail.hu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|GV2PR08MB8678:EE_|AMS0EPF000001AE:EE_|DB3PR08MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: c54f3cf6-f72d-4485-635d-08ddeec92cb9
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?UnBxY3NDQmQ0S3p3ekpDYzd4ejFQMkhIT0pUbDFSaFNFOSs1TXFETmlMSkhH?=
 =?utf-8?B?bTdxbGJoejJiSi9wbXR2WnlyclZVanA4WUhsREpsRXFtSGtva0I3bFNNeXlx?=
 =?utf-8?B?M2ZuY2dZRTgycnQ1eEFNd3F3UWlKbW5OcXYzWUZGbnhUTnk5dkV1SFMwcTVX?=
 =?utf-8?B?bjJPY1hVNFVscDFVNm1DbXBWbnhXaTU3UmVqR0ZGMENQdVI1RlhadHNJSHIx?=
 =?utf-8?B?dXJzRTFaRkRvb081Z1hYZ3E0VldVMDJRdUlnR2RQVkVwcXlzT29PUkpyQTJS?=
 =?utf-8?B?TmQxY2FiSjVZSHMxSUJnM1BnQXZ3QldIalRxNHYwUkJzUzBYdEoyQXp5ZFN4?=
 =?utf-8?B?bWg0cGFITWR0a2VKMzVROTVTMlBlbTBIVUZGNU9sL2tYOFZjRGF0UWJ6TkNQ?=
 =?utf-8?B?cFViR3ZjS2l1czNzQXk1WjNnU3lDaFdiSUFPaDFaRnhnSFl3UGhhcWUwWXFx?=
 =?utf-8?B?YWdYS0QwWFQ1Y0xsRWRlMGRRc045NFF4aENXWE5uMWhDeEllVys1anZQNGpw?=
 =?utf-8?B?blk2b2I2OUlScUpwcVNFOEN1SGxxZGdsZSsvbkE5NmhaNm5saUNwZC93QTc2?=
 =?utf-8?B?VGlTRFpaajNRalNxeWI0c00yY0dOQWFQQ2lzSTNIOE1ESDhiNVU0ZEtiMDFW?=
 =?utf-8?B?YVhYY1dHOVJnWTdIK3prbXdYNXRUU0ZseUVHUUlHQVorT2crblNkRUpNbzB5?=
 =?utf-8?B?akJDb3A4RkdSMDVuWFVwOHJ4VXp1ZFY4UVdpbERjUXVyWlZtcllzODNraWJu?=
 =?utf-8?B?WHpwY0dlc3VNS3dsU1ZLK3Byai9zNVBKM1hNYkRzSHdoZzhDekZNeDFPbFRZ?=
 =?utf-8?B?ekRabXVKMzNCQlB0Yi8wOURHOFhVYk5aRmdGb0NLczFPVUxtNWswbC9NMnV6?=
 =?utf-8?B?T3R0V0U0YWF6aUFVaTd5MnM5NDBFYmYrWUhyNjRLbHgrOHhtSWVxeFBTbUR4?=
 =?utf-8?B?MlIrNjI4TnNkK3o1K1FUMmRnbzdsU3ZyNUk4V0NaMVFhTDBucXI1cjVndU55?=
 =?utf-8?B?QUNKcG52SFZIVnJZY0lTWngrSHJIWllXd0Z0bmtWVUhPd0svTDBlSVlabUli?=
 =?utf-8?B?MWtRU3JoZEZaRkk3UTNENHBkZGNLb2xNb04wTThEakNjWExkTFdwVmM2R3hp?=
 =?utf-8?B?ME9hanJFUGJqSUtRV201Y3Yra1Q5UE9TVHFveUNEQ08rempsWThFc1MvMk1s?=
 =?utf-8?B?RFlSQjBjN2VnOExrR3FCL0pybDRycEQrRFIxUEZmK0FobUlLb0ZCRi9RUGhu?=
 =?utf-8?B?RVhDVGJvMG8wLzYrbG5TaFVVZlpWV0VCTVA1YkE5dUFMbTk1VCtNRWd4cVJ4?=
 =?utf-8?B?MzlKWWg2SXp6Mm1FM01pNHlBcVozbU00QW52LzRUdFRSZmlabmpINENJSkFZ?=
 =?utf-8?B?eHgvd050a1RCUHFEV0hXejJ5L212SktiRWE5Y1hMME0yYjFncEJYbnhuWjJL?=
 =?utf-8?B?a09YeUhpQXhHcDZQSWxraTcvcFVJS0xUcGNuMmpIRVhJTEs1MU9jd2l5L0k0?=
 =?utf-8?B?TWlxTWlMRFJqUitRMEo5Wi9NNHYrS2k0WUtTVmltMkpScjhMN1J2Z085V3BX?=
 =?utf-8?B?VkMrM3kzR3dvL1gwWG93VU9HanNPSm5oZjdvMTMwTFBSc3J5alQrNkErMGxv?=
 =?utf-8?B?b0hLV3FOMmg1YmNPUGlVS2RTdVBTVGRyOHNXblNvL0xsbWVwU3oxZ2NGY0tN?=
 =?utf-8?B?alcxZHVRaWxKajU0QlB3SzJzL202Y01yN3hleElKcGJCRFpRazNsajhNeGJN?=
 =?utf-8?B?RXAzUURaTUNWakhwTmV6OXFEMDBYcWtaTFlXMFdLa3phMksrQUZxVW4zc0Ro?=
 =?utf-8?B?bjErOWpzZ01pYzJZL0pkb2VKSis3dUl0dGFYUWpJWVdrSTdva3VKdEFnRWxw?=
 =?utf-8?B?ek50cllTaTYrNVBxYTFlNVVwOGhZYlpPdnJNeldDV0VsNDdxNkd1SUNjV1hw?=
 =?utf-8?B?eTdyeVpIQnVnWTJEdGp0T0xwQmpMNXkrdU45b1FJTnR6ME1UY3J5d2dxdW83?=
 =?utf-8?B?YnNvcGswSmdRPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <C713179A238B9147870AC2C3F3901155@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8678
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	d6bf1a1d-3eeb-426c-1813-08ddeec918d8
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|35042699022|36860700013|82310400026|14060799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEJidlI3RndKRS9mdkt5a0xIRlk3M2NJdXE5MTFQdmJML2EvS3h2ZTl3WW9z?=
 =?utf-8?B?bFMxVytCZGozTUt6ZjkrN3A4UGZmZ3ZnVk5uSEFablQrSG5QQjMvVjN2aXFH?=
 =?utf-8?B?SENUeEZZV01TYzVORkdseVZnNkVJVlA2cFFUMWY4YW5TZEQxWXl1TU5GeDlm?=
 =?utf-8?B?RTFWTHUvV0NiQWd5bFY5d2xWL3h5K2pLSUZXaWp4cEZNRkR2bVNSZCttOEtj?=
 =?utf-8?B?cVdrb3ZkdWlFUzlzSlJHQXJhTDlTRHp3Qmt3N2Rld2tUTlhHYlpEbkF3dHB6?=
 =?utf-8?B?RVo3c2FGVGNqU3pIYmdnMU9ISFFGZnMyV0kwUzl5OEdPUU9GMFcySzRmUnpo?=
 =?utf-8?B?dDNWcnB4QnBkeGhib0VKNDNUSmdMNXFFcjhONUJ1UmhhSnNGN1JxbXlicXZq?=
 =?utf-8?B?UTN1NDNKYUJWVzliUWl0Wk9COHZVWDBMNWxqVlA3Mlo4Y3NkYmpnZDJjeWVG?=
 =?utf-8?B?dDNPMWxYUERZaFJZbUdFY0FDUjNHS0tmd2J5S3dPKytKZHloN0pjZGJNc0VG?=
 =?utf-8?B?c2xKK1dyOFpJNzRROUdGNnhTNGFSc0Z1MTA3RTVHSllqZHhNMkV1WXJNTno1?=
 =?utf-8?B?dmpjbDlhWWxkbnRZUjduVThKbzFMd2RQd3pLVEd0UkVwSjg1ZFNiWDVwK3pF?=
 =?utf-8?B?YkVBZ0VwV0NNTmdscDdhQ2ZuaW5BcUR2VitNOXgycm1yZXVGWXJjMTNqemxv?=
 =?utf-8?B?dVhrb2NuNGRqczgwQnREZ2hBU0NqNVhEcGxacFVTZzdtUEEyNDVBY1oyVFBw?=
 =?utf-8?B?WjErSjNyMERWZUZtNUtzUGdUVnQrU1k0Ykp4Z2VZdFJmcm9UUTZOc243b3lS?=
 =?utf-8?B?WlNuS3hVWmxKQnBIN0tuczdTeWRNcmwzbDh0dG1UbE4xR3FpdGcwMHVpb1Br?=
 =?utf-8?B?RVd6Q05iNUNkQkRkUHh2MDI4Y3EvU3V2bFJRRDl6ZUdDK094bFF1TmM3WDYr?=
 =?utf-8?B?YVJrL1lkYkVOeHFrMkRtYllMSExXL3F1OHVmL25jc0ZpWWRCWldlZ1cyZmVI?=
 =?utf-8?B?S1NFODRPQUpPVUM1amFCMlRUaGw1SUlUaFhackNieno3ZkwyWnZCalhrcklX?=
 =?utf-8?B?d2lSd2xpeE5EMTFQTmt1WExER2Vjb1ZqVnZ6U3lSY0lmUVRPVjZWakxoTkho?=
 =?utf-8?B?UXlXQlMrbmZEcWZxTUMwY2w4U3JucGlaWjgxNmhYSFhUQmRTL1BXanJDZ0lj?=
 =?utf-8?B?TGlsUmhrUDhEL1BXWG1zK0w0TUZSSE5adytoSjY3azhaVVdzWU9MRVF0OGU1?=
 =?utf-8?B?MnEwYVN4Q3c5dFZnRmNLMkpqN2VyOU1pNlFIWEhsVHRHR0lES1Blcnh4eHZw?=
 =?utf-8?B?YTE0MDR4czJHNDFtcDkrY3dWK21YVFlTcEMzODdBQjBtNE1sam1DZHplcG1E?=
 =?utf-8?B?ZmNubXhCS0VEWFJ0bkZ6S29qUGNBYUF1YnVSaHlFRjhwZERYRWI4a21Obko3?=
 =?utf-8?B?RS9RRjNUV0dUNjhGNXczT1pGQ2luVWhyMVAxbGhhdzhVQVU4N2lwRFZIdzFN?=
 =?utf-8?B?WGNzQVRqbC96MTJLa09SSENCL0lDV095aE95bGFTM0Q1OWZpY0xTR1ZNY29h?=
 =?utf-8?B?NUt3djhnVElZWkRSWHhHc0lGVmZyd2RpbUQ4dUhCTFNHL280Y1lPeGVwck84?=
 =?utf-8?B?eFpFeVh1WC9WWi9hSkdyTE54QktpamhsSmIzTWZJc0x0SHN3WEx4L2pqNTk3?=
 =?utf-8?B?WVBwNDhEMGlKbGxvUWVBREI1bm94TWlpTXRSNGwvSy9IYVprYy9JRStnY1Ew?=
 =?utf-8?B?TVkyUHRpVWNXR2dVU0dTVmcrNWhlR0hDbWFpY1A1YXZrU2xqN013YmJUcjlt?=
 =?utf-8?B?YzhoSlFHVDFnV0c5SXZ6RGp2Z080R0tReWpVYWxQTWpTSTA4ZEh5S3ZqbFZP?=
 =?utf-8?B?dzJBM0NoQXdrTkZTOS9ob3AxaTIvNWxDS1VwSENrSTJhZW9GYTVsbHo2aDlm?=
 =?utf-8?B?Z00yWDNlWHRWVWYveG45ZE90aTZBMHk0VjFIbGgya1ZMcEp5Qjc5YUN3RVFT?=
 =?utf-8?B?L3pWa0tkelEyWWtWWXBtUmVZbVdGMEZDbEFRLys0OTJwWjRSRUY3ZlRyZTFz?=
 =?utf-8?Q?Kk5H+P?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(82310400026)(14060799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:16:36.2252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54f3cf6-f72d-4485-635d-08ddeec92cb9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8964
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 11:16:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17987

T24gMjUgSmFuIDIwMjUsIGF0IDExOjU2LCBMaXZpdXMgdmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmcgPGVneXN6ZXJlZ3k9ZnJlZW1haWwuaHVAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6
DQo+IA0KPiBGcm9tOiBCZW5qYW1pbiBTesWRa2UgPGVneXN6ZXJlZ3lAZnJlZW1haWwuaHU+DQo+
IA0KPiBSZW9wZW4gZXZlbnRmaWxlIGlzIGEgdmVyeSB0aW1lIGNvbnN1bWluZyBjYWxsIGluIGV2
ZXJ5IHNlbmQoKSBjYWxsaW5nLiBJdCB3YXMNCj4gZml4ZWQgYnkgLT4gb3BlbiBpdHMgZmlsZSBk
ZXNjcmlwdG9yIGluIF9faW5pdF9fKCkgYW5kIGNsb3NlIGl0IGluIF9fZGVsX18oKS4NCj4gUmVt
b3ZlIHVudXNlZCBzZWxmLmV2ZW50X3F1ZXVlID0gW10uDQoNCklzIHRoaXMgYSByZWFsIGJvdHRs
ZW5lY2sgeW91IG5vdGljZWQsIG9yIGEgaHlwb3RoZXRpY2FsIGJvdHRsZW5lY2s/ICBJZiByZWFs
LCB3aGF0IHdhcyB0aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgc2Vlbj8NCg0KUm9zcw==

