Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 44ABD74242
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 20:56:28 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so84411594pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=da8mLZNlr+MYpYEShlTtNuRF73+pDck4l5GB0jdFSTE=;
	b=IHdDBDWrXETyBmsRZLx5ePUkcV20aSMCRtHoShD3E3awRS0TLiBY7RZR7phQFMKyrl
	7tJO66p5f0tvzQr3bmFSAouwCCb8T7iOaQaOdLrU+MyS+P/O6zGjHnamRDmZqruSfJEx
	b2SD0Fb1kWUSFMuCchiezISyD7Ofd1tZ7o9bRRHoIiea7JCIW4tE1/p7asIte3qWJsaM
	70WPGE7VNHEpdqYXUPMLSNbrIk7BWgh4mK9A0Xllow/E0kr2gLIRMOwQh0beDg/hKia6
	Cl2DWs2PPdB9Y1lfFlSf2mMN1deUyGRnkQgZVffGV45q7FgO6jl4bhKKrwcGXhy4GApF
	ZjrA==
X-Received: by 10.68.219.194 with SMTP id pq2mr1695257pbc.20.1442004989364;
	Fri, 11 Sep 2015 13:56:29 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ql5sm1997168pac.46.2015.09.11.13.56.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 11 Sep 2015 13:56:28 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Sep 2015 13:57:30 -0700
Message-Id: <6bbbf30628d8f0f2c2ac39b1953e553119eb40b6.1442004911.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <838c8c98c5edfd801c02aa06a5e3393d35649e0d.1442004911.git.avery.brian@gmail.com>
References: <838c8c98c5edfd801c02aa06a5e3393d35649e0d.1442004911.git.avery.brian@gmail.com>
In-Reply-To: <cover.1442004911.git.avery.brian@gmail.com>
References: <cover.1442004911.git.avery.brian@gmail.com>
Subject: [PATCH 3/3] toaster: Don't def a function for each call to build_artifact()
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
X-List-Received-Date: Fri, 11 Sep 2015 20:56:29 -0000

From: Elliot Smith <elliot.smith@intel.com>

Cache the mimetype object and only define the function for
getting a mimetype once.

Also ensure that filemagic is listed as a requirement of
toaster. Doing this also means we can remove the code
which tries multiple different "magic" libraries, as we know
we have the right version available.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 42 ++++++++++-------------------------------
 toaster-requirements.txt        |  1 +
 2 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 784272f..e918b05 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -47,10 +47,19 @@ import json
 from os.path import dirname
 import itertools
 
+import magic
 import logging
 
 logger = logging.getLogger("toaster")
 
+class MimeTypeFinder(object):
+    _magic = magic.Magic(flags = magic.MAGIC_MIME_TYPE)
+
+    # returns the mimetype for a file path
+    @classmethod
+    def get_mimetype(self, path):
+        return self._magic.id_filename(path)
+
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
 def landing(request):
@@ -68,8 +77,6 @@ def landing(request):
 
     return render(request, 'landing.html', context)
 
-
-
 # returns a list for most recent builds;
 def _get_latest_builds(prj=None):
     queryset = Build.objects.all()
@@ -2710,40 +2717,11 @@ if True:
 
     def build_artifact(request, build_id, artifact_type, artifact_id):
         if artifact_type in ["cookerlog"]:
-            def _mimetype_for_artifact(path):
-                try:
-                    import magic
-
-                    # fair warning: this is a mess; there are multiple competing and incompatible
-                    # magic modules floating around, so we try some of the most common combinations
-
-                    try:    # we try ubuntu's python-magic 5.4
-                        m = magic.open(magic.MAGIC_MIME_TYPE)
-                        m.load()
-                        return m.file(path)
-                    except AttributeError:
-                        pass
-
-                    try:    # we try python-magic 0.4.6
-                        m = magic.Magic(magic.MAGIC_MIME)
-                        return m.from_file(path)
-                    except AttributeError:
-                        pass
-
-                    try:    # we try pip filemagic 1.6
-                        m = magic.Magic(flags=magic.MAGIC_MIME_TYPE)
-                        return m.id_filename(path)
-                    except AttributeError:
-                        pass
-
-                    return "binary/octet-stream"
-                except ImportError:
-                    return "binary/octet-stream"
             try:
                 build = Build.objects.get(pk = build_id)
                 file_name = build.cooker_log_path
                 fsock = open(file_name, "r")
-                content_type = _mimetype_for_artifact(file_name)
+                content_type = MimeTypeFinder.get_mimetype(file_name)
 
                 response = HttpResponse(fsock, content_type = content_type)
 
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index 19b5293..1d92d5e 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -2,3 +2,4 @@ Django==1.6
 South==0.8.4
 argparse==1.2.1
 wsgiref==0.1.2
+filemagic==1.6
-- 
1.9.1


