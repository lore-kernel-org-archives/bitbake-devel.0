Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 9615970A8B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 10:27:27 +0000 (UTC)
Received: by mail-wg0-f52.google.com with SMTP id b13so10095058wgh.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Nov 2014 02:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QgNN13ojOi63AyZu0HhKF8qDRKxHhjxrZIZezRYHRwI=;
	b=Up6/dUrvF3rVBzXbpzmIUUUJLqw8jfJ/+f6vhpgzsjQ5rGLgFKH3EP2O9p00FOthNR
	qvGb5Ha0SfntblIc6iI0JxXyFO4q5HHW+8TqnZPXvwVQ//h5lQ2yjIAkhWBtpK1/KCRd
	hr0eMOAn2n4JEpC/Qaz0DrcbA9hp3deKbNZ8WIo+fm0MavO6xV5CT9Hfajv4KGK2qYE0
	EdYGLbxFVU6bAyJo9hPTVEDSyAIVhePUkXWgI6X7Q92qWEYwshQKMhWPfeL65OEKRn/h
	3nUt1CvHrjMy6nQ+zeyfyf5btbZKzrCXr1cII9jJInHNUYcVP0XIEpA8HzbmtSdDr7jY
	zVvw==
X-Gm-Message-State: ALoCoQn7OGNl1iImruI1ersFtVoE5tsj5QQaIbRX4/2ohwXagYTsMIu7n/FYe6NwJ2EdijgUfpCJ
X-Received: by 10.180.210.167 with SMTP id mv7mr15371032wic.15.1415010448202; 
	Mon, 03 Nov 2014 02:27:28 -0800 (PST)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	k10sm21671329wjb.28.2014.11.03.02.27.26 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Nov 2014 02:27:26 -0800 (PST)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 23B4956088C; Fri, 31 Oct 2014 19:17:03 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Oct 2014 19:17:01 +0000
Message-Id: <82772b844dfa509e533adc339264151c47f013d6.1414779051.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1414779051.git.alexandru.damian@intel.com>
References: <cover.1414779051.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/2] toasterui: improvements in data reading
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
X-List-Received-Date: Mon, 03 Nov 2014 10:27:31 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add improvements in data reading, following
issues discovered in testing.

- elapsed_time is now read from buildstats
- we add safeguards to not fail logging if the build was triggered
with a toaster_brbe configuration, but it's running in
1.6 mode
- added log markups for build finish to let other programs
known when the work is done.

[YOCTO #6833]
[YOCTO #6685]
[YOCTO #6887]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 22 +++++++++++++---------
 lib/bb/ui/toasterui.py       |  6 ++++--
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index fcef53b..b5ae9e97 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -67,13 +67,15 @@ class ORMWrapper(object):
 
         if brbe is not None:
             from bldcontrol.models import BuildEnvironment, BuildRequest
-            br, be = brbe.split(":")
-            buildrequest = BuildRequest.objects.get(pk = br)
-            buildrequest.build = build
-            buildrequest.save()
-            build.project_id = buildrequest.project_id
-            build.save()
-
+            try:
+                br, be = brbe.split(":")
+                buildrequest = BuildRequest.objects.get(pk = br)
+                buildrequest.build = build
+                buildrequest.save()
+                build.project_id = buildrequest.project_id
+                build.save()
+            except BuildRequest.DoesNotExist:
+                pass
         return build
 
     def create_target_objects(self, target_info):
@@ -146,6 +148,8 @@ class ORMWrapper(object):
         if 'start_time' in task_information.keys() and 'end_time' in task_information.keys():
             duration = task_information['end_time'] - task_information['start_time']
             task_object.elapsed_time = duration
+            del task_information['start_time']
+            del task_information['end_time']
 
         task_object.save()
         return task_object
@@ -320,8 +324,7 @@ class ORMWrapper(object):
                 searchname = pkgpnmap[p]['OPKGN']
 
             packagedict[p]['object'], created = Package.objects.get_or_create( build = build_obj, name = searchname )
-            if created:
-                # package was not build in the current build, but
+            if True:    # save the data anyway we can, not just if it was not created here; bug [YOCTO #6887]
                 # fill in everything we can from the runtime-reverse package data
                 try:
                     packagedict[p]['object'].recipe = recipes[pkgpnmap[p]['PN']]
@@ -717,6 +720,7 @@ class BuildInfoHelper(object):
             task_information['task_name'] = taskname
             task_information['cpu_usage'] = taskstats['cpu_usage']
             task_information['disk_io'] = taskstats['disk_io']
+            task_information['elapsed_time'] = taskstats['elapsed_time']
             task_obj = self.orm_wrapper.get_update_task_object(task_information, True)  # must exist
 
     def update_and_store_task(self, event):
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 0c53843..007c6b6 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -231,14 +231,16 @@ def main(server, eventHandler, params ):
 
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 buildinfohelper.close(errorcode)
+                # mark the log output; controllers may kill the toasterUI after seeing this log
+                logger.info("ToasterUI build done")
 
                 # we start a new build info
                 if buildinfohelper.brbe is not None:
 
-                    print "we are under BuildEnvironment management - after the build, we exit"
+                    logger.debug(1, "ToasterUI under BuildEnvironment management - exiting after the build")
                     server.terminateServer()
                 else:
-                    print "prepared for new build"
+                    logger.debug(1, "ToasterUI prepared for new build")
                     errors = 0
                     warnings = 0
                     taskfailures = []
-- 
1.9.1


