Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.68])
 by mx.groups.io with SMTP id smtpd.web12.10079.1596378939768641336
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 02 Aug 2020 07:35:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=dt2FCwuR;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMZJhBGra8s4Sg5SEDKoYbuhWHVT44ieddBUoUFfFQJi37GK3J5ja0sdf06KvnJLpaRw7+oOVCrUkxdyp9E6FuIiosTKXFw+gkkYE4utB1C9j3b+WJX6+sGr+1pFEqNXrUK2KhvToP4FL0L53riBIm0hupESAVm6Phm1tGvpORm3zXT0TGgnO/NJe1OY+sYiPruytrL7YH7+sn2IXuCFFvaHSRVEmPragefRzCZt0xsDGClb81RFLIsGlrs8wZDFiuArMl6FNuaxh4j+U11wvoGRf8OqF3EoFZwQPnqqElIOhzF1EqVQ+GDTVn4pz+MzNTEz4WjG3yFL+s48SvZBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfkiGg8/RvtaGgMHtYjx1ByKFrdK1nRcv1vC9MA7PXY=;
 b=CluEdnwjXAnFzr+sQewbaIcnERVgRmTqn74cJaKvMIEGKJnqI3/P/Kq0RiR5qTVCu9fEm8G6Ow03PzppuWs+W4aPM9gEv+uI+4Zoc3D8B63wKnAr8jQxZynz4lHwfqDtytj/OaYUNTu3v1tZH/WtD6rwNa8e9xN3wyhH52TD2da3gu8ufUASAqmHVZAshBikLCHJNlVgFzKJipujgW+3Ox8bpSVoCdFQMQLtDNcUi6GwyJfyxqck7RCxMn/2Ote583DiFOowyMRw900pZ3fFCA31GGF5Iyfpx9j8KlCyJxRMykKaEw9MYc1pIIpRjR3PG2W9SvCg2jnbTfjBGOCUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfkiGg8/RvtaGgMHtYjx1ByKFrdK1nRcv1vC9MA7PXY=;
 b=dt2FCwuR6SCI+XxO4iVHojG9ZWRLiQ8b35r5UCt2JLyXzRxnCWCBNNJNfToPzeQnkCv20N65POhtGTrE0hlYwQ8pMsQUzqTVd3UhVHqnG/oVnFrV5Xbrnio0VWZWQ3rLfivNjz48iJhBRzsWdxfCW77OTKAj/p2fa7/rqindnz+BpvlLi9LsM7wSZ9jORLEBDxu8r+9uINkfqE9OBoYPiAyaSxV60RLBn+vCnBcFLkc0Cu1CoSNt3hsPu63bkfS1Iqh/dyy5j/jTTu3juTd4IZ12mET3//J6jXq5pimjQP9U+sW75/iij2oYBcC5BdSz4AWPSicjMZ8UXPlIZMV0ZA==
Received: from CO2PR07CA0067.namprd07.prod.outlook.com (2603:10b6:100::35) by
 BN7PR12MB2707.namprd12.prod.outlook.com (2603:10b6:408:2f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Sun, 2 Aug 2020 14:35:36 +0000
Received: from MW2NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::45) by CO2PR07CA0067.outlook.office365.com
 (2603:10b6:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Sun, 2 Aug 2020 14:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT058.mail.protection.outlook.com (10.13.181.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Sun, 2 Aug 2020 14:35:36 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Sun, 2 Aug 2020 08:35:32 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 3/4] build: print a backtrace with the original metadata locations of Bash shell funcs
Date: Sun, 2 Aug 2020 10:35:04 -0400
Message-ID: <20200802143505.88409-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200802143505.88409-1-chris.laplante@agilent.com>
References: <20200802143505.88409-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 887e8614-fd45-46f1-a985-08d836f151e0
X-MS-TrafficTypeDiagnostic: BN7PR12MB2707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN7PR12MB2707882C83C92A8ABF1E2A628B4C0@BN7PR12MB2707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	amaIpip/JcP5RtJF4HGRTw1lRYBZqQCEEcRMPY7zgQNAtLfehBq5KuGrbYPegJOV0V5i2AkxvQfcJjLyzU050fIArYTe/FC2ebBiZV1vypL5LPxO7qqwwRBGGXhPAA9ndRPHLXxZME+0yRa+Bp7OcbKQ4ADzHtaKGNzvmEvZh3ixDoD8YaBp6jhnSRSVLjqK1HfryJAm2XJm+b8foBx449gSUFXh2TTYz45gWDDH7UHEYiqOTZsLtuJPWBU2mRLjwkrl3fb0StVcYzzSeGSI1MX0a8Iq5QnrAaAzAZ/CNUBP5DbioEi1YfpXTKoo+11tYdCdvok0mJklSFrDzvmv3uwwD/VO0Rki5cYl23Q8d1RTpbYlTtJ4pI8hg/MoraGu6pMSGO20MGd0CN52rDGMNC37r/KbeH0bkIkVVtHcf+c=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(376002)(346002)(29502001)(46966005)(2906002)(44832011)(82310400002)(6916009)(426003)(478600001)(186003)(82740400003)(36756003)(8676002)(956004)(2616005)(316002)(36906005)(8936002)(83380400001)(47076004)(356005)(26005)(5660300002)(1076003)(70206006)(86362001)(336012)(4326008)(6666004)(7636003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 14:35:36.0442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887e8614-fd45-46f1-a985-08d836f151e0
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT058.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2707
Content-Type: text/plain

Leverage the comments that emit_var writes and the backtrace that
the shell func writes to generate an additional metadata-relative
backtrace. This will help the user troubleshoot shell funcs much
more easily.

E.g.:

| /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873: line 168: no_exist: command not found
| WARNING: /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873:168 exit 127 from 'no_exist'
| WARNING: Backtrace (BB generated script):
| 	#0: myclass_do_something, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873, line 168
| 	#1: do_something, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873, line 157
| 	#2: actually_fail, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873, line 150
| 	#3: my_compile_extra, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873, line 152
| 	#4: do_compile, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873, line 138
| 	#5: main, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.87873, line 181
|
| Backtrace (metadata-relative locations):
| 	#0: myclass_do_something, /home/laplante/repos/oe-core/meta/classes/myclass.bbclass, line 2
| 	#1: do_something, autogenerated, line 2
| 	#2: actually_fail, /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb, line 36
| 	#3: my_compile_extra, /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb, line 38
| 	#4: do_compile, autogenerated, line 3

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py   | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/process.py |  3 ++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index ad445aa9..834078fd 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -16,7 +16,9 @@ import os
 import sys
 import logging
 import glob
+import itertools
 import time
+import re
 import stat
 import bb
 import bb.msg
@@ -470,6 +472,62 @@ exit $ret
             bb.debug(2, "Executing shell function %s" % func)
             with open(os.devnull, 'r+') as stdin, logfile:
                 bb.process.run(cmd, shell=False, stdin=stdin, log=logfile, extrafiles=[(fifo,readfifo)])
+        except bb.process.ExecutionError as exe:
+            # Find the backtrace that the shell trap generated
+            backtrace_marker_regex = re.compile(r"WARNING: Backtrace \(BB generated script\)")
+            stdout_lines = (exe.stdout or "").split("\n")
+            backtrace_start_line = None
+            for i, line in enumerate(reversed(stdout_lines)):
+                if backtrace_marker_regex.search(line):
+                    backtrace_start_line = len(stdout_lines) - i
+                    break
+
+            # Read the backtrace frames, starting at the location we just found
+            backtrace_entry_regex = re.compile(r"#(?P<frameno>\d+): (?P<funcname>[^\s]+), (?P<file>.+?), line ("
+                                               r"?P<lineno>\d+)")
+            backtrace_frames = []
+            if backtrace_start_line:
+                for line in itertools.islice(stdout_lines, backtrace_start_line, None):
+                    match = backtrace_entry_regex.search(line)
+                    if match:
+                        backtrace_frames.append(match.groupdict())
+
+            with open(runfile, "r") as script:
+                script_lines = [line.rstrip() for line in script.readlines()]
+
+            # For each backtrace frame, search backwards in the script (from the line number called out by the frame),
+            # to find the comment that emit_vars injected when it wrote the script. This will give us the metadata
+            # filename (e.g. .bb or .bbclass) and line number where the shell function was originally defined.
+            script_metadata_comment_regex = re.compile(r"# line: (?P<lineno>\d+), file: (?P<file>.+)")
+            better_frames = []
+            # Skip the very last frame since it's just the call to the shell task in the body of the script
+            for frame in backtrace_frames[:-1]:
+                # Check whether the frame corresponds to a function defined in the script vs external script.
+                if os.path.samefile(frame["file"], runfile):
+                    # Search backwards from the frame lineno to locate the comment that BB injected
+                    i = int(frame["lineno"]) - 1
+                    while i >= 0:
+                        match = script_metadata_comment_regex.match(script_lines[i])
+                        if match:
+                            # Calculate the relative line in the function itself
+                            relative_line_in_function = int(frame["lineno"]) - i - 2
+                            # Calculate line in the function as declared in the metadata
+                            metadata_function_line = relative_line_in_function + int(match["lineno"])
+                            better_frames.append("#{frameno}: {funcname}, {file}, line {lineno}".format(
+                                frameno=frame["frameno"],
+                                funcname=frame["funcname"],
+                                file=match["file"],
+                                lineno=metadata_function_line
+                            ))
+                            break
+                        i -= 1
+                else:
+                    better_frames.append("#{frameno}: {funcname}, {file}, line {lineno}".format(**frame))
+
+            if better_frames:
+                better_frames = ("\t{0}".format(frame) for frame in better_frames)
+                exe.extra_message = "\nBacktrace (metadata-relative locations):\n{0}".format("\n".join(better_frames))
+            raise
         finally:
             os.unlink(fifopath)
 
diff --git a/lib/bb/process.py b/lib/bb/process.py
index 2dc472a8..f36c929d 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -41,6 +41,7 @@ class ExecutionError(CmdError):
         self.exitcode = exitcode
         self.stdout = stdout
         self.stderr = stderr
+        self.extra_message = None
 
     def __str__(self):
         message = ""
@@ -51,7 +52,7 @@ class ExecutionError(CmdError):
         if message:
             message = ":\n" + message
         return (CmdError.__str__(self) +
-                " with exit code %s" % self.exitcode + message)
+                " with exit code %s" % self.exitcode + message + (self.extra_message or ""))
 
 class Popen(subprocess.Popen):
     defaults = {
-- 
2.17.1

