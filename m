Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.39])
 by mx.groups.io with SMTP id smtpd.web11.5037.1594328331831522402
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jul 2020 13:58:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=ozom8T1V;
 spf=pass (domain: outlook.com, ip: 40.92.89.39, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARBEUHcfo2ItpRheryL23kH33dR25RMb/x4YIoSfNzalybAWVm+KJwNZk8oz7Z/ZQ35YDjPOd5MoNBGz0ssGKSgUpR/6jo1ouCmnc9TLqaNLZ1/jF11eGwCmDUK6pCE1NWwctc8n1mv1O9+c7hBcrcYv9prbvOeDa+U91rE7p9v2BH7U0vE+RzH3bsG1p5T4TSCtzvBVyVvYfPaRPSLUod8AVbOv7jrAJWXsY84FwPuMM0NIxcQmdW4ZOyKXThqRx04hiayzI9m/uDBsWpzq7YhxHXS8BDJNojgExpcnDf2LBjLth7T/EVPLkVpxG106/SpvvM9bmlqkx7zLTmpXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc4ye9ncDrYbcGfvoleYoJT/KWYUuhzsMPyRKiAlXzE=;
 b=m89gFadiwobVyXBsd54Kdefa8hwIGYMi65JTkZ0tLj457iTkqeazu/rYv26CtmHySorANV/Z3pD3/hgYB+OILs9yIIvvLjGbpQerq0M8TqX4D62Q9QHLwndAYIAwyMrB5GSP+RAQj5NPHyttfuSVXRpUMYOUEW16njD3kjfcBGFU3LufozfSaYlUAkTWhuPNmxFS6z9fSAoLRFXdiKXMu1sNrXyoqC70pCkeHP+kw6BsLsRe/940+ket1yLXxeRPqiEk/sNKGeMteBlN6h4XUHc1bOpFiJiAlMluuHEMwOuTujwKirs+nhUgwbosbdNOuEqjdbPPVQNTz3O/4OVSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc4ye9ncDrYbcGfvoleYoJT/KWYUuhzsMPyRKiAlXzE=;
 b=ozom8T1VLmKNDRcRT2SV0wazEsAY9+SOKjYITiy8/4Zpul69c/Pu8+H9b3eLoQnOQg3TM7NRfSwZAbl6KEmaD9/Z4LcNqCirJwleRAruLqQs/tk18bgwWgBwpvTJUH54Wl2U0diJXe9pVWAsIiTsVewLSXYGLeln64PgQBJ4MehVpUmphbQJOVkkeNLqZ+wfCZz6H6R3ncjgR78YqMo8SZF1+DXRjVt5ftJfM453i4adpu352iy9H/PxTjwlyPb2EfNLDUyXZj4nlqhCqhXy4CPFTb5jSeVex6PbC3C3GZJ/2osywXFRDxCRTX6IXAGdRQS5n8woQoCDWSUTEraFhA==
Received: from DB8EUR05FT031.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::47) by
 DB8EUR05HT106.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::129)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 20:58:50 +0000
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 (2a01:111:e400:fc0f::53) by DB8EUR05FT031.mail.protection.outlook.com
 (2a01:111:e400:fc0f::449) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Thu, 9 Jul 2020 20:58:50 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:FBBCB317E83DD11EF000094A5F4A67F93BE9EC43290A833AF0DF4FD63F9E9D98;UpperCasedChecksum:82217C4D61ADAE7D3CBED8C79C3E7BCD0447605A6292CA263D3223CDA9CBBA08;SizeAsReceived:7398;Count:47
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722]) by AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 20:58:50 +0000
From: "Konrad Weihmann" <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH] pyshyacc: allow double COMMA statements
Date: Thu,  9 Jul 2020 22:58:36 +0200
Message-ID: <AM7PR05MB688169194901FA372A0CB0FAA8640@AM7PR05MB6881.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: AM6P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::19) To AM7PR05MB6881.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a9::19)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <20200709205836.3121-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ICKE-EDGE.fritz.box (87.150.35.214) by AM6P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Thu, 9 Jul 2020 20:58:49 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200709205836.3121-1-kweihmann@outlook.com>
X-TMN: [iZmN459SB2Gfi+0hTqLNNfr8g9oSewj2]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 55bd5cc1-136b-4315-67a8-08d8244ae140
X-MS-Exchange-SLBlob-MailProps: 
	mBRmoEB1kyJ3mPeice8p46l1iajLfZdb4WtagLsoGhtjFTV9hJ4nuHGGZunUZGEmHwXgpjfqZ9zPEaf/G3pF2oGoG2XgqSMR3KLkYjDIsr9aGWPpsqKWZ6bkmODiHA3BNLyJO/1WGqAYvFfuTnGvmpr0Wp5YSi+BeIcOdg/RGm5ZBDQLLRIQnrN//AbCwt4fgi0gSRKTqksaeyBmW3aXl6hfEhWipECiQxgyAbLULUjuuGBb87n55f4SML7trZrHGTR8+CL/aXV0wsTieOD70SM2VW2jHlB50xS2opFBzaIf/UoETGlhG6T7DO4rxJpqd/kslCU2z4uoVwkt5fiZvtVcQ8Lpi8LvoE21jq+Xp2kA9UJR7R6a6pnGHL5//Joq/Ev+9nsrkpWizmy/JY6o9xavvLTuD2G9kcep2GZv2R8WPcImICYMJvInv6KVbSfG9E5+G/y8QuaV/4uU7qh7bmFgDwEdqzbXf9t9RMCuD51UWG/0/Obh6a+u11pHg66gGcUUZAdLe45DHQ91X2m1gYGOdEw/ydx2dsX6lUo7Ccw7+WxP5pzdJGu5GiAKXI24EBUnYPJJEqkVLTCjJdLm2Y0Sg7LQN0c/iY5sengiVCwKLg/zalmbKKiBmePAzgUwt42fk9hsSBP4jfn0DtojAiKXxkwAMcYINlr4yZ5EiezrJgcAi1X1T4QUIM9QKRy6pHhTn9oWGAjl4l76/0CpVKkXyQFQ/IBknyu+m/R6eKWQMvJgIX/Sa9eqmzV5Fggm2lfwr7hU82I=
X-MS-TrafficTypeDiagnostic: DB8EUR05HT106:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wPrs4u56q7GzSQdFYX8Mbpi4UyFmVwu6l7/eiorSikTej+jDFQS9PR3nA75hYFdmJxEXPhiZ2GwqhOumc7s/N+WMrAFhWulCogPmsSrHAZ5P9mf+e8Zyh887Su9vY2haklmOFVAI786/IqVGwGSm4Wx34gFrIP5jjD+/a0v/8A7M2YTAifAIv1Xq8X34Gbn8sGPjG0QbfKt94nvzDkbInA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6881.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 
	lBIGN0bdENup2xvWFsBIvgei8vIMTDSfCYmSpfCuGmh3cw1/rnMwkby8/YIAMWP33+MNie+14PJ5xU6Hu6MbUw1BnwoRIa30GlGqi4/thkNnoxxLcY/M2TWulFimUEGQyzoTQcEDkaataAO6Ic60dQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bd5cc1-136b-4315-67a8-08d8244ae140
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 20:58:50.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	DB8EUR05FT031.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT106
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

this allows shell statements like '; ;' to pass the parser.
As it may be bad code but still valid enough to execute

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/pysh/pyshyacc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/pysh/pyshyacc.py b/lib/bb/pysh/pyshyacc.py
index de565dc9..924860a6 100644
--- a/lib/bb/pysh/pyshyacc.py
+++ b/lib/bb/pysh/pyshyacc.py
@@ -570,6 +570,7 @@ def p_linebreak(p):
=20
 def p_separator_op(p):                =20
     """separator_op : COMMA
+                    | COMMA COMMA
                     | AMP"""
     p[0] =3D p[1]
=20
--=20
2.20.1

