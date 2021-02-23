Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.76])
 by mx.groups.io with SMTP id smtpd.web12.5148.1614050333476747266
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Feb 2021 19:18:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=HVKmgqDl;
 spf=pass (domain: windriver.com, ip: 40.107.237.76, mailfrom: qi.chen@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJOv2G1XIpKZh8HOjLz8vT6OlXd1sFfoHd20ujlTcAmgiRmwHJPm+I9wCEN1ZM7Ito2fRKq9D9jW7QONFclyNjKrYARtICciTxWBYNClAWYfDIDd1NB1O+sQrz/Cc7UQPPnix5vsgtJyNTBkRVXAAh5sA7FppB1iYr959/PKuCdXG68LarK5sMsIsIQvTWaqGXk9+B23IyvwPqcS2XZnVTXTcU8tKsxOHHa4P02gx9qpsr815qXOe2IyUvTavzQEM3epkHAigNYsCXcPxuvFd+Zb8ua0vrLDMnL0l3kxRd/ebW+Qmw7B0qFBf3hMmMETPU3sCo3B0whe2gF9FXxMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqHICUan2iNkiIiKV56vlDk5QGbPIhA2T++M9j2HIyA=;
 b=B8eSnoudye66my+trWlLIrIx9VOGZdDP1OrPzbM3z2B6H7zGrCXH9gb2NMJJ5ccpaJM48jnx/LxTEgTvqx3Vs+DSRhvrZcosyQAg1vceyQOMEPVZG4MUlpVCNHwnzThN2uNzOideOHVkO9T4OZZyvU8hIxy/GbNLe8d8mh/nYOgDlTSDc2HZRQTlMJVqCr5L6G238IC7VejhAtpcwkx9BYFBiaazDTqSBqEWkyOfWTHBxfuJyom0WuM4QkYD2UTu00hinMyontPzUEgKUWWRbn+IaM7oYjcI7nEvhsReSO+1+8hm2IvS4d+o02EFe2jvyFlcwjytUrop2z2IJ+obBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqHICUan2iNkiIiKV56vlDk5QGbPIhA2T++M9j2HIyA=;
 b=HVKmgqDlqM5ceX/GScIedQyUj8R/6pny/S/8JpC8keCkn9uARSkg0l3doIx4ahzHGjLrHRO+ET6Fhuedkao+/tG1/sM7iGyPChW0KhL1M9I+LIiT7Lut9nW91HXXqAMh9EUKpHcLKWLKtbp0fezqTgtaKqJ/JvKY44JsZm/26eU=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3480.namprd11.prod.outlook.com (2603:10b6:a03:79::27)
 by BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 03:18:51 +0000
Received: from BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60]) by BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 03:18:51 +0000
From: "Chen Qi" <Qi.Chen@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH V2] event.py: fix regression about INVALIDCONF
Date: Tue, 23 Feb 2021 11:18:28 +0800
Message-Id: <20210223031828.17763-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To BYAPR11MB3480.namprd11.prod.outlook.com
 (2603:10b6:a03:79::27)
Return-Path: Qi.Chen@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core3.wrs.com (60.247.85.82) by HK2PR0401CA0018.apcprd04.prod.outlook.com (2603:1096:202:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 03:18:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40281c3c-0f86-4aff-1e10-08d8d7a9bde0
X-MS-TrafficTypeDiagnostic: BYAPR11MB3256:
X-Microsoft-Antispam-PRVS: 
	<BYAPR11MB3256F7AD74F65B10A978BA97ED809@BYAPR11MB3256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Fxpu99kh6wSqiEMWFhdq2E4x84mV4yddBVuqKVONFnMWj2JUhCdX+FOJ8t6WA5Teyq7tPFXVJCKw9ObOI09uecFAgYlhfRqYYj9zVVYibkhj8Qmt9t4Y6GLQ8spde0AXMIytIfZz+dwlywegxLI+5K8AehDqzbRJny/QqaQtqIr5OhvMngdhp+Z0OF42IVCj45eRMzf6eJ8CbgY5vNZw/3oj95Yr+GMvzcTaI2AUKNnRcdrRE8u6K59Ck+KcehmLiy6B9ZRi+0HR1Mnz2YcabQhZnflsHxypDifWWJyTXp9a++xjCY1jimMFW/aHn1tYF7Fi5oXMjgEAqew4gLsEH0ZXCsQxUJ8e/wUj2YnLOLNIUT4DIRB30OliACfkPCoWCMWhjSkCJbmY0xa2k6LXgv23oGeVoxANOLAJG1SAPWE+ej1VeojJ6XOHb47Fp5zrO2593k14CZWsrFif5Kk+wncFeM1IuFphqk+lZJ79Yz1C1kx5Y3xhNgl3KqavScZamP3jFcl0QWkMbBSZdQoaCg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3480.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39850400004)(186003)(16526019)(956004)(26005)(478600001)(6506007)(86362001)(2616005)(316002)(52116002)(8676002)(8936002)(6916009)(6486002)(6666004)(4744005)(1076003)(36756003)(6512007)(2906002)(66556008)(66476007)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?dUBxdgTNdNM1CcLGxd83MbuHy0i5NNX7py3uPAzl4HST3jZt37QAWx5CS3eo?=
 =?us-ascii?Q?MWWaKtq1hY3LPvhhuTkFiNbvelqo53dSwUoLOqfXZTBqX3eNQzsoXEEoIjfV?=
 =?us-ascii?Q?RicElSQHcniaKTO34q1aXzMr7GjXjGEzz2h3LsUyQTTLuUAVNFGYHM5K+d4A?=
 =?us-ascii?Q?SzHp5Ve7/f5TOysy9RAZWrsAC3L86Iat62OCDQgNOhLeDJMQr4ybSoBv9BVU?=
 =?us-ascii?Q?dtriB/nYEKIs0YsNxB+cjsGGiW/skQeWbWp+gfHDjPE3ROz5W/Kd94StJbSh?=
 =?us-ascii?Q?C8ya0VYapJDgJA2s94cMqW6ClGukSRjSicxDSpXU1QGrIP4t54M9CLlFKpSh?=
 =?us-ascii?Q?cTtbXcuOcWipY2vFBhZXpQzDicZxsk33fVsBJnfdLW3vkwr2jdmYGW15xgul?=
 =?us-ascii?Q?B9g19vMHZuFKDDRZeHgrGCOyS3kVEmDtMHJZ3267vqpmsi4/rp2nFUBXI6yp?=
 =?us-ascii?Q?/dLTkGXlspEZSYKyT3tQ8HgA1nb0DvbsKhNrGBiFo6pvzoGMKShXXlAIll1d?=
 =?us-ascii?Q?4r7Jw77twRUNyf1JcMEd8ZwRCF6ZOsiPccTW7lG+noyM149+IexMnZw/gtXT?=
 =?us-ascii?Q?uLWtETEX9wuVxnatLUxgAGHrmwM2BwZC5x+o65WQMUvNXqzsIj8jd0KI0ScL?=
 =?us-ascii?Q?3v58PfimMutlwq57WW6pKnxzs6WtyOXRHi8jO3/cRyGHDAdfTfvOP+ETrSEz?=
 =?us-ascii?Q?i5OUWsO3JHK/D/VNwrPZ7giBfPeaq6YkEkI/4HldJqFazq7xoTj8cjGIO3BA?=
 =?us-ascii?Q?WtLC5IKWF3JupB8HTLDXsH+oxqI6Gq53BQVtf2HyD+ZH07fVqgYE8pnG7puu?=
 =?us-ascii?Q?H73K2GjUQ0035pq81h6yFbPfLkXKKAEDRTR3CHI9OtbCDmoImnJpFsx+Twgs?=
 =?us-ascii?Q?tkU8UGl5d0duGgqAF1FLgp18EXqAvH02u4igMC0/WH8Yw1Q7MOvPsrQmnYfd?=
 =?us-ascii?Q?6BTE0j/vqTS4AhiGMmyRm/s/wPbgxx7jYKbbXJqLofU/gc4zmD7rqx4YH9f/?=
 =?us-ascii?Q?d7235UdI/904OzQMf5srdCT+QhubcMyUkgwSyX292ia8JoCcAjIUjimlPPiB?=
 =?us-ascii?Q?wHq5GqnNmDo0XE57mNAmglsbi8pK4ORwfVOhjtarZS7p+htCN5YTgBuxKXol?=
 =?us-ascii?Q?dR3zhVV0GZwNVbTV8v8Q7HTfn+bqbCJlDPy/pdUjojJRLcpYaF0zOaUhFsxh?=
 =?us-ascii?Q?JY2gCiCitmLQYhoFTGiVA81+BaVbjRjuNCnfPrPtFuQapyja1zRLHpAiyy4W?=
 =?us-ascii?Q?lI3zSRR6P6LmhBVo8nQZ8svwW+KC5ZlzbWAQnYOC/M86E3UVLb5jkNvPJUj4?=
 =?us-ascii?Q?X2lc7d1sQNb9qPpCcFxqPe/U?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40281c3c-0f86-4aff-1e10-08d8d7a9bde0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3480.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 03:18:51.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GklNpisDq+XNndBGsW/NJ5WqAEidQIYLeSIThL2GYie2/CSmSWf0zAYX9W3ySImP/Ax5mn1ulnaAn1kMe6U9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3256
Content-Type: text/plain

A previous commit uses __BBHANDLERS_MC to record all handlers, but
it does not take into consideration of INVALIDCONF, thus causing regression.

We need to record the name before returned AlreadyRegistered, otherwise, when
reparsing due to INVALIDCONF, bascially all handlers are not called.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/event.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 23e1f318..3e571839 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -238,6 +238,10 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
 
     # already registered
     if name in _handlers:
+        if data:
+            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
+            bbhands_mc.append(name)
+            data.setVar("__BBHANDLERS_MC", bbhands_mc)
         return AlreadyRegistered
 
     if handler is not None:
-- 
2.17.1

