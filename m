Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.88])
 by mx.groups.io with SMTP id smtpd.web11.13977.1619018431290015039
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Apr 2021 08:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=fCy0AyWR;
 spf=pass (domain: arm.com, ip: 40.107.20.88, mailfrom: diego.sueiro@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRI/B+FwlJFt1Jiy+pWz74WhJaQ7It+BSIQgB2K7rJY=;
 b=fCy0AyWRoLN9bdT40Ul0h4z+Yg6NRaISg3U3M1CxgIyXS1QCLQZUYyEKJ7LU5reVXISPal8S1T/2e2qgWut72W6ZHK0EicHpyYK6VUnEoF3lyS4NufBZXBkW50jhnVAREvnjiFozLLLpO3VhHS1XvdsHFOUbr4jGGA+0XPh18xY=
Received: from AM5PR0601CA0033.eurprd06.prod.outlook.com
 (2603:10a6:203:68::19) by AM6PR08MB4008.eurprd08.prod.outlook.com
 (2603:10a6:20b:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Wed, 21 Apr
 2021 15:20:28 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::35) by AM5PR0601CA0033.outlook.office365.com
 (2603:10a6:203:68::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 15:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.openembedded.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.openembedded.org; dmarc=pass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 15:20:28 +0000
Received: ("Tessian outbound 34291f7cb530:v90"); Wed, 21 Apr 2021 15:20:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8395e3af13f76602
X-CR-MTA-TID: 64aa7808
Received: from 09b5cbb5478c.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id BDBEB338-5304-4653-B1F6-B9977BBC1171.1;
	Wed, 21 Apr 2021 15:20:17 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 09b5cbb5478c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 21 Apr 2021 15:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff1gP2nJG/OuYvltBouy8L+9oOXNMw8uJ6r0QB1E8VEJ+TR5yzYctOsINAi7Q5YR4fkM6bMGKRnuIdQ2207G8X4Y6kTjmjbmGw2qlfpYs4YrmNFmg8t8wb9gqMH2K3t3LIlxNCseWxpT7iOmoIBxINCu9q34Js8tggwJ+tBiYgFhD0Xtv3mTYApsdf4+jAjtVb4KBdxLcb7xBs9VD/RdtWFgVD3p4X/5vYOM1ynk0kpK/dreUA7UD6ZFf8EFKVYBYZvneLzFo1PAQSgGLeE8hxfCrJhIwmlzIPVxU1OzxdnoJPR15nQyyPqBQfgatneNcrGTzTNAICAAVXCYYXcD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRI/B+FwlJFt1Jiy+pWz74WhJaQ7It+BSIQgB2K7rJY=;
 b=jFxGZa6+9V8SuPCxTGz3I1NYuGPyzE5BhDaxrnkUHLjNXrsjsCK6ue/AWDNTUn6teZPwOtqM26CSWh3yVxO0AnB3gqG7PCXu6sWdv5VfQS/euRTU+km0PTIEI85Y1XuZrrr7Jb1ywrx5HVELcKYhpc7eSSvw75kfVxgAxQJ/wcPik4co2fFkxq0CsOhQTC8vZYZGSnUco+NagHLBcHNNX8XVKaHJblGqhchrGxllK9HG7cdcLC0Q/kqJsEoZUxQRXgMI1uV/KeS2brAV7B/YofofIOLCej5h5QKbmxQqQql7icP0bczsUPdINoD7kUAWwTA8kWJf7TwZinBw79x07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRI/B+FwlJFt1Jiy+pWz74WhJaQ7It+BSIQgB2K7rJY=;
 b=fCy0AyWRoLN9bdT40Ul0h4z+Yg6NRaISg3U3M1CxgIyXS1QCLQZUYyEKJ7LU5reVXISPal8S1T/2e2qgWut72W6ZHK0EicHpyYK6VUnEoF3lyS4NufBZXBkW50jhnVAREvnjiFozLLLpO3VhHS1XvdsHFOUbr4jGGA+0XPh18xY=
Authentication-Results-Original: lists.openembedded.org; dkim=none (message
 not signed) header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com (2603:10a6:20b:47::28)
 by AM5PR0801MB2114.eurprd08.prod.outlook.com (2603:10a6:203:37::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Wed, 21 Apr
 2021 15:20:15 +0000
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b]) by AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b%4]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 15:20:15 +0000
From: "Diego Sueiro" <diego.sueiro@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com,
	Diego Sueiro <diego.sueiro@arm.com>
Subject: [PATCH v2 1/2] bitbake: layerindex: Fix bitbake-layers layerindex-show-depends command
Date: Wed, 21 Apr 2021 16:20:03 +0100
Message-Id: <3b56d18433d4fb52fa08beb2d725999b296c73d2.1619017963.git.diego.sueiro@arm.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To AM6PR08MB3461.eurprd08.prod.outlook.com
 (2603:10a6:20b:47::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e120809.cambridge.arm.com (217.140.106.53) by LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend Transport; Wed, 21 Apr 2021 15:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f035467-a59a-44f6-18fb-08d904d8fed0
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2114:|AM6PR08MB4008:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM6PR08MB40081C7F7B902C287B1F97D392479@AM6PR08MB4008.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 Q4UVM/oqSS7N6YyqTgZbDzNSeFjvaWWOZx3HyKtw0+ou3FnqVXLGB42KAkkzfhmOKaNoli1XEyaA809NJclZEh9bKB97sS1phQeCidg46AtZZWQexAmKbTRleFuYkrCv+ikJK/LaUctnPvZ2r7SSBeRk/74efOlGnw2gV55c0Xqv7NKUwqd91bX35Q/MFzVM9Ezr+74Hldy9ZssXzTcINsq9riHJ6EkdVFNU4f9Tz5yOcHUvg32Lj8K+TIvy9bzBNljBqfVGBseNdzdF9Z15ybWtDe8em9RiVB/Oww/cWbdll7kob0gGp70/XcgdQ/NQKVFl7Zudpk8eKeTWGn+Q77ppFN9klIzQUx/Iyb7Eo2VhJPGE+qEZ/fJLzzh9hF60Q/CmBqFrhs37I3q1Y/AuhxSj87VexDYC0dI3G4UVQooLOR+B/OVTw3t8Y59dk5o1ZaPd0+JkEYOg/8Y/i5DYnV5suC1iG2mK2m20UHQf5fX2jPQ/z0uYJlHbuGbPvS+a410Kjhb+LspZtBb95M1cZLUYR9VLg+gMt9DuXY8YdALPv7TfhQ6B9/6q16FknB3xsGhhQRAe8twD8DQ2qRZtJst/Ld3CUfBaT2f0W+faBZq23uPd2MEGUc71ACfVEMfApzdFVvQHwwlI+8dyBEDwdPCLzLaQM7p5HOki4eZ9Vio=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3461.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(6486002)(498600001)(38350700002)(6666004)(5660300002)(186003)(52116002)(956004)(38100700002)(36756003)(66476007)(26005)(16526019)(6916009)(8676002)(66946007)(4326008)(2616005)(2906002)(86362001)(66556008)(8936002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
 =?us-ascii?Q?yoCpQVyRvPrIBCsjtu3QRHU4Q3Ik8A6tHySYg/VqLOxX8lmIRbZ4BuP4J3hy?=
 =?us-ascii?Q?hW7mUQre8GevvbQYE/hMlxAvqhaVTKrblqx2YClfuuuwZ7DSydc6VO7WBKPD?=
 =?us-ascii?Q?dHKDjxVIodTIluVApZmkoUVM0ldMHtmjaC6oG2LZBpzwqXBudeTgAPV5770b?=
 =?us-ascii?Q?eIURC+mnBqzp+TJpUZoAIpylYEZ+wGHP7h24q2WEQiX6X8NcvjK91Odz2n90?=
 =?us-ascii?Q?4ccXTpaX790AWYokQVHA4hORgx6pHE7UlXXNyfACPBs6eaL7Tqy8wd25DwLx?=
 =?us-ascii?Q?flRlwuOYtN+oZ3VmqUi0QL69CbcDOu5yudb8ii1JqvlQh2XeRlL5bMsGM+xx?=
 =?us-ascii?Q?6azrj4Iq0M1WXJuE3JHa+F0IWBYIe6ixlwcQpwHNoAtQRuaICoL6GNtVavp0?=
 =?us-ascii?Q?5f6zcp2vokSybYeMyNZqen/6fzbSoqVl9aV3cY5UX7g1BXLQHSV0H8RQRsG9?=
 =?us-ascii?Q?RP/9s/Z7SBRfHXfdCguYoUjg7wH60LTeO951OgQF4HAJAGRzgLGgKxwCLA6f?=
 =?us-ascii?Q?kIt8C77SRUfKd+fUj5hGPCg04QqpPIu0eSA22ObeDCheQbIjMS6BAXbpD2WN?=
 =?us-ascii?Q?PTpRVhoJIqjO3epZzeIWw6llOz1fHCa5+IyioZP/lHuRV427LVgEMWJALD0o?=
 =?us-ascii?Q?8tm3j9W7YfZgV30XuSz7Zt/XYYSOsMOFDzkvANN0xZOMe05nIT6J2f79HF+L?=
 =?us-ascii?Q?n5Dbfzgs4K+viR8xTLdu8fIKq9pS33Q1vvmsRnb8oHXcEOJSjcvXXfOl6oiH?=
 =?us-ascii?Q?vf0FhiNcFfg9AbKd9JzRVyNla3azg9dhGppwGG1dNJR3NG4G4zruZGUMEFB9?=
 =?us-ascii?Q?SM4ry2wloZy5OB5VO5F8psHcjlEaQMAgfuDga9nTBjOeKaqMh5t6SArphfTk?=
 =?us-ascii?Q?o5JCciHE/WjbzClpg14JiW4dh06NBesMuv6gqZH4QEqQg5PTK4TMMFomd0x/?=
 =?us-ascii?Q?9WiXRTSBIG87hX2L+NMSGj9BN+zaUE1fvFf+J6Hro1ZBlb45JUgXaEeqK3rv?=
 =?us-ascii?Q?VhmzAbxmy8k+5UIyxnKTJ4vNr6SbfLHUb57WZgtxe3Q5KGOi6LmM5HFXmCGn?=
 =?us-ascii?Q?I4s2qR1zAWvw3PLgiubaOjWbGa3UwIdU5WQNOAog9Fw1qzFaE9WVkpf3fcdO?=
 =?us-ascii?Q?ch9S4vAU5OBNvK4AdYjzb6mi8OwUYC9rET0IemKpk1YZL7xcR2JjZPsudsqn?=
 =?us-ascii?Q?7WHLRF9HPBBiQ0GFk6SBfqysrxFzpMCRnGMOsfO1nAjPsyQsVSdfsFP3/oad?=
 =?us-ascii?Q?rQ68ic4UpEl6GLJefjRCbP7oC0kKab+8Ww+2NKHyM5JBMtFYjKGANBVt9Esw?=
 =?us-ascii?Q?p/XMxjjrZ3oPDHQZjFF+bd+P?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2114
Original-Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Return-Path: Diego.Sueiro@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	1ab1eb85-3ceb-490e-3701-08d904d8f6fd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YM+fD8frewKA5ENq0h3rnyu05dgM6smhHS57b4M0F9mAfexh156n+VeA2fzAUg8X7rcrjYIEnbqR4xu7jDU3D5ERc3/9GWGsQUHN0o2bmxo/fqNQVoH4MSx4ZMdjneypSa1/wDolDjvmQ/4ZCe8cTiaPJix4bpKad+XQBKAqNa6RjPJ1mlsUrS6R0tVZWkIVtapHUYuEz68Mn+LbMqCInzw57wMhCrx2EuoYILAPhfSoblEuabFZn4SAz3PgFhS59tEDY0wnVJGgfkjKg8rkZVUanPqmjFZPUa8LZZhDYgQT8rBHV5hHJNLbn4NMeWAr7MQ3C6SFAIZpZpxAv6mlT6uWba5b1kqjU9pJHLjZcn/LNUoS2o9IfcimajK6eskk9xDJau0gCiTFesaXQjlI7f4Bix0F/iWAvL61wVbKaRE2HkJzh750bJn3XLpA3+/LFTAUiytIr73DnjTcwGur+2C9t98tL41KxJSt9yh/EFVUPV8whghhJu1txKS/3Dp2hV4IYGUH9PducXWqaZMc2qKH07YVl0o8cQdqxN5RrqVL+0qvWUcWwa7MPoDUAlJrkcdhZYLBWL4aBqnSCTiCC2zozyn4TS65Cq+7YrPVZxPXpKboo9Oyn55P2Xzr6fiBsbf0izPspCgSqD7VAb7XzkxEEhUBczDh/yxaVnWMbIk=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(498600001)(6486002)(36756003)(6666004)(2906002)(70206006)(44832011)(2616005)(8676002)(16526019)(6916009)(36860700001)(4326008)(186003)(86362001)(336012)(956004)(26005)(356005)(82310400003)(47076005)(5660300002)(7696005)(8936002)(81166007)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 15:20:28.3453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f035467-a59a-44f6-18fb-08d904d8fed0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4008
Content-Type: text/plain

Running 'bitbake-layers layerindex-show-depends meta-filesystems' fails with:
```
Traceback (most recent call last):
  File "<...>/poky/bitbake/bin/bitbake-layers", line 93, in <module>
    ret = main()
  File "<...>/poky/bitbake/bin/bitbake-layers", line 86, in main
    return args.func(args)
  File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 209, in do_layerindex_show_depends
    self.do_layerindex_fetch(args)
  File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 182, in do_layerindex_fetch
    args.shallow)
AttributeError: 'Namespace' object has no attribute 'shallow'
```

Initialize the shallow attribute to fix it.

Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
---
 bitbake/lib/bblayers/layerindex.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
index b2f27b21ee..17dfc9874d 100644
--- a/bitbake/lib/bblayers/layerindex.py
+++ b/bitbake/lib/bblayers/layerindex.py
@@ -206,6 +206,7 @@ class LayerIndexPlugin(ActionPlugin):
 """
         args.show_only = True
         args.ignore = []
+        args.shallow = True
         self.do_layerindex_fetch(args)
 
     def register_commands(self, sp):
-- 
2.17.1

