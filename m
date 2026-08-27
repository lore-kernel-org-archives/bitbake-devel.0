Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F5C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:35 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com (DM1PR04CU001.outbound.protection.outlook.com [52.101.61.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3295.1787861252898703197
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=xg0509EX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.61.58, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwRUbAYLuJ4+kMsHN1sS/y+sycVtRgsOoshjeJgr0z334fwcCHK3AdxeW8bySVRf/NjOmML086QPdJ4f9n31tAHCA9ELSSC7lkbE+E9LOhARBys2gVM40z5zN1zeAYudkbM09LIwkx0K/uzZn66IQ36r8qzN5izu/eqzLdrIqQ3zt1sjtPH0a/+kBbQALf9Np6R72cVpPDoMugnfDSWtKNz3Sm/yxVL6GENsgKjt95oAvfWcnv3Q3uLz27l12/dty9RigGkR3g1ZV4B40hLYC8NhyoP2TEhtDrY400OS79Q/dBkqhXtKKw4VPtkZb0IId840n0boMdMLq3/mdD4Oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SfdXytjYNn1ZsouJRp74vtepu2YhthZaDycd1cEdgc=;
 b=KsQUA5G4n7CreMQbkSWogSfvSBxIJ9S6USgOaXRDXeh8UEA9l2pFdCnLKb3jvBugCXLbZw1T4Ip9WsreS9mDxYpY4Q8lB0TtFcwRaBPxDiKNQ2nXUoc7ktl4L4/YpbPpoeEGwA7hftnmw2RcBHQpB3J2uLSNw8xvpR2nfVlpFrSFjLr0UAOLg9Hcn4NM/L6ryFXnVsZ5184xfn0QDNdCCs5ZF/YE54XUncm0AK7cTxgDJKs67VRQLZ9dT1ILF2zCJtqmhv1W/dXXlu2p9DA5QS00BAsGybc1/xjIUyuZVHxcEQZlr0/LVyYKrt5Mw1SZwKugKBaHPH0Ca5e3rpRgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SfdXytjYNn1ZsouJRp74vtepu2YhthZaDycd1cEdgc=;
 b=xg0509EXUoEB4ciIBK2wCGYAPNtyEn/kwkXjJevjnSFh/3hWeZgbkcq/K0wVEZoGCgggW+qLkL8O+cd9fjVQG0oxF4fc+W0fpfvjLTiWY0+qOhAHqfX5AunvlxPpfx64tvXrYtELUB2VlsavSvQHNt52ByY2krfFejQB2CcCxfiNfFBLajcDc5vpR7n+lS803zum6qK5mb216d9T0dz+UY8LEq/gweKajcYwa3jCp1hn0ry5dFLrQWj8gmhERvMYiiKS7VR8AfxaMU8sgop0gJC1R+qMyZDnRUclNga0y5F+EshLo3Rt3tyWWrCqhS6CGIjP1El6Ngvo/Vy65VDY+Q==
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:07:28 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::aa) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:28 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:02 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 07/11] runqueue: declare pressure/load attributes in RunQueueScheduler.__init__ rather than dynamically
Date: Thu, 27 Aug 2026 16:05:59 -0400
Message-ID: <20260827200603.688796-8-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: e5763d0a-80e0-4a14-6233-08df0476d1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	hsqk79/FgW+6T4hEV3q/XrAkWLjsjhLgqxQ5+1/3TpcKjtfw8AVkAIpj+BtowZeguL2g4d/KSY/1oWXTw3AhNRnb+BXhJiLDovUtvfT52g0j++ukPo95i1CvauJzQtQXg9aPPaMNDjcXYo+m11pDxilU4MrGBw1Wj7nahKLtQfDVT5Nt4Ag4K0oSztDTXBCP6FCqU2Q34j1UzU5dDm7xgveSVUdi7040TK3wbLPaH/hiHnbXp3hYFu6s1C7F727HOffizR67jq7INrHbJPdWbL/vESHmMUOIvWmyidY0LAiUHsVuSNzl1tR373FxHeqHEbPX9dsoMY+FmLlyAEYjzp4Xu34a1ZykovYNyTqzH1J3i2WSAQPZaAN1x2UYk18SU1gq4DnwsEAkVRFJCYeEebrLtqlWTVE8ZVMzc6wF6U8MGzAcDICz4go5UjpPe9H6zzq9efh5zTDjMuwrFWNbvyyqCPZQt8B2rtpTF/88Le0Z1CWAI19f2Q75YWe847k3J6LZc+Gzf6r9jwzGmxKBExCV+Aq3jEL9kHik4G7Z+0gTJocpNR0Dhi05dl/AT6Mkk/AsIpMshQA+N7ADknAhUeZkYW75jrbasE3eF2tT4gsxs0IMaHvVcZGb0PhD5rWteWuU90KhCYWX5RFEd6HIlRoRuvJ/Vw+mnT6xcOllaC8zPo/2O3zHwUAnWmLAMOXQUyI/M+nMB5ioGbyAX5Wopw==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JhiLZLkFeZa4xotCY1jvr24Ve1XQtIkfanCnh41BDUe2Ulh8w7g/a7WkoPzcXDhOCfoyDV63RLBe29w0ZUkbV9RScv05emfyFkSAAHCuTMSDYs08G2Yy3r8wo+rwWAR0PmTmjNBZ36h/tJDYhw+c6t9ImsjEVfYlYe3U67tZatScexd8hoeUc3tkZqTMBNcTClcJoBTLTv/XLhzjnQzqjFupQ1TFdYL8Irv2TkMAwmEbwn/MRVC+nSyW2IsMeT1FKNxIRT9iv4/WAdPT2dqXg03dPy+UN5JdlsTWn8tx7MYeHN5Qq5EfLO4/IXZPnbJ+CL9+mx6dZAiIgIvsikRnaXRckAkRrYbIU+8Uebvp5zX/+FPemNQfa4jWrnVRSQZa5Ux+bYa2aCfl9Qc7ATjZR8JmlNQQEp1rvawvqg60b+p2MBjOomp+6in8KnK/WPEf
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:28.0715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5763d0a-80e0-4a14-6233-08df0476d1c7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20081

From: Chris Laplante <chris.laplante@agilent.com>

Also moves float parsing for prev_* to when the files are read, rather than=
 every
call to exceeds_max_pressure.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c55dfd9d8..9325bf356 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -173,6 +173,13 @@ class RunQueueScheduler(object):
                 self.buildable.add(tid)
=20
         self.rev_prio_map =3D None
+        self.prev_cpu_pressure =3D 0.0
+        self.prev_io_pressure =3D 0.0
+        self.prev_memory_pressure =3D 0.0
+        self.prev_pressure_time =3D 0.0
+        self.check_pressure =3D False
+        self.pressure_state =3D None
+        self.loadfactor_limit =3D None
         self.is_pressure_usable()
=20
     def is_pressure_usable(self):
@@ -187,9 +194,9 @@ class RunQueueScheduler(object):
                     open("/proc/pressure/io") as io_pressure_fds, \
                     open("/proc/pressure/memory") as memory_pressure_fds:
=20
-                    self.prev_cpu_pressure =3D cpu_pressure_fds.readline()=
.split()[4].split("=3D")[1]
-                    self.prev_io_pressure =3D io_pressure_fds.readline().s=
plit()[4].split("=3D")[1]
-                    self.prev_memory_pressure =3D memory_pressure_fds.read=
line().split()[4].split("=3D")[1]
+                    self.prev_cpu_pressure =3D float(cpu_pressure_fds.read=
line().split()[4].split("=3D")[1])
+                    self.prev_io_pressure =3D float(io_pressure_fds.readli=
ne().split()[4].split("=3D")[1])
+                    self.prev_memory_pressure =3D float(memory_pressure_fd=
s.readline().split()[4].split("=3D")[1])
                     self.prev_pressure_time =3D time.time()
                 self.check_pressure =3D True
             except:
@@ -208,15 +215,15 @@ class RunQueueScheduler(object):
                 open("/proc/pressure/io") as io_pressure_fds, \
                 open("/proc/pressure/memory") as memory_pressure_fds:
                 # extract "total" from /proc/pressure/{cpu|io}
-                curr_cpu_pressure =3D cpu_pressure_fds.readline().split()[=
4].split("=3D")[1]
-                curr_io_pressure =3D io_pressure_fds.readline().split()[4]=
.split("=3D")[1]
-                curr_memory_pressure =3D memory_pressure_fds.readline().sp=
lit()[4].split("=3D")[1]
+                curr_cpu_pressure =3D float(cpu_pressure_fds.readline().sp=
lit()[4].split("=3D")[1])
+                curr_io_pressure =3D float(io_pressure_fds.readline().spli=
t()[4].split("=3D")[1])
+                curr_memory_pressure =3D float(memory_pressure_fds.readlin=
e().split()[4].split("=3D")[1])
                 now =3D time.time()
                 tdiff =3D now - self.prev_pressure_time
                 psi_accumulation_interval =3D 1.0
-                cpu_pressure =3D (float(curr_cpu_pressure) - float(self.pr=
ev_cpu_pressure)) / tdiff
-                io_pressure =3D (float(curr_io_pressure) - float(self.prev=
_io_pressure)) / tdiff
-                memory_pressure =3D (float(curr_memory_pressure) - float(s=
elf.prev_memory_pressure)) / tdiff
+                cpu_pressure =3D (curr_cpu_pressure - self.prev_cpu_pressu=
re) / tdiff
+                io_pressure =3D (curr_io_pressure - self.prev_io_pressure)=
 / tdiff
+                memory_pressure =3D (curr_memory_pressure - self.prev_memo=
ry_pressure) / tdiff
                 exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure and cpu=
_pressure > self.rq.max_cpu_pressure
                 exceeds_io_pressure =3D  self.rq.max_io_pressure and io_pr=
essure > self.rq.max_io_pressure
                 exceeds_memory_pressure =3D  self.rq.max_memory_pressure a=
nd memory_pressure > self.rq.max_memory_pressure
@@ -229,7 +236,7 @@ class RunQueueScheduler(object):
=20
             pressure_state =3D (exceeds_cpu_pressure, exceeds_io_pressure,=
 exceeds_memory_pressure)
             pressure_values =3D (round(cpu_pressure,1), self.rq.max_cpu_pr=
essure, round(io_pressure,1), self.rq.max_io_pressure, round(memory_pressur=
e,1), self.rq.max_memory_pressure)
-            if hasattr(self, "pressure_state") and pressure_state !=3D sel=
f.pressure_state:
+            if self.pressure_state is not None and pressure_state !=3D sel=
f.pressure_state:
                 psi_logger.verbose("Pressure status changed to CPU: %s, IO=
: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake thr=
eads" % (pressure_state + pressure_values + (len(self.rq.runq_running.diffe=
rence(self.rq.runq_complete)), self.rq.number_tasks)))
                 bb.event.fire(PSIEvent(pressure_state, pressure_values), s=
elf.rq.cfgData)
             self.pressure_state =3D pressure_state
@@ -240,7 +247,7 @@ class RunQueueScheduler(object):
             # bb.warn("Comparing %s to %s" % (loadfactor, self.rq.max_load=
factor))
             if loadfactor > self.rq.max_loadfactor:
                 limit =3D True
-            if hasattr(self, "loadfactor_limit") and limit !=3D self.loadf=
actor_limit:
+            if self.loadfactor_limit is not None and limit !=3D self.loadf=
actor_limit:
                 bb.note("Load average limiting set to %s as load average: =
%s - using %s/%s bitbake threads" % (limit, loadfactor, len(self.rq.runq_ru=
nning.difference(self.rq.runq_complete)), self.rq.number_tasks))
             self.loadfactor_limit =3D limit
             return limit
--=20
2.43.0


