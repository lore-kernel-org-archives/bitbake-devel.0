Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B8C52D6F
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 11:20:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.67])
 by mx.groups.io with SMTP id smtpd.web10.5018.1722943246208449177
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 04:20:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=XnpRPxyE;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=XnpRPxyE;
 spf=pass (domain: arm.com, ip: 40.107.22.67, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MplBmYqp88qo9PZCkI3PFDnhcZ51/KkkzXXzkFbAkCiMesd2OP+C7bzRGbsfsc2IoGkQldQsCMNF6dS+Xz5TL7RiwCyPQ0A7PrSiEhsrmOIsr3kfkB6h2dkKmS9tP24vjhOujWcOzMDjcngfQdDc8NeKIsSUgqdQVPqFc9lX06snIleNjWwIVxNfQ5t06rkjuD9OkvxSjdJi9U0BU28NaQhQzCPJqCHqXfgH7wtQZKDc3jOdBYJtR8j+owxTLAV3gTawvSG/CXjVX1P2TvWUAHvAUM+5x45NjkLbcKpkBJi40syI4rsxltlTFzI+4I2jEfTCw1UM3nmK+3XWznhJWw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGWk07QLEqkRQN7nB11fUYI6p5EYHUY1RDyI3ZlaxwA=;
 b=mcZ+74jU5BE+0esEiuZCG6L14jl7EPrTUz6Yl0OzfGz6EiDEoR+2XnRTjY0UiB5yvULT/YQWUarrPQgY4bXfOtAIZCpicPuTDJCIKf13wtdnhe57X4yKQmjiaAWm9gUw510OLnZTr3yeBp/56GZxZGLYfULxnxhQ9v0nQhI+gonUojMaVs40kKBQUJMz48Pv7lUvvwwkFkkudWpEU4vzVlRM7+8BoXbPGydW19+v6bsoaeNkivj3+u4hNt/b0iZYo+2bDJmnsKw2nS67nVvrZWhHVj0UZtYlV6L3SOSqotEQWJK9ZCKAh7RlKVUuXOsYlvl0xYrvIhA7DLn7ILW6GQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGWk07QLEqkRQN7nB11fUYI6p5EYHUY1RDyI3ZlaxwA=;
 b=XnpRPxyEJtorHZg1yle4FMu65z42WRMKrulfDkU/eGSvZUpKcktyBjQaJx4guNYa5abSAAzSjShTcPnKomgaylCiiAL4S98LLCuO+G9X+a8ygxVm4ILt6Y3DRigad7e5ShlnAcjyBhGZbm5CnKfT4yeL4pOzKyjeXE3ziUKgcrE=
Received: from DB9PR02CA0013.eurprd02.prod.outlook.com (2603:10a6:10:1d9::18)
 by AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Tue, 6 Aug
 2024 11:20:42 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::25) by DB9PR02CA0013.outlook.office365.com
 (2603:10a6:10:1d9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Tue, 6 Aug 2024 11:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7849.8
 via Frontend Transport; Tue, 6 Aug 2024 11:20:41 +0000
Received: ("Tessian outbound f62a19c28806:v365"); Tue, 06 Aug 2024 11:20:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 91c91954649558a2
X-CR-MTA-TID: 64aa7808
Received: from L886389b1107a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D8239DFE-A2C7-45A8-BE3D-20CA9B2F6131.1;
	Tue, 06 Aug 2024 11:20:35 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L886389b1107a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 06 Aug 2024 11:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMyFMNiR+of14USJ/boe8fqsHYzXwlvWAZw6AuWD2IKHbDTtflkL/JDBaXGb2dkyJKU+pKlK5O8Y9b/2uBMtr17E4yDwLyJ0zqaeN7ecjEvp/aTHkCbQ0AXcT+xOUfL+4NV8Uo7m6vDT05874ShDIbWCX8mmCS6gb4ZtnNGkOpTj4KBRs37WaFvCQH1obmiYNB+hWL6zKZf2ycP2bwfThgUGe1IVMfXVmdLUaLq5NFBpBtIucas1CDPrf70BE5DQiIDFVbVZJ5KfQM/kLNtvPbax+UGGAAdZrIvQVXUa48JrsWJ9lvYHpaek81GB5P+akUsNag9cSTfbi2BNCTrg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGWk07QLEqkRQN7nB11fUYI6p5EYHUY1RDyI3ZlaxwA=;
 b=RzvowbXh2G4vVeM35BpZ/q7Dv7ft7obze/cTj6gWrMdBpNfN1l1Kc2Dp07zcDaBlftCtMiU5oB0DIc/pBmJd55U2PmZMcpFfU4nAFY6VO1yI7wssLX61sjnCJrSOodpZLTy6XsN8ciHMKzG292xx9tKFlc8PYT2sUpz6R91V64C7TNFz6tLD01JWqaJQnLhrM2rDpvZkO8wbxBKwC8pB9FUKIVUV3MUSsG4PS6y9DcxJi896pX6+IYDsHiBG6cygv9cmlhPfYmeHZRkggamFfLTYRs6aAd7GqK0NG4ljzXYfGHiJnFxUz+L+3Ur7msdAxcyAfJYYCi9r69Q7IO0vhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGWk07QLEqkRQN7nB11fUYI6p5EYHUY1RDyI3ZlaxwA=;
 b=XnpRPxyEJtorHZg1yle4FMu65z42WRMKrulfDkU/eGSvZUpKcktyBjQaJx4guNYa5abSAAzSjShTcPnKomgaylCiiAL4S98LLCuO+G9X+a8ygxVm4ILt6Y3DRigad7e5ShlnAcjyBhGZbm5CnKfT4yeL4pOzKyjeXE3ziUKgcrE=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by GVXPR08MB10575.eurprd08.prod.outlook.com (2603:10a6:150:15a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Tue, 6 Aug
 2024 11:20:33 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 11:20:33 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Robert Yang <liezhi.yang@windriver.com>
CC: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
Thread-Topic: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
Thread-Index: AQHaxGPi7yw7DkBwFkObrue4fcmiBbIaWIKAgAAD9wA=
Date: Tue, 6 Aug 2024 11:20:32 +0000
Message-ID: <CE5E709F-BDFC-4144-91B2-089DDE2D45D7@arm.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
 <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
In-Reply-To: 
 <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|GVXPR08MB10575:EE_|DU6PEPF0000B61E:EE_|AM9PR08MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aaa4ba-74a4-4320-d795-08dcb609ceaf
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?tyQP2nco7gLxPmChKOdKDyLzRnlVNgdn6jQ2lnZ0/EdwucoLbLyFa34ao6IQ?=
 =?us-ascii?Q?xQnWm1fh5B/OWa31eNvliqUD5iTsMZ2rejnfaOwonPJ6dxeSSQvcBtgUEvbL?=
 =?us-ascii?Q?7BFNTP84GFuYiLz5VU4r1ZkwglERNYctFkzelk0Q6yw3mFonSnMyKWQOovy1?=
 =?us-ascii?Q?OkE03YsV3d9ryvn0rQmGO3MInUGY78N2t0XJVW9qk4CoS+yc26tk/Z6sP967?=
 =?us-ascii?Q?Q9rqFT0ktnkomgug/LZ7beJsYhH7zfwOtecEO9fIJyFdgymuIZDy7T79wAn/?=
 =?us-ascii?Q?Y8vjkeqrX7JMmF19k0LXrQV0y4OLZT5xXY1NkBu9nJ25ssL2Fh/X/neh4PcR?=
 =?us-ascii?Q?ZrZlW+1qr6GjCXxR706tMaCwNyFsT6i8Hl5f6PpJ/80Ky/jjU5j/YIR/S60r?=
 =?us-ascii?Q?8hA3sPZ7e9NHHNujxIgpqZBS9rpFFzILVzIKE8NKuKqL25zOyzKWwe/V/l5D?=
 =?us-ascii?Q?WyLHWUq7w/wVzMHCcEK7EErQdvCCVOFyOsJkgNMOpLDSEWjIy37K4iG68Aat?=
 =?us-ascii?Q?VEMoXg1pWxtNjRy8Wjt4Fo7itm6puPA+pVrgkhkyE9KEZKAsxsdoaT0h9bcc?=
 =?us-ascii?Q?36hTKY2ztbz1+fXT/KIe3fQpl4ugFLA8uumAIx174vlD+e2h09UjLMVdx48I?=
 =?us-ascii?Q?yLQceM+UeqZs6PGGH/FFb6qgurVF+UejSghhpNaguSsQejX0Yl92vJhKrxYO?=
 =?us-ascii?Q?Co5p97c3Ua2hT8zsbErwS4Ug57SkjHfBgBIjV2Kk0NmcwNay33wDD+x4LGK2?=
 =?us-ascii?Q?WVTWSvcF27/vfTZ/zOL9bQIgVlG0s4WJGPAr23H48LQ8banBXfA355D8d4bK?=
 =?us-ascii?Q?ieAQOggme97J1O5OKD4MGCLRwUE+P3t4Cr6bUM0DeDjtmcSVZJgfEEzPlxux?=
 =?us-ascii?Q?6+4SlC9sINnbLS7GMIG1FssieGKo/Uvruf9tuSyKyaKzxV5gCllGcKCLh4eH?=
 =?us-ascii?Q?7aQQJGuED7t9xAJ+T3tk2YUmUtMs4RDmzzKvnkNNpcIpvUSyvXGQNHjSS7dM?=
 =?us-ascii?Q?X8c6RO+LjvW2V0FHTJfaBr3OG0iLYTey+J0m/ENqrhyWbijaboYZ2pEboj6B?=
 =?us-ascii?Q?iFj0MBvMvswVU/5fsEHwmFY+SWcvS3ZOp7Bu8sausSEaZFZ9/EtO5BML5RW3?=
 =?us-ascii?Q?6RJxMCLkRaISQJ6Y2nzT7zfaqX78ZKvm1FUPCNTu5SdzLSbsAGrQ7K1WlIuK?=
 =?us-ascii?Q?gEvO4Mwrdihe6i2VgyNPUOYugvb9MLF24cUXh3fI4/OzimbejTJi18iUu1Vz?=
 =?us-ascii?Q?+5Q/qHvGVt8WY5YjlH8jMAOuXz7TthiLXD9hUj3p/Bh7u8ItYW2iKpp4KBy8?=
 =?us-ascii?Q?RNwyCXROgDB1t7p6A7VZfl8Kq15sK/elF2om+BTk9PIveeBSqN+LdJUpgLS1?=
 =?us-ascii?Q?hxy1JjZxayPwsYi1/lBYtXZutLI5t+XtPwO3ZMN4OYvuZEf02w=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6022553CE60EA94BAE34F22C78DC9F67@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10575
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	9b81eada-bf4c-4261-31ab-08dcb609c96d
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?O/JOUO8Qmx7M+tXAuwu30DIoOeQRHVvwLUWH4iMB3Cu9xJtqCUD624q//d0Y?=
 =?us-ascii?Q?opRcq0zQpPoMCZmC3whlfXUaqOm3J0kdy8wBAZxydcCJHdNFYX5Xb147A1ja?=
 =?us-ascii?Q?xZBELroju9SbpjDiiPi5Ut1qG0uFt+R0FEWv8S6dW/UKrVa5Z6ZdWFJLoGV3?=
 =?us-ascii?Q?DI8YA99RLpF6zUf5gWsdsfd+XuFYdZmu4KgRsWbI8v216eF2tuJOSiSFZDAO?=
 =?us-ascii?Q?AtxLTLfE348W8nJCp/rfHoVLDXrnixdBh36z3VxPhBrwSkyH63lNclIXokYF?=
 =?us-ascii?Q?YYA8hVyx2nn4VwU9qt0ePKlRVQHrjpb9pZ6eFlUYLrNb2nMlDn88Abphmpf3?=
 =?us-ascii?Q?zGRaaMxhbDIO1ICfc0yzhzgKyhUT9boFg5XV6UHJt2IH/0qtW+aA6Xks0xlX?=
 =?us-ascii?Q?jXaZvowst5+OxwYVP/Totk1ebtzxNah1vXj8pfuaMhuob9ke+vRLpBTAzOwr?=
 =?us-ascii?Q?d5/lPVxEmI7kjX+YvDL5l/rXeKbJ89IdO8+iDOdDl71vIhqMUPVMR8E+JC5a?=
 =?us-ascii?Q?8abuJ6MRhWw2hMJhsdfzSkmxDqP/XQ8SjkyoS/39gdWcf8DA6+IQJdangtb5?=
 =?us-ascii?Q?WWd1xcuFU9ZTeMLmOdzId62/bURBvjHF1o6ZETPgEp4R0LrTxKssG1mut1yk?=
 =?us-ascii?Q?N8wQej81rtqX1XSkRw/Bc6HFG7pWmoKsG+aqxbvRjCwzhQVjUnTA9puxfWWB?=
 =?us-ascii?Q?l3da+I4SqV/CGPREVUqSdvUutCnH/YlIFZGlFjr5gXNCLndTKtLlC9Gy3z1J?=
 =?us-ascii?Q?Rn9OSE3u/fthbMNkF8axzTvisWUelNtJV30Vx0A3XUMGxeLt/m+5Q7M3HNiD?=
 =?us-ascii?Q?KPbCLNjfR2BV13kxup7tsiWDSVxVLMFI3p8OQxNfhJBHK+jK/6VD04cm1Jp7?=
 =?us-ascii?Q?L0NOK5OLdWfC4S3Oca4dQT50I5ld138O5e+lUqqfzM/9ZbTQN/xQJSG1H/aJ?=
 =?us-ascii?Q?m6V//n84sKGlbOqJ5jtz1VTKPjAb8gtOEdrZAOPlSEZ3X6kqXY4S7jsbQpgr?=
 =?us-ascii?Q?i1CLX24Miz25AmVedrI8v1ggPaN+HwMBlQaw9foKCaxkiEQ19Qz+W79AGnm3?=
 =?us-ascii?Q?PnntiyNfoTXujY3V4plaMItSYkTY6YTgDO0uMClX+7qzM9ZSk7vNixzPHNLt?=
 =?us-ascii?Q?dFr5s+n+ml2XAImV/fOaFUHXixjhSca4rNyDqkyfXsDTwqlEcTwjhTavsLnu?=
 =?us-ascii?Q?e8zEEklVkQvyDFCF1Nco+jk4+enN5pYGe68pS0LUKDOsDRsL6G579/uwsI+A?=
 =?us-ascii?Q?vvcThrGKAdRP7cP0Xuiydj4ayUExfqDIBfZFaOKnHNVFYayN8c1mT1aAzmXB?=
 =?us-ascii?Q?CiBw5A8zYBeLTFoBrT/l275Fxy0gtsTvZkV2hAsUiSxb6kxLIYrBTX6dIbZx?=
 =?us-ascii?Q?1eT3s8WKwNaVls8+rD8sUNBZoZ6EWiXOcH357sDopY8W3HDgq5VP2+73vGjZ?=
 =?us-ascii?Q?3DYYmsf714cA8SNxeq9vdMgYgO6uvTaO?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 11:20:41.8202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aaa4ba-74a4-4320-d795-08dcb609ceaf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6258
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 11:20:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16445


> On 6 Aug 2024, at 12:06, Richard Purdie via lists.openembedded.org <richa=
rd.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> I did look at this patch again. I'm still not convinced about the
> original use case but ignoring that, the patch itself isn't too safe.
> If you have two repositories with the same name, this can break since
> basename() on the URI is not a unique value.=20

I just tested this and verified this is the behaviour.  With a recipe that =
fetches a local git repo called xyzzy it currently does a clone to $DL_DIR/=
git2/home.rosbur01.xyzzy but this changes that path to $DL_DIR/git2/xyzzy. =
 My fear is that this is too ambiguous for a DL_DIR path.

Ross=

