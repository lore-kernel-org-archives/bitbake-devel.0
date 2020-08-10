Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.85])
 by mx.groups.io with SMTP id smtpd.web12.49102.1597078550243729683
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2020 09:55:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=OuReAVwa;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.85, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NitQV9afLAOh7t/V6jPstF7Lzvpg8+naYE3PrS/SAz0iIpyiO9vDNoG0H3sXJLwCZdeWprtHIsoPvEXGk8P4dSLQYCnPQrq/L8Xu7GGWZF8iiWQN/jE8TCa3P+veTM42kuPpOiJm2hbkai4jJtmCXih67ihe4+1RpBW2ApAcOWcbb+DEX88yzgyhNQJpHJKKj4LcXliLyQCzsPAn6hQR+tEYpKP1l1bHbQ0uFHptQcE2R7Kra23tJ+TfiBrASN9i0gP3YySw3S0FamtPYVyCoTCUF+hbkqQ+wDfNRLxEceZTUZaW+b8saVkhGo/K28wuqRDgkAFle7XN2IC1HBIQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfkiGg8/RvtaGgMHtYjx1ByKFrdK1nRcv1vC9MA7PXY=;
 b=YI6rGvkvAQGdm99sZiyburpfZOC9EW0Au3M8IzLvBTvm3aS5FrxxnRNA4euLA+n50YLV9U6jtmTkCCwFeGuEDI3NVsEobz72770n5f15svkM5yk5LXeKENfc2jIvI9GIEj21xU9btwr2EW8bYFSX2wtcJuDhjvjzw3ftk69v2NnY/VYh8aQ41DxxRdngdbK8a4MtLcPuWvqf5wQvZUlywG9ICntynY03zbdc4G6RK5uQ2EctnJz91VLi/VCQkMADuC0u7bX/h25iKd8xFpM0UlUEx1mTbfkdplg47/YODQ9vsgObkt2VpPJFn/9dTe2kYVJzg5202jz/7t49aUqj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfkiGg8/RvtaGgMHtYjx1ByKFrdK1nRcv1vC9MA7PXY=;
 b=OuReAVwaTqy8DGZMxw+v6etAcBrdEKv5mIReg6Ij7iLa+2R+hKfIrbTpisnrXBzxSnEoFOxlZcYUsKfOMlPQCBTpNkjopU+P5SreBBMOg8jvnFnXcpzmO8lZ2MBnvY02brsYE6LOKz71nzOJk/A06PmyMpQQ7cDMZrjMraJJoohRFBFMkPuLFSU3ORef3/UBRgHajllZGVdds2AGd4+LWooKe/tAVpxaffCwuZbjkT9juz+xi5yXghKuQxCbfI15BtLHpaqVVS89oLr3qqpmtMGoHTajwWz7twdrcX923G2CNx0Jhj2TY07YjGxortjdQHn/RQQp1LbCs2nQz8XXRQ==
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 BYAPR12MB3367.namprd12.prod.outlook.com (2603:10b6:a03:d7::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.20; Mon, 10 Aug 2020 16:55:49 +0000
Received: from DM6NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::f4) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Mon, 10 Aug 2020 16:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT010.mail.protection.outlook.com (10.13.179.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.11 via Frontend Transport; Mon, 10 Aug 2020 16:55:48 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Mon, 10 Aug 2020 10:55:45 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v3 2/4] build: print a backtrace with the original metadata locations of Bash shell funcs
Date: Mon, 10 Aug 2020 12:55:22 -0400
Message-ID: <20200810165524.37417-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810165524.37417-1-chris.laplante@agilent.com>
References: <20200810165524.37417-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead0df34-efc1-4f5e-502b-08d83d4e3b86
X-MS-TrafficTypeDiagnostic: BYAPR12MB3367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB3367D9CFC7DE2531AE092E418B440@BYAPR12MB3367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dJukCUmfHdu04zX3fYbACOCoJfOVmgf0TeX1Hw6RafppdHGcL6yZyU65IY2B9NCdKLMrtWGuyIqwBKj9hUheJtxjEw+ZF9FvCdwlBE4AkcmrUkKRJW0Mx4boYnYqAN0An8VzC72h6WJRpHWum6N8d6g/XJWVUJM1bg1GhVrtzshD6i6tDsjZxqB7ruNDOlqg+WeybuOVuM+5Xr2+Y5ViaA9yf/J0X7ta2abFi8MrFYWZQhORdKv+KtnzNE8mBBuOhQCzy5NZ/GvmjskNmsXrFFo+v1/lAHsN1yjaZu9z6od3Yo5tB6rQuReEIotGNJ9I/Xfjf981X/2pVBJiV/r+1/p4NrMV5O8xiMkAJ8iLon0lIufrgMDZTqNuHDigXo4zUdY1CGmMQMIzkmPPQZGgedu7l3q4wKhb5DB3KEEqliU=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(29502001)(46966005)(2906002)(8676002)(107886003)(86362001)(6916009)(4326008)(82310400002)(83380400001)(7636003)(5660300002)(47076004)(82740400003)(356005)(478600001)(8936002)(6666004)(186003)(336012)(26005)(1076003)(54906003)(316002)(36906005)(426003)(2616005)(44832011)(70206006)(956004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 16:55:48.7207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead0df34-efc1-4f5e-502b-08d83d4e3b86
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT010.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
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

