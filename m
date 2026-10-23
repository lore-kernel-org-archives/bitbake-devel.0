Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.762.1792792684132564711
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Oct 2026 14:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=V18JaeMw;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=QgCTfDPp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLvLTI3117159
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 21:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=64kxcn51Mtn
	CR63WoOBk/ZgcHW0ElUIh5Fx6cYF/7vc=; b=V18JaeMw4CvZDj8RR+fhlPMennx
	5RYYuIO030Gw1LCCwAW+ML/JywtiRPCUZBeaC48a9V2/06ikrApK2V6jwpCJUiaj
	rzHF3x/MXRtMKjapwTxTMYzgWe91o1CJkxH8twQFCZhoKKdK3hNZuN9doCtHRPit
	M5EIIvJQjQJdEQFRJW9FmdSdAcXtXr4ZbGR6lmklm2CduFxCZHmfxDHh19m3BmaB
	Lwoqp/HkeNQmBfUqZCbuf046O2lK9Q7bAdfVDFDgjz7t3CU61+qJHq/fnJ6baglZ
	/ueyl9KAQ2gKEgYedKAV7UhjrPjJhhYBg0GAVYEZK4oyvG6S4XNxZw/ej+A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrt8nay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 21:58:03 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc10da5ad4so328499137.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792792682; x=1793397482; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=64kxcn51MtnCR63WoOBk/ZgcHW0ElUIh5Fx6cYF/7vc=;
        b=QgCTfDPp71am3RNe22lWq5Thfk2WDVLEN6Ec2vqrRh7hh5SpSlkkpowbk30U1aAMvs
         D58vSlb39hKWHltGG5ZvcJ7e3Z85xwOIoEa1YnnV5ykVz+HQ3qKy7riwwBoH3kQfnR+T
         ox3q0tq44RoiobIihozshwATvxT5w0aXy0lRA2GiBARPzMuo2oN6fsFd5P8D75PWfYQ+
         iZo4haIpzT+L5Z2nqpDme8GxP9kecaIl7vbf3tFBvp28Ix5yZJkZsd6uJPjey7hU89jU
         1lsqMQc7z9w2JHquBEZAeWKTJHY8or45+wnHsE3hHkRYpgilLgdxGTXXpP/xzMRrU0Xk
         9AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792682; x=1793397482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=64kxcn51MtnCR63WoOBk/ZgcHW0ElUIh5Fx6cYF/7vc=;
        b=GQSPinTXgYWLX/GRZfXqjqcYsydOnAwenfbz7DBSusr0hmu2x8UnFfVsLblZTLNkMt
         rEdYMVg/nSMyFll8Z/DFIWiPGgonibewzXcpiF1Krs7Z2/5C032tmzMrFQwwUDKmaKkd
         t7aMPD8FT0Nw5XgW6cidN6dJR94nFyxfQBftQ5vBeMcSkZEXCuBl5gHuVFVdJwu7lkzL
         +UNVtAcdcJWkeYEZSyyUgJv5xjJSvmo+j2mct4+FqDzgrHs09IglFpAP/FLu1waCygie
         8Nig6Sh6gHnzYpLQVQxyvZLTqedu05vOFCe4NL9hIlFtxPa7xDqjMcdlknKJ6/y/nRRA
         BhIQ==
X-Gm-Message-State: AFq9FYJ7uc0baXGTakfmw3xjkyWQX+XY07BVh21taFmtSWi/FUSnhRuI
	8bdXPOD1FEQgn2Zp0QAuk3v3KBU7PcsIWWQOv0lMctkQ7b1Tpo6AXQuH4UW3X26fHLvfbnKfsaB
	HP+jc3xCuWpjCCMYP4fqjQGtHSSFqWZaoqGbQzw/f7jZ/RhqXG/T4roR0ymOBsemLSi5gxCRHFy
	V0RSADxUvVqo9i
X-Gm-Gg: AYBFou2Blij6/ClYD89EUu1fb6tnR9n4mZ3lGwCUhK2qcJM+/ld+8EBcMazGAW1NFNf
	isD+aQoeqXQIf5kxgx9T1/liK06gbJMT/neyVYjNskIR5TWo77ZHYppAvJP43zisQKMqxGUYEfZ
	8ciL31yPEZ4GvvZMw9D/NXWMzVbWGpj1aM506NJq44PJUm0RiKbWhys4U0ixkXRe27shWLSVbeM
	vw2tnN6w29lh2ITYOcie2yLKS6FOmaLxOeyagUXX+vSlXwUFhZgH+u+/i5dAzTEHD2WbYKBCd6a
	HJFjF8p89csJQKtx5CWwEVDtzzaCZRxvbisG3juan/2PvXtEB3VaTINNI5/3tmOFf4jnOcAbnui
	3mOLbUHJ1tw==
X-Received: by 2002:a05:6102:f8b:b0:7cc:2cd0:e73c with SMTP id ada2fe7eead31-7ce5cd751cfmr170379137.25.1792792682437;
        Fri, 23 Oct 2026 14:58:02 -0700 (PDT)
X-Received: by 2002:a05:6102:f8b:b0:7cc:2cd0:e73c with SMTP id ada2fe7eead31-7ce5cd751cfmr170371137.25.1792792681782;
        Fri, 23 Oct 2026 14:58:01 -0700 (PDT)
Received: from evatuf ([187.65.213.234])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234add5dsm201999e0c.16.2026.10.23.14.58.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:58:01 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] runqueue: Avoid building task set unions in next_buildable_task
Date: Fri, 23 Oct 2026 18:57:53 -0300
Message-ID: <20261023215753.1454091-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022225148.2195453-1-ricardo.salveti@oss.qualcomm.com>
References: <20261022225148.2195453-1-ricardo.salveti@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4NiBTYWx0ZWRfXwa8nr4CgDeCl
 E8GPUBa4z8lxdO1W/6bHuoHjUUzHAAAnrYEH5hCG5X0ZldXnonek5g4cBt69c1ZPNR8aFTN8rae
 KXZRkgCgrBiI1a07oS2ZABE+h0oKeEg=
X-Proofpoint-ORIG-GUID: J3q39Hr2hc4mJGWK6CMuI9cV77ZsOMrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4NiBTYWx0ZWRfX9ZeQgh+YqBYK
 R53NBu9FSffya1M0VfKsAJcitwJBjM0ybEaLZnmYg/F4rX7+unTX8r3LCFE1h51pzJMtexy5VBl
 0Dqs8fH7qWNQ73TX73HSzrbRF8NtTiSxxn8IBIHyOw/qJc+h3MjF834PP7JDtdcKcxCVBa/okZp
 gon+d6cNaxMqiqzDtxZ0Df7vr/6NZyrqBelbzY+l/EPBgAa//7yccrzlIpMwnW+nvONRDuHTwZ7
 t/Ohoir5MfEbNgJU9/5AuvJrRRTqlXfIhIFpATvjjpdTZyevvV8cfF/7Bd++Skdy2vxkAf7eQWh
 AYVeAk0Q/zxZT7pkqZ0W7XC6b/SzishdbEIqwSTdYb+Uhp51VNIwus1c+6oXXov77EtGnAUh31K
 m/dKo0aNSXOnPLqUpc7S5CoiiOWr3a0vG2IPtFHfQ+iGYCW0FIQ7jWFwZGTvy0bY6IOl34NuWEy
 8MgBUXFCe0fb4pXN3pA==
X-Authority-Analysis: v=2.4 cv=E7lYNqdl c=1 sm=1 tr=0 ts=6adbd86b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=H6YuGxh2q6KyqgzzRUCmUw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1nrlm_J5CM2oISA4ObAA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: J3q39Hr2hc4mJGWK6CMuI9cV77ZsOMrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230086
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 21:58:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20372
Content-Type: text/plain; charset="utf-8"

next_buildable_task() runs at least once for every task in the build,
and again on every worker wakeup while a slot is free. Each call builds
tasks_covered | tasks_notcovered to filter the buildable tasks, and when
a task is buildable it also computes runq_running - runq_complete. These
four sets grow to the size of the whole runqueue, although only a few
tasks are buildable at any time.

Filter the buildable tasks by membership instead. The difference is
only needed for number_threads limits, so fill the existing
skip_maxthread cache once when the scheduler is created, and only count
the running tasks when some task has a limit.

A no-op 'bitbake core-image-minimal' with OE-core goes from 7.64s to
6.61s, and a no-op image build with 18 layers from 46.22s to 41.44s
(median of 5 runs each). The runqueue task order of dry runs and of a
single-threaded build from sstate is unchanged. Add a selftest checking
that a number_threads limit is applied, which wasn't covered before.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
Changes in v2:
- Drop the runq_running_not_complete set, so nothing has to be kept in
  sync with runq_running and runq_complete. Fill the existing
  number_threads flag cache once when the scheduler is created instead,
  and only compute the difference when some task has a limit.
- Add a selftest checking that a number_threads limit is applied.

 lib/bb/runqueue.py       | 31 ++++++++++++++++++-------------
 lib/bb/tests/runqueue.py | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef95eb46b..ce88ab99e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -171,6 +171,10 @@ class RunQueueScheduler(object):
             self.stamps[tid] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
             if tid in self.rq.runq_buildable:
                 self.buildable.add(tid)
+            if taskname not in self.skip_maxthread:
+                self.skip_maxthread[taskname] = self.rq.cfgData.getVarFlag(taskname, "number_threads")
+        # Only count the running tasks per name if some task has a limit
+        self.has_maxthread = any(self.skip_maxthread.values())
 
         self.rev_prio_map = None
         self.prev_cpu_pressure = 0.0
@@ -259,9 +263,11 @@ class RunQueueScheduler(object):
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
 
@@ -273,16 +279,15 @@ class RunQueueScheduler(object):
 
         # Filter out tasks that have a max number of threads that have been exceeded
         skip_buildable = {}
-        for running in self.rq.runq_running.difference(self.rq.runq_complete):
-            rtaskname = taskname_from_tid(running)
-            if rtaskname not in self.skip_maxthread:
-                self.skip_maxthread[rtaskname] = self.rq.cfgData.getVarFlag(rtaskname, "number_threads")
-            if not self.skip_maxthread[rtaskname]:
-                continue
-            if rtaskname in skip_buildable:
-                skip_buildable[rtaskname] += 1
-            else:
-                skip_buildable[rtaskname] = 1
+        if self.has_maxthread:
+            for running in self.rq.runq_running.difference(self.rq.runq_complete):
+                rtaskname = taskname_from_tid(running)
+                if not self.skip_maxthread[rtaskname]:
+                    continue
+                if rtaskname in skip_buildable:
+                    skip_buildable[rtaskname] += 1
+                else:
+                    skip_buildable[rtaskname] = 1
 
         if len(buildable) == 1:
             tid = buildable.pop()
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 42c02cd15..d8c49f8c0 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -72,6 +72,21 @@ class RunQueueTests(unittest.TestCase):
 
             self.shutdown(tempdir)
 
+    def test_number_threads(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            postconf = os.path.join(tempdir, "number_threads.conf")
+            with open(postconf, "w") as f:
+                f.write('do_fetch[number_threads] = "1"\n')
+            cmd = ["bitbake", "-R", postconf, "a1", "b1"]
+            # a1:do_fetch is scheduled first, so the quick b1:do_fetch can
+            # only finish after the slow a1:do_fetch if the limit is applied
+            tasks = self.run_bitbakecmd(cmd, tempdir, slowtasks="a1:fetch")
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+            self.assertLess(tasks.index('a1:fetch'), tasks.index('b1:fetch'))
+
+            self.shutdown(tempdir)
+
     def test_single_setscenevalid(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1"]
-- 
2.55.0

