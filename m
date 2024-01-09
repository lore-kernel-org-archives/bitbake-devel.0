Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B28C46CD2
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 10:38:19 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.51])
 by mx.groups.io with SMTP id smtpd.web11.13466.1704794904932206508
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 02:08:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@criticaltechworks.com header.s=selector1 header.b=jKY07iaO;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.8.51, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWxbybZFJEna/MmfZxAHZjQWVc2IUlb/YFCV9bO+KQYEsdiVNFqtk6yyR+xz0wX07meOqtCq4FgMBGCHjowMj2j9odQr4WwyuhzkCua0wa9KW6orrdKT2owG4aznmSBm9331CMGfQn2YZBrhfNv5wL5Wh9vYav1m/UpLc7Lx9IiXBf6EEbBa03gC2gknWwvWKVdNbW/OGUmbg4TfPYgJ5OcVd+JG2+w76tSvoPcavGsUkyTZMoeCzti0xoBNmOMsHfCrhLxfivkoKEXtJCKyLrU+BWUMtI6LNL/fh9b9IhiPf+Lz04EU2Vv1ZjqF8PKYeX/wx7bRTxTmJP4aK5MMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gthyr0cgYmWM8i+YTwlszY34+oEGZG5vG2m9Gbt+mm4=;
 b=cbYDf7Cepv5JWMohjF9n8wRp2OtdK9vBSaa6nwoew9Aw+KJbwDoo8oDW3WwxaM5q7tOpE8BPTPSpuT7tyi/R9US/XfgHL9mhKY/5Agx30aJzsiDAjYkSLzI1G07YyzhjO8wk+qCgdK+Ln8qEBFRml1b5igAgByKwI9+ILJGvSPcAKWf1zj1asnPlLKUMNQOq5FKy3BeZ9IR6DwnY+nPm+lW8IJXynNYkljh3AgAVdz93nMCxLeTJhg6PBO2Lf7ShIOqr4nZFODso4h4jhO6Q6t0zHkaOyD34EhyQf1lyyUNh0xWXBgH3OaRmXh35asCM4vBJ7pESbWi0MPrKirmSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gthyr0cgYmWM8i+YTwlszY34+oEGZG5vG2m9Gbt+mm4=;
 b=jKY07iaOeARqYZ7Gee8wNYpWJYa2ez+j11J/cvA/3Dtz1VQp1hspqOl2dntVjAtnzy5SAieGHT/xs5YoyLpG2dVT+MbZpYlu5k0W8OxrPvcYgNdTjSXZ1VzeA4drtgK9InfbJC8Wexe+fHoJMp6Mrwm+YhQWeXMaMDlOc5gbRibrkK/OEyU78EtY9k2uqFbt203sAVE+MKIH7i/ctlDIGeSK9Eo81LjQsQXTSfBx4q0cX9Nz8bSl3iKGPq6cpuyFZGlF8kIBff6kb2GAJRFru2NTzj382IC0wbjoKJq8zFOhJyW++ZT7sEPH97fRWxsAEPGFqUgKfjbBgw+ea37gKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criticaltechworks.com;
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13b::14)
 by DU2P193MB2049.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 10:08:20 +0000
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::99a5:f27c:49c5:c41c]) by PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::99a5:f27c:49c5:c41c%6]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 10:08:20 +0000
From: "Fabio Berton" <Fabio.Berton@criticaltechworks.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][kirkstone][2.0][PATCH] utils: Add enable_loopback_networking()
Date: Tue,  9 Jan 2024 10:07:53 +0000
Message-Id: <20240109100753.147890-1-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO2P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::17) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DU2P193MB2049:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5babe-c70e-4b47-f284-08dc10fae811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BLcLxqwPaJjOL3FqYibI6Mzjm6FlPXz8SgcR2BOsx8yVsVbwcKL4p6GJl0QyyQG8+0D5w79lnQimK3GEmNGWq/Az+AGhMZipjTrd3Pb7KknSE7uhtUzBvKNpVJYdv4PfJf8lR4F/AedcBk0O0atSzn+vEDMGtr+FoTrSrTtHJb09lAJFk6zgjGF4ARUPp5KicuUOilsoAw3XhKeJVc06UigP4WjiVrc+w7tqeV8QvDXoEyIEip4WK6hGRbakG9mxirFeNsjvzrFIgwTEttgKzMlvsmTIdaDhAT6468RalNycbCGw8ZyJ6CWzibRcVtp2J75VfUQSy/Ni+Ogsn4OtVfgHHvUWvbX/PHcCsrQYTq5thHxKGXN39t7Ix11m0taUVVGsdTHluJ51cD3OewR4LovLdamZfcWN2fdGNft5RdYW0xbx9IhorLacxbw1iqdbpkVqsStrqZkw8+GDSY0aaXN64ZBwwRMkNSZaY6j1poxFTjnKaCUydCBgNpadwbQC4Jjw6RbtpbSkEeexk5yDxsG3U1dEM4ecit8CCzaW1TEwCW5XvCY9idHKOa9E3OSBSRNbxm6BtMJ0qlmFXonUYDBwz4NuGNoHLMopEjqXP9TwWK9lK/xKc6BUJle0iKbo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(83380400001)(6512007)(26005)(36756003)(86362001)(38350700005)(38100700002)(44832011)(5660300002)(6666004)(6506007)(2616005)(52116002)(66476007)(66556008)(8936002)(8676002)(6916009)(316002)(66946007)(2906002)(41300700001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RtVY44fCec9TlqAhJNsVkdQlB1u2rY7YbN+Wbs2VzA72vmiTd2AsA1kRK0Jq?=
 =?us-ascii?Q?SEoe9izod+/+VL+F3tc55hgTiHccstrsehX4QNxqKofxxhNVyxVG2bgwAAcF?=
 =?us-ascii?Q?d0diG2Cu7Pfd4XP1BYPjNKzL+yDvzuE09ecOWyF5CCXZHyunricN/WXpTUOG?=
 =?us-ascii?Q?n4TGaXihTdo4zPL0d8CKvoFFl0C03S5d8fPXzdR8s4LBI+0lnGpEuNDlGZmM?=
 =?us-ascii?Q?aF4mlrnWPhG9MX4B5ZQQ7JIfqrpsOITLJHqDrqGiFzgi0IMtjiDtt+NbJin2?=
 =?us-ascii?Q?lpyHfO0b614n8KG7aUv7RDyjBx9bAkgjduENiPxPv+n+ajYKaMphVTZ6njwd?=
 =?us-ascii?Q?yeIeOYoGD5r4f44BX/o1K3IxpI7DXkc+IY1+Jz1EOTM1EYrVhINAMBuPfkfn?=
 =?us-ascii?Q?KYhVyuH8ZuvRij3tRGc7xK5zBoHwWkfn0bhtGD7QmtlNqI+quLIT8duxhSvB?=
 =?us-ascii?Q?SbwmuS2KzQ+E0EOEN7YdMhVBu/H/O52cgnY7kRnMP/NQLMPTHpfDuCvfm5kH?=
 =?us-ascii?Q?s73mFsaleQDhoUH0IWCl4ecmc2i8CqFjF1BHlBS44c+jEDwQz0F401Ai5tW/?=
 =?us-ascii?Q?N16RSVlAaskDGYmYwtoBK4LO946rjV8Ho3A2sz6g6Lzf12TitXfod1/4FnsF?=
 =?us-ascii?Q?Xw36alQKx5wmHW1KYd/sySfvxVoRTa3W20AeCRE4AlN0tJwnS6/30YASeUq/?=
 =?us-ascii?Q?k/Sw16G8jJelym6yh8TsqQUT/7BKrS0kv4HwXVdGuv9mP/+OlWF/EM+q5cn0?=
 =?us-ascii?Q?oi1Zhpm/Cq1UbjbvgBDHRAQuLCuZE/DRMD7JLfwxsVZa5HHbcutX6H/R37Bt?=
 =?us-ascii?Q?fR/qn+EDqNDc0HcsBNema8L1ar1Zs51BGrqxmT+fOPGKuEDQ8K+VK1Bv44av?=
 =?us-ascii?Q?0kDWQ/lVSe5shFDOKfGk7KMtJBPj57ho9qC6ZD2VxLI838KmMvm/ft8llQOK?=
 =?us-ascii?Q?O2FEw+29O1eJi7E0Ly4m2Z9hL8MZT+zeXDuIdyDIX5VwafK7dYGna/0EUP95?=
 =?us-ascii?Q?7/+t6IEgpDBw3YX3xNUHEXtjF9w//YfZCgJU/H281Zexrl8p/7ln3OnHmPdI?=
 =?us-ascii?Q?hWOs2L0S5z/ueETAyph2/d2l8ZQmUjgrewZWx8Zd+uZhC5XsKPePCpmPIERP?=
 =?us-ascii?Q?3h1P8L6Nyg/3PHmxSWocFl9ZNTwgqRhISrJNhA8vsGRrk1VkfX9WIEHhhxuS?=
 =?us-ascii?Q?mJ9MKpv0m9lpC1zvrqaGr8rkceyxIaaq1L2JoKqt7ygRLaih5gq8uHwYV31z?=
 =?us-ascii?Q?1HnUS2Us5twBGZJVuR1/8jwDhrhvk4U/flQ7R4vRRX1pzMF2lLhCOQXCBmCG?=
 =?us-ascii?Q?+YnHOFIQAsUYlutwxOYLzGAAcXMT5L9cRchUZ3NCMqNYapDfZmBh7o5oSMdN?=
 =?us-ascii?Q?/JNi8MoJkm5S8Aa9508i/y3HxgeJpQluPvo+hObrpAOlrY9IJycapVtAeQCF?=
 =?us-ascii?Q?1QS6uEP7orHAY1qf8bvFXZoWplu3WlXQiaTBBqWd4YvGsFy9CvQBrLR+bgZ8?=
 =?us-ascii?Q?AYX7QCNc4gAP2ByAatu6rtTPzI2yb6nO+GFtlNKoDKwahLJQGFN4z//Vm2GY?=
 =?us-ascii?Q?dXVkfEeGWqv+8ZJzQJNGxA6llqxqmgvL0Rz1fzeSG/ZpTvo3fAJ5sKCJIAzJ?=
 =?us-ascii?Q?LztvqPRK7oIwP98bbdApitU=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5babe-c70e-4b47-f284-08dc10fae811
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:08:20.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awb8qHjXM1ztx+b4gxcbKC3dH9SNJ8zafVy4ljN7ADJGrYEdnLM8/TJhUC5k37fQRn0LgZpfiF8pNNTFHCM+VMCz+rlaRBQbfqcBi75hv5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2049
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 10:38:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15757

From: Mattias Jernberg <mattiasj@axis.com>

It can be used to enable the loopback interface, typically after calling
disable_network().

Also correct a typo in a debug message.

Signed-off-by: Mattias Jernberg <mattias.jernberg@axis.com>
Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0d317209d4234c5f05a9fcdc13c52f502f104018)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
---
 lib/bb/utils.py | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3f7f82d1..d09e1782 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -30,6 +30,8 @@ import collections
 import copy
 import ctypes
 import random
+import socket
+import struct
 import tempfile
 from subprocess import getstatusoutput
 from contextlib import contextmanager
@@ -1627,6 +1629,44 @@ def set_process_name(name):
     except:
         pass

+def enable_loopback_networking():
+    # From bits/ioctls.h
+    SIOCGIFFLAGS =3D 0x8913
+    SIOCSIFFLAGS =3D 0x8914
+    SIOCSIFADDR =3D 0x8916
+    SIOCSIFNETMASK =3D 0x891C
+
+    # if.h
+    IFF_UP =3D 0x1
+    IFF_RUNNING =3D 0x40
+
+    # bits/socket.h
+    AF_INET =3D 2
+
+    # char ifr_name[IFNAMSIZ=3D16]
+    ifr_name =3D struct.pack("@16s", b"lo")
+    def netdev_req(fd, req, data =3D b""):
+        # Pad and add interface name
+        data =3D ifr_name + data + (b'\x00' * (16 - len(data)))
+        # Return all data after interface name
+        return fcntl.ioctl(fd, req, data)[16:]
+
+    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_I=
P) as sock:
+        fd =3D sock.fileno()
+
+        # struct sockaddr_in ifr_addr { unsigned short family; uint16_t si=
n_port ; uint32_t in_addr; }
+        req =3D struct.pack("@H", AF_INET) + struct.pack("=3DH4B", 0, 127,=
 0, 0, 1)
+        netdev_req(fd, SIOCSIFADDR, req)
+
+        # short ifr_flags
+        flags =3D struct.unpack_from('@h', netdev_req(fd, SIOCGIFFLAGS))[0=
]
+        flags |=3D IFF_UP | IFF_RUNNING
+        netdev_req(fd, SIOCSIFFLAGS, struct.pack('@h', flags))
+
+        # struct sockaddr_in ifr_netmask
+        req =3D struct.pack("@H", AF_INET) + struct.pack("=3DH4B", 0, 255,=
 0, 0, 0)
+        netdev_req(fd, SIOCSIFNETMASK, req)
+
 def disable_network(uid=3DNone, gid=3DNone):
     """
     Disable networking in the current process if the kernel supports it, e=
lse
@@ -1648,7 +1688,7 @@ def disable_network(uid=3DNone, gid=3DNone):

     ret =3D libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)
     if ret !=3D 0:
-        logger.debug("System doesn't suport disabling network without admi=
n privs")
+        logger.debug("System doesn't support disabling network without adm=
in privs")
         return
     with open("/proc/self/uid_map", "w") as f:
         f.write("%s %s 1" % (uid, uid))
--
2.25.1

The information in this communication may contain confidential or legally p=
rivileged information. It is intended solely for the use of the individual =
or entity it addresses and others authorized to receive it. If you are not =
an intended recipient, you are hereby notified that any disclosure, copying=
, distribution or action in reliance on the contents of this information is=
 strictly prohibited and may be unlawful. If you have received this communi=
cation by error, please notify us immediately by responding to this e-mail =
and then delete it from your system. Critical TechWorks is not liable for t=
he proper and complete transmission of the information in this communicatio=
n nor for any delay in its receipt

This e-mail is environmentally friendly, just like Critical TechWorks, whic=
h lives in a paper-free atmosphere. Therefore, please consider the environm=
ent before printing it!

