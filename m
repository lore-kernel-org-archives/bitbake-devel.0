Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499DDD66B9D
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 00:13:26 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web10.61021.1732666401347262731
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Nov 2024 16:13:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eURumWU8;
 spf=pass (domain: gmail.com, ip: 209.85.160.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29685066b8dso3543423fac.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Nov 2024 16:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732666400; x=1733271200; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpaU332j3+7RjeiA5P/TpDhzenbcOhh2cS4iOAA7boA=;
        b=eURumWU8XD4BG5NpiYim3lL0aR3ujfzhR4BzMYD+16awU114zbL2aIpNmT4/llwui3
         Gt0gTMhHhsVrIi8xmSOD7dsamDorzkaBmSfUVdZE71x1sS9thPM0xHXZ8sLoGRo5YqCU
         yKqhZy2rj6OkFNPdLz684l7w6LZIyTLWjeUwcSgp1sX9ASO5w6HcBjb+gMT12BJpOVtQ
         0KZCs5awRqnLSiTskv4954346v4EjCx8Pg+MAOOcn2qbqOj4eO0mMU/mPg4gs6glG8bc
         MslmY3QnfX0U+n/t98841vTpgn+Wdqqfdepahh0NlNmt0TlHBNpox9opfBHmx5XTBdfb
         /AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732666400; x=1733271200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpaU332j3+7RjeiA5P/TpDhzenbcOhh2cS4iOAA7boA=;
        b=SmIOJ5TX1HvO6whr6NxFYjvwxI7ZUsldy2dKBXoL5YjBmvTStbSaDjGm5p+hfc1/bW
         qkCIFTt+Fc2vUYejXyU/1IA3NIEg1uCjWwcgJibmfnFZwxj957wDpG5YYC8YmhU2LDK2
         bQQMDyFV5L57S+nR8Gkn5iBtgfRRnQLt91/wFqukwWbQSrAVgYihUn2Ndinx5HQCFTJN
         7emtJmJQk7qIZtRp9nsIOLOy4N2iAE7qmOOcuUpGKDAKjifb3z/mKeWQ3tJJT1nAaZSG
         Clwz9qGx/xp0omcpsROFMYthcotdlcsviffXC/As5gliqiSx5Qq+/EVr574dtcxSKBhn
         GXmg==
X-Gm-Message-State: AOJu0Yy05mmZxfnKpCjXGzhNodP4yElHITz4py0CZbOQCDWvz5eaEoHs
	m6vUvSzo284wl7gighEJVg5loFxs18RxpVdJWj5I7AJm5N8zrLhZ64zWHg==
X-Gm-Gg: ASbGncsHgPktL5PLlzcCU/7zbNCIQKMosd8W2yP5PmM4OevSiSwtCynbkjgo8WWMmSq
	ggjlDWI0SddZfOik4cgIVjb625vhdFid+94DA7qHeaRTbW/5Y93jjKykwbk0du7PLxHT4em8vMn
	UzhcrShd/qGAQ95Y4H3kPWODCQZgX4SGUdgZWsf9Q/HaNBpPxVwW+elCXlO/yKFOTXeEVZ2GqIW
	h8BUd6WAixWGvow1yD8XSKPcFhbFpwhuhVxJ/g2XolnvGUS
X-Google-Smtp-Source: AGHT+IGbIyeZdR8v3NS3S2Hh9qMLb6ovq6vdNI3/PvKEeP0P0lWZ4wnC1WONOfTHtlsMBsNJzwN3zA==
X-Received: by 2002:a05:6871:580f:b0:297:4653:dc5 with SMTP id 586e51a60fabf-29dc4736d49mr648192fac.34.1732666399879;
        Tue, 26 Nov 2024 16:13:19 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::dc1a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d5e17afsm4339261fac.15.2024.11.26.16.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:13:18 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] Remove custom exception backtrace formatting
Date: Tue, 26 Nov 2024 17:05:28 -0700
Message-ID: <20241127000529.2893687-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Nov 2024 00:13:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16841

Removes the code in bitbake to show custom backtrace formatting for
exceptions. In particular, the bitbake exception code prints function
arguments, which while helpful is a security problem when passwords and
other secrets can be passed as function arguments.

As it turns out, the handling of the custom serialized exception stack
frames was pretty much made obsolete by d7db75020ed ("event/msg: Pass
formatted exceptions"), which changed the events to pass a preformatted
stacktrack list of strings, but the passing of the serialized data was
never removed.

Change all the code to use the python traceback API to format exceptions
instead of the custom code; conveniently traceback.format_exception()
also returns a list of stack trace strings, so it can be used as a drop
in replacement for bb.exception.format_exception()

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py      | 21 ++++----
 bitbake/lib/bb/event.py       |  9 +---
 bitbake/lib/bb/exceptions.py  | 94 -----------------------------------
 bitbake/lib/bb/msg.py         |  4 --
 bitbake/lib/bb/ui/teamcity.py |  5 --
 5 files changed, 12 insertions(+), 121 deletions(-)
 delete mode 100644 bitbake/lib/bb/exceptions.py

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a8e0a81dc90..056b86a3345 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -17,7 +17,7 @@ import threading
 from io import StringIO, UnsupportedOperation
 from contextlib import closing
 from collections import defaultdict, namedtuple
-import bb, bb.exceptions, bb.command
+import bb, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue, build
 import queue
 import signal
@@ -2096,7 +2096,6 @@ class Parser(multiprocessing.Process):
         except Exception as exc:
             tb = sys.exc_info()[2]
             exc.recipe = filename
-            exc.traceback = list(bb.exceptions.extract_traceback(tb, context=3))
             return True, None, exc
         # Need to turn BaseExceptions into Exceptions here so we gracefully shutdown
         # and for example a worker thread doesn't just exit on its own in response to
@@ -2297,8 +2296,12 @@ class CookerParser(object):
             return False
         except ParsingFailure as exc:
             self.error += 1
-            logger.error('Unable to parse %s: %s' %
-                     (exc.recipe, bb.exceptions.to_string(exc.realexception)))
+
+            exc_desc = str(exc)
+            if isinstance(exc, SystemExit) and not isinstance(exc.code, str):
+                exc_desc = 'Exited with "%d"' % exc.code
+
+            logger.error('Unable to parse %s: %s' % (exc.recipe, exc_desc))
             self.shutdown(clean=False)
             return False
         except bb.parse.ParseError as exc:
@@ -2308,19 +2311,17 @@ class CookerParser(object):
             return False
         except bb.data_smart.ExpansionError as exc:
             self.error += 1
-            bbdir = os.path.dirname(__file__) + os.sep
-            etype, value, _ = sys.exc_info()
-            tb = list(itertools.dropwhile(lambda e: e.filename.startswith(bbdir), exc.traceback))
+            _, value, _ = sys.exc_info()
             logger.error('ExpansionError during parsing %s', value.recipe,
-                         exc_info=(etype, value, tb))
+                         exc_info=sys.exc_info())
             self.shutdown(clean=False)
             return False
         except Exception as exc:
             self.error += 1
-            etype, value, tb = sys.exc_info()
+            _, value, _ = sys.exc_info()
             if hasattr(value, "recipe"):
                 logger.error('Unable to parse %s' % value.recipe,
-                            exc_info=(etype, value, exc.traceback))
+                            exc_info=sys.exc_info())
             else:
                 # Most likely, an exception occurred during raising an exception
                 import traceback
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 4761c868800..952c85c0bd5 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -19,7 +19,6 @@ import sys
 import threading
 import traceback
 
-import bb.exceptions
 import bb.utils
 
 # This is the pid for which we should generate the event. This is set when
@@ -759,13 +758,7 @@ class LogHandler(logging.Handler):
 
     def emit(self, record):
         if record.exc_info:
-            etype, value, tb = record.exc_info
-            if hasattr(tb, 'tb_next'):
-                tb = list(bb.exceptions.extract_traceback(tb, context=3))
-            # Need to turn the value into something the logging system can pickle
-            record.bb_exc_info = (etype, value, tb)
-            record.bb_exc_formatted = bb.exceptions.format_exception(etype, value, tb, limit=5)
-            value = str(value)
+            record.bb_exc_formatted = traceback.format_exception(*record.exc_info)
             record.exc_info = None
         fire(record, None)
 
diff --git a/bitbake/lib/bb/exceptions.py b/bitbake/lib/bb/exceptions.py
deleted file mode 100644
index 60643bd6421..00000000000
--- a/bitbake/lib/bb/exceptions.py
+++ /dev/null
@@ -1,94 +0,0 @@
-#
-# Copyright BitBake Contributors
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-import inspect
-import traceback
-import bb.namedtuple_with_abc
-from collections import namedtuple
-
-
-class TracebackEntry(namedtuple.abc):
-    """Pickleable representation of a traceback entry"""
-    _fields = 'filename lineno function args code_context index'
-    _header = '  File "{0.filename}", line {0.lineno}, in {0.function}{0.args}'
-
-    def format(self, formatter=None):
-        if not self.code_context:
-            return self._header.format(self) + '\n'
-
-        formatted = [self._header.format(self) + ':\n']
-
-        for lineindex, line in enumerate(self.code_context):
-            if formatter:
-                line = formatter(line)
-
-            if lineindex == self.index:
-                formatted.append('    >%s' % line)
-            else:
-                formatted.append('     %s' % line)
-        return formatted
-
-    def __str__(self):
-        return ''.join(self.format())
-
-def _get_frame_args(frame):
-    """Get the formatted arguments and class (if available) for a frame"""
-    arginfo = inspect.getargvalues(frame)
-
-    if not arginfo.args:
-            return '', None
-
-    firstarg = arginfo.args[0]
-    if firstarg == 'self':
-        self = arginfo.locals['self']
-        cls = self.__class__.__name__
-
-        arginfo.args.pop(0)
-        try:
-            del arginfo.locals['self']
-        except TypeError:
-            # FIXME - python 3.13 FrameLocalsProxy can't be modified
-            pass
-    else:
-        cls = None
-
-    formatted = inspect.formatargvalues(*arginfo)
-    return formatted, cls
-
-def extract_traceback(tb, context=1):
-    frames = inspect.getinnerframes(tb, context)
-    for frame, filename, lineno, function, code_context, index in frames:
-        formatted_args, cls = _get_frame_args(frame)
-        if cls:
-            function = '%s.%s' % (cls, function)
-        yield TracebackEntry(filename, lineno, function, formatted_args,
-                             code_context, index)
-
-def format_extracted(extracted, formatter=None, limit=None):
-    if limit:
-        extracted = extracted[-limit:]
-
-    formatted = []
-    for tracebackinfo in extracted:
-        formatted.extend(tracebackinfo.format(formatter))
-    return formatted
-
-
-def format_exception(etype, value, tb, context=1, limit=None, formatter=None):
-    formatted = ['Traceback (most recent call last):\n']
-
-    if hasattr(tb, 'tb_next'):
-        tb = extract_traceback(tb, context)
-
-    formatted.extend(format_extracted(tb, formatter, limit))
-    formatted.extend(traceback.format_exception_only(etype, value))
-    return formatted
-
-def to_string(exc):
-    if isinstance(exc, SystemExit):
-        if not isinstance(exc.code, str):
-            return 'Exited with "%d"' % exc.code
-    return str(exc)
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 3e18596faae..4f616ff42e7 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -89,10 +89,6 @@ class BBLogFormatter(logging.Formatter):
             msg = logging.Formatter.format(self, record)
         if hasattr(record, 'bb_exc_formatted'):
             msg += '\n' + ''.join(record.bb_exc_formatted)
-        elif hasattr(record, 'bb_exc_info'):
-            etype, value, tb = record.bb_exc_info
-            formatted = bb.exceptions.format_exception(etype, value, tb, limit=5)
-            msg += '\n' + ''.join(formatted)
         return msg
 
     def colorize(self, record):
diff --git a/bitbake/lib/bb/ui/teamcity.py b/bitbake/lib/bb/ui/teamcity.py
index fca46c2874d..7eeaab8d634 100644
--- a/bitbake/lib/bb/ui/teamcity.py
+++ b/bitbake/lib/bb/ui/teamcity.py
@@ -30,7 +30,6 @@ import bb.build
 import bb.command
 import bb.cooker
 import bb.event
-import bb.exceptions
 import bb.runqueue
 from bb.ui import uihelper
 
@@ -102,10 +101,6 @@ class TeamcityLogFormatter(logging.Formatter):
         details = ""
         if hasattr(record, 'bb_exc_formatted'):
             details = ''.join(record.bb_exc_formatted)
-        elif hasattr(record, 'bb_exc_info'):
-            etype, value, tb = record.bb_exc_info
-            formatted = bb.exceptions.format_exception(etype, value, tb, limit=5)
-            details = ''.join(formatted)
 
         if record.levelno in [bb.msg.BBLogFormatter.ERROR, bb.msg.BBLogFormatter.CRITICAL]:
             # ERROR gets a separate errorDetails field
-- 
2.47.1


