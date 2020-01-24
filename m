Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
	by mail.openembedded.org (Postfix) with ESMTP id 2167B7E71B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 15:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=QWjs3fzA5E5ySPJ+Afxcih8uJY4pG87RoRgTT5g4VL9wF7iTgpFHL/iw0Ja2jP5vcjd2xEqdMrKfwcHmHWsK6ey3JbETXhNMoVkQa3qqrbgFNZ75pcUt83QaOaMF6/77BM3WZuOn4udRuDp+9I3i+VmTvx2hkUqYNhICddOUTy2eFJfKgWnnI3qORtm+tF2J+uWWwb3/xkuMVNbpVIAp0lc2mdtlJCsSrBtK7h1juqkjK7umagXBg5ngbYoR785zCiXPT/UEZnRLa/U9yEIwJ34MY90i7d3PjbNyU/h/T/U3hVNfUZ/NUO/qVDJglWBfizO6DhLC3VLAWOrerfV1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ij0HXa36fRV53HqAqVvBpzqG/8iBncasa1bA6HD57Ro=;
	b=dQfPIjQwxuyyvI/JYsZtTYHuMboorqamUv7LXroKuhnSmOh51XVcMpBMjpd2cK3vZ0GzFSAGb4K4MiBnzHqGdDYVY4fudnpOtJkjUiRrlo6ERGPQXaW3hrAA2LOTzkanAMn3i9ooV+ykbfeIEYOtxOd2Q99XhUgh+emngftRnMKY63ewVx6BZksYwjODk+9E4vSMMk3EJ2YQlZKR/oxSXwHmU+EEjkOkFPWnpzPSj4hmRZWcX4P/5f96BuX2ezQ45LTF6iVS8Af85laDOrzFuzo8pNmsHVSBSl1lEzR4hegmo3PvBH1mTBMP70qiymrkKxqwYLMIDnWgg+0vdthjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ij0HXa36fRV53HqAqVvBpzqG/8iBncasa1bA6HD57Ro=;
	b=YQVXHxvxPbsD13Piqa380Zaut0t+oFnQyiFdDvAgH4tSmu2FDp7VJ5npWCqK46Ct24aK1550IrueWgtghAc+gFsl7casC0Z4D4JIO/TSpZx10ENWs12Z9AWQMpJxfnKO5gaWHfM7He2NYf5tvaGg98tx/sIUp45tdgwf9/6zQpM=
Received: from BN6PR1201CA0014.namprd12.prod.outlook.com
	(2603:10b6:405:4c::24) by DM6PR12MB2620.namprd12.prod.outlook.com
	(2603:10b6:5:42::33) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20;
	Fri, 24 Jan 2020 15:16:46 +0000
Received: from DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe59::209) by BN6PR1201CA0014.outlook.office365.com
	(2603:10b6:405:4c::24) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via
	Frontend Transport; Fri, 24 Jan 2020 15:16:46 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	DM6NAM12FT013.mail.protection.outlook.com (10.13.178.66) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2686.12 via Frontend Transport; Fri, 24 Jan 2020 15:16:46 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 24 Jan 2020 08:16:42 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 24 Jan 2020 10:16:23 -0500
Message-ID: <1579878983-121851-2-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579878983-121851-1-git-send-email-chris.laplante@agilent.com>
References: <1579878983-121851-1-git-send-email-chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(29502001)(8936002)(36756003)(70206006)(8676002)(30864003)(15650500001)(336012)(966005)(26005)(2906002)(186003)(107886003)(478600001)(956004)(2616005)(44832011)(5660300002)(316002)(86362001)(36906005)(6666004)(356004)(4326008)(426003)(6916009)(246002)(7636002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2620;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bffc411c-5d23-439a-f563-08d7a0e06d61
X-MS-TrafficTypeDiagnostic: DM6PR12MB2620:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2620B5F6159EB3D2CE779FC28B0E0@DM6PR12MB2620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-Forefront-PRVS: 02929ECF07
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqDdfb4PF6T+kx1vErtocU9Et6j8M5iM20QqaGj5GwBCYGiXjNypLjP+wvjs+iUmyyg+qqeKTe9qyumCyl6agr6WN2aRUuaTGzuou1P/mLfJYJANA8dBX9haI1hTgLnI3ZZgGy3I1DreQpn6o3PGfLrEihkODtq+BVuDK9Rrwh5dCCfo9TykpGU+bLS1WbAIWyBkYfx6lhZ8DipEsX9sLYkX+S8gZ2zGhdFdRLEccTNdHKI9qfEJZSHoMUNAz2kr3iauG17yCE7nKFbUZ75lGN3BiUrIMEzJUyaY6bwM00UVMVw72jt/AjKLVL6vvtHdExOZDdtiaQJz2ide9AamTq5XSfwaix48fQq88eBMwaKCvl2DD6JojKrSk3JDgP3HgQxQd1OUTlSXAy/q2oT1L4AeeK/b5mIlDwzg1RUIi8X8ZNm1XumTTnSl31hry//MaA2Bh9sUuGuMSG1d8yH7yp35V0V4OTCWKxaiu8wqtRj6bi7XE13gkX3zJ2jvieGg8NVg6OMqqpt89GB3EKpHMmJtctAc1+Fej/5A69p49Tw=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 15:16:46.3220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bffc411c-5d23-439a-f563-08d7a0e06d61
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
Subject: [PATCH 1/1] ui/teamcity: add a TeamCity service message frontend
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 24 Jan 2020 15:16:48 -0000
Content-Type: text/plain

Exposes build status via TeamCity service messages, see
https://www.jetbrains.com/help/teamcity/build-script-interaction-with-teamcity.html.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/ui/teamcity.py | 398 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 398 insertions(+)
 create mode 100644 lib/bb/ui/teamcity.py

diff --git a/lib/bb/ui/teamcity.py b/lib/bb/ui/teamcity.py
new file mode 100644
index 0000000..1854292
--- /dev/null
+++ b/lib/bb/ui/teamcity.py
@@ -0,0 +1,398 @@
+#
+# TeamCity UI Implementation
+#
+# Implements a TeamCity frontend for the BitBake utility, via service messages.
+# See https://www.jetbrains.com/help/teamcity/build-script-interaction-with-teamcity.html
+#
+# Based on ncurses.py and knotty.py, variously by Michael Lauer and Richard Purdie
+#
+# Copyright (C) 2006 Michael 'Mickey' Lauer
+# Copyright (C) 2006-2012 Richard Purdie
+# Copyright (C) 2018-2020 Agilent Technologies, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Author: Chris Laplante <chris.laplante@agilent.com>
+
+from __future__ import division
+
+import datetime
+import logging
+import math
+import os
+import re
+import sys
+import xmlrpc.client
+from collections import deque
+
+import bb
+import bb.build
+import bb.command
+import bb.cooker
+import bb.event
+import bb.exceptions
+import bb.runqueue
+from bb.ui import uihelper
+
+logger = logging.getLogger("BitBake")
+
+
+class TeamCityUI:
+    def __init__(self):
+        self._block_stack = []
+        self._last_progress_state = None
+
+    @classmethod
+    def escape_service_value(cls, value):
+        """
+        Escape a value for inclusion in a service message. TeamCity uses the vertical pipe character for escaping.
+        See: https://confluence.jetbrains.com/display/TCD10/Build+Script+Interaction+with+TeamCity#BuildScriptInteractionwithTeamCity-Escapedvalues
+        """
+        return re.sub(r"(['|\[\]])", r"|\1", value).replace("\n", "|n").replace("\r", "|r")
+
+    @classmethod
+    def emit_service_message(cls, message_type, **kwargs):
+        print(cls.format_service_message(message_type, **kwargs), flush=True)
+
+    @classmethod
+    def format_service_message(cls, message_type, **kwargs):
+        payload = " ".join(["{0}='{1}'".format(k, cls.escape_service_value(v)) for k, v in kwargs.items()])
+        return "##teamcity[{0} {1}]".format(message_type, payload)
+
+    @classmethod
+    def emit_simple_service_message(cls, message_type, message):
+        print(cls.format_simple_service_message(message_type, message), flush=True)
+
+    @classmethod
+    def format_simple_service_message(cls, message_type, message):
+        return "##teamcity[{0} '{1}']".format(message_type, cls.escape_service_value(message))
+
+    @classmethod
+    def format_build_message(cls, text, status):
+        return cls.format_service_message("message", text=text, status=status)
+
+    def block_start(self, name):
+        self._block_stack.append(name)
+        self.emit_service_message("blockOpened", name=name)
+
+    def block_end(self):
+        if self._block_stack:
+            name = self._block_stack.pop()
+            self.emit_service_message("blockClosed", name=name)
+
+    def progress(self, message, percent, extra=None):
+        now = datetime.datetime.now()
+        percent = "{0: >3.0f}".format(percent)
+
+        report = False
+        if not self._last_progress_state \
+                or (self._last_progress_state[0] == message
+                    and self._last_progress_state[1] != percent
+                    and (now - self._last_progress_state[2]).microseconds >= 5000) \
+                or self._last_progress_state[0] != message:
+            report = True
+            self._last_progress_state = (message, percent, now)
+
+        if report or percent in [0, 100]:
+            self.emit_simple_service_message("progressMessage", "{0}: {1}%{2}".format(message, percent, extra or ""))
+
+
+class TeamcityLogFormatter(logging.Formatter):
+    def format(self, record):
+        details = ""
+        if hasattr(record, 'bb_exc_formatted'):
+            details = ''.join(record.bb_exc_formatted)
+        elif hasattr(record, 'bb_exc_info'):
+            etype, value, tb = record.bb_exc_info
+            formatted = bb.exceptions.format_exception(etype, value, tb, limit=5)
+            details = ''.join(formatted)
+
+        if record.levelno in [bb.msg.BBLogFormatter.ERROR, bb.msg.BBLogFormatter.CRITICAL]:
+            # ERROR gets a separate errorDetails field
+            msg = TeamCityUI.format_service_message("message", text=record.getMessage(), status="ERROR",
+                                                    errorDetails=details)
+        else:
+            payload = record.getMessage()
+            if details:
+                payload += "\n" + details
+            if record.levelno == bb.msg.BBLogFormatter.PLAIN:
+                msg = payload
+            elif record.levelno == bb.msg.BBLogFormatter.WARNING:
+                msg = TeamCityUI.format_service_message("message", text=payload, status="WARNING")
+            else:
+                msg = TeamCityUI.format_service_message("message", text=payload, status="NORMAL")
+
+        return msg
+
+
+_evt_list = ["bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.LogRecord",
+             "bb.build.TaskFailed", "bb.build.TaskBase", "bb.event.ParseStarted",
+             "bb.event.ParseProgress", "bb.event.ParseCompleted", "bb.event.CacheLoadStarted",
+             "bb.event.CacheLoadProgress", "bb.event.CacheLoadCompleted", "bb.command.CommandFailed",
+             "bb.command.CommandExit", "bb.command.CommandCompleted", "bb.cooker.CookerExit",
+             "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
+             "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
+             "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
+             "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.event.ProcessProgress", "bb.event.ProcessFinished"]
+
+
+def _log_settings_from_server(server):
+    # Get values of variables which control our output
+    includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
+        raise BaseException(error)
+    loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
+        raise BaseException(error)
+    return includelogs, loglines
+
+
+def main(server, eventHandler, params):
+    params.updateToServer(server, os.environ.copy())
+
+    includelogs, loglines = _log_settings_from_server(server)
+
+    ui = TeamCityUI()
+
+    helper = uihelper.BBUIHelper()
+
+    console = logging.StreamHandler(sys.stdout)
+    errconsole = logging.StreamHandler(sys.stderr)
+    format = TeamcityLogFormatter()
+    if params.options.quiet == 0:
+        forcelevel = None
+    elif params.options.quiet > 2:
+        forcelevel = bb.msg.BBLogFormatter.ERROR
+    else:
+        forcelevel = bb.msg.BBLogFormatter.WARNING
+    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, forcelevel)
+    bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
+    console.setFormatter(format)
+    errconsole.setFormatter(format)
+    if not bb.msg.has_console_handler(logger):
+        logger.addHandler(console)
+        logger.addHandler(errconsole)
+
+    if params.options.remote_server and params.options.kill_server:
+        server.terminateServer()
+        return
+
+    if params.observe_only:
+        logger.error("Observe-only mode not supported in this UI")
+        return 1
+
+    llevel, debug_domains = bb.msg.constructLogOptions()
+    server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
+
+    try:
+        params.updateFromServer(server)
+        cmdline = params.parseActions()
+        if not cmdline:
+            logger.error("No task given")
+            return 1
+        if 'msg' in cmdline and cmdline['msg']:
+            logger.error(cmdline['msg'])
+            return 1
+        cmdline = cmdline['action']
+        ret, error = server.runCommand(cmdline)
+        if error:
+            logger.error("{0}: {1}".format(cmdline, error))
+            return 1
+        elif not ret:
+            logger.error("Couldn't get default commandline: {0}".format(re))
+            return 1
+    except xmlrpc.client.Fault as x:
+        logger.error("XMLRPC Fault getting commandline: {0}".format(x))
+        return 1
+
+    active_process_total = None
+    is_tasks_running = False
+
+    while True:
+        try:
+            event = eventHandler.waitEvent(0.25)
+            if not event:
+                continue
+
+            helper.eventHandler(event)
+
+            if isinstance(event, bb.build.TaskBase):
+                logger.info(event._message)
+            if isinstance(event, logging.LogRecord):
+                # Don't report sstate failures as errors, since Yocto will just run the tasks for real
+                if event.msg == "No suitable staging package found" or (event.msg.startswith(
+                        "Fetcher failure: Unable to find file") and "downloadfilename" in event.msg and "sstate" in event.msg):
+                    event.levelno = bb.msg.BBLogFormatter.WARNING
+                if event.taskpid != 0:
+                    # For "normal" logging conditions, don't show note logs from tasks
+                    # but do show them if the user has changed the default log level to
+                    # include verbose/debug messages
+                    if event.levelno <= bb.msg.BBLogFormatter.NOTE and (event.levelno < llevel or (
+                            event.levelno == bb.msg.BBLogFormatter.NOTE and llevel != bb.msg.BBLogFormatter.VERBOSE)):
+                        continue
+
+                    # Prefix task messages with recipe/task
+                    if event.taskpid in helper.running_tasks and event.levelno != bb.msg.BBLogFormatter.PLAIN:
+                        taskinfo = helper.running_tasks[event.taskpid]
+                        event.msg = taskinfo['title'] + ': ' + event.msg
+                if hasattr(event, 'fn'):
+                    event.msg = event.fn + ': ' + event.msg
+                logger.handle(event)
+            if isinstance(event, bb.build.TaskFailedSilent):
+                logger.warning("Logfile for failed setscene task is %s" % event.logfile)
+                continue
+            if isinstance(event, bb.build.TaskFailed):
+                rt = "{0}-{1}:{2}".format(event.pn, event.pv.replace("AUTOINC", "0"), event.task)
+
+                logfile = event.logfile
+                if not logfile or not os.path.exists(logfile):
+                    TeamCityUI.emit_service_message("buildProblem", description="{0}\nUnknown failure (no log file available)".format(rt))
+                    if not event.task.endswith("_setscene"):
+                        server.runCommand(["stateForceShutdown"])
+                    continue
+
+                details = deque(maxlen=loglines)
+                error_lines = []
+                if includelogs and not event.errprinted:
+                    with open(logfile, "r") as f:
+                        while True:
+                            line = f.readline()
+                            if not line:
+                                break
+                            line = line.rstrip()
+                            details.append(' | %s' % line)
+                            # TODO: a less stupid check for errors
+                            if (event.task == "do_compile") and ("error:" in line):
+                                error_lines.append(line)
+
+                if error_lines:
+                    TeamCityUI.emit_service_message("compilationStarted", compiler=rt)
+                    for line in error_lines:
+                        TeamCityUI.emit_service_message("message", text=line, status="ERROR")
+                    TeamCityUI.emit_service_message("compilationFinished", compiler=rt)
+                else:
+                    TeamCityUI.emit_service_message("buildProblem", description=rt)
+
+                err = "Logfile of failure stored in: %s" % logfile
+                if details:
+                    ui.block_start("{0} task log".format(rt))
+                    # TeamCity seems to choke on service messages longer than about 63800 characters, so if error
+                    # details is longer than, say, 60000, batch it up into several messages.
+                    first_message = True
+                    while details:
+                        detail_len = 0
+                        batch = deque()
+                        while details and detail_len < 60000:
+                            # TODO: This code doesn't bother to handle lines that themselves are extremely long.
+                            line = details.popleft()
+                            batch.append(line)
+                            detail_len += len(line)
+
+                        if first_message:
+                            batch.appendleft("Log data follows:")
+                            first_message = False
+                            TeamCityUI.emit_service_message("message", text=err, status="ERROR",
+                                                            errorDetails="\n".join(batch))
+                        else:
+                            TeamCityUI.emit_service_message("message", text="[continued]", status="ERROR",
+                                                            errorDetails="\n".join(batch))
+                    ui.block_end()
+                else:
+                    TeamCityUI.emit_service_message("message", text=err, status="ERROR", errorDetails="")
+
+                if not event.task.endswith("_setscene"):
+                    server.runCommand(["stateForceShutdown"])
+
+            if isinstance(event, bb.event.ProcessStarted):
+                if event.processname in ["Initialising tasks", "Checking sstate mirror object availability"]:
+                    active_process_total = event.total
+                    ui.block_start(event.processname)
+            if isinstance(event, bb.event.ProcessFinished):
+                if event.processname in ["Initialising tasks", "Checking sstate mirror object availability"]:
+                    ui.progress(event.processname, 100)
+                    ui.block_end()
+            if isinstance(event, bb.event.ProcessProgress):
+                if event.processname in ["Initialising tasks",
+                                         "Checking sstate mirror object availability"] and active_process_total != 0:
+                    ui.progress(event.processname, event.progress * 100 / active_process_total)
+            if isinstance(event, bb.event.CacheLoadStarted):
+                ui.block_start("Loading cache")
+            if isinstance(event, bb.event.CacheLoadProgress):
+                if event.total != 0:
+                    ui.progress("Loading cache", math.floor(event.current * 100 / event.total))
+            if isinstance(event, bb.event.CacheLoadCompleted):
+                ui.progress("Loading cache", 100)
+                ui.block_end()
+            if isinstance(event, bb.event.ParseStarted):
+                ui.block_start("Parsing recipes and checking upstream revisions")
+            if isinstance(event, bb.event.ParseProgress):
+                if event.total != 0:
+                    ui.progress("Parsing recipes", math.floor(event.current * 100 / event.total))
+            if isinstance(event, bb.event.ParseCompleted):
+                ui.progress("Parsing recipes", 100)
+                ui.block_end()
+            if isinstance(event, bb.command.CommandCompleted):
+                return
+            if isinstance(event, bb.command.CommandFailed):
+                logger.error(str(event))
+                return 1
+            if isinstance(event, bb.event.MultipleProviders):
+                logger.warning(str(event))
+                continue
+            if isinstance(event, bb.event.NoProvider):
+                logger.error(str(event))
+                continue
+            if isinstance(event, bb.command.CommandExit):
+                return
+            if isinstance(event, bb.cooker.CookerExit):
+                return
+            if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+                if not is_tasks_running:
+                    is_tasks_running = True
+                    ui.block_start("Running tasks")
+                if event.stats.total != 0:
+                    ui.progress("Running setscene tasks", (
+                            event.stats.completed + event.stats.active + event.stats.failed + 1) * 100 / event.stats.total)
+            if isinstance(event, bb.runqueue.runQueueTaskStarted):
+                if not is_tasks_running:
+                    is_tasks_running = True
+                    ui.block_start("Running tasks")
+                if event.stats.total != 0:
+                    pseudo_total = event.stats.total - event.stats.skipped
+                    pseudo_complete = event.stats.completed + event.stats.active - event.stats.skipped + event.stats.failed + 1
+                    # TODO: sometimes this gives over 100%
+                    ui.progress("Running runqueue tasks", (pseudo_complete) * 100 / pseudo_total,
+                            " ({0}/{1})".format(pseudo_complete, pseudo_total))
+            if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
+                logger.warning(str(event))
+                continue
+            if isinstance(event, bb.runqueue.runQueueTaskFailed):
+                logger.error(str(event))
+                return 1
+            if isinstance(event, bb.event.LogExecTTY):
+                pass
+        except EnvironmentError as ioerror:
+            # ignore interrupted io
+            if ioerror.args[0] == 4:
+                pass
+        except Exception as ex:
+            logger.error(str(ex))
+
+        # except KeyboardInterrupt:
+        #     if shutdown == 2:
+        #         mw.appendText("Third Keyboard Interrupt, exit.\n")
+        #         exitflag = True
+        #     if shutdown == 1:
+        #         mw.appendText("Second Keyboard Interrupt, stopping...\n")
+        #         _, error = server.runCommand(["stateForceShutdown"])
+        #         if error:
+        #             print("Unable to cleanly stop: %s" % error)
+        #     if shutdown == 0:
+        #         mw.appendText("Keyboard Interrupt, closing down...\n")
+        #         _, error = server.runCommand(["stateShutdown"])
+        #         if error:
+        #             print("Unable to cleanly shutdown: %s" % error)
+        #     shutdown = shutdown + 1
+        #     pass
--
2.7.4


