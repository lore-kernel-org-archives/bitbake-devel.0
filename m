Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552BAE7718F
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.106])
 by mx.groups.io with SMTP id smtpd.web11.149743.1734693991344736713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=Yg8YWHwT;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.106, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX/BGaZI3emQ1O30/5z9eAoR5JuKmzVS2F9WdYC8AKX+cfavTFs36U6YPaGbME4gw2kkSdOiFehq9ZWnDeWGQqc9r0SY1slqnsCoQkI2mZqzjoJGX+LxCc3v/CeFH2lVNKqTedo+S70AAeJzMDlGjmHURu3FMemS9GzUxKQP0lM1HQbFmmQFDwg1tLZvhSFYcH3nbe4GFUKzjI3gySqOSFLNI8ECwvYy9CZpC42Z3/GVPqvz5K9muIIFOkXxvSwWiWXLYezY6nhMp1Icz88SYMWaqjZ9PBpr3HwFPsCFplD1tMSqK7uM1guX6VJ/r4I3rj3B6riAXX7DUF8wo+WzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLkihzEIyZkYbf8tBr7koBGCxXvyngDqbEgVCGtUo80=;
 b=Hb7KsFFaaOK1Jyj821Ef8g65RPoVMpm1bd7WxYlcyY6ET7gzPEdoRBPkDssj2LiyXDpsvZjV2PWkjYQz57poyf8RKYSFsae2Q1aKxtC1x5qwtUmjY+Ke6Oy6JjWKactOF7lkmBZMOJTuU395swxrbo8dUe5UYwtGA9algc64h4IVrfz3F3MjKFpVc8dTa3SOjm7oXXDtx+DcHHGDwNBLuhKcR74lFHqfqqGN4SupP/zN5wdY5kHzpYOF8mIohgCmoYYdQfN8QmZvowRKrGR+ikuJnwHX2PTnwh/wQYrFNP0yGbkhb3euLFOBHGKb3cSqcObm4C9jFLY6Ms5IJnADrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLkihzEIyZkYbf8tBr7koBGCxXvyngDqbEgVCGtUo80=;
 b=Yg8YWHwT705Fkybtk7Eaoge0Crdfo1NhA8KZtmTOcn8sHHctvDEOxdC4XkMNCwyH8PjfHVH0WNKHqzwotZGRxbK/LWvuLlkR8Cph7g71zvcgWaIg5Rfi4HwQv92bfrK2+hHc07w9Z9sSAsOWFSAYI1SBLJRD4W/hXX3FZDDaH7n7D6Q90zWHzLCu8Hw5EeMUgNoCCvtVtpqfkg7ggfP8FtUVyYsA6kiUnjxuo4D6oOVe1yxOYlD2ISj9osYC+F7Rk/qYQnlHpdnfRGegrJ8C2x/aNoDxw/LSvgCOIKNB2UkG3Cx7QNSaZflcmXfAnsmWIRCz9zCIlEUA79mjjLyyYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:27 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:27 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 09/21] fetch2: add destdir to FetchData
Date: Fri, 20 Dec 2024 12:26:00 +0100
Message-ID: <20241220112613.22647-10-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3f3697-4e20-47d8-be7e-08dd20e92492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?E1DwSfG1kl9aXqnnTtj5dppDIEo5JQU2snpq2vLV1z/qS2i0Of2aOkCIJGWR?=
 =?us-ascii?Q?/sAX+N/Sf27wuKm8yjgUdL59HwdoIsQ6Iq5I3JDns1AFiAIOrXXqhxElA3Sn?=
 =?us-ascii?Q?5EtitcRWrFfyWJkhTPtpCDQRa2GgRVkD7Vjbw8jLgML/e45hkuMZwbcSEmze?=
 =?us-ascii?Q?mXW0hOUkaAWZD+NF07b6bKd++Dk7Ln95ucJDJar06G+hXDbLqNRu5PjF2MMd?=
 =?us-ascii?Q?c9tFPW8Cedqg4/FLpd62LFlAl3Td9lEUULKOpi/fKZZaHhMbsVjtEhUxNORL?=
 =?us-ascii?Q?UBMVQIdwO4mfl0RLxD4BM82Svoz3AM7zSduA+5T45eJ51BbbtC2Tnwb0XyQr?=
 =?us-ascii?Q?edpQcvNM4MUDSSvyBVxk16/llJyWzPA31g1nZ1VWGpFSPS0bq3krZSLcgF4j?=
 =?us-ascii?Q?FivBSutaTyS9heB/O60CPFkCsebIy/sdBY1pgh3wAdD/S6iLVVTYxe38Hq4H?=
 =?us-ascii?Q?g4UIm0a4oVARZTEcjcIKDlHy/K86Aca3PL2FeixNPUzw0B2lc6BloDGgsfkm?=
 =?us-ascii?Q?paFgzYUCZT4wOvYpb1aZeV/IKDdZBQCHr52eaRwywkISfRH3qjIIX+dhBkiI?=
 =?us-ascii?Q?yP9083/ljtWv8Yji5XQmVGiqTKbWBhDOgYc3rAD+SulhRh7e7obyCLz11jR5?=
 =?us-ascii?Q?K944OrTPKmf6Skk7b07EYPb+GmU9M/eN3qRBlyiUAQruydnf++qd/RDzuYQC?=
 =?us-ascii?Q?OSl9g30tOlaswRINMbBAdnp+cPng//c24m42NmWSMk9rZ8TWPkb3sjvJxOEN?=
 =?us-ascii?Q?wcs32YqaqxmtykjgAEM8BQ91/obJ+XRhq/magdm+z3EgfYeiwldqJ42sqbnk?=
 =?us-ascii?Q?6kfqdCudVs7ww70Y8gPndsRlqQR5FChUri+dshOHVbCgjoKG37cMbQpNijqx?=
 =?us-ascii?Q?//8y7a5o5rg8GJooJosOJyCI0vYcjviQzW+Ks+nr6V0Ix9LDJ4xHl6r7UvWc?=
 =?us-ascii?Q?douyLZadipYASOTrHcvbeho7yGGBKpLZquW6s+yw/rgfRZJEj1XoB3gyE3iB?=
 =?us-ascii?Q?m9LRcu7BHvB1OFeFV5y42/a98ME/+k3HL7ktgGBC75X9F/vTlOsOMVVi6cHO?=
 =?us-ascii?Q?uZeGdm+wiekj34PJl869Yi+7yG92AO6gjJSPs6Jj7+cMn1swGx43DrFaeF5W?=
 =?us-ascii?Q?6EDxPOzIcatcjG91sw76fZc1s/ePpp3yjdLFcYB+tj2UyCmS032SdSO0IYi+?=
 =?us-ascii?Q?6JMNu9keA5pc4Woe3SQJFPUCwt6l0DfZ/jQ21OQC6XM1EoEINutDtW7ggEX8?=
 =?us-ascii?Q?t+A4Bbzhs3uRN0RMcRx6lff65jDPqt+3bBruIEpjrj2x4sp9TCKfX0wIGeSh?=
 =?us-ascii?Q?Mr8pbj+dLcOUETIEuBQWYzGV4LH5SPuRiBYMRJhzmxOZ90YSlm7NbA6nYcXo?=
 =?us-ascii?Q?4Cq4Onoab3WtX+KoKlcII4XoHS8lD9UhG/UFa9JqvJK1e0bvQJcghvZOdPJE?=
 =?us-ascii?Q?d25r6N+wXyuPF6EVqPUBYZr2+KmmOByy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nQZpKVDYs/FAWebug8BIZtMPB8AO9pR3GKDsn4TCwJqbFlQ3KgmGzDLasj/P?=
 =?us-ascii?Q?Myip/zeDNun6PHc0/9XKz7JSWQKAxeYlMXf+uRpftPDqbNEIIqvvNNmk0gbH?=
 =?us-ascii?Q?UCX3y3ODeFEHWdeE8DO5wkfwfdDiFT//Nb24khKyq+JccZocUw2uSOjzz/wT?=
 =?us-ascii?Q?d7QrbcbsNDLmJMLePN33xEfDkjFQtt8oxDkuo9bV23wgOo3LgdXOJCYY2QUH?=
 =?us-ascii?Q?LxW3+l+i1nbZ5jx3zAGmuC6PcMqY71FZUzB57XtbuwHm/05Re9/RivogWiJU?=
 =?us-ascii?Q?hfNmrV3Cqd5bHtvqEz74Pj7FUPC0PY6rLNcVynF+ogILOhiKFol1aL0BHz4G?=
 =?us-ascii?Q?7ytRh7pGs/p4BYPp7repMLPPjck+Midci0gTo/njn5QVMZMpcbNuxqVF5Oxp?=
 =?us-ascii?Q?ckjW6/PiDizYJJ9gCWge8+e39xOSq8f7L871SSAvI6bHu93sbarzhufSmcqG?=
 =?us-ascii?Q?NKnedW05yarRKGUHC7dIvy0nUkrAZuLGItrcGc+OGH31+mw6MHQqmO65e/AK?=
 =?us-ascii?Q?b0d0jEFXSnTrer7T+cYSsoEmv+QFDvVx1jyyzY9u9Cia0eDy7KNHZ4vToOKC?=
 =?us-ascii?Q?cXluw1IFtErUtda6MYzgrF0/5ob6X09zEtiYlyzyr2VVLUY33ixInR8tbR3D?=
 =?us-ascii?Q?4rbgzNay8w8tMc0hb6p8utL/En9cXawGnBng3j3HIMfyHVHA42TUsYB6MIt4?=
 =?us-ascii?Q?gvGNq1aGnBkNbF6KOAYvzZ0dTZgXlJYe4YwKEYU6QlM2FgU0b0Nw1BSjvklK?=
 =?us-ascii?Q?oTnrYrLOypRUhoIoh111Qeh19loZ6ymPYypAhK6CP9LfccfLy4g6Nm47H+2O?=
 =?us-ascii?Q?gYSajHT69vzaotaryK8p5pM+dCSvgp9TEt00weTIAHQoBmW1VI1OdwyXdo1O?=
 =?us-ascii?Q?KZfp2UYSx2J5X0xZYeZeDh47YlJIHvAG7CSAk+SIjRAjIO+EwcyVhMnzFREU?=
 =?us-ascii?Q?pr27gJxmtjh/aLhmwt+cT5XfT7jvApxYkO+uNP4cs+wOywPqGRvymIH5lsYj?=
 =?us-ascii?Q?VmfJqdWiRT0AVjtLZNMn5xX4eOknHB0sPFzQBAKmsFyj+pm5VMIjSlQJL3kF?=
 =?us-ascii?Q?5TydUgourwn+oimuju/Fe6hAipN6RQ4xErwd1mz65Z7kIYXluYdU69d95UIV?=
 =?us-ascii?Q?fEvpqoTsxkvPbmi5To6ET/04yXYuypboko9Yn+zBHVb6gx771tlp60HRFQPb?=
 =?us-ascii?Q?C6VSNaLl5druLziEahX2knqphXaMPkRo8bge3ydNeYiO5vJJ/H1CHtTMTsNz?=
 =?us-ascii?Q?O6dy90KrnvaBKGd6vaPLMEF4l/pxw1UDqXctTVPzamBask3R+O1gQWhoJLtJ?=
 =?us-ascii?Q?HnvYEf2B+OvKUHbdGWwzpKc68Iu/hMf1mb6UWcGQ5luQgF6BCEBut3VSRWwe?=
 =?us-ascii?Q?A1TnweuPGTZC950JCKEPY8681fnTivGjE+m2/IhQ7X1vm+oCwNKThPnyQjc9?=
 =?us-ascii?Q?KGPgf3nbDBsPAcUIypYdZHPQ8shSUls3MHdocdp6XBUSGQ/pVczKu7qh8+YS?=
 =?us-ascii?Q?1Ug9uJ5nk9XUUQYQvxbGzWIJ3AYFRL81MlrpfArKUgo3cL8J2fW9QcCuaKEU?=
 =?us-ascii?Q?Pran/dzJnfVlOsWjmNyPj8lasGs+TMncmUG1r/XfjQoF1D0jgegZb5sd5+MU?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3f3697-4e20-47d8-be7e-08dd20e92492
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:27.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hQxQR5XeNX1KhJg6/aa3iP5B9aki313tXEhn6JZoPLcaZ8iRDWSFAuYp3ryUMY8bQDg/6Xrh4fRV8sybeGFTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16931

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a `destdir` variable to the `FetchData` class to record destination
directory of unpack method. Users of the `FetchData` class can use the
directory to unpack additional content into the directory. The git
fetcher class already records the destination directory in `destdir`
class variable of `FetchData`.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0c2d6d73e..3a7030bf3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1314,6 +1314,7 @@ class FetchData(object):
         if not self.pswd and "pswd" in self.parm:
             self.pswd =3D self.parm["pswd"]
         self.setup =3D False
+        self.destdir =3D None
=20
         def configure_checksum(checksum_id):
             checksum_plain_name =3D "%ssum" % checksum_id
@@ -1609,6 +1610,8 @@ class FetchMethod(object):
         else:
             unpackdir =3D rootdir
=20
+        urldata.destdir =3D unpackdir
+
         if not unpack or not cmd:
             urldata.unpack_tracer.unpack("file-copy", unpackdir)
             # If file =3D=3D dest, then avoid any copies, as we already pu=
t the file into dest!
--=20
2.39.5


