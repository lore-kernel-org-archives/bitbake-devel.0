Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FDCAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 00:06:59 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.34])
 by mx.groups.io with SMTP id smtpd.web11.7738.1757981218163140012
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 17:06:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=fwtFwE2B;
 spf=pass (domain: axis.com, ip: 52.101.66.34, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utKUY6iLXqnmrGKd4A9DD9nM+7UoGDxmHgWZDmRsaBW07gNt4QHpn3ZSK+I9TBW6KOk08zvpiHABP4ypVLQJOaN4v1PLy+hhV+Ap8aae04xrda0JYxr7AGjFmrsvFkr8JgjZz/etbuoumPJBfRMD16/6yZv0iTouKk0+omDHibceYuYAc7bNJjZMrdokjKYqCVI4U2Jgd8neBb8OxtqRwoS8Ceg13DrO8nbgTA2Ve/cNkXOK+nAcI4YQTRhy9lTMKbv0wxs6XI2ro7BEGZz+g3VvCgN3nd8XTxIB9zzM49po/+W5pMTF9wpguyJlIBQuYPqOu7MRPrF4Ajo52e7HAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC7KwzJL51QHS8BOuoN5W1fgGCG3WefK70eZ5E23Vmc=;
 b=TZfqzueGJxewov5VD2h/QOAxlkW3/MK9rg1j6PiOsFWYj2MdQBxYyXTKY67FRynJLGd2ZTSaghSYf82PeEepdJ8W49kQcrOQxKzXpkdQY8AiTjko20RF88PeQiPqDFsBw9mgm7wvWYnfvmHndN3Uv9U2ciYR7Dsel00RrUGynkbUbJHqwh3b54x92m+TyUhzwP38L6PT2MMouoa8aOOc7E1uhCsMwG+XBsGJPgii6KPqpZOQ2NRthrWXLeHOXiQ4BGWe6Ssvsa2HXGUsgYfVtptpVsy8wAgPmiYQEO8rLu7xH83pBkfpUjDK00kPhLXImsRZpnUQNGkvG8yBh4PvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC7KwzJL51QHS8BOuoN5W1fgGCG3WefK70eZ5E23Vmc=;
 b=fwtFwE2BpPet1iqZlSbEkFBUzSu9im/YSoeHf+ODGFHdcAIbokAyIJicuoNzW00gbidl1BYUSs0tmmwhg3CcXgvhWT1F/WsoLYSQ5SjlsBGol4oLjWf4WAfDPw4dS2WyO2Pag1zYQy04+X3ifKoAcc505EMKO2ep9RQm9EUl1MM=
Received: from DU7P251CA0017.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::8) by
 AS2PR02MB9166.eurprd02.prod.outlook.com (2603:10a6:20b:5f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 00:06:53 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::bb) by DU7P251CA0017.outlook.office365.com
 (2603:10a6:10:551::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.19 via Frontend Transport; Tue,
 16 Sep 2025 00:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 00:06:53 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 02:06:52 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 02:06:52 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 02:06:52 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 1ADD3209C
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 02:06:52 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 8731D12021A; Tue, 16 Sep 2025 02:06:51 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/5] tests/parse: Remove unnecessary calls to file.flush()
Date: Tue, 16 Sep 2025 02:06:45 +0200
Message-ID: <20250916000648.1182372-2-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916000648.1182372-1-pkj@axis.com>
References: <20250916000648.1182372-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|AS2PR02MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0a6374-0101-40b0-4851-08ddf4b4f173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rrs9j6s+bBVOlPY5sDWLwSmLKO2dzoOP4HhHzZQPpCiZhXWtglGwvczgo4Bd?=
 =?us-ascii?Q?0Tqyh18/uLxvNoNm9kPcNsCT0PZV8qALCmOKTvfMZOblDKCzmp+nRWqWp2U9?=
 =?us-ascii?Q?LIP4tyW82/lFfwoBDiL1S3NZo9lCPmamnRa3m9oap1PYcWB6PKhfdAKhqp5u?=
 =?us-ascii?Q?yRkh2GamnjA74RBbt/UHwLsSMv0QbZwnAp90HwrsG21ahP7Rjnqe/dI6QJaP?=
 =?us-ascii?Q?TEy1r1oPPXQQDBPn0leFerul+nq8bMp/pihfeRqcc78A5Ky7zZYgK8gr9TNl?=
 =?us-ascii?Q?q/yTojIWhhtoccKtTL6z1nQLb1rvOvyuv1GidsnbdEwOqeITQa62oT6b89BE?=
 =?us-ascii?Q?yDU2MGTjdj8xW03cAs7Cv4hoPZ7EIRBv2/QmnVy2tNKo2TFjvOs/EolfUf1K?=
 =?us-ascii?Q?zDz+kqZAvc01HoRNpAQFU2drd6xjaqO1P5hQbg3NLwiy3PMWqICz9airFhHY?=
 =?us-ascii?Q?sdtvaTkPevwZ9uMPgLeCiPvTid4GHxYF82bEWliTEmCG2l5ExV8RTCRpDagg?=
 =?us-ascii?Q?4xWD2rOuestqqV/bRbeEDT0NiIow1Riod9u3wuMGyMN04DORDTjoyHpk9n0N?=
 =?us-ascii?Q?bgEv2tW7Y4Rt8Imdfz3p3NT+FfO9zpu41BZWGvTo+M0YMrUV5CmeJqPoabls?=
 =?us-ascii?Q?kqYLdAN7gzGYP/2knPumN3PrWJ+YaBCz1vHsheiZIIeDtmCsWaMLgdjlks7R?=
 =?us-ascii?Q?KJ7xpHlNZGchaTt8bnekFkObd/D5vGDUaYZZmnZ6uCIMIWOxS6sDI+01i1n9?=
 =?us-ascii?Q?5bOnF50e71xw4EljeXdENKWNX6nkxiWvdSPRQ4JNKYi0Expy7QixaZrh/gpU?=
 =?us-ascii?Q?BQJ37Hg67M2OJPT+5xPnVY/P0vXu8EkJrUgXeStEN7V4S5snljuIXwahMAkn?=
 =?us-ascii?Q?+ZHUSNe6a/2ivLVObElkg32PM669BdOiUFhUMGj2aPplV6yl+D/Jiu4VJLyk?=
 =?us-ascii?Q?EEm4Y7vs+TcBETH6iTgm/xZF6Ut1XET36NrQqiLiWpmTw47WOx03PEFTPXzL?=
 =?us-ascii?Q?WmGMnLlO/hv0Ph/6Iw4JNLuhMN18PCnPepF4CiGqf5qM8WHh1eYQdPDrSFaS?=
 =?us-ascii?Q?JkOyFqPZKo4zE3XIZFpVFWqj4FCsgQdZmfSizCTV1wH5/WC8bCngNOHl90lz?=
 =?us-ascii?Q?ZJbFiy4gDHh+r9rTTVCZNLsL42rs8CwQUOW9OJdczjStQ6iVhCa3Khx68ugQ?=
 =?us-ascii?Q?WGPHYAJuYjFbbhW3UOGVQyg9tl6xMldK3q3L941j9U5/r/4VBYQaW/Ui9fsH?=
 =?us-ascii?Q?5Nw6sZeBKAXmCaLVECtkA5Eiq9kELd26xvtd+9J5EG3Cr4GjC0nn6W7raM93?=
 =?us-ascii?Q?9x6xi4OmJFLJ7pX+gv1zGDnCuWVZ3SsKh0bqjVc4z+k5xP7NCP3Orst1Zt3G?=
 =?us-ascii?Q?F0rAh5YL+zWHmAEWOEk7A0QAQb9fWgtjKHzoa/kirkhjNez+m9R5itsXGC0a?=
 =?us-ascii?Q?8l3MXh25FGE2Ba6msT4FunYKmlItdn1V1px6lFRx+zWfpg6s2TpTYFwgMLyp?=
 =?us-ascii?Q?tIsrV58OhEXBmSYF91y7aKBDtTOkVK7mg+fx?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 00:06:53.8140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0a6374-0101-40b0-4851-08ddf4b4f173
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9166
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 00:06:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18038

There is no reason to call file.flush() as the last call within a file
context manager since ending the context will close the file and thus
flush it.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/parse.py | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index b272739f56..431b0c7d3e 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -349,14 +349,11 @@ EXPORT_FUNCTIONS do_compile do_compilepython
             os.makedirs(tempdir + "/classes")
             with open(tempdir + "/classes/someclass.bbclass", "w") as f:
                 f.write(self.export_function_class)
-                f.flush()
             with open(tempdir + "/classes/secondclass.bbclass", "w") as f:
                 f.write(self.export_function_class2)
-                f.flush()
=20
             with open(recipename, "w") as f:
                 f.write(self.export_function_recipe)
-                f.flush()
             os.chdir(tempdir)
             d =3D bb.parse.handle(recipename, bb.data.createCopy(self.d))[=
'']
             self.assertIn("someclass_do_compile", d.getVar("do_compile"))
@@ -366,7 +363,6 @@ EXPORT_FUNCTIONS do_compile do_compilepython
             recipename2 =3D tempdir + "/recipe2.bb"
             with open(recipename2, "w") as f:
                 f.write(self.export_function_recipe2)
-                f.flush()
=20
             d =3D bb.parse.handle(recipename2, bb.data.createCopy(self.d))=
['']
             self.assertNotIn("someclass_do_compile", d.getVar("do_compile"=
))
@@ -377,10 +373,8 @@ EXPORT_FUNCTIONS do_compile do_compilepython
=20
             with open(recipename, "a+") as f:
                 f.write("\ninherit secondclass\n")
-                f.flush()
             with open(recipename2, "a+") as f:
                 f.write("\ninherit secondclass\n")
-                f.flush()
=20
             d =3D bb.parse.handle(recipename, bb.data.createCopy(self.d))[=
'']
             self.assertIn("secondclass_do_compile", d.getVar("do_compile")=
)
@@ -418,7 +412,6 @@ include \\
                 recipename =3D tempdir + "/recipe_unclosed.bb"
                 with open(recipename, "w") as f:
                     f.write(content)
-                    f.flush()
                 os.chdir(tempdir)
                 with self.assertRaises(bb.parse.ParseError) as error:
                     bb.parse.handle(recipename, bb.data.createCopy(self.d)=
)
@@ -434,7 +427,6 @@ include \\
                 lines =3D self.export_function_unclosed_tab.split("\n")
                 lines[3] =3D "}"
                 in_file.write("\n".join(lines))
-                in_file.flush()
             bb.parse.handle(recipename_closed, bb.data.createCopy(self.d))
=20
     special_character_assignment =3D """

