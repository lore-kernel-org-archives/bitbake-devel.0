Return-Path: <alban.bedel@aerq.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E7CFC299
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 11:46:20 +0000 (UTC)
Received: from mx-relay94-hz2.antispameurope.com (mx-relay94-hz2.antispameurope.com [94.100.136.194])
 by mx.groups.io with SMTP id smtpd.web10.11329.1728992775315232563
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Oct 2024 04:46:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@l2task.onmicrosoft.com header.s=selector1-l2task-onmicrosoft-com header.b=Xutub1dq;
 dkim=fail reason="dkim: body hash did not verify" header.i=@l2task.onmicrosoft.com header.s=selector1-l2task-onmicrosoft-com header.b=mIME4+qk;
 dkim=pass header.i=@aerq.com header.s=hse1 header.b=dIFj3tqN;
 spf=pass (domain: aerq.com, ip: 94.100.136.194, mailfrom: alban.bedel@aerq.com)
Received: from mail-am7eur03lp2237.outbound.protection.outlook.com ([104.47.51.237]) by mx-relay94-hz2.antispameurope.com;
 Tue, 15 Oct 2024 13:46:13 +0200
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=lGH3fpYs4rPWCO1HS4ppJy4bPcwf2Xa94dsejXgbXZ5BoDEBGFLWfIdi1thTM5gLRCTFEcE8iRC9BAg012TpF0aL9wxV6Ru8NU2o3iWjgsdUUGCh+i0X4ibDZzSETx921mzvGsRD+Jy+6L4kCbZg2Ow3rPxC7+xAqglBUaR3cLu93XHfFYwlnWf4PT6yXsi0Gykht+9POGrrH4vg/CbF5dLQMY3H5hc+4d7jBTPecsPaB7Lp9liimOfSH3AghC4BtvPKtULtiuZ9OXPr3wsgqSH9ZT5ckcJZoKwRZ7+buJlXGvaLC5wFveTo2cjSzSjS7mdpv5r6ehqYW2GA4FonBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fVOwhGgMB5kj0ydKVNfY2HXGP1pqVG/P7tlnzLO9pw=;
 b=ZgqzbCzjuOC5yT0aN4gZwENX9zY5w3tC+qCpefsTPH6qIE9GFnU4UWBJLL5QMt7eA2pa+ptaqWeBO/l0cFY7hirwneExjxARa3CVGH5EZ1O8IonDe26ScuN4J0BsePItFZbKLr9f+DJ0CUQQxSEVwlp6d7OZ1rbSsbkN5A8mUtzT4IKf5cFAUp/E1VYNqd0FLI1mOFM2Ud5gz8GxCs1V2Ha0TpiLQw9mFsA0R9FZeXyZp7xs/rjPSTezeHEOqiJtWiF4Pc5TGSxQXbqUVD9CnZDIdKEgcxw791u4yurVBHIuGtAEWlu4tKpoMZdlz8VfEkjdLfQhtDOiSLWcatKufg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.40.229.156) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=aerq.com; dmarc=temperror action=none header.from=aerq.com;
 dkim=fail (body hash did not verify) header.d=l2task.onmicrosoft.com;
 arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fVOwhGgMB5kj0ydKVNfY2HXGP1pqVG/P7tlnzLO9pw=;
 b=Xutub1dqu894MAadytCr7WhISTgznTTVVl4Y5zymO9te91fW/tc2ywfWGUvKFd9qiYlrhCIBCHw8CvuqAqD2gmiVppkSgKhbkQVpzJhz6+dq5J5XUQHDNFF/5npn3RvZZdTEg5wYfalC2EF3dc6qGplIReklMA6ncLtVcZJf4KA=
Received: from DUZPR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::12) by AM7PR10MB3157.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:105::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Tue, 15 Oct
 2024 11:46:03 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::38) by DUZPR01CA0176.outlook.office365.com
 (2603:10a6:10:4b3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 11:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.40.229.156) smtp.mailfrom=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;dmarc=temperror action=none
 header.from=aerq.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 aerq.com discourages use of 104.40.229.156 as permitted sender)
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 11:46:01 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (104.47.11.112)
	 by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Tue, 15 Oct 2024 11:46:01
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 4823145
X-ExclaimerImprintLatency: 481523
X-ExclaimerImprintAction: cb85e160023a4bd69b2f70e063af1e1a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLffBDEiTJNl+BOTqSMlicvO0+wyncEuWBztiH6rvU3+xqrh8ylPIssoOUy30WRtMC5/Bn5W17yDvOOIQuw74A4G65MQ427Mf54n5Bjcqu3ZlczrYbeZbkmF0T43C8mgJU0qcEOf514aHdNg13hjS5bAjCkr5Nw3mayp7NOyPyUMD2OUi8AY7b7dWYmNza3tvTFj2U+dwWChyPAZOd9rhNH9dmjykZeMrWRRKr7EaxrTCU2gtgplVQs18cd0ttYo9UatnJJKql4dMQ+3eSjRIGnTQUL/r/qjpiwZoDCCSD158JV5wm8Qnz9xoI/xXamfIDLahyokIVjrA/jYnTcfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XutEum3sEpOstURazXg0Uf+pxB94uihVamBcHQN+kL0=;
 b=HjdwyiXS6Hims/oUxpx+fZ37w+8MsUOUWslF7Ku1m+S2aPFVGlGW0RxqtHZYMf9Cx8CdY7YmjzUvG1YNpj3PfOAIe8uuNYB6hyJf/opsQgB1r+7F4LKN70wNrqFy1ehtf0VMeJW69XoqgtyjRTtne9FO1HW8CcpwtaNMYUc599j0d7hvXyCoEF2/pzfINQMWT5ZKYozd0AnGSQGrGM9iGt4W5m/NLLedoqW5WIdr1BV6VBBBtq9JN1jMZFyZfm+LEs2FeAbdoAoUTQcwcqou9wBwsp+IEk1muVKpxAkyrGTdVjaz8gtJQDQrxRjE3b58pWY/fko646VqcyGHn8zOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XutEum3sEpOstURazXg0Uf+pxB94uihVamBcHQN+kL0=;
 b=mIME4+qkQHpHKpXDknZnH2IyFon4dOQL129AJYFZHzkSeuP4yoQe6o2Dhpo5tiiisxGTMoCYDCHdvU+lUAum6W3n2gSGFbB6gpH4mZhQQXEEdfR7OuJf5+JgbEXmvzxoxsQx1krYZK3uVAUUR1jSlq2pgH0QPEg7dJ9GcuvD2X4=
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
CC: Alban Bedel <alban.bedel@aerq.com>
Subject: [scarthgap][2.8][ 0/2] Bug fixes backport
Date: Tue, 15 Oct 2024 13:45:13 +0200
Message-ID: <20241015114515.1331555-1-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:405::24)
X-MS-TrafficTypeDiagnostic: 
	AS8PR10MB5000:EE_|PAVPR10MB6940:EE_|DU2PEPF00028D12:EE_|AM7PR10MB3157:EE_
X-MS-Office365-Filtering-Correlation-Id: d65d89ab-200c-4c3c-628a-08dced0ef182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|52116014|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?bURLc293NHRzRXl5U09uYm1RWXdjZkpRZTlsV2MyVzJaQ1JIeHg5NmNra2l2?=
 =?utf-8?B?azhKTVJRZExFSFIzZU1qdk1GZVZRRnFzRHJ4NHhtaGhqZElrU1YvNjhDTzVs?=
 =?utf-8?B?RkJVOUdwS2NlaWxURXJBUC9TWk0xaE1YYmxEMm1EZUlnaVZCSDdUdmhHdUtZ?=
 =?utf-8?B?aVpHeGVqd3dKNVZxVXNRT3FyN09qLzIxWnJNaWdkTnBNMCtKNU9QQnZMMWh4?=
 =?utf-8?B?cEhIcVArUjdkR3Y0UDdCSHBJeHI4Q0ZOa0VDK29Nc1ptMnFzWTdCY1RwT0VI?=
 =?utf-8?B?bVJ0Wkx1L0FRZ2RkdFdqSWJyKytHdUxWMjRwbEFpNXhySjBwbmpFZlBodnBQ?=
 =?utf-8?B?Z3ZPNmZWN3JoeGYwK0hTTkoxNTZtejlyeVdLR0ZSVWtKQWlmM0piTUZ3VVlL?=
 =?utf-8?B?aGpaNExJS21kenlqTVg0ZER1SUplYUZoWnFIU3JqdUM4Ujc1YmMwek1hUHl6?=
 =?utf-8?B?UUFCMm9iZHhQTWtWOFZGT1o5UVpsbzA4SXpyS0RMZjBhQWVSdEp3eENwOVY3?=
 =?utf-8?B?LzRWZUQrc3lKNTV0WjBDNUJhT3d0OS9MOXRGUVNXOVN6RkgvVC9lN0NMd3o4?=
 =?utf-8?B?V1dPRVVQSUZHSTl6OGt6Z21ZTWdoVnVQU2swTnNPeCtmVUJEUi9EK1NNeDBF?=
 =?utf-8?B?akpQN0ZJRE52WCt1RFkrSUZjQWRBM2xRcUk4LzllSUIwUks5LzRLaGdsclk3?=
 =?utf-8?B?K25ueE5Ia2RTK3U3Sk5xVkNiUWFGWUpPOHFBcGdDQkl5TzhzY1JjcENtWHRC?=
 =?utf-8?B?RHpTSmNMOTdkS1k4RVBtM25PQmsyN1kxeVB5VUlZOHJ4QTdJaXRrWGpGemM4?=
 =?utf-8?B?RGsvWm5BZXRyTVh6VUNpVkp0YjZ6SFBuRGxvYS9Db2IvSEswU3EyendPRUpi?=
 =?utf-8?B?emJNTlQ2RWN5amw5cE1abzJycXJjR3J2SEMyK3ZzcGZsck5pKzNoa0Evb09B?=
 =?utf-8?B?TjNjM3pYMk5TSlIyam1WTXVNbXhrc3dqWlJ3cjZjL0xwdnZHam5lUVA4bkpN?=
 =?utf-8?B?ZFBzeHJBaGJLaHUySmVsVWdBNlFXYi9CTnh1THFnM2xHNHA1NFVKMmdpM0pK?=
 =?utf-8?B?b0JQY21mZnV3dnlpY2hyVURTWUJ0UUo3NkVZQk5CaUxaTzhocGlvd3d4T0dQ?=
 =?utf-8?B?YkFONXFSWVVLN0huUFZLb3FnZ1VEa01KOUdSdzVRNkdsdlcreHZLMVlqMzRl?=
 =?utf-8?B?OU1ZL3FoYTN4Wk5vVnBRL3dPbDB1ME1aVUQ0Z2ZkVHI0NVdWbm54WjFtazFl?=
 =?utf-8?B?TWV4bmx1Q0NNeTJBNEVHY1d4cHdYa1l5OTQ4VkJYUUJJdHNtSVdhUWg1Y3dE?=
 =?utf-8?B?OUdzbjhNSm0rR0JDRzY3c3VJZFZTU3MrWWNnaWtrTGtEcEhLc0xSVWZDa05k?=
 =?utf-8?B?c29nSGpTdnJPbXpiRjZwTE5DK2VYRG9aUzlzZ2g5SFR6ZHFxb0IrOEZPZVg4?=
 =?utf-8?B?N2FoT0tBM3hqbk14NEg0TWUxdUF5TVBZMk1kcXhCdVpoclQyTXJKOXQ2akVK?=
 =?utf-8?B?Y2pLVVdrelJOdUJZZ0pQSGJETEJEaFI5RENMaDVHNVhvd29lWHZlVEdRM3dR?=
 =?utf-8?B?anoxSTlKZG01TkUwRDFFZlJnRUQrNzdVME1uTDQ0aWNnQVpsWGd2UEIwMGlr?=
 =?utf-8?B?WnQwV1JqSHYyenhLSnJsQ0dqNkI2cW90aEZmQlFIZHBKSi9YQ0VZNU1pM1lO?=
 =?utf-8?B?c0NnV1BPSmdXcVZkazF3cG9OMjd1SStyNmlDTjFBREJ4ZnhEVldJeVJBPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5000.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	1b33f534-4493-478d-b92b-08dced0eec38
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|35042699022|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MkhJOVo0SjIxTHpZbFJpRkJyQ0cvTXhGYUlOcWVSeWtTaDZPWXFaSzdXYk43?=
 =?utf-8?B?NjQwdzhYUDlVZTRjMlYwTCtNYlh4cEd0MEJqbWpaMmJBbnBaRFZZeHUwd2FH?=
 =?utf-8?B?cWxZRG1KNm00b2gvdU1VWTN2bUZ1VjcwOE4wcUFMUGt0MmFGVFBnMkN0dmJK?=
 =?utf-8?B?VFFnUWpZV1BaS25zTUNLS081Z0lUaWxkMWN5RElYSnFzZEFFSzhnN0lvQ0s4?=
 =?utf-8?B?c1Y3VE9aYm1IVlhCUnkzRGdsVUpsZmwzN0RLaVUwWXVzMjNXeUZBWFRmQ3NC?=
 =?utf-8?B?WVhYMElIVStla2RpemJzZ29YR3BkTXJLbXg3SnpXdmp2QTNzVlliSkVadGMz?=
 =?utf-8?B?UzVWY1U4TW5BK2JrQVZBamJnMWkyU0E2b2N2K3RWSy9JRXRIZWxLQms0SnVN?=
 =?utf-8?B?Z0VhSUkzKzIwUUxlNWpoTjcyYXIvaEllRlNTVmd6cW1CY2JvNW1neWQ1U29a?=
 =?utf-8?B?UnBJNExocG9ibi9NVVFrT1B5UW14SUNiY3d2Ni9tdHcrZmNmTEZyM1VLRnEx?=
 =?utf-8?B?RjgybytvYjh6T1Z1TUFzUW5kUkZhNjEvRnp1ZW5jNXJVNnZraVBFM2x1aHpI?=
 =?utf-8?B?QmF3KzhBOFhmdU5aOE5kbFVOeUcrd1RZTFNNaFd2MzBLMXFNQW5IN3BIb256?=
 =?utf-8?B?dFdlVnpmOW1taFhIdm5Uc0d6MUg1STlzMEpKOWd6Wjl3U0I4RFdWcW05L2c5?=
 =?utf-8?B?ZFRHYWF2M0xvTnNMdU9tRzJBT055d0FBOXhOUU9zRElPSy8zV0hNT29JdEs0?=
 =?utf-8?B?WmhoTnBLWDdIZ3ZkQ3Y5a2kzQVMrNEp6dmZOYm1RUVNrdFhyU2ZQUCtCQy90?=
 =?utf-8?B?c1U5ZjFKZVRSQjRqUmJvUkVPcUJvZ0pLUjdhS01hMXRYbG00d01nWFgzQWJV?=
 =?utf-8?B?MkZxMTd4VVpWVzIrQTkzczhEN21UMjNBR3p1VzF2WmlrZUhtUUtnSXlHUmlj?=
 =?utf-8?B?bEUrRnhXc3k4YnJvbHFMNUY3bllLVVIzTEtaVlgzN0xySkdNU3pEbEs4bFNZ?=
 =?utf-8?B?R0xhQ245WENheVloTzlsS0JSQ04yb1Mwc1puck83all6bzZmTWlPRTdubU5J?=
 =?utf-8?B?bjBDOS9ESCtDa2FId2RPZFhWNXhPNFBNMGpmK1B1YXZrUGhQWnhPQ1B6RzBa?=
 =?utf-8?B?WXIrbnd6TmUxdGx4QVoraVhjMVJOcGNQYngyTDZleEU5ZStVQm5uVjJKNUg0?=
 =?utf-8?B?cTlSUVU4V3R1YjZ5Z0UvRHp6QmFCdWg1UDEyZlZVdHMxQkprd2phR2trNDQw?=
 =?utf-8?B?YysxOC9wdzFLT2xBcWFobk5WK2NTODdvYi8rWnVCaUhsRlBrOFRnb3J5VUJP?=
 =?utf-8?B?Z2RDVWhvSHYrZmNLNXZtN0R2NGRVVzBSZXNEMlZINC81SlVkNmFDVHRTLzVS?=
 =?utf-8?B?VWt0V0QzVGVOTkExM05tVnFKN3pjOFNhVjI4TnA4bFQvNVY1VGI3aHhwZGpQ?=
 =?utf-8?B?VXAzekdvcEN6UWJwSFJabWU3U3c0ODBZNjRDei9rK3FPMTVOSXVyNHk2aUk2?=
 =?utf-8?B?T0J1dURLREJxWVhGZENsODdFTkZNZmQ4U0Zwd1h1Z25CTFZ6azZWT041b1JD?=
 =?utf-8?B?QnVUZDRvZ0NyZjJGMWdFVWswTWt3NFJUUU5vanp2c0UzSWV4TWk3aE4xQWtX?=
 =?utf-8?B?bmVNUTZjY3FnV0ptZFgxSzdkOTV3U25XYXdtRUhqZllBV3ZORE5yUWJJYTBo?=
 =?utf-8?B?MU1tdTZXdlVBSC9udG9xQTV4dDRBb2RIQ0tyV0lYMmkxVzdRUnBXWDgrV08y?=
 =?utf-8?B?TVZSb0NJTnRvSi9POUl4UUdSSjBLMFJYZS9Jc0llNEtLQ3pBNzlJdVExVThj?=
 =?utf-8?B?UE1XMWVRbWg2V0lLTUFUUU8rK05KVGxkYUx1ZjJycWdENFdXZ2dEUVVraE1O?=
 =?utf-8?Q?5grX8qp751gjK?=
X-Forefront-Antispam-Report: 
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:46:01.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65d89ab-200c-4c3c-628a-08dced0ef182
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3157
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----9D6E9B7233899CE39F7D94679C3669B8"
X-cloud-security-sender: alban.bedel@aerq.com
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: alban.bedel@aerq.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay94-hz2.antispameurope.com with 4XSXNv086cz3dG9f
X-cloud-security-connect: mail-am7eur03lp2237.outbound.protection.outlook.com[104.47.51.237], TLS=1, IP=104.47.51.237
X-cloud-security-Digest: 0448bd73a9ca84a020f17ff3ff4a672e
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security: scantime:1.886
DKIM-Signature: a=rsa-sha256;
 bh=OE5kX1l6YaTh7ZCCVioUX0C0bo6fUZWw1C3UTm4VuKA=; c=relaxed/relaxed;
 d=aerq.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1728992773; v=1;
 b=dIFj3tqNCKdV97Ne4K9ouuhDL7ko/DWC3QzKb/yBKeFSBiTsZxxFcV2GlqfkJcU+WHzMGvnL
 cVDbDdwQn6PzSVck9hBCnrwR4DF2JQu1fEJWJTu3U51oTeEG4ojCljK2raF8xyNfLXoRyBEJgVV
 +XS4AagX9+xCZibtG/geWyryGzSV/hWoGhP56/mTEhC8ekNjp5hC4q0l/X7YkcBYwemE0fHijYW
 ximgARbvnb1yL64p7/Dcc/CVFaA6y+O2AvvN/HkXH3yHCmHaI+cDU5wEF2BVK0Nn29rn7rla6/D
 BCeMO1kDLf5P0NZie+WCuPQeHPKnZ2p4Q7OFP0n44LQiw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Oct 2024 11:46:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16685

This is an S/MIME signed message

------9D6E9B7233899CE39F7D94679C3669B8
To: bitbake-devel@lists.openembedded.org
CC: Alban Bedel <alban.bedel@aerq.com>
Subject: [scarthgap][2.8][ 0/2] Bug fixes backport
Date: Tue, 15 Oct 2024 13:45:13 +0200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

This series backport 2 bug fixes from master. The first make
`bitbake-dumpsig` usable again and the second fix some potentialy
huge sstate mismatch between different build environments.

Enrico J=C3=B6rns (1):
  bitbake-diffsigs: fix handling when finding only a single sigfile

Richard Purdie (1):
  siggen: Fix rare file-checksum hash issue

 bin/bitbake-diffsigs | 9 +++++----
 lib/bb/siggen.py     | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

--=20
2.34.1

------9D6E9B7233899CE39F7D94679C3669B8
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
NDEwMTUxMTQ2MTFaMC8GCSqGSIb3DQEJBDEiBCDvqLWsWphALyAyML+C5UPkwZHD
CsnTR3UqFqMpWQI+RzB5BgkqhkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG
9w0BAQEFAASCAQAMYLhXTM1j6G23GYYphZ6kwxzzVmYapW1vJyXzW5asH2/GQSvR
ujvQ/cyHeljayEhtgNrlaQgDPDuXDHiw/3xqt7OD0tNEwxiLY1oh5cXSPiTIOlCY
28EqwzXQ/RWFHA2Wx6FwN7ms88I0mOL93SCiyc9oYNCMd0FY6teXLYzXFT/OeyLb
x+YzEaFmLs5bnsWkJQN6dh2DHcHaXBw57UkwGvXtJBkEyL6yds0yw19M8lTyZqEb
NIUFiPt80LWx3ws477nv+uf+aJ3ABFEXGB4dWno2ajcZf4jht97Wy/FQ7zVMg098
4MWbONIxS14TY9jPwYq1aTDmkE0576Unng+m

------9D6E9B7233899CE39F7D94679C3669B8--


