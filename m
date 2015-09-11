Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 91DFF74242
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 20:56:27 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so85956971pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=xvbhdtQJpFWzp4qywMJDha1vkUezoXhPn7NI5C9A5zc=;
	b=nb9ETcvyt4TzPQyRHfrAO8sAqcFcErhPijlBCcuk7bbt7Avc9wkRbF4VKIbXQVxrHK
	9jH5VEjp5LgAThA/NeM4TuwVdppMUY3f/+MSvnVvkpjOSGzi2abBr5+LIILThacNkdJV
	FFRHNfGY2Sv9RFKttMjHCEQyxwFz2AbrgpGapRSodkeO8bnHsDBr+ZpdfZzyb/qiqAkw
	49gWDpyd83yBcjv7UZbTTFCOv4FtFT9k9JYt9w9H8iZAPsz7UwFqeR6PxDrD3YgfMFE/
	Lp6602VPe6hHb4FGDgARUEE1D5ha0jEqkrINo9WGeEMA+0zPA4gmw+sJtSNdD6BQhWQw
	52WA==
X-Received: by 10.66.164.230 with SMTP id yt6mr1565915pab.149.1442004987974;
	Fri, 11 Sep 2015 13:56:27 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ql5sm1997168pac.46.2015.09.11.13.56.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 11 Sep 2015 13:56:27 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Sep 2015 13:57:29 -0700
Message-Id: <33c4808befde264fb3fd9f31008e122ce5807fce.1442004911.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <838c8c98c5edfd801c02aa06a5e3393d35649e0d.1442004911.git.avery.brian@gmail.com>
References: <838c8c98c5edfd801c02aa06a5e3393d35649e0d.1442004911.git.avery.brian@gmail.com>
In-Reply-To: <cover.1442004911.git.avery.brian@gmail.com>
References: <cover.1442004911.git.avery.brian@gmail.com>
Subject: [PATCH 2/3] toaster: Avoid unnecessary local to local copy of cooker log
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
X-List-Received-Date: Fri, 11 Sep 2015 20:56:27 -0000

From: Elliot Smith <elliot.smith@intel.com>

The cooker log is copied from its original (bitbake) location
to an artifact directory chosen by the user (chosen when
checksettings.py runs as part of the managed mode;
it's one of the annoying questions you're asked at startup).
The copy happens as part of the runbuilds script run, which
is started in a loop from the toaster startup script
in managed mode.

When a user requests the log for a build via toaster, they
are getting the log which has been copied to the artifact
directory, not the original bitbake log.

This works for the managed case, where the runbuilds command is
running in a loop and copying log files for completed builds to
the artifact directory. However, in analysis mode, there are two
problems:

1. checksettings isn't run, so the artifacts directory isn't
set. toaster is then unable to figure out where the log files
should have been copied to.

2. The log files aren't copied to the artifacts directory
anyway, as runbuilds isn't running in analysis mode.

To fix this, just point the user to the local bitbake log file
in its original location. This avoids the copy step, and means
we can remove a whole question from the toaster startup sequence,
as we no longer need an artifact directory.

The only downside to this is that it's not appropriate for
remote bitbake servers. We will need to revisit this and
possibly reinstate the copy step once we have to reconcile
local and remote builds and make their logs available in
the same way.

[YOCTO #8209]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 .../management/commands/checksettings.py           | 22 --------------------
 .../bldcontrol/management/commands/runbuilds.py    | 24 ++--------------------
 lib/toaster/toastergui/views.py                    | 13 ++++++------
 3 files changed, 8 insertions(+), 51 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 3ccc7c6..b2c573c 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -64,27 +64,6 @@ class Command(NoArgsCommand):
             return ""
         return DN(self._find_first_path_for_file(DN(self.guesspath), "bblayers.conf", 4))
 
-
-    def _verify_artifact_storage_dir(self):
-        # verify that we have a settings for downloading artifacts
-        while ToasterSetting.objects.filter(name="ARTIFACTS_STORAGE_DIR").count() == 0:
-            guessedpath = os.getcwd() + "/toaster_build_artifacts/"
-            print("\nToaster needs to know in which directory it can download build log files and other artifacts.\nToaster suggests \"%s\"." % guessedpath)
-            artifacts_storage_dir = raw_input("Press Enter to select \"%s\" or type the full path to a different directory: " % guessedpath)
-            if len(artifacts_storage_dir) == 0:
-                artifacts_storage_dir = guessedpath
-            if len(artifacts_storage_dir) > 0 and artifacts_storage_dir.startswith("/"):
-                try:
-                    os.makedirs(artifacts_storage_dir)
-                except OSError as ose:
-                    if "File exists" in str(ose):
-                        pass
-                    else:
-                        raise ose
-                ToasterSetting.objects.create(name="ARTIFACTS_STORAGE_DIR", value=artifacts_storage_dir)
-        return 0
-
-
     def _verify_build_environment(self):
         # refuse to start if we have no build environments
         while BuildEnvironment.objects.count() == 0:
@@ -239,7 +218,6 @@ class Command(NoArgsCommand):
 
     def handle_noargs(self, **options):
         retval = 0
-        retval += self._verify_artifact_storage_dir()
         retval += self._verify_build_environment()
         retval += self._verify_default_settings()
         retval += self._verify_builds_in_progress()
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index c3e9b74..718e144 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -77,31 +77,11 @@ class Command(NoArgsCommand):
             bec.be.save()
 
     def archive(self):
-        ''' archives data from the builds '''
-        artifact_storage_dir = ToasterSetting.objects.get(name="ARTIFACTS_STORAGE_DIR").value
         for br in BuildRequest.objects.filter(state = BuildRequest.REQ_ARCHIVE):
-            # save cooker log
             if br.build == None:
                 br.state = BuildRequest.REQ_FAILED
-                br.save()
-                continue
-            build_artifact_storage_dir = os.path.join(artifact_storage_dir, "%d" % br.build.pk)
-            try:
-                os.makedirs(build_artifact_storage_dir)
-            except OSError as ose:
-                if "File exists" in str(ose):
-                    pass
-                else:
-                    raise ose
-
-            file_name = os.path.join(build_artifact_storage_dir, "cooker_log.txt")
-            try:
-                with open(file_name, "w") as f:
-                    f.write(br.environment.get_artifact(br.build.cooker_log_path).read())
-            except IOError:
-                os.unlink(file_name)
-
-            br.state = BuildRequest.REQ_COMPLETED
+            else:
+                br.state = BuildRequest.REQ_COMPLETED
             br.save()
 
     def cleanup(self):
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4e8f69e..784272f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2710,7 +2710,6 @@ if True:
 
     def build_artifact(request, build_id, artifact_type, artifact_id):
         if artifact_type in ["cookerlog"]:
-            # these artifacts are saved after building, so they are on the server itself
             def _mimetype_for_artifact(path):
                 try:
                     import magic
@@ -2741,16 +2740,16 @@ if True:
                 except ImportError:
                     return "binary/octet-stream"
             try:
-                # match code with runbuilds.Command.archive()
-                build_artifact_storage_dir = os.path.join(ToasterSetting.objects.get(name="ARTIFACTS_STORAGE_DIR").value, "%d" % int(build_id))
-                file_name = os.path.join(build_artifact_storage_dir, "cooker_log.txt")
-
+                build = Build.objects.get(pk = build_id)
+                file_name = build.cooker_log_path
                 fsock = open(file_name, "r")
-                content_type=_mimetype_for_artifact(file_name)
+                content_type = _mimetype_for_artifact(file_name)
 
                 response = HttpResponse(fsock, content_type = content_type)
 
-                response['Content-Disposition'] = 'attachment; filename=' + os.path.basename(file_name)
+                disposition = 'attachment; filename=cooker.log'
+                response['Content-Disposition'] = disposition
+
                 return response
             except IOError:
                 context = {
-- 
1.9.1


