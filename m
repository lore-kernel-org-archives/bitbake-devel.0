Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B99C0219E
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.84])
 by mx.groups.io with SMTP id smtpd.web10.6666.1738739758879250353
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=V/tXJxyW;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.84, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnVvQ74JkI3rzQZcDsv/akcvTAmapXsjJYZjQUp8+wUFmxdg84LyWd0VyPvN1mM+sE6QS+cEXj8aSl3I6ZHhFoeS+O9/8AZtJXa5zPauxjrbV+KrbmarzjtQZceYwou1BT63RTfl5sOz5TfEcJQG5wusbWkyrS0LA3xhtqnoVjsqfI0tNMnPEg2mrAR1rW0s9hAs135AN9oFZM3MHxf+PLZQpK9ekYH+g3uV8FKv8lfLscTnJuIJhRK4e7qMUE+Le21ManbNOc7OtfFBR5AfZVa/1vRkPTcN11Nr7PC4e1Hnmw4wdvuuxNTDGhZrKu5bfXqydlMSWogpzMUxR+vFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cUZdyhde/Un1gzAnkn6OsIK2MnB8ctyVaYxHXwUNzc=;
 b=y4XcUYAMJ6O7XnFo3JPZx2WLSLhkvxxredRZrxKW9gN5zkYS02vtDmG7nYB9yeTqWbBWuLEKWwbuRv2J3UBD0LRo5k/UPOUteTsBQGEsJz1IwOx+sbJcpP2jVrn/4LecDIumx23jK5ykkFDnarr9X/Mn1BVYxfBOoUfAG7F9DLvtXv1UrjXXzNq6uFGoNlfMyw+tsEwsqzYvh/lMSphdRQqo2SLdcRL7AkPbCxQsfvlMtXlCSJjPsrvDFb12l+vHeIeWAh0r8JhENOKIQxpjWn750nVtGJKElJs+fXWeaZlTzinHwUgJSotd/43gZo/AJTPpYXdzCHSHHua2a8HR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cUZdyhde/Un1gzAnkn6OsIK2MnB8ctyVaYxHXwUNzc=;
 b=V/tXJxyW630tx/5mU3VA/kd6uqSnQlTIAriR1SfIC7C5h8Y+8CYFnJCXzFItYxl7xBQ4mBKgJ740bB5r2lYV4cUQkIMOmgmZv4qUhgJD410skca8Q6NLgdByii68XznbT6Nv67SgPIhpihXt2/3JcupscwbJf/8G2faBLiUKkaTYrzCcw6djyBl3433S5WiGai0MpDYhzR+evhP/TeVXGShJzH/XtKRcA0Q7C07btC7r9IcaQcVmuo0nMXE+VUTakI0IH7xnz8j4Pp6U/OI0UHHnUseeTWxH6Xm6s7iDvEqMqbJDFL1H5+A6IDBKfOqdtBLnEoyYPmdvWVt7KbRFbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV1PR08MB8743.eurprd08.prod.outlook.com (2603:10a6:150:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 07:15:55 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:55 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 13/15] tests: fetch: comment and add replaceuris in MirrorUriTest
Date: Wed,  5 Feb 2025 08:15:36 +0100
Message-ID: <20250205071538.2681-13-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV1PR08MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4eab19-e2a6-4f3c-e8cb-08dd45b4ee59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Z4Ly6BeB7NW532ksOyc9pAFrrZl7O9WGGHFFsT7A4lGkDNZyWSM5sJLta5BN?=
 =?us-ascii?Q?Y7MXBkUWnH/jvoSZzjvfy3pHVOPmiUZCBrF6E9KGUM5VbiIuwjczCaT6/ttQ?=
 =?us-ascii?Q?GIj/1iFYKp8HHh6U9mfDn1ffd4+FamWsGNLNZo19vgZYBMwpTXtIqhjOJDpO?=
 =?us-ascii?Q?rua//uz5YqKfy427TJ97Yf48i/s5x73nrwung9xpY4Vd294ag1HWH2jkrZMK?=
 =?us-ascii?Q?bJQjdLBWKyP9M5raUzLSyD/WEZEM3tCyqQV+SEtvfoIVKQT/7mBuDroBdnPj?=
 =?us-ascii?Q?i5qqV0GUBos09co/1/A+WpQAif93vQlanCABhqnVmlexUmu1D7tx2AOWAo4u?=
 =?us-ascii?Q?hMJqubwYh94y2X18p6B2tnAdQrjdg1J8nRTvnOoBW4lyZ3p3wodyTj2cw/HA?=
 =?us-ascii?Q?SvHMUlzYY1HMYPOlBslQjx6K//nxGhqbk9/Ihcu7+85er6BPNovSo1Zn3h5d?=
 =?us-ascii?Q?gHpl+xpK2kCt0jrZG4AohC26U09tY30Q2jdz7I46EberZ85xwoEHp29Fe2Yl?=
 =?us-ascii?Q?kvc6PyggMxAIBhEyWAet0ZwPqQt2K76+o9rUANGSa0er4RfX2UfjtP1XhOi3?=
 =?us-ascii?Q?1EVgiJPKffM7JG7ZCYh1EgWY4uH+uBrEakW6mV7kzqFF+uQ/Z7a/i30luHOM?=
 =?us-ascii?Q?zyFWuOBgCCLg7Jtj4J2psCrJo0zcj3pwvHQEuvCy24ci/2LqoMBBAO327fDS?=
 =?us-ascii?Q?U/L3EB34OGyS+lZn/Vovpmkus8k4a5OpWDxk0btLN1rVRPHMVipmm/ey+7T3?=
 =?us-ascii?Q?cCzPQrRH4epXeSJgpSXZGbRcS8LhJus3QlEosMwqB+ye8HGLDTLGvo3v/m8j?=
 =?us-ascii?Q?Tlt3GNJLqig0mMYmYIdugy+OtX46lHgig0xlHR7GTqXdTQiP5ECpzQNlpO/Y?=
 =?us-ascii?Q?CaSEmLhP9XBXQCaeC24Z8LwiLKf3NLQZaW7R1YdEtT64bKcwpJcZVsbmE3Xr?=
 =?us-ascii?Q?wnjhCV8P7iJNUzM3MFLMS1aHRDBWBE1Nb2Y20kSmmQ2W8eju+QZeZv8sMbTM?=
 =?us-ascii?Q?RIXTg5sXsOYn/KiZMaUZGW/BmJHh9CUr9TT9WbkY+xj/oCrQDZ8PscHF3W/R?=
 =?us-ascii?Q?MZb66yRj2d143BtqWSwjO4IDs8x7pCE4cykfSYRmsViGy8N8UvXKob+lgXbZ?=
 =?us-ascii?Q?1ywMn5VF24m0GwvAoy5mnm7EhlNu5tFgDzQRZXL5dFE1lVAmXomS5/yPa2hr?=
 =?us-ascii?Q?JdHLbUNVDjnwSBJvK1/2EtycQMDYsHDyKbpkxHb8s66ye6J8UMrEaKF8n4AH?=
 =?us-ascii?Q?h3TF45MUuMV33Duarhsny4eCSueJgSTppzyFoSxW/arLpS4L2FvaB9ieQu/Z?=
 =?us-ascii?Q?Pd3Vmvl9ImMOH0ccbRiG6VhXUPPOhXZ2afeOxzfaUBh7GQUTvAo4JPymJiv6?=
 =?us-ascii?Q?wiRxib3dXZzs9kYTVHIv5Uxk/RV3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5+TTD3EXGPlJ83ZfvphSZN4rsT3ZGMKR812iMucehmVemsJ9OYQTqWxOjQZ6?=
 =?us-ascii?Q?RDDrbQrAk72Ws+2lfP+T06JHsyN1nG6VvCV+Qyc8bUFt7mQPKPgW8cctXDMD?=
 =?us-ascii?Q?lby4s+yDpQgyHeaYDr5hi4/necTaEjySWgZtDhQ6NdKeLK/81X6V2IlSRvRz?=
 =?us-ascii?Q?T/hOXtA4Ecb4XwI6LA2nuoMqXikL/j9eaxgM5iTUqGoL4TasAs7T3TEobKMM?=
 =?us-ascii?Q?ZSGXzJHQbB6cc42IeJEw31TPNc6oNGK58JLb1VFotZWDMnP00WCAjAsxwG/g?=
 =?us-ascii?Q?sq/1kC6WPRZ2urXufl/xY1vCDj2s1yGhWvcbOdbftIbpftk6boYfMBuqz7pB?=
 =?us-ascii?Q?SY8r6c19JaMw9kxmDRpfo6Gqf322XMwLMiIlyHqkt7Gk1UOI23x8khVqrMVM?=
 =?us-ascii?Q?wUZbCZpGYhMazCPTWgZ/AsTXD5+2XhPNU59lXaUzmavDRltYHYQYq6vKE6/n?=
 =?us-ascii?Q?dkjoE8lpEBuVgpxNkEjSYNbzDuIEY7nlwiJOIY3DPUIboB6Ezkpzd2vgAb+d?=
 =?us-ascii?Q?sXSTWepaNV1O0xkRNUHGinEsPpuuop/krvZVme/g56ZJe4TYEV0w76b0wG9N?=
 =?us-ascii?Q?Of2QJA/fpqMdAXqjgk34Yyqu9aA3PI1nwjrC8e9+VFIcMoR5Cm/7fBZGvqta?=
 =?us-ascii?Q?scJYlZRb6g2wWVHAQEcNmtFO3NhFBxFkm+YHZQ7hRAXHpBblAcqaMH2AcBGn?=
 =?us-ascii?Q?E0ERFy5judDwA8wdfQa0++WDIJpmofMA4z5xzqReJs4F2g0OrmDcLdnc3PCn?=
 =?us-ascii?Q?pVuHswGyhzDx0rITeQBI7JPV/s7Egbfy4zb6Jwlmf3Gsm8I6VUDsFA9G6Uk4?=
 =?us-ascii?Q?g5scz0vN775GWw1CzmVe1KkZlvfCADOF02VT+AhQsL7FrsH86c4t3Gq4kV0K?=
 =?us-ascii?Q?U/Q8wYAq5r+POR+o6kJ3GwE9FOpY89UKhNyBYOTDEKe6aRK5u8dsJTTvu1bi?=
 =?us-ascii?Q?M2qPAk+OB82sgqfi4LNfJ9QU2TJNLY8hAWeaGIaRtOABLRAI4dJ5g4yzA672?=
 =?us-ascii?Q?uh8K1VQrJfnjwH0tHEFGyL9eHfveNgtdwayvq8Mc1COj8+1lNvrMACSRUfja?=
 =?us-ascii?Q?oN9zx7CtzQOkcLax0x706BDFohGtRXtMAf5WBMnyf/Q2dhMx0N//U7XX6nYm?=
 =?us-ascii?Q?40FCg1w6SD7ANAOFcVRcF49ms3QjaNm10W6ABlZqW+gEDrhDLmCC9QXwKMI/?=
 =?us-ascii?Q?QMKwhZznHGFRd13TdntkbbEh5govJdxDGvNIioMH/JnH6fhe0K0JFiKGvdJj?=
 =?us-ascii?Q?351oM6BRZvvqJOXF3hZfN1DJ2elNPWfj70q41OhR+U9ConQWgQBJRbLKvKyW?=
 =?us-ascii?Q?6cn/jxcdKnqObyuLwD1D9W9uxvlNe2l+udMwyQ6WN9n6fieYIXqQsyif/kND?=
 =?us-ascii?Q?8xzpZTlFT9NCm6Fsy63jWWERpBOexcMhWIhXRttH7RPFfsYCj6BT8e8RO7/o?=
 =?us-ascii?Q?PhGCr+EWn5U69GeuP8raJ2lcr1K+GgyxjPVVUZZ/Jx3/559IF4KaDpHExaad?=
 =?us-ascii?Q?td5/LVeRcMG5v7fj9joMxlIyQ0ZXFgpvna+nfo4EBV9EkteaKMW0W+7l7wJj?=
 =?us-ascii?Q?u4O+pcxfoFV8dhU9pJWhoVVfIydr2G6zlUQvXzpZz1CvGUD5L3T/Fxsn5Rq2?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4eab19-e2a6-4f3c-e8cb-08dd45b4ee59
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:55.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i3ktlVcboLPy/63MUIv1pADPMKPOa1qt+fGk0bnWeGnuCRRGfKCjGRxLjfttaIajeNFw/YPL/UxR9S8n0KYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17139

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Comment the replaceuris in MirrorUriTest accordingly the test cases.

Add additional tests:
* Explicit PATH and DOWNLOADFILENAME replacement
* Rename of server and path
* Rename of downloaded filename
* Subfolder in downloadfilename parameter

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 29920bd9c..37de4d3e8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -459,8 +459,12 @@ class FetcherTest(unittest.TestCase):
 class MirrorUriTest(FetcherTest):
=20
     replaceuris =3D {
+        # remote download mirror for git
         ("git://git.invalid.infradead.org/mtd-utils.git;tag=3D123456789012=
3456789012345678901234567890", "git://.*/.*", "http://somewhere.org/somedir=
/")
             : "http://somewhere.org/somedir/git2_git.invalid.infradead.org=
.mtd-utils.git.tar.gz",
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=3D123456789012=
3456789012345678901234567890", "git://.*/.*", "http://somewhere.org/somedir=
/DOWNLOADFILENAME")
+            : "http://somewhere.org/somedir/git2_git.invalid.infradead.org=
.mtd-utils.git.tar.gz",
+        # remote git upstream mirror
         ("git://git.invalid.infradead.org/mtd-utils.git;tag=3D123456789012=
3456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewher=
e.org/somedir/\\2;protocol=3Dhttp")
             : "git://somewhere.org/somedir/mtd-utils.git;tag=3D12345678901=
23456789012345678901234567890;protocol=3Dhttp",
         ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=3D12345678=
90123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://some=
where.org/somedir/\\2;protocol=3Dhttp")
@@ -469,44 +473,77 @@ class MirrorUriTest(FetcherTest):
             : "git://somewhere.org/mtd-utils.git;tag=3D1234567890123456789=
012345678901234567890;protocol=3Dhttp",
         ("git://someserver.org/bitbake;tag=3D12345678901234567890123456789=
01234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/b=
itbake")
             : "git://git.openembedded.org/bitbake;tag=3D123456789012345678=
9012345678901234567890",
+        # local state mirror for file
         ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sst=
ate-cache")
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
         ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sst=
ate-cache/")
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
+        ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sst=
ate-cache/PATH")
+            : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
         ("file://somedir/sstate-xyz.tgz", "file://.*/.*", "file:///somewhe=
re/1234/sstate-cache")
             : "file:///somewhere/1234/sstate-cache/somedir/sstate-xyz.tgz"=
,
+        ("file://somedir/sstate-xyz.tgz", "file://.*/.*", "file:///somewhe=
re/1234/sstate-cache/PATH")
+            : "file:///somewhere/1234/sstate-cache/somedir/sstate-xyz.tgz"=
,
+        # remote download mirror for http
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "=
http://.*/.*", "http://somewhere2.org/somedir3")
             : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
+        ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "=
http://.*/.*", "http://somewhere2.org/somedir3/DOWNLOADFILENAME")
+            : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
+        # remote upstream mirror for http with rename of server and path e=
xpect basename
         ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://so=
mewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir=
3/somefile_1.2.3.tar.gz")
             : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
+        # remote upstream mirror for http with rename of server and path i=
nclusive basename
+        ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://so=
mewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir=
3/somefile4_1.2.3.tar.gz")
+            : "http://somewhere2.org/somedir3/somefile4_1.2.3.tar.gz",
+        # remote upstream mirror
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2",=
 "http://www.apache.org/dist", "http://archive.apache.org/dist")
             : "http://archive.apache.org/dist/subversion/subversion-1.7.1.=
tar.bz2",
+        # local download mirror for http
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2",=
 "http://.*/.*", "file:///somepath/downloads/")
             : "file:///somepath/downloads/subversion-1.7.1.tar.bz2",
+        ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2",=
 "http://.*/.*", "file:///somepath/downloads/DOWNLOADFILENAME")
+            : "file:///somepath/downloads/subversion-1.7.1.tar.bz2",
+        # remote upstream mirror for git with BASENAME
         ("git://git.invalid.infradead.org/mtd-utils.git;tag=3D123456789012=
3456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/=
BASENAME;protocol=3Dhttp")
             : "git://somewhere.org/somedir/mtd-utils.git;tag=3D12345678901=
23456789012345678901234567890;protocol=3Dhttp",
         ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=3D12345678=
90123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/some=
dir/BASENAME;protocol=3Dhttp")
             : "git://somewhere.org/somedir/mtd-utils.git;tag=3D12345678901=
23456789012345678901234567890;protocol=3Dhttp",
+        # remote upstream mirror for git with MIRRORNAME
         ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=3D12345678=
90123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/some=
dir/MIRRORNAME;protocol=3Dhttp")
             : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.m=
td-utils.git;tag=3D1234567890123456789012345678901234567890;protocol=3Dhttp=
",
+        # remote download mirror for http
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "=
http://.*/.*", "http://somewhere2.org")
             : "http://somewhere2.org/somefile_1.2.3.tar.gz",
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "=
http://.*/.*", "http://somewhere2.org/")
             : "http://somewhere2.org/somefile_1.2.3.tar.gz",
+        ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "=
http://.*/.*", "http://somewhere2.org/DOWNLOADFILENAME")
+            : "http://somewhere2.org/somefile_1.2.3.tar.gz",
+        # remote upstream mirror with rename of server and path inclusive =
basename
         ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://so=
mewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir=
3/somefile_2.3.4.tar.gz")
             : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz",
+        # remote upstream mirror for git with other protocol
         ("git://someserver.org/bitbake;tag=3D12345678901234567890123456789=
01234567890;branch=3Dmaster", "git://someserver.org/bitbake;branch=3Dmaster=
", "git://git.openembedded.org/bitbake;protocol=3Dhttp")
             : "git://git.openembedded.org/bitbake;tag=3D123456789012345678=
9012345678901234567890;branch=3Dmaster;protocol=3Dhttp",
         ("git://user1@someserver.org/bitbake;tag=3D12345678901234567890123=
45678901234567890;branch=3Dmaster", "git://someserver.org/bitbake;branch=3D=
master", "git://user2@git.openembedded.org/bitbake;protocol=3Dhttp")
             : "git://user2@git.openembedded.org/bitbake;tag=3D123456789012=
3456789012345678901234567890;branch=3Dmaster;protocol=3Dhttp",
         ("git://someserver.org/bitbake;tag=3D12345678901234567890123456789=
01234567890;protocol=3Dgit;branch=3Dmaster", "git://someserver.org/bitbake"=
, "git://someotherserver.org/bitbake;protocol=3Dhttps")
             : "git://someotherserver.org/bitbake;tag=3D1234567890123456789=
012345678901234567890;protocol=3Dhttps;branch=3Dmaster",
+        # remote download mirror for gitsm
         ("gitsm://git.qemu.org/git/seabios.git/;protocol=3Dhttps;name=3Dro=
ms/seabios;subpath=3Droms/seabios;bareclone=3D1;nobranch=3D1;rev=3D12345678=
90123456789012345678901234567890", "gitsm://.*/.*", "http://petalinux.xilin=
x.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads")
             : "http://petalinux.xilinx.com/sswreleases/rel-v%24%7BXILINX_V=
ER_MAIN%7D/downloads/git2_git.qemu.org.git.seabios.git..tar.gz",
+        ("gitsm://git.qemu.org/git/seabios.git/;protocol=3Dhttps;name=3Dro=
ms/seabios;subpath=3Droms/seabios;bareclone=3D1;nobranch=3D1;rev=3D12345678=
90123456789012345678901234567890", "gitsm://.*/.*", "http://petalinux.xilin=
x.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads/DOWNLOADFILENAME")
+            : "http://petalinux.xilinx.com/sswreleases/rel-v%24%7BXILINX_V=
ER_MAIN%7D/downloads/git2_git.qemu.org.git.seabios.git..tar.gz",
+        # local download mirror for https
         ("https://somewhere.org/example/1.0.0/example;downloadfilename=3Ds=
ome-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/PATH")
             : "file:///mirror/example/1.0.0/example;downloadfilename=3Dsom=
e-example-1.0.0.tgz",
         ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/")
             : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=3Dso=
me-example-1.0.0.tgz",
+        # local mirror for https with rename of download filename
+        ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/DOWNLOADFILENAME")
+            : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=3Dso=
me-example-1.0.0.tgz",
+        # local mirror for https with subfolder in downloadfilename
+        ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsubdi=
r/some-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/sub")
+            : "file:///mirror/sub/subdir/some-example-1.0.0.tgz;downloadfi=
lename=3Dsubdir/some-example-1.0.0.tgz",
     }
=20
     mirrorvar =3D "http://.*/.* file:///somepath/downloads/ " \
--=20
2.39.5


