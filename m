Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3759CD8C92
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 14:40:10 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.92])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56208.1780929600378540772
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jun 2026 07:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=psv50Jkn;
 spf=pass (domain: navimatix.de, ip: 52.101.84.92, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XG7gKrLeW4OcVFqMUnXGcRJsiRG6+Aov/4nDC9JMR6bOt8XO33+poPjsUwbmiaOXaj641XjkuIZr7wxvbcKfKQ3gp8ye7bKLhg9TQZA/6Qrais2+cW9cjmtF4Ko302PhkQqvR0G7ybIIz8IQkL8UUtkPzX19o7Hla30GHhhWabhIXymIuxfn2sYrTw1J/AoaWPfvv/WpiYF59Uj5kTYkwFZduYqs9JOzeDtSMjWcIMWP2vhhhK16B1GyRrouGLlULa7crW39ncEMVQto29EHHJBjxKYbtSRxyAws72gQJI1xAF0aC9tsda1P8EhKtNISr2rILum02tDGeHR26IwUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqQVUVZYktZjBQ/Dw6D7ACgUeDkoMOrYSUIxRrvr+mU=;
 b=niburyFQ67gCGrnoF+hNEtFfLYkcLp5e1ina0GRiRdwSWdATIZk88wO2/p81eJqW+xumaWyL7Pznybudv3tH7jp9+7DGcB9b30MgttimV+FxUlfAg3uXHVErjZZGboDwpunTRxvpTcgX/KsQdxReXPoS1R7KyFqxBYjCRaq7FJKtfE4iaV3caqJsdCpaPSWz38MlJwVLThR/hiqGFI6mpw+dj2pG3YIgGZHywWC7lp3Hu4K1J69E+DFKGH6HH8Q0xRnDFqljYSEYE2CjKKHoA3r/9pnIefYVvfU1YxMMJeya2t2cXPjayZ8/Sois6JG3nlp9uzIOGNIyUcHSkoIe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqQVUVZYktZjBQ/Dw6D7ACgUeDkoMOrYSUIxRrvr+mU=;
 b=psv50JknuzhDS6Ojm6qgKV+luDJyA4v1e+eM244b69Fjd83dLue9TfBEBk/bSrp3WTADn00V7AyxwWfbRarnJEgY7QFomuwKpo8hcmS7XmSf0uaHM7MaWXMASkpdqqI7/ZbfYwUSSNdWqsG6PUgKC57FrUq7mTTe8Es1rishqxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by DB9PR01MB7868.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 14:39:56 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%3])
 with mapi id 15.21.0092.011; Mon, 8 Jun 2026 14:39:55 +0000
Date: Mon, 8 Jun 2026 16:39:54 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: bitbake-devel@lists.openembedded.org, joerg.sommer@navimatix.de
CC: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [PATCH] utils.contains,_any: Fix description of return value
Message-ID: <63bcd3253c3f7cb372c4e9a85f86473ffa1633f7.1780929593.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::17) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|DB9PR01MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d4f8ff-17b9-4e72-8589-08dec56bcef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	4RdTgqK4aJWQGo95S/MwWXHC93mYmuf2qjyp8peWV8AYon5o9ZHeUi9JdocEg6/Caei94BQ446DfL/O4soWS9cNXzhozNcxIyX5xZ9emd1kwW3oKW20UKKwaomtSWxZnBTglSvp53pLJwq+FMW10C6mrrUAO/E3S4F7iiZFmPfDKywN0tvN6w7f49RnxZ8epTl0geZaRxO/bIkH8KACubeVWxnwnk7jSLaPELFQAzHYtH8aAOH9TZYLSMtHoDHIdJrXxrsuxljzLn9j3awEe+rFplB4sBTbMtN/Iy4Q1xnbBJ/yhP2hsRRbd1RlXu9isbCXgi0ba7YrTF6W1kmhlW1Ycmx4bQn7pib60qJH2rlQLafBOYzat6k0bqFf00OiA9Qi/cKWXs3xnQY8CfHIorFRpkuXD7GV8PoRXq1yW77XhZupPILfTPINLaTrzpF1Py2YKBq0GdlDvBtt9HX/17rX2FjFRJvE2HJRZFkpv+By+/2L04K8dRaWfvT0xdob17Frm7RxkMfO+izahX+e1BMK8a1WQbtQZyucFvGJkrTx/Dv5tzpGBq39OlbwVhPfHwuOyhmOjdoPSSaP35TAEviJDHI7ZKZtaHVOW3v6TWTiyZT8SToJWMMPTLhChRMq6YDKZr4sOQMO4QnO7hcyZB8/tdqngGFoMNC/WjApt9qYlQU0yhY/F6peAzIDyX0SQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RdNBH5/8nqZzqoNsV+p1hG8O8/ataFM5KfC0gwZQwFvnazxzRE6gJntAE/WK?=
 =?us-ascii?Q?YrfnC2w5ZzMkAUu/wAeF5kQVVRYQu0njz7u4ky/vknKn3Vx1EKsiop2wAJ3t?=
 =?us-ascii?Q?d9NAjjjQBoJP/Qy3lcVrh+lrrssGRs545zHYBHE6MO2JonRLhSTxOxj8dsf9?=
 =?us-ascii?Q?cKmKwwjwBtchM/PDlx9+Zmy4PePdl3kyCgYw95sz59CJVulx3XnmJ8Yhb0/A?=
 =?us-ascii?Q?A2wQrmthW4ldeqtr3HXlS143PK2Ta8VCmZuEZEM17VIrBhWqI0hc0teH9ozk?=
 =?us-ascii?Q?iQDseCCrcts2FtKNd9b+yyGZ8fWLKlwXUc4605upY0M4E1aEJS7g1Doj5y8t?=
 =?us-ascii?Q?F5CGKXYpeeG5I69kHjgRosVB/1elthp/9sFRIj20QxU5DigRd/SObY/JFLbS?=
 =?us-ascii?Q?c8N2wYYslcS+BO9nKZVyp3jvIQemFjkR5J0WHTSZ1lnUBRX+cb6QJOFayqdt?=
 =?us-ascii?Q?7/epOzB32r/EFnbWfUpt0nd9rfNwaCEk9+FpjlSxsfadE2U9dB/8IEXEbR/N?=
 =?us-ascii?Q?4oPLPoWWC4mJInlfJxGxV3aXGosQ66EwYqSYERX/0BZSz8A6lEw/Q6utxxoW?=
 =?us-ascii?Q?Vcid5BCKer684Ss2N1fRVqneXQh1r7DKroD7T4YIfwooU8dv8EGBTsK0HUxy?=
 =?us-ascii?Q?BJLPPgkVaYZBVf+RgSlxiWoNFU4vZGBJnMsxFfzUQBA527+b5pSkMjnUsFlN?=
 =?us-ascii?Q?2PJtd1cjrhg9bClrUjGLjXwzpFgN3d1tSCnDlApTncYfSeITBan6SGhvikUK?=
 =?us-ascii?Q?hJLLe/ygvjaXzdHmlj6QPQCMDLnpb6C4EOoHgTUrSww5hsr/rfSNLBF2OUH9?=
 =?us-ascii?Q?fVB9a6jiL+qtLfUgHcDLHFwpABJXmWxeEFVc+taq/0FDr3gR8iwvvzNtzxrm?=
 =?us-ascii?Q?zG5Jqy3emWxiydpkkxbGNZy5nkwqmo7LlE7ML7C++Ega7wCrp1XUfej2/ChH?=
 =?us-ascii?Q?HF6ustLWbot16mYLAf8yKvQodIdkPtSti76IurOX+q0sN/ZQnBluytBrrm9G?=
 =?us-ascii?Q?x5YPlrB2zvLfUEKSLhnwGjvWwmblb7G8VKDr6ywSVNjMcqL3EO2w0gFbQQUG?=
 =?us-ascii?Q?uqgatboixLq+vEM6eslFRLgrrBCnC/rt0SS76OB1Me7TJrGMaNTt7O9Wb1Ou?=
 =?us-ascii?Q?6qYmSYHvNpRCUBuRnQk0SGJvwQgvSOt/zUfyJz9HrR4puPwuZQOPxz+2TOKm?=
 =?us-ascii?Q?qaQh/V8civezuo5XY+2yQ+3ooYqBvRKUPp6Cyf1N4842a74XA5WWRPTOJhFQ?=
 =?us-ascii?Q?rxYZpBGzgNUREbIb8m55BUQnXSteU5MyCfVA1nAzO1rKy3ZFdb76ofVE+olz?=
 =?us-ascii?Q?IMfIC0bu98PjIoqJ1NDrL/2NlkNYlre0WpIFsRVzkrJby5T/NfgEcSJW4Hgh?=
 =?us-ascii?Q?aQ0cFc3mb5oMJ0w/N1r5TosN+JBY9iZ2W1RSMYaxKplIeJUZQweTJjKPoTIV?=
 =?us-ascii?Q?1DW0eq3vqnpp/gIqhxYJmXUt9ixLIj9B/FprzfeHyne6NfUH4q+epSBrN6DB?=
 =?us-ascii?Q?58pEGxqoSlpPKKpvRldFCkfXjygCK+PgP0h/BvvUa8bgw7vecKT/FKUH6sd4?=
 =?us-ascii?Q?qNu0OiplVT8Sd/9B7G5Ds0a8xvuMMj7KnddrOULvoxFSBqlwNYMqCmiPMo1K?=
 =?us-ascii?Q?xX6ggPVvl2oOEo6s1zf1U6RbMttg7bydV3xrGaHWUTS5M2kfauitg3BVEptC?=
 =?us-ascii?Q?UAZZ+mjquyo0btxDUiPv3WVUZLFcSFejYGc7w45Qj1ietqYgq30zI3GBtVVn?=
 =?us-ascii?Q?7K7ZqFSqWqyZ4BIFe7+dIFJhfX2mcJc=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d4f8ff-17b9-4e72-8589-08dec56bcef1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 14:39:55.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0l0J4g8kGULM1AbDrAguLQTlMByldQc1+48OS9GdJoQpZ06wgWzvDqw5sriQ7VOqPipGAGWmy8lDzNlYYCt2q/mOXYAi+K3bAM/O+ezHQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB7868
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jun 2026 14:40:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19633

From: J=F6rg Sommer <joerg.sommer@navimatix.de>

Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
---
 lib/bb/utils.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f03c950af..181082c95 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1291,8 +1291,8 @@ def contains(variable, checkvalues, truevalue, falsev=
alue, d):
        not a subset of variable.
     -  ``d``: the data store.
=20
-    Returns ``True`` if the variable contains the values specified, ``Fals=
e``
-    otherwise.
+    Returns ``truevalue`` if the variable contains the values specified,
+    ``falsevalue`` otherwise.
     """
=20
     val =3D d.getVar(variable)
@@ -1321,8 +1321,8 @@ def contains_any(variable, checkvalues, truevalue, fa=
lsevalue, d):
        not a subset of variable.
     -  ``d``: the data store.
=20
-    Returns ``True`` if the variable contains any of the values specified,
-    ``False`` otherwise.
+    Returns ``truevalue`` if the variable contains any of the values speci=
fied,
+    ``falsevalue`` otherwise.
     """
     val =3D d.getVar(variable)
     if not val:
--=20
2.53.0


