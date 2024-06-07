Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB33C27C5F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 15:23:51 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web11.45155.1717773825608651622
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Jun 2024 08:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=EMOyWnk6;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=EMOyWnk6;
 spf=pass (domain: arm.com, ip: 40.107.20.66, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=DQI6/VjdJEDa7T2+0USguezMI+qw8svBBnGNNyG5RD7SqiKkIHeZKbmKcdlsylTH6CgrMts3eBaWem3novTwwOUF3RnT1xkOe2XK7TcMFYGMd10FFLLBdcA409eZtpvNPC9Pf9hItrWQMBmxcQWxKpe7qoOqcYmU44ten94HWDhoktC2kWTL6oQfeNx6e7RClnlWfpjP0RvnpPMoDKnapJoyI6679Tmc29PGZh5XC6d25bz6nRoSBtZpOKSoTX+NH2pQdgXUo5/No7ydfu7NeEHZanM8TKbuvwG2hyvq17ruTcDfDxILOtTaf7n7v6NPjYbM7UJRzyfCKhBvrpdQpw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZNFslYyUUemfM2mMTRUOjAxvD7hODzgpVjv+NjnWb0=;
 b=ZKcVW36FMLr+LmCuqD+rRcHGK/CsuL8TVFj1IUHKwLv4M6Ckg6sXsFFCqcwOGZ+/oZj6dqpnEzgBuK7V9wtaExmMBb1MT8W57VngIqyuFz8n1sbU+oAgH4TIPeRWY0xiXHrgDmhqorhBRW4ThsfYIEK62dl6QJ6zc4pA6Eikv1FpDUFgN62Qzcm6Y+vtm3AGL8uapQO9iHJ61emt0KvfTc3wyACkwhOlwF6oP9WXlAlaXiE6r/w6kl98Gh+qcdXF2u/T82QwG1TiTHfvNtiQV9hsiPX95ooASRh8X5SaCmvt6pEIYka+4uNJwNki2XIcqmCNaCnckk1AWowOD3U/Mw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZNFslYyUUemfM2mMTRUOjAxvD7hODzgpVjv+NjnWb0=;
 b=EMOyWnk6RwmrZ8WZVum0tLQdt/bKfXkvckGVcmNLyv3NTdgxEWUha29gl4Iuy2La57h5yRXsd3UbeNGXhUgRpxAafRkpMowj5k7s0RpkTX13MskrsToMBl7BLdQwfa5FOAutpiTTfEOkFje220M2bAlp/w5a/XFgNNdmUbDpGuY=
Received: from AM4PR0302CA0016.eurprd03.prod.outlook.com (2603:10a6:205:2::29)
 by AS2PR08MB10127.eurprd08.prod.outlook.com (2603:10a6:20b:642::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 15:23:42 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:205:2:cafe::b4) by AM4PR0302CA0016.outlook.office365.com
 (2603:10a6:205:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 15:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Fri, 7 Jun 2024 15:23:41 +0000
Received: ("Tessian outbound 20dfd856a3c2:v330"); Fri, 07 Jun 2024 15:23:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9307d6628ef6a1a9
X-CR-MTA-TID: 64aa7808
Received: from e7271831f141.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C2B886B4-3FD9-478B-A569-14233AF1D303.1;
	Fri, 07 Jun 2024 15:23:35 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e7271831f141.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 07 Jun 2024 15:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNp9hS6/KCSVHv0Q85sY8y0w/LqjfnciHTXh6mbOmw08xz6GeUxNYYcXhvGqHrcdi/8XwvlnsAqTiWDgJqSvu5f655LfsFAsdAnkp2AfS59Rc0hPxkL8jN/krYkPPxNCXUJfX4+cxG2N150Z5NIXMguXodiglsvpia5OlWWEKwSIJWSf60cG+xnhGAo43Oyo/tYeZAvW9EA8kw2MRaft97ey0SlVs8gHd5dS/y1zrVdAL7L2MZsTeoDRqTvnd2ZAvV/AChAF0dnpfkj8i7aLL2ZbEnz/wh4rnhu/hdR5QRxXyb4EUY0G60BmjLfDt9c7XRGEhhRdgl4AGcbsywkZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZNFslYyUUemfM2mMTRUOjAxvD7hODzgpVjv+NjnWb0=;
 b=IIqC4eegXPyknKg/j4w81pDrksAEBoVAoVTBDZOuvhnsqT9TiKwEu7NNNGJ4WpPc7vwdSBKPOwNGeEPYAMr+Nyfs8uhviEdoGKR7wwYGx3FJAN8Dm21jJWmofXJeNLiZfy8GRwNqTLfNxP+CFRoE0O7G52gMxf8MPFvwulJfH5TPYrkMvZAHDRTRWiDhG4uv7bw6Y3l/tdKdjSwWpyM1sNLu14w4Tdgb4ESy2opwitig31Z3MnQ1gWJyS1naYha+iLEkZP5kotcNnhcoJmUnGacsAQx1X5efglfCiMqNC2uzB1QjGTk1Ts3Kf1yhmF/IL9WhpYod+M4yRKYeh7jFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZNFslYyUUemfM2mMTRUOjAxvD7hODzgpVjv+NjnWb0=;
 b=EMOyWnk6RwmrZ8WZVum0tLQdt/bKfXkvckGVcmNLyv3NTdgxEWUha29gl4Iuy2La57h5yRXsd3UbeNGXhUgRpxAafRkpMowj5k7s0RpkTX13MskrsToMBl7BLdQwfa5FOAutpiTTfEOkFje220M2bAlp/w5a/XFgNNdmUbDpGuY=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS8PR08MB8804.eurprd08.prod.outlook.com (2603:10a6:20b:5ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 15:23:33 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%4]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 15:23:33 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "egyszeregy@freemail.hu" <egyszeregy@freemail.hu>
CC: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	"docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: Add user_agent parameter so
 it can be used optionally
Thread-Topic: [bitbake-devel] [PATCH] fetch2/wget: Add user_agent parameter so
 it can be used optionally
Thread-Index: AQHauFDi6O6v6SwDbEOMcPsPTSX05rG8bKOA
Date: Fri, 7 Jun 2024 15:23:33 +0000
Message-ID: <29B1D1C3-2E2F-467F-85BC-B265097BB933@arm.com>
References: <20240606203103.910-1-egyszeregy@freemail.hu>
 <20240606203103.910-2-egyszeregy@freemail.hu>
In-Reply-To: <20240606203103.910-2-egyszeregy@freemail.hu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AS8PR08MB8804:EE_|AM4PEPF00027A60:EE_|AS2PR08MB10127:EE_
X-MS-Office365-Filtering-Correlation-Id: 6faf71d5-cb56-4084-2946-08dc8705d050
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?MUZSMHNkd280SlQwNVpjWUhBMk1uamZUZXl2RTAreGt4cDJqdFJRaEp5dHh3?=
 =?utf-8?B?OHhpY3laUnlWcUU3UzJiR1VCd1dRdzZ6cTFrWkJoR0l1dmM3eUdyYm9GQVRC?=
 =?utf-8?B?Y2JPWmlySWRwRlhMVEg5UTgwNDdIbDVrN3M1TCtteFY5NjFWMVAwcE5ZbjZv?=
 =?utf-8?B?TjJtMDFLNjRudDlXQmw3d3JUSGVqM2hRTXdBR3JDQXZrWm02TzJIRDJpeWdN?=
 =?utf-8?B?Sjltcmg3OEV1SU0vSThoVlBlUVYxVnNZNTZlZHFVckxQY0txTFFXa01KS1JW?=
 =?utf-8?B?U2VWSmU0TXU4N3BVMXRzV25EUERVQ3NPYXBtbU85QVZ3MHMzMkF4WnB0VHo4?=
 =?utf-8?B?cGdpbGg1Wm1Pem1qU0RqR2xPV01WaVlTYm9oejk1NkJUcGdwUmZqRzNXQ3kz?=
 =?utf-8?B?cUMrV3FaUExoY0x1Yklrd09pTEI0RnIyUWJvbFRUZ3pRZUhpemdsOVN1d2Jr?=
 =?utf-8?B?RktlZFdMQmg2cm42VHdjcmI4WlZiVm1FSklmY3ZLMWgvNEVUWllLcDF1TFVy?=
 =?utf-8?B?ckk0bzV2ZWFuWXNuZ3lYeUtSRGoxZnE3bUpPVDg0TjJEQllEeXE1UXkzRmxj?=
 =?utf-8?B?c1FuNngydjR4ZjNLZzlVVVpRTE9mK2NhUTRzUzFjR0N0SFpjY3BnUFA5SW95?=
 =?utf-8?B?bGRDOVFFYTFVZHUzZ1RmbU5OdVB4VzRtbDNYQzlVS29mWXBHcjlyK0Q3NUJ5?=
 =?utf-8?B?VmtralVZM2MwOVBLWGNYbnV3ZE9SdjQrdFh0SXNNelhORGV2U1RzaDluYkFF?=
 =?utf-8?B?cUptcHNxVTZTNW9KTjlwSE9WcEx5eEgvZVk3UTJDRVF0T2M1OEMvR2xCSU0v?=
 =?utf-8?B?ZWRzeDBldmZnOGF4bzZ4aUVvUDZtZG5ES3drdjc0dSttZjBIYmFuc3BBejU0?=
 =?utf-8?B?aVVib21Na3pSMG5mWXZRQm5PQTVjd29jZ0ZKYmJsMGRGZmJocEx6RGJpUG54?=
 =?utf-8?B?dlEyME9pYkNFY3QzZ1BVc0dHdCtHN0MxWWNQY09MQ25UaEczR0l6M2UxR0Vh?=
 =?utf-8?B?MFBRYjBDVEViSy9taFhxYWJaZ043b1cxSW8vQXkrQ01CaVY2ZUxTT0EwY3Nx?=
 =?utf-8?B?V0V2MExoNUYwYkk0eXpPd1lZZ2wxN1Y0ZGlVWGc4TEk1ZlcxZ3pqYmJPQTF6?=
 =?utf-8?B?enR4UTM0UStITlg0NVpPUHRoTWx1TGRwczNscHpRdFlYMTYrS2ppdEVZaXRH?=
 =?utf-8?B?YUhwT1VheG96a1FYV09XcWVkNmhlOUV1enFVK2EybVFWMGtiekQ5YlFPZnkr?=
 =?utf-8?B?SWQzM0tleWNXNGhwcW1QN2dZenVLd3ZWcTlBNHI3UG0zd2RjYUltUURXMkRC?=
 =?utf-8?B?TUtXNERoaUkvdSt5dHVIMi92MmtWbkxhc2I3WDF5dnhDQ2o4ZVVGYitmTUVX?=
 =?utf-8?B?TU1CZlVjVGZzTkM0QzRyWkY1WENUNjMvOWE0RjAwTGJIamtqMDVsdmxlMXFT?=
 =?utf-8?B?R3ZFdXh4T0J0ejlEMXB1NFY3dm95amJKS0hrL3NRSUVac1Rtc2xoVENFTFZJ?=
 =?utf-8?B?STFpZEFRaklOMzlGTmM4eld3SHpWRmhFeVlOQU5ZanM2UHdyTkJRUzQyZ0pG?=
 =?utf-8?B?YXQ1ZjhYZDNsSHVWdkdMcGJ5bCtSYXc4ckpDT2pPNmdscHZDTmJaQkkzbi9S?=
 =?utf-8?B?SjA3NDNlM3h0cVVIVDlST2NaVGppNitaQ3NoSkRvSnFEQWw4UWRwK21TUjBB?=
 =?utf-8?B?Z01EWVJmNmVPNWlaaGZ5eHRaOHJiUVJXY29pUENTOUVxUlNyTkFOZXIvZTgz?=
 =?utf-8?B?ZXE1M0V6YjJZQ0RmSm5SN2J1SzhxQVQ2T3ZjYy8ybFpKL3ROeDA4S3RXQ0dS?=
 =?utf-8?Q?104AZVg+GFfSpw6RIq1NmR0TIuSALEBDlX5KE=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8DCDEEA4C217748B90D26D86F376947@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8804
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	560ef48b-2c0f-41ec-22f6-08dc8705cb77
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|35042699013|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dkVOMHYrbEtzSXNYY0NHZDdqaDRNQWd2VjdyZzkrdW93SUdSYzBkaVVDbHBX?=
 =?utf-8?B?Wk9uU1R4RFoyODF5NWlnL3NwaHNUSzRHU2hhVW53MnAxUXdpRDVOSG0vVWFN?=
 =?utf-8?B?ZFJyeEg2YTJ0dDFmaHBqcGZxa0haWWQxRm1hbURqVnFNLy80UUJ3aTBwQU1V?=
 =?utf-8?B?c3YzOGF1SjU4SitRdkhPZU1rZUt6aXV2T1Y4dEVweS9tM1lJdEpSNkZOYmdH?=
 =?utf-8?B?UEtoTmVLQzZ1Wk16V0hGM0I2WDFVTlc4QmQ0c3R5REtWaytRREx6Q0Q2RGtS?=
 =?utf-8?B?WTZzL3BmZmVxNzlxUC9FYmRJOXpCa1Zjck1NYTJxWGtKZGpSekNwRlZ6VWoy?=
 =?utf-8?B?clIzYVpROTF6MjVxODlsUWIyL3JwdXVjbGpnY2pBNml0SGFKRnlaMFdvUlph?=
 =?utf-8?B?ZEdhdUE2Y3I2ZzhVT0V1ZGsrQXU5SDhkRUJXWklML3VDK0FlVUNlWldmMnY3?=
 =?utf-8?B?QmE5cy8yQVJMT1N5SkpkNUp1SGJ0eHhnYzNGNDZsdFRQcFpvbmt4U1VjbHpD?=
 =?utf-8?B?blJHZk91WDJyOW9aaGJ2M05qS3FnNTZQdDB2VzBOaEgvMVlhQnNLazVyVVY4?=
 =?utf-8?B?MTJxN2xpbER0NGdpTG4xNGsyK1ZhK2Y0OFhlWlRENmloZmNDc1YxOTVuUU00?=
 =?utf-8?B?R2tCN01sQ3p4WXJXbm1uVWhUTCt3Y3NnZ1FYNzdtSDFVWlpUY1h6R1pNaDdv?=
 =?utf-8?B?KzgrZnpzOG81L0g0bTd0aVZ5QStKSTFmbnZWU3k0R0JmY0VLajBOVTFrb1B5?=
 =?utf-8?B?MStlaEhtSitva1pmY09oYTc5Q3RpYjQ3cmlaTEthSWpsVlI4ZS9ZdktJWUVa?=
 =?utf-8?B?OUsySmgwMm02S2xMUS8wRHYxcThib2plWUxyTVdXY2VzWUVJcGxiWE9rZTE0?=
 =?utf-8?B?NVB1WFhYMXp4ZlYyKzdxRmQ2QTc2ajBlZ2U1RGlJdERhYVhLeEVuaUdVWW1J?=
 =?utf-8?B?VlVTMUpsTzFqVmpmU2E0TVdLSkFnQjBadXhPL0orYlpyVU5TTkVuNHdqQXNK?=
 =?utf-8?B?cDBoR3NKaGNiM3J3cFdLRnZtTXpSUy84SFJqaGZvWmV1dkRMU2liZEhsQUlU?=
 =?utf-8?B?Sk5ZSUdJWURqTktXelMzVFFBMERINFYxV0JpMytPZzRTZ1hVUjlSZ3pCbDkz?=
 =?utf-8?B?c3lRZXR3cHVTaUZ0NW1YUG95ZXlBU0xUWGxCNGtSaXdXSURDbGg0cklscHkv?=
 =?utf-8?B?WnM5SkN2bXlFckZMVkQ3NmNsc2l6VjgrVjZiUC9MNzVKckhTOW9jS1UvNGox?=
 =?utf-8?B?TzhkSFI5S240V0loQjhGZXhQejVpUlhXVmFFRi9FOTUzbTZ4ajkxcTVHY09j?=
 =?utf-8?B?QjlhaUtZM1B3QUFma3U1akI0R2h2N0xhZnEzdW1zSXYrSDQ0VmtuamQ3WVJo?=
 =?utf-8?B?dU1SV0o0VFkxMktnMHdGaVhkYkh0eEFaSlU5NVNuWWczSEpiT0R1TjV3VC9i?=
 =?utf-8?B?QnNvcC9pQzU0NFJlalZ4VFpOOVBCUG1wK1MrQmJvcnpER0RZcGNneG1qd3k2?=
 =?utf-8?B?ZE5hSUxNMCt0Mkprc3BtVFlUNTc0NUtzbERVem9SbEhSbnNtN0s1d2kxZHRp?=
 =?utf-8?B?OTc5ZnA5amd6amhUbzVaOWF3cjRzNDdqcXE5SmVaSXFkbzNaMXdpT1FHamhW?=
 =?utf-8?B?SXU2Uk1ZOTRmdGRCOG4zTkVnZ0ovZi85ay95Mmh3QXQ1L0luY1lmRCtOV2VK?=
 =?utf-8?B?NFA5Qk8rUlN1THF2M2Y2QUE2azBSelRDNjlpd0NxdmZoQ3RXa05FYU1lQUlY?=
 =?utf-8?B?MUs1dzFob3hGSzhicmlvYUZlNTNsK1J2TGZxcjFWY2dCanNqVXpwZnhaMndk?=
 =?utf-8?B?bnE5R0kzZkpvc0VZMWt4NGF0dEVKaGlhbDhLM2FVOGp0UWxKTGZ5STVvQUQy?=
 =?utf-8?B?ekM5L1pDTzVUeEYvK1BHSEdzWjZ4L25XZFRwR3NEenBIMWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(35042699013)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:23:41.8799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faf71d5-cb56-4084-2946-08dc8705d050
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10127
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Jun 2024 15:23:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16329

T24gNiBKdW4gMjAyNCwgYXQgMjE6MzEsIExpdml1cyB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9y
ZyA8ZWd5c3plcmVneT1mcmVlbWFpbC5odUBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiB3cm90ZToN
Cj4gDQo+IEZyb206IEJlbmphbWluIFN6xZFrZSA8ZWd5c3plcmVneUBmcmVlbWFpbC5odT4NCj4g
DQo+IEFkZCB0aGUgInVzZXJfYWdlbnQiIG9wdGlvbmFsIHBhcmFtZXRlciBmb3Igd2dldCBmZXRj
aGVyIHRvIGFibGUNCj4gdG8gdXNlIGl0IGlmIEhUVFAgc2VydmVycyBibG9jayByZXF1ZXN0cyB3
aXRoIHRoZSBkZWZhdWx0IHdnZXQNCj4gdXNlciBhZ2VudC4NCg0KV2hhdCBzZXJ2ZXJzLCB3aHkg
YXJlIHRoZXkgYmxvY2tpbmcsIGFuZCB3aGF0IHVzZXItYWdlbnQgY2FuIGZvb2wgdGhlbT8gIEFz
IHlvdeKAmXZlIHNlZW4gdGhlcmUgaXMgYWxyZWFkeSBjb2RlIHRvIGNoYW5nZSB0aGUgdXNlci1h
Z2VudCBmb3Igc29tZSBjb2RlcGF0aHMgYnV0IG5vdCBhbGwgb2YgdGhlbTogd2Ugc2hvdWxkIHBy
b2JhYmx5IGVuc3VyZSB0aGUgc2FtZSBsb2dpYyBpcyB1c2VkIGV2ZXJ5d2hlcmUuDQoNCldoYXQg
aGFwcGVucyBpZiB3ZeKAmXJlIG1vc3RseSB0cnV0aGZ1bCBhbmQgaGF2ZSBhIHVzZXJhZ2VudCBv
ZiDigJxCaXRiYWtl4oCdIGluc3RlYWQgb2Ygd2dldCAod2hpY2ggY291bGQgYmUgdGhyb3R0bGVk
KSBvciBmYWtpbmcgYSBicm93c2VyPw0KDQpSb3NzDQoNCg==

