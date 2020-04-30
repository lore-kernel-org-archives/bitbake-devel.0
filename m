Received: from EUR03-DB5-obe.outbound.protection.outlook.com (EUR03-DB5-obe.outbound.protection.outlook.com [40.92.71.82])
 by mx.groups.io with SMTP id smtpd.web10.1301.1588273657639948742
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2020 12:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=BD+J319u;
 spf=pass (domain: outlook.com, ip: 40.92.71.82, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFHIvJsK+lqY61G+ZBgKTLLdqFVfBeFJJ1loxskkCYZP42yU5tAv+qQZxq7pT/3zHMxyWWf+NKNXKahpdW0TQPXnVa5pKosAfFRw+4ZovsPWfkseJWZinj+b7DNxz/9h7hTSVM2OMqQQ54O4k6ygtlP+lTOg6kmYkDjwpIMpJWfgRtkQQcOTLmXbmZ9kegQqwN93t6jp+O4CilZIexosoZAnHoeXZkBra2/EVnaJxvaV5AU+WhCeQZPupDkHP5SlGFLTDNNBgKu1Q9MaKyIFk2qa6aC51NGwT1O/q2Hp1gknN9aZcK4y8ioF8Y0Zq9gjH00jIqSUDlD2ZkkYPxCPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5k+LLtL8X9zztHrHnGEZiX0uaqthPSYvEA+evWabWo=;
 b=L2uqlBxnXMqPUg0+gNCsxgWzyNiljmAi9nXaCcprLw5GAM9MomO74y5w/+7KElua0tsxjH3StlcrGcWM14hkxBIWUGzzxfY/K7RYY+QsG+jLgH4wP4l1xjcdwTKqT+1pNKd9RL6HTIwYjMGTBxw/FIULhSSy7a7MXWO4e6rR/bfWz4aHO6xMWXixQLNRi/ld5TD159VxEKeKIrDdKaMxri2Xt2HbHA3KHOU6Q1KJq6J52L8SKu+dAvKr+uACGGf3rWI2FaMXgOmFY4ezqcE/78+VI7jetXQ9aSHnp+Ue9srI+rBNebXtPuWpHGFZn9kvs1jacqO2S/DWQwE6E58X7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.com; dmarc=pass action=none header.from=outlook.com;
 dkim=pass header.d=outlook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5k+LLtL8X9zztHrHnGEZiX0uaqthPSYvEA+evWabWo=;
 b=BD+J319uHOwwQFZKqidV0eeeg5sALUhuGN9yGzSJ21D5S0jS244qgl/xroeva005N1KjEbIdhJ/TVdQwwitLKOPbxCZTI93XyRiynQRVGwBy3XCXQhjqMrh4cHgHLR3rU/Qgyn3KcdTq/8iBhr36loug5dF0RTJnrom0uouCZj6lq/w+tb9vA6usmyS/XV1udZKnCmhy8mN/n4XaVD24rfHvuxoyiwak7dIZT3uZsFfXv3Rae9qOR/CmMLx4O581igymVy8jvb8J6fXnA90o3JtZjZ08YWWhPFeEW2LNSVUq7rB4wtNeUYn035Qcg5Znz26b8gcY5g9atSd0wgTQvQ==
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e0a::51) by
 DB5EUR03HT029.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e0a::244)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 19:07:35 +0000
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 (2a01:111:e400:7e0a::4a) by DB5EUR03FT023.mail.protection.outlook.com
 (2a01:111:e400:7e0a::68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Thu, 30 Apr 2020 19:07:35 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E5E051C7DE92CB6D506CC31F69BA05B621E9EDC9E1B517B2D69DBC8A70CE4EAF;UpperCasedChecksum:2F48F83F7F0089E947C1B3EB8F0397241AEB7AA94ACCCAB120DBF2153F43FF0C;SizeAsReceived:7459;Count:48
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::f5f1:b5e3:66d7:e590]) by AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::f5f1:b5e3:66d7:e590%7]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 19:07:35 +0000
From: "Konrad Weihmann" <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v2] BBFILES_DYNAMIC: add inverse mode
Date: Thu, 30 Apr 2020 21:07:07 +0200
Message-ID: <AM7PR05MB6881328B43BF3B8B9C03AFC6A8AA0@AM7PR05MB6881.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: AM6PR10CA0064.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::41) To AM7PR05MB6881.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a9::19)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <20200430190707.16826-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ICKE-EDGE.fritz.box (87.141.84.123) by AM6PR10CA0064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 19:07:35 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200430190707.16826-1-kweihmann@outlook.com>
X-TMN: [dRRjSIYXM6A0vyJC0zP+jqllXg7iXlwL]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2299557e-de67-42ad-ec8b-08d7ed39be1e
X-MS-Exchange-SLBlob-MailProps: 
	0RSV28T7LqS1WaFHeL7vGo9RlvU75tTpo3hAZbE6CLTL/EKmQULWvZVxRqk6u4P7fohsBatUCKxdHpOe0pkApky8PLCfRUOkIKNltM3EKaQhdrKI/ZdkhMzbnCJBGonjcgHD7lFXl//QYqdzYjdlYIwwashhV0iYLETO0zvBB/M0KD8mOv4LSwC1UVwPc4UB0z0BU7SaxuiQDL4FtKNxnFCHZ3Dad1/LLx+9ILNpVkJ9f/wuFNDvnx0m9OshRe22h8u4pMWB6hHgcitC59bTYBJir1YmprmFDH0Mqbp0Oc/w5Q2pVePGdUCTjsQWG5zpZwbeEeCF0C1tOpkmWtBm2XNED0d9wLe3XdVmPma3UMlJsNWdrYFjNWXthAXw09R8NTKA5bhjL/3MUXKuADHnKq+GAIUZkYqhj4Le4A6wF8uYIY1s5cfHhJiCNHYLEiW1KhlTUro96W8ha+1r5/d2Wd31WDmABdOHZ6QeUknTz+mlP5age/fvOyBivpnypyCEGjYpkpXboJ17WN0mH0tmYDX6yZ9wEicUYkgvimHfismJKYTkmP9+a5/1Kdq9r5OqQcMA2p//Hgjf7APxC3RikwQoYMiLRvDz9sUsamUVpvxoKFjTwTKI5w7v6tjqngTZ9Ym+FzjDALPLTZXgFRl77qhq1FHRUcmGVpIp1JLnaDRCKwKk4KkXpCEchJDCgPg2
X-MS-TrafficTypeDiagnostic: DB5EUR03HT029:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SCyjTUalFboCKh2fm8sQ6ufQ18lofGRxZgYzYY1tAGLDgqtjGG0IkgGGhlh1xjZafxc8UPLeUKasOC+XrNMppNk2AAWwgMd4RV4xTeF+aFbuU07LOxVgbb+bWCppIuKAVPAHPHzx5AF/mv15UIpe2x+RICjRLLtR003ycqYR1hd6kpWByaGT4/fgWQ0YuyPA99SKd7CDM7cgPQnRAtnB4Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6881.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 
	RqVXE40Gg4UMKeSlcXb21bTtBj0KyH8e+abEDcjTJfbYaDJ4H+yYn8kE5EHC0HP295/f3Ifjr7pMkws3Krt2du4OpXohuzk6+AiB2aREqsSyB89cNwibK316ODl0ViCSqPKjyA4YtDviiXuyUPLyPg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2299557e-de67-42ad-ec8b-08d7ed39be1e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 19:07:35.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT029
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Add an inverse mode for BBFILES_DYNAMIC.
Entries where the layername is prefix with '!' will act in inverted mode
including given glob mask in absence of the referenced layer.
This is useful to backfill recipes from potentially missing layer.

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/cookerdata.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 472423fd..bf72a8b3 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -387,7 +387,10 @@ class CookerDataBuilder(object):
                     invalid.append(entry)
                     continue
                 l, f =3D parts
-                if l in collections:
+                invert =3D l[0] =3D=3D "!"
+                if invert:
+                    l =3D l[1:]
+                if (l in collections and not invert) or (l not in collecti=
ons and invert):
                     data.appendVar("BBFILES", " " + f)
             if invalid:
                 bb.fatal("BBFILES_DYNAMIC entries must be of the form <col=
lection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
--=20
2.20.1

