Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA871E82CBA
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 17:16:35 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.73])
 by mx.groups.io with SMTP id smtpd.web10.22977.1695834986868874877
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Sep 2023 10:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=AapCveEH;
 spf=pass (domain: axis.com, ip: 40.107.104.73, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2mm2yIF1ORsPvX8o9YL5/WQPzDAdu1052Pq++eHhWOD1zP4os7WASS0yLBLksvM1YBFT1h06WRZoUYCdWBybuvmB/PYdCN5Qp5flYp7YGrMhRX79IN06mp16WB6IMkdSy/n4n7XyiU2rWIFhim80DzBsYKnv8JHS0KKVZLUEzEpB/v+PEFkaRRamGExVUo8VJbFx+1Nc0MQa1zrUqm/t8HtMo3R8c49j0AllqQx4fF4HeEi8Jd/2aUdPoKhRGx1qVE8sZx+qBKq+z/UVBpyvgPt09e4JYOmTA7o6Opp0Gx4JqXMdjYqVnYQIMFUmB1F8EEvq9aunLVokL3rFEgktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyxhP5z4xjX8JO1UU4jal7OJXsrH76WZffqDE0tobtM=;
 b=WYZYk1ThDfxpjR/C+Mgc98JrgVD+bXShvZoEo+oVj/aVzqDZENN/2lx9/mVvJDP2tBZtiwTSVUqIods3UGYsp8ptCnf2xaKZDXN8m7M1gSn/b7H1nm9tvjPDYd1kTdLQh++Gbu4FPBmKu3x0yoSSboClVHzLidKtSEKY8j1Obma2Mj4AGdXXmyHXAPyv2zSewscCSphDQJ1hl99kgJZ7/4vsSs1pzwqAT2C5rPveGKwj6h9Mjom/m3jTFL5ZOZP/Ssxc30uq8rFGjQ9UZ+zZY30892TECQmziZ/dYw2gqkC+G0iwux9NVkghxxDAz3YU5Sjtwy/0JCmzm+gMNx7vxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyxhP5z4xjX8JO1UU4jal7OJXsrH76WZffqDE0tobtM=;
 b=AapCveEHliSHrCUeADEKZ+uZy9GkChCAeaJH6uG7BdiKro0yDhYaliZt9NdEkI4Q1SNMR3js/PzE20kemmbSxoOHRFJa7qDT1TDYyO9NkCzlaCEM58ZFmX+uAikzTgXGbSGgfL5+L+ESRFjmXLGNDLZG7tzantzDshuuEZ/oiaE=
Received: from AS9PR0301CA0040.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::26) by PAXPR02MB7325.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 17:16:23 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::cf) by AS9PR0301CA0040.outlook.office365.com
 (2603:10a6:20b:469::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 17:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 17:16:23 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:23 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:22 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 19:16:22 +0200
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id AA8402A66
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200 (CEST)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 38RHGMAR3352833
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 38RHGMuo3352832
	for bitbake-devel@lists.openembedded.org; Wed, 27 Sep 2023 19:16:22 +0200
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 2/4] bitbake-getvar: Treat undefined variables as empty with --value
Date: Wed, 27 Sep 2023 19:16:17 +0200
Message-ID: <20230927171619.3352810-2-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927171619.3352810-1-pkj@axis.com>
References: <20230927171619.3352810-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|PAXPR02MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bf34bb-8abe-4428-e274-08dbbf7d79ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FCtEhcVB/dDnlwCNWF8WriB7G7uc66mNAiao9Y04xKLlmnU28H0NsDQy1LD4kF2l7cFsMwrCZ1amv0mEzqKx7Ad+/3Dv6TILfuUGBk+T53JyKNA6F40cEfvMHqMjUfhBBuMdhK74rbzmbXnbjTvzRglv8m8moA3hTO0ioGBTcK+FbXgVQQ6r5+ml4cLS776BuyhXSCjm/gnt92pk357iLY/vK0LY9TDbNALJN/ME1qdFqpP94vbAXNd/G6tGsyLytIl27IXGhMKMBrQeLXn//uTSUmekClDWWlz4RLcBJFp2Hz9xHhHoKqpAGwGrOCKSt6ytT3brots0Q/GyQjlD7ZVPEOmB6557DHqFMUeak+RwEn0kbf4QjUKau/MO5s5UM2GJ2Khn6Q4wK7rS5oRJCvW/wFCJrkJbyZlP2ZR39ryiR+EWqVXroPEMiKoW9I5CAjVRgugPKC1ir4QuY8Dlj//QGicdatH/ypLIioxhlTV6H+dPz76gO9/pQDHXkwzZ1yu6hSzA2IqvGYZ78NW7s7MZvFxKtndAUUFR9SwsBXtCmPaU8kfdnHsOkWskYkrtApEQqvXIKEzwI1BwTQcmjWRolDIyHdFVLNH8xhHIZGp94E9z8ltMEPAYLz7OBFRBkteNXJhpLcumeUrUBJSrSlY3fj2qw9FlHxYQuTf5uRUxvxrfLyLdEMyLH2M9BpA1f2RwRnvd7lZypHYLAr0zsnLzoMFPXmNa8Dmo/RhhUo7Wc8VATdOPqAYjG2vErykkT2GfXhueYSt0KzgJK/bvYg==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(82740400003)(26005)(336012)(2616005)(1076003)(426003)(70586007)(70206006)(42186006)(478600001)(47076005)(36860700001)(356005)(81166007)(83380400001)(4744005)(2906002)(8936002)(8676002)(6916009)(316002)(41300700001)(40480700001)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:16:23.7901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bf34bb-8abe-4428-e274-08dbbf7d79ca
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7325
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 17:16:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15138

Rather than outputting the string "None" for undefined variables, output
only a linefeed (the same as for variables that are defined to the empty
string).

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv3: Split from the preceding commit.

 bitbake/bin/bitbake-getvar | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 53ab900693..8901f99ae2 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -55,6 +55,6 @@ if __name__ =3D=3D "__main__":
             if value is None and not args.ignore_undefined:
                 sys.exit(f"The variable '{args.variable}' is not defined")
         if args.value:
-            print(str(value))
+            print(str(value if value is not None else ""))
         else:
             bb.data.emit_var(args.variable, d=3Dd, all=3DTrue)

