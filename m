Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D999C982DD
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 19:48:06 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18943.1789760884445458091
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Sep 2026 12:48:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=NsRCMPeB;
 spf=pass (domain: axis.com, ip: 52.101.83.16, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiZv/IXyrDv8aWXXqgsQ63YDqivhcga/1cVDA/akOQJ1O4n9S2ydI4v9V9DWTr0gQWtAGDBeIJfLzU2KRQYLdDIA538KLsLJ2flOvxJP+0XEsL/ocMvCvi6S7e+BwuwTZlPmqo7m1E2GFgbjHlBzuTKGxyJ4pUDVeXuhf6ogr5I9FLApd/GiDW3NzX3eb0kitsvAwEQCpV5BDgWD9jV/Hum6TXh2/lph5mIlvwUS6V8IBb+7Ow94fxZtVfEhcj5i56/IEwIZ1Kywn2sBZeSSF79BHqDo8SXMpAbMQw5Yk3ndUFNAANKGISahAWlIV7cZOvFGn85diYtJNurUAo8e8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4EA+mZfVqxcPg1HU6xFe6eSYiFYH3B5wK2vJXXcshA=;
 b=yMTeywfU6J70c3YpxKQ4927QFntHuYw54JyzzR/Ip8MujFj+WNQ/jQYsJj364nHdq2xCb4L4iVkNnOELznokx/fLknLyqn8QJt1ODEeYhkdDqHZDOMGb4VNjapKBa7VmgupzcMuoB/3/BPmqKA14O9YbBa5ZGNwW9SNtTM3xFiL9FRDD34X/WfQlzIt3AeO8BI3e1Iyd//bAmcgvPoEGXABqay5YGvBcsujowp8xVomG7d9kATjH8j5AawD7FEv02a/A1QPN0WiaLemYEODeivZ2zlzPv7+X+h2IdHvkv3lqwV6k+kwUhyc5GuMLC+LdOhUQm3STOHU0/03zAzw9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4EA+mZfVqxcPg1HU6xFe6eSYiFYH3B5wK2vJXXcshA=;
 b=NsRCMPeBBLjX8AuvVClD82ZNI9DxbjN0bH8kLHKt3K86dBha9VE134bjzVtTpa6Oe1+CTDZOeEIH5R2062jNYTWLpd+wTsFVr2e+d0vtH9TyZmzKr0T7H8CjX2HaubO7fvgfkPxoOs2Dp5WuYKLIMlob98u74ixqAkZqjfmeBY8=
Received: from DUZPR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::6) by VI0PR02MB10766.eurprd02.prod.outlook.com
 (2603:10a6:800:202::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 19:47:58 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::20) by DUZPR01CA0165.outlook.office365.com
 (2603:10a6:10:4b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 19:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 19:47:58 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 18 Sep
 2026 21:47:57 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 18 Sep
 2026 21:47:57 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 18 Sep 2026 21:47:57 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 8DA392884
	for <bitbake-devel@lists.openembedded.org>; Fri, 18 Sep 2026 21:47:57 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 7B0A612A893; Fri, 18 Sep 2026 21:48:09 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] ast: Make PyLibNode support submodules in BBIMPORTS
Date: Fri, 18 Sep 2026 21:48:06 +0200
Message-ID: <20260918194806.510401-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|VI0PR02MB10766:EE_
X-MS-Office365-Filtering-Correlation-Id: a204c9fe-253d-4962-ee94-08df15bdbd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	u2zhOEHo0ZEMD1TUmLPX4mX7/4BHVB1EnymQ6EFnqNvlGumH8wj+vvmp6bcmuvOwqJhMS6CGxJjdWV0ot0QMxBonAQrtOMNbL339WKqCCmsWLDaTjgOh57+X+VQO0FRUL9sHhdvosvf+QmGGRp0ad9acFUcj3hKsv4NpBYlfroOBZxxGJfhV6tIntINK6124jhI1QFNSE0EOc+pTKJtP4HoYtemit09lzCQnnxI+soi7Lt2rPkF3S6AsDTOl07chjHGyK1i1YNwRhgbsR8UTJQ84IAjjzaWF6FwNLKcY1SCRo0lAMF2hUM4R7xvBHuYYyerT1/1AiQiNNV0crrqY7DoSvOAnPkv5tCeotiHcfjgqfiSSofQPCZy88q+pIUeFoRaCYIELCvs+m4vR7vJHjBjYVA5bAem51elp0LycMHza/NALfvVvZ1hRpZxnC3D6TOv6omTGL4lfuhzMyisf11qvKo+ugk7dT7ZfnTDjKTsAQXOqNtm6UdVO1D6zI37tQ4xW0YgBkhU/gayYuDS0uOqD3SpvJR0wm40Q7ZJfMZHBUIUEKCp1J+PgxO+ZNu83NlNI9+2MvQYORHqKYIHU14uUm5dqoRb7p5bB+oLlBuNRrJRuKXlBZOFYt9Sv5jPXHIBFu3hjMSt7FxqKnp5PlIQC5ScahaW5Ozasw3Llhw4uoFUW2OTJKEOBZsVOIb6sfQqq8m8n7GajU9orMDTXCA==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qNdNY4h/2agcbpuqnpJtD4TrRSJojSW3PYkfVYOi3dUKU173LiitSE26ejD3wIxk4t5/1N1HKbQZRTpjPPGtqJo13++UznbNxwSsB2qUwjuXHH3lmySOoG4ffPnLcSo4+Ntj1FdoPlySstiM2+g65abfzIWrC6SKtx5WIUXYDsfbd/X7eDy7DACSJA75uVUdXyt2ab22JPYpyFPqQMkmTbsCyBNuTYUQjrmZBKFZ0RN/P+88/8jpjoBw3scDFCl/Bvl+gHsfSy5xmeQSTQjDLxePj2xsUbTGOxdoC7psuoGe3h61QMP5XGt/LAvSzgXe3YtKuhBMffSgy0f49xXDDESWlxVm/jZVMwG084YIRghzP6d2Qaddm27RzmuGor3IYRxpt6wsf+QEvkg/ZVlqfoVTo8fvMFGS9K32t95Oi58BUZe0nweYrzkrS6KHOO2s
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 19:47:58.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a204c9fe-253d-4962-ee94-08df15bdbd78
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10766
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Sep 2026 19:48:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20231

For a given `addpylib <path> <namespace>`, the existing code would
import all modules specified in `BBIMPORTS` with the assumption that
there are no submodules. This adds support for specifying submodules as
well. E.g., `BBIMPORTS =3D "foo.bar"` will now make `<namespace>.foo.bar`
available.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

In theory, one could do `addpylib <lib>/<namespace> foo` and then use
`BBIMPORTS =3D "bar"`. However, any existing `import <namespace>.foo.bar`
in the code would not match the import made via `BBIMPORTS`.

 lib/bb/parse/ast.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index a372b3534..5f2aaadfb 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -310,8 +310,9 @@ class PyLibNode(AstNode):
             bb.utils._context[self.namespace] =3D __import__(self.namespac=
e)
             toimport =3D getattr(bb.utils._context[self.namespace], "BBIMP=
ORTS", [])
             for i in toimport:
-                bb.utils._context[self.namespace] =3D __import__(self.name=
space + "." + i)
-                mod =3D getattr(bb.utils._context[self.namespace], i)
+                mod =3D bb.utils._context[self.namespace] =3D __import__(s=
elf.namespace + "." + i)
+                for submod in i.split("."):
+                    mod =3D getattr(mod, submod)
                 fn =3D getattr(mod, "__file__")
                 funcs =3D {}
                 for f in dir(mod):

