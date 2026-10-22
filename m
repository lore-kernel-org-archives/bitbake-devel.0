Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2422.1792709521958009181
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Oct 2026 15:52:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=pURNb1WF;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=iTfVGwC3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MMFIX7610688
	for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 22:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vzkRfSiAP9xlMMVFyoYXjMjnCn1Xs7/292w
	7UTH//gg=; b=pURNb1WFlJaOOum1lk6kU+tC/gEoIItydPdVqj+pd4PiCSJePJx
	8YT6fNvwLV0XoQkMW+48yO1hfoKj+Nna0HRqLtrmzOrm7dpCq3kLVVNnl3RtsHLN
	wH3Vb+1MtwNGB/4eeDXTnaAW0EbHtgP8764MiHKgMRRNN9PUTIVEMug5AlVwqoWW
	nUrvYy7HgdyuozvWuCjy4PIK2NU2Lk7gplLUFzUO4DPDQfwsG9l0WEGqks5/SXhN
	Xg1QeL8gDdoGsFmbes/9mSvmzTk5R/9wMyQw7XAMuCcEZLjbNcEM5tRPTKCFA8z8
	E1GVNBwDQo9r1eLtqGC6Nf9TyxuOofP+KRQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahs9re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 22:52:00 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c96bf59c31so89076e0c.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792709519; x=1793314319; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzkRfSiAP9xlMMVFyoYXjMjnCn1Xs7/292w7UTH//gg=;
        b=iTfVGwC34agG0oXrBkvrPOdfEdqWhTlAEH8tpSXuqLa7hDnC3fWRur5EG20Dudr5W0
         CvqqJ5IvNzDqvsfhS62KUnnJ+7dn1MYcKZjM86hHuHzygz+CZl2aLnqU6nH9hmQlY49X
         tF7pw/SIL4ETXxojmx3hGDQyKoXdlmSQqm+JegOynG1bSpJcKR/Y0QmQ1WLR/rdJ58Xq
         4sVzfXo4C3XlTaFwshV8uOsBWNwvIUnUmNRaQEmLCd2K8JfOwTMjn/9a9A+DBKbKlWi1
         6jyV3g1nzxhdPsUY3s0Kr4RYVCcvWHX9Q+MWxIWHan4mdfv9huHhsg+meAiaRCzYivXJ
         mpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709519; x=1793314319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vzkRfSiAP9xlMMVFyoYXjMjnCn1Xs7/292w7UTH//gg=;
        b=2BDqKnwMBnqzvIu1MjUT+ooyRFvDmgrNcTxl8q1Q1hiQNhrkxnPfsiDHYrEcr50K7o
         rWB/wF07k3+LcuH4R+fkjbAZz6n7IpzVUjH+xWbe35PEy14thTtD+4BY62FXdCDARd49
         9zvwjUKK/w9Cn99OOzNpscf66tCWckFj5WFsJxWKObZFp0ti+VmrTeuW25ubGEcF0EuZ
         P2mFrxt6fwcDyNmVop3NXd4zkuERBCq57dBIVFGrsxfyGBTzH8nwASDgwis5QY9Kbyyw
         SwWvNK+4vHSth/ylQ7rZq5jitmNM3XqTqsT2cyb7Xr2bWsvZlxXLCMtbS+tNd/gAhsw5
         9H6Q==
X-Gm-Message-State: AFq9FYI4ZH9fMr2NbO4ej454b185pO3wXRjfEl7ZZZvEZEZFXKHQE4g0
	VS/3i/LQ1D2LDDNSzxv18EvT5Z1lZhzl1fd6Zjz5EJtRLMOk6o2CDHIAvmMtn3K9hz4Nw7yzP5U
	TuTCYo0XC/E/E9PRyXxB8cycSt7U/gcyedyT9dTqGWQwmeMuRXuVIRRc36nSFroHAj8AQ6my6xa
	AHoWpk/GuzHjkI
X-Gm-Gg: AYBFou2MRhWVhh2613NAQxR6NdGADEIttbaiTrP+tAbX842x7xS8kU86mYb4ls+RPBC
	10BbNnLby1RSXYzeBn42j/jk8B2e8eKbLO7KnMdO/WXTUZZMNgNugsecqR57uAIwZECy3f0iXVc
	JjYNb+1qHYjSF8g/aoFKWEPEeqee1CMSG0MtvhlLDA+crIszTt5D8XYNa/7kdob2+BUOostMQ/p
	of5zUYCebD5Qls6CGDb+VyoMDdDsJhIPPsamfABt1urqhKYtVAFUlKqn2slV1+PKonW7SaDk3if
	XPXzyX5rOHB5H8UlYOAUuUl74OUWjAYKzylB6i1724K9X0uqicgqr0kgJ+ydPBmWnK+uXeXj1X2
	meCNeIxr/yw==
X-Received: by 2002:a05:6122:280f:b0:5c9:a60b:e5c0 with SMTP id 71dfb90a1353d-5ec14abe866mr127711e0c.16.1792709519353;
        Thu, 22 Oct 2026 15:51:59 -0700 (PDT)
X-Received: by 2002:a05:6122:280f:b0:5c9:a60b:e5c0 with SMTP id 71dfb90a1353d-5ec14abe866mr127698e0c.16.1792709518550;
        Thu, 22 Oct 2026 15:51:58 -0700 (PDT)
Received: from evatuf ([187.65.213.234])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13f0fb63sm573510e0c.12.2026.10.22.15.51.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:51:58 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Avoid building task set unions in next_buildable_task
Date: Thu, 22 Oct 2026 19:51:48 -0300
Message-ID: <20261022225148.2195453-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX1ZeoFPjnL1Dr
 T4hQ7/siZC1DjgpGFUlF2s1U5lV8uUAkxrnRGNpv2Jfl2E1wrhTWL1eNMS4Q2ly0rmP2fFbp3uT
 171Babs09+5CgJk16PFvKoA6/uEOP1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX/Fedxh6jv2WV
 brwCmVmbwwXxAJNrIJ92kxPOd1oQJOk0glryBq3kkYTHXhQRenFalo1NHOgmqAzy5T3rNX2Mvb9
 /PfJ0el+u1q+wjq6TNIGcnf0/8cFJJ7IKvhZfwVjZiZKAXhIM4aH2NQurrlObLvQKlrPs+3W6/3
 F1IhT/i3hL782gQaaz/7TC6zNx702lebZfmaer9YHixINgsKlU2b3slL73ytJyNApUEHkWov1pf
 exSEnfKQvR1Zl2laueIbH0w5eFLfNFj7W8KP7a05pPSbQaSzzstQrM0Tz4CThLIfZGOeTCWUH44
 rOpBUJpI3gaJK6pbRWPZzKGrnKMIx5eYDfh3iWnqRf90cHQF32U4aBBLUfmXGglL8E0XkTpdi2+
 k/Ff9/AE5xH+e8hutaEpM+XmF6nWOu3reopq+/P1iUrGguOiBDbo+N7BvNc8nzA9yFTi7o+dK3n
 Z41OF9/+FJ6Jm7RIpsw==
X-Proofpoint-GUID: wN-8dBzRcCoRVWcznth0chwSlTCKfx6J
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6ada9390 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=H6YuGxh2q6KyqgzzRUCmUw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=qhwRhB_QkDBEI8da5xkA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: wN-8dBzRcCoRVWcznth0chwSlTCKfx6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 22 Oct 2026 22:52:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20368
Content-Type: text/plain; charset="utf-8"

next_buildable_task() runs at least once for every task in the build,
and again on every worker wakeup while a slot is free. Each call copies
the buildable set, removes holdoff_tasks from it and intersects it with
tasks_covered | tasks_notcovered, and when a task is buildable it also
computes runq_running - runq_complete. Those sets grow to the size of
the whole runqueue, so every call costs time proportional to the build,
although only a small fraction of the tasks are buildable at any time.

Filter the buildable tasks by membership instead, and keep
runq_running - runq_complete as a set which is updated when tasks start
and complete. Tasks are never removed from runq_running or
runq_complete, so the new set always equals the difference and, as
before, includes failed tasks. Also use it for the thread count in the
pressure and load average messages. Every task has its own priority, so
the chosen task does not depend on set iteration order.

A no-op 'bitbake core-image-minimal' with OE-core goes from 7.66s to
6.64s, and a no-op build of an image with 18 layers from 46.54s to
41.59s (median of 5 runs each). Task signatures and the runqueue task
order of dry runs and of a single-threaded build from sstate are
unchanged.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 lib/bb/runqueue.py | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef95eb46b..522288d63 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -237,7 +237,7 @@ class RunQueueScheduler(object):
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             pressure_values = (round(cpu_pressure,1), self.rq.max_cpu_pressure, round(io_pressure,1), self.rq.max_io_pressure, round(memory_pressure,1), self.rq.max_memory_pressure)
             if self.pressure_state is not None and pressure_state != self.pressure_state:
-                psi_logger.verbose("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
+                psi_logger.verbose("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running_not_complete), self.rq.number_tasks)))
                 bb.event.fire(PSIEvent(pressure_state, pressure_values), self.rq.cfgData)
             self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
@@ -248,7 +248,7 @@ class RunQueueScheduler(object):
             if loadfactor > self.rq.max_loadfactor:
                 limit = True
             if self.loadfactor_limit is not None and limit != self.loadfactor_limit:
-                bb.note("Load average limiting set to %s as load average: %s - using %s/%s bitbake threads" % (limit, loadfactor, len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks))
+                bb.note("Load average limiting set to %s as load average: %s - using %s/%s bitbake threads" % (limit, loadfactor, len(self.rq.runq_running_not_complete), self.rq.number_tasks))
             self.loadfactor_limit = limit
             return limit
         return False
@@ -259,9 +259,11 @@ class RunQueueScheduler(object):
         """
         # Once tasks are running we don't need to worry about them again
         self.buildable.difference_update(self.rq.runq_running)
-        buildable = set(self.buildable)
-        buildable.difference_update(self.rq.holdoff_tasks)
-        buildable.intersection_update(self.rq.tasks_covered | self.rq.tasks_notcovered)
+        holdoff = self.rq.holdoff_tasks
+        covered = self.rq.tasks_covered
+        notcovered = self.rq.tasks_notcovered
+        buildable = {t for t in self.buildable
+                     if t not in holdoff and (t in covered or t in notcovered)}
         if not buildable:
             return None
 
@@ -273,7 +275,7 @@ class RunQueueScheduler(object):
 
         # Filter out tasks that have a max number of threads that have been exceeded
         skip_buildable = {}
-        for running in self.rq.runq_running.difference(self.rq.runq_complete):
+        for running in self.rq.runq_running_not_complete:
             rtaskname = taskname_from_tid(running)
             if rtaskname not in self.skip_maxthread:
                 self.skip_maxthread[rtaskname] = self.rq.cfgData.getVarFlag(rtaskname, "number_threads")
@@ -1883,6 +1885,8 @@ class RunQueueExecute:
         self.runq_buildable = set()
         self.runq_running = set()
         self.runq_complete = set()
+        # runq_running - runq_complete, kept up to date for the scheduler
+        self.runq_running_not_complete = set()
         self.runq_tasksrun = set()
 
         self.build_stamps = {}
@@ -2082,6 +2086,10 @@ class RunQueueExecute:
         self.runq_buildable.add(task)
         self.sched.newbuildable(task)
 
+    def runq_running_add(self, task):
+        self.runq_running.add(task)
+        self.runq_running_not_complete.add(task)
+
     def task_completeoutright(self, task):
         """
         Mark a task as completed
@@ -2089,6 +2097,7 @@ class RunQueueExecute:
         completed dependencies as buildable
         """
         self.runq_complete.add(task)
+        self.runq_running_not_complete.discard(task)
         for revdep in self.rqdata.runtaskentries[task].revdeps:
             if revdep in self.runq_running:
                 continue
@@ -2152,7 +2161,7 @@ class RunQueueExecute:
             self.rq.state = RunQueueState.CLEAN_UP
 
     def task_skip(self, task, reason):
-        self.runq_running.add(task)
+        self.runq_running_add(task)
         self.setbuildable(task)
         bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq, reason), self.cfgData)
         self.task_completeoutright(task)
@@ -2381,7 +2390,7 @@ class RunQueueExecute:
                 startevent = runQueueTaskStarted(task, self.stats, self.rq,
                                                  noexec=True)
                 bb.event.fire(startevent, self.cfgData)
-                self.runq_running.add(task)
+                self.runq_running_add(task)
                 self.stats.taskActive()
                 if not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                     bb.build.make_stamp_mcfn(taskname, taskfn)
@@ -2426,7 +2435,7 @@ class RunQueueExecute:
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
-            self.runq_running.add(task)
+            self.runq_running_add(task)
             self.stats.taskActive()
             if self.can_start_task():
                 return True
-- 
2.55.0

