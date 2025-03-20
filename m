Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F4EC36000
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 09:17:47 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.103])
 by mx.groups.io with SMTP id smtpd.web10.3162.1742462258020536300
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Mar 2025 02:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=5vrsCNwY;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.103, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCKe3iuc7XeOyElabnirjY5fZ7cuthv6VjHpBJ6gXLl7H6vszpTp7YKsDKhHutPgIrr0jUbQOUIPgKK95DVI1z7Bz2cest7nr2eJTz2+dDSpv1dB4HjRuH//vmB74tb5SvON394CoSBzZnivTmpR780CQQq9HMiQ/nz36dHQvz/HboLxAyL2O+/F5cwDGMQhJ7/fSH4r+hn3In2Vl9K+G5cTHzTkTSvDVBjUJblw6dLrqnkXJ5Ns/Z7gj5siJbQ8z3zplpAd5YvoccOKb0MadfPyw9wOH3ja3XecO5LOSm+Q1WYaoy5zqLBkr7BkBEmIjLiQTpASnqBob/ts2BSRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpmXxXELvcMXMXapMVLKFiHLMg2ERhGWT3Vn/UDo1HE=;
 b=dn2znnqk0qJw4HE7b7qhlUOkVGI2G7/v+qm/a510jgNiWtobrgHe4Wtd16M7S64afCWzxZ/CbgJoXtQ+nUtCIJTGdIWQdvf4a1k1m4V7pBEtMC9W1ExJnP9MUUhUa/750jieH18haURmgYJiPBSsM6grcjjbFS214ivML5yTIvG5g2Cx5k3yj5e3083ZUHK7j/VlVELN+1QzxWJD2Aw+LZyd9OJ6BUAC8xQiLxo5AMEYjGq6fRws6LEK9yd7omZtsGkUK6PKqRFQ/zX8KCEeu4sA9eQY0cQkR/3MxLTy7Q1Q/y19xMxkIUpuwCtnxrRUXMnn+HwX5ilQjhkWc/ar8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpmXxXELvcMXMXapMVLKFiHLMg2ERhGWT3Vn/UDo1HE=;
 b=5vrsCNwYL2wJW83ksQIqWo3BKujgApf/KLQdVNEwM5+4FKhFWT2cXsUDwi7eP55LL0HNaRTwhRCdthDFz1GOxnYk7lglEcxdd5gmIK/07kLIW2UJM32xmX1WXg9J5DzH9oZwZnbwP9pyLUrDm/wb1KNo7AE8YXeB/YNQ+68WiBLiiq/pOJEF6yvVoVzyMmqcqXQJ4WJxHw2ldnBs0l6n1iEODMcIbfIlfV4X62IXKk5Ozw8gUd/FCFES91h0WkBO42ZughJ9X+j4/8xVJ0j7fRBe2EE+fWPY/aETwFr2OU87ikQ0ij2F3L90I63W8c/XrUwPT9cdzH2dLdN9UUbABg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DU5PR08MB10774.eurprd08.prod.outlook.com (2603:10a6:10:529::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:17:34 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 09:17:34 +0000
Message-ID: <9a1ea09e-9449-4449-ad30-a175df2c8207@weidmueller.com>
Date: Thu, 20 Mar 2025 10:17:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] fetch2/gomod: Fix mirroring problem
To: bitbake-devel@lists.openembedded.org
References: <20250320065011.1560156-1-christli@axis.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20250320065011.1560156-1-christli@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DU5PR08MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: 0684e166-2ff8-49cf-b1e4-08dd67900c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fnDMPKQkjt/I2u9Kh/A6n06MABqa3jJCqIXJU0wn2ALm5KxQr2JDEyUIsykk?=
 =?us-ascii?Q?w5BzB/1w35pQelBYdhhUhA1f9xRzQKc7PLTyCWJ7Ot1FGdA7AWFZ451WWsep?=
 =?us-ascii?Q?rX2DjnrReVjbqOBWU6ldVfD4u5IJDW5J6b27vPL9+ZXrCp+e9oEbi2p1Mqau?=
 =?us-ascii?Q?JIOnQYpQezNRUES0ofXmpS9m2yZd2SSlNStEqR/aS7VSbHR1B3S5xDKV9N9y?=
 =?us-ascii?Q?+U9+1diumMWNtQf/2XErPhgLRKu6NZ7bCeITXHwMDuBOKUKanmaTSgCiUWy1?=
 =?us-ascii?Q?7DYoyEJo3xc27yKCGnCwfhRsEgBKPq2+7my6BM6rZlWDxONPCXO8iat7kGYq?=
 =?us-ascii?Q?XLZddniZ1gKRWfskKGQ7+LZnjhDPhtbR3zUvQgWBA1zkeV7QuyqEnw0FoGKq?=
 =?us-ascii?Q?/BX3U19rNognBMAYER0fR/JpdKZetz+TS56GWMe8QANJsvGX74+DM6nAMkSW?=
 =?us-ascii?Q?z8I/TcmZzLn3umpGTI1lJumyqgeD3zOid4SRqrBnQxGuLQdWSUOf/5FX78Wb?=
 =?us-ascii?Q?JdrIpICA/Uk7kZK9prwXqPZ8SOGWMVo0Ai1WjsszBv0Xy3ttbYHXs+Htrb4o?=
 =?us-ascii?Q?7ZCTaVY/mlKWW+BEVvBg886J1UtAUvMDHNLWAJ1XiSQosgLdi19NDfV5gDvb?=
 =?us-ascii?Q?QAdwxzpaKJ8u/hfhhF8uD8Vo0FJr0gaROtECU/knY/OaCbaAJJmbdcy7mxrs?=
 =?us-ascii?Q?I6UFmw0j5br7sDZpRUdQ4bzVR17FSUQLUGQjaPEISPP36UDwyZe3Hb0j4xRS?=
 =?us-ascii?Q?9Y6Xp97d7mrPJ+CmUaz7QurJlKgn8bXl7Feg66OkFo0LhdHD2Djh6Qf1N6hD?=
 =?us-ascii?Q?wHdXuzHbHlnj7jyzWGhDd/8HBWRnm2vPUsJnljlSSkEMOuRevmIEjDGaflZg?=
 =?us-ascii?Q?30DmHzGVEqvEAzEh9vJ+9RyEwleytFG5kdvKRLjec8BUGsd5aQuWkLjZAaTK?=
 =?us-ascii?Q?4Af6FJ5VChQlbGjUgP/2uCmaX19VQHqhTzy603PfH+eSXQpfGBeqcVP+7RGk?=
 =?us-ascii?Q?h+BMwhVX5mj09pSs08ldoZk9Xe1YabBontcaDbAbi5GaFya2NLZQrxQ0n2U1?=
 =?us-ascii?Q?NMxnt/OH+i4fLCujNW9BSH7P+1UvI0wXPp25q2fgIzABAvOaiWlUC5Xgjvf9?=
 =?us-ascii?Q?MbH04iKOdpMp4JL0TM2S/7GsJpPohLucMF0IWm9782TRBpBsz2yTvjAhUYgA?=
 =?us-ascii?Q?gebhqvWPSU3I7uY8tS/DbUqYe0Mam1T2LpCMPO5V/NfaP84VQLq8SGdLXGdK?=
 =?us-ascii?Q?oaBkDli7T91Gg8ZfFOXhI9nfZ8agP/lgkIvgoD3ASJcW7pLkyRBhq3RIrWbC?=
 =?us-ascii?Q?DoRdpOVJTXLJZP8TdV0JMkAqUki0gqE37fJvGJOfQkW7kOdgQYz1Mc0bV6iP?=
 =?us-ascii?Q?MbILMc03h52RHHOLj9PNtQeM0pfz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rl8N3JNx6XlcCjpBV+1Jtx3WmI/Ydfb6TvxVvzi0uB2MeYQMKrheFpl/t7pk?=
 =?us-ascii?Q?Blu5h2PPkhLajg14oDY2vjRvykzCtwuKSIAO36JVgWFf3f79445MfdbsvzEi?=
 =?us-ascii?Q?gu6aYY1g2YjpoRP9qWtexNXLTtqXzJAw5a7haodf2N7rSDvzYwWBTM6YuXTH?=
 =?us-ascii?Q?PSQvFC+k+PyFE29BqI0xAsZ+csPxfWv1tvhoM1qI99FfaLa1W6Z/ZIKnTxjX?=
 =?us-ascii?Q?fihlnZqhQfZPHmkEMnbt0AT+FwtfxGK/30Jdp/h+npe+TsUHShuKBBCJL4+Q?=
 =?us-ascii?Q?WChC9AVL6pHGW42ypViph8VXGCYPzweCxs2LjLHnQlcJW1qtc5CLrUtWa0w0?=
 =?us-ascii?Q?jHRmV6fzTM0rCf2IQLj2Nybl1WmEAg0Qh16Mf1gLBOL8/ZEAqY0Et4XfqXZz?=
 =?us-ascii?Q?3jJfGKVBaYw20U5ovTrV8R8MMq2NuvFtLNMhzRnqk0dsZLnKt5EWEjGLnhaF?=
 =?us-ascii?Q?GaKwfag1P3phnqPkdFSv81ioemKtF62KyM2yNcgWiWU9g7fe4MW2YP6gFFXf?=
 =?us-ascii?Q?YkTl+VyL3emJao708xdeIqvsDOIAAto/wcin2WdwAhHoLAeIMs8GwwI7WCdx?=
 =?us-ascii?Q?eg7FHrt/QXaAZ91HJr3p8Wykjx0tvJwxC5R+8rDwjdKCwFbGgAutSxi/AOih?=
 =?us-ascii?Q?M8EznUURZILlhXMlWTRQNW8ziLWcFH9Ct8gILIcC3mrDQq5FRN4cqoDsE7MQ?=
 =?us-ascii?Q?cN0B61zSDP18kxmYjoph3kRV86OjDHlhr0+8xvMcIrEmpsgqD2IjALBY4ECK?=
 =?us-ascii?Q?qjamDLh1IEOar7MRM+QAlhB0NdNDxdzZmE3K6+Qfhsi5kSiu4JVXWN9Py6hB?=
 =?us-ascii?Q?ZiW3syLVfnS/G8uiHf0SHCJ7Hdbw48iCHvWiZWrt+UgRBAbxBPVSI64qSazz?=
 =?us-ascii?Q?KBdhOC3wvFVZM9dusHv9JU8lGeEm3lTgpnjub+KVeXNoxAfn6H/LagEbSjAU?=
 =?us-ascii?Q?cycysBQQJafxSkL+3S6kWWfajtbMHK0aAaHZ/BZdsQpoK9HHQ9KP6T+3w4CE?=
 =?us-ascii?Q?w5DJlKhvbUsueLmhjBJlh+hWn94iF4rV6upmIW6O6L89X4xN0xao3MqJLWRp?=
 =?us-ascii?Q?yXQt85K6/fkNtSKOndFntHAjNxmV1UvRhdPxvsTum5lHFPf4JSVAdnxQe2RK?=
 =?us-ascii?Q?OPKDMVgyXR60rG5Q89ad8jfIB4se3q/P2H2pSILVlurn3F/S8DMiTcLRLqj8?=
 =?us-ascii?Q?UeXg8vMtsswxjYMu68TAkTMvua4jfagZ4KaKE2oNMgKFNwqdpbWRnc4mtfJG?=
 =?us-ascii?Q?eK4mrP8fMfg/EGnLfU0kmm1ONunasFOSsOlvcoDdDGF54ApChMdx6SgrU2oa?=
 =?us-ascii?Q?TjFR32eUMnPev5uFn8gjb8T8sxc4OJDQnAD+xSYKbdUC6Gjn3rD/Lng90jVf?=
 =?us-ascii?Q?PhrDpvUdzyVEjPkTKjCfCMcdOSnR4Kvws6Kt3KVo2hTX9zRlauqvD2BHaU6L?=
 =?us-ascii?Q?1RLlTFKNp+4YQvvr8KekTQneNvoJg7WaumCkasvXL6qcEeSOryAAWaQy73TM?=
 =?us-ascii?Q?goDy6dxvfAktt0CPl/5Mvn6u1OjmUaXoeXaXFS1ykP51NaWoddNl1DQNime0?=
 =?us-ascii?Q?hpbUFlNZqqODW254onQQeY08ClPh5ambPsja76Kz8n0saSKc1Tte+4nMfi4c?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0684e166-2ff8-49cf-b1e4-08dd67900c62
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:17:33.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc1RdBYqFsIsgiv9EkN96d1cgclpOazfqi4dC7G2jKBLCMJshLXabve+Z+Yi57YAVQvKcssmGLFSH2IhxHPhUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10774
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 09:17:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17478

Am 20.03.2025 um 07:50 schrieb Christian Lindeberg via=20
lists.openembedded.org:
> From: Christian Lindeberg <christian.lindeberg@axis.com>
>
> Build the 'downloadfilename' parameter by replacing path separators in
> the module path like the git fetcher builds the mirror tar ball name.
> Copy the downloaded file in the fetcher's unpack method like the crate
> fetcher instead of calling the base fetcher's unpack method.

What is the reason for the change?

Do we really prefer to duplicate the code from the unpack function?

Regards
 =C2=A0 Stefan


