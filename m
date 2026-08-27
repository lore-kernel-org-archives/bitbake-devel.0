Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A3C61DD4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:03 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com (BL2PR02CU003.outbound.protection.outlook.com [52.101.52.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3.1787861879132967784
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=blVcbXIY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.52.50, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIE9GBrwz/s8yfKAOx29IfMXsSBf8SC1L7GQ0DO+8gv/25O/9J6GjOZtfMmz4vFmYDKa5ZXE09M64+16g8yS6GjqNBZmawOCN/ETtawTJyelVMmafKqoHo+Qcet+K/E3dimFKTbPJnW4stpC3+ZPnoD9vhdfS/vMsni57AGYfZrdOHpfZK4Pfh8gEvAUEa+hpGdjZQzq8KXnnW4n66CKW/NRoDgFGifQUcUgPL7lU2Ns3KTuahLTvEbY4Ox1wtSLt4wfC9jO0HxBm1BxC2OFCvyvJgP8EhU/2QEMXImooPCdx1YMrPlhT6c/JFTWLltTcy06bnCctu9qs3rP9+j3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR317fy/4965oqi+ebBBlKCNyTPYO8mGTTc/KFf7IoY=;
 b=NMoU8DM7TfY5/w15KANd/J7Wp753DLPlv8mGUcv0deKCIvqfHCjLCRFhqfFcDokmLLTlE0emyYmk/+5oyp/84PVFDROG5EOER11XAuvUlftaEFBf2blMj+w4aqv7Mm/OXgjZY86qnKQMb53vws+NcJGM3YtUBMl8vQZxQoI/RcCJ/i942QQsdkJx3MpcqliepvIpkh2/o1quqIpqfZzEqqSdfW18Y8i5C7xkOjLqbzzFrsKP00DDnQ7Ck55oUUeHc405N2Px7R/ldz1h/QWwtw8T+zd9JuZ0Sdri9fztkt5RtLD1sVVMkFnZQZXcAtguuCBqISqKts6F1vYRct2xXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR317fy/4965oqi+ebBBlKCNyTPYO8mGTTc/KFf7IoY=;
 b=blVcbXIYJqWn7EgcQxoN/HMHgNiKofYDCTucRuOhcssSYoM5GUbxZ1Jjx5jF2zi2i12WWnkfcptKJ5oSSUwcZFXPQP/sRsO2rpKkn1V4sbEejHRCb0+BWgo7InKTwFnQTOMs1ozvAZ9ePlNTXnkBAt11ebnOE512UkRAt5Ul3OqD/YeS9yTQEcljV3JPAgeKq1CAtwAxpjXt2MbbNKyfohQITSbGIrz1P+nI6IhHSrJO1UsFOoQCNmf05VMGXkR0MD8GReKoMOgiAIKSDEuRTV06UUnGNBZLZ+JzMeySupNJU6YG0wH0WwneckEwvkWghoo0kPhJSoKxH+aVNNAcVA==
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:17:49 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::46) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:49 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:33 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 07/11] runqueue: declare pressure/load attributes in RunQueueScheduler.__init__ rather than dynamically
Date: Thu, 27 Aug 2026 16:17:17 -0400
Message-ID: <20260827201720.698482-9-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da5c407-7d78-45e1-8a48-08df04784426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	7lWYuH8hHspk7Ehh5jc5FpCHYwy5CU81gT+umYBY4tpKwsn3nM/KMpx561SfWht0+XKp7EXwmmt/uc33WiJn8IAu81bM+1K+U/v1grf/jkgOucHWVTNJgye3LAIXRIUfFVuqXIQVNcXMLkhajebaJlIxus72O78/cI4ZIwfcCVfWM85vAou0cWW7RTVUeNOpkp8jnrB1fwLnyqon1cKK6e/3ffYh03QSTaojA0DZFRQfD4Yekax/KOIXHOE4KUFAgAii1q/weMsLhQllca2Xy12xsDoptTDW9rqF9nbD7VqigdR/Kjh+QbGevyH+K9JN9AiQNtonhIjmEypdJ/jFWP5qcx/rL6NqtFNA1m4i78k3egVR+gAWi6MuA0xZjaYysCV/0yArB4yWox2ozxynlcJn8S6NZQJv2BeonqxpZ8QRy6hFYZ5zFwGzenj8TcUZ7pC9t3ujibbnz69RHudFM9DGhBRj6VxBYhhEmlNVxyAxFtapTbf9AhL3rha+wEnYH4/9aHnJM2qdVBirT1gCf4rMx3e/2wqY0m92HbOoeSZAEyCKbC6eGeOoHxwK1CvcQsZJRLsPpx76MU3aHt3zUZuNJfQSWxoHQRwAWtlQwYUdDsrDGEHKPeBQjqcu64Y6ix/9IbdHUvPpmmuDE264RMY5jd4OkSmKr6idKWnUIOQuoHxt2mejn/N4kr1g6qJFDUQdTsD0w50F+eBLm/hJzQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	o9qIaVoAxYKGieEf3W+DcNrDohygvbbpSw79dfDMBj1u6CjDLzeefL0q2/cjhJKN1fsT8VrFyBfPWug8cuRrkT0IMQ+9h2wd6USEBL0WMp4EVOgcHf8/KSpsffRvddUssKxn6/gK09a2FXErDqeanQ9Wr+VTU1xKtHwZjqH9PSZEW4cvsJiaMBEID6TIqoeMR2f+Xz1Tnx7sm4OLW+zQAUDW7WbxJ/LQaNOyqCmjj5pZrbMO2wwzkIwGT2M85/a063PQhjHNYr50LmrwMBloxGRzAGYv2jxMeS2UsNoGHXCg3/I3gNd+h5aXEmgKdDtbMaPijGjF99oL+Iam2tJYitmKKekcZgfdzAcgZfEZDRMvnjX5ix5PG4vqogYehk66Rzw9/qP2QEuihfO2ZfM3wNmLimhPLVNyofY6Jf6AH3Poc+dtKQtmO3jECnXLadcL
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:49.4476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5c407-7d78-45e1-8a48-08df04784426
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20097

From: Chris Laplante <chris.laplante@agilent.com>

Also moves float parsing for prev_* to when the files are read, rather than=
 every
call to exceeds_max_pressure.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 54e1066a9..8b92ec7a9 100644
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


