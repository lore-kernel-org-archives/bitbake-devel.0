Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F5C35FE7
	for <webhook@archiver.kernel.org>; Sun, 15 Sep 2024 14:07:16 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.43])
 by mx.groups.io with SMTP id smtpd.web11.114945.1726409232298705416
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Sep 2024 07:07:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=gNapZPPl;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=gNapZPPl;
 spf=pass (domain: arm.com, ip: 40.107.20.43, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vSAR3NsFmpoYTlLEdQ8uMBIcRqlFeIvPu355kOIpvCgx9Z9F6Yw1VWdLWQxzV7QLtJUBLByyyJwPyLe3xxKWjZ/PvCs4vTkl3kxqIRaVgdQeKBIeZ6tIVq34fJUnXSAmMXZ2J5iEhXgdOyyo/bgBStPWN+ZdNFphvGvUQLCWopRxtvywMlxGBaFHN0ZGXWIHKDJGQtb6w5atn151AXT7RcIcVeBa7mKGQZl2SZ9cu0Nke7iPceU4iXHjmoopRJDxZXxcPAI4bhWZ1ZoGb9joj6yEuhcpOO8mkR6gb5H7VGYdhfWyJ5Fb+lhl+yddRSt6+fFuqMb456J/tiRRJ3z1Dg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFk0fMd68HtIP3vrlqGQIVPTbRRoeap1UDMmDyntYZE=;
 b=M7iyIe3fEG+bmNKsmqeZXohYrpqVyyDjs7rOFR7X7D6RKj3OGvrlDSQXhp/D0gYdaRQW5Xnd1jtQ+djny87brvMBW3TJT37pFeZ/DetHT2i7V8OEFjA4F8gNk5TuY4IVbdb0vJJwWy9tGXq9KYFMQRqRFze5A13Vlh00JDEIc9YHa3kkYyxMVd342VCg7m8GTOOySAxmDaGiKt0hu9tDdu8WorWK0Zt4MPb6sEfQmgspI7wEz7ZVRy5oXLbUDSWXdyNW6myH8sxwgIzUMWGckH9CaxJRATtt9vsN9Zoq7TG8on3GASsrTiXa6wnEEW6y9VE7HE5tTPOEQv1cTdBTaA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFk0fMd68HtIP3vrlqGQIVPTbRRoeap1UDMmDyntYZE=;
 b=gNapZPPlz1+2t6Sea7QtqLE5ZWz/LJclx7a0tkha9I9UGYeXmHQPKtOvlYnjwBxd8CFhLITTim72D/15k9ec0736Qhu2kRbIxADUEeGn/qPcpBnKfQV7IWPd5Cc1DIWwVOdyyGZZVksZWlIonlEXLFimdkxBW8Fdal8Y4krVvgM=
Received: from DUZP191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::18)
 by PAWPR08MB9662.eurprd08.prod.outlook.com (2603:10a6:102:2e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Sun, 15 Sep
 2024 14:07:04 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::28) by DUZP191CA0040.outlook.office365.com
 (2603:10a6:10:4f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Sun, 15 Sep 2024 14:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Sun, 15 Sep 2024 14:07:03 +0000
Received: ("Tessian outbound ee7a81b3b7b9:v441"); Sun, 15 Sep 2024 14:07:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 81c3bacc8d664aff
X-CR-MTA-TID: 64aa7808
Received: from Lbb1c5883f557.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 17EED827-4A84-41F3-A648-C0052F33B592.1;
	Sun, 15 Sep 2024 14:06:57 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lbb1c5883f557.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sun, 15 Sep 2024 14:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaQBruaHQodKE21FwtVraIyf+usCp6meeNqYw66KHR5gyNv/NVLQ0LOpmbQYAchLePsMpE1Lmk3BAwMzHJwxvZGJrxz0UNeBKl8zyb1j4ouI4mmPXI7ot5KcBRFxUAQ5n2g7ZxKJFkd6zgpbfkjy4E2r4Vd5SutYoRcWrJ113pKuq/yTwFpR5TkeNfHE6/ep+txsTiUGuQhm0Ud5W0tBKJ2JkPJNqlbhOvno9yhMOfIqF1UKfKn7fMQvRYwXDl3/mAVeJN+aD5EBtM5gLXN6wRHpc34/wqJqTrJJCPtbQyVw8patbKObPKGkzmrRIqidMudGsm0/ra0SCTK8o7ou/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFk0fMd68HtIP3vrlqGQIVPTbRRoeap1UDMmDyntYZE=;
 b=oYUuUiymCvzzNt+dy1T6dn1aT4mSwGol2uZS1ZxaAYChjcniV6yi0IEMDqZdlW32jq0QUFydCADUQsMDeJzCqp+cKheKGyAQscON8ncOlXZFcEqei+yGqClXmNWPHFfbX5xAZiiVWq102nQir+TCEMkJHuFNE2y017YyELWfVo5mVzLiOk0G4Mxkqh/CqZREIvdCc2qGR3k4Z/GuKnoys8BlYhMFy1B5lXbxWe22F0/x7GPRLTNUfA8c5kopZCWnbkslfoLibLpNK9d3nhE/zefFbcwuWPyQj1ZWcZAm2wGXBX/pS74yLYuAxVRU8caPUIS9NbgsfXGokcKr1R9IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFk0fMd68HtIP3vrlqGQIVPTbRRoeap1UDMmDyntYZE=;
 b=gNapZPPlz1+2t6Sea7QtqLE5ZWz/LJclx7a0tkha9I9UGYeXmHQPKtOvlYnjwBxd8CFhLITTim72D/15k9ec0736Qhu2kRbIxADUEeGn/qPcpBnKfQV7IWPd5Cc1DIWwVOdyyGZZVksZWlIonlEXLFimdkxBW8Fdal8Y4krVvgM=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DB9PR08MB6555.eurprd08.prod.outlook.com (2603:10a6:10:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Sun, 15 Sep
 2024 14:06:54 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%6]) with mapi id 15.20.7982.011; Sun, 15 Sep 2024
 14:06:53 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
CC: Martin Jansa <martin.jansa@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Revert "fetch2/gitsm: use configparser to
 parse .gitmodules"
Thread-Topic: [bitbake-devel] [PATCH] Revert "fetch2/gitsm: use configparser
 to parse .gitmodules"
Thread-Index: AQHbBuK12aewUGqKdEa597pmpDJSR7JY4zaA
Date: Sun, 15 Sep 2024 14:06:53 +0000
Message-ID: <A2FC62CF-DB20-4110-B4ED-ED77C0ED8400@arm.com>
References: <20240914201417.22497-1-martin.jansa@gmail.com>
In-Reply-To: <20240914201417.22497-1-martin.jansa@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DB9PR08MB6555:EE_|DU2PEPF00028D02:EE_|PAWPR08MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3c4f7b-6581-4052-cca5-08dcd58fad0c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|4022899009|1800799024|366016|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?yZQGhmxpfxRY5EtT7Ui/ULUhXCxYozW8L2G3WiDoaCxerdCCSVYsyb0DwM2x?=
 =?us-ascii?Q?T8wbJiLf7/mNlu/9qXx+OUH33qXLXRWRvsCCJn8Fv/x9yjbZaGlPN8PFQ1UN?=
 =?us-ascii?Q?oJY2G5s7g3xYYp6bibaOFnZEEpDFQtsnRhHJ0UBukFwyqkafUxEQ8rdbafZw?=
 =?us-ascii?Q?WHOmyJevf7zNvX4k6w83PH1dbcUYQtEdcxox7gN3dKZ6Jjzh7tRc4SLq0ui1?=
 =?us-ascii?Q?qvwE1WKusPlUh7NfoToaA+ciXM/upe5Egdm6jRGoV5FukGRvS0OYmqyNkW3r?=
 =?us-ascii?Q?LuloxKRqlRC53dhqwwBUuQGMg06i3uXqCRqKBW/VCrgBZMgSgJmuOXb5CVt3?=
 =?us-ascii?Q?xupISMfJzCw6JOXghS3e31ttg0Gg903y9FyCePrm7jSLxa6G9A2tHKOEsmBM?=
 =?us-ascii?Q?MFhFOS5ouqyEl7PG1qBzvUOrgDmAv4PCs+uLgq+w93fhC5jgTUOs6OR7cUZJ?=
 =?us-ascii?Q?Ii7sEl0HLUkXMxBFu5oxPkKr/Swjp8IrG/SDboMu/Y5gEa6hEJC0OXACZqeA?=
 =?us-ascii?Q?uekPfIMKqzZFekxFRfAhLwidKQiw+9jAwZLOFqp9K6W2YmvUxesWBLe/wFXj?=
 =?us-ascii?Q?RH2OexAhZ5XKCBWCWp09iX8fF3BtALYjpWxN1eAd9XP6e6wWkvEX1S3SRIbM?=
 =?us-ascii?Q?aO3wRx6gqrYUsDxi7w9vf3VObuBY4T7TYQ2ZgLbyHjQQeObDQIDbhGBq/p5L?=
 =?us-ascii?Q?n8M0GTBZxrI383+qoJ/QRjCAZDRTmqhc4wECngbaNOeMr1N90ioC8odBAq9f?=
 =?us-ascii?Q?x3Y5pAokdNTn5BTFSYAwNUKwwq3Wa4rmAD8f3edU8JOfsEQOgVh5Vm0UQ02l?=
 =?us-ascii?Q?gTEEOKZxLkZlkGCFQmOi3c2AHDK2grawPkfPKNaSfvd5CCI6otJJB6dBYlcl?=
 =?us-ascii?Q?bqtoJQ8ZP8AKPTH9cSmlT6ULprYcRr3XzPvFvgEMX8ArJxjpQ1T/XkMjpOJA?=
 =?us-ascii?Q?XFcLT0CtUBprnS7XAlOrjDtgNoImzj/y5qtz780vYbsYcbNbjWqbyyshhKWD?=
 =?us-ascii?Q?p2svcfXp3lW4CkUTcb8njAHonVTFNSyldfJjRq4yAy50SR8KZWuRkpB1pUbv?=
 =?us-ascii?Q?lj1jfQ4Emw7Fk+SaReYyVe4rgiViHHehTbqtcSziRC2OZ17XK0lZNqYr4Pya?=
 =?us-ascii?Q?QPCmqgu6ySrPQcUKNzEpYe8gCLuREI/dfy7xT9+kg/fVfJZRvdevxdIykG3X?=
 =?us-ascii?Q?9ZiOIPmHkAAUpS961E6qnMDklRmuqrKFzWzX+7N+18Q7e/cP07gZMbjWtPgY?=
 =?us-ascii?Q?1VmeKok4/1KmKJ1FThz3dp0GPKO374ODwHFIaAGyQ9wjR/QM8rjs5oXjzNr4?=
 =?us-ascii?Q?lNxvH7/wz7A5SsYMMenQGppRPGKEXCkLJZL2jKVb35WdVxiyRSisdp8jtG4m?=
 =?us-ascii?Q?eNoKIGY=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10E18B339882184FB9DD8AE6C4BF17C0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6555
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	af2036d9-96c4-43c2-5feb-08dcd58fa706
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|36860700013|376014|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MqIyqGsy0nm7c0ouo8BSEgNjNcabqP5dKctQTdXzA5tZEDDPbVNIP+9JJJBr?=
 =?us-ascii?Q?C6bnAdi0zdolmvvhVYuAWk/ytNS5p2xJs136KCqU0WvP8ItFwUu4cPA0ENwA?=
 =?us-ascii?Q?vT9JGvLD6PSp9Z8W+bWKNnS5M8DVWLf2zOzB4D+0VY6+NpuAtNFS6ap2bT7b?=
 =?us-ascii?Q?AiO0/ALNKMh3dXrd6+HTKbccZTEFQlOsXtN0vdEkg+u5TzMHd2nyaNFW7aj3?=
 =?us-ascii?Q?Qglxj9089lbA6qGSrZe3SuHAGOLduoetPs9epFiPB2kPfKh3JjJ22Ezf+zrM?=
 =?us-ascii?Q?tjydKnye+O02pSx2V9b1TvsQVqXsmabrOjVY2wtCeTKlx5Av5lA+Ec8PQOSr?=
 =?us-ascii?Q?Hd+/ujwZKH/4eGX/AgYssXToDNywOKRGuUnLIN47FNqxtsXzu7ad3y4Ee8I/?=
 =?us-ascii?Q?ke+HiJIB9cS8LkCQLEAiGsgz61+AeJDIeoBJiHoNKFo2ZXnxiCmkN+NwbHSq?=
 =?us-ascii?Q?otjgiAZZOfz2uWDrUmA8N1MdD47NUyMGRr4KD8LWlDCffLBsy1oQfaFhVg1/?=
 =?us-ascii?Q?CbOZCPtI4qMXkLBw01pMRwClsyddYuSj06NzRDzqrNIglekn7j9jptgwFr7l?=
 =?us-ascii?Q?CgNy4r9pXsZaDfPiGOuBPpmPs2V5Emh/tvXd1MiZoU408RD3VFeajkuOQQe7?=
 =?us-ascii?Q?e65XsTNZrtu6dML2frOEj9/PwwV97u18csIccqwxo/ox3xLgtcHXdBQR+nYw?=
 =?us-ascii?Q?Q2jteQVgy7QS1hf89H0SkGm21bhPNNuTL+d2Lp92TvGWrI/kp87h3cMjBBth?=
 =?us-ascii?Q?Gm8BLNfmiW4cs5siizKnJ2hbNlhHjqMuNZtbF95G67WeA/HCh7h/J8eV1eZu?=
 =?us-ascii?Q?JBHZ2x+U2ddB1t2sXZ5TIZFzH/LSx41N06rhSMEpwdysCXu8cY+QLJtayXPO?=
 =?us-ascii?Q?ZYws3gHOCSlFO2csMud2ldokb1oDIvEcd5ku09OAFWQBG1bChT3T7FKxAQlT?=
 =?us-ascii?Q?bSSuP+o0M9FlnsAAtzhg1UA/lNDN1YSu303VnhpDQOm9Ta4MWA0gyb91FVMF?=
 =?us-ascii?Q?+RBkXxfWqlXXFMRmcWW37LFsiqhVXLPj/YpHTQP2TvXY3d97VKPvgxBROaQx?=
 =?us-ascii?Q?y5FQON9dAd7Z3+b+ynQkOnPe9E45MVb7TGX0gHzryUP3b4d947+chsraZ5JB?=
 =?us-ascii?Q?oQcZEmiucSrrJA7ZFTjefl8nVj2gNmzEEWOZi/F6o2a6ns0Qj4QXr7+mTsko?=
 =?us-ascii?Q?UQ+VgK3/V0JN8InxjVoQpT1mu1rqXoseZadHoj7YQYTljAMTC4tZRX4kTUeC?=
 =?us-ascii?Q?qF5KWbP03hVkdue0KM2qftRg8mtHlDtNisHAcfKOfzVn8fjJZ8TkGUnmZfvQ?=
 =?us-ascii?Q?r/sh3RBjJJAVfA5cNvwcgizzrTVpIlpBfer9hEEY9Df/OxlGsXJhEXQgdohl?=
 =?us-ascii?Q?wBMHq/oUb/Knp3WDExM9zcZbib4ICagOBzNrh45/iT2IVFFmPA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700013)(376014)(4022899009);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 14:07:03.9948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c4f7b-6581-4052-cca5-08dcd58fad0c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9662
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 15 Sep 2024 14:07:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16562

Glad we caught this before release...

Acked-by: Ross Burton <ross.burton@arm.com>

Thanks,
Ross

> On 14 Sep 2024, at 22:14, Martin Jansa via lists.openembedded.org <martin=
.jansa=3Dgmail.com@lists.openembedded.org> wrote:
>=20
> This reverts commit a4f42e396e2942fde94b8b4944487c1c45f7a295.
>=20
> Unfortunately configparser is a bit more strict and fails to parse e.g.:
> https://github.com/espressif/esp-idf/blob/e104dd7f27d2e73ab0e9b614dd7b929=
5099069bf/.gitmodules
>=20
> [submodule "components/bt/controller/lib_esp32"]
> path =3D components/bt/controller/lib_esp32
>        url =3D ../../espressif/esp32-bt-lib.git
>=20
> The url is using 8 spaces while path 1 tab causing:
> Exception: configparser.NoOptionError: No option 'url' in section: 'submo=
dule "components/bt/controller/lib_esp32"'
>=20
> It was fixed in:
> https://github.com/espressif/esp-idf/commit/62ca8e2fb478a1cdc0e4700302526=
5cd0d840395#diff-fe7afb5c9c916e521401d3fcfb4277d5071798c3baf83baf11d6071742=
823584
>=20
> but mcuboot is using a bit older esp-idf revision in:
> https://github.com/ATmobica/mcuboot/blame/main/.gitmodules
>=20
> and mcuboot is then used as submodule in:
> https://github.com/project-chip/connectedhomeip/blob/master/.gitmodules
>=20
> so it might take a while for the fix to be propagated everywhere.
>=20
> Not sure how common these issues are, but configparser parses
> "url =3D ../../espressif/esp32-bt-lib.git" as 2nd line of "path"
> value (because it's indented differently) while git submodule
> and old gitsm implementation parses it as separate path and
> url keys.
>=20
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
> lib/bb/fetch2/gitsm.py | 24 +++++++++++-------------
> 1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index f193ae3c9..f7f3af721 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -47,20 +47,18 @@ class GitSM(Git):
>         subrevision =3D {}
>=20
>         def parse_gitmodules(gitmodules):
> -            """
> -            Parse .gitmodules and return a dictionary of submodule paths=
 to dictionaries with path and url members.
> -            """
> -            import configparser
> -            cp =3D configparser.ConfigParser()
> -            cp.read_string(gitmodules)
> -
>             modules =3D {}
> -            for section in [s for s in cp.sections() if s.startswith("su=
bmodule ")]:
> -                module =3D section.split('"')[1]
> -                modules[module] =3D {
> -                    'path': cp.get(section, 'path'),
> -                    'url': cp.get(section, 'url')
> -                }
> +            module =3D ""
> +            for line in gitmodules.splitlines():
> +                if line.startswith('[submodule'):
> +                    module =3D line.split('"')[1]
> +                    modules[module] =3D {}
> +                elif module and line.strip().startswith('path'):
> +                    path =3D line.split('=3D')[1].strip()
> +                    modules[module]['path'] =3D path
> +                elif module and line.strip().startswith('url'):
> +                    url =3D line.split('=3D')[1].strip()
> +                    modules[module]['url'] =3D url
>             return modules
>=20
>         # Collect the defined submodules, and their attributes
> --=20
> 2.46.0
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16561): https://lists.openembedded.org/g/bitbake-deve=
l/message/16561
> Mute This Topic: https://lists.openembedded.org/mt/108454701/6875888
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [ross.b=
urton@arm.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


