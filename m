Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B79CC4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 04:16:44 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.75])
 by mx.groups.io with SMTP id smtpd.web10.15691.1701404197288530639
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Nov 2023 20:16:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cgS7rbjX;
 spf=pass (domain: siemens.com, ip: 40.107.7.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIjT8UIeueZuSAcqJ8wJ1BV4BObTo31+svEit+uoXzZIjaK9T7qbXAzfaJoD+UqmR5E9nMO7Cc8y0wp78MaWDMHRf+CdLQhN5XPjCKwzhj0Z0XrierP6Q5fNhglr5J9sTxrqdjDKpS/kAKhr6exxK5yQuZ+HvNOgyoiYSsPv1pn1NTILYmDSU3V/nNu0TKNOfna3rjXfi4iL/qbUwaikBDbXO8QwqY4Kz0Xlzj00oEa6z13DbfH9Eb8fWrwN67vPVJBkmI6PAhdPZTCSBo1897jlwN1KVb1diSthfgb4jNU3mZePlYhYTc+y3KFs4yQ5pQXVZ7W0BGihEdGedcwtoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv6FQ0zuSMQAlnKpD1AtQ4A1gcr2uoOhomsKBJ6ixE0=;
 b=LhJ0LxznxmVBlaPnSvphudDIf/wBi8THrokg37v+dol7IcU783LfgkPM+u5c522VtX30Kef5E2glA7XLjFD1z9Z/rYOVPs62Eu2O+ZVceffND8nQvGh4B6ODpWwbBj5EjY9oLutOnZR9jeH+4nJPFvP42XSgTQ6+6rF+RABlO/WxkbQcKkJKDIJh5w71cilB7bEXnauHYVMLShhi7c39Ke4TIJh0U/2QhtpuY/iNbZP0I1Wn7UjVVDmeUEHL1yqSub33XAOzKWH+yzXJ8jCsGNtRgbMcXHq1eDdoa63/ol56d1dG1T99Y+Kmh6PqQnVmsPc+8yyvxCQCk+ELL54gjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv6FQ0zuSMQAlnKpD1AtQ4A1gcr2uoOhomsKBJ6ixE0=;
 b=cgS7rbjXcJwDDD5OOhdja0X46jFy1G3IPWnXMMfEN1oqj48muVFNwqNGYKM3xM9wFCmPoffrwuwW9SLcQ0VAlidIhSZPxWVfpWpOD9tYAC9CyUvkLInnM1gw2ywar7TKsSPVIczGqJ39sdfC7UQO21QKqEFD76oj59fZ2xgKwRMgDQAuceuHhUdKzDl+UfGJfHNVT04sizuzDPuXQpaViKz1ak52trLa/ZsNRdOK1kMHrYtv3XWJJm7+t9O+79Repp6nEI/AyuHV4/FhJwFVPpTbJv2AIfOKNxp8AmCaXEzoP65skN6ijeeyz+djHMN6IekN1bvBfVU8JSuMcAdTYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 04:16:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 04:16:33 +0000
Message-ID: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
Date: Fri, 1 Dec 2023 12:16:21 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org, enrico.scholz@sigma-chemnitz.de,
 Richard Purdie <richard.purdie@linuxfoundation.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: AUTOREV, PREMIRRORS and unavailable upstream
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: e34aa347-514e-44f6-d8d3-08dbf2244d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Id4zjIwwyxLy6E7SLTG7bQgXEqEun83LVUyFTAoMm+sU1Sv4H4TFFqL2+hT8gChRQfpiggh+6aMjA4eX5T6Bt4R9asi28pPYJIxrB2hDcsbEbtzGY3o36jSHRw9fNaK9f4b2NHXa01tOKiwaa+D8PD6DnFL5IUVVOJmzpVM5aoFkKcmUHOBG7Q6QuSTm+JWCyeMRsog7xXvpqrE1vpbjG5p7je4mKUxwgXXrRgxJeTAdBPhqttmE6/Yni7wWlqI/7MfAon89F4ZfWHkQ4E50OhaODV/D+kEmOEpvtWC61+1br/7rGihiXpUBZ9MaqzHO3axze4jjsQFTXgm8JrThlBTP8wRLKnB8Iw8OZLASpIucjWtNGivFM4UlOIa/gHetZuGQNRiljJ+UNmlMUeBynzmR852oaIEN0MhTJR4St+GuQnHUPJ4yTqnFk8V/wayUnaqp9Q/VOP/NYSmouGYHQtGsjZDidKm3YpDVWazm742DzJHA7P+p7BrWFmBVEOl1E2JJRYiYj1ui+1iC6lKPWhbZRK5dweZ9AsqXpslAKkJ9C7PuYjMu7ndmoJZMbvBvR0/84169JrUuUFzpCLnxdFRCXH9Vz7KI+vEUvkUXIdMwBTbxzf94Cv1ky5p4kjCgKyi/2EO0pTEEsgOiLPHagg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(966005)(6486002)(8936002)(5660300002)(8676002)(31696002)(6506007)(478600001)(6666004)(38100700002)(86362001)(2616005)(26005)(6916009)(66946007)(44832011)(66556008)(66476007)(316002)(6512007)(82960400001)(2906002)(4744005)(41300700001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzI3Q3MvNzBwL1llRWJrQnpOQ3hkYUJaOEJJVUpINTl2RkFld1loa3E4NDBM?=
 =?utf-8?B?NXRmQ0FXa2FDVS9hMitDR25QK0tZSW1MSUFXNmZhVVI0OElYY0E5NVQ1aHVs?=
 =?utf-8?B?Q1g2eFUwYWZ6a2V5eFFlR3VKaUpleG5WakxiUytEMm5uQ3h4b0NiM0IzVDgr?=
 =?utf-8?B?by93VXRXTVRRMUV6S0l6a3lrRDIya21CNkNqQmhmRTl2UzF5S0lzcHJpU1lG?=
 =?utf-8?B?VGRQWmkrRG1GWVlqclhFL0xCWTRSeFRWeGhYY3AycnhVV3dIdGxJU01ad1kx?=
 =?utf-8?B?aVhUcnp3dzdFcmo5QVNxV2YyQlYvMDJhNG1Hak5tRGNUaGtZdDRaSCt6a0Uy?=
 =?utf-8?B?V01mZE5ldTNGcHBzcFdhbTA3R3k1ekkzeDRXM29Pa1d2VDc1eC9BcjZNYysw?=
 =?utf-8?B?Z3Y3OWoxY1djdjdON1JpV1orWExIQU9GWm4vbUFMRi9LbkZVT3VYdks5SEFp?=
 =?utf-8?B?ZmFSSkVBWXhVSjRHTW42MG5yRGc3NG0rdTBQTHE4T1ZMbkJKWjdIWjZpYUtF?=
 =?utf-8?B?aVpQTzUxeit5TytnT2tiNHZhR24zTDBQMytxb0IzREZ0eVNrQ3N0YUhYN0R3?=
 =?utf-8?B?dFpFamJKWmVzMlVPVlk0Q2wxZWQ1d0tzdWN6OWt6VkYzMEVVL0ZaNXRaV0ZY?=
 =?utf-8?B?NmRjMkU2c2ZSa2NrWUdPMVZ3WkllRkcvRTlHbzZtSHdLUURsek10cVI4Uk52?=
 =?utf-8?B?R1Y1aVZkM3B5Q0lEK1RSWmtoK25PK3gya20wOVU2Y1g0NE5zdU13RWVSRk9k?=
 =?utf-8?B?ZjJPK3hmcmJ4MXRVL24xc1ZRVnE2bER1ZUM1VDJPSHBsSTRsT25VUHpXVjVt?=
 =?utf-8?B?Q0VraTVjeFFPMG5Ta2dXaFcwQ2FveklRWUF5Q0hyQ3d0RE0yWVdQV3pYS3Uv?=
 =?utf-8?B?dlVESFBJaFcrb0RpVDE2WDZwVHAvRUxHeU5IOVBlRkthUUZpQTdMbWoreUo2?=
 =?utf-8?B?REFiYXF0MTVHR2VNQTYya2VXUUhaQTFTV0xmdG9iWDhFY0N1ckx1L05NeCtu?=
 =?utf-8?B?Zk5OWVpoZmRITzVINHc2YWFtWFBudUVQaUJMeXdyR0xSRGoydi9VaXFkaWtL?=
 =?utf-8?B?ZGR1Ym1zbElVL3I2WHdzWUQ1bVhDYnpyVXlKalg0R25PYnppMk1mQlM0bFJV?=
 =?utf-8?B?UHlRRGI2dm1NNGlBSjVUWWlyOGY3U3pEMHZyWXp5eWxEVDRlaHBOYmFleXkr?=
 =?utf-8?B?NU9lMkJIVy9QaVJsL3pGY2Z4Q2xOTCtLWjdnSE9xSTRvRDYzb3VNKzRvalFz?=
 =?utf-8?B?Tm9xV0t1Z1gxNDZiMG1uOGMvdERrV0NkcjdMUVdENkFxbThZR3VOSnhJNHRV?=
 =?utf-8?B?Q3NXaXY3ZE5iTjJ1RUFySkVIWXVxYUVZZlhhcEF3L29PaTd2U3l5aFUrUTlU?=
 =?utf-8?B?Y0tIemNJY1cyN05uNDdKazRaSHdndjNINC8va0FrVDd4Tkhmd1JKT1BLVHVN?=
 =?utf-8?B?aXJIUUt5TkRZMzFzanRpTXpSNnVkV3BCZjM2MGpKOWo4SHFtTE5NQnFaZ1JF?=
 =?utf-8?B?TlRlRUdVUGRNenZFLzlHc2hlQzNSclk4bWVyazhCNmszYlJheGlBQ0xpcVk1?=
 =?utf-8?B?VFpiMjEzOTRwMHdyYXdGUDJhazlyZ2RhV3RWWkRWbmNReVhKWVNselBrSllo?=
 =?utf-8?B?TTFlYk8vSVg5aEdRN2YyU294eDYrRVpDK0w1cFM2d3NiR1o4MUg5Z1NDSmlk?=
 =?utf-8?B?T1MyUW9KdjRtQi9EcktLUDJhN1lVRXA3TzFhTlFVdTJZb29FY3RQNGt3VFk1?=
 =?utf-8?B?SURKS2JtYUpzQW9PVVRQRkE5U0dSNFRZT01XZjdDWHhQeUlRS3pIL0NnUjhS?=
 =?utf-8?B?ektCMWxoMGxvS0tMRFlGVHVXWFEyQldlNi9jYThMbUoyaDhRZGFCSFhhZ3NY?=
 =?utf-8?B?U1Z5WGRQTmJwSk9sUTZnN2VCMjBGWE5tZjVVSXJMWFlXRm9wT3gwbnpZbk81?=
 =?utf-8?B?a1J2OGdRVHU0Tk95U1FuZVBXMWJEOVdoS3hhcEY5enhnSkRLZlhUL1lCU3Uy?=
 =?utf-8?B?UmFlaTdYOE9HYWJ5YzJrM1hoYmducUhQcXlGL0NzZDh5QWNPK3hNdDdmSmNr?=
 =?utf-8?B?SGlzTExYOXU0U3VqalRlVTZXdjdmNDBqdFBMOUFvc1NnMCtGWHFpanl1c242?=
 =?utf-8?Q?ootD3yt74GDgFNZcD9xkZBYW1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34aa347-514e-44f6-d8d3-08dbf2244d57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 04:16:33.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgzQ74qctmNdtEfOrjfNGIzDn8lLyzUck9SKuM4nmHnzdNK/PXcBsthV21LiCkvTySuMKOW8AQGmQkl8dDZyZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6818
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 04:16:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15594

Hi all,

this topic has been discussed already long time ago [1], but I don't
find a conclusion that helps when the original server is unavailable
(like github.com for me right now while staying in China). What is the
right answer to this?

Jan

[1] https://lists.openembedded.org/g/bitbake-devel/topic/72112230

-- 
Siemens AG, Technology
Linux Expert Center

