Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id C6D4E76DEB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:08 +0000 (UTC)
Received: by pacti10 with SMTP id ti10so93263457pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=k9n4qT4s8SqLbF2TEt2dxyQpXN9VFg8YkHRKo+sgVdA=;
	b=y1BsV+vqGM2yNMZ9cxH+jVqM1P8MYv5twlEHjsn2nhO2f8N4b1jOi8qt5Gt8sFVZHt
	lSMHehdwI7XaO/UqkJD/imHT4tb9bN4VMOI8ai8z8BJMDdO7+FfXp2SWlewmotuajVHh
	ekqIr6p+Bd4r7U69C7q4y9CyaK/PhH75eo7bYdvFc8j+d4ZtFlu4UOQAtYCVk8xnPKV9
	EEGysyeVdALAHvhdg+11di1MAhbWCUbBup5befBfhzOccs5G+FHg/YWqTaJZN0Aqqqbe
	15ehgbqINEzjwtDZpPcAqeUL0JRfw68pq7Z1gHujs81XzQD99gNGrsu958l91YxOuhhk
	a03w==
X-Received: by 10.66.254.167 with SMTP id aj7mr71209933pad.39.1440607028867;
	Wed, 26 Aug 2015 09:37:08 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	vw6sm23226840pab.14.2015.08.26.09.37.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:07 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:37:45 -0700
Message-Id: <1440607067-14461-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440607067-14461-1-git-send-email-kergoth@gmail.com>
References: <1440607067-14461-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/3] bb.fetch.git: remove leading '.' from gitsrcname
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:08 -0000

From: Christopher Larson <chris_larson@mentor.com>

When using an absolute file URI, there's no host, and the path starts with
'/', the dir under ${DL_DIR}/git2/ ends up starting with '.', so is hidden.
Remove any leading '.' to fix this.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 374d846..40658ff 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -137,7 +137,10 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
+        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
+        if gitsrcname.startswith('.'):
+            gitsrcname = gitsrcname[1:]
+
         # for rebaseable git repo, it is necessary to keep mirror tar ball
         # per revision, so that even the revision disappears from the
         # upstream repo in the future, the mirror will remain intact and still
-- 
2.2.1


