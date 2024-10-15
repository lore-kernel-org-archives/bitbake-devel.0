Return-Path: <alban.bedel@aerq.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E4CFC29A
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 11:46:20 +0000 (UTC)
Received: from mx-relay100-hz2.antispameurope.com (mx-relay100-hz2.antispameurope.com [94.100.136.201])
 by mx.groups.io with SMTP id smtpd.web10.11328.1728992772020333499
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Oct 2024 04:46:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@l2task.onmicrosoft.com header.s=selector1-l2task-onmicrosoft-com header.b=fV5NnU7/;
 dkim=fail reason="dkim: body hash did not verify" header.i=@l2task.onmicrosoft.com header.s=selector1-l2task-onmicrosoft-com header.b=VWV8m/Bx;
 dkim=pass header.i=@aerq.com header.s=hse1 header.b=FjOX6JdC;
 spf=pass (domain: aerq.com, ip: 94.100.136.201, mailfrom: alban.bedel@aerq.com)
Received: from mail-am7eur03lp2238.outbound.protection.outlook.com ([104.47.51.238]) by mx-relay100-hz2.antispameurope.com;
 Tue, 15 Oct 2024 13:46:07 +0200
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=FuXbKRjqzGTi/TpBkyeYTjxQvouCvZvaJ7TLA+MEOXvWnCbLP1xeWTV7Ix4DLIilDQN7xaxZ08VxWnvgKl7tuLX16ZLyY1YsOaMSDjOU8d9AGI7mnXFs1HA8YvhZXyB86xKqOxAvThN2oY6HnThI+ASCVbziOfsPPJ+LDGws+YtvtbuL2kQMg6yDS5aRcPGETYXu/Q1zxUolwBwV2RvRg9wxEzV0pmbVGpGK8tiNLfzqZuBY0Sst4NHTqgCuWw8stgDH5mosPuM+7jU631hPycQTNa64rMU/jHmbUmv+Ws93TI1on0uL8kIev1NEACM0Jr4drGqKt6H7K0kCGYKPZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iuvwl3wALznsCMyDWkRIHADpny7qCMcmcD3Fmrkh/M=;
 b=kjS2/wwP1ZulpH9oqViREIUboPr9T9vzXroQGELNV6YtXf5dBrIX2g2jXbrbd+MXZWoP8ZWS/2uHUXqsE6jP0UYVHBqj1AMdSXb3lWW/cc+b0O9z7beE5I30hlmIjXWmgzuS06TbnFSx6Lr+ohiadJIJ41RnozCZa6GgwC2oSKzi1X3tZm4ZMnZWWCbwMkpe5b6ljmlBC8dOq91XmGPkgQmKckjkA5quqAiLkTLVGD3UVEf+aX4sSu9wM4WA54X0uVBDAMxbkNl3XakXeq3i6MTUB32+p1YoXbcqyzdjY6Uq9aqf2Zi8pi/eJI44ATX6puHVTXWINXyMzdCOVODOLw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.40.229.156) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=aerq.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iuvwl3wALznsCMyDWkRIHADpny7qCMcmcD3Fmrkh/M=;
 b=fV5NnU7/eoi/fRhMqb1IUtrEHplfJt5AybK2ZW+Zwr4DlLYbugCjrKEhcqlvufhrTNhmiqHbQL/D1/R45RrfawPhmg8JWLZFyvJ+EMvUFkBNimnLGvKrHYRn+D4aAJv+LvEzHLbZsp8NDSKvym8hEeHBNwuVyTznl2c5b0tZK2E=
Received: from DU7P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::13)
 by AS8PR10MB6128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Tue, 15 Oct
 2024 11:45:58 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::5) by DU7P189CA0022.outlook.office365.com
 (2603:10a6:10:552::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 11:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.40.229.156) smtp.mailfrom=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;dmarc=fail action=quarantine
 header.from=aerq.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 aerq.com discourages use of 104.40.229.156 as permitted sender)
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 11:45:56 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (104.47.11.112)
	 by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Tue, 15 Oct 2024 11:45:56
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 6029361
X-ExclaimerImprintLatency: 862308
X-ExclaimerImprintAction: d8d4f9b0cdc9444491daa47a233f5fbc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d71XpMnAh1EJmfN54nmJbZUUuDAz8DuE2i3g29Wl169F3uIhcesyGMM9AvFw05sthXArgotJ4xjy0IXW2dRC1KErua6oYcforW+uZxFVKBhRaiRMEXSm1HcpZ8Zk/4JrRW7fv6I9ZUOpeGQqwu1G5bvaqAJ/RhyjC9mwhLVzdr//REKRGQ6GgXJG8fxD+Hm4mOX2bJJzvkyumIysiFrjkTrfBUTSqhU2rw+qiBu5EiHEpRx46LOxb3JbB78QLHQWMaWi7+ymudNdQJPTG7WwVEip3Ug0wOhPWsBMAgZImES6IXvuO6JLXJKf7REBfNUne9vDPxC/KNZG/h+NYUAeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7YGVJ8iP3E8EG6Z/TZmIRzmNVbzrDWvPZysavayj3o=;
 b=PNeGFQJtcc6VDoiztzCES6t5ob1/IF+qBp5tGHvIJ6zcHBrvBvCg+ViMb/AtvLmHCjxw/KvJmmelrlWCjYBlMDwTYUfIUGQvl2O6jFyeCEpCfqeaK/24zaQkV5FYh0xly5gojcbVSWAKcY/0FZ0CAUVwApshb/4+T/S3yhxJVGEAFiCA0i4OHXjPGSYgmVos/NVjNM1GtctnWplrbr3Tr4ulwvsTeYecqrMPtrNRLntZfps1kxNkkGwfBYDJoehCkmsYk+jhpj1lks7s1fjLag/coFdJNLqTME73a+pSvJnrJ6SJjV+1gfcI2feERUaz+b1ro87UmZ+bUCoBHrgdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7YGVJ8iP3E8EG6Z/TZmIRzmNVbzrDWvPZysavayj3o=;
 b=VWV8m/BxXSS9/8DBLEeJQag/k6QYjmrb7b8zob6eojkVA4ycP6dJ5qS8oq3rhJFQfNQY1Q2DDmbuHzPl5poAmzRzhhHdyb54cyO/qEWXfr10n2IQG3fPpDNKpTneER9K+kPkUsF0E5Wj9Eh4XbdC0AUCU29iFRksp5T0XN7NWh0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aerq.com;
Received: from AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:405::24)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 11:45:53 +0000
Received: from AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dfc0:30ac:94b8:c791]) by AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dfc0:30ac:94b8:c791%3]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 11:45:53 +0000
From: Alban Bedel <alban.bedel@aerq.com>
To: bitbake-devel@lists.openembedded.org
CC: =?UTF-8?q?Enrico=20J=C3=B6rns?= <ejo@pengutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][2.8][ 1/2] bitbake-diffsigs: fix handling when finding only a single sigfile
Date: Tue, 15 Oct 2024 13:45:14 +0200
Message-ID: <20241015114515.1331555-2-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015114515.1331555-1-alban.bedel@aerq.com>
References: <20241015114515.1331555-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:405::24)
X-MS-TrafficTypeDiagnostic: 
	AS8PR10MB5000:EE_|PAVPR10MB6940:EE_|DB3PEPF00008860:EE_|AS8PR10MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: acb40c8a-e840-435e-659d-08dced0eee9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|52116014|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?SDczMVYzR29LK2diSVpCc3hpU2I5eTJJYjJ6NUg3aEpPQmpSN2w1ZWJ6bkU0?=
 =?utf-8?B?dEJaTWwzNndETnppa3VDeE1VOGo0ZjdBYy9MTGkwK25wMTZ5eUVGeWJFRVdW?=
 =?utf-8?B?Y3VDZkszYndyNWRzcm1hYzhBeENBWm05NkR1SysrbWNFSzBHY3psUU95V3BH?=
 =?utf-8?B?SkNFc1l0UGR4NEswRzVqb1U3Y21ubjlKZ0NTajNVS0R5K0JDUTkxTUdRNFho?=
 =?utf-8?B?Z2VsODFWVEhIY25JTitSUTc0L1Myb095a0h4Sk5EemppaGFrQmlLeEVPa25Y?=
 =?utf-8?B?WnYxcFRsY2dFaGF4d2ltY2REcjhWV013ZkZ0aXU5cGs4T0V2NFp4SU5QOEpD?=
 =?utf-8?B?UzVuNHZZMDVVelBSMXFnUjNrUGlHSmdTazhUbllTanY1bnlkK0Q5N0QvSVF3?=
 =?utf-8?B?R080NEJBTDZpbkV6SFJYdkxSKzFuYTA5Rko1dDg1Vk1lUy90ejRzQkw5ZjVD?=
 =?utf-8?B?T1poU2xJTE1lRVNEeEV6YlVQaDUyS1MzREtGZlpnMVArVDUzVGY1dGhIQ2ZO?=
 =?utf-8?B?UXRCTWdhUDI4SU5mM1ZKaGRJRlNLdmFDM0cvUUhSNmVyUHE4WTRlU0c3US9N?=
 =?utf-8?B?VFlEc29SK0R1VGVIUG5oM2JUQmJ3cVEyRW91QTdpNnZwWkhWeldZc2orRTRV?=
 =?utf-8?B?MEY1YWs0WktPQmUwMWtEQnBVZHVvT1EvdzEyYVlIV0wwYi9MUHFLSy9lTUpW?=
 =?utf-8?B?V3FIdEdaRTY1TEJTUkwrRFBxWFg3cTJXWGc1bktRMlVkUUU0ejZhUWRLVE1M?=
 =?utf-8?B?bC81STlBeXJFL2tOVlkzSVJlcGhMcWZObitTRDdZSEIzSS9FbVZFYzNOcXhD?=
 =?utf-8?B?N1NNZmVydUhycFVyVjJMUEtjMXpYNllQL1laVU1NSUM1STJ6cGpxZ3YyN0ZK?=
 =?utf-8?B?Q1hyakcyaG45cHBXTjMwcUxjbDJiemkxSE5hVnBTMUZRM241b3pmbjMxQmpi?=
 =?utf-8?B?aDhLS2hFZHNETllYb1JMOUhDb1pzVHc5ak1ZaVRiVnRBb2tHRmZwNTFBaTdT?=
 =?utf-8?B?Tmsva0RRU0ZJVk9HeEFCNmN2U0ZvYmFEbDVoMlJYZi9DS2pSTXZoR3BGVTJJ?=
 =?utf-8?B?U1RDUlRSV0ZmQ1VuM09taWlJeFJHVUYzR0lyNU9IcUttQUlKWDd1ZjJYbWtP?=
 =?utf-8?B?ZkdSUUxSc0hKWXBwLy9KVEh6eTBnYkxjZjdNa1ovYUpvdWg3WTlucFpXaFdi?=
 =?utf-8?B?Z3ZudW5LTjZVY0NWcDN1VEtjRlNQZEVnZWRmKzFmVitHc1k0aWJLTS9UN2hU?=
 =?utf-8?B?NUJMZDdaRmN0Y2F4VmFUc2ZKN0JxWTRuaGdIVkVFTzN6MHl3T0FTRHU3Z29a?=
 =?utf-8?B?Mm9PN24wMFFVM1BleDBUUzRUNmplVWpqZVVPY0w1Mk56elVOQmlrdkhCODJi?=
 =?utf-8?B?QmlXczB4Q3dnazYvR0U2dlNsKzBPZWdTSE5WbVpEZ0cwMXdqeitQakJ6TDFz?=
 =?utf-8?B?bXFrazltNlROZW54VGpES3dTeXhJTFRFV0dIU3QzMEs0OE9sN3IwMjBPME9y?=
 =?utf-8?B?UVFFb0xRcFAvQUFGL0Z4NGRrVHZEWmR1UjdyaFBHNmFqKzRleFZqbFNUckcv?=
 =?utf-8?B?ZWx6YlBUcklGalowYTBhRFQwTmw1akx6Umt3TFBsa1pyNzQyL28vRHpOL1A1?=
 =?utf-8?B?SzloTFd2VmlWcjFpQnpwSHgzaDVaVmN4OEFCbjQxM05TR2J5Slo2NW9IN0Rp?=
 =?utf-8?B?ZEp6Vy9JbVlJWTY0NThocHhVN1owN2NOOW5hYUswcnAyazIxMmd1TWJBPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	70efd2fa-7b25-4457-b191-08dced0eec9a
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aUhYNUFac3EzQmZuMFVQZ3M4N2hDZ3d3QnFJY3kxSWNseXFGcmtSb1Y3SFdu?=
 =?utf-8?B?djluVjYvREhTNFg5RXh3R2hTWGVEem01YVF5dVdFZ0p6TmRMY2FVcjlacjlP?=
 =?utf-8?B?anJlK2NJSUc2bTJpcVRYVXRpLzAvNVZuSXVMRjR1SVV6M2FlUUc1WEk3Z0Rr?=
 =?utf-8?B?bDFldFB2OWtmaHhrWUdOeHFmQ3F1RjZKMU8wSHh6TXVWdXJJeFVKcnFEdVkr?=
 =?utf-8?B?RDIyenlvMDVOWWtQck40RGJ2Q1lFdUZNSENxbGkzdVRsdThMa1BoKzlnNUNJ?=
 =?utf-8?B?UmlLMllvUk9seVFJeFd2NmlETS8zV1hyaGhXSHc0Ym90UWUrQWN6ekxmV1Uz?=
 =?utf-8?B?Smthb05YRUcrQVV0R1l2TnNaTXBKcXl5Ukd5RmVXRzEvRTg3VkdLT0NZcDNJ?=
 =?utf-8?B?UW4vRVpPTFZjb0I1cytjNVJ2WThjT2t6ck1aVG4wUDIzUzB2Y1RMNnJmYU5t?=
 =?utf-8?B?SzQwcjhLZzNaWGxKT21XVklNd3lGWlpzcWRqV05xMlJkd0hSaTlJMlVweUVO?=
 =?utf-8?B?ODlTYzRjZ0ZTbVAxV1hHNzVGMTlBa3Q4bUNVcW5lOXc2TmU2SEgvRWZPMkgr?=
 =?utf-8?B?Y25GajByb09aRitUYSsvQnlSSkZMSjZ0aHpzVDJtMVZxVU1jQWwvWVltSjlj?=
 =?utf-8?B?cisveWRlRjRLNlpnckdYQkF1REZBUnRUZzhXVDVJQWtlLzlxM1hpS3VwZzZO?=
 =?utf-8?B?UW5HOXF0SU5EYWlNWlltZHEyTkczOVFnVkJHMEZKRmpEZlNCQk9lMlhaL0Zk?=
 =?utf-8?B?c2xESllBMzNWY2QwWkJjY29WdExZVnZnMHphWEhTekFnOFg1UWtpRTFEOTM4?=
 =?utf-8?B?WkhwUURzRFN3bHp6WTNwaEJQc0dtTHJmT3JGWFlXMEVBMVZkbzlPdGErcSts?=
 =?utf-8?B?QVB0cUU0N1dVWlhONDF3Mkp5Y2ZEdjhUWmVYZ1Zrd25HaWFyc3FVbmd6SGx3?=
 =?utf-8?B?bkJkMWRjYStOSGFMdUFPZG9HNGsxbTREamVveGZkOUhkclNQbHFraHlDd3FV?=
 =?utf-8?B?ek5XRDJLaHB3SS9zblpLd29zeHU0RGhzZUNxYjZFdGtIdW1pR1NhaDU2YUth?=
 =?utf-8?B?WlMxbmFBMDg1ak95SFFYeVNCelRZZUJIR29Jc3B4eHRNQW5wYi9Ock9CV1dS?=
 =?utf-8?B?ZkZZUi9GWUM5UnlrdVRPOEpZbGlxcVJWTkhpTjZCZzkrRlRJQVBLQ0gzbnJm?=
 =?utf-8?B?UE8yWnNranJHUHYwSXVLVnZKN2JoMm5nbFV1RGlNcFNHOFlQOUlsT2NZYVBn?=
 =?utf-8?B?RmdSU2pnVG9XRDAxM2RTYXBXYUdVMHhCV24xSlpqZTVKRHMvaXYzSStqOFRD?=
 =?utf-8?B?a3Fjc3M1bHp3U1dBV2FZc2NkdGF5Zk9PUExmc1FCWjRXVTVCTmlEK0hiOVl0?=
 =?utf-8?B?SUtBNFNFVkU1Z2dTUER4dG9SRUMxOWZIQzlNWlZ4RTNMVDFJbWMxSFZ1T2tC?=
 =?utf-8?B?NzJlb212UnczajEwMFRISG9sME1QbkhibEQ1VHlJRWRMckVibVRqcFhXMnN6?=
 =?utf-8?B?UFZzR3dlajF2S0pFMDdqcG9yWTd3V3pEQ3pyNGV3ZXdXQ210amtrRnpmRG5G?=
 =?utf-8?B?MzZzdGErbVRDOEhxdG1vQ0JlZGJNQlZqc3hOcDd0ckpYMFl0bER5RHF1aXRm?=
 =?utf-8?B?VlhQd3htSnRxTjgyUkxYeWx2MUd2bTc3Nlc5VDdJaSt3Sm8wbVBYUzEreGJy?=
 =?utf-8?B?a3NGNmFkZ084dGVRenRoZ2J2MXNjSFdKenlSMWhDdXlGRmhDZ1QySlIxa20v?=
 =?utf-8?B?bUxDZWdLdXBZNlg5TStraVQrSlNKcHdGSm5XQVBka2JiMFd6YkROcWx1UkZp?=
 =?utf-8?Q?XJ4oa4ZWuOFG5sqbnTkicSgOdp07Cs+Z1QS98=3D?=
X-Forefront-Antispam-Report: 
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:45:56.5754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb40c8a-e840-435e-659d-08dced0eee9b
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6128
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----D85484A958A1B39326061145823B7F72"
X-cloud-security-sender: alban.bedel@aerq.com
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: alban.bedel@aerq.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay100-hz2.antispameurope.com with 4XSXNn5z67z3NtHb
X-cloud-security-connect: mail-am7eur03lp2238.outbound.protection.outlook.com[104.47.51.238], TLS=1, IP=104.47.51.238
X-cloud-security-Digest: 4cdb037a379d97a7d840bff1167f68d0
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security: scantime:1.813
DKIM-Signature: a=rsa-sha256;
 bh=Y7pOhNznt3ipWH8/QGtubc9JL3nPBk10DPuo4WZEkEs=; c=relaxed/relaxed;
 d=aerq.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1728992767; v=1;
 b=FjOX6JdC0xfCojy0LJcs7aiQVWkvhQ90E6rrg4jkfZWvaaf+x9Hts/qSyG3Z2aL8TG1JZzHd
 c3T67imVivggtVp5b46EY566e+tqCSbo2zVarnlJ9XmQpegKWPszRYy3XMLWzutWnrGV2pJaLqm
 xTuj/s6ydQ0cprc4EZYdtvA+e2GI/mQzl+vnUs6chR2EjpIesf9I4G5IKxOSAZwIPonKJnkpbZA
 8PaH0ccJN8HpV2rwpz+aQ1lMQ0tMIw+RgezRqFbnn1WHfQ82IZ0mCkzclyA0WYpmUV9wwQh2QCb
 VhS1dm6Us9BLdiiUxOmdYiYdTlw4TEeBoes0qZZ5eqprg==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Oct 2024 11:46:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16683

This is an S/MIME signed message

------D85484A958A1B39326061145823B7F72
To: bitbake-devel@lists.openembedded.org
CC: =?UTF-8?q?Enrico=20J=C3=B6rns?= <ejo@pengutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][2.8][ 1/2] bitbake-diffsigs: fix handling when finding only a single sigfile
Date: Tue, 15 Oct 2024 13:45:14 +0200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

From: Enrico J=C3=B6rns <ejo@pengutronix.de>

This fixes the following error when calling 'bitbake-dumpsig' or
'bitbake-diffsigs' when having only a single sigfile available:

| Traceback (most recent call last):
|   File "[..]/poky/bitbake/bin/bitbake-dumpsig", line 171, in <module>
|     files =3D find_siginfo_task(tinfoil, options.taskargs[0], options.tas=
kargs[1])
|             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^
|   File "[..]/poky/bitbake/bin/bitbake-dumpsig", line 83, in find_siginfo_=
task
|     sig2 =3D latestsigs[1]
|            ~~~~~~~~~~^^^
| IndexError: list index out of range

Handle this by adding (and returning) the path for the second sigfile
only if one is found. This way it will work for both diffsigs and
dumpsig use case.

The calling argparse code already deals with find_siginfo_task()
returning only a single file.
For 'bitbake-dumpsig' it will just dump the single sigfile, for
'bitbake-diffsigs' it will emit a proper error message again:

| ERROR: Only one matching sigdata file found for the specified task (syste=
md configure)

Signed-off-by: Enrico J=C3=B6rns <ejo@pengutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-diffsigs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 8202c786239e..9d6cb8c944bc 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -72,16 +72,17 @@ def find_siginfo_task(bbhandler, pn, taskname, sig1=3DN=
one, sig2=3DNone):
         elif sig2 not in sigfiles:
             logger.error('No sigdata files found matching %s %s with signa=
ture %s' % (pn, taskname, sig2))
             sys.exit(1)
+
+        latestfiles =3D [sigfiles[sig1]['path'], sigfiles[sig2]['path']]
     else:
         sigfiles =3D find_siginfo(bbhandler, pn, taskname)
         latestsigs =3D sorted(sigfiles.keys(), key=3Dlambda h: sigfiles[h]=
['time'])[-2:]
         if not latestsigs:
             logger.error('No sigdata files found matching %s %s' % (pn, ta=
skname))
             sys.exit(1)
-        sig1 =3D latestsigs[0]
-        sig2 =3D latestsigs[1]
-
-    latestfiles =3D [sigfiles[sig1]['path'], sigfiles[sig2]['path']]
+        latestfiles =3D [sigfiles[latestsigs[0]]['path']]
+        if len(latestsigs) > 1:
+            latestfiles.append(sigfiles[latestsigs[1]]['path'])
=20
     return latestfiles
=20
--=20
2.34.1

------D85484A958A1B39326061145823B7F72
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOJwYJKoZIhvcNAQcCoIIOGDCCDhQCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggstMIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggUVMIID/aADAgECAhAV
Bbr0bzRtpXqrU7KDa4UuMA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIxMTIw
NzAwMDAwMFoXDTI0MTIwNjIzNTk1OVowJTEjMCEGCSqGSIb3DQEJARYUYWxiYW4u
YmVkZWxAYWVycS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDD
bGac2SHb2eIa+m3KUo/AJiZDcBR5eFitNMqkBYGzLH3NwmL+2qbl5vKerZ+M3jaS
sFeMmr6P9lXTjSR4Qkcdv+ZmTUNTaJ/vLFqEgWx+sCszay9KK5TM5w4tpkCQLX1T
4Fiuans6EUUPZETMfjKBjLafMenQuGZdn/ul9a0DrkgsEe/qJUNnhsRXzY8zd4mm
mcTaiqI7elLXQelS7FUaWh/BTSjd6c+hFW8YvYxFLEsTp1di/PcBOlb9VgD4+/D4
zxHDQkfsJ7xiy/Xig3PbZmmhF/T4d9hab1YrVv1rXJqKbtjZyG7Cfsdwfz9Tsodj
HEFItk2dLR5ROV6LRWR7AgMBAAGjggHNMIIByTAfBgNVHSMEGDAWgBQJwPL8C9qU
21/+K9+omULPyeCtADAdBgNVHQ4EFgQU7sc2WNoWAgmlONb7GCP/BCyMuEwwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQG
CCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUH
AgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0
dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0
aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEF
BQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0
aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0
cDovL29jc3Auc2VjdGlnby5jb20wHwYDVR0RBBgwFoEUYWxiYW4uYmVkZWxAYWVy
cS5jb20wDQYJKoZIhvcNAQELBQADggEBAF9U2htHftfPRwJwvN9bFBpXNA69+Em1
a4zxDLR77PMBkmc8pwgbl12rBuwJ9BzUsOgeCLfdCmQiurLsnGhrvGj1JV7L1s8e
S5vKKemLAnPZJ0czTzQeIGlLY0ZAvBWbgkjmWLpsOjeZmLOOMFLTDa/5QZzDXo/E
ZmvxqRqsfirSYWVzKWdIoIbpfBIdqMM5sj/p+L9vXDle3143c+orA+1L6tp/7Mw6
tFIzedrBWu4wv4XgGb5OuouhiBL8+fzVlsY67M04A/6lQ83eJXEn3JM7GCMIPIdj
N7fLO4fWbhwndi+1xdmlTY679FwT+mpoPXVARs7OOLxuuitpqPdw4jwxggK+MIIC
ugIBATCBqzCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVk
MT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5k
IFNlY3VyZSBFbWFpbCBDQQIQFQW69G80baV6q1Oyg2uFLjANBglghkgBZQMEAgEF
AKCB5DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0y
NDEwMTUxMTQ2MDVaMC8GCSqGSIb3DQEJBDEiBCDgt9sutFhFdJb10ollrwML9jDz
rL9uzxHxhIAKf3Un5zB5BgkqhkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG
9w0BAQEFAASCAQBVo9+7Vd39VoomZR6obtvVLQZVFz9iUdLfR1eAYUOkE6O6wgcH
zfqmzvtk9qY8PRz9ML68A0Z+2XrcpuBBMhMd/z1bVLuT7H1ss5JCN98SdRQgxXDT
UAlT9bAjHfO/201G3PmrwiZWV8q5npVLK9j8XTrRa+0tp98F5XS2fPHqpaWctsfn
4bFe4xmq3Te5qdLZ9DcPg3g6kIdlgIHJsWZA9KrC6bgTk5RGuCkikOipRGgtvv0+
hrgwL1Yrky+aVZhuGHXZ6SQvIDh4njetHu7cqEzo7u4eyxxti4wJj9LYZZ6xwHmn
VgVhdVAnpyzcp9uiJfGPCcbxU572jSXI1RFU

------D85484A958A1B39326061145823B7F72--


