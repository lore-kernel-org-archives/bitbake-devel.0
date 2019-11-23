Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id DD9386C44A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 13:56:34 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id t2so12057412wrr.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kTHHqZeM/8A/4tOlPUQkl+Vp1ruYjCtv4cGBDFue6cY=;
	b=LV7/d3MdnszQ5KFG1tjHD7ZoWCHPmq+Of9Ndg/h6XrGHD6uw30CQcVQpQCILUUVKuP
	qSuqgve+0OfsZfTaIa7LcLwaPqAwm+gV+GxSE9x7fbLXSN40WeheIsO0FwsEGC6Qk7my
	dyIQ+iZTX4qZjGVTj46lj3P73qFo5vjyR/8P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kTHHqZeM/8A/4tOlPUQkl+Vp1ruYjCtv4cGBDFue6cY=;
	b=uARde1HWe6OwEtZJv8z3AKy+iun7EEjqXR/Jxcx2OiPjKaGb8ffyOyTC2Vs+zWMkB7
	xwq1n0QoqbEvJpi/Ws1WlMmafmjI0IR5qeHYqjuuU12V+2oXyJCTtZIS7nkl6IRvKVun
	eKC9ogJGbiKKl6V9U4A+4TaWFNcD4kRIWZv+z8oNFc02W0LMXv5ALBw9nzOUgVja37+j
	rHpZ4kbOQe+IQTRrGUS+rrlve1GqjWDJ9xzReuiyvzBQe/eAD9sF116SK5zPjUUYcuri
	4C+zAMvQBz7CZg0swYTsiO9Y1/YEUzB70DqmrrAAaXNuIH0ryCdmX9lsbCsfVAMnfaPH
	MlBg==
X-Gm-Message-State: APjAAAW8iPPa0dgIQ54yLyiWj/OcrzAfKVhKC6nvaQVfM7Ej3IK63W0a
	Uw8hzrqsI6XC5WH+qmLCXxwnHmvLUhU=
X-Google-Smtp-Source: APXvYqxxM+4odp4PX7exs/ieW0oob+odpJZTOPLPwbfFXV7SD6/nlfOH5inuim/QhMilvfyYlKa1jw==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr15934442wrs.226.1574517395150; 
	Sat, 23 Nov 2019 05:56:35 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	d20sm2316735wra.4.2019.11.23.05.56.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 23 Nov 2019 05:56:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 13:56:33 +0000
Message-Id: <20191123135633.31288-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: Ensure failed harddependencies in scenequeue are accounted for in migrations
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
X-List-Received-Date: Sat, 23 Nov 2019 13:56:35 -0000
Content-Transfer-Encoding: 8bit

Setscene hard dependencies were not being correctly handled during task migration.
For example, do_package of recipe X might become valid due to hashequiv yet we're
still rebuilding pseudo-native, a harddep of do_package. This would mean
it would try to execute that setscene task despite pseudo not being present.

Fix this by ignoring tasks with failed harddependencies. This does mean
stlightly more rebuilds than is optimal but it avoids build crashes. Ultimately
the new runqueue model can likely better handle these cases than the older codebase
could but that is for another more invasive patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 26492e7087..485d9341f5 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2343,7 +2343,12 @@ class RunQueueExecute:
                 self.sq_buildable.remove(tid)
             if tid in self.sq_running:
                 self.sq_running.remove(tid)
-            if self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+            harddepfail = False
+            for t in self.sqdata.sq_harddeps:
+                if tid in self.sqdata.sq_harddeps[t] and t in self.scenequeue_notcovered:
+                    harddepfail = True
+                    break
+            if not harddepfail and self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
                 if tid not in self.sq_buildable:
                     self.sq_buildable.add(tid)
             if len(self.sqdata.sq_revdeps[tid]) == 0:
@@ -2374,6 +2379,8 @@ class RunQueueExecute:
             update_scenequeue_data([tid], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
             if tid in self.sqdata.valid and not origvalid:
                 logger.info("Setscene task %s became valid" % tid)
+            if harddepfail:
+                self.sq_task_failoutright(tid)
 
         if changed:
             self.holdoff_need_update = True
-- 
2.20.1


