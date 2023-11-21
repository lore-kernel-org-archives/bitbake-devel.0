Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD0BC61D88
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 02:10:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.49])
 by mx.groups.io with SMTP id smtpd.web10.25729.1700532598525443557
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 18:09:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=XPTE82T7;
 spf=pass (domain: axis.com, ip: 40.107.20.49, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttqn2UyAWaI4uHOyC4dk2D21I78OJ6eaDeCo8LsMUHDRgDUjn8UjhaFUKzNpFxd6lL5+LVcgGGwe7zQbkMFN0cyOFW8w8MIBqcJBVXbudb75ubQ0IcfiMI5wvC5h5IGAAc1d0SCrnHWWqIEMSsL9pBmEJHwJqkRwfor3kCI4nFbQ16u2slgjd0xIbFRT+D70mmDkGpn5XdoS6Aen/74DT4xDYACgDzKG7ay1Zur6GiF+HiTewtm+BbV8OQaCRJJwAYZT+K+gEUappp28ngfCwLKOa4ONKpgI7Pz1Fachq1q/9NO/JGXOUaiRQkUxKobFpM/4o6q0/fjo8KHBmBwcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0k2YikoAcJ7fk9Rr4UALVIUwEnUiscLhXwFi8qiTno=;
 b=VYJQipdsmN68296ElaOam9B5uNYAYj18BNrZEygW6PzoDqU3aYmsJ5/lmysJEodPvqwI+EBvZBafj5f8ddKYCpJhQzBDA/4XxFtUh9hZB81vWTifcBgP9guZMge0kEI9I5pMFi3Mmpfl/XHL1T5CDagVPQfjQS+U2AeN2NoWQJGEpBFwP/SweSt8+d+AL7Db6d0ovJSc0DviVdEViVTyrUUobNwCY/M6rVpWzo8lagpbV+y5+XCfZxUabCKCvVJr+CAKgg+D1BiCF2i/6WnbG1IdqbYgCoLMdPL2cPTyo5wyhKrMwSu4g+pv3sgKFN2SKAZMuBE8GnmEv/5gVHsEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0k2YikoAcJ7fk9Rr4UALVIUwEnUiscLhXwFi8qiTno=;
 b=XPTE82T70jDpO0kO6daQfHcjYEaj6WJ9gvWmRe3MXCpkJMlmm4ir0qmQus4AFwnBj+J82/uu0hN9oYzWfFzqZtdUc51/Xn2wIGCtWttG6Br64nIgWW++6FoDEUaqbz5E8F9iRW6Xo98CXwmfVyTKWDDCYAYgHLAaTnzb2hseW+8=
Received: from AS9PR06CA0613.eurprd06.prod.outlook.com (2603:10a6:20b:46e::34)
 by DU0PR02MB8715.eurprd02.prod.outlook.com (2603:10a6:10:3ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 02:09:55 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::3d) by AS9PR06CA0613.outlook.office365.com
 (2603:10a6:20b:46e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Tue, 21 Nov 2023 02:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 02:09:55 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 03:09:54 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 03:09:54 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2B698E43E
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 03:09:54 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 3AL29sc21069254
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 03:09:54 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 3AL29r3k1069252
	for bitbake-devel@lists.openembedded.org; Tue, 21 Nov 2023 03:09:53 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] cookerdata: Be consistent with what type bb_data represents
Date: Tue, 21 Nov 2023 03:09:50 +0100
Message-ID: <20231121020951.1069234-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|DU0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b08512c-a325-45bf-a967-08dbea36f451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nP6KGZVtLPAbQHZ5ILt7A54PISSIf+QGYNJkvRXB8T7+VYN9yp7a8zZAk/DOI4DSy6Ghh2u+T5ysngvJk6miRV26svyty2WzL5weBPXA6gXFT8EzM5hAJNfTHHZQD4iqSaDQyMhpKWQ8z2W1U+hM0OSwfZsIOjgArqfGdMf73LGl5lHfvN1OoM8t8PCp0/V7l8cVZ6NGouWkl28CEEDXoVh0LMWkIWmcf7xkn7gXnbavjLkgWWuzlITxf2tbjPB0ljINBsiEGh/RYUhcbuM+n3/suR320ZxZ0m+RLf5PjtNw3BsbPS0wgbIrrVNXlL3XkAjDmeMgmpUdvV7ARo/O3UoGd1oJ0gUJT4leRxgipSl9odA3PwuGlergwGwTr5CrfruLZzlq5EMcGXSV4nHYxixySpY+wyBEKY7Y4rQDQLVynZOyxS9zSshnpGr87Zv+OaNuep27dQUG9zIChdUKdcJWBaCd5r0gl0pTpWdJp12Q0ilONTTdkCqxLPZEuawOPWHivUHQ4j8vdlHpFLX7u3ecO0sq3IfFcO7P7R/UdYJoHV+ClO9CqPzqyG3xAYlzD6cv9w6rh9fjMwa8Kmm2AhzlsAJkP0rt93xcX//WW+IV1RFxlBtEpwN8mV85SMrBLw39F+ZX29g4xj7eyzcg/ifQbrwEzdyeqUjCSqsqWaJMW3VbGimmzpF5eXjNNgVh5bBygrsnwNuJtx0QXk3CSYGhKnZLdsPOxyrLWwCmEME8jXpMaxOu5lZT+saAaJgLYipuLQ0rnI7UZipEcHiwFQ==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(40480700001)(41300700001)(8936002)(8676002)(70206006)(6916009)(70586007)(42186006)(40460700003)(316002)(47076005)(1076003)(26005)(36756003)(2616005)(478600001)(426003)(336012)(356005)(81166007)(83380400001)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 02:09:55.0714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b08512c-a325-45bf-a967-08dbea36f451
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8715
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 02:10:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15543

In _parse_recipe(), bb_data was initially a datastore object, but then
after the call to bb.parse.handle() it was all of a sudden turned into a
dict of variant:datastore pairs. At the same time, parseRecipeVariants()
used bb_data for datastore objects, while parseRecipe() used it for the
dicts of variant:datastore pairs.

Change these functions to consistently use "bb_data" for datastore
objects and use "datastores" for the dicts of variant:datastore pairs.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cookerdata.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 42b8d64685..0649e40995 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -503,8 +503,8 @@ class CookerDataBuilder(object):
=20
         if appends:
             bb_data.setVar('__BBAPPEND', " ".join(appends))
-        bb_data =3D bb.parse.handle(bbfile, bb_data)
-        return bb_data
+
+        return bb.parse.handle(bbfile, bb_data)
=20
     def parseRecipeVariants(self, bbfile, appends, virtonly=3DFalse, mc=3D=
None, layername=3DNone):
         """
@@ -516,8 +516,7 @@ class CookerDataBuilder(object):
             (bbfile, virtual, mc) =3D bb.cache.virtualfn2realfn(bbfile)
             bb_data =3D self.mcdata[mc].createCopy()
             bb_data.setVar("__ONLYFINALISE", virtual or "default")
-            datastores =3D self._parse_recipe(bb_data, bbfile, appends, mc=
, layername)
-            return datastores
+            return self._parse_recipe(bb_data, bbfile, appends, mc, layern=
ame)
=20
         if mc is not None:
             bb_data =3D self.mcdata[mc].createCopy()
@@ -543,5 +542,5 @@ class CookerDataBuilder(object):
         """
         logger.debug("Parsing %s (full)" % virtualfn)
         (fn, virtual, mc) =3D bb.cache.virtualfn2realfn(virtualfn)
-        bb_data =3D self.parseRecipeVariants(virtualfn, appends, virtonly=
=3DTrue, layername=3Dlayername)
-        return bb_data[virtual]
+        datastores =3D self.parseRecipeVariants(virtualfn, appends, virton=
ly=3DTrue, layername=3Dlayername)
+        return datastores[virtual]

