Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E9BE82CB8
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 17:16:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web10.22983.1695834994299524384
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Sep 2023 10:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=RHaNsrOQ;
 spf=pass (domain: axis.com, ip: 40.107.22.69, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0CVgwdGTP+1I245uSERQEK6k8mxHXnbevgdDkcqryuo3uXKz7Q0AqCw7i8RY5Rc1DJAVVoTREiSm+JAW6cPTxSb8HqGyaGK5fnromy0GV44GCwlW1F2hbjtCp2QThpqBdBCmxfEnAquFVuzwIiQ+9D7wgfg6VKj6EVu6OpH1vby5LesTwo1qIEGVozVfGr8WuylgmJMpNsiq4j02C3werHeccS9stu3IW0KTwqFiCR7ki94Rz2x8FnAsCUt8yIG0Cy6z5+zFFpjBzAuPvIZpWXb2hHv/QFPtCE3l7mXRneofDFRs3m/EWr4BVN29GeWOpRPI9bBlQa1RqXJnvt1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hBViTYRkP1CE0mEl+Zq/r/4azg081MkHZIOy3CzoHc=;
 b=lEHJppeN8GrDx/KGWvwscvFrW3zhqMjJNKxMsWtHEILspuc/2LgtQad7mwbFe0R2gwi0GaPQrIaKUCyHE7qXkS2bKRzy53ABKi7kHUQ+KQbLTzL4xxePlS947puZH1c60whg4xB20PB9cPEX8vrCd6j55wHA7r9sIOsNRRyAoZkF+D8YbU6QCibLmfg3ZoJkSpwB54g3dWVql2jeJS0NorWlBK0aOKGXEJoQHhFwnMCELO8iCJcJLZbOzDNVa2Vf3+9I0jyOBILjBvSNb/IQfRdB6SN6llIX4s6EwvP1pBnk399GU+lMfCVJUEr/NG+ie6iWPajSn3wAH+sJZ8NkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hBViTYRkP1CE0mEl+Zq/r/4azg081MkHZIOy3CzoHc=;
 b=RHaNsrOQXZKwhXIE2Ns8CbCH31qTbcivEcACxjS9E4CISy647jpFVzZ/UevDMb9Vj9STyxMic8fOBvPgwnpBmNN8q/LwFF6cP+J+xryesG05s2weRTt+iz/2RE9IaElUhAYX2KIQSlxjmZkMvOKkZEJ9VG2JAiwWLli44Y8v+xk=
Received: from AS9PR0301CA0046.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::6) by PAVPR02MB9843.eurprd02.prod.outlook.com
 (2603:10a6:102:31a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 17:16:31 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::c6) by AS9PR0301CA0046.outlook.office365.com
 (2603:10a6:20b:469::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 17:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 17:16:31 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:23 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 19:16:23 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 19:16:23 +0200
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id ED45F1A75
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200 (CEST)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 38RHGMLr3352841
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 19:16:22 +0200
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 38RHGMaD3352840
	for bitbake-devel@lists.openembedded.org; Wed, 27 Sep 2023 19:16:22 +0200
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 4/4] bitbake-getvar: Add -v as short option for --value
Date: Wed, 27 Sep 2023 19:16:19 +0200
Message-ID: <20230927171619.3352810-4-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927171619.3352810-1-pkj@axis.com>
References: <20230927171619.3352810-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|PAVPR02MB9843:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa673a4-2d6f-40e6-4beb-08dbbf7d7e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/i9bpHH+q9KsAxcm1MjYpWvEPynjAnQhKR3N3LUd6MptvHIX9NDk0DFZKohrKh+rln2W2fJG9P0QvUVRSRuJHpMk2r6Psf2yhj8N12ik5KF17QDGHmAkzsAM4ermtV7DN17vAPTlb5SR+3gkTu8YSznEV2UxRqdYpO+PAH+M5td0zzsxq/vnnHTjSop/Bcl2rZifEY6h7yPNInlOmxCgJPStKewCX/yVQ03nClfk2G6QXwSP3Qb3CUXvrX6C6rbtI1C5h7Iect/blSid7MQUS48jAXgiPok9qjYf9NAEYdvnn1jd9jfArmiJvwsr/0m0UKV2HY4o0CUxNNT/W7Ky1eHYjGHljWj2mwzqnm/4Wj2Vs7/TuAmSuIYJmHbrCBDqboJlaF3+SYT9E7HIevL8Uz3D86rwG/0WQXHE4xLhcaLQ1p0H2L5PKBZTo9aoZBPEtrOj7jFfR7uIaZxCyvgcUJhKYNYjkzatk10FX1Y7A67uhhQ4kCIhBOm7PhwiRPG8BbC81aLMLyXiuGPwzTWVm1XUIDx6KOy4uBbzj55l3+enRebHKRMgu6mlE851Du8LzcfxOl1TwpH/Bjl/ECXnoX9H/IaRFxbxIlEo3lP38Lv1kw8UJbbl74P+cY32KJjVP+SjDVOjXGWhtrLPZwhJMBJS4BB3ae/gMn2zvVLa7ZOTGMikOIlfDfMD13HBPPchYablJZXlaLJ8RzBKPQx332nL9AdHi4w2rWOkHE8otinwBLYMgXoNgyZASd+J2O+bMdlhIzFEOqvu1lnwLApBeA==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(42186006)(40460700003)(82740400003)(26005)(2906002)(70586007)(336012)(1076003)(426003)(6666004)(2616005)(36860700001)(478600001)(47076005)(81166007)(83380400001)(5660300002)(8936002)(316002)(8676002)(36756003)(70206006)(41300700001)(356005)(40480700001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:16:31.2901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa673a4-2d6f-40e6-4beb-08dbbf7d7e43
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9843
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Sep 2023 17:16:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15141

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv3: New in this patch set.

 bitbake/bin/bitbake-getvar | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 1b5bb2e1f5..22e2cb7d8d 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -24,7 +24,7 @@ if __name__ =3D=3D "__main__":
     parser.add_argument("-r", "--recipe", help=3D"Recipe name to query", d=
efault=3DNone, required=3DFalse)
     parser.add_argument('-u', '--unexpand', help=3D'Do not expand the valu=
e (with --value)', action=3D"store_true")
     parser.add_argument('-f', '--flag', help=3D'Specify a variable flag to=
 query (with --value)', default=3DNone)
-    parser.add_argument('--value', help=3D'Only report the value, no histo=
ry and no variable name', action=3D"store_true")
+    parser.add_argument('-v', '--value', help=3D'Only report the value, no=
 history and no variable name', action=3D"store_true")
     parser.add_argument('-q', '--quiet', help=3D'Silence bitbake server lo=
gging', action=3D"store_true")
     parser.add_argument('-s', '--ignore-undefined', help=3D'Suppress any e=
rrors related to undefined variables', action=3D"store_true")
     args =3D parser.parse_args()

