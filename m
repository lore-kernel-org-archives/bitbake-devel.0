Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA18C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 09:43:47 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.136])
 by mx.groups.io with SMTP id smtpd.web10.7629.1741340615886651356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 01:43:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=v5dQ/zZz;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.136, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXZmpTXPgS67VR8Q+td1NSJbu1NsDNm/P/dDuK5uHhXYqRaE3XjbJvuXh3JNTxXXZfa7Mr03PQhUnWSg68WFc//2WVzyuZEoE7sfLcyIMhtEFbdFdkqEt/3KAo4bHq1L5Ec7sC2tbaEuSpdds1TZDCaKqr1RfrhSv+9oNmt5+Dr2WOkSdfSW9qLm7UFU3MDO2GFEfBNlR3KsRWgc+e4pTxn+9XD5X3QN2CKZ+PRiFmyA4KPDiiM3mIHqbHVz8F2igDYb8JQZ2tYdSK0Na91pjKlIkgV5Vwqb5H7sRIGoJ3KphVhV9De4rsvkvF083nYLnbKj6obvmqVOkwrT6dJVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLU9jC6tlBf0EueTjYpF52Jkm+6W9EaLIuGSRguMtXg=;
 b=Hpp7x7UE+0WsKZ4ZpWvCQVxzjIqv10gwvxYJAgraUA9FzRg1GeMhadGx4nSQX1OcEPyiRZfkqDcD1alatdzjTglf0DLQxsW/LetU9Jh4Pr1DqIG7gdiMflkaTRNx783CWBukSgTaePXTZOWGlBYLUDRE9om+ibhdt6jtjouZy9dm6F2rIqpXWO8gWCxbM0PdZEMjSqVjtfP57P/JpXiLocu9Pwa4tBu1pYtYcwbEfFWIe9XUUdvx9D1zcLNG2V/R0ZDPiB7EYgEJhjBeTj6vDZNUG1Nkqdmquh178z1RBPSChaTLlGluOVF1Kth/BjvBLjNFqy7KiS/cfZFhV1FYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLU9jC6tlBf0EueTjYpF52Jkm+6W9EaLIuGSRguMtXg=;
 b=v5dQ/zZzzqkue7KgIzsYNfAp4aeZoCYKw03nMn6ADizA2yRkRukyDTyqABQS5UhzF7Ldw+vWyS6zudOlHjY/M2A5rpOCw2uRCvuHRu6CllSs6Z9wD1+QimoGPh0CLhHOPLW+g8T1V32fRZtHawrq53ng0fl4uES8GEkGs2UC4HXiZJrybqFEe8QoztmO5giQEWjrPWQ4VGYSDR2vFwYG05yJmV45yhBNuiQuNxmMUzyZuVbJop1Qey5c/JDKR1LwpbJdREJnK/9od6Cq4VwtxFj++nxh3TplXhPQ433OVONxf1RX5Ej/Lm3zIo4i5vL8Sn9AJtRBke0Nno0hlURNhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB6511.eurprd08.prod.outlook.com (2603:10a6:102:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 09:43:32 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:43:32 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"Peter Kjellerstedt via lists.openembedded.org" <peter.kjellerstedt=axis.com@lists.openembedded.org>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 2/2] tests/fetch: Verify regular expression "URLs" that contain a ?
Date: Fri,  7 Mar 2025 10:43:21 +0100
Message-ID: <20250307094321.8993-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307094321.8993-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250307094321.8993-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: fefbc7cc-1c93-46b3-8329-08dd5d5c85cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?E49QO0U9726znySamg+j5OygDAP66vjrvswe2eyksXr54Vc1gPdPIDrthRqJ?=
 =?us-ascii?Q?k3AhGB8nEfVEsc/mOna6DomEhE2z3BkhPYCZmYE8cleXtHmNEJcT4yHyitPX?=
 =?us-ascii?Q?bqp1rlcDd86PQaMMVCrDm/ku2ysbEqrs4/MCsOnx1EfSHx3CLKpLRdJeSens?=
 =?us-ascii?Q?c/lzmM58Ga/9AfSTBY6XWygmy461Ugkod9a5G9oGs3l+s8b/v8XK6/rc2JXP?=
 =?us-ascii?Q?aqc8bMBRgpzcCb9EHS3lE3PAHtzdVIJnnHsPLfjsay9Aj1+l4v/Px7DG/92p?=
 =?us-ascii?Q?ooGUfvSASaM9We7yFS19L3WY4Q0BJ/B216vq1hTuAeVXOyUAN9xK5Q6ooN1Y?=
 =?us-ascii?Q?jn+7uvm8yvzyzg76Vqz63mTp9xc1XogXKav5b2G4OiUYW4GFLp9r4pbpo1L1?=
 =?us-ascii?Q?9v4MZYnQKsgjZIFWTGRCrRpAFeV5OcbYUyW6f7jOQwSkK0PcfTapWpMthSJu?=
 =?us-ascii?Q?UFT4g71djYuNs2TVfcSZNregEXc1nGyiwoa5Pwq6zAwUHDzgNrovZwi28j0A?=
 =?us-ascii?Q?my1j6OR9dAPNmiMCh+ltuc+qQYqFzRcvRXm9+sxsAcfebN5Z3VpyUSk4xnxw?=
 =?us-ascii?Q?IdiAnYtN/nB51NTdBKFyDmZCCgjiLqRQOxkbeOsAJ33e5leiZBaYcwWMXVJa?=
 =?us-ascii?Q?XN5HmrClP+rifJwrVZ6kinOrskiARlVE9E5XT7r0PIPRUlf5CCEIrmG09ECj?=
 =?us-ascii?Q?sS9Hoi7aUyWzfFwQP3pyZ4Q63y33barIUe7IiWu0JRkSnE8b0MkM16j8AUfz?=
 =?us-ascii?Q?pJcyySM1xduo7aXaUrCNrkF9yLUaLf2oiQKDaB8V7gI0eTEhOeInfLSv3jMm?=
 =?us-ascii?Q?KW9+gXP6r3ybX8bA7xEhj/lk8bGgGcSSORggs/iisdmlPjorjZSaLZr9ScSo?=
 =?us-ascii?Q?NGyUlWLc0Hdz9Qz7I3hatECi5dLqnUkSxwzD5BOtqv8VG54PZhcohZ5JCK0M?=
 =?us-ascii?Q?om3oBAvH/TXTVETW5bqQWcMhIlCNSoazBO3tmBKrzeJWJ316hn1r0NY6iBPZ?=
 =?us-ascii?Q?0TU/glIkmU+CQFgP4bwRuKWdIXYcz04mnvVS5fzcLK60MKyidCwKb/FSC7yq?=
 =?us-ascii?Q?6vKlObrkyiRbItXsJwsA4naSwMhoXqSo30rKAfmYpqY4+66girweWmxnUQvy?=
 =?us-ascii?Q?Wip8Wux7JIwGEF4fc4zHIRoXyPxBXWR7xaCT5dTj13OwG398KV9Jumaip1Mc?=
 =?us-ascii?Q?qLOi9+fI6j4mdGoDfjkZCPpb5UngclwF4aK7ZsifmMuuvVXzkoOeQn9nGPeg?=
 =?us-ascii?Q?2oQ6eBvKYpJhpM3ykkWt+IcrbWZ4TcEGnptA/8S8kDQReRmatpWRXeImhPdV?=
 =?us-ascii?Q?gXBIpH3ziR4tJG5+JhS+CRpDeNCIBWlSHa0rKQZB+/RsDVs2iHtLNdRBrjfj?=
 =?us-ascii?Q?rOMC41jWylDS1xT9opMTo3aTBldo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Qv4DUCgujHrsE1C7GSQoebQO8wV+ELDicGkV+0jtN0FHFbN7ESv4CzI+0Sbq?=
 =?us-ascii?Q?qq3WzfX7pkEtKDODHWiEZ4Vw5IPZCRzxsfxd+698IgRAnltGW8F/41jhKvDX?=
 =?us-ascii?Q?56RKNn58cpdcGOY0JZ4UQbvzZEd0Vs3GTUSR7EWeBvk3OJuUvxlAUrRSX4jo?=
 =?us-ascii?Q?Aj27Ts1I47Wm4COqRiafzNtXUxiLqRPj+ULxp2DlpnhjQo2eEz6RilHr54vT?=
 =?us-ascii?Q?9tkMHNep2fk2cm4G8zZ8rLBNI2YoTLcXyU7m9046gB2e0LOzClX9jmbzFyhi?=
 =?us-ascii?Q?kKAkXHJMrkagJtk0f/XOEb/hXPK5Kq/srY/O8ODFf7FckAz1uNCFSmd8csbr?=
 =?us-ascii?Q?wEqjZxN3AyOxiQswNv3xcaB48mAHl2oFn6WovyxQPxay+xPx9rH85bTPZWMW?=
 =?us-ascii?Q?dFEJcaFLmpdW7WTZen3TDEMDwGiZ2A2Bi/4D80GGk7YXE1tFCYodnZ0StssU?=
 =?us-ascii?Q?gf9nz3Lm7b0/iDJw21Jl1D4S0xgefDbnqOtO0jSLXdAsoFUGnGAH26wfbdTw?=
 =?us-ascii?Q?bN9md9y9NKLMB0kP3MBSeS1WMZBF64iDl1lbSLxNjQKtFdW7CI7sNNYVCSan?=
 =?us-ascii?Q?I4fwUVQgZKweSy548MdD42oVREQaNqIXxqHmSzTq0BeWGv2SqGFRmd2kwhGL?=
 =?us-ascii?Q?jnwvZS3Bx77OeKrTRcvmdd80T23xtx2hjg59jQi5HdxezGnKdlG8Tbo+4YSd?=
 =?us-ascii?Q?bWbrFPrV3oFobSlUEdxdIexBYldnXrnedj5gzs0gJ65bxufFH9+r2DI4PhZW?=
 =?us-ascii?Q?qIUfYq73YRV/Rg37M47u/IfBAaNoWhIjtY+uHkEl/dpd25pKJKl2TpPAH54t?=
 =?us-ascii?Q?z+RUji9D6odjAaGsfHKFlX2gWMUWEWqZnJUdOHBbcKJhCOrypLBc/pYgihbI?=
 =?us-ascii?Q?UPn0Du3pIjF//UB6zTlsTDvOi3wmYE96/hzZ9v+Z4tpxl4IkZvKvzcBxZ9h9?=
 =?us-ascii?Q?FZonoWVhmeFbvfRUVlJc3dWFdEmlU4e0LY19axuwW2e+/SM9dEO8btYfpZwf?=
 =?us-ascii?Q?MDrJz/q9OtnW0OfHrQ7F862UaB828qMILOkUA3CJg+xVKN3QWWxhjhvqnf/1?=
 =?us-ascii?Q?T2tBFVCzR2f+B32Fzyxl+wwXDyA+zUJQRQhJrxcJrfbefpIIxgUQELXVdOLK?=
 =?us-ascii?Q?ZZw+G2Zk3c/I6H/xP58sklRUjHBIDS5+yFPaDopAy0Wd/HUOwA/2LDTjFM2r?=
 =?us-ascii?Q?0tDPi/vzE/eOSOAt/UPOXIV8m15Ijz8zdlyW5MloxYtUlVOTEWlGCAPQKcSw?=
 =?us-ascii?Q?GJA73dLW/E6oUWH4wK48V79K8DfmLZQPMgCeoIzPSEOoMG9xCKKh/C/OXu2R?=
 =?us-ascii?Q?lqUBdAmPYSoqKsBJyoeoAI4gbJsWJsihu9nUg8b8c8EhCsH3SIpIZ4d5nxER?=
 =?us-ascii?Q?PbXrvBovV0t9tqTY6kz1uWizCJqtqnpfXnr4lUbpfWtgiHJt85/XahRG/WzZ?=
 =?us-ascii?Q?oLnPcZQpCeKtERSehxPibbBwz52xEWoBVE1Tigbh8S3txzAgfj5XUBcZfsAa?=
 =?us-ascii?Q?eJO03npN8nGeOCdWa6CmCd/JaBVeLS2HhJfA7Ov2bEW039S6mJAiHdbqhu56?=
 =?us-ascii?Q?mN0pq7ZO+c9C+UJtNPU8XrFGjyuxHm6sXxxj1aShK1XfzwG0RCxUP/z6eN0K?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefbc7cc-1c93-46b3-8329-08dd5d5c85cc
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:43:32.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i00QwwSnhuf1b7ZUi/3oahn0Rc9WDQj5x1gb7/Mk5XhmEhZO2d0/1MToP4ILFPWZp2HZSP8HXBFMkIzEWjJTDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6511
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 09:43:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17399

From: "Peter Kjellerstedt via lists.openembedded.org" <peter.kjellerstedt=
=3Daxis.com@lists.openembedded.org>

A regular expression "URL" in PREMIRRORS and MIRRORS may contain a ? as
part of the regular expression. Make sure this does not cause
problems.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

(no changes since v1)

 lib/bb/tests/fetch.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 48b9e4af1..cfb4eb241 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -517,6 +517,10 @@ class MirrorUriTest(FetcherTest):
             : "file:///mirror/example/1.0.0/some-example-1.0.0.tgz;downloa=
dfilename=3Dsome-example-1.0.0.tgz",
         ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/some-example-1.0.0.tgz=
")
             : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=3Dso=
me-example-1.0.0.tgz",
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=3D123456789012=
3456789012345678901234567890", r"git://(?!internal\.git\.server).*/.*", "ht=
tp://somewhere.org/somedir/")
+            : "http://somewhere.org/somedir/git2_git.invalid.infradead.org=
.mtd-utils.git.tar.gz",
+        ("git://internal.git.server.org/mtd-utils.git;tag=3D12345678901234=
56789012345678901234567890", r"git://(?!internal\.git\.server).*/.*", "http=
://somewhere.org/somedir/")
+            : None,
=20
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://s=
omewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedi=
r3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4=
.tar.gz"
@@ -525,8 +529,7 @@ class MirrorUriTest(FetcherTest):
=20
     mirrorvar =3D "http://.*/.* file:///somepath/downloads/ " \
                 "git://someserver.org/bitbake git://git.openembedded.org/b=
itbake " \
-                "https://.*/.* file:///someotherpath/downloads/ " \
-                "http://.*/.* file:///someotherpath/downloads/ " \
+                "https?://.*/.* file:///someotherpath/downloads/ " \
                 "svn://svn.server1.com/ svn://svn.server2.com/"
=20
     def test_urireplace(self):
@@ -536,7 +539,7 @@ class MirrorUriTest(FetcherTest):
             ud.setup_localpath(self.d)
             mirrors =3D bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]=
))
             newuris, uds =3D bb.fetch2.build_mirroruris(ud, mirrors, self.=
d)
-            self.assertEqual([v], newuris)
+            self.assertEqual([v] if v else [], newuris)
=20
     def test_urilist1(self):
         fetcher =3D bb.fetch.FetchData("http://downloads.yoctoproject.org/=
releases/bitbake/bitbake-1.0.tar.gz", self.d)
--=20
2.39.5


