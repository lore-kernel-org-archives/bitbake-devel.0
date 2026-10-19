Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38570.1792426379987651604
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2026 09:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=GzimsExQ;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=GzimsExQ;
 spf=pass (domain: arm.com, ip: 52.101.84.19, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qgKuJqoQqhTLYMO03CiSAJSAxgvAnF0oLKd3MMrz0Tp/iaDURK6oUiGOjALlYnIK3BZy7KlxkcQLwFmdf9jR6z6d058Avb7x9jySnbw2iYh3au1B5LgzmudzPLfKo2o6MnH+/1Bb1xOqnnUssKN6sQS3UYMCo2YrqpxaSddJmuBHt5Jp9XOTmNz3Ym8/jDqoIur7f7YFF/vQZT5DQ5YC32L3+9rbmyUVO+R+9kjKf/rnRxENnKbGzR+l0GrfC/ImZLuhHvVzjQbZ21av31p1Xee5h+FmrVP8M2f+1QVwETfZjKkWHiNep7EOrdXJ9NT0AfcIOM6u+jFcDDGl21u58Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fWgnWJHwT9fMjxxbMN/IzL+Bp5NCIeChlMiG0qY3WE=;
 b=tKcrEo5oI4Hz290aYoRERknWNmtk6+MFWR6sDaUOfX+NhCetdm9ix57+1wrrm17iF9Ih6ua/Dve2gVqgf/szidbUdk4L+Y9oImd0pcdx3hXBgk7pn9qzHgGmIFwNHC0qehAGb8PtUmQ+2jcUz46mjm8TXXKPtNxQ6sM3SgiSLOI7397hKbM2Ak+jmRq1eBRz8o+b6J6vi7RWM1lkotrDoMlP1UsiWY2w6Gf79KFVUSNhDQp6qU8HcXVPiLDceR2gjK0DRP8dtQwP1+R7B80AtUBt0JmdhMjwZnFW0bDB9cLhzvB/ZAKIxTc6pwGjH0Np5ilUvHc8wAD+FHnxPLp6rg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fWgnWJHwT9fMjxxbMN/IzL+Bp5NCIeChlMiG0qY3WE=;
 b=GzimsExQ5M0YChiXWIkrJ3fvpz6lFqyPtgOjvX7JidxFiHkMbRdJUs5KdowIBWXHHJHFYyFKAwEApeJQj3wibY+9M/kVxouEVwLZmi2JPBLqtM+pRPPo7k98M9KfN8I7Q37cnZEzbgmxkyj/1PCK5DlXlm/njCgBc28mf8Rdkxs=
Received: from AM0PR02CA0116.eurprd02.prod.outlook.com (2603:10a6:20b:28c::13)
 by AS8PR08MB8394.eurprd08.prod.outlook.com (2603:10a6:20b:568::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 16:12:49 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:20b:28c:cafe::5f) by AM0PR02CA0116.outlook.office365.com
 (2603:10a6:20b:28c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:12:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 19 Oct 2026 16:12:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeK2u2BrTr4wUFu3z6gwZFt8Je64jJJ0iyGHQKGdelNcIcCTvW6kuPJtTNnd1VHk+SJAyy2zT1BT7eTqN7KIRlTRmMOTLhMkQbLoi2pJ5EyH26p2HjMykFHfJYxuYF3/2qwya6vjiFlR2okQx3iqSOdkEXM+0vC5PmicV5M80L+9lZUqtKrJwA4BrsLSK55l8+a/5+oyAcCKx9xCn0sRjrx3pH86t0QfHYBzYqURMMibvMBUP18/8TJo0zFsFgwHNe6D8GbEieytprnUTRXQzVbjVqs0QZ9mul2OYVdoqPHJBXh07eUDYkEIlwZltstkrro2RzqXSPLzBrCpqEnOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fWgnWJHwT9fMjxxbMN/IzL+Bp5NCIeChlMiG0qY3WE=;
 b=q7fRdLd6yb3uplXDpTo2jfaKMG/Uwq0n2Mk+GCXLPkLnvQYXI4lY0tzigGcNJIZckrRHA9xYNEOv2e2k2VxdsrPYy4jofP4vN0GQTYDgom0YxTz5vrPNkZA/DlijhpyRNdz2hEG4dJFMCy5Y57nPuY6Fano7uN+SxLA/Wn8neIhHvlMVWntX9fuSULIs3sx7yhOvyYSKGSWgp9KaMD16AI/Aubkj0Xo5DY47vCOvwsRG350IqpHSTWLiwkSsEoWNnMC1z2/UKeclJk+oOUQkZISLgi3nFx6vdgFMcO9/7/QBeo6f9KdpRvQzLrI1fuT/8mSz6D9C+QIF3Oxw/DOBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fWgnWJHwT9fMjxxbMN/IzL+Bp5NCIeChlMiG0qY3WE=;
 b=GzimsExQ5M0YChiXWIkrJ3fvpz6lFqyPtgOjvX7JidxFiHkMbRdJUs5KdowIBWXHHJHFYyFKAwEApeJQj3wibY+9M/kVxouEVwLZmi2JPBLqtM+pRPPo7k98M9KfN8I7Q37cnZEzbgmxkyj/1PCK5DlXlm/njCgBc28mf8Rdkxs=
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com (2603:10a6:20b:5a9::13)
 by MI7PR08MB215279.eurprd08.prod.outlook.com (2603:10a6:290:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 16:12:15 +0000
Received: from AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb]) by AS8PR08MB9410.eurprd08.prod.outlook.com
 ([fe80::1f2c:bae7:a4d3:fefb%5]) with mapi id 15.21.0546.006; Mon, 19 Oct 2026
 16:12:15 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "ticotimo@gmail.com" <ticotimo@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] parse: only search each BBPATH directory
 once in include_all
Thread-Topic: [bitbake-devel] [PATCH] parse: only search each BBPATH directory
 once in include_all
Thread-Index: AQHdX24vqmcm7AfrIEygRM8L5/ES5rcFCk2A
Date: Mon, 19 Oct 2026 16:12:15 +0000
Message-ID: <6C7FAEF1-2BE9-4E2C-B2DF-A037491D00D0@arm.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
In-Reply-To: <20261019020422.14365-1-tim.orling@konsulko.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.1)
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB9410:EE_|MI7PR08MB215279:EE_|DU2PEPF00028D00:EE_|AS8PR08MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 1999468a-6c07-4d8f-5029-08df2dfbd1d6
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|11063799006|38070700021|56012099006;
X-Microsoft-Antispam-Message-Info-Original: Up6GGWxOFwRHFXloDedITtTXZcUKXn8n7Gu52jo+HVaqhJZFGdsq16HrnGNzmyQovfRv7AiQW0ElXSjpBePKmJOxCof5CxRIhr9wviBx25wX3JH6xLj/aXoCOVWV/EvCQ7ERhV1ddYDMeYz/7RAU9PCicFV3LDtbHju2uU0NI7iEW2IHTweBmKG3/Azns4JJxy3+aaOCEroaX0C/0zMspKxbxjB08UgmoijGEmTHfpSSIdX0k1FO8u77Iv+qfqMwSKFNtTZ3iwcK9ASPFsyQX41gk2HOk60yZbPnl8+OXAXNxE/Uk7c+yrxjBglmcIpf8x6XpG74TFuoXQfCygjiEUCOL4hjUUwZRfjRlj1S8ZNZ/CWCqwlpv4vvI9c8zcq22QPmEffxiM48rq9hunPbNhhpkFiEGUYUYjHV52c/6qDjVE/xV0d0HjrJrGzdfzPD8tNtnUZkRxOoxQ6mKueX6S4N+PjYTrYZMz0wb7e6ITbL2oLXhNDooCZxdCWVBa02mYNzFlUoY64cJe7xpXOD4pNj7sWDQ32+cELh7fX/wARl88qYklsD+qxGrqaKvSUT12YggMZJp2VPd3wrrDpZCXmWnXA+qCfUS/1BYNyVidSRzsqGEWmyULBd/Aj4shC34wzyK+m8mxb5rJR84cV35eFEArAoxbpjQ6HGyMx3H3oECrod8XkUt6zF35N54t/a3RQvV2E6/L9qKnFJRN5+GKNi4llBRDZh1/hxJlja1UM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9410.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <479D1E2B642C9D40BDDAF7E4605D1F11@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ifS2Vwa1whH/iUPW3wSoyl3m3bGe2Fwq5FlszTUa3bdAkUOhWTaDgL884S4a9uMank62YsLQNtUFtT6hZok5uqIYoRDrSyZ7ddqrtoe14Ku4beBewvt3pITgKnZ92AF5Z9bK/9aGdMVRG4HuBkB+atlA/Qu1Y/vrEMYGhYm0GCl03ZKXrqvPqUC0E8NCefJMe7M9Z3nw4Nb/ca5nOaeTGI5j2RmCnZN8SAG5f8HMoCUm4yPeKTa/3n3rM8FwOKVTgfd434W/ixxye8ZW1+bCFggKSaVQcQM7tDdWxQooerRwG6o8u07GB+kuG1iHEEjljSTb6moXqGdAFB75FU5vnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR08MB215279
Return-Path: Ross.Burton@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ea19e89a-18be-4630-6a67-08df2dfbbdce
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|35042699022|376014|1800799024|14060799003|23010399003|18002099003|10067099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ph23eKzrzvTtjZAm1bC0bHTPWeeSLqfwr2jZdDfv88n9fuDYRdnjhaNJCrQRjW41wxgVp5uBh8FGE7xRmfVk2i5YrZJnteKlGvBqgLEinwslXMffnlwBXiZzypl6GnfNuGcJKvYeVTtnjMVqleH7JFmTs3m6zL/SFGDg0R/AZC+ir8eTMlegVpL4pLBUXjqAil2lptmuG2S4KzIr0fQZ22Jr49Hn3igRwsDFZXRVzqJeV7weLusvkLF84xf/q6vjVRroBYVDspwqidYQGMj2+hiLZX8juOwhlrHeOlb92iIHA9uoEbDz++sT/kMWL7eQcL7fkEwhoJfkvqyal622diRUhxo0uzCwufDhZT3rdgz5wCZ0L6ZeU4wEyb6NgxDi0XrpCgajMlKnZGRMHrasUiI1cGi3sGd4zlAZmfzlUWYpzM/ct+ChlPZFvyPcQzvIHIEY8NFwTDA4x4EC20B1/Cu6i2niUrni+gkqYjz0EmWBQNKa2IozpSRSKNJoB8WR4jNDlFG0sW6e2D9XalkEyvk1Y75wOpiM0htq7VeDQqYAPnrWQcizU5rpkf7TV6jmEAI/ZatocRgQs+AJMg32Jr23jA/XdNvJcGdU9JEVBRcooz49LeFSFFCkYmVXHtoBGq6WFO8Y4mxHjc7FBMN8WDygnpbZqIWBvmOsqaUJLEs4cqe/2bP/SCyhnojgghBQDiLRP5JRr6zPYJApo5KX8g==
X-Forefront-Antispam-Report: CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(35042699022)(376014)(1800799024)(14060799003)(23010399003)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MMQKil9ZREr2McKAWjrOBbU5FYpc+Rwwj5ldy77qMQRfNcjOB8HWvtQkykc3004XPRUlCPJiZR8JcfYbU5FGrYdtzEk6Bo2F1EfQbgg/2gQRLZnauKw11OrH1ortFB1PfKr0JSTPk3mXG5ymVJClEFv1PUVKaNdDsRi8sXdrEXubQ70++Vsa2uwzrZOJnQASm3zeN5HPHA3RUcxw4m92d5NxOFWAapDUVm2Ny3xT72RqIqTmtRNvxGtIw0+qToC+2Oas3mgjPgVMqpo6v6s+eZe3k7HRidcidD4QLHNoePFSuggeF25LI5PA/EimRP3IJbvOrbPDq+p7jFfFlwHahTQ4hAZbfukaF6RD9PIpNtP9qLc4mdwFOT7nZmVvMfia4YHrPVA8q8ZlLGF/HqWlvGaDOrWMFx4tKlweGgq+/XnmPj4riZRYlY1C9vJN6Sti
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:12:48.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1999468a-6c07-4d8f-5029-08df2dfbd1d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8394
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 19 Oct 2026 16:13:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20361

On 19 Oct 2026, at 03:04, Tim Orling via lists.openembedded.org <ticotimo=
=3Dgmail.com@lists.openembedded.org> wrote:
>=20
> +        for path in dict.fromkeys(data.getVar("BBPATH").split(":")):

Feels like using a set() instead of dict.fromkeys() would be neater.

Ross=
