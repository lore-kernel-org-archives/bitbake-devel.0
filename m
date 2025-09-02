Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D49CA1011
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=PJu+mMbD;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft7mqXOqf8DKdKJJWaS5zuzA1JzUVpsK0dvcLI1sRVVQi6uGN/Z++cpmzfT4JAExojVWAeC3bu2SDKN9J3PVwcmHyApVvKfmuznEdPnNEL8LpPjdv0+N7YjKmDupK3BaxbCay5Q6Th6p5ZMylhHYsC3COfENongDcvS6ECs/x/By2agdZmRkzfr7gWeHEOidHhQ11lJ2kI2aAXvnfoV5Q7LEGy+WKqmH2vHIsnNNJPTaVH5wW+JkSWxqjWM76nPxUUKkfA5cWiQJ7JWT79aW9e9YYOkNf/SyhXrp/e1fLxdkZtDm+8daCxp79VGjK0Z0vZxAeLIHPI4jTO5m3ebUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FyokpHNAxEnoGJN3uz8RKRnp5p+uqVKueRT7kHugHQ=;
 b=n2iHEq/IOLIbwqy5I7mQZOQriX4nwaogIv50Hw/dcvYVfgQsmDbBR6zJyWXuR7TkBRPPNVq8D7qN1OoKplU11hE+QehtbtTtypyuU+wMwUKo8fBQRZB5udExCW4zvrVLYEsnCkdfM9llCqsdHjwW+96ojdgE49N5j04jFjMYvCmM55h2Lg7uIlPXMqX1fJvYvC02m1bRhAZWf55y88RZxLe5lXFoeQ3M/6Me7DBAG0DphrChelbNmGRj9LLK9Ht7OVPakxt95TjwOqXjAJDmFOL0XzABZFC0WlkPMpCsOYPKYOPVJ3DSEl2tJOn6VRDJkNzUzmp4b1/uJIglzbIkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FyokpHNAxEnoGJN3uz8RKRnp5p+uqVKueRT7kHugHQ=;
 b=PJu+mMbDw0rYsHbVrNYgT4RruCMqaegl/XQOTRNzTCaV+NbliaQCneehmD8rlE61aPtNPc7TUEloGWiyGVkbkqEVxLIzNzvKXWJjNiS7AoS6uo4aM8+sC8Czp1sOCx6gTCXpS+3nbsZ0iKUPldcq8x3Lb77FtI6p3vgYP47E/WkCYPv0URNN61MM/ERH9mGLr70dTkm9mJdHrv5RGtpzDt4QC67qlct044Ok4nm5V5pKhqZESXjH7yEYEjnlargbFr5jQP+obzhBljh+SL8tEt2cMXx8v8e3NZW0tDJBWzWS83Zx8NcsgnuqHM/wpGb6CQ+0HeUv0/gUnal7MU1usw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:41 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:40 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 08/15] fetch2: gitsm: remove duplicate code
Date: Tue,  2 Sep 2025 08:45:07 +0200
Message-ID: <20250902064515.30879-9-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df705b8-9034-46a5-a3f4-08dde9ec5425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NiiqudUTULoGDGsN4rczBeGiEY2UFbf3kkMqA4tbH/KGkS1aimGReybGTlxO?=
 =?us-ascii?Q?ekPuGLsf4vgBLkHeMKGtUrKHyU04faL3U2LRq01pYwiZ8yb4046Gz46eXRhy?=
 =?us-ascii?Q?jnGRXeO+BD7m3GLwmT1q4JoOGYyKYCh6MTS0AJ57aUDFZo6qRBJFkM1OLKL5?=
 =?us-ascii?Q?QD/qE+ZYBDnMSXgEx7Bg2NhBRlwmN6Bs9xTi8drh5KdtGw1EHqzB0eJkbY6I?=
 =?us-ascii?Q?Y7xnSfjQHzV7eNIPyoV/lvRKYmurUKN0CLtrzvuf0Tc0jNc6bJ99S0ns9LoD?=
 =?us-ascii?Q?SbNnbxeBki0iwzraQRRnDX9KI4a+iiNJS6UtUjHpk9SswJUfS41F5hwc/P5W?=
 =?us-ascii?Q?UP6YSeFwUWK7CJ3n/pCThLeguUP+TwZatJzP7FisBGawrYpAxV6g9Siq/DuJ?=
 =?us-ascii?Q?wsScqjVP/7GxTgC3g4sTaMsaNYe+1Q5Km/tcYBgcauYAkQglbk80ZuSxlkZB?=
 =?us-ascii?Q?H0ZKlOFCC+83aZEQNYi7/+D7RsViuicUZZaALy0MCM7QBDy7nSV0JGeDCvJm?=
 =?us-ascii?Q?aWiyRinXYfOF2h2Xbnb2b7TCOcaP8lFpbmsQLyUgmf1vtv0ATVCkxanemn3M?=
 =?us-ascii?Q?eD3qyTzNaoYvIeJjgDCGJ+YL6afPvHQzXPZZYHLSA/aQHOwrcbVNx6wD/5Xx?=
 =?us-ascii?Q?Q0EmJ1zEK1Ce5uvfN4FayGrIOOwfaMUyIpg875AC9uK8pCvX3ziI5Y4dDpE8?=
 =?us-ascii?Q?hr5cIgFp3rKEqLkyFNf3t+dnN80NyrAcVv4wSGq3UBPvSikyWs+qs/QOTjge?=
 =?us-ascii?Q?zS3RWD5PqATxttZTXireC1OaWI2uj7Jbqxj+wRHyjGnuuua4qU4w2KAEj0Dc?=
 =?us-ascii?Q?8/FBnATJGUWLQz4GwiPvX91INOco0xeW4itg3VKhmGquzeJa5+zTtThAzVdP?=
 =?us-ascii?Q?CBuFnX1MocVvCtVgrJkeNeKY4eTvkKcdIwTPTerxxqDIVRcypFtFgpnNLSkU?=
 =?us-ascii?Q?AnC378qjNdbElZTTiMe5baYxWi03QdioktraHOHoRdX3wyam6Kqmfd4e5G8Y?=
 =?us-ascii?Q?37g8OflOW0xKwyo2yf8u1r80EPBA3Wy9cQ0xPxrm/g4bLghi0xkDXUmaVqGH?=
 =?us-ascii?Q?w5L16dMXmcsD6paqc1GyLVE576KCsYsAIRgKjuYaGj/4HrJvGPDLnXaVUVYH?=
 =?us-ascii?Q?BlD5Mnn2kk6T9kBEc14xVYzIq91bZRpoKHiv8Ez1oN0nTu6jEn6gGk6p4K9C?=
 =?us-ascii?Q?8V5Au6ind/3AbxTtc41cEj4wPcL/t4I6RbhS1vVGYIuzzzNBuvXtJtKE/ntY?=
 =?us-ascii?Q?vrzCBDs4DkwhL//P7kmZauiN9IQraC0nXrv3bGcxeSPAzH012I5VsWpMIglw?=
 =?us-ascii?Q?164nXTtPhJ9Sa0OyRRzcqpSSwGG5iZxpKPL2uGIHt9dI+4kvMM6KRQIvehfE?=
 =?us-ascii?Q?L4YnS0eDbnJtDsl4Uqu0nupW4RuXdb4Dd7nNO77UyoFPy8BoeivCKTzltrvf?=
 =?us-ascii?Q?V/jfnjzf+omODqs75uE4fuwow/tqWvqQ8cD8JIBPS7KT6bDmQDV7zQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?17rTw0B07xLYdjbjJhi+GJndWZdq0zWAVmINbxErLKIz5/hWeeDoGuRH45gC?=
 =?us-ascii?Q?lyQEEDAz9ZOuUDCenbZX+OgwNZWeE8wBVoCVYBvNmhrVTBhUL4aJ9/XJou5N?=
 =?us-ascii?Q?/qxFD6NlURpFWv6HvI/Z+p87SvcA7qyhXqx3wxh6V4+N006pkzR1Wj8HlAyp?=
 =?us-ascii?Q?KHH0hFvTctY4nZmxvFmJFwuDES5FUUe1qNw0dhWvtPQ1VPXx5XsgUlePAaz4?=
 =?us-ascii?Q?xjckbs+nXc8jn2Pl9WU0snokzX8Pk5TlxHB8uWYm19La9osoKDrWSszR/TQD?=
 =?us-ascii?Q?JTwN2O+Bm3CZP8gfOzcpFC7fd7HWEpBM786VyBwlp0VK9hrPfYhGTOgl0iw5?=
 =?us-ascii?Q?wnCrjWPFzBU5IySob8qE2sjTYRxmLSEq0oGuH0UJSYwtPGKpHOKEvMzfaZfP?=
 =?us-ascii?Q?ARzoTiEI11L179PwBJkr11OfcGwlWcXLBJqSWONWZvO/yWgAHVRzKKLNUJVh?=
 =?us-ascii?Q?Fi88CYplcxtdKSrni0x+3jOqAgS0kzTLC8ScQEgIJEaL1w9Rw+r6D7XSWp/c?=
 =?us-ascii?Q?GzuZ9ZuHiYnCsoSH6hvqOveJa6zQLXvxGy932FfSqPh0IwqwENwfwTPIeny1?=
 =?us-ascii?Q?lGmkpQilwF+T/UO/KMNUCsbPUpvDHUwtELH2F5nGzobEGhDDegRQsdIahlrB?=
 =?us-ascii?Q?1UmA4KSpxDLpuBpPtZMRYmIrdwocBTCFO2eerHiikjPiqBehBvjExRQzvQd9?=
 =?us-ascii?Q?eAGSXcV7sRtu62ksU2diR5T/5C678n6jjOMflwZ4NUCs6rAMaNbnS4WBlHc2?=
 =?us-ascii?Q?pWm54OGjkgiYCcvN95KPCUrudCwHz+AbX5qiqtQl2LAj80oWGSKk4ShZayy0?=
 =?us-ascii?Q?zTHtyNWC36oNwK2q0iXd6n1VRtooeOSSyz+5sARAXYxESzVkN/3a90spZg09?=
 =?us-ascii?Q?dJ84L/qvgE28rWNHlTFSW7qiA0f3ILFqwtrrXttB5oty2IxVYWfLBewel2Ep?=
 =?us-ascii?Q?08bDu7ZbPyL8JXAlPfjwmEx5lcoSWFIJuuOpiJ+WgfwA2mkzDxi6giDpuIey?=
 =?us-ascii?Q?dLKDtrr2bQc6I7K4CW09g2zDWGh0CMlbyRkRuvumlrDK2057tQpFw8tguqRv?=
 =?us-ascii?Q?dU4Wkh/w3+QF/BRIf1wDwkcjm8v1QQSzHOD/E6AffYkwwleyX7RelaIBRIDV?=
 =?us-ascii?Q?E0N8+zbS1NAK6kRaBPoJCCoaLvZPPe6SSkiV8rn+qWx+rK/UPryHEupO7XuB?=
 =?us-ascii?Q?zvxxt3V9NlVEkFwVpcOScDCEYUS/gpXjYTeNfNAWYHG4+Mv6DdQ0XTjebQKt?=
 =?us-ascii?Q?uv5jv3KBEfxNKg0zjN5UvHONVP5o7O/IZPlBoRSyP3fj9CXYqFz8++tsXWWY?=
 =?us-ascii?Q?388oYZYK3tT0zpF/Jf0gIidQk9sx9L/5nzucnymrs2oSKrHFM5zcfedwfxj7?=
 =?us-ascii?Q?wOLc6TwueGqyBB3pXypXJC0X7mC2jquVj+KUEZFCIzpGyglhBcSDIAkO0X05?=
 =?us-ascii?Q?v4vcXhrgfTV/ydU9oOpgPP+kQ5QfKXstwrqk19XnbqoiX5WirlyAC3D9Uy1n?=
 =?us-ascii?Q?ZLRLft3LW3GsGHr3Kw5bEB14Q1R6TbVAqdOE2DNNv36h2IJjgqBHUpaJsXJw?=
 =?us-ascii?Q?ODmlAzsxDn3Xf+ZQ9gK9yJhs1ckdD4bcBFGKUqehkepBs1IyRg52Nt3wT1U5?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df705b8-9034-46a5-a3f4-08dde9ec5425
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:39.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPRAxMZlHG9272Et9UuAk9mcxDoNIoir9dYzgsncWANQpl9z700sXFpriYj3atQCV5TeEF2S1Q0J0wu07tfsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17926

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the duplicate append of the nobranch parameter from the loops and
move duplicate append of the bareclone parameter from the loops to the
URL creation.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 497661bd6..953a1ca39 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -124,6 +124,7 @@ class GitSM(Git):
             url +=3D ";nobranch=3D1"
             url +=3D ";lfs=3D%s" % ("1" if self._need_lfs(ud) else "0")
             url +=3D ";rev=3D%s" % subrevision[module]
+            url +=3D ";bareclone=3D1"
             # Note that adding "user=3D" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git:=
//
             # URL a password is not supported, one have to use one of the
@@ -157,8 +158,6 @@ class GitSM(Git):
=20
         need_update_list =3D []
         def need_update_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
-
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
                 new_ud =3D newfetch.ud[url]
@@ -178,8 +177,6 @@ class GitSM(Git):
=20
     def download(self, ud, d):
         def download_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
-
             # Is the following still needed?
             #url +=3D ";nocheckout=3D1"
=20
@@ -197,8 +194,6 @@ class GitSM(Git):
         subdestdir =3D self.destdir(ud, destdir, d)
=20
         def unpack_submodules(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
-
             # Figure out where we clone over the bare submodules...
             if ud.bareclone:
                 repo_conf =3D ''
@@ -239,7 +234,6 @@ class GitSM(Git):
             runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dsubdestdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
                 newfetch.clean()
@@ -256,7 +250,6 @@ class GitSM(Git):
=20
         urldata =3D []
         def add_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
             newfetch =3D Fetch([url], d, cache=3DFalse)
             urldata.extend(newfetch.expanded_urldata())
=20
--=20
2.39.5


