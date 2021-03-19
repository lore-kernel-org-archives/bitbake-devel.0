Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.330.1616175015838712591
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Mar 2021 10:30:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K+ayUQDC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo5649043wmq.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Mar 2021 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0I/Wwe0zZkOcHlGiNhwJD1e1O3kzt559Mp/aianXu3Y=;
        b=K+ayUQDC1yexS7u9aA8MpNjYIwsedPfx9JVKqAM5ZWa2yYrWog2aVd1JFKJEdd87hK
         xB71OnJt1t4/C0i5Ur50BAW+on+6gSxzTInhcP2YSTDqlpd7oLuBjyW7mXLRrpB1ZRKb
         C+AD1IfvrIyyC6+xrj0eCSg6odgbjSwonYbCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0I/Wwe0zZkOcHlGiNhwJD1e1O3kzt559Mp/aianXu3Y=;
        b=OvjQCl+yI4anFDOrVj1BHeyJQB1a/2Zo+phW1hkeqBQoQCueDpaVwlUzQIrk3AA5Rs
         xBEtv42tfHmxfRPziF8PP2TFtWRJclJvNSvlNPF8+AdHEIBZYpcCESSymiv+COp66EB7
         OfsH+EgSRtWPKLP0fwMea0d3qvf67cEA/ES/V2/CuqzIuQ8hV05Kgve9SYb2BsHQb2fb
         CY0R8YQQZeZ+gn/eHe+a1Vba1k3rUTdmgLy3EqE5dBP8sLpSrNnaQmDupydd/o2Jsb7/
         siSL8d8mVOsjm2tW0K+6rxnCr6l7FRvRpjObAq+vnjtT/nsuuw8yY1yuF62aNSN4FGVT
         18rA==
X-Gm-Message-State: AOAM532e3+4l51a6zK9SKxXadLQWWpvbBDbfoqAAMEAfzyku+Mo6GJGW
	fHhq3QcRpEBtG1bV84VR8Ch1oNhh/CmZhA==
X-Google-Smtp-Source: ABdhPJyV8Pj7vjktqCpnGoqUBucdGrCDTjfbk6gY7/jVRdX7i+OJJVsl6qybksfoAXqVzCOs8foy6g==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr4808260wmh.169.1616175014223;
        Fri, 19 Mar 2021 10:30:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5808:8e52:d330:3893])
        by smtp.gmail.com with ESMTPSA id x25sm8537852wmj.14.2021.03.19.10.30.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:30:13 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue/event: Add an event for notifying of stale setscene tasks
Date: Fri, 19 Mar 2021 17:30:12 +0000
Message-Id: <20210319173012.229109-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319173012.229109-1-richard.purdie@linuxfoundation.org>
References: <20210319173012.229109-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new functionality in build.py to identify stale setscene tasks
and send an event to the metadata listing them. The metadata then
has the option of performing cleanup operations if it thinks that
appropriate.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py    | 11 +++++++++++
 lib/bb/runqueue.py | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 31e7c2a4d2..0454c75332 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -670,6 +670,17 @@ class ReachableStamps(Event):
         Event.__init__(self)
         self.stamps = stamps
 
+class StaleSetSceneTasks(Event):
+    """
+    An event listing setscene tasks which are 'stale' and will
+    be rerun. The metadata may use to clean up stale data.
+    tasks is a mapping of tasks and matching stale stamps.
+    """
+
+    def __init__(self, tasks):
+        Event.__init__(self)
+        self.tasks = tasks
+
 class FilesMatchingFound(Event):
     """
     Event when a list of files matching the supplied pattern has
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3008b7ad4f..80d7f6ca6b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2781,6 +2781,20 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True)
 
+    # Compute a list of 'stale' sstate tasks where the current hash does not match the one
+    # in any stamp files. Pass the list out to metadata as an event.
+    found = {}
+    for tid in rqdata.runq_setscene_tids:
+        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+        stamps = bb.build.find_stale_stamps(taskname, rqdata.dataCaches[mc], taskfn)
+        if stamps:
+            if mc not in found:
+                found[mc] = {}
+            found[mc][tid] = stamps
+    for mc in found:
+        event = bb.event.StaleSetSceneTasks(found[mc])
+        bb.event.fire(event, cooker.databuilder.mcdata[mc])
+
 def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True):
 
     tocheck = set()
-- 
2.30.2

