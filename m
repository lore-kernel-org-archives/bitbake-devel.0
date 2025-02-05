Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D5EC02199
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.128])
 by mx.groups.io with SMTP id smtpd.web10.6665.1738739756512032404
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=6dHHm+vo;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW10gDdpQm9cRwPul1vvwCiQPzO5k82Vemxj7AwDffNVpT9PudPiOO58ykw/oMpifQYoKZ9Iej72FeCybYO492XbDL1imU5cIkjnn4uwmlYnB9nzuz6uCDvrq1PU7wcRShNeud076bsF+JQfILTTihuoSrd9VwqmmbBdZTpXRpfBOwK3O85HgtPmRo7FdBM6IjjHPvA+0E+t5mq3meoDSmu8/L8D9HIGB3mmyRtaRyHDqQcxxJ6LoePITUhzGrxKJDv+Z1y3ZbVMbxcM8029dW6M+eJxLhkATS5gkVt5qvNJlTXyjhZSozq6v2JrvTbjhRVBsqCPf/su3Pu0jhXMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iptm8PjNZ8+AvBc1jWNEqp+lPBwyzs/b4AiM1P3Vwow=;
 b=hKSslblAycUnKMMP4XYMrhZYmGAg3D8MttZGg+6NM0lNV/jN+6xyUB0VLEzeSnYHgZ06NXt8Xa9UQG/kOrjoxC8lzfGVcLFIdO7ISf3PxxhG7I10rP4cJQw/Th7t6WTeWgkn/6L4A2z2XyLCycpyRvsQ5KVtdx5UpqAbXLrwWIL5vX8C+k0D463nAefUCbT16ExCUJWEzr4/rDDW879wcvgRZfDN0DBYYTYN2gmfaJe1z5QOspoGKO2TE0rF26BoCdH1tXD0FPMfXyx0dvxtwfAG2zWXNhMAU3vwkoOiR+5vhnnMsrTYNk4Vp2MNC7hnhewbfhCm5ns14XURw3rlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iptm8PjNZ8+AvBc1jWNEqp+lPBwyzs/b4AiM1P3Vwow=;
 b=6dHHm+voG6ZVJbzfVWDmaL/Z2ceQSmU0GCnNNpO9sU7NO6hEjl0QHfLEWEYri0NZsx+p39bete2Vpd2zp7f3c8RlOaPyWZYimRr/tOUm/G5WmjL2U5j8DmAcKJbgfiWHSgTtzoDWaoeghR2IjFdiBSHe2wzzMRr5SV4q3hkrocZJQlbeCjkgLgV9uju9KYtlWt42O/rrv86eGRVbDy4sbbqIZn5XzZA8ZNLGQvHbJ0FI4KfOO6Vl7bAztG/xPhpEXQarpgmqD3kTseakn935KC/FDql9zWDG0dWtHnib/xCa5U7qAqb9h4MMuJPhzDD89n8fbYx43nc+QZjvMJS7Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:53 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:53 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 09/15] fetch2: make DOWNLOADFILENAME and PATH explicit in mirrors
Date: Wed,  5 Feb 2025 08:15:32 +0100
Message-ID: <20250205080953.RFC.9.9dcddffa-7bd7-491b-8d33-ed0d255fa02e@changeid>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d5dbf9-0f7c-449d-86c4-08dd45b4ed5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IlqtDV5SzKrcvEdCZw8SPofm8ktn+0O0H7crE8QNrZWpHKOziNZNdLGNQirT?=
 =?us-ascii?Q?v4tLNz/i2By9Z6ajSmnzpm1tG3Nas4jmkIagaAL5oVNuAUY8dvcMVsAhdpyQ?=
 =?us-ascii?Q?krMSjFIUl+/JEezbqp7PNqwqh68jiaG97mdqkfs7PEjpcAVRk1LMm+ygGClC?=
 =?us-ascii?Q?XCxKhLvILzVr5hBX3KZnfERllH/wON5AxfLUm/r/k/bxA6eEAJHQAus9meJT?=
 =?us-ascii?Q?6uxeMYhMSE9SLHQM057oAcNRxsI8lo2jddlpmK4i9H8PWe+1nLtV8kZkE1zP?=
 =?us-ascii?Q?48GjE5nFzENQPNb/O3OzuSCQ4BNZN9BsD8trJfTI06CXVVjGmvO5UXwqvM1e?=
 =?us-ascii?Q?/7S1QtKp6wRXD8k/v+Uby+f3p5Pfp/iYfCAWjtPBK16uCfndF0Kf5V3vinjv?=
 =?us-ascii?Q?+BbFs1Idq/cbWE/HE7/ajGj1A2NcDlvjJU5MLB31R64iF9tGHNc+/zIwmQtN?=
 =?us-ascii?Q?AFLLPfVg4ka2KQKJbRtk7ThlEGizfs2A9XyeK7Vhk0cGmmefQtPJo8aBP/B1?=
 =?us-ascii?Q?zzK0X15lXQrr7B4DRZk9dNKjL6LXAkh2Q90CBpfslXYBIBEoKXp12afi1aDS?=
 =?us-ascii?Q?aoWT3NIO1DQdOsD66LbX5z1j4vNBHuafkPmgPfpIwZjlU119v1QhRs5GFjyf?=
 =?us-ascii?Q?x7yShHLh5FwChgjB9yAtlUdVetCuZB2NAGuJEXS7yFbDvRjnHq0UmKuJ9RKU?=
 =?us-ascii?Q?x906BQEr7hhQS8UO1YqVLYAoB66oKsoS8NuZ60sNc0E/yGEXiD6iQNQxrZr5?=
 =?us-ascii?Q?NCLCOXVNkma6vVYn0xLxh/9YWLo5nGWj6wcCA885WbGLkHRg6AmWaF0y7fAf?=
 =?us-ascii?Q?QyhPG6Mg0ZXMpdqudPgK3q8crDzpeTXFx958EI7aE9+m0sNLECMXePm/8Sih?=
 =?us-ascii?Q?jEJkezpEiyQcSjrm1cm2KA2uNcoTZSu0VOxPMKwrd/bkPOItc9UdFE/kpzrw?=
 =?us-ascii?Q?CLqGUMQ7TjjWpK7NF7qvbP1SRh1MlMdITh//n9HSUIcMM6M7AGiN6fbQlmx1?=
 =?us-ascii?Q?DxT5R+suWyvg1/Wi73ii+tVEABAvjmQegEfXGdozZWsl2AshD/nOrHFgqCiA?=
 =?us-ascii?Q?nCvfcjA7OP1dnlJBKvgm0RCIwr6HVrihLxiwD6DUKpBBSgr24ShtGocFfd7R?=
 =?us-ascii?Q?QGp8RTbkSFx3W5b7ri3czIyI7doty6TTpxXhCOcM7h9TDboXAck6FvWwF7Bn?=
 =?us-ascii?Q?kv18OyTS1yYp5oiQj2iLpquJ4YyqaEwPU4INfnuQnjInFJGEuwwt/fSsfAVg?=
 =?us-ascii?Q?7pYoc2JSs+5CpzemAOiJbwEs9zlxIHOwhEAbda8mmBAadGLaMCq7Wkj40gYc?=
 =?us-ascii?Q?n2JngLrDnwS0O6URuj8oTXUz8jcw0F4J8JtTyfX7Pw7lZkW3EYwRaZClmq2B?=
 =?us-ascii?Q?7fq1WjiW71BqH/1zGGudSMuZMu+0LnRt1MiKQK/Oc191TckO3NqkhBaOtzIl?=
 =?us-ascii?Q?xVKK7LIUYVlm2YZrCqCISNtaFkb2jPow?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ecoQfuxSvIYwu2pQidqYKPcMEDSANXaXgRtJXNCbyVNxWHvDGIwFJIhl6WNI?=
 =?us-ascii?Q?cMGldTIDJf3fLIuyoaOxDrdbb7cUty8mjIhtSALsydhJ80gHYMj83Thy133c?=
 =?us-ascii?Q?HrEz0tVzXjWPIcWUEGFJ6+8g4P9mXD51APwA3B18aCi0jR3+eFXLBeZb01C8?=
 =?us-ascii?Q?I6SYQl38ZZChIgpbOsgUpmND/rAV13ED6fMLvnzSiAhdQBPSQc6AYL0vIT2x?=
 =?us-ascii?Q?qC6npne5nvtoYtTYkRrk2QZZgPDoD5B3aFoGey3yKifrx2cVHfnW8u0yvSbB?=
 =?us-ascii?Q?aTJBByS6n4qnf9kyyrNVjMPMqzrx8Ivs8SBG8Um1Pp75RQuyKhZj/TiwbbRb?=
 =?us-ascii?Q?gODb2XyeV1SDXGx5EoeJFZx8wwWRfiWTGA8EpCpaYZQ0cvS/9y247DQxzLaC?=
 =?us-ascii?Q?hqm508vq/P7/EclR/PT/9cmEyNe91nqweVDeDs2SPs2jo30jlZJuenV0+Aen?=
 =?us-ascii?Q?7TFanUWmVZz2prmrcVO2+cnmISHTU7T7fwHxvWfyUdJKKFF5mRBwI32KRF4T?=
 =?us-ascii?Q?wRCew0x4TfTKe/JJ87oeR2m2zXEfyo+G45/eJ0QZLjBVa3HJCfyoyzMELkp5?=
 =?us-ascii?Q?VdSVHuhNkEOIQ144TTOhRS0P6zCHlI3OKy3eQfgiiJMKeXatLSoIbDySwX8W?=
 =?us-ascii?Q?9d0N/ams/rrY2TESVN1phunuzxs2La0H6NK8dMun0uGWtzvDvfRrt4zOiHCg?=
 =?us-ascii?Q?Xc0EuViz5Fv2HjieqnbTz8pS9JLZep+KyLA9rjHwPEXldyeYaf4xMpPEu23q?=
 =?us-ascii?Q?Gkm0KgqTjPZdw/RYeNbFYENuI/yP5E4fwfFwZgDcYAibyeZxngJSRBChPrAP?=
 =?us-ascii?Q?WzXYnW3EtS4X8AoUf66iUOQUfnjS5JS7T6j8PL/BcDttOOAh/qJaOdwKTLyD?=
 =?us-ascii?Q?mRe1s4T5E26iHxw/dgW58xrIBhlhRPlv4y4UFTaQ13iMHsirlASvJf2F8IXO?=
 =?us-ascii?Q?GRWAGKstR2IpGTkIuPDRmm6fqCIsV7HzEBp/OHAls+ENKdcilh8SWuKpg1Yf?=
 =?us-ascii?Q?i/GCVOpgn5vaGOL4NZSQ3YHgdyR8+CdoxoI6hVxuOZV/cbPZrgrjop8gQDqd?=
 =?us-ascii?Q?ivhWcU8Rrtn0WuOONXQ3g02K3Be1XLUZsFhuYM2pW64czFrKCO/9zOYT/5ER?=
 =?us-ascii?Q?kF40euMtKWG9kIw6KJIbZvmaJVdOpVe3sg4FOWXeiVul5k6Ebw5fZvrZYHws?=
 =?us-ascii?Q?0cWSox+J92jWynyivik/8//0FcPhJQjZEtbKaAKJsyR8cl0RrBPxfYLpAAiS?=
 =?us-ascii?Q?e5ZLddCdoLUQehFswcj+cBbZZ2V2acc5kfuMWBqeoLZdw81UDOzRJyCbElAQ?=
 =?us-ascii?Q?PB2XijZZwnQAuwIRXoqVvc0Lh61HciZggjyoAG7K2B67dYoLOnYrD+48haLu?=
 =?us-ascii?Q?BFwDNtNWb3NUufQoL7MDLutUAZwvrpTi9kR53Ng2dLfalb+p1ExwgOV93M+d?=
 =?us-ascii?Q?tDrVm4ri87kgiR2j9ytK3m+O6cqNZ0sFG29etiGr1IgpSpv9HHzc40VcpC9d?=
 =?us-ascii?Q?e7YSgAa67bKEo6X8Fk/2NlG8GpSeM5oRmHFJes223MS5tNpeFXZ/AiJWjieR?=
 =?us-ascii?Q?D62w7LQqJADjg3l8Fsz6bn+gj9hg/2iRYT+Z7nyQZAIETft4hiACLztn0zs/?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d5dbf9-0f7c-449d-86c4-08dd45b4ed5b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:53.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSx1ebOStkc4b7OBicfF8ce4U3b/sTyLJZTvI65/Y2vPXHWpL/OX2XFPpiTWPdOLO5rRZ3FE6MdAJ/GoTwyG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17144

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Make the DOWNLOADFILENAME and PATH replacement explicit in the mirrors
to support upstream and download mirrors. An upstream mirror expects the
original PATH whereas a download mirror requires the DOWNLOADFILENAME.

Don=E2=80=99t replace the last part of the PATH with the basename of the
downloaded filename. The downloadfilename parameter may contain
subfolders and a mirror may require the original PATH.

Add a preprocessing of the mirror replacement to support common
inexplicit use cases.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 41 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2328a8fe3..7ec1b4b20 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -429,6 +429,21 @@ def uri_replace(ud, uri_find, uri_replace, replacement=
s, d, mirrortarball=3DNone):
     uri_decoded =3D list(decodeurl(ud.url))
     uri_find_decoded =3D list(decodeurl(uri_find))
     uri_replace_decoded =3D list(decodeurl(uri_replace))
+
+    # Fix mirror lines without PATH, BASENAME or DOWNLOADFILENAME
+    if (uri_find_decoded[0] =3D=3D "file" and ".*" in uri_find_decoded[2]
+            and all({k not in uri_replace_decoded[2]
+                     for k in {"PATH", "BASENAME"}})):
+        uri_replace_decoded[2] =3D os.path.join(uri_replace_decoded[2], "P=
ATH")
+    elif ((uri_replace_decoded[0].startswith("http")
+                or uri_replace_decoded[0] =3D=3D "file")
+            and ((uri_decoded[0] !=3D uri_replace_decoded[0] and mirrortar=
ball)
+                    or ".*" in uri_find_decoded[2])
+            and all({k not in uri_replace_decoded[2]
+                     for k in {"PATH", "BASENAME", "DOWNLOADFILENAME"}})):
+        uri_replace_decoded[2] =3D os.path.join(uri_replace_decoded[2],
+                                              "DOWNLOADFILENAME")
+
     logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find=
_decoded, uri_replace_decoded))
     result_decoded =3D ['', '', '', '', '', {}]
     # 0 - type, 1 - host, 2 - path, 3 - user,  4- pswd, 5 - params
@@ -441,7 +456,10 @@ def uri_replace(ud, uri_find, uri_replace, replacement=
s, d, mirrortarball=3DNone):
             regexp +=3D "$"
         if loc =3D=3D 5:
             # Handle URL parameters
-            if i:
+            if uri_decoded[0] !=3D uri_replace_decoded[0] and mirrortarbal=
l:
+                # Kill parameters, they make no sense for mirror tarballs
+                result_decoded[5] =3D {}
+            elif i:
                 # Any specified URL parameters must match
                 for k in uri_find_decoded[loc]:
                     if uri_decoded[loc][k] !=3D uri_find_decoded[loc][k]:
@@ -462,26 +480,6 @@ def uri_replace(ud, uri_find, uri_replace, replacement=
s, d, mirrortarball=3DNone):
                     uri_replace_decoded[loc] =3D uri_replace_decoded[loc].=
replace(k, replacements[k])
                 #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc], u=
ri_decoded[loc]))
                 result_decoded[loc] =3D re.sub(regexp, uri_replace_decoded=
[loc], uri_decoded[loc], count=3D1)
-            if loc =3D=3D 2:
-                # Handle path manipulations
-                basename =3D None
-                if uri_decoded[0] !=3D uri_replace_decoded[0] and mirrorta=
rball:
-                    # If the source and destination url types differ, must=
 be a mirrortarball mapping
-                    basename =3D os.path.basename(mirrortarball)
-                    # Kill parameters, they make no sense for mirror tarba=
lls
-                    uri_decoded[5] =3D {}
-                    uri_find_decoded[5] =3D {}
-                elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename =3D os.path.basename(ud.localpath)
-                if basename:
-                    uri_basename =3D os.path.basename(uri_decoded[loc])
-                    # Prefix with a slash as a sentinel in case
-                    # result_decoded[loc] does not contain one.
-                    path =3D "/" + result_decoded[loc]
-                    if uri_basename and basename !=3D uri_basename and pat=
h.endswith("/" + uri_basename):
-                        result_decoded[loc] =3D path[1:-len(uri_basename)]=
 + basename
-                    elif not path.endswith("/" + basename):
-                        result_decoded[loc] =3D os.path.join(path[1:], bas=
ename)
         else:
             return None
     result =3D encodeurl(result_decoded)
@@ -1000,6 +998,7 @@ def build_mirroruris(origud, mirrors, ld):
                 continue
=20
             for tarball in tarballs:
+                replacements["DOWNLOADFILENAME"] =3D tarball or origud.loc=
alfile
                 newuri =3D uri_replace(ud, find, replace, replacements, ld=
, tarball)
                 if not newuri or newuri in uris or newuri =3D=3D origud.ur=
l:
                     continue
--=20
2.39.5


