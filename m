Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id 70C7373D26
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:03:30 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so6282676pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Oct 2015 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hCV7B9hsjsS8WWK5t1u5gu/mFO+yvOLlb0VdKqp2z+o=;
	b=W+Z27mrQwVvOURGpiq5MMcvilgqrir+L5t1XlrcYYrolD3sqmDxZOyEo+YbuoNOYIE
	/DBI/d9Nnr/0ZKaEQC1eSqX1dz+jLkhlp0c0btoNj7Txp6oC09OJZpwQ9fNMcCHZPJ66
	GdXWBOyrIr8XG+kSIIhkIlmLUM7kh0+l+C6BC9RielANmJ+HDHN7qIDELRE4JLKFwZG0
	CGh44K4lAIejjBEdsG5rdcL13qkjCwm/d6mCpi+NJtR7VRcS15cphD3Tb+mRFB5Sax9A
	ZAeZe+iOHaiAi4dhOyqd4nmKnxsX7d9G5ct59EZ4ibZcXHSuzQflfgsae2bBVqyWUjW+
	lgAA==
X-Received: by 10.66.235.4 with SMTP id ui4mr5969047pac.129.1444187011155;
	Tue, 06 Oct 2015 20:03:31 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	pk2sm36154214pbb.21.2015.10.06.20.03.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 06 Oct 2015 20:03:30 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 20:05:21 -0700
Message-Id: <3030554491f72bca7e6256b2af8602780e180177.1444187051.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1444187051.git.avery.brian@gmail.com>
References: <cover.1444187051.git.avery.brian@gmail.com>
Subject: [PATCH 1/2] toaster: Use Python's mimetypes module
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
X-List-Received-Date: Wed, 07 Oct 2015 03:03:31 -0000

From: Elliot Smith <elliot.smith@intel.com>

filemagic is used to guess the mimetype of files when a user
requests a download. However, this adds a dependency on an
external library.

Python does have a mimetypes module, though this guesses the
mimetype rather than doing anything clever with the actual
file content. But for our purposes, it's more than adequate.
(NB Django also uses this module when serving static files.)

Use this instead of relying on any external code, and remove
the filemagic dependency.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 15 +++++++++++----
 toaster-requirements.txt        |  1 -
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e07f0e2..9e4cf55 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -47,19 +47,26 @@ import json
 from os.path import dirname
 from functools import wraps
 import itertools
+import mimetypes
 
-import magic
 import logging
 
 logger = logging.getLogger("toaster")
 
 class MimeTypeFinder(object):
-    _magic = magic.Magic(flags = magic.MAGIC_MIME_TYPE)
+    # setting this to False enables additional non-standard mimetypes
+    # to be included in the guess
+    _strict = False
 
-    # returns the mimetype for a file path
+    # returns the mimetype for a file path as a string,
+    # or 'application/octet-stream' if the type couldn't be guessed
     @classmethod
     def get_mimetype(self, path):
-        return self._magic.id_filename(path)
+        guess = mimetypes.guess_type(path, self._strict)
+        guessed_type = guess[0]
+        if guessed_type == None:
+            guessed_type = 'application/octet-stream'
+        return guessed_type
 
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index c4a2221..1d7d21b 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -2,5 +2,4 @@ Django==1.6
 South==0.8.4
 argparse==1.2.1
 wsgiref==0.1.2
-filemagic==1.6
 beautifulsoup4>=4.4.0
-- 
1.9.1


