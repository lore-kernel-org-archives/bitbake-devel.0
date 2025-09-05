Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10012CAC581
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:45 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.127])
 by mx.groups.io with SMTP id smtpd.web10.15209.1757054681032438910
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=3miRvD+R;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I873Odgq9wgzk0X2UYkqwYSWLUtRs79Dq4LvgyRvtgHv5UYSmvWTFwj3LSCti1sXWcDySzK5aur6mN2ACw1vtSeS8OUyPBAxwcoAgf176jrnlWPMYBPvothiVS4Lj4X2ytm52aVYco92k1obg7Hj6VYuhXtwHmG0thZc/ybkn28yQd+H++EoInRvGwhMb+kPMS1rgFaUlsxSL/Pii8KTwUoUfcm6bpE8MKA6EnSzYImAPhD2TjqOgrk9VcfzOPLOfm2ZMdtBi1LfmIhAnKg/05L0Llsgs94l2klxzEyTiIbFliSGhReDchDO4MoUuVK3BpfLukLX4ssWv1+2JjWJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFXi9A25+K3N7kQ1ZNUVXkVLVkrxcrgM8fX2aYGEdiI=;
 b=zC50cnmoQYLy75PudEgbugXD9uXptmNAVwMVOwDZ4Cv3/oa0mMsbtesuAMEj+hgGzlxFbh9OYyll8YGPTGwxMQOSRW2SwMDiJois6i7ZAAJ4rTpvbwTjLAQzIn1ELFxCSjRVjH80/K07uZI0XPgn8AE8z2Cea8ottW7ULbI1OrQEt/OEscn/jaBN9ymtR/g45YffHsVa+1/eloUhHQ1NuVXd/3zw7Wr3B05uAKmYvRtIumnywY165XTSGqFehLkS8dPGWeJ8K9mugiGnm17V7IH5C5FjNDV+iPY+c9Im3U/75JwHmXqUotAn3Xgt8IWQQdhgJVX/XZfupfDURJNDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFXi9A25+K3N7kQ1ZNUVXkVLVkrxcrgM8fX2aYGEdiI=;
 b=3miRvD+RZFeBTSFrsrY75Tzwo+967oiN8xgxW1jMbobkBA7h0FvxdpuwmQ1fszLcGICwbNdxrNaARudsNSnd7Z8a7L3DUsGJB943G/thlTHOH7RVJKnTifVQbXYVVz0G63K9Y+pmBBoQxyCk7kWEXapSx1e2qKNvZPDE4XcOWqEc9TfdSp3cRgbMsf0+pdBYaG5mzRZjArHUFxCAUgS7uxyNOurRvKO0dBU0zBuXJVYqrRW3NuvqGn/JMzI5ctmReuvKcHWPk3D7LPuHaXeGOshOs4oL9QJa5xy8LBa+XpMcJX0kMCk4wEesYDm9M/5A4GE0JSYgOBKgjJq7mWF28A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 06:44:39 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:44:39 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v2 6/7] fetch2: add support for implicit urls
Date: Fri,  5 Sep 2025 08:44:18 +0200
Message-ID: <20250905064419.2589111-7-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAWPR08MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 04217bee-8594-417f-6556-08ddec47aeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aeNo8qrEBW3wSVcJLfTYT9KNwg9yurG5mOMZPg9EYsVm/wZrNISBnqhY5+8O?=
 =?us-ascii?Q?DmyrFLVibORiB4ryID5rMwTjqDuPSn/+nlAByeQrn/W0DUs1S8Det9j39SOL?=
 =?us-ascii?Q?rcpAGgUxoWxYbg05VmtGlBOh6bobiDmMzF6oIrdWQbH/+4Rf8s4mNG+CujI9?=
 =?us-ascii?Q?r8wtAGqrccKrJ1WsDv5Z0kQgYviF+pjsWJNGGtgQ+d186K8ZgEV34LXYl4/t?=
 =?us-ascii?Q?97rD6Rf//1gUi9vs63EL4nn1atO5l4xTjKYpMyMBF8UhzQCj6Mjdgtdcb5Po?=
 =?us-ascii?Q?rQa2AvAHg38cN9WMZwS3P95gfTEV41ba+WMvu7ITI2/lwNpQ9yPH7qihVDPt?=
 =?us-ascii?Q?TN5JWBRuDO4DprjXQzl2Je/CecNjVo+fuIaOyOQGu214cZ5cBmMimC5TYEof?=
 =?us-ascii?Q?4aXHsDvOH0+AfNLYSXBlm+4cWrJEzsGo6kL7ekGnaLliAdToYLsiWY5lmePh?=
 =?us-ascii?Q?cbvEk8LAWeppxwWxBuIFJyeFlnrTEXnq4Zq6RpJyzbtG3Tsk6LdY6wgMsefq?=
 =?us-ascii?Q?4XVaZJLkOPhaH1/tN02/yOKbhvu9LxrGY5C5yyGPTrLK6bpLPYjvFA4mVqMf?=
 =?us-ascii?Q?yPpQg0x1zsYuU1vOJ85WUrIL5Cn9GaKyG5tSmKRXV6hFeGhrcIXYBO4YpbAj?=
 =?us-ascii?Q?LPDLpY0UACoAapDQGhy19D7hjPJsb3A9l1EGqOvPICpUc7j0vlThcVXMZYMi?=
 =?us-ascii?Q?07rpj/ZPc/l7q5VKPHHzhciGL69q9EpPAt0Vg9mQtYBWjD0fj0WWooafIi6L?=
 =?us-ascii?Q?K6Jw9ZbyTeC48u4vWOD/M42yM7k407v/7I4MtEANsM+jCbWMBf+6lwZecHxb?=
 =?us-ascii?Q?0jXwCNrPmJy9HG79x/H4sSZfK254nj0gt5qEzce2+xs8xMWpVeXf5th6scKU?=
 =?us-ascii?Q?wtkcjV94jL0iCMFRfcVl6288QZppjD7RCcMN8n6blRTRyR3cAeuc+gb+QeK/?=
 =?us-ascii?Q?HZbBs91bOvrrVouZZqmS1wWJacnDHjAwFJS/k4dwhzxbYpHHBjo+C6rOI8dY?=
 =?us-ascii?Q?oLmjKSZm3zdJRAoQ71dhZcpoho/FL3P86VXAeugiIIVNHLWARfDx5R9kIK6s?=
 =?us-ascii?Q?4dNH3TLV4NyLWg7ui2AQrm5FzWYkzxxtosfkfrwm9T2qxU8qnRQckW/fkqFI?=
 =?us-ascii?Q?xlM81cv/S6ECcdQmeFi6GP8rIFjv3EAb/+oodOcBZIpER8PYfMM89YgGZeMO?=
 =?us-ascii?Q?llfkZxYTFIjFxkolYllb3EZzQb/qdG37XhFE6nIuHf+o6c8BDYUqWOZKWQpn?=
 =?us-ascii?Q?Et2bco/lXN0F2xpKvoKAhRYpCdPNn31/hNXY+BU/31mKObAGHYy8U3JGN37g?=
 =?us-ascii?Q?Q8TGh7inaKZdLGSBTBCXtwnGxQ5adUq1bl9UeywYADyt3S9AyY3Pz0oeDN/o?=
 =?us-ascii?Q?Fnje1bbU5MGYKJAsxOwsJixSXmTYRLs7Yvfc/xKUfWxvflj7YeD0lSv+jzSs?=
 =?us-ascii?Q?d5qheqkgWp2/7mpewByS9VMTBwKhPJc9cBGpCHXmJLT3iiEphOYC8w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W69NwaJpp7ej6QuHUryhS4Ep3kVNHxuKz+P5OpgMlKIOYYSihzTBsm54qobw?=
 =?us-ascii?Q?LwsL4FbB2tmAUHTwgdBbC6ZbUOTKa3P/cPISmfZ+UZAyKvtsZ1ndCJKmeah4?=
 =?us-ascii?Q?Po4jc245TF5CDuMoIn0n5ynuZyjrO/UP6CX+ZCJagpIh6AF9iAYQDum6uKaa?=
 =?us-ascii?Q?TdjqKcYZu770+jmJHQm7xNOo8JynPff2gkZAat8AULzQeroMZPfKBZGAamTy?=
 =?us-ascii?Q?7ZcdTC50pzYscxgoU/g2peGN8CPLjnJ1cMgKh4vTo+p1IY6hIhIqfPrKUPmB?=
 =?us-ascii?Q?J+t2mpSOxvv25aIGsNA+9KKojwb3n8dSUPLoooxq7TgUJ/iAVUWD3PaLWPmJ?=
 =?us-ascii?Q?OgPLFAzovz5E8r62uSk49yfr0cwTaCv2//pDg+Ck3JE59kN/Aooq0CIhqOme?=
 =?us-ascii?Q?NvhJsudiHOZz9wL9bvA2BZFi+67a1dHxOA11yIR8LSnjAYuxxbVJLo2mm2O8?=
 =?us-ascii?Q?OdqJrr90ai7JBDnCTe4u5O7fnQKpqp/whHx1iKmB7wCInw+06jduRMuhH5eD?=
 =?us-ascii?Q?Xi4oMA3ovchOILGXIr8Fk4I9d5QSCkWCwsH98KKEKh5fqcSBU/ypYbOOWq3j?=
 =?us-ascii?Q?eVjrVLbiYi3Jthb3hsy4qCqoJAQTVhnQmEuy4bsLo6Dhce3/0mG3D5iujsmd?=
 =?us-ascii?Q?taSlrAtlpxlMUEHRsDojOWMpEdsHlf3QspFFWKvcPWSlB/sOcuBpg9C9kOZ/?=
 =?us-ascii?Q?AYpp+TzXn8tvB4UjUAH56xjaHjKxXQdUXJEFLkGczJI8t+8CQOqt1U0Hq3PF?=
 =?us-ascii?Q?xrwAmvD6zfi6SHWxcK6/3KBGtgfYNlSTZ+Q96UNalpway3usVK2SAdf3EBcx?=
 =?us-ascii?Q?tVsW54/1yYV0w5dYyV4bkqXe2w6h8ASOXVq7u1KDIgztcA1Ri3T8dZVoYFfG?=
 =?us-ascii?Q?1E1//Z1yGn1TxMikdHAhiLmBym3XxERUBGgVR5tMGevvCeyNYY9yYHtcU8Nx?=
 =?us-ascii?Q?XSt5R/QdkwhYyXa08oVcNUsfYV9EuYMS2576w4GC0FqqOyW6u8c1jypX044R?=
 =?us-ascii?Q?7jxJJl1EervTQNR6E7S/c+UH/RVg50KVrNAemXCJJ9MFWS6N/4tpc8ILQTfG?=
 =?us-ascii?Q?nhA/0gPZXqe8RP8KsJchHiUPLz/V39U4ldYK+313VRy4Bfnav/JK96W/QnTp?=
 =?us-ascii?Q?lKAE5QxnyAHHwqW1l/7F3DBCJb1eV5Uje2F9I0HImbvr69EmyxxaoDAUo9Nh?=
 =?us-ascii?Q?ASDo33AWHKhO2pbDqVV7IYbIA2f/7MRAjkblVAm3soB3TjafEgrRPtvg2EbP?=
 =?us-ascii?Q?W8t7XbMKQrd79EuYmonDgfSwp+RGqlt9jCbRW3ofvTfVv/+jzvR+8RMwl8Jv?=
 =?us-ascii?Q?6DqvB3G/MIkn5nGHI1ceFZvAGt4n/Y+HDeDyhwCbyfEn/V/j3lyg4Eeyy5Oz?=
 =?us-ascii?Q?vcI6TBS5A1RhSMIwf8uGt/CLtnmCKkKd/wyZfj7GhMBRl8tcJJrSlPrVuxSw?=
 =?us-ascii?Q?QRnXYafmflUUxJcG1KuV2Y8eyp3zeoVj7wZocu7diGAU8q+LN36K+zscjYS0?=
 =?us-ascii?Q?pHQLEBzYHTAv4AGXKzIT9HRZTd8zig1D4EP1A4AI7W3+kvbGXUzlZaq0MwyJ?=
 =?us-ascii?Q?eG0QIgOJd6K9Fk9IAUmz8NKMlWfEe6n3S+ISaDXpzuxoo+yzYTrdPvelmGY+?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04217bee-8594-417f-6556-08ddec47aeea
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:37.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELPI2b2gz7b2ECb05BtBxeWcm4HBtYdYiC2S+1fcmzyXPZlEg3k/KNK/3hDIm7uaEVv4BjVA6Nib5tpds36WdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17979

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add support for implicit URLs which are defined inside another source
like a version control system (git submodule) or an embedded lock file
(package-lock.json, cargo.lock or go.sum). The implicit URLs are
extracted from the source and thereby only available after the download
of the explicit source. The integration of implicit URLs beside explicit
URLs simplifies the fetcher classes and avoid bugs because of iterations
between the Fetch and FetchMethod classes.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

Changes in v2:
- Remove implicit URLs from localpaths for backward compatibility

 lib/bb/fetch2/__init__.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c4d7cc033..1bf16b7e6 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1312,6 +1312,7 @@ class FetchData(object):
         if not self.pswd and "pswd" in self.parm:
             self.pswd =3D self.parm["pswd"]
         self.setup =3D False
+        self.implicit_urls =3D None
=20
         def configure_checksum(checksum_id):
             checksum_plain_name =3D "%ssum" % checksum_id
@@ -1409,6 +1410,11 @@ class FetchData(object):
=20
         return d.getVar("SRCDATE") or d.getVar("DATE")
=20
+    def setup_implicit_urls(self, d):
+        if self.implicit_urls is None:
+            self.setup_localpath(d)
+            self.implicit_urls =3D self.method.implicit_urls(self, d)
+
 class FetchMethod(object):
     """Base class for 'fetch'ing data"""
=20
@@ -1727,6 +1733,9 @@ class FetchMethod(object):
         """
         return []
=20
+    def implicit_urls(self, ud, d):
+        return []
+
=20
 class DummyUnpackTracer(object):
     """
@@ -1960,6 +1969,16 @@ class Fetch(object):
         for url in urls:
             download(url)
=20
+        def download_implicit(url):
+            ud =3D self._get_urldata(url)
+            ud.setup_implicit_urls(self.d)
+            for u in ud.implicit_urls:
+                download(u)
+                download_implicit(u)
+
+        for url in urls:
+            download_implicit(url)
+
         if checksum_missing_messages:
             logger.error("Missing SRC_URI checksum, please add those to th=
e recipe: \n%s", "\n".join(checksum_missing_messages))
             raise BBFetchException("There was some missing checksums in th=
e recipe")
@@ -2022,6 +2041,12 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
=20
+            ud.setup_implicit_urls(self.d)
+            for u in ud.implicit_urls:
+                unpack(u)
+            if hasattr(ud.method, "postunpack"):
+                ud.method.postunpack(ud, root, self.d)
+
         for url in urls:
             unpack(url)
=20
@@ -2038,6 +2063,10 @@ class Fetch(object):
         def clean(url):
             ud =3D self._get_urldata(url)
             ud.setup_localpath(self.d)
+            if os.path.exists(ud.localpath):
+                ud.setup_implicit_urls(self.d)
+                for u in ud.implicit_urls:
+                    clean(u)
=20
             if not ud.localfile and ud.localpath is None:
                 return
@@ -2070,6 +2099,9 @@ class Fetch(object):
             ud =3D self._get_urldata(url)
             urldata.append(ud)
             urldata.extend(ud.method.implicit_urldata(ud, self.d))
+            ud.setup_implicit_urls(self.d)
+            for u in ud.implicit_urls:
+                expand_urldata(u)
=20
         for url in urls:
             expand_urldata(url)
--=20
2.39.5


