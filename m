Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.3096.1632396537423632378
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Sep 2021 04:28:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fMwZIOgE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id i24so285425wrc.9
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Sep 2021 04:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WGbsdQzLjiLircADo5z1OPgZKzin02FlY/cmBSzBJtc=;
        b=fMwZIOgEGbXtWcw//axOjPzFo17zqfXcKV/z7FdWIQ1VHTTcQji37wLtCIM2SAz36l
         NVOuC4rK/5ca0VnHQ7xeGiezyZmL1vl2pRDO+w5BbF7SGdBMi9PjRWzgxEAXUmVO46r4
         R0WybxoHaumbk9FSKLrswNApnapW455rlLKrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGbsdQzLjiLircADo5z1OPgZKzin02FlY/cmBSzBJtc=;
        b=R2A+zjsMxNpGSrhKjtsLeJ6thoZHDlO+jTdcL3bxxUYpyeA66PympmYHUeyoatUpm3
         vaHW3FPwbemop0r4vqIzxFAJuKpVj5827IhbiOeAvsGL7OSccwyvejzuZmC33emMaUxz
         G114AaNmnTmuDJwJ5IRvz5uPSlVrvViEiHzdDb49TDpERia+migRVNVJZZHwkPFmpWhV
         bGDvjQTiG3BwWEc6LFZuuP/nt/3OCYUWibFHkTa9ZnBgM8Fs+1UJRIXGfQRelse2UOQc
         DuFYX2gCzg8kHpirjxgfyj+ovGj5tdsfEfQeGL9wrjs+AR8DItLTFeKVYkjhIpRJaobI
         /1CA==
X-Gm-Message-State: AOAM530OCzMtNdJOhr/msaV/vweQ4XrbWjsW/Lwq1ZQMnf+0mvSqKMJH
	IVcIlLRUancZztQ8eCKlkzN9F+BH6B4cXruX
X-Google-Smtp-Source: ABdhPJx9VfHHd8frXbwW6wB7PVMXXjnGBE28fnQZfJbzGqpVhogHyZxCdVY8cGna/yivJahiP9+t7g==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr4470567wrn.400.1632396535837;
        Thu, 23 Sep 2021 04:28:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3a36:9e9a:ccb5:f067])
        by smtp.gmail.com with ESMTPSA id 5sm5177382wmb.37.2021.09.23.04.28.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 04:28:55 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] build: Fix log flushing race
Date: Thu, 23 Sep 2021 12:28:53 +0100
Message-Id: <20210923112853.1706985-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210923112853.1706985-1-richard.purdie@linuxfoundation.org>
References: <20210923112853.1706985-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race between sending the TaskFailed event which could trigger
the UI to look at the logs and flushing and closing the log files.

Reverse the order of the finally clause and the exception handling
to ensure we've handled the logfiles before sending the task events.

This should fix a race seen in bblogging.BitBakeLogging.test_python_exit_logging

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 76 ++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 99954b0c26..7e4ab9f64c 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -686,51 +686,51 @@ def _exec_task(fn, task, d, quieterr):
     try:
         try:
             event.fire(TaskStarted(task, fn, logfn, flags, localdata), localdata)
-        except (bb.BBHandledException, SystemExit):
-            return 1
 
-        try:
             for func in (prefuncs or '').split():
                 exec_func(func, localdata)
             exec_func(task, localdata)
             for func in (postfuncs or '').split():
                 exec_func(func, localdata)
-        except bb.BBHandledException:
-            event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
-            return 1
-        except (Exception, SystemExit) as exc:
-            if quieterr:
-                event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
-            else:
-                errprinted = errchk.triggered
-                # If the output is already on stdout, we've printed the information in the
-                # logs once already so don't duplicate
-                if verboseStdoutLogging:
-                    errprinted = True
-                logger.error(repr(exc))
-                event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
-            return 1
-    finally:
-        sys.stdout.flush()
-        sys.stderr.flush()
-
-        bblogger.removeHandler(handler)
-
-        # Restore the backup fds
-        os.dup2(osi[0], osi[1])
-        os.dup2(oso[0], oso[1])
-        os.dup2(ose[0], ose[1])
-
-        # Close the backup fds
-        os.close(osi[0])
-        os.close(oso[0])
-        os.close(ose[0])
+        finally:
+            # Need to flush and close the logs before sending events where the
+            # UI may try to look at the logs.
+            sys.stdout.flush()
+            sys.stderr.flush()
+
+            bblogger.removeHandler(handler)
+
+            # Restore the backup fds
+            os.dup2(osi[0], osi[1])
+            os.dup2(oso[0], oso[1])
+            os.dup2(ose[0], ose[1])
+
+            # Close the backup fds
+            os.close(osi[0])
+            os.close(oso[0])
+            os.close(ose[0])
+
+            logfile.close()
+            if os.path.exists(logfn) and os.path.getsize(logfn) == 0:
+                logger.debug2("Zero size logfn %s, removing", logfn)
+                bb.utils.remove(logfn)
+                bb.utils.remove(loglink)
+    except bb.BBHandledException:
+        event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
+        return 1
+    except (Exception, SystemExit) as exc:
+        if quieterr:
+            event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
+        else:
+            errprinted = errchk.triggered
+            # If the output is already on stdout, we've printed the information in the
+            # logs once already so don't duplicate
+            if verboseStdoutLogging:
+                errprinted = True
+            logger.error(repr(exc))
+            event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
+        return 1
 
-        logfile.close()
-        if os.path.exists(logfn) and os.path.getsize(logfn) == 0:
-            logger.debug2("Zero size logfn %s, removing", logfn)
-            bb.utils.remove(logfn)
-            bb.utils.remove(loglink)
     event.fire(TaskSucceeded(task, fn, logfn, localdata), localdata)
 
     if not localdata.getVarFlag(task, 'nostamp', False) and not localdata.getVarFlag(task, 'selfstamp', False):
-- 
2.32.0

