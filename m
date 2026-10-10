Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C542CA6004
	for <webhook@archiver.kernel.org>; Sat, 10 Oct 2026 10:37:22 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7204.1791628636190464442
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Oct 2026 03:37:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=NDdxtTPs;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=NDdxtTPs;
 spf=pass (domain: arm.com, ip: 52.101.65.68, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nijUehSQPjngPCnWj/V2AZveVy9wGXHjhfSZckI/yDNHyJd/DBlswkEFcxSwi6CepOMkxAwrWXblha3DIEJc7YTcT4qpMYujymi08Qmmbf6ynBDK+1d0mCet12kKtdS4iOM/+9FzCqjcjUnoIr/G4wTi41amBzXa7XgL8B/T7sJxWmkW1Rd/3ey66lHYQcTxvAKeO3RYfct18Gqgi2xxpJUzXQn+AIXBcfNogPLPAF1tV0Ogvn32y2NpwhEVUPNNm04eLxrOohrop2d3Ivwnxeb1uK6QDSsFUa/lfPdI5CgWknxY12l/P3tLP9gafMAdX9jBRPbBZo1S2WbtaLJorw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpjzGO0dzPp1URoAjODz5pkwTwmk3cka0YnNVed2DUg=;
 b=Xgoyi+7ONOgOcXygVjAW7JcsOEUWuzcxlMR9xZoDCDS25TKCRJDjDCY5xq91oBIIY2xJiBuNbfnwTWAxNB0uXukj4TafYn7kWMlT/2nlF1C1z3AXU8O4D3W9Pij8gVvWF76pBmSPFQs6+1gOWlr8c5yAuo+LNfFUYjZ0uEXzbkwkChlLq6GWzjsadPh3LZcrYqtYEIAcbEegRRB36G0vHkV/MNwvRAFHmJgglNkiQNoJCT3fbr8wPXVP0rEDYyxIz8clZXKxQm3YjTNsSftiJWSMPLcWzUrliG6ukf9IYzFYCqIheZS5fEmYrvugviRIO55cRphlubVhV6jbd0l4jg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpjzGO0dzPp1URoAjODz5pkwTwmk3cka0YnNVed2DUg=;
 b=NDdxtTPsoQ7q9BWlwHmpuhGpOasDCJYhBeq/WVLtd+6tU0AaZaNIoy3edHdrQKtTHBLpa22W2r9x1duVHZ0nCt6xmXtMrQp2pB6e4MqApomL6pOsSKdQpVP4TpdZlGZekb015jtOwsKg/K9AiH1GWeMIPVeqnkL3evE/EVYhDl8=
Received: from DB8PR04CA0017.eurprd04.prod.outlook.com (2603:10a6:10:110::27)
 by DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.7; Sat, 10 Oct
 2026 10:37:10 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::a) by DB8PR04CA0017.outlook.office365.com
 (2603:10a6:10:110::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Sat,
 10 Oct 2026 10:37:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sat, 10 Oct 2026 10:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk0R1qkQYK3ePcWi2nSHnL9LSgkIk2fPTduYSLEfSqZTKHZW6DupsB0o+hVELG+uO+CXvuGKyCRmR2r7diJCvXeD142Vfbh3Lt93yA//cdp/jYhYbO/w5KeKdFoKvg5wprbNcZNluBTm98J6flmHZ3gLTqvjurPq7UzDpjW3eYMtWQ++37Ezlp6B1Mtn38rgt5wvSkHxDtxaxZNzREmZeuB9ygaCkfiJZd4W6VlbWGrygDu4KBqiehoYus1bNOw+cFTQbmzfsRvVAqk5rr4hMWnnqHrSkveTvxJXTejQ/BBTW2IN7fNuJQhXJSJAjAViaHQs+0J6p6qg9G172MNIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpjzGO0dzPp1URoAjODz5pkwTwmk3cka0YnNVed2DUg=;
 b=OmTgr8ABe95pfLIy0fP9lvdU4p5+IDEJfLmREXz/Kad45Glw4zHOnMS3GSaWbg4bJZvPPsNiET3kfx4TGZ09jMqBRt2jjRHqtxgo5FxHbM1sbC60v/NipcKdTZCMWFFT3pwpP05XEm5IX6vowT1S1mvIGYcxqgg96ubKTJa4/XxghKxFqdPIJPpAq0k2+0IMQ2kMGFjMXRmnuvJDQgv/8dwI68osOxoEoBzHQYJvQwlhzu1BIoNMWn7/Ao8zUxU6XQVsosKhQaiHwqdWwQTwXxtEU8U9Mmb2trO/wnOefQiNdqRHX9fl/4g6xcfc1q0NBwg3gf4s836GIzI7Ozzfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpjzGO0dzPp1URoAjODz5pkwTwmk3cka0YnNVed2DUg=;
 b=NDdxtTPsoQ7q9BWlwHmpuhGpOasDCJYhBeq/WVLtd+6tU0AaZaNIoy3edHdrQKtTHBLpa22W2r9x1duVHZ0nCt6xmXtMrQp2pB6e4MqApomL6pOsSKdQpVP4TpdZlGZekb015jtOwsKg/K9AiH1GWeMIPVeqnkL3evE/EVYhDl8=
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19)
 by AMDPR08MB11676.eurprd08.prod.outlook.com (2603:10a6:20b:73b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.8; Sat, 10 Oct
 2026 10:36:35 +0000
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b]) by AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b%4]) with mapi id 15.21.0522.006; Sat, 10 Oct 2026
 10:36:35 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>, "rob.woolleywr@gmail.com"
	<rob.woolleywr@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] packaging-pypi: make bitbake-setup depend
 on websockets
Thread-Topic: [bitbake-devel] [PATCH] packaging-pypi: make bitbake-setup
 depend on websockets
Thread-Index: AQHdV/L0OPGA6bujlUCV04RIBq30S7b1mSMAgADq+QCAABIYjQ==
Date: Sat, 10 Oct 2026 10:36:35 +0000
Message-ID: 
 <AM9PR08MB6258870E0A295B1F21D18972E8912@AM9PR08MB6258.eurprd08.prod.outlook.com>
References: <20261009133418.215223-1-ross.burton@arm.com>
 <CAGAhMByanL8TzBt=EPnW15bdPOaY1mjY4JtTv54ghie7AZx=Tg@mail.gmail.com>
 <CANNYZj_jwXcqc1tqViGvGCmJX6PZqZQaJLD4ToNt+c7uk3aMCA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_jwXcqc1tqViGvGCmJX6PZqZQaJLD4ToNt+c7uk3aMCA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AM9PR08MB6258:EE_|AMDPR08MB11676:EE_|DB1PEPF000509EC:EE_|DU4PR08MB11188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb6a77d-b6ca-45bb-7432-08df26ba7050
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|10067099003|18002099003|3023799007|13003099007|8096899003|261009223027099003|38070700021|11063799006|261009221227099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 
 lYFXJ3aUFquQII0KPUSH+8xuFaQqXBoQKum+2cuAXiHnnY1/ES7chazWrm94tO/QU5SHz+/lERN3grUwk7T4peGJAeW95d/RUSot+gajltOmCe/xO+f4MXxyhm7dmFC+lNlgMQ3b3BxVBXfJCorOHUjcAxcDKmNFNhmlPDnTLY2OzDt7kbCEq+FZPl3U0TxANu+0c8bwcXMQRwpE77NZJgR3dDeLKTbj0bmUK3qbtiGRFw5WFPsaGpbTY2aeLy3AChzGB3mqRdPtMdO/IuG+Mw0/82J5SYK2vN/G97vGiLBor4fHjyZQ3YaYoBB1AibUT2ZK/jsGFCP/ZlDPCyj9OHMWLcAuEz+/c0wV2EYvdenhEHcf2UajjSRVYCeluLYgXxg8hgiXfuqpwyFuVjmsyk34/o5/wyv8yvFKQnKwIsYHt9J41s7T6joJi+Ap7JlhY06/RLYaP483e60tcjOK41diDAbfFZNQxi9FeX3hXkIjhqVMuxhIpTU6CmLZiabcwxk+vXkmgiOmEiztMUoXOWk1pzfEZ10YWwNHd7UfQOdd7jyDP6ZpmDstiI13jJrZXmiHWzCw5h0UT8ORwSHqDGFhv8Fhdx9EpUI1r2cyN7SQcU1U4h4Qhy1jo14Bv26jBHYaQu7xbmheTo18ddo5ASc72WsAOb3IU4l7qKhPvu8=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6258.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(13003099007)(8096899003)(261009223027099003)(38070700021)(11063799006)(261009221227099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
Content-Type: multipart/alternative;
	boundary="_000_AM9PR08MB6258870E0A295B1F21D18972E8912AM9PR08MB6258eurp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 tawFZXycL+NzpMsiZ6rhDqCX6nxV8l9SG4hpm4/UgAKTM6kZQv96pchSy3BlngJQRkYVpvkOaZMpQgwNqfAB8eGlYAZm3+XmJRD6KMmTvBsd+FBXrm0/BesbS/MEzE/mb36LY5EyJMH4ahjdzJCk6CRWl5mybetNjrj6cc4ojU2mYo3/oTaFJ8IjYqUZjqWyiwWZKAF4V4Kyu8FRpO2aVIJsqRgrbmFQ9l5vq6FKaBGWnFoJ3JfGODcU47S43AG0//Xhuy5dTl0lGNfbzof6piQFLoWRROFrEOBIfdl3xONwypN3nI6YFRj4lyMhF5BVSEZZzf9NUvxOl/JK0qpMCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11676
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	ee67af50-cf53-4416-24d1-08df26ba5bd1
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|23010399003|35042699022|36860700016|1800799024|14060799003|6133799003|10067099003|18002099003|22082099003|8096899003|261009221227099003|13003099007|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	4jl0w9EaRarpGfsyWXBRqgTQzQDT3LVa+DNuLyofJv++qFr+jOXon/Q4/ST+xR9caDkc4CbCCeb/Nk1rZER8nR5CpewPNnTQYkS9jwfbyLia5dvdkyfrQrcUrhRTbAsnuz77Rf5lxHKUNBGTmSfEKcMKyu9IMk7RVlAluIRf3MufMOOieYqrVEXBtrPQDaP5im+hPon984NcNsoOHoLlXHbSzOu30/H8QWpPJO9HwWca7AuIsf+MbJ/lUj673xnU0HCgQvgkk6dPh89mH1ok96+3JL2nj1nWXQ0frZ+N+VfjLHICLsbn2ZHK0opm1J3T3bIS5KPr8nqrUSmWdOa4YQlQ+V7GKtpsPwxaN3C84Ki5L0gf+YmZpj6eJ8Ze2mzUZTBynpn31XcQpA0mqYgaVywD6imEgisFVM8eTBASSYXHOU76c529/5eQsZQOuVNuXtEjeukfqMyhvM+Q0krtp0ia/RbYisdryYLPn8+EpywYT1aPK4Xr6BFWWYqZHzeqTuMhpuHrrj0Rcs2o0gvlg46dYRs1JUlOMMB3FvTRScVdUriVIz/nVIoWhl/mA0OnLIIKUr82TNsmZEPQ/r75oLVVz2jwlOWsPWKUeVpn9sNHMLje9sIAKu7YY5mai1E2vf34WN4uMFz6Fwd57gAL7g==
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(35042699022)(36860700016)(1800799024)(14060799003)(6133799003)(10067099003)(18002099003)(22082099003)(8096899003)(261009221227099003)(13003099007)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	106e9hVLffEaKUl8S8T8iSdrP4NShKOd0qhRszSHyqFXWl4WvjN+QuYEg9dKApEjnx9INaYF79u5EhECHGIGjyjr55rQkSkRrvJ9Sz7HQFFVNuZq6VTBb/H1jnh1OvEfRkbnJoIMrIr6MNM27nLZNy2N8bft+MUvC6K5159l14RD73CswmC7rPgYGfjL/h6KwHg3rIymQRU224rDRmYMRYRIWR7vm75OtcmET7C2lcaoMnnvUpZbgTQn7qYPRwsLmZ/6SFr/uKKE2wSpo0ZWBRFmWRGZX12sDXPb/yCBsCrrkE1LgCbm+CqRfKLxTnowoSZboKIja0SpXj1hTOprtG1flVXTY1lz89jrQAp8v0nZINBbsJf6vo+M/36eVZuSYU2t0aufBmEEaNYNRbrci7X2ZBFeATDVgvaU15aKtSx/YU1pjh0uqIMvm2RVz0HS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 10:37:09.8832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb6a77d-b6ca-45bb-7432-08df26ba7050
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11188
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Oct 2026 10:37:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20313

--_000_AM9PR08MB6258870E0A295B1F21D18972E8912AM9PR08MB6258eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes, the demo was exactly what caused this patch. That's a common use case,=
 and a bit of friction we can make disappear.

Ross

________________________________
From: Alexander Kanavin <alex.kanavin@gmail.com>
Sent: Saturday, 10 October 2026 11:30:36
To: rob.woolleywr@gmail.com <rob.woolleywr@gmail.com>
Cc: Ross Burton <Ross.Burton@arm.com>; bitbake-devel@lists.openembedded.org=
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] packaging-pypi: make bitbake-setup dep=
end on websockets

On Fri, 9 Oct 2026 at 21:29, Rob Woolley via lists.openembedded.org<http://=
lists.openembedded.org> <rob.woolleywr=3Dgmail.com@lists.openembedded.org<m=
ailto:gmail.com@lists.openembedded.org>> wrote:

I think this would add the websocket module to the bitbake-setup package, e=
ven though it doesn't deliver the bitbake code that uses websocket.

I looked at the bitbake code, and it seems to already cover this failure ca=
se in a commit from Alexander: https://git.openembedded.org/bitbake/commit/=
?id=3D2d15e6fc93f6a73c9c84e399613f931f1c783922

It looks like it should output the following message to the user in this si=
tuation:

Unable to use hash equivalence server at 'websocket' due to missing or inco=
rrect python module:
websocket
Please install the needed module on the build host, or use an environment c=
ontaining it:
 - if you are using bitbake-setup, run 'bitbake-setup install-buildtools'
 - openembedded-core layer contains 'scripts/install-buildtools' that can a=
lso be used
 - or set up pip venv
You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result =
in significantly longer build times as bitbake will be unable to reuse preb=
uilt sstate artefacts.

Is there a use case where the user won't see the message?

I think the intent (which I fully support) is that when a user runs 'pip in=
stall bitbake-setup', that would install both bitbake-setup and websockets.=
 So they never even see this message or have to figure out what to do about=
 it. Ross's fix is right, if it adjusts the dependencies of bitbake-setup p=
ackage to include websockets.

I've just done a demo at bitbake-setup at ELC/OSS and there was a slightly =
awkward but mercifully brief moment where the message popped up when I trie=
d to run bitbake, and I had to 'pip install websockets' and rerun bitbake. =
Let's eliminate this.


Alex

--_000_AM9PR08MB6258870E0A295B1F21D18972E8912AM9PR08MB6258eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Yes, the demo was exactly what caused this patch. That's a common use case,=
 and a bit of friction we can make disappear.</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Ross</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, =
-apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alexander Kanavin &lt=
;alex.kanavin@gmail.com&gt;<br>
<b>Sent:</b> Saturday, 10 October 2026 11:30:36<br>
<b>To:</b> rob.woolleywr@gmail.com &lt;rob.woolleywr@gmail.com&gt;<br>
<b>Cc:</b> Ross Burton &lt;Ross.Burton@arm.com&gt;; bitbake-devel@lists.ope=
nembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH] packaging-pypi: make bitbake-se=
tup depend on websockets</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">On Fri, 9 Oct 2026 at 21:29, Rob Woolley via <a href=3D"ht=
tp://lists.openembedded.org">
lists.openembedded.org</a> &lt;rob.woolleywr=3D<a href=3D"mailto:gmail.com@=
lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:</di=
v>
<div class=3D"x_gmail_quote x_gmail_quote_container">
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
<div dir=3D"ltr"><br>
<div>I think this would add the websocket module to the bitbake-setup packa=
ge, even though it doesn't deliver the bitbake code that uses websocket.<br=
>
<br>
I looked at the bitbake code, and it seems to already cover this failure ca=
se in a commit from Alexander:&nbsp;<a href=3D"https://git.openembedded.org=
/bitbake/commit/?id=3D2d15e6fc93f6a73c9c84e399613f931f1c783922" target=3D"_=
blank">https://git.openembedded.org/bitbake/commit/?id=3D2d15e6fc93f6a73c9c=
84e399613f931f1c783922</a></div>
<div><br>
</div>
<div>It looks like it should output the following message to the user in th=
is situation:</div>
<div><br>
</div>
<blockquote style=3D"margin:0px 0px 0px 40px; border:medium; padding:0px">
<div>
<div>Unable to use hash equivalence server at 'websocket' due to missing or=
 incorrect python module:</div>
</div>
<div>
<div>websocket</div>
</div>
<div>
<div>Please install the needed module on the build host, or use an environm=
ent containing it:</div>
</div>
<div>
<div>&nbsp;- if you are using bitbake-setup, run 'bitbake-setup install-bui=
ldtools'</div>
</div>
<div>
<div>&nbsp;- openembedded-core layer contains 'scripts/install-buildtools' =
that can also be used</div>
</div>
<div>
<div>&nbsp;- or set up pip venv</div>
</div>
<div>
<div>You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may re=
sult in significantly longer build times as bitbake will be unable to reuse=
 prebuilt sstate artefacts.<br>
</div>
</div>
</blockquote>
<div>
<div><br>
Is there a use case where the user won't see the message?<br>
</div>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>I think the intent (which I fully support) is that when a user runs 'p=
ip install bitbake-setup', that would install both bitbake-setup and websoc=
kets. So they never even see this message or have to figure out what to do =
about it. Ross's fix is right, if
 it adjusts the dependencies of bitbake-setup package to include websockets=
.</div>
<div><br>
</div>
<div>I've just done a demo at bitbake-setup at ELC/OSS and there was a slig=
htly awkward but mercifully brief moment where the message popped up when I=
 tried to run bitbake, and I had to 'pip install websockets' and rerun bitb=
ake. Let's eliminate this.</div>
<div><br>
</div>
<div><br>
</div>
<div>Alex&nbsp;</div>
</div>
</div>
</div>
</body>
</html>

--_000_AM9PR08MB6258870E0A295B1F21D18972E8912AM9PR08MB6258eurp_--

