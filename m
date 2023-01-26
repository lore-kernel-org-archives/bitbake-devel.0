Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13DEC54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 16:48:44 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.77])
 by mx.groups.io with SMTP id smtpd.web10.78798.1674751722809768359
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 08:48:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=eViGZ44X;
 spf=pass (domain: arm.com, ip: 40.107.104.77, mailfrom: ross.burton@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsfoFehJujWuaEpbPYP/v0lNroJtXnOhVli1kD2XlPo=;
 b=eViGZ44XEww9eN8GVbwiwg3wVWqt1e7AKs+YbeW49He3bhQ06qVIA7wtvvyWjQYB4fb6YQ1cdlmxhF3ByIlsVeDgRC8h68NNtCSr1IoGDGIX6DUGoG1FKi9egabMwXiHHfovyOIMCAChKbYRMr/b/qzHG7BgziaqyuL8MXSGCvw=
Received: from DB8PR06CA0059.eurprd06.prod.outlook.com (2603:10a6:10:120::33)
 by AS8PR08MB6216.eurprd08.prod.outlook.com (2603:10a6:20b:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 16:48:32 +0000
Received: from DBAEUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::d) by DB8PR06CA0059.outlook.office365.com
 (2603:10a6:10:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 16:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT044.mail.protection.outlook.com (100.127.142.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 16:48:31 +0000
Received: ("Tessian outbound 6e565e48ed4a:v132"); Thu, 26 Jan 2023 16:48:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1d9fc3e39f37b69e
X-CR-MTA-TID: 64aa7808
Received: from ba0706e85a1e.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7DD1C490-AB65-4893-8045-7401DCB22396.1;
	Thu, 26 Jan 2023 16:48:25 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ba0706e85a1e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Jan 2023 16:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWO1vPxhswi+eXbZ9uUHbcEvm0CiEXwXzu3a07vVuTQPfrzLPDUS7OOkAWUusGZnUNFT2dxdswdkYg08L3gPOZV2x1yr8UOY9Liq204j5kWwmn2E4AWa9onANZK4fkoE4La5fCBcuP7fQStNBJPZnt/JXMGJoTmMZTht5Rs7tlTok215Ysyc9xYx0Bf5Z6eEZlJwFar4acWIZTf2oPATjxEbASmGiE5Tz2bnDokfm097576JiyrRyN0sFm2ABZ6KSDRHezhxIgr8M2qG6CIJuCfxScgW4LwC73p7DveJ+p1Xxq0AgXZ7ZtBZWYHN8K4oILFf9OmP9Q+m0may3oRTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsfoFehJujWuaEpbPYP/v0lNroJtXnOhVli1kD2XlPo=;
 b=e4MVLx3S0amBzINCQx/zKqMPDIWxpDhEeW1GyAKIDJZoM/cD7aVOUxUM9Jl053LgTSY8IGDP4DabDd5tGs0cFapBOeRHJYRovVfbEcMwcPOkCdUWspwNDGEKcf9aAYoyByPct0c/rSyTCOli7uGCH4kkBD9ap3AxMUEWW0C/w3AcAvEEb6EVqCiELCf0JZ1N/CgjaRHoX0IUix+MUKUwWtw606vtOCZN/0oHa9MWs9tYri+WJcoe3HqEWSt8WpbRcutQ+ztxHLMQvD9cD7WDbmylhhNPKMOkc76zNNVAHAn0irG59UByeLgP0Ldy7ZXJOdMrHcOTGRp2BH0jYvENRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsfoFehJujWuaEpbPYP/v0lNroJtXnOhVli1kD2XlPo=;
 b=eViGZ44XEww9eN8GVbwiwg3wVWqt1e7AKs+YbeW49He3bhQ06qVIA7wtvvyWjQYB4fb6YQ1cdlmxhF3ByIlsVeDgRC8h68NNtCSr1IoGDGIX6DUGoG1FKi9egabMwXiHHfovyOIMCAChKbYRMr/b/qzHG7BgziaqyuL8MXSGCvw=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by GV1PR08MB8742.eurprd08.prod.outlook.com (2603:10a6:150:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 16:48:23 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::2d3c:c53c:86ba:a3b0%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 16:48:22 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, nd <nd@arm.com>
Subject: Re: [bitbake-devel] [PATCH] bb/utils: include SSL certificate paths
 in export_proxies
Thread-Topic: [bitbake-devel] [PATCH] bb/utils: include SSL certificate paths
 in export_proxies
Thread-Index: AQHZMZQKu3Degm5F0kKFFZJcnxNcR66w6I+AgAAAPQA=
Date: Thu, 26 Jan 2023 16:48:22 +0000
Message-ID: <3DDD745B-94D2-4BA6-B9D5-C214638A4CD1@arm.com>
References: <20230126143935.1444197-1-ross.burton@arm.com>
 <cf441572a9c2070c607ac377e6cfd77bd205a190.camel@linuxfoundation.org>
In-Reply-To: 
 <cf441572a9c2070c607ac377e6cfd77bd205a190.camel@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|GV1PR08MB8742:EE_|DBAEUR03FT044:EE_|AS8PR08MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: eff9bf38-35e6-40dc-bf08-08daffbd2882
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 ln+80SculOukvRM29tTXG57kctA4OrKUfmQly0imw412VrFskzqS5+1bmO0R/ICw3/2EKCNGkjCUnz+DIcbKZ0hb8dVO0EHbrF6bnhKTmftyQdMEAmVnjs5QGVQftSBu9E3Wf/jTChEzlR7pDSXiDqZZmcxIuxhC8alV3H/hE4hJDwVYI+HgO5huJBI00S6WNPrxCTLHE1qdYM9G9GwUSQwPVxKEY9HVjjn6OP339WFfdH8NGJ17uSjOTwUpONdXgKpyWpaPrSJG8fHICbMVP8f+6xR8vaQKY9WxTCW5LufQW4ouy5KDK8002DLHKGAF9Uq4Ll2nq6qT0Qf4Bwq8cTJv7yd2cKN+G+izkrf3gwSsyQFSFMZ/mYOtZrx4Z8QtvFmxb73h7k1Mh6ndvRyu9XGUcLkpMpS05HC2QMbtPdQ2Gt6eET1f2winfarVrBDHiFmzrRz8hlkAxddgZdOuW78vT79xGXJpHRMFqaOHTRzHNK1Ji2kOr3zxgjJX7ffETbvkEsG1cW2xrRHlrdUp/QLS/2NVEITTPX/kVjaEVa9jm+i0W5q3KSzDF0tNT1dM1p3Mb3/7uzeMiyZAWTF6DdFaykB/T0reTOamk9Y61Bdwrgfbither+eWRd9GsFpeIuQrOjF1UY++l83GtDaP4/D9ZzoKyN/2UuDThgQiUnzDm5DiZ6hpwft4cnvRClxfjmSgeVX3UWLbxWDQGWjy3lff7YUKWfYTWXXMfXZZbu8=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(6512007)(36756003)(316002)(558084003)(66476007)(38070700005)(66446008)(33656002)(86362001)(76116006)(8936002)(122000001)(2906002)(6506007)(41300700001)(5660300002)(91956017)(8676002)(64756008)(71200400001)(4326008)(6916009)(66946007)(2616005)(38100700002)(66556008)(26005)(54906003)(186003)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <354B549DFF1E924AB0C06A8D81241A8E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8742
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DBAEUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	3b2cace8-378a-4c08-54ed-08daffbd2313
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P4jdYCqtdEu3ZVPd/cGoCTCoUX8p7Gg1kd8CFDxmBkaZGdDiZLz4EtZ+PqEndUdGKWgV+ve1eoAb2nRgiZ4+wzeIh7Oyf9dua0FbM2z9f4nxfZ3AOH5tmOehmGRYnY9XgibTCVgjGABqfkZ86h/gF620HlYxK3GDHRDhll5A3p+7FBUJh2SACS/N/0XrwZjJZdW5C+zoYPsN/V5J9OXsyfgM3yPuFcLYyYclR/t2iXUhJ5utRi5cuN726axnS3q+k25EFHPWvl7Ii5WdPWpTZuzHbh+hEm+gS4cHVweG3+5ufvY84+Q23xOVflCi08lTUK1fJo6wX1sUywyaPc0pyEg+qUO5EeQJkQg/N7CMrLNPtwuafPvVI4UeUGGalpqNb/zuJnjhYCYsnHRT/S1bCjG3jcgXFyM73CDoKUnxIvsH3maxfcsVuZPPt8aLyXNNeh53U6WW8PL0ZoT7OnQQJTaMpc1kC1T2P80KfsqdwowBsG5Hski4fNrLf1vftQa2uiJ0Gvgd/I47sHFnkwZxLxziX9A9jKcJhfKiC0k1q6kdldPJdJLDStL9HnVf19lpmMWAfEt3FgJGQNhWNwOyZxPWJy7dW2GiMtCsPEJ7Y8zgN5Op4cCxqCswJH915EbMcDdWtEmzQv+LptRoKjGkaFbuRhvoJp2SYkU9wYGrpqRKNcE4MRodIjVamkKM3xvbHPFfq6EblmTAz7PzC8eySw==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(2906002)(41300700001)(6862004)(4326008)(316002)(8676002)(54906003)(6506007)(6486002)(478600001)(82310400005)(36860700001)(2616005)(6512007)(186003)(26005)(336012)(86362001)(70586007)(70206006)(40480700001)(40460700003)(33656002)(82740400003)(36756003)(558084003)(356005)(47076005)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 16:48:31.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff9bf38-35e6-40dc-bf08-08daffbd2882
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DBAEUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6216
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 16:48:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14350

Pj4gKyAgICByZXR1cm4gb3MNCj4+IA0KPiANCj4gInJldHVybiBvc+KAnT8NCg0KV2hlcmUgdGhl
IGhlbGwgZGlkIHRoYXQgY29tZSBmcm9tPyENCg0KdjIgaW5jb21pbmcuLi4NCg0KDQo=

