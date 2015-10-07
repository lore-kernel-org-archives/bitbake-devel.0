Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 8563573CF2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:03:31 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so6111972pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Oct 2015 20:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=wELUZ0puSgW7szF2PM1Ro3EabAqWNtUJkXlMWy+Es8A=;
	b=VauGvDXOqqXJFHCLK2mfuqZGnhbz+Zz3gje0JGc2TXM5DwbQvZKuoNERWuxevFRltU
	TUN0tYmdhYcHq2L5e3OFrPEpHERB9di1xboO86qg8RyXFcKIM8gFjDveh3qD8PTugSg0
	qhj2SMhjxRBehaX7dHFnupbiXQMxn196+oOyZ40Xac/Qthfp6zNBB2FYd235HBGAE4DP
	sp1LIewOSpI5o14gxNLn9w9NFNpT91QrMD6PvHiyVPd19uE0Nq8yOCbTnUkpAPw0cqc+
	nVffjggnnyR39MGBeyOmT6KTEN08dB8j3KC8Spy8U2PoQ4RxxvwrYqKnFw86DJTnH06q
	1JPw==
X-Received: by 10.66.251.35 with SMTP id zh3mr51253945pac.121.1444187011957;
	Tue, 06 Oct 2015 20:03:31 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	pk2sm36154214pbb.21.2015.10.06.20.03.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 06 Oct 2015 20:03:31 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 20:05:22 -0700
Message-Id: <b0833604e6b67c93abee7eb8a791c1ea298f4da9.1444187051.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <3030554491f72bca7e6256b2af8602780e180177.1444187051.git.avery.brian@gmail.com>
References: <3030554491f72bca7e6256b2af8602780e180177.1444187051.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444187051.git.avery.brian@gmail.com>
References: <cover.1444187051.git.avery.brian@gmail.com>
Subject: [PATCH 2/2] toaster: Rationalise mimetype guessing to fix artifact downloads
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
X-List-Received-Date: Wed, 07 Oct 2015 03:03:32 -0000

From: Elliot Smith <elliot.smith@intel.com>

Artifact download links were broken because the function to
get the mimetype for the artifact was incorrectly using the
underlying mimetype library. The function was also attached
to the build environment controller, which was unnecessary, as
we only support local controllers anyway.

Remove the mimetype getter on the build environment and
use the one in the view code instead. This works correctly
and prevents the download error from occurring.

[YOCTO #8369]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/models.py | 34 ----------------------------------
 lib/toaster/toastergui/views.py  |  2 +-
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index f2493a8..ab41105 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -39,40 +39,6 @@ class BuildEnvironment(models.Model):
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
 
-
-    def get_artifact_type(self, path):
-        if self.betype == BuildEnvironment.TYPE_LOCAL:
-            try:
-                import magic
-
-                # fair warning: this is a mess; there are multiple competeing and incompatible
-                # magic modules floating around, so we try some of the most common combinations
-
-                try:    # we try ubuntu's python-magic 5.4
-                    m = magic.open(magic.MAGIC_MIME_TYPE)
-                    m.load()
-                    return m.file(path)
-                except AttributeError:
-                    pass
-
-                try:    # we try python-magic 0.4.6
-                    m = magic.Magic(magic.MAGIC_MIME)
-                    return m.from_file(path)
-                except AttributeError:
-                    pass
-
-                try:    # we try pip filemagic 1.6
-                    m = magic.Magic(flags=magic.MAGIC_MIME_TYPE)
-                    return m.id_filename(path)
-                except AttributeError:
-                    pass
-
-                return "binary/octet-stream"
-            except ImportError:
-                return "binary/octet-stream"
-        raise Exception("FIXME: artifact type not implemented for build environment type %s" % self.get_betype_display())
-
-
     def get_artifact(self, path):
         if self.betype == BuildEnvironment.TYPE_LOCAL:
             return open(path, "r")
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9e4cf55..468cce3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2981,7 +2981,7 @@ if True:
             if file_name is None:
                 raise Exception("Could not handle artifact %s id %s" % (artifact_type, artifact_id))
             else:
-                content_type = b.buildrequest.environment.get_artifact_type(file_name)
+                content_type = MimeTypeFinder.get_mimetype(file_name)
                 fsock = b.buildrequest.environment.get_artifact(file_name)
                 file_name = os.path.basename(file_name) # we assume that the build environment system has the same path conventions as host
 
-- 
1.9.1


