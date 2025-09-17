Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD6ECA0EE8
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 09:15:51 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.0])
 by mx.groups.io with SMTP id smtpd.web11.18566.1758100546762255301
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 02:15:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=rSMJTJj0;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=rSMJTJj0;
 spf=pass (domain: arm.com, ip: 52.101.70.0, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aD4tMdyq8Kh1vnhEED8pyG6ThB67Y6fkC0UJbdY8PF6Ass6UJPuocblIl2pSqJYxBCbE9sEsQkyfbX1q41wYUZi5RWJQu32PTbXWQ7R8/uNZM/aD1VeooQ21NeNvnRMc7AR/taByVGEJCaShvZicc0yNAgHivlNrtl0C4b6GfcqDf+87oluiffCoqBJkZHjp4plQJOor/YfSeyiOqGdK/Vr7ULJINgRS/Psx5cYuWgENQ3kupvuBAPQ0wCXxcSN3t/fpmx46T+h2zg8lsPNFni53N9PQ03SM5yb/gwWJXb0w8FPOtuNxBKPq1Fdwp7T1CkV2tD29bBg8UIiZVHrZNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN57jA+VNnxNfmoK7y2o7uDGDBMvt+sakte1SytOCkQ=;
 b=fjvJE/VBHw+7gTzBPoJxMAZB62GdPqI8cEW6e2sumHNzAShYFE39ktRwRgxgkq40vwJRkiS7/jE1MPaJGfjhVULAMKLwgH0PTTaqXH52kbx6s+ppBLqGO/ydr04o9QtyIRu3j57UIUT/KDMQLlAz/sNdOrgZk0czhJ45DU51YoqBJbpUs0AMhVvQiXzE7YKi3LNexlBHeuSwyfojrGvnirio4BrXklbDp/gZpOv2nONFr8cGpg3X+v1iYiOzWNdeOS1fBdhNpsJGtETI5iASNVyPVm0hY8ip3IIamgcLfff0fPSOYJQGzOBZlk4wQkifH6qrWdw4zJbIRjH+g9uEQw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN57jA+VNnxNfmoK7y2o7uDGDBMvt+sakte1SytOCkQ=;
 b=rSMJTJj0lZTqxGFyeK32wjWQpgfUQsokCTpxESNPOjaFM2WmEK9ueyaagoJ2JK3IXzU3FBTslmoJZuRqM26b1xFb4j89BLyRrVPS9QN+au7XBGpXTjekHLJ+E2TY2+rKvuKcSMg7I7zIqDLCdaXGOI9fnaQiX84uWkc6J5JmizU=
Received: from DB7PR05CA0066.eurprd05.prod.outlook.com (2603:10a6:10:2e::43)
 by DBBPR08MB10628.eurprd08.prod.outlook.com (2603:10a6:10:52d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:15:35 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::f1) by DB7PR05CA0066.outlook.office365.com
 (2603:10a6:10:2e::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 09:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 09:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmODlcfGLGVrFKgWMzOrCimSHL4w6X6TW5656+f1bY280e5Mb6UGdbIMh36GfOb6PHWI0DWaBby72Q4+pTxfMLWx5o3Z02EVag17lZRhcIBDjhyY+MbGvYUfCCk+XDnxCLyVHjUkhEfToJts7Q1W9tXqrR1rzVKZQIwNaXwOqGJFLD9b4X0XIa4eN0sFpI1XPGxV/QbRY15vKsY3BVLtkW2o1p+SIvTYC3iqGDKQ2Ldl/rABYG6mDxSDp/9eZzMtno9ac1UpCnxBGiWvfLkcHfYJAtu1mj55mlSGCZJREOjpjL1/5Vj6g4tLWOVTtr10CILwqNdlveY5ox8XUZBKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN57jA+VNnxNfmoK7y2o7uDGDBMvt+sakte1SytOCkQ=;
 b=rqGTObrkegPYVn1GgS2YwYXM5I3PIN1J0X2BtcFrKzTq7cUkEBX3sbY8oheiqFE/kObijHOmq3R78dfMVsty7XSNC7q3d1CuGB2e+VdimvtOlk0j7h1J5C7scI1XLPXGGKqttdy+B8aP5SBdYqih2Oq0sDjyrBrU3H5gtZkb8HhVORqN0Jlp+Fn7iUQM30V1ggNg+UA6tPnqfL5lwORfQxVzdV4zciH+uV9JWvUNDnFJ5FJuqDFF2HS2kvNvg/ILvbXBKMZ+jp/xLEoDgt+tToeYOvqWOQhb9vjRF1tABzM/Q6U3OReSKSGZBS+aRkfgDvtLieSjJbUfzHNli1PwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN57jA+VNnxNfmoK7y2o7uDGDBMvt+sakte1SytOCkQ=;
 b=rSMJTJj0lZTqxGFyeK32wjWQpgfUQsokCTpxESNPOjaFM2WmEK9ueyaagoJ2JK3IXzU3FBTslmoJZuRqM26b1xFb4j89BLyRrVPS9QN+au7XBGpXTjekHLJ+E2TY2+rKvuKcSMg7I7zIqDLCdaXGOI9fnaQiX84uWkc6J5JmizU=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 09:14:59 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 09:14:59 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto@lists.yoctoproject.org" <yocto@lists.yoctoproject.org>,
	"seth.raymond@matrixspace.com" <seth.raymond@matrixspace.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] Documentation around adding custom fetchers to layer
Thread-Topic: [yocto] Documentation around adding custom fetchers to layer
Thread-Index: AQHcJ0Uv5R0l4KWMOE6eTdelXgR+TrSXGH6A
Date: Wed, 17 Sep 2025 09:14:59 +0000
Message-ID: <9EEFEABC-1B2A-4C76-B0CC-0E0CADAEB744@arm.com>
References: <tEoU.1758053094260077183.1RYf@lists.yoctoproject.org>
In-Reply-To: <tEoU.1758053094260077183.1RYf@lists.yoctoproject.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AS1PR08MB7586:EE_|DB5PEPF00014B8C:EE_|DBBPR08MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb834b8-0d23-405f-ff9d-08ddf5cac170
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?QnB1R1ArMytBUXpGMWM0N0RDSDVVMkY1YUVOV2Nid0J4VE9RVmV0ZkExVktR?=
 =?utf-8?B?c0dxa1VEYzZ4bkxyRktWOW1mZHpDY0V2dDA3dHZBdWRoMklsaU9jcGdzRzVW?=
 =?utf-8?B?UHdCeVduQUpieXNwQzRGcy9xc2NyVjVnSGxpek1CRlBjQytBUldJNWYrQXVY?=
 =?utf-8?B?dldBcjQzWEhPYmtib1RRN1ozQ0VCWWl4Tk1ONXB1Y3NqQ3FNR0VVanh4UEZs?=
 =?utf-8?B?VCswR3RUSVg0OWNCVSs5d2c0cW1aYzRzQXdHb0NVajVQcnF1UGdCbk9XcStZ?=
 =?utf-8?B?cmRxZjFuVlg0YUtaalc0Uy9GQzZWc01CSFQ1TmdiMGFYTWNHOFpiNHltUkFr?=
 =?utf-8?B?SEV6YUVLT2V4UlMwNUFMMlRaTlIrZUtEeSt1YkpkQU5uSmh4bllUMDc0VGV0?=
 =?utf-8?B?NldycjB2M2wzd3pFQTIyS3VqM25tNlFnM3FmMUdrQlhxekk1MUovam9PMmtS?=
 =?utf-8?B?M3R4VDQzQlI5bldoR0wwMnk5RVdUN09iRUpmakNlQUFzTXlZNlZZZ3hlbnRW?=
 =?utf-8?B?alUyOEw3eVIvVHliUHdBekF5VzhJWE93V1NSYkdCc0s3RTFsM042ZUIxbkpk?=
 =?utf-8?B?RFBtTmd4ZkVnZlAySkxOb2RNTk9EK3A0NCtkeTZoQmoyWk4xcVNhZVZCaHFk?=
 =?utf-8?B?OEZnWGRDVm1lalQzYzlLc3VLY1ZnNWg2M3FLNFljWncxbzM2a2lUcnhXN3Y5?=
 =?utf-8?B?ZXdDWlV0UzhidU10RENYSkRnbFBsSytEeldubVpLRnVreVI2UXAvbjlicmpB?=
 =?utf-8?B?Q2d5Qy9BNXVUQmQ5OUdwQWRNWjBVY1hxM2xzMVF4L3JWZWRvS0hNaWdRV3ZT?=
 =?utf-8?B?TytxbE5mWC9vOGpqRk8vd0xFcGRaNmxUdWNqdUxXK3ovMnpjY0hVWkN3aEVq?=
 =?utf-8?B?WVJjT2N6dnBZWTE3ZytjVzZuRGYrQXJaZy9QZXhhOVJieE92Q21ub1E5ZjlF?=
 =?utf-8?B?T0NKeG92ZHBjSWtHNWdrSzN4aHA3RWpEU3RSUTBLNEFlRDUybDJrSDdxMWYw?=
 =?utf-8?B?UmJvbHpQd3Ztc2xic2xuZktXQkJQYS9wWVBvNUpCc0l1bFBDMURMcFVNWmoz?=
 =?utf-8?B?aFpoRzE4bUJmVDJkRy9tclNtTFdLTEFkaWk0TDFpS0ZuU2s4TkZGUFJKelBJ?=
 =?utf-8?B?MEE3czgrR1E2ZGkweGxGWEI5V2Vjc1pmRzJLejlwU052WStnMEZoMEJ4UDVD?=
 =?utf-8?B?a3QrYU5yclRldHkzZzhIK0VtQ25RelBSZzZjSDRuU3JweWl2SktXd3Y1d1pE?=
 =?utf-8?B?QTBxSmlKOGI2UG5uQ1ZpSG9JLzFReUxoTnRCRVNEQk1EK1hxc2J5NnR5ZXEx?=
 =?utf-8?B?bldDc1diVlBleDFjZXFPMG1qT0JaTE8waXZWZENPblFVck5sWlZGcnlxeWp1?=
 =?utf-8?B?T1U5RmlJdHdVeDExKzJPQXR3SlR4cFU1eUcraWRBanVocitkK2t2SVFzSlVs?=
 =?utf-8?B?d25XbnQzV3UveG1LQWdQbnlqQmpkYjlHbm11Uzl4elNnUmJqNG5BWFlBU0p0?=
 =?utf-8?B?cHlsWTJWRTRQeXBvNWpvWTZXZFBJbTNjMjAvR2orZHh1OXc2djNzeGoxNXRq?=
 =?utf-8?B?dGF6cUtmZmQvdGM5dUcyQkdKQ0xUYkJQRWs4SnNsdHNwazdzNjNGdmZMMVhV?=
 =?utf-8?B?SUxua1Y5SytRQzRXeTZncXNLUnpyNGNUSFRXTk4yNHhkQytrT3lhV0wybEgx?=
 =?utf-8?B?ejc2cXlkT2c4V2hUaHZ0em1lMG9zU2lVdG1ia0Z5WWphU3l3TFRHcUlVaXFr?=
 =?utf-8?B?NGIxNENOeXFkdkEwRnk3Y2xCTGo1M1B2RGlzZjJ1SHB2bkNod2N0ZUM5ZnFy?=
 =?utf-8?B?VXBTemZFOUZESmJpdnp4R3BDY2tsR2p0dXQvMElZOThJSDlRQjV6djY3dFh0?=
 =?utf-8?B?eWJZY3MzeDhPalZjSXJsdXp2VC92WThSY01aZzFvNXIzR05DUFNrTXFTWTNS?=
 =?utf-8?B?TEdCcTM5SzUzdDJRZGZBUlFqT0N1WC9DRHZWUGsvZFZsOVZtTmJSV211REpI?=
 =?utf-8?B?ZHVpclFNOFBBPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F460F0F0731954B845E0B062AB13D02@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	7cd850ef-cd76-46bb-ffc5-08ddf5caad4a
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|14060799003|35042699022|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QWEwQWtHZUkxMEhFMG4veE5CekRKTTdORkhBWk9DcXpoT3Vtb1hjczZObFhM?=
 =?utf-8?B?aXdHVVA2amk2NjdKaDkvMGxUU0pMMlExd3c4MFhNVHdrcE95Z1NtcFdUblZU?=
 =?utf-8?B?eWZGU3dQeFVvN0JzMTdGVjY2V3dXZ1NqZWtLOE5SdjRvbFpYRWhZcXR1dktv?=
 =?utf-8?B?ZXVZaWFxaW00RTNwMEZva3FwUWdoT0FrMWtGTFpYZjhmQkJ2QzNGQWkvRTVx?=
 =?utf-8?B?K2RSOG5MQUlHMjhoRUh2bER0Z1Z1MzR6OWk5WG9mdCtXVWhFWTNpY0xiQVpU?=
 =?utf-8?B?bGtZaTJwQjZ5cmpMZ1RJRnBNVHJsNCtWODdVQTAyeFg0eTl5M09SeDVWanhs?=
 =?utf-8?B?a3lkY1lCYm9qMEJkM1lBblV6RkpWOElIVDB2TWhvVFhZQzBKM2F1aTUxWXpv?=
 =?utf-8?B?NTkrVVNnN0tyVHhpOGZHUFpLMWhjQThGRkZLNHh4MG5VN3JHWisxT2FURy90?=
 =?utf-8?B?S2M5U0RTd3RvS3RHUzFLMVNlMS82MkVZeHBka3NZdEdGMWRqYnhGOUZwVFg5?=
 =?utf-8?B?cy85YkovanBEd0FFN2JrYVEwcnp2Z1dpVWtLLzdNejhnZm5uY0xwTXo0cEMx?=
 =?utf-8?B?WWNjQ3pTR0hDbVFTd0FsMEhvd29COFFqMkpoU0tJQ3NNYVMxNk9WWTRKcTZV?=
 =?utf-8?B?WkJjU0p2NnRVU3RQc2t6eW9uZkFkNy9hNW1yZm1LT0pVbE8xLzAvYzZqUmtm?=
 =?utf-8?B?YzY2WncvU1pXNUF2eDZSL1VYcnNHc0FFM1d0Y253RHpIZDhMUDNPdTNENG4w?=
 =?utf-8?B?TlhuWEFZR0tIT0MrOUZjVlFPZC9sZWF3R0E0WnEyMitHNG9sTnZ5dlQzcHFq?=
 =?utf-8?B?VzQ4dzIzVWxWLzVBd1lBTHVnMW1rWTY1dWxTTS82QU1BZzN4OURIdkFrWTZO?=
 =?utf-8?B?UXduZjVnQkhIbndyVGp0SGpFenRrRUFhVkxWU1d4U3RJMmhSK0xyTDJ3ZHcx?=
 =?utf-8?B?MXd6dGZKRlM1SWpKVFJ1enVVbGp5c3NQQ05wMlovdUdoYklCNDZPQ3ZtWm5z?=
 =?utf-8?B?SUpKbE5PZkh3M2cyOHNnM1d6bk9ZUmFMSDM1VlU2Ym5HNWtGLzRCa3c2Q1BZ?=
 =?utf-8?B?aXRCeEgwMkhJUUFxcTdrZHI3ZVNnSmZXWHZjbVo5WDFZd2tZUWN2YzlFdnBr?=
 =?utf-8?B?cGtYaFdua2hiR3FBOGVTWkJrZC9Ya3p5eXJEN1hjVHEzYTYxVmJLSXZTYjVH?=
 =?utf-8?B?QWwxb3MxdWhwczRIVERUSXc5aENSWjdtNmg4WTVRTDdmMzVkZkpYZW9Md20w?=
 =?utf-8?B?K2ZCTTViT0dEWkRrdVdvSGsvTGNLNFl3TW5mV1lQT2ltTDVZYmZqK2IxekU4?=
 =?utf-8?B?dDBWbVBQdHk5V0h3NnFOQ1V2cW8wZzFxcWV3Z2tMTUw2Ni9JUDhtT0tmeUFy?=
 =?utf-8?B?NXc2MS9TTEV3NWRwaFlzQkFOcnByZGtYZFlVbzF5RnljSzdSNEVON0NScys1?=
 =?utf-8?B?Vjd0UUdyaXorc2dSMEUyRnJTZ3hqNjM0V3krcnVsZWRrTGxuTkNuSGd5ZjBr?=
 =?utf-8?B?Rm5lUEtxY3lsd1pmTDVvS0xmcmpTVThJL2lYVHZQNFRBVFJpN01OOHVGQWgr?=
 =?utf-8?B?d0lyYnI1YUV0UGtPOHl4UkM0U2FLeFJKWjNydm9QSlp4SEgyZTZXaXplZW1r?=
 =?utf-8?B?MDB1ZlJMSjMwNGVnK3h0ODM5YS91TFR0OThZWENzc3JZL3NWald4VHRwYjdX?=
 =?utf-8?B?NmFxZUdzZEN1QlVPbDFDWTdHMmFsTTZoRjhKS1ozdElyR0VNMG9QUG02dTRD?=
 =?utf-8?B?YWV2SU92SDNzVHg3cW1oNjI2SWtlem93dVBHc3V2eFkvenhhVjgzbTRZNDR5?=
 =?utf-8?B?RC9tSFQvVUdGWk5VR0NRalRJMTFOYm9tVGltTVFCUHc4bGNlQjI5SE5tYUsx?=
 =?utf-8?B?b3ZYcXNVb3J1RFIwOXdCZGd4c1hFRGRJcHZoaXNtLy9Cci8wdUQzTHJOUElB?=
 =?utf-8?B?VWhtMFNYVkFMdW4wN2VvNExxejlsK0FLa1c0bnVTZmI5c05xaVUxeDlYanBr?=
 =?utf-8?B?QTJVVitCOHNMcEFsSXQ3RjRqOXlKeXZmdnlISTBaVDFFMnRvMnFSWTMxZ2dN?=
 =?utf-8?Q?htNnwa?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(35042699022)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:15:33.3047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb834b8-0d23-405f-ff9d-08ddf5cac170
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10628
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 09:15:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18050

T24gMTYgU2VwIDIwMjUsIGF0IDIxOjA0LCBzZXRoLnJheW1vbmQgdmlhIGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPHNldGgucmF5bW9uZD1tYXRyaXhzcGFjZS5jb21AbGlzdHMueW9jdG9wcm9qZWN0
Lm9yZz4gd3JvdGU6DQo+IA0KPiBIZWxsbywNCj4gICBJIGFtIGF0dGVtcHRpbmcgdG8gd3JpdGUg
YSBjb3VwbGUgb2YgY3VzdG9tIGZldGNoZXIgdGhhdCBwdWxsIHNlY3JldHMgZnJvbSBvdXIgcGFz
c3dvcmQgbWFuYWdlciAodXNpbmcgaXRzIENMSSkuIFRvIHN0YXJ0LCBJIHdyb3RlIFB5dGhvbiBj
bGFzc2VzIHRoYXQgaW5oZXJpdCBmcm9tIGJiLmZldGNoMi5GZXRjaE1ldGhvZCBhbmQgcmVnaXN0
ZXJlZCB0aGVtIGluIHBva3kvYml0YmFrZS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IGJ5IGlt
cG9ydGluZyB0aGVtIGFuZCBhcHBlbmRpbmcgdGhlbSB0byBtZXRob2RzLiBJIGNvbmZpcm1lZCB0
aGF0IHRoZSBmZXRjaGVycyB0aGVtc2VsdmVzIGFyZSB3b3JraW5nIGFzIGV4cGVjdGVkIGFuZCB0
aGUgc2VjcmV0cyBhcmUgZ2V0dGluZyBwdWxsZWQgZHVyaW5nIHRoZSByZWNpcGUgYnVpbGQgcHJv
Y2Vzcy4NCj4gICBPZiBjb3Vyc2UsIEkgZG9uJ3QgKG5lY2Vzc2FyaWx5KSB3YW50IHRvIGNvbnRy
aWJ1dGUgdGhlc2UgZmV0Y2hlcnMgdXBzdHJlYW0gdG8gcG9reS4gSSB3b3VsZCBsaWtlIHRvIGFk
ZCB0aGVtIHRvIG9uZSBvZiBvdXIgY29tcGFueSdzIGxheWVycy4gT3VyIGRpcmVjdG9yeSBzdHJ1
Y3R1cmUgaXMgbGFpZCBvdXQgbGlrZToNCi4uLg0KPiBQWVRIT05QQVRIIC49ICI6JHtMQVlFUkRJ
Un0vbGliIg0KPiAgIFdoZW4gYnVpbGRpbmcgcmVjaXBlcyB0aGF0IHVzZSB0aGUgZmV0Y2hlcnMs
IEkgZ2V0IHBhcnNpbmcgZXJyb3JzIHNheWluZyB0aGF0IG5vIGZldGNoZXJzIGNvdWxkIGJlIGZv
dW5kIHRvIHN1cHBvcnQgdGhlIFVSTDoNCj4gDQo+IGJiLmRhdGFfc21hcnQuRXhwYW5zaW9uRXJy
b3I6IEZhaWx1cmUgZXhwYW5kaW5nIHZhcmlhYmxlIGZldGNoZXJfaGFzaGVzX2R1bW15ZnVuY1t2
YXJkZXB2YWx1ZV0sIGV4cHJlc3Npb24gd2FzICR7QGJiLmZldGNoLmdldF9oYXNodmFsdWUoZCl9
IHdoaWNoIHRyaWdnZXJlZCBleGNlcHRpb24gTm9NZXRob2RFcnJvcjogQ291bGQgbm90IGZpbmQg
YSBmZXRjaGVyIHdoaWNoIHN1cHBvcnRzIHRoZSBVUkw6ICdvcHRlbXBsYXRlOi8vYWVzX2tleS50
cGw7b3V0cHV0PWFlcy5rZXknDQo+IFRoZSB2YXJpYWJsZSBkZXBlbmRlbmN5IGNoYWluIGZvciB0
aGUgZmFpbHVyZSBpczogZmV0Y2hlcl9oYXNoZXNfZHVtbXlmdW5jW3ZhcmRlcHZhbHVlXQ0KPiAN
Cj4gSSdtIG5vdCBzZWVpbmcgYW55IGRvY3VtZW50YXRpb24gb24gaG93IHRvIGFkZCBhIGN1c3Rv
bSBmZXRjaGVyIHRvIGEgbGF5ZXIsIGFuZCB0aGUgZmV0Y2hlcnMgaW4gcG9reSBkb24ndCBwcm92
aWRlIGVub3VnaCBpbmZvcm1hdGlvbiBvbiBob3cgdG8gcmVnaXN0ZXIgdGhlc2UgZmV0Y2hlcnMu
IElzIHRoaXMgZnVuY3Rpb25hbGl0eSBzdXBwb3J0ZWQsIG9yIHdpbGwgd2UgaGF2ZSB0byBmb3Jr
IHBva3kgYW5kIGtlZXAgaXQgdXAtdG8tZGF0ZSB0byBhZGQgYSBuZXcgZmV0Y2hlcj8NCg0KVGhp
cyBpcyBhIGJpdGJha2UgaXNzdWUsIHNvIEnigJl2ZSBjb3BpZWQgaW4gdGhlIGJpdGJha2UgbGlz
dC4NCg0KVGhlcmXigJlzIG5vIHN0YW5kYXJkIHdheSB0byBhZGQgb3V0LW9mLWJpdGJha2UgZmV0
Y2hlcnMsIGFzIHlvdSBzYXkgeW91IG5lZWQgdG8gYWRkIHRoZSBmZXRjaGVyIGluc3RhbmNlIHRv
IGJiLmZldGNoMi5tZXRob2RzLg0KDQpJIGd1ZXNzIHlvdSBtaWdodCBiZSBhYmxlIHRvIHdyaXRl
IGEgZG9fZmV0Y2ggcHJlZnVuYyB0aGF0IGNyZWF0ZXMgYW4gaW5zdGFuY2Ugb2YgeW91ciBmZXRj
aGVyIGFuZCBhZGRzIGl0IHRvIHRoZSBsaXN0LCBidXQgSSB3b3VsZCBub3QgYmUgc3VycHJpc2Vk
IGlmIHRoZXJlIHdlcmUgbW9yZSBwbGFjZXMgd2hlcmUgdGhhdCB3b3VsZCBiZSBuZWVkZWQuDQoN
CnB5dGhvbiB1c2VfbXlfZmV0Y2hlcigpIHsNCiAgYmIuZmV0Y2gyLm1ldGhvZHMuYXBwZW5kKE15
RmV0Y2hlcigpKQ0KfQ0KZG9fZmV0Y2hbcHJlZnVuY3NdICs9IOKAnHVzZV9teV9mZXRjaGVy4oCd
DQoNClJvc3M=

