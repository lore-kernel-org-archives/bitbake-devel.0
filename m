Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79FCFA45D
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 00:08:42 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.288.1763683711952157667
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Nov 2025 16:08:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=ICdmqREP;
 spf=pass (domain: axis.com, ip: 52.101.66.2, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF5h1EWvRvxL4SvmbHQmWOvJumUpcg3/xVIV4SCfwoqvIPtXyaUv1lwgeVUoO6GcTQ8uxTCYg66qf4ROmpK8iA5Xqv1XacDRk/4mwnSYMz57BraTEOL5KahDmcq3MwzpSX7UnoUcgoyDA5ZRi95HPJZ7Ls9G3gFp8dNA4kWCiB9xYsx2Oh+w5PBTmR1YkEnkNHZvlhJwgEc8QMJfApb23trVdM6nYUewCv8HR4rl3GMDJ35dioFKKCZfC6S7BizXaBSLSmdUrj4pX80pCvGkoRC0fkCmOcosepaOOe9ZbdWCLOijgJORUgdYMz2hFyEIF4+6PWpfOI5WCb+YfadPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMdW8ZarikQ8Y4XhrxJc2mznWw/fJfEqVAuuhhZ2+ik=;
 b=EANVzM+bqXMAiQDy1I7c8/GfV3EUPY0aX//nQVUmw+6xZmJ9jw++DxSqzzRPk30rwEb1raMdbrWK3gnjxs3AKjYaEmEYmonvQ50EdnQCAApTzIFlj+iVgM/ntv5zkojefBVf1DXmSRYXFozj3XXb0zacGxdvUL3cA+wgmLUEf5tu644E/0M5UV0UerqjQbTFm6vuKD/t0SvHkBjl+u54pJb1lcLD5hhnB0scocHISF9z42r0Fb4GCXagpXW8o6TdhJBXTUfjtYt3KtfWuYvYtSpKEwfdyrwWIzsNjGG0twNohlfCT+f8wzslxQTWNBrMyMhTC9+7HV4u7ec1rynjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMdW8ZarikQ8Y4XhrxJc2mznWw/fJfEqVAuuhhZ2+ik=;
 b=ICdmqREPHZxLHAoPLmyeaC1wOkjh2afhf666fN09bdaNR5ijvHFkVTBk5/oCqSh8mzuNtP7LGL3tVst/8FMG91RiQ9yFpErKp16N08+1BssIKnKulgbTfa8kJV6vbnQ9di+OQZQwPha3O0VGZMZjNXEiW2EL5WN0SSqqPMyn3Z8=
Received: from DU7PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::23) by PAVPR02MB9307.eurprd02.prod.outlook.com
 (2603:10a6:102:30c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 00:08:22 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::2f) by DU7PR01CA0040.outlook.office365.com
 (2603:10a6:10:50e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 00:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 00:08:22 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 21 Nov
 2025 01:08:21 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 21 Nov 2025 01:08:21 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id AD3312911
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 01:08:21 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 012D312058E; Fri, 21 Nov 2025 01:10:09 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/3] ast: Improve output when a fragment cannot be found
Date: Fri, 21 Nov 2025 01:10:06 +0100
Message-ID: <20251121001006.3756451-3-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121001006.3756451-1-pkj@axis.com>
References: <20251121001006.3756451-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|PAVPR02MB9307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d794f59-23bc-4704-0ed8-08de28921557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4g8z4oG8GWfwWYMaDOfb0RJIuZt3wbLK2mXuDrsLmoUBFDpLOyo0aAPP4Q7n?=
 =?us-ascii?Q?Xp0GDMQhpVjxYFrgfUXbAO4l10EZKGC6nuhiyt4f+1psAcSZ2waXEJ5xG3/U?=
 =?us-ascii?Q?M0dUgTuxN2KDtuz76B2gXAzWrKkZyHVlIg2IQNNnLwYNaSI934dsyAtOdfI6?=
 =?us-ascii?Q?dCp6JNCebYIxan1hkC7t2eI0Gk9WqbhYLIx0wtxT5LOsEUXHEF+8UAc66dMa?=
 =?us-ascii?Q?msEWU/M/kfuXBIYFjWRAlj7d1tQYEZtZMlcRkJLxZhpMg5uriEgOw0uDHUW1?=
 =?us-ascii?Q?c67ItglCwOidWq0L96ce1feJZpqm2nKVGbp3KhL9GeoL7zhXwwKyCLdchIzr?=
 =?us-ascii?Q?eTrNnv14+Maym2bzU8YBLbvMU6jDh9D6ODELQnEVLEuWzNhi8U8QstWW1fS1?=
 =?us-ascii?Q?0QHmLZdYfUXo/zyYRkKurKE0re3rpuVNSd+0ovtp1p+0xixVrcve54eYCAz5?=
 =?us-ascii?Q?yBhNikS2eOBaOqS72nGXstgF8cWfXKHbrm3tcN1V9qyLM8z5idwOcO+7Oz6M?=
 =?us-ascii?Q?H4iD3NLB6LfYfCJPCZuOPLFXK47Sb1UJsTRViPVCh34+odE5YqX9inuv9moo?=
 =?us-ascii?Q?XZkG2hRvTEMZ6+8fKNIJfYpHSCvt08d9Z8pQgaDS0rkA9IQYTR5+ffXbdKML?=
 =?us-ascii?Q?tVlP6KKtVx8s9Nz3lbHV/Ly7g6DJK0OeEiJTIh+dPBcPJvoHvDxV2AtyHW6V?=
 =?us-ascii?Q?qauvY4qBGW7p2uUHWC6s/dSfZDdKhnToho+Ho/Kmrsj7uJE56JOHnZ+SYbaO?=
 =?us-ascii?Q?l7JMs4hw3oWPAeLzt+YAJU0b3UM+dEcXiQLQF4S+7fqaI+GiIHDh56OhkyUv?=
 =?us-ascii?Q?LCO22xMTZPrYuDmnzcC6ghmJtpaiQqj1w7CuWkvgBpNrPdMwOYocXnT+9Xz8?=
 =?us-ascii?Q?ct6SpERw+dFH9V4cJ3LDnulbWU9i5/N1H4xpPFbaZaNYUnmRD+w5DgyJ1y9B?=
 =?us-ascii?Q?vCx8YJC6eYb363wpABXo7EyM3R3V/UwrXcS6Cak+bCnsrKbgCNmZMqqrgfKF?=
 =?us-ascii?Q?0cEugj/A8Zoa20/wU7eW657pv71l+rgR0WKIL8dBKY8WovMDrlaHV+rE0c/3?=
 =?us-ascii?Q?iimW3C/3eB2cQLHs3jZae8nkuKiythzwGAna/rOFYZokIy+SM6I5ol+e3rRJ?=
 =?us-ascii?Q?LFag0nd2sPDLlFxwrIIDXrA9izh6hlC4L8SEz5QActFXZ1bvV6yvSjPiWAcU?=
 =?us-ascii?Q?fv4qxaZayeIAC6soitSmVW3klow+eJDZcd+RG5LG5FE2GfRXqTf4QITqyY6A?=
 =?us-ascii?Q?UUO+9N2otvtW3CmT+N54+wuFkFJPvEEiWeo724a0ROC16grjaLIZEUQnK1KX?=
 =?us-ascii?Q?a0tjPYuXWYDbcxvyYdddmZBlvUJfHrZLAh4N3lTYOPcDnf+kH8Oe9P9sGABd?=
 =?us-ascii?Q?lbM/hbhS6JlR8GRbLhAS6O9OAO0hD1PkB7ZGDo4wX+shNAHjf9yVzRBscJIC?=
 =?us-ascii?Q?fheBVzQ3LVJGqyJXhUX0YtdjH0ilY1i0f3hIZN+795kZINa5VYEwj4rOg7ul?=
 =?us-ascii?Q?qBfIhD8a+3yjbgNjyKlmDYQja+NIBowJoF5ZMHv2e/xRmWiioWx8hnuI541k?=
 =?us-ascii?Q?rH3w+o0coYzYCfPgjyA=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 00:08:22.0999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d794f59-23bc-4704-0ed8-08de28921557
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9307
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 00:08:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18473

Show the list of searched layers as one layer per line rather than just
dumping the contents of the BBLAYERS variable.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 69e9f166c..e23ef6db3 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -427,7 +427,7 @@ class AddFragmentsNode(AstNode):
                     data.setVarFlag(flagged_var, f, val)
                     data.setVar(flagged_var, None)
             else:
-                bb.fatal("Could not find fragment {} in enabled layers: {}=
".format(f, layers))
+                bb.fatal("Could not find fragment {} in enabled layers:\n\=
t{}".format(f, "\n\t".join(layers.split())))
=20
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))

