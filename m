Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.85])
 by mx.groups.io with SMTP id smtpd.web11.9.1597438639406941848
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2020 13:57:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=kN8zxPyV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.85, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLHzQziXUa+fOTPNxg6Ffwps8ZdGffFZ1NOOW7NoWL7ImZHhlxw4gNZ2FIiV9gbrRsN91kvoL4G79xQYP6BbpSavge5EkqMMSqc67OGGLpVd8nxSx7TaBf+d0sDdjjNIcPNq8fF3lzvN/zLGpgSpw0rQITTey293QDFS5N1TdWVvnPdUx/t3TstEV8uKx657ss3bIqrj9TdU2n+g47kBI7XuYSG4rdKDhnLkqEISd0l+EZ98f6QJ5FJsolCuEASMk5bQiWdImVrWLe/wOWQFly1CDPOUmH5vcMbNKuvIctUtBzGXHIQfFbuxE4sumxwKUmmi2HgDNWkb6KnN8/4kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8Lou3VDMpmN9C2eZ3j9ZQgFtO12/K+0+dvNW0l6tY4=;
 b=e3ipTpRVJsIbeblaVD392c380nNhlfLlxKyXyOip2ial0QtjE/1xlCdbH0yHJ1D8SANZrxFClpyI53ysr+vrWD7Ks4TiuAWxPBgqBVl+uPxXfAuKd2Y/tqHcCjzkzOlNXobH5sBA4oX2gsPhyUxwQUKHfZ6snOQHmgS84tADaBsm48/FBgTGIiQZ35VQvyZY0SqJqiA4zwh/UL6CRTZqqQvz2oIotlXnIwZzkFvqZEhqVt1uoBT+YPRlVQpObolDFWu+ik8uNWQ0Ce1pqM5u/zfaE1DnkGRdMNGKRwmiFSksJrFCvUl9R7OTnYF3HNku9G3ZMImSeDPZN9NduonPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8Lou3VDMpmN9C2eZ3j9ZQgFtO12/K+0+dvNW0l6tY4=;
 b=kN8zxPyVpyLTSiA5W71taUcZE3IikgdyzOSah7kKp3zNqrkWxfYuzMMtoXsWtmdiTm+Pe4jgVQuept5bh3MjCcuqvCEJ5RcpaOirOJUMSt0UtYx7kCYCq8gMcromhme+58DOefTwCoEQJXtQSc9giHWlw/DgfxvaRu7pGv8t8lLvHWesmJHjwNoFKmbMQHjruA5k3ISWd29OMr18Y6HcjX55/gA5H9ocQG6BXKPTE48sBg/yhTxiW71K2O/mV83KcKiavR2BCWSsWFOYo7PLmqBn9NGqpLzHN/0HjJZWKlpAqFWvvUn/QInL/eceqhZ2ti5dCTH5bCWoZTUGGYyscA==
Received: from BN8PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:94::46)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 20:57:14 +0000
Received: from BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::f6) by BN8PR03CA0033.outlook.office365.com
 (2603:10b6:408:94::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Fri, 14 Aug 2020 20:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 BN8NAM12FT062.mail.protection.outlook.com (10.13.183.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Fri, 14 Aug 2020 20:57:12 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 14 Aug 2020 14:57:07 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [PATCH v4 2/2] build: print a backtrace with the original metadata locations of Bash shell funcs
Date: Fri, 14 Aug 2020 16:55:57 -0400
Message-ID: <20200814205557.69655-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200814205557.69655-1-chris.laplante@agilent.com>
References: <20200814205557.69655-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a205006e-7604-4856-c2c7-08d840949e14
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SA0PR12MB4429ABEDEDBA155EB4BF2F3A8B400@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kFv4RjQSoo/1U4sGkel7P3geuWGnOrlQompAxcTo0djSs6ZeG4NmQrkCn0eOePZuxOhNWCldhCQ24EvrTpyu+pSONzCycEbFz9HaeEzCUQemngvSqCJnhh/IQ51AXHJyL4CTQOd8G8o5jU5A14OyXjKB0LgCq0tDie7kzOKbHFYSxPHKyCTqeXYEeCyQmTIcY2fD3ewxnwj4+v6WeJRS3lVmAyLfL+ORdqzjAwvtDrdSBe2fzOgacSZscI1gIsEzaKy6G6rRxa95oOIs5sCdXHn63iIAn0JbHUZ94AsG+eH8X1wwSpIzXqYz9Ylh4ki8ejwOU0wEm6EMCUtc7VNPoEdbIxbHH7wHdMGiW61uNBiM1RbwMqUjhgcA8gxGg6PF26nV3/Q1i2VdOEkHVDuxl32teD6ckwHy6ue8wp+JXF8=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(29502001)(46966005)(356005)(82310400002)(70206006)(44832011)(2906002)(7636003)(8676002)(82740400003)(336012)(86362001)(316002)(36906005)(6916009)(107886003)(4326008)(956004)(36756003)(186003)(426003)(1076003)(478600001)(83380400001)(2616005)(26005)(5660300002)(54906003)(6666004)(8936002)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 20:57:12.3064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a205006e-7604-4856-c2c7-08d840949e14
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Content-Type: text/plain

Leverage the comments that emit_var writes and the backtrace that
the shell func writes to generate an additional metadata-relative
backtrace. This will help the user troubleshoot shell funcs much
more easily.

Example:

| WARNING: /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.68955:171 exit 1 from 'exit 1'
| WARNING: Backtrace (BB generated script):
| 	#1: myclass_do_something, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.68955, line 171
| 	#2: do_something, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.68955, line 166
| 	#3: actually_fail, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.68955, line 153
| 	#4: my_compile_extra, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.68955, line 155
| 	#5: do_compile, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.68955, line 141
| 	#6: main, /home/laplante/repos/oe-core/build/tmp-glibc/work/core2-64-oe-linux/libsolv/0.7.14-r0/temp/run.do_compile.68955, line 184
|
| Backtrace (metadata-relative locations):
| 	#1: myclass_do_something, /home/laplante/repos/oe-core/meta/classes/myclass.bbclass, line 2
| 	#2: do_something, autogenerated, line 2
| 	#3: actually_fail, /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb, line 36
| 	#4: my_compile_extra, /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb, line 38
| 	#5: do_compile, autogenerated, line 3
ERROR: Task (/home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb:do_compile) failed with exit code '1'
NOTE: Tasks Summary: Attempted 542 tasks of which 541 didn't need to be rerun and 1 failed.

Summary: 1 task failed:
  /home/laplante/repos/oe-core/meta/recipes-extended/libsolv/libsolv_0.7.14.bb:do_compile
Summary: There was 1 ERROR message shown, returning a non-zero exit code.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py   | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/process.py |  3 ++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 98cbc48c..5479a53d 100644
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
@@ -495,6 +497,62 @@ exit $ret
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

