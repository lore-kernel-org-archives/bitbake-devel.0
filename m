Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.103])
 by mx.groups.io with SMTP id smtpd.web11.14372.1600946169299430431
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2020 04:16:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@klsmartin.com header.s=selector1 header.b=vEiRu+1o;
 spf=pass (domain: klsmartin.com, ip: 40.107.6.103, mailfrom: leif.middelschulte@klsmartin.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcgRSvk0wnyGHl862yOOcX7Bl/mjMEKk9bpzpdDxE4H7IfqlRaiqivecPFTNUyeOgZSzPGw8T732i49eo/z2sslXPIBqQ4IOXun1B5/rS0WksMkxoql+25jV+h5YC6CCccYJf615O3Owdfl+Y+08oi8uwBFHX4IIYDl6tlr8WXNjcSsNKv1nOBkZ3k73b+dsC/bxIRwx8ZlV+bdWLzv3XaYC2UrslZEPxotzcw6vxmlAdMDXaKvAadE4yXZeTpWsWlygmJ7FcbbCCC8TckWS2yHX842nWjbnaYsFLFg4lXw/2+Qxj7yA9XViOJPiZUwazZa7e0rW4BdzeHrgNdS0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoA+BUfiiN3r3VJcAl9ittz7K6YCvyFZp+/q6TEp1yw=;
 b=Td2EkqzRShqBNU7bFn0JqHVqJsisg8rej3GNdpNxr/Vr1Rg9wNPpKKYjflvqevVItn0jWTQf/hTC1xQ4YVTaDKpo9S63meoUBnN60WZm2971OJn6Kjyd3T+WerG+6TBfm6X4aBWnzJW6/Rz117gM01JGkIRI4rXekbrUQraeLFpJwYjC1LmHLt5MGz3XWlvOHLVqufMy3up88c+iUTaZ8jBcbvCZW9JC1PyC6lq0zjYDbUmbVBE3GIGMLiYVgNf+qT94kERUZ02bhQ/uBaKmsPpwqVKihtjxtOpkhvkusf+rPnEU8/RUGT7hksr8yeTs9EofTeg2ZdAqH1RSVRjllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.211.189.60) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=klsmartin.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=klsmartin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klsmartin.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoA+BUfiiN3r3VJcAl9ittz7K6YCvyFZp+/q6TEp1yw=;
 b=vEiRu+1olnlZvyUp0uMB/rVWMSMZEBIDwbzPnPiMYGKDCzPjF/NmYjBagYc1YSsFdl1dIIv73voN9J06TC/gesuDHeYRq/316Dlclpz4tX9RUIeC7wcI74zIQ3H3JEZ5xb+GxAkUK4jGZ1CIMQVqlePv7rNgvA0Kd9amSABKJJSUaJvWu0fMchbJFcP22/1bCz93ul0s1OTT1FqnARuUIutnIod7Haj9WGe8lJPcTaWq8oUa7bucvdX0Ba9lD8B2iaJLwCzlgY4ulDR564WX4fg1JL1r/gZTlhgUFNf1gQwJ6eSQsGBZZ0gXgbV1sRBdMMThIVRt3vJjtk71Q42OzA==
Received: from DB6PR0802CA0044.eurprd08.prod.outlook.com (2603:10a6:4:a3::30)
 by HE1PR0202MB2748.eurprd02.prod.outlook.com (2603:10a6:3:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Thu, 24 Sep
 2020 11:16:05 +0000
Received: from DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::77) by DB6PR0802CA0044.outlook.office365.com
 (2603:10a6:4:a3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 11:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.211.189.60)
 smtp.mailfrom=klsmartin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=klsmartin.com;
Received-SPF: Pass (protection.outlook.com: domain of klsmartin.com designates
 212.211.189.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=212.211.189.60; helo=mail.klsmartin.com;
Received: from mail.klsmartin.com (212.211.189.60) by
 DB5EUR01FT052.mail.protection.outlook.com (10.152.5.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 11:16:04 +0000
Received: from SKLSExchange02.KLS.zentral (172.20.10.200) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 13:16:04 +0200
Received: from ELARA.TUT.KLS.zentral (172.20.10.63) by
 SKLSExchange02.KLS.zentral (172.20.10.200) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1913.5
 via Frontend Transport; Thu, 24 Sep 2020 13:16:04 +0200
Received: from SUMMAIL01.UMK.KLS.zentral (172.25.1.63) by
 ELARA.TUT.KLS.zentral (172.20.10.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 13:16:03 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.103) by
 SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 24 Sep 2020 13:16:03 +0200
From: "Leif Middelschulte" <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v4] fetch2: fix handling of `\` in file:// SRC_URI
Date: Thu, 24 Sep 2020 13:14:10 +0200
Message-ID: <20200924111411.21590-1-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
References: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
MIME-Version: 1.0
Return-Path: Leif.Middelschulte@klsmartin.com
X-Originating-IP: [172.25.2.103]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24.09.2020 09:09:00
X-CI-MailPolicy-Key: a7171edc6d882241d2c63de1f06b7859;38cc73d0-e751-486f-9878-c0329cb5322e;ELARA
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452366f7-ec68-473a-b8d8-08d8607b3a52
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2748:
X-Microsoft-Antispam-PRVS: 
	<HE1PR0202MB27481FECF275F7EEE19EF25799390@HE1PR0202MB2748.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bSNcPLc32XoUxhV0HXS3WtA0q/wLD3rvxGiRdt0Qmh+FglQFECiWOPhFGSfxNKIQX78sE93LVXkVUScDLR2qCe8b+wTdCUv7zYhyidZPRaBkHC0xuq//dbkHMrQzrQ5X/s1vs4Bb07HJpNK3J6w2kroGqOsdquzbSkBQwAVDNfTsUw1qBtbbXJcqNtMyFaMXNZgFXCDHlcDKOOn679p/0T4CYfXYV9T/Uc5Ei/8gKKlNGVQATvgP6gdLK1+0Te1EvlKFiKfk+9EEx/XvzvkXho8uW0RhsKoixjrX6dRCD8+DE4+3mRUKqFnulFJc8TXUmWwuUIaeleOqK0SUzZdvRXWcTJKZpIjCuRpfSmS2dZEogtXEcXMfceXuS5V2O7SNIw14DNom/5ZwgRAxNwMIuXeLIgU5lws0LlvvsIdyjT8briq7Ib0gpg5YvkcjHXkj
X-Forefront-Antispam-Report: 
	CIP:212.211.189.60;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.klsmartin.com;PTR:asav10-372.outside.spxs.net;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(46966005)(36756003)(316002)(2906002)(6916009)(36906005)(478600001)(186003)(86362001)(81166007)(82740400003)(47076004)(6666004)(8676002)(2616005)(26005)(33310700002)(82310400003)(16526019)(44832011)(1076003)(356005)(70586007)(336012)(4744005)(70206006)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: klsmartin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:16:04.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452366f7-ec68-473a-b8d8-08d8607b3a52
X-MS-Exchange-CrossTenant-Id: 9d29fdbf-9c75-430e-86f5-ebe1ff5a5223
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9d29fdbf-9c75-430e-86f5-ebe1ff5a5223;Ip=[212.211.189.60];Helo=[mail.klsmartin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2748
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series allows users to specify `file://` SRC_URIs containing bac=
kslashes (`\`).

Patch series revision v1:
- Provide simple (using quotes around paths) patch to allow backslahes.

Patch series revision v2:
- Rework simple patch to handle glob expansion inside Python instead of rel=
ying on the Shell.
- Provide second patch to test `file://` SRC_URIs containing backslashes.

Patch series revision v3:
- Fixup typo in python filename specification.

Patch series revision v4:
- Add missing DCO for patch 2/2.



