Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CECEC0219F
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.101])
 by mx.groups.io with SMTP id smtpd.web10.68438.1738932445099229225
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=Q4ZRDEm7;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.101, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBVty/VhOEUAhmtOqycm1VdM6XR59glOO4T1Teo2zZFmccsAt7LMmk7Gtve85RL547fXan0dQgETibOg/0cBrjr+gUIsqAYTpqGTHrHUHvxUAQg9cCvLilUx61Edci+/J+jC68NvPkoimcFk17hPQO8W5NWiE4Rh4N1Kl0QRPAegyH0CQANyIG8mph8OojU6LvodxDE/b/ajU+580ltU8cNaxCYuwl9rlfh1RAG2F7ll0JaAlP3B8DD1OxSj8NiAC2AQRqBc/bN0F/FitzxzxgogF32I7LCxyVOvgmnNGZrlQs+w52vv49SDhVQLVFR5V67e2fyn+9oq4Z2VCkV+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsdvD9/UhgxwS3g3pFd1YG0zrEM04JN+KwTKaAk2l8A=;
 b=tpUNWDI5uye2ZKh/Yo21FBCBD6R0t0Ey2KG6zzKTCqCF1scWq5fnk9fco1URUboW3CjXng//413jGtwjkb6IhxgoOKOG8lEVMjkxrYaGzW7gFZZ9V3wzc8l2f5YXpP2olg+nbDMIHEPKmWQLObm/OlFt2TqV5STBTqK3GEzmex8Slpzs7JstbtLhoFurhVHMAGP6Y2qccw6DU33OJnVuxJt63j5Msm1MOtYBdK029+cUtIIwDeNNnGZzxddJ34YiESoHtYEGf/ELxOIbUM/7rRvgTQJfd8TzAWtjcFheQIF0gL344IfIXM2kW7Zzt9NJB8b4Cj1G4zgDU06AEJeMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsdvD9/UhgxwS3g3pFd1YG0zrEM04JN+KwTKaAk2l8A=;
 b=Q4ZRDEm7Z/jwcl/1Zkmi2B22f513h4p+BNdUft1mkrnA9RFH5zOH4vi9pPkeVXSqmnarXLUaV4/yOTymxbxw/btGUZ7a974QHTKIFAoHtmoN+eYWUYUb+EyRAAZjTDLLQbN+0Bwo9l6qN99pt5rZydXg1BKUTkffw3V8nk70FxsZS/aJ7+psiGElRDqjfoXYcsmEYOFUmINseIi88Kk8zMtWWak5OePDW1Qgm98tbFM5M/Lxgr8dnIARZcCFK1dyJMeq0oUheETcbC8QvvOPsQZe9+AZ2yT0M/qp/AlhrlkUArlOPA2L0Cp9Ns4XGytp7NMhR/PEMt8GdhnNMJNOhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:19 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:19 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 12/13] fetch2: remove basename from FetchData
Date: Fri,  7 Feb 2025 13:47:00 +0100
Message-ID: <20250207124701.14787-12-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ed20c2-7951-407e-6519-08dd47758e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pufKMgHAJqBTS50Ps+LgyqM12m/36UeAOd1Xz6NdJrBlI9o0ZOrh9n40H7IQ?=
 =?us-ascii?Q?4Cagpm/ciFznAhIw4nkW9OLAgCrYqBPgjvPmG0APdmwufc6bJTijME6KqSXo?=
 =?us-ascii?Q?vUvClbfS5QVot7MYVfpOac+fDxnoVLpNU6Ysp7agN+SNuRC0/Fi6meuaJryJ?=
 =?us-ascii?Q?avAAoJfDyXpM9OGPeeRTRA8Wd5IndO+rQSZyfW2Aunw/d921BQIdJ419aNtH?=
 =?us-ascii?Q?vrh1GrWr78Jz0Us5eKD0RYqY6zSWgDCr2Phx5SMw+jXWbqwf6S5VVEziuPBj?=
 =?us-ascii?Q?aXgcWF3lgBw0C8iXBkJGQA7PCjN0UOvMsgY8txvnIqr/ixc7V+NJ+eTuLaVT?=
 =?us-ascii?Q?0nZUPYTVzBILLDv86dF6zBN6BGQdU0U3ia8L0SKn3BXGsu1Yxm3YbKNmFiqo?=
 =?us-ascii?Q?PThYxj6sDD1BC08m5h5RI/ISz32UNZUoKhJ6Zjpzmn87Qeh4QcESttaddItl?=
 =?us-ascii?Q?pTM/yOUjjADouQwBAojZAG2nld9GG4vOdjtCNTDSR/k0v6Hhz5yFUVhZ7+C6?=
 =?us-ascii?Q?50kc8IwroJdrnuj09VPPcWoScdKCKhByylQL6CSsej7jfttDW/F0mnfbe5P3?=
 =?us-ascii?Q?5OcUPBx+IxB4+EJVzDzaeFEsAzKeEXbu5FKAOZJKJO//mMxAwaD9g1il8ZN8?=
 =?us-ascii?Q?dsaByTXJ+P1cC03VCyf2E7ZdjoapzqVLHKwdH70VhAmHJIrURYe0z5VCSTze?=
 =?us-ascii?Q?7pMV26bAkbvGhy8M02RZlOOopn9RvUfwDReY/ycxFFsiCYu/2GDyVerSWd5F?=
 =?us-ascii?Q?r4DZWCUSE803E+YaO59RsM/EDlrT5RzAlUuOjcpBvA5AtAoXM2dcO7ezp84K?=
 =?us-ascii?Q?QmKsAa78OCFuv7KjVNqUm2W5OcUmiyYd6mKhq/+wbNANvbv2+9H3K4ypm5by?=
 =?us-ascii?Q?2vbv1TuCeSeIBkg370Wd+0988eEU+CfIv8U8+fQsafb28zqxNFi9Y3BgJ6yR?=
 =?us-ascii?Q?qdIDepm9PC2SguYEsK2Y5wb8pGodfIYNoVkLa5RpxufGHH17xt5eKqvFy/ot?=
 =?us-ascii?Q?CzHZmeLfAPeK1ic0MK1OwP/QUCKC+FPmblUxyhYv2maNFD5qeQvnQwg6WkpE?=
 =?us-ascii?Q?3vQlZWMVYaZQxWjOaQhD7cgq5TiregHatU6qZRgpnI9q5jJ2m2APlLN+2AAV?=
 =?us-ascii?Q?FUvh4cstC5lVH8S6ozYoYIo3tlEyAjHSFa6o0BNMl4SiooOJ5kThPiQBucnY?=
 =?us-ascii?Q?8EpIl8XdUzqleRtSvqTAa/XB1NkmWKeebebIe5vRN74hQxwKqU49LOkKQHEC?=
 =?us-ascii?Q?Shtsy02qOhZjSlWxzeVL45vvBjcwLQIK3kpsRKyZaKsVZRD8QnDwb/HnLEkq?=
 =?us-ascii?Q?juTtkpvBwMz8hBHLL8eNfoQ3SOWPXz3I75GURNTiqLGu2cGM93ngLu0yFC71?=
 =?us-ascii?Q?5XfRensZdzb8GKp6jqB5nY5yZyteeuygxZLqS9lYxAfvbs7/DW2hBCL43m29?=
 =?us-ascii?Q?8KJS/iGxG8wZQe5SQbBNV9spCIy2uf+I?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CdgWxLXdUika4YGEu5lHtpG+oZQzbhTtWVM3Cfd/d4W9IpLsjIO3wRl4ecJO?=
 =?us-ascii?Q?a6NVqM3jn2GAHe0TEllWwi2Raj3qD/mjO2SaB8ni2snPXwuVH+c2SZm4Iuth?=
 =?us-ascii?Q?SP4x2Ah2GUBe99Xxdvm7ROOsXn86TEdafKebPu2Veg5EIAcWe/kME3XQdpyC?=
 =?us-ascii?Q?vPjwRO1D78HJcA/zhiqdgqy/0GJ1qkgaTv6t+JxAy5euiJvoPa3u5ZrEYjkV?=
 =?us-ascii?Q?g+/iFVVHvqq/qGjrn/5HIfDLegO/izCmwTdH+9+JzZyGgmMGV9I/3/HP25Dr?=
 =?us-ascii?Q?yLAIv1bGtp1qzvZ0kFlbvMeYR02XsfUfpSvXJXOPhMx8Xoxf7cu2W01HvUNR?=
 =?us-ascii?Q?Tdmo5Kauge+DJKXn8JmKDSeS9anpBkgJ1FlIH4u8FLdM54/v6pjRCOSLt43g?=
 =?us-ascii?Q?agc+6vH5aWvcKdTmMAkZSVXKp/ERhY/KznFoTa7CyyXqaAh8tG0eQYQWVwxC?=
 =?us-ascii?Q?xkDy6xp+8w98VgkPkq7XD2xAvdi9XxfDzVk4uF95goZDJ5Hblif56VAVbZdm?=
 =?us-ascii?Q?kTfJOj34LC3mfXkzY0ywQhAJ162gyF8HJNFfgtGmHEoonr7DisEX0bRe/js4?=
 =?us-ascii?Q?t0hrUD491kLVdd5G4YmGDJP5QDrv4NXwAePlX4B3nVj5HEieFK8OAz1CVRu1?=
 =?us-ascii?Q?N+sxu0ZWSwxzVF67HDD+VuegNvHlsP/s3CUt9D2m1yPYoaqnJzc+SvxnQd/q?=
 =?us-ascii?Q?3qzUK6eg6LvPFhVzXW+WSW536J8sxUp4p+kttn/8ogAih4+WEkNIh5OGuRMb?=
 =?us-ascii?Q?HJrYakX2HCEm0g9rhoWQZOw1O+KH2ynhKDjg6r6euGhLrh/JnEM+ec/Sfv5c?=
 =?us-ascii?Q?cPh0DUJ4727TKIn+DyXyPXpeY0Kk89McksjMDVOa3cS63To60xasbiZ9Kapd?=
 =?us-ascii?Q?4j2cjKTN38bTOWO7vzZpQqj2O3+KRcdrOTmGPgVZdkwJdFEGzCDmVHJoZKO+?=
 =?us-ascii?Q?TDOONnDiM+ZAYy2t9z4F7QwbUQPtyTKmMYtcS2KXexhd20Y769gRdr4JVXz6?=
 =?us-ascii?Q?wwe4CjdjTjfpPOcs3xfCx4SjYRxo+YkUcR7jbcdwI4RYFzWlV/KxgbAeb81C?=
 =?us-ascii?Q?0mOk+zBn2H9eFQFHMt15uBxiEejAqtEyJkP2rW6BTvFtALBAAeIukjqDdiPb?=
 =?us-ascii?Q?z84hFR/NCxMGLztfUkHAZRiICqK+KfYmgkg4eArcidGbOcoXqfZnTM8S/tZh?=
 =?us-ascii?Q?0uEoSqj7vzremU09B9sWVT4X0cd+Q+aOZsof82nfS7z0sTPL6QJxz06P3yYK?=
 =?us-ascii?Q?18bj1WTgKAqE2uaJCm+J9kexj2cBfxGdvO0NBjXLXFZiyOHNbn6c0So3bAI9?=
 =?us-ascii?Q?4LG1nhq8GoBDVqtVEejwZGe9fOwDmOX0R631l+NOrWVujmyi4SOQjys/KINb?=
 =?us-ascii?Q?bdHkaLsD29jf22Y0Vz452VEJgtRORIqH1Ee8Izf7NZH21QIMiGB+Av0IzSPd?=
 =?us-ascii?Q?clEwIDTHWu8C1cfL6CpHxZD/q7bM5PbQGPw5RrG11JeHMECLkSWBkXckCFVO?=
 =?us-ascii?Q?oE08co/Px6zVdhz+S75wyxpw44vOl2iB1Hl5hddjma176WyPXhOfJbOMrUwD?=
 =?us-ascii?Q?tadP1PY89A4/upOuvaGSVOzRxqqwQ5jY3AFjag7HXKTCjg6ICtdWjPwAIUQN?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ed20c2-7951-407e-6519-08dd47758e4d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:18.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 596l7anPeHuIczkr5cCqVDB6GpIkuKw8kEsFn27YQqs19TZ42tOwUeh9RC/MMUh9j5ebcHV/CmXGVjxNfeXzXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17180

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the basename variable from the FetchData class. The variable
contains the same information as the localfile variable and is mainly
used by duplicated code. Consolidate the duplicated code inside the
FetchData class.

The variable name is also misleading because it doesn=E2=80=99t contain the
basename of a file.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 14 ++++++++++----
 lib/bb/fetch2/gcp.py      |  8 --------
 lib/bb/fetch2/local.py    |  1 -
 lib/bb/fetch2/s3.py       |  7 -------
 lib/bb/fetch2/sftp.py     |  7 -------
 lib/bb/fetch2/wget.py     |  9 ---------
 6 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index a680783c4..de1ab0782 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1269,7 +1269,6 @@ class FetchData(object):
         self.localpath =3D None
         self.lockfile =3D None
         self.mirrortarballs =3D []
-        self.basename =3D None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm)=
 =3D decodeurl(d.expand(url))
         self.date =3D self.getSRCDate(d)
         self.url =3D url
@@ -1325,10 +1324,17 @@ class FetchData(object):
=20
         self.ignore_checksums =3D False
=20
+        if not self.localfile and self.needdonestamp:
+            if 'downloadfilename' in self.parm:
+                self.localfile =3D self.parm['downloadfilename']
+            else:
+                self.localfile =3D os.path.basename(self.path)
+            if not os.path.basename(self.localfile):
+                self.localfile =3D self.host + self.path.replace("/", ".")
+
         if "localpath" in self.parm:
             # if user sets localpath for file, use it instead.
             self.localpath =3D self.parm["localpath"]
-            self.basename =3D os.path.basename(self.localpath)
         elif self.localfile:
             self.localpath =3D self.method.localpath(self, d)
=20
@@ -1342,8 +1348,8 @@ class FetchData(object):
             basepath =3D self.localpath
         elif self.localpath:
             basepath =3D dldir + os.sep + os.path.basename(self.localpath)
-        elif self.basename:
-            basepath =3D dldir + os.sep + self.basename
+        elif self.localfile:
+            basepath =3D dldir + os.sep + self.localfile
         else:
             bb.fatal("Can't determine lock path for url %s" % url)
=20
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 86546d40b..62715f746 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -40,14 +40,6 @@ class GCP(FetchMethod):
     def recommends_checksum(self, urldata):
         return True
=20
-    def urldata_init(self, ud, d):
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-
     def get_gcp_client(self):
         from google.cloud import storage
         self.gcp_client =3D storage.Client(project=3DNone)
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index fda56a564..0e9357968 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -29,7 +29,6 @@ class Local(FetchMethod):
=20
     def urldata_init(self, ud, d):
         # We don't set localfile as for this fetcher the file is already l=
ocal!
-        ud.basename =3D os.path.basename(ud.path)
         ud.basepath =3D ud.path
         ud.needdonestamp =3D False
         if "*" in ud.path:
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 22c053813..2cf181442 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -72,13 +72,6 @@ class S3(FetchMethod):
         return True
=20
     def urldata_init(self, ud, d):
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-
         ud.basecmd =3D d.getVar("FETCHCMD_s3") or "/usr/bin/env aws s3"
=20
     def download(self, ud, d):
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index bee71a0d0..2a2a70a1b 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -72,13 +72,6 @@ class SFTP(FetchMethod):
                 "git repository using ssh, you need to use the " +
                 "git:// prefix with protocol=3Dssh", ud.url)
=20
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-
     def download(self, ud, d):
         """Fetch urls"""
=20
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6cb728ab4..161c66bea 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -73,15 +73,6 @@ class Wget(FetchMethod):
             if ud.parm['protocol'] =3D=3D 'git':
                 raise bb.fetch2.ParameterError("Invalid protocol - if you =
wish to fetch from a git repository using http, you need to instead use the=
 git:// prefix with protocol=3Dhttp", ud.url)
=20
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-        if not ud.localfile:
-            ud.localfile =3D ud.host + ud.path.replace("/", ".")
-
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -=
t 2 -T 100"
=20
         if ud.type =3D=3D 'ftp' or ud.type =3D=3D 'ftps':
--=20
2.39.5


