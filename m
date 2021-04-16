Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.46])
 by mx.groups.io with SMTP id smtpd.web09.11220.1618589267379601708
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Apr 2021 09:07:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=LGYVA0Lu;
 spf=pass (domain: arm.com, ip: 40.107.21.46, mailfrom: diego.sueiro@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRI/B+FwlJFt1Jiy+pWz74WhJaQ7It+BSIQgB2K7rJY=;
 b=LGYVA0Lu+/FXH1tKYk6LI/ESoZW9h3Ml2AT98Z1L/yUEZe5RJ375yxf4JWRKq5+Jnw9vdcoiOubVGrZsNKFCid2ad/b8OB+4BjL4KpIz+Ze/5xdTmzDOnN+I1zEtv/2K4Ke64aRMZ4v0TprcxzWwms1Oe9GIXAejIdRktDuWNzs=
Received: from AM6P195CA0086.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::27)
 by AM9PR08MB6161.eurprd08.prod.outlook.com (2603:10a6:20b:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 16:07:42 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:86:cafe::8b) by AM6P195CA0086.outlook.office365.com
 (2603:10a6:209:86::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 16:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.openembedded.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.openembedded.org; dmarc=pass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 16:07:42 +0000
Received: ("Tessian outbound 82c2d58b350b:v90"); Fri, 16 Apr 2021 16:07:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: af6323f3ef4ead99
X-CR-MTA-TID: 64aa7808
Received: from 072485cd90f3.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A8515EE5-8A56-461C-8B74-8090C868852A.1;
	Fri, 16 Apr 2021 16:07:35 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 072485cd90f3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 16 Apr 2021 16:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8JfB+HdWCp984YZMZ6HPN7oWKduGOSZmiAakwldYbsyzyqpVC/CE9hq/UESfPuFxIi9FwxWTpYWbvDG0ip5y2cCGtu1EKQlfZV1b7t86fncSkbl5hF4WwmKQvZQl0V5f6cWOt7xKOJAlapUCahtzvm4gwcX+/Qf6WnKf/x34kXh6TYzhFUTHXYKtQq1OKhiQwvkijrr+KVNR57s/ktODf8eoCH1Mz0ObpP+R6pVn3BdkIMGGyl3VAAZYhVLcJ4UevwB0nqcClwUrmUkCPHDH13gf8m4v+ysLK7eDzTeZpKgISV+ebZvaA8rqBV6M+vise1S4tPYhfyE014FRljg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRI/B+FwlJFt1Jiy+pWz74WhJaQ7It+BSIQgB2K7rJY=;
 b=WrFvjfwAgAZzik73UHWJUn+wLgSzL5s0nroNXQLfNxSRucQN8c5E5Bk+JJnMOSLzkkRx6WBK0Nqku4vpcP5LEaxqSOqkmUN2XEWay51278WBwWnIMhAnoqtAXZxQ+y9HhL/5V6Q+/W7aDqnF9tcDuvapBsIt7M+kKwQ+Nd6VfbfHmz21wKVAfGe1cRV5EKE8ml95pa8l9ELjl5XmlxQZS4G1bwFveDQOkpg9sZAu0eack3of4GpE28cN0tWSpxAuIhR0UXd0A/xek0uZp/T1mePQJdab2RgmiR0bIcy8Yczz/cjXble7DBoZs5oW3dbxSBlTRMhrxpWphTaMii20Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRI/B+FwlJFt1Jiy+pWz74WhJaQ7It+BSIQgB2K7rJY=;
 b=LGYVA0Lu+/FXH1tKYk6LI/ESoZW9h3Ml2AT98Z1L/yUEZe5RJ375yxf4JWRKq5+Jnw9vdcoiOubVGrZsNKFCid2ad/b8OB+4BjL4KpIz+Ze/5xdTmzDOnN+I1zEtv/2K4Ke64aRMZ4v0TprcxzWwms1Oe9GIXAejIdRktDuWNzs=
Authentication-Results-Original: lists.openembedded.org; dkim=none (message
 not signed) header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com (2603:10a6:20b:47::28)
 by AM5PR0801MB1747.eurprd08.prod.outlook.com (2603:10a6:203:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 16:07:33 +0000
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b]) by AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b%4]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 16:07:33 +0000
From: "Diego Sueiro" <diego.sueiro@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com,
	Diego Sueiro <diego.sueiro@arm.com>
Subject: [PATCH 1/2] bitbake: layerindex: Fix bitbake-layers layerindex-show-depends command
Date: Fri, 16 Apr 2021 17:07:10 +0100
Message-Id: <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::14) To AM6PR08MB3461.eurprd08.prod.outlook.com
 (2603:10a6:20b:47::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e120809.cambridge.arm.com (217.140.106.53) by LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Fri, 16 Apr 2021 16:07:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0a94836-ff2f-4b33-df3c-08d900f1c3ce
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1747:|AM9PR08MB6161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM9PR08MB616114B80DF03E0D6964BC2D924C9@AM9PR08MB6161.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 +1ADSPZbt7xgsm/3Sd7HWGIQ/tR4nmid6nmhR20apwzZoRdYnGqd6AZ4GP6uijwYp3IvTzpajya+qKiUW56DIo0maaMAZ3tzcszf6fEE6bC0Lui/32PHVM7primPuo+KzA26kGpc3o0ArQ+vX+4AsIEmun8QYWq2Z9/1oFpYw0COVYkqRec45tc4URnWDCYCWUiU59TrJD01uNL5vwdqIk6O8/LaYitOPLhyJDoVe766bm4/Fs1hLPNo255GeF5AuHZu0xnDF/a3qZa6YbpSGYOFGOpY+CKYr8o5MFFrlpjI+mUGiXK8gLAom8VUV6f+2CJ/YYIWEdVF/xTNHckbQxqGZoqzisavn58+Eu6zGBf8TKw1J0C5bk6+ZY43KtPa+1BLF82+V2rPhOQju/5weQYl4ulhQMZvkQB85V80+PoMkR/0n86USNBBXk0sDywXt4Q4O7BJ9hkHi4I9mrgxll7BwGmRbOkIVVF/6/bHUQFLJJjsI+5cjk0wBnjnv1ebDIk5RjYtU/I++JPPVM37fOn7vXe/BZqp24qNxpdsHE/C8TjkEwZfUbhfr8t8tDltkikmGxwllzLgXBRoUSG0fjSCE5RPbLFe7nRtuNx0Y+eN3zBGmBiF+OAa+Jg49epYX1Bao8gwlIQUwBnEl6jOcO+UFkJq8WXbJSaZBV3p5Ek=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3461.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(7696005)(2906002)(316002)(8936002)(52116002)(26005)(5660300002)(86362001)(36756003)(2616005)(956004)(4326008)(6486002)(8676002)(478600001)(38350700002)(16526019)(186003)(38100700002)(66556008)(66946007)(6916009)(66476007)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
 =?us-ascii?Q?hc0pnlYLh5n6BzgPvPKJGZiI0bDxqXWi8YGfUks8jKz9MiEjPn/Oms/eA02L?=
 =?us-ascii?Q?6+zNGOVvKBbng56Eabh102oZtxeCF65NPw8eiGbOEs0KEyJxi3feLjvWjv1w?=
 =?us-ascii?Q?cmF2ivMs3xVXqw9AHl+RbzeW7dnlYkKd0fw8rtPvg6TklNAEfmBc6oO7d3Xy?=
 =?us-ascii?Q?R9dkEwWkzID0wUP92D2ce0P5v45xg1Mg9Fzff9HJcJ3ckvZ/E9LkVe+aZpxr?=
 =?us-ascii?Q?M/TsGNLs+Jk3ihLMDV8gl5QL929GpUx3hFgt6vRXGnU3nyO4a/Yi9Ud3zkn/?=
 =?us-ascii?Q?Ym0w0Oka2NTNJCVYdz/wNuBsiX4Ban9m+cyGOU+45Xr+vo1GbAh/n4v01InJ?=
 =?us-ascii?Q?T3+uxsdJhd3DUkf2bjTRpftbLSJeMYwC+kqupej9vySVU9LWTyHzWe2b1bQr?=
 =?us-ascii?Q?ok1XLfNaeH2ruRnpQ3RULc1OgN992AL33il0tyaAj+GyogXPv5rsf4TvJ0EQ?=
 =?us-ascii?Q?JCNAhZvGUkcj2e1KJ3S41jfF4B23MFVE6S1rblKkE7Wb6U4DoS1LMDYEbCvt?=
 =?us-ascii?Q?XJvSNLhs+DrdG0GLnHPmXBs6xLCkpISDaXOeIuhHYMZe4YayiaASVy5660gj?=
 =?us-ascii?Q?J0JKhiCAZE38ACFa5B4n1cHK8M1KKsncxC4JJDH/Pt5t7p4rPyjoeBTClsdQ?=
 =?us-ascii?Q?XLmuz376hYOOHswZRe+HPA0jaeqc2D42P7Lp/I7ufvYoLreitG22sD6PuZqC?=
 =?us-ascii?Q?OuipJlYlNWOI2liEhZGQgX8R7sPW62O4EQjTlHDK1msJXqkMPsyfh0qbPF76?=
 =?us-ascii?Q?TqHm8vp+aBfm4iizX8TH7h1VbzHPqLhwQXZn34R8apgC6APAvI1Z2imKnP5d?=
 =?us-ascii?Q?0Bm+dWyfDHDhtVLDaBn0tfOAV0Q55qUH92ndeX3HkrXv00MqMOUEx25iVRNI?=
 =?us-ascii?Q?w4ZMsRNQdQettNC/Sj/jEzEZdNji8PjBv1PSxoErJCWqln/aBNLBSyKJWeeo?=
 =?us-ascii?Q?8dB8YUn3PH+V8aeJo+B3O9+q9c87XGE7n9/Htx9zsMkEoQ4OO5zLfrkKxHD8?=
 =?us-ascii?Q?AxaCo1L4H4RlZZeovEXWb/482ynyIj4g/MkmyIRjpMVWVMQHwEtAqcEXRhEU?=
 =?us-ascii?Q?Dbn3iZ/sw3gdvkm1N9MeHsG68xzQfb2JpkMIR6DtWZpqnwLGaG/arElMRoHV?=
 =?us-ascii?Q?y/6e63je0NNsNB1nZE0cAY4amnf6ObF7U0BTgKTvs88Sz+1BKP4je1lNJaqJ?=
 =?us-ascii?Q?d605aiKcQ9iqD9bQd5br2XzBvGZ5oTFMGKCs3I1ca4QpDWKr5odU2LLWrcAZ?=
 =?us-ascii?Q?V0EyZW0XInGca4Jk/U5MlRH9bLHdnZYaD1YPAXk59IHMehEEghzWfXfwVELW?=
 =?us-ascii?Q?CUZMy+LG1TvlmJPxXeozPk2S?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1747
Original-Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arm.com;
Return-Path: Diego.Sueiro@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	2edd0f11-bffe-4102-f682-08d900f1bdef
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PvWtOi89qTqkIIye226LcO+NgOmGce2WSCLaCvaCIdS9kzLEQ/iogRFUwDy+RbXUN7MffY+js2GFK2rhqKZRkdcmqlq1QCxb13PDIBEyG/+Qd1ix9Md3upNc6TLbYVFQ/dfgVwt6bvFQc5KHqoVoN2GQW94ro3QX79jZ57CmnPOZPFf4HhxOYNSX5ypn3eqBN1xD4hyTAphUg8i6yZbylpOeiZ9PmWub9c973mWRRc9zT3jTbMRrCPTyKEG8UYEo5cfIe7ZOi+nHDVgOej10DTRzKjmqAQ10GE9YwDBPUsc6aRPX0JzDCanAy0Alo9m3PC5PCNcaYPl07HVUdXnJI6SnpWvBDgzj02+uKmVy5el4bu/Io+sYSnpsajQW/voy4RwMUuEtxQPAWpdvIbPc5A+ssOiKghLhG+tKHmUrU8ZzdL0NwZfMwtqWdkyKbPYqZWln+SU1rn8PjbZZGEQktkJ9V5swYqOq2ALddG2N5/aZJfPxHK6FcCvO3L+O2j7xcTFNpfjk11Mzr3u0NtElkbqJTJJBwvQWn2Dr4jqEqpMJ7FDedUxYQAQMExtXhIOPBBhisrcxa7tz9ksb/Pxdr3ml3WtOTB96S1LkOsW3Mnpcrt9dlRpYe6BniouDfC+RBVboJyF+8B6MsbkVGGgT/azZ6RNyDV/f6okgJhp36f0=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(44832011)(186003)(16526019)(2616005)(336012)(356005)(956004)(6666004)(6916009)(7696005)(8936002)(36756003)(2906002)(82740400003)(81166007)(82310400003)(47076005)(36860700001)(4326008)(70206006)(316002)(86362001)(8676002)(6486002)(70586007)(478600001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 16:07:42.0529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a94836-ff2f-4b33-df3c-08d900f1c3ce
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6161
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

