Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E706D6D243
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 22:11:33 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.83388.1732745486752428127
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Nov 2024 14:11:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ciugJFvr;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-297078d8eaeso282952fac.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Nov 2024 14:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732745485; x=1733350285; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ny5v3vsvXVVBxH/alvPAkbNocvcWVpKFlxO1fPzfr0=;
        b=ciugJFvrpQPjCLL9aE5S/nck5QDMzFMft3/2TL5Lm650iGx1OxIcudN3SGNCXe4ZxL
         vFZ7QKSBCHf6minpUpJdMwyHcUge9mwRpXGDhlC4HzxzD3Dw5MvN8iqut67ysh9vdWB9
         4ByyVs5V5Dm9ZEsh1Mrn9DKMZQVPH6P1T5nhZhy20WZh5OB6/lKPXgCS1cYNuQfMupRY
         jzmdFpSldac0Jwt61GMvXY8+EbwX1whOZFOGBiLMUSkYgbWSvz7rBZE8wk+yesqTZvX0
         zvThTx5G+Vtunh1T0rOMxYmg+tk+sGWNiyYlh6hONge1q/MU0ZGA6/vpm8x0WeJzl8Ni
         XEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745485; x=1733350285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ny5v3vsvXVVBxH/alvPAkbNocvcWVpKFlxO1fPzfr0=;
        b=YttFLYBgief7VwBIR5P+fEbbJwuqaHPhA/A/KDQpmZoILpIQhv6Z4bWWb52O2aYSXu
         lgRfN+lVbsh1R90J+RjILSp4pxRE0PZPCFUFgCKjfcaxDNAGQD/5nvZWVi/chFUckBOO
         uQBIpGqNZ4EOhCl/rZayz7CXa3btkoa52GtwmTImpgpBjbgprTANJ2LVVIad85bRT8on
         WRbC8ceB+TwKfR6q8WVsfY0bVvQf9TAa1Y0dzO/MimzG14dvTJL8JvVWy+qOpY5Y1+Yq
         7OXcgLNqxLoRFKO+rskxpu9Wz8cEI590WYKIRFg8k3yIE+Clc0jT/BHeszJrpYOC1y9Q
         QzMA==
X-Gm-Message-State: AOJu0YyYVZJo+C3vX5MDrWc+8LJZS/i5pI5Y2ngF+ci/NGMvqoXu/+aU
	6Dn6KCIzlvQqJxuLmOjIKOjegkOkhEIdYqXLNATiS76c/d3jo7zTeKacgw==
X-Gm-Gg: ASbGncuyA95eR/AamhR5TCfRvqfVawWGErJToDojYgNKZXMib8h6v8fAUTQMOjWmId6
	GvnR8BMpc0QOev8hINzlQwLpSF470ueGyLAY9bPHZB9SFLS+VM8rMZSBm+qolcigpBPgpaqICgm
	V8gCaxuueZXcstH00Q+DFSKMk1PuI6jE2wc7bUUQ4b6ukW0Qi0ApNtCXXyXWmqHtPGZ7dtZqixI
	M4yJyGNQimYxlX4EypdvDFYNi+b4/7e8ytKfju/OWiVzBeT
X-Google-Smtp-Source: AGHT+IGGyLApYyEr6oLIgbMT3YGMB2E/Q6bHL90fD0wwMgxSjfWFiukaFSuomDnjMvyaBZy22vmXWQ==
X-Received: by 2002:a05:6870:2190:b0:296:dd1d:ce58 with SMTP id 586e51a60fabf-29dc3f9e171mr3685766fac.1.1732745485305;
        Wed, 27 Nov 2024 14:11:25 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::dc1a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de92d8246sm53525fac.25.2024.11.27.14.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:11:24 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] Remove custom exception backtrace formatting
Date: Wed, 27 Nov 2024 15:10:06 -0700
Message-ID: <20241127221119.3151291-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241127000529.2893687-1-JPEWhacker@gmail.com>
References: <20241127000529.2893687-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Nov 2024 22:11:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16843

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
V2: Restored backtrace filtering in ExpansionError exceptions to exclude
any frames in bitbake code. Note that this requires Python 3.7 or later,
since tb_next is not a writable property in prior versions


 bitbake/lib/bb/cooker.py      | 32 +++++++++---
 bitbake/lib/bb/event.py       |  9 +---
 bitbake/lib/bb/exceptions.py  | 94 -----------------------------------
 bitbake/lib/bb/msg.py         |  4 --
 bitbake/lib/bb/ui/teamcity.py |  5 --
 5 files changed, 25 insertions(+), 119 deletions(-)
 delete mode 100644 bitbake/lib/bb/exceptions.py

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a8e0a81dc90..ca37cfea951 100644
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
@@ -2307,20 +2310,33 @@ class CookerParser(object):
             self.shutdown(clean=False, eventmsg=str(exc))
             return False
         except bb.data_smart.ExpansionError as exc:
+            def skip_frames(f, fn_prefix):
+                while f and f.tb_frame.f_code.co_filename.startswith(fn_prefix):
+                    f = f.tb_next
+                return f
+
             self.error += 1
             bbdir = os.path.dirname(__file__) + os.sep
-            etype, value, _ = sys.exc_info()
-            tb = list(itertools.dropwhile(lambda e: e.filename.startswith(bbdir), exc.traceback))
+            etype, value, tb = sys.exc_info()
+
+            # Remove any frames where the code comes from bitbake. This
+            # prevents deep (and pretty useless) backtraces for expansion error
+            tb = skip_frames(tb, bbdir)
+            cur = tb
+            while cur:
+                cur.tb_next = skip_frames(cur.tb_next, bbdir)
+                cur = cur.tb_next
+
             logger.error('ExpansionError during parsing %s', value.recipe,
                          exc_info=(etype, value, tb))
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


