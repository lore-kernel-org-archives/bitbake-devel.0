Return-Path: <alban.bedel@aerq.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F50CCFC29B
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 11:46:20 +0000 (UTC)
Received: from mx-relay26-hz1.antispameurope.com (mx-relay26-hz1.antispameurope.com [94.100.133.202])
 by mx.groups.io with SMTP id smtpd.web11.11291.1728992772631775803
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Oct 2024 04:46:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@l2task.onmicrosoft.com header.s=selector1-l2task-onmicrosoft-com header.b=Rz6WCKx3;
 dkim=fail reason="dkim: body hash did not verify" header.i=@l2task.onmicrosoft.com header.s=selector1-l2task-onmicrosoft-com header.b=pKMLW2Z9;
 dkim=pass header.i=@aerq.com header.s=hse1 header.b=D3VgcyZ8;
 spf=pass (domain: aerq.com, ip: 94.100.133.202, mailfrom: alban.bedel@aerq.com)
Received: from mail-am6eur05lp2113.outbound.protection.outlook.com ([104.47.18.113]) by mx-relay26-hz1.antispameurope.com;
 Tue, 15 Oct 2024 13:46:09 +0200
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=TGG4rCPa+aIThmytP3xBXG+qVGTt7fpdzDIVpJq3G1u7DEK00Bjgg9TyGQh76I7cGq7RNrxJmvHgLO3f6EaMuJds7FuZnxYb6LaQxcKHdMNr3ABNQJYkTf7j9YOR02aK8e5T6e2D0QTufn6cS+xWW2VaITq0aXzv/oAsJ/QHvz/Orp/fAWoJTCuC4k+0204G+ecyWI57Z7A75gYCguTQYGr9M+oqIID1TGY2LjfypJlQ+9ahDbjmON+ZVq9U1yP9qmY/y/U7HruqbwHIWP8AKRxKVGaQD5e75NH0UeTNeKpTwcULWz/l3HBq4N5ZPkdnkGWle75RYmCssYPuN2zgBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0kA3Cb9rYXbqYWtMhGwFV0Q/L5CYbg1O0u9NiyGiVw=;
 b=Nv5PmWgivmWxcEax07H+aOUoYPwswwNbZuO0rvOeV6EivvZhBEds1iB/s8GJEzvICp+pH9ndA+OZizfjAjsRAVIqbaPB1YXGss8YrsAjapGUnvR05vqxeBW1jExGBzAaNEsJ/pyobc8Y1yZFQ60ZQ6Uc3WMhC7JDIM2sRURFaNdFAu04EHQY5UdObD7gh2JtMJyL4qhgnTtuOMqf8UkdAqqDLPhrxDOL5ze1Sw0t3P5R+m+4kuAbBoEVbz1eAAMy86t7np8V3EpfqoCOWXM/IqSfg39y8+qFxaKQalO4ZHMHvAbF9LrUoRT69u5FOsTDqnYsHEFXTsqjprgrIRATzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.40.229.156) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=aerq.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0kA3Cb9rYXbqYWtMhGwFV0Q/L5CYbg1O0u9NiyGiVw=;
 b=Rz6WCKx37/54SSo3NzrgfiEGBmgvyHY5odTHKZCZ03IIPFS0Mt1Q21etU8czIDWfm2LfXEsGtKUL+AACDJXP60wvrV4NVhNdyC8CHETmKPJgv1E7nY5n2HAfpFoYTMWwsNRo9G16ZQ/3Axo0YOwMArF6EDGIcURfoJn5Lt4yga8=
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by AS4PR10MB5846.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:511::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 11:46:00 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::1f) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 11:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.40.229.156) smtp.mailfrom=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;dmarc=fail action=quarantine
 header.from=aerq.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 aerq.com discourages use of 104.40.229.156 as permitted sender)
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 11:45:59 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (104.47.11.112)
	 by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Tue, 15 Oct 2024 11:45:59
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 5471397
X-ExclaimerImprintLatency: 588968
X-ExclaimerImprintAction: 908c34d0a0374bb797bb7da71e48141c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNhVpi0RdcGZND8sd+loF71K7dIjZMhyQocjEJ3y8n4TzwqRruzQFi6KV0eyWaES4pnInsWjWrP0b83H9/Vp1vDkO5XaaUWN7gjJ09cqopW70w+JxrOoswVH9YVwdWuBIxhd7e/eKWsal2K8fd6sM3WwxnYXHNByqQJ/egVwWmFlfhgVr5nzf7stW1bsErHOh6YknYN2elh6XbDLPdd2E7XA5CZ1ZisPDC1O1WatrMvA3qo+57UWo+ISOkFwN45wr2Baejl8sKGvk8ciDaIPoEQOkKrFn3ZBeh/VzxhbmF32JNuXsA9lHwteEUnMMJ7eg+uABykIXgBQ33XC3Dq4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9lMJqFyX8+OZYMR8uUtWogKYnNBcC1a3weeLiTT5wI=;
 b=ftF+VB6c+hzioNmofApKglEMsS1mxT9/AWPOgLNcVs60JffqWg0QYnJY3WDPinMFbsX3kmkOqFQUfbG+uvR/gjLk99cUpLrb7LIeArOgybfzycHvhYIAOOObxZsm/b0nU9eZDDaRlQk6znAsui/LxNFxl2hLzo8YnDdkbtAhWbPOU0/whhNomfjpXtGezAXn9w3zPjYmfWntfg3BTgWGNO5QpUsMxhWB5twzX5YLtFEnCcK0RoGdFuxKVQ8mFXetnQdQ0goFbu9IILvgRprFbN0m0b1aumlTUwMHMPqRae+1XZzz22SjyUpxLBJHFuSKL7hW0mWTYxOh1c/ROmtRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9lMJqFyX8+OZYMR8uUtWogKYnNBcC1a3weeLiTT5wI=;
 b=pKMLW2Z9ekJ3Swh+tUrKTtHgHO/pPNfJmVvMpiilYrG+AysPzk5hzigXWk9HBQCqHfydAG8e+favg3645As6aPSvfJF6UvbpQ4N2H5T2RtU3JSAPaYkaai/34FZJ9HHIGHT2in+qLL7AxkSBB9mjzCUvk4XCoCIHzJdM7NtZA0Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aerq.com;
Received: from AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:405::24)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 11:45:54 +0000
Received: from AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dfc0:30ac:94b8:c791]) by AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dfc0:30ac:94b8:c791%3]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 11:45:53 +0000
From: Alban Bedel <alban.bedel@aerq.com>
To: bitbake-devel@lists.openembedded.org
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][2.8][ 2/2] siggen: Fix rare file-checksum hash issue
Date: Tue, 15 Oct 2024 13:45:15 +0200
Message-ID: <20241015114515.1331555-3-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015114515.1331555-1-alban.bedel@aerq.com>
References: <20241015114515.1331555-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:405::24)
X-MS-TrafficTypeDiagnostic: 
	AS8PR10MB5000:EE_|PAVPR10MB6940:EE_|DB5PEPF00014B8B:EE_|AS4PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 13296e3a-8e64-4bb4-17bc-08dced0ef01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|52116014|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?qi4cDk7cpR6FFjsVAX1fG7yZheaVt3qgIeRJj0yMd1wUKVSPeaslj5YNqso4?=
 =?us-ascii?Q?3rWqySUY7kTOzc6dW1FvjK0nuge4mMVokmRsScGgABhIfpWeC4XTMK6sX4O/?=
 =?us-ascii?Q?t5kapJAlfDwh2LvcYCM5rHKIOzc9ETVSzd++QuGuDVGUmZLzZFw4gOZbVbfY?=
 =?us-ascii?Q?W7pDJEcDK3jHHjWjkCF3SUd+NYVxep0dyPaPupIdBSMQRV0nz8eaatCcn7UL?=
 =?us-ascii?Q?swVDkzRD/X8n1mHVuHAUKbJPyx5L0OZTpGcToyfW3GsHijBmBMVK/UG77YAJ?=
 =?us-ascii?Q?T4ouwmslj9+maUSw6oW66Ir1l6Lo1NHSGAXZwV/IlSwkXLgi8cKFLmcVQF7Y?=
 =?us-ascii?Q?rphCVauLMIjaIONVAE2Ddur4lmMtSFKpyiEUfvVXQXv9afJvwGfk+abzJLwJ?=
 =?us-ascii?Q?mpNh5zpuAxxwYYJdJRKXA/Gkg/prwmo2Ab+6vHb8+1RmpbeotEdULnLOEl0z?=
 =?us-ascii?Q?JVJBMcafmGQafAdTf8UwVcOgOKX+eVzzdP0DqIcHEfOKP4jScWGk8YfeZFG4?=
 =?us-ascii?Q?Aedqou2Xj/4Ct2iDxJGVwCXmGKxn9FAV2WrUstnXmyHDLXdcGk/86eO0EgVd?=
 =?us-ascii?Q?WuvdwU28ufkjKhZmer4e0WG8AJa4KFaNXo0SbkOc7h4KSNXOy88FFWeX1kgG?=
 =?us-ascii?Q?EquQFg4eY/k6LcjQ9AbF3saY/NOw9XZT+1eG3qk78D0JsLrPycDnudO9VNrc?=
 =?us-ascii?Q?wL/CV/PVQXhRB6xp6V2dEiTKeEkmlEroecWxmGqX0IklzKZ9YuPIA36l6WxL?=
 =?us-ascii?Q?t2YmkD0KGYWRTex3t9mbxQh+KHjna25SzWzfItC57ZanU0FOWqYGOqgHZAOb?=
 =?us-ascii?Q?wtGZZ95nU2RG+wALVoto8Xod+qVUhmI44xqYH7ca0qSgpuyOyEGhQkSgtoGh?=
 =?us-ascii?Q?XUJ0ZaYRr9HA0exN8RG4c5mRg1xuvXOoTx7cq6VfnM47WARpoHiC3156oXJq?=
 =?us-ascii?Q?jcI4YrgVMj2fekxHD4/CX/3eRtv0+qpiqrgF7UPoJejXjoH2VqT0rjr4HPPV?=
 =?us-ascii?Q?kd9/2gXnB+B8p4Ql2qDV5U6ThDrnOb5uzm9Ppne5X2LOHVcFCkBUls3aNgXt?=
 =?us-ascii?Q?Huu1r3susgBQ+WO0O/vsA6QR1D0t534G6V6ZGf18gyGPMvrR6WjLBUqlYsBN?=
 =?us-ascii?Q?sC/vxfp+GrM5HtYeLAIylDqeEyf4beiTyVU6H7im0mqGI5juIddQclKg2N75?=
 =?us-ascii?Q?KP+LyJ5TqnMBl0Upl8YNlfWJHngDOQzBMgMyzLzeQf1nQ2jHqBB6YofC+xLC?=
 =?us-ascii?Q?z7pxi3byBtbpGyYkRi7IWdUD78MQCBET8Q+puYjF1Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	3606d9ea-c027-418a-50c7-08dced0eecca
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vj8nrLBWt2ATYAXq9k2ZZCmH52ICG3AxBetz74Xx6fC9ughEALb3pj2ioaBp?=
 =?us-ascii?Q?Zr0PByjr2890oRuGT344L8XyzVloIkwJZSCdaIkSGzzylJQS3Jxg8ndIyMQf?=
 =?us-ascii?Q?sziuIzrEwoiUiJqcq6E91UVUji7HjKCCS0KZJoExkgI242ITgt+WHGmOxe9k?=
 =?us-ascii?Q?QRCmPHp7ubPq43qnJWsqjcxCBCHBHVYvAtPbG7FPtOWJKPLa9tWa9nX/zdMS?=
 =?us-ascii?Q?RJD+GJoq7tBjwebcqHRB/oUIk9t43ekN8ng7DUDWwjduoN//Y258GB0FBGQI?=
 =?us-ascii?Q?te3yO+GhpTkWBjK8Awu+BK9wjTtrWjbuYNcF+rvf4cFeD3waLE4T3V+riQ/Q?=
 =?us-ascii?Q?RNWzvbX2W8VioZWjjRuNOwjAwJqIzJ20bHt+cTNRlDw93pFIVxtB/vC1Vk4f?=
 =?us-ascii?Q?0fT3PhhsMI6mjvQNYaKDQJ8d6F0s418JzxzlVNu4PGY3URHUbEe3IZl+1Zz5?=
 =?us-ascii?Q?8VgRHLfCEJ6ogjq9Hh+UVOHeStRIl0mlCiv5YVyaKgORS2LOrIZ4+7NaLa6K?=
 =?us-ascii?Q?VFZ7kKS5cZfS0LRWPc6t+3WequLz1OOCDnxbLmqCiG7rT6FmOZ7rOCBkXsgX?=
 =?us-ascii?Q?AZ3N5xtRm/w1EoJxNiDNQK4AONyiACqGAZuLWzOQE4nNhre4UbGEkND8bG5v?=
 =?us-ascii?Q?8n0+RI3kQ43Ot5og2/fho03XxoGJsNh7CkqmloZ7RqkhBkiouIhmsf0pmXue?=
 =?us-ascii?Q?g9rweTjboPwu5ZwBB15kWX/g0cvhFD2xCz+ky3wV4usqZ9zX/nLwFh3SuwGx?=
 =?us-ascii?Q?mJYsX2ZBbm/uzPRoHYC0RrBpWwE+UDbWNFATJ/8ZabUhHWBRIp40GwbGkhY0?=
 =?us-ascii?Q?2O1pr5JshRw321bNuMhRBxuqLnucuo2GWZHH42ujhtc0U15VNnetL9E4Wc3t?=
 =?us-ascii?Q?PeiF+e8+prBtMPmPgoz8ZDCCaPaexvrx6zbQG19shSd2A3v610VKa6kPSnB7?=
 =?us-ascii?Q?vWXkGLOhMgy4MHQtF/h4gFIHA4mbFDQSW/h4UY65RH5SpinVZuNNv/8WN4RR?=
 =?us-ascii?Q?DgWCsdlRy7zkjBQfRC6JoJty3o0Lsk6a6WzF85ABSlALNAZYqAYOuZN0vrlX?=
 =?us-ascii?Q?gkIPHm2e4AtG8SBM2fP0L7uzBCmFa4+otDZUTF8Iduy+YCyUOfNH68o/kAC1?=
 =?us-ascii?Q?yTeUxl5L8wii+B5go7VqGb/AMfGGMgu9vb0p8NkU5dwQh66rrFjlkgNWiIp2?=
 =?us-ascii?Q?F1Q4al5eOgFIuywiRcdLIoSrC2YqDZduRU8TQvsmPaVKdys8bjJhPsnyFYc/?=
 =?us-ascii?Q?raD9HINZxrk3XO46ZmsX0DSVcs0eaGTE++01pDqAbE/OypiyossJ9lHg32Dr?=
 =?us-ascii?Q?6TZmvxzfDmf7vbdfaJKIKholzmDGLr5vYpb9TLkFOZBNLwb57qbl3pqPGgrJ?=
 =?us-ascii?Q?TlBOintFkUKcNlU/ZsYNC6qy5a8T?=
X-Forefront-Antispam-Report: 
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:45:59.1656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13296e3a-8e64-4bb4-17bc-08dced0ef01d
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5846
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----320B66FC3B2EB60F39B71215DBEEF457"
X-cloud-security-sender: alban.bedel@aerq.com
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: alban.bedel@aerq.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay26-hz1.antispameurope.com with 4XSXNq2xZRz2yBHK
X-cloud-security-connect: mail-am6eur05lp2113.outbound.protection.outlook.com[104.47.18.113], TLS=1, IP=104.47.18.113
X-cloud-security-Digest: 16c86c6a4d366643d0f77ca0df46dca7
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security: scantime:1.881
DKIM-Signature: a=rsa-sha256;
 bh=Euvk+btajJ+ANtplS39QluTj99hFd6X5UBlDBb9aXTM=; c=relaxed/relaxed;
 d=aerq.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1728992768; v=1;
 b=D3VgcyZ8TmaiJpij3KCrIqm2pLnT/G7jj6Oi0CbOQJ8Zi8saiI3H6r9khg/Ic1klUtlKhN9o
 VkHjiI37jv2L6sEO1ARklVZ7x5Ryums3x74WRLpzApWT0GDtyHqAvTYdgubJPwYaD25La1x37il
 uCa7JfphGB9cw5UiaGc1iwQ3QpAi7vOSLTk7UcXDQlW+9SKxQ+jAvOqexGh/0oiTPLNMZMnQ7Hj
 ANCK03f4KP3/P+H+uibwTt5ZkgB2OPt0azfKXDb9Z43wFS5OaW9m0oOJDffVF1YhP4q5ylqmXom
 H8JLKzJgWWMPaW4FSsU7Fcbd+PbDakmri/MwwcONr2Vnw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Oct 2024 11:46:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16684

This is an S/MIME signed message

------320B66FC3B2EB60F39B71215DBEEF457
To: bitbake-devel@lists.openembedded.org
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][2.8][ 2/2] siggen: Fix rare file-checksum hash issue
Date: Tue, 15 Oct 2024 13:45:15 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
MIME-Version: 1.0

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There is a subtle issue with full pathnames being included in the
file checksums since the sorting might be different depending upon
how layers are being setup causing hash mismatches for recipes appeneded
from other layers with differing directory layouts.

Avoid this by filtering out to the path basename which is what is written
into the sig data anyway later in the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 65ca0811d58b..8642e07f0fa0 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -904,7 +904,7 @@ def clean_checksum_file_path(file_checksum_tuple):
     f, cs =3D file_checksum_tuple
     if "/./" in f:
         return "./" + f.split("/./")[1]
-    return f
+    return os.path.basename(f)
=20
 def dump_this_task(outfile, d):
     import bb.parse
--=20
2.34.1

------320B66FC3B2EB60F39B71215DBEEF457
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
NDEwMTUxMTQ2MDdaMC8GCSqGSIb3DQEJBDEiBCATLzaYdDsHOPKxILY7r9IXpODQ
qSV/hQNVvZlUXGSuVDB5BgkqhkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG
9w0BAQEFAASCAQBqP/QTp7CiBMoXszsfdJM44EUrRopVoMK2JlbKzo8DLIHBk0Bq
9IXbvFOhd8RxmBUWbQYdigg+BYZZa6itu5A59ASFU0SkXtlWWjvGVUZlUhcqeA2k
js29A8+Skue4Edt9pa/Sh+U7WUE4YmRUXf2LQ0PloFYFdq+oJ9ZnKneSXg1PNz9U
JWKRf8t5Du1nghY10rW3GCzibsL+1DD1r/v5A5CfsQ2InWKyB4VkzHYj/4zwt2Bd
hrBeB78ASZk+Jc1eJUZ+5KWlnPLp6+GTO7J/utL3EhiCz4FaLv9+9hDusqXcyOSn
7RFDFUnRjm60gTCJERQeSWuE0EWLjhhkGobc

------320B66FC3B2EB60F39B71215DBEEF457--


