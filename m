Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CBCF856C
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 08:13:12 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.92.57.35])
 by mx.groups.io with SMTP id smtpd.web11.6428.1727943184440733598
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 01:13:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=k1zgLytN;
 spf=pass (domain: outlook.com, ip: 40.92.57.35, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq8HCIDW0RneWriTX+DleC8QaRBKq1jpObvFtJWAFSSe7crLSdX0olhDH4OqQIoR3VHlCJFZVmO3jzIcMEopTb2Pk4QDKMdoRSQlIMzAqssyYgz3tptdBsCfH3x4Cyaf0m/ni62e44VSz+tSHNyjeFSm22aJENeKyct2Ah1QV5zIxuaFRwvBWJ1eUIGmt4vWJhypQuzNlnR480OQlp6prSZn+wdlfkpBdUkFjwO+e5dMf3VkckvrWXOiScfXz6Kdmt56CUlfvzTuPrMoBUyPP+Ha3vYGrzmEat1Ri6zYz+H8KGxQYT+AlGkWAyGKCAIfPl+IicTVVN+Mo0AnGjClGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwbh+fNJoGkOaP4rw5iGbmVms4yFMWKt6OPWG7H/5Yo=;
 b=rgtStH524yiGd4bJ3sobhNwvUon7dIEXiTRCv0NjOr9qLmRA64v48P7wz+i0yYVOmetvKmB0j5OLLdIB7Fw927hjECYSROVaiXK3Xfiz3QR5kkabOm2AamlOzEdRC3KbU5T21D1iYQ8daOTjXa/FoRdItjzHoVmbv4JqeHV+y80JxOOBjo0uPUHNzsrCRwwrYbD8w0yenx/IgHzyNlubImSPluVHbSoXOY2n81vkb7jRunyfULzFbnZcKdkghnmlsHRwE6MGhZLj2y9Q+UY6or9TMYC0mdKFcAjbEijXd3Vcwr/Z+30CkaIiLoiHyrxmqnFY64I5CFKVpot7Ov6o8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwbh+fNJoGkOaP4rw5iGbmVms4yFMWKt6OPWG7H/5Yo=;
 b=k1zgLytNlLyPYkTqbE9cgTH8FHX0+FGPWFdsi9+iqBacT2sDi/TPQ3StEeIh6as5OJVaE0oI+FZhLgpGTsER9BKYZJzBCLRUOIY1HrhFPshivroagYbtfvoc60dfcS412LDh9WH7LhTq+zhliohdFSnIRqolb4p1kUKtlulgobSmjIk/cbhfAH+QZdtZ+wZvjBu/3Opossi5YtlIO3iykOpbx/2zSF8GuDfG5gpJ0Cf/0lBlM2ObBjO4NlJwmmld8+2Z2bzU+XjMWryxKCcyLBjRWJ0bybQeqtT3/mE2I7lu3HzyuQEiq89jNMVpESFDWIkf4ESdG1SV1j3hAkGvNA==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by PA4PR07MB7615.eurprd07.prod.outlook.com (2603:10a6:102:cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 3 Oct
 2024 08:12:59 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 08:12:59 +0000
Message-ID: 
 <GV1PR07MB91203F808EF9F8856AA74053A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Thu, 3 Oct 2024 10:12:57 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v4 0/3] bb/data_smart: better old override syntax check
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::8) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <63fd5e75-d2a8-4d47-9f03-04949bef7263@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|PA4PR07MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 208dfe5a-4f3e-445a-0809-08dce3833163
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|6090799003|7092599003|8060799006|5072599009|15080799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 
	oRdm1FQ3b8iXkgm0ZAgnKSdGs00NyeFpNZDcvuPrJburr1sfEl57RqYsCssy0VPOUjqosA4O2gc5Q/agqmm22AD8w7xLi7spHf/PZzWKQo8hIiBnmb3N6n1GhHKa4bFa8FWi0uUghiuBKQkzr8u/Sxl1e8YoY8kLjo6Tu56q+g6ts6KyPZtznT94W5+wH2eJYUaM2E3CR7F8np+GHYtr5EqT2XLcV/1aCJwhWX2zlNJRxi8aTn1k8zGXSN6QCyTU7pTQfLbgWsZ3q0OUpLe1nSDflBZiWZcJe4lqsx+1SkY+foWepsOO5AtIyf8XTm4d9TDiGaubZNX5q7SkiS607yiQacxLlnFdtKy44+j9ay/2fX5MEloPcjjvFoXGxkJrMYHf+TpxOz+jWUjjnoGSBjqCgRs6P1WRj712ttlNaAJZsC9H+TGek3cgj9J8FcDi4e9LaHgt27n9nKq/iKE0Y2ddI83KHm+UurFcysMrgEYM+fH1151TYu5uu3I2KPeYAWGlF1ILvFms1OPgPsro5/3m1MPUjfsmW6segBRmE7HtnYVV19VjPob+labdi8HDO2AxcmkrmZNe8SSePzT2uIBCOsSkmVXqWQbfiwBZ3eNjFlYcOXgnvJNVExD3LsuH0cudD/vjtU61NsWiWtCP0zpThWNZ802H3bsWIROkhak4zqrts+wqvvrrV1KYdoZ9qqNKi9cTAcwS0gu0Xo21PebX71UWQ0hZ5+Kw874YvGBieTxqV6ye9y+71dAZa2lBNxJ/iyJT186h5MPkS+dr8Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHluaXpQbVAxUENuNGR5NFhGelFFL1c0SkVIY0FVYXR6UE5JWjFqVjVIb3Vv?=
 =?utf-8?B?UWw1b0NoKzVrMFlBMzlwQWVxODZVVkFMUzY1ek1GcU1oZzA1dC9mTFp6ZWZm?=
 =?utf-8?B?UGdaKzJ2ZEpWeHV4c3pvZlhHWUdGampoTWQwbDJYNGU3cnNLWUtCMmFwM0E0?=
 =?utf-8?B?MVJKckpVVG5UdVBCZjNQZk92K2tGRngvNVB0MGNKRWc0M1FWaEt1THgrVita?=
 =?utf-8?B?dm92Tkg0Wmk1L25jZ1NvYzl0V3d3em9OOE9GaHpFQzJuMnY4MnNKQkJEaER4?=
 =?utf-8?B?S3lqZ1JybzI4WFpMejFzektSTmtxaWdYamRURGlBWTlQYmttR2pCbVhMc3JM?=
 =?utf-8?B?dWlSNDF2ZzYzdHpoTEYyZEExU2pUR3VFTVdCOUZYb3R5ZkZjK1dtRnJPK0Zr?=
 =?utf-8?B?L29ycDNrTHp1cDhMUEMwQkNuTDc4MjJXNFk0WU5MaHBJejJ1cnVNcHE0S3FV?=
 =?utf-8?B?NDRsWHhmT2VYazdFR1owV0Q4OVdUSVpKUDBEVE4rek5wSkpubjB6ZU96Qmpo?=
 =?utf-8?B?b3FRcG5YK0NERzJaK0RLTFRRS0JQWXoweDlEMXA2WktzdUNXdStyR0lMVXB2?=
 =?utf-8?B?RDFLTE5pMjBBNjZxU2pUVVV3bTljM1I2aGZzaThPSHNZbStobmU0bFI5Lzh5?=
 =?utf-8?B?RWoxYlllYW5hbUhkNkhIbHZGcjFwVXFTSzZXZUE3WGJDVzB3TkliZWwzb3JZ?=
 =?utf-8?B?TiswcFMxaUlOUEFvQTR2ZjJvaGt5bTR1bEdpam81U0xQeVBMK25NcU0reFFx?=
 =?utf-8?B?RFpYZWhBM3loUmRieWFHcVpJTk9jRFEwTkFEWk5jeHVTSElQSnNtYmdQQ1g5?=
 =?utf-8?B?NTNocytwZUM3YjlsK01xNXhCR2VKMmVQdEpIc05BZXhzRmg5NjVqVTNZcTl5?=
 =?utf-8?B?YWl4cE9PaHhCbnp1OUg2NTZrVlIwV1VyUGZNRDNjTDBWcVpEaUt1cTlYYThs?=
 =?utf-8?B?STBYd0dBUUV1Wk1rbVNCanhEcVpMWmk1THFSUitZVFdmYTFWM0NESHV2YXhu?=
 =?utf-8?B?VHhTNU1aM2U4eEdYd1pZRURjMHY5OGRQeUQ3MzZMVFRhODBCNTQ4YThPYUVE?=
 =?utf-8?B?VG1VOWRRMEEvUVR1VDBCUHJkcExVazhOaHRqL0hWck91KzFBKzUyVFNSSWJa?=
 =?utf-8?B?L0pHZU5BYi9lUjY2L0JnZkhQMUgrV0cxK1BUWnN4cVZUUUFRMmJNWjNyMzZx?=
 =?utf-8?B?MzdlZzN4LzFORndUTEZJamFtSjBxbkFMaytLdGkvbXUya3JlMC8rWHJYYm1a?=
 =?utf-8?B?dkVvemtUMzNYNVBCclBwcExaMVpUbVQreElEREJOOENJR3lQeHVCUERGeWlJ?=
 =?utf-8?B?Zk1Kd2Rtd1M1SEhJT3IvSzFCTGJ5MkdOUHM0WFhqTjR3S214b1o5NzNpQ0E2?=
 =?utf-8?B?VVo4dGQ5aDJCb3czMjJONExqOHNzVzFXMU5SeXJVU2x4Z21wZHdpTWpPdG5D?=
 =?utf-8?B?YVBMMG01QnN1MXRKaVJFKzNiWjczT1ZETkhIN3FjUnJibUwwbDA2VW1YUGp1?=
 =?utf-8?B?WXQ0NitsK3FKRkdGYlVlbjJJZjhpOEdGYzdLVXlybWsvcGIrM0NpM09LbElH?=
 =?utf-8?B?YVkrUjc4dnZybnF5aFV2RUV5SHRYeUN0clppY3V3dkJmUWptbVlBbnFabGxN?=
 =?utf-8?B?QXgyUFdaNVBVZjBXWmluc0hJUzJ2UU01dTlhQSsyK2RDVkkwMGdCWFVoT2lG?=
 =?utf-8?B?NGtBMnp0VHlGVjdXMlVWakt2cEJMNmlhZmR4WU1FcWdDYUUwaGlqY1JncFlC?=
 =?utf-8?Q?7ww2DS8iJLrFfgFuGE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208dfe5a-4f3e-445a-0809-08dce3833163
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:12:59.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7615
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 08:13:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16626

v2:
   - move expensive operation into if condition

v3:
   - fix condition

v4:

   - precompile regex
   - merge tests into single methods with loops

Konrad Weihmann (3):
   bb/data_smart: remove dead code
   bb/data_smart: fix override syntax warning
   tests/parse: add coverage for old override syntax

  lib/bb/data_smart.py  | 17 ++++++++---------
  lib/bb/tests/parse.py | 28 ++++++++++++++++++++++++++++
  2 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.34.1

