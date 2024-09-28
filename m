Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C6CF649A
	for <webhook@archiver.kernel.org>; Sat, 28 Sep 2024 07:00:13 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.92.49.99])
 by mx.groups.io with SMTP id smtpd.web10.9215.1727506809905741789
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 Sep 2024 00:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=COMqt90V;
 spf=pass (domain: outlook.com, ip: 40.92.49.99, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gufuzMVd8llsQb/LcF+BfsBWpsyBM/hgpC85UusH5kkg6maWWw3Fl6AnG0TVngCNk5weun2LcqH70JYB004bLc928ymDKtdq+3XpUqqHd0sox6/g01BKmsCuvFftrS1twQoHPk+AizS3xX8hXbnhnNIfwztAEUISz1Ogkn+edsV7Y+hmrhjnzdWYJvqn1k3QaJtPHTjENhrfDW4J07lJSZATUHEwrTndQkBKRWow/tKbxdyuPzQ1CA1I7vqOkTdtJNtj8iNE+as8uWkdf3cZ2UxuIxfmFSOi5Zy29Glmwx4x2LzYTLgJPYn+85L+mj2mqLbIx7/YBP9kwXQIwE/L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnkZyoclwyEJt7+RzNE3iPYRuDaMj143flgjwEX7Zf8=;
 b=VWQXwKaKWrb4akRJvWBhRAvj6kIyGX4QKjqDLIieO8J2rXnCr6BNDheTeJDMP+xh7ds2SfK2ozWEhNlf13YMyOl4NxP1EAggQTVXxLVCTjwBb8mIEf4RL1PmFR4Ue69u8UatJ2rGqyhaFDayl6W17w8hU07OxtsKA25OB84BmVaSmq3gD1LqT2odty2/98Io5I2E++JNK6gBeMbtxrLNgGofpoKOy+MdAts18XxsuZfhAFbJAUi1ctCrZVh57nXpmLREzhLzlhrY153rNiF2i7KawQwCsmdzlWJxo52j3hMS+iANuk86CxvTkmdWYMyp0+eof0Y1wGcbG88H9CaAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnkZyoclwyEJt7+RzNE3iPYRuDaMj143flgjwEX7Zf8=;
 b=COMqt90V47aYDVzx2AUNeLlYh9jagQshiQl5VzhfbbgLryevyG9MejObqOF+bT3tMKKt0EaxkIjiA8ubEZsyGdLaRnQ93ClCPfhJHhVTI9s9VCEZGufKhtWwrshF1hqiRuoI9TIzhhM7xpdJN7VaFWr4CREidL/c4ZrfzfHRn898rZ/KSQaio66z2T4Ku6BaRt3pX2T6ngYND2DpKpfK7cI8/qLPfDBcMg9WdbukLx8BQdR5koj9qQ0UXQybpVu5WfFpooIhFmXFrIhGN9cHNJS4sv0ndV7q8QMiGAtRVGRMXegRIeboXlP8kScpforlCARwTSgYFdQJBEqeYKrtsw==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by DB9PR07MB7945.eurprd07.prod.outlook.com (2603:10a6:10:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 07:00:06 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8005.020; Sat, 28 Sep 2024
 07:00:06 +0000
Message-ID: 
 <GV1PR07MB912052A98343DABDC3930B58A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Sat, 28 Sep 2024 09:00:04 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v3 0/3] bb/data_smart: better old override syntax check
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <bd5cdd5c-d059-43a0-a72f-1252763a7f9e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|DB9PR07MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed863f8-c94d-4545-cdf7-08dcdf8b2ecd
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|7092599003|6090799003|19110799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 
	Ksnskv9TmyTbGipFb+GCmUXLRU6QCt0KP0QGJKagPCAAiI9i8sRg8rX9oMryNAGZpdr1xDCjGQEafngIHQKT4RozenVloZFyQJH7V8cGVbk2wOsJXgeXkVGeLslv1xQpyN9ZSkgz8K2EeY6fpl/txe3W0ewS0HlOqRq1EmYdKIGX2Ob70OxsBuMsBOJ2fE2HLBWYfaVIHJVBCz1pDqSoymul7JB+T2noT/LOuD5NxQN6f+fo+kEpOtCTvzITS0JwJTL3ldsqii6VrZNhzGG2nslV49vlSQrLM3LrJwJLvU/8EqY8bSSHg5ivkmInIERRBOH8jkR/k2Nn+d4Xi3H3iqJL+5YIi8TuDWfPT8CTzPAjrJuigNwGgj57wcZYzAJlFRcvopvIR2PQLISU07xEGhADMJpukOLn818v28WQyrJFisv4N3+g2Kja2szTxTdBYCQwwP73SfSHjfY4G1G05rnWxpgtS8wwcsXmhSa6Uk2VLBirEBgJ7ewO7FZ2V5lq3yjlLElKMbOJZLdsGWFUaaZlC5orkzsNDaIw8KGUzGp/GJHLHTP12Y1ga8tpL6uiKp5Jax8oDQ5WyhfbD5VgoNMIBLnn9H2PG+VAuSK3Cjer7650WsCta/W22OCZTXc7MxS/UMAGKOzUtve1hJk1i2GIFOF2mXx6czcS1DahugZKUcNwtduvk1QOYRxjRN/eXPGfhbFJvZDaeqM3QmXj461T49D66INnc78+0nrnOO5AUjBZc8pz3bbTMpIoO+wSi2XSAhztJwInnn4zxZZhag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SGdOS05aOTZHQ3FFZWh5WWhMczF1SG13R0J1TEFyL0l6SXZGRFUvdyt5b0ZY?=
 =?utf-8?B?VytlVnQ0QXowWjZRK3VYRC9NdERYWTRIK1FQRjNsakhybW5IOERNSzVxeGJl?=
 =?utf-8?B?eFN3Uk9lZGo5TEh6UWlhekFHR2htdmFxWkhzVGxHenNsUDNBeHRYNlFFM1dp?=
 =?utf-8?B?Mmx5R1hRaEFGN2pqcE1xV0F3UDhVOC96STMrTFpKOTJXcCtyN2FkdnQ5ZG1K?=
 =?utf-8?B?azFkTDBpTGphSmY4UzhON0ZsQlRnUjRMdVZQMzZndDVqd2pkRElLcUVqWXhy?=
 =?utf-8?B?aUt2eGRzVzF2SExJWEpRWVBWb043ZDlQRVVmdndNRzJYMFBvWnhGSGY4bVR5?=
 =?utf-8?B?MnFHTW4reXM0cldZdzNYY29XanFvb2dFYmlzcmUrRXhXZ3cwSzg0MnFFRWFT?=
 =?utf-8?B?WUh6MEhLNkRqbUdFZmJqUzhSdllOb2kxeTRNMHNOaHpkVEVtSkxkMDcwaDBh?=
 =?utf-8?B?Z2dDZlFLVVhhWGFveGJGU20yZFJ3L1dBZzRTMHJSaW8vYVNqRE5NbTF5eWw3?=
 =?utf-8?B?YWM5V0lZdmFMd2tZVURHWHZlanErMTA5aE9Zb0tMWk1nbkdUOXFMMW9wUER5?=
 =?utf-8?B?SEtnYXJWYVFicHFZRHpndE1kcnd6a1ZiYnYwdlgvUCtLVFpoK3haWWdzakRT?=
 =?utf-8?B?OXFlMjlIK2ZJNmM2MUpNVjBHbVk1cFFzdS9hMzlIcmdFaWNMY044Y1VkcklY?=
 =?utf-8?B?U1BEQ3NPNHN4NHNMRmJtaVNTQUxPWW5QdndTYXRuRG45UWZrMXlZaW9RcnNk?=
 =?utf-8?B?Sm0wZm5XZ3g5SHRiQTFQS0xlQzRKV1QrcXl2L1Y1cnEyV3plZ1NBZ0hBN25F?=
 =?utf-8?B?eHhBM0ZxNFFyVU5LbjBybEhnbVFWbVptUWEwcUpmZDVkaTJkbFVScStBc2lY?=
 =?utf-8?B?MTQzMFJ4MmtBN25jeHBkdEJ6TUdwTFZxU3NRT2crcE5vZEtCSWlCU2JBeVpQ?=
 =?utf-8?B?eVNwS3lWQyttNitxSVE0eDZtZFRLRjBWMFBONWNSdmo0L0pmMmwzQkMvclVk?=
 =?utf-8?B?YTdYWWx3V21FUzlRcUwxcHcwaW9ZNFNSY3VHRWpsVEVMMHBzSjFDcWg3ZFVE?=
 =?utf-8?B?YkxaS3N3TEZBWEhNRU1LdVdJNitzb1VZdjNrSmdLOVdDb0U5NnhyaXlJbVRp?=
 =?utf-8?B?ejNucnZQK3E5YjJiVGpCaDAzbllVMVpPZkprNEVIVnhDcjd0Y3llVmIybDd6?=
 =?utf-8?B?VTFZSkpxd0FFcGJvd3Y2OGFIZDhDWjhKTEFDTDhLcEtTMDRmai9ycXpOWnlw?=
 =?utf-8?B?b1RjRkYvdnFzWGw4RmJYTEpBR2J5TUVSejZoMHNUNFJLWUJtbHUrVmJqejVO?=
 =?utf-8?B?b3BSdWFyci9zWGFKSFRZd3FJL3pKQmlBYi9vSXJ0eTBCck1HMWtzbEl5cndj?=
 =?utf-8?B?OG9uRkVFNzJ6ajF4eDd5OWhDUm5yOFAwbnd5OVFVMXoyYnFHMzYzb0tsckxz?=
 =?utf-8?B?akZGNXd3TXg1WXUwYWlPWGF3THR5eWxYc3lBZktZU0JyR0swMnQzUTJtdG9t?=
 =?utf-8?B?Z093aWZCOGxxOFBGK3ZycGU2T0RzTUx1NGNNbE41OW5iYVhlWjJKWnduNlo5?=
 =?utf-8?B?aHIyOWdIa2xmNWdkWTVQWEEzMkhQZDhQZWJlaGxmVlJuWnpucUVILzV0K2tu?=
 =?utf-8?B?dFFiTFFrTmRiSEtRUjM2UEc1UHZNeWZTT2s3L3ZXUy9EUzltZXVrdERiRWhB?=
 =?utf-8?B?aCtRVVduZ25mbWc3SDNaeXBmTDFWNEpTMDAyQ2pRVGxhZWZxOW94dnRNS1A1?=
 =?utf-8?Q?qmEqiWkklW+cq1gBCDG1KDLM2zjDaW24JNkt9uK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed863f8-c94d-4545-cdf7-08dcdf8b2ecd
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 07:00:06.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7945
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 28 Sep 2024 07:00:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16611

v2:
   - move expensive operation into if condition

v3:
   - fix condition

Konrad Weihmann (3):
   bb/data_smart: remove dead code
   bb/data_smart: fix override syntax warning
   tests/parse: add coverage for old override syntax

  lib/bb/data_smart.py  | 16 +++++-----
  lib/bb/tests/parse.py | 69 +++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 76 insertions(+), 9 deletions(-)

-- 
2.34.1

