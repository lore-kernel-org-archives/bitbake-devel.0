Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com
	[209.85.219.196])
	by mail.openembedded.org (Postfix) with ESMTP id 261C490DFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2019 18:45:26 +0000 (UTC)
Received: by mail-yb1-f196.google.com with SMTP id i72so1167857ybg.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2019 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kudzu-us.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=pNgVqbj1z6YzLnB+24TMD88tOu2cOMHW7gySPbdWeig=;
	b=kRwCA7RHCa02+4xaHEJBkvbTEv3vgdldnZ68n7ObJ6m6hskZoiwN4hJ1R0txIxOrBQ
	joZqvz/9osD5eh7ORYOxHZO8ud0qe+llTUZqlfMtN3utKE4yF8ffPaNQtPJQlKcXWZXE
	2y8Yz372hA26z+xlRQay86UtD2VyMjitz0CrZu5kmYmGPAkRBBpbneWPH6Jny2iyGwj5
	YHSLaWA94B1GGTx9020D9b+/w7Ad/aAvb2IFKGUq3MSJDKaLf46XWuZQwwoSy59JILMo
	PHvruvbJ6dJfohlrUCP5eOpejdUJnQWn62heco8AkIDfwCJ5yVG70Xmfab9la1vAr6bd
	+YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=pNgVqbj1z6YzLnB+24TMD88tOu2cOMHW7gySPbdWeig=;
	b=XQiFrB7tq0zYe3m1FNM3ECYIUbA4me9MS9BcvHr/3OpT5Q2rspBaSldMWFD/uQwS1m
	yJkWEv+Ba8qWl5B3LGnLRGLvEAU/meFMUHxEHLzOvDC3QOV+nHCT8caF6ejY8El2ZTg6
	jAIbphoKEuyZopBXcBjf8WeUaEZNzQtChQQhOtw3wjGl9Gqofasvt6CvCYzICTPWI8KF
	GI0vVh29H+9X4ru1SS8uZ01pmgptuR4iNmu45DUPLRw6a8qGibasg8tr9MVezWiXS1i0
	bhMF6SHck/J26UmP4kWuCa4YZjSBjSWEfBEf6xd+Y+YB7y+yUs6M/sVfWpmykoMrH7F+
	cjGg==
X-Gm-Message-State: APjAAAVAp2WJhrlXzqDtGjbeuTUffWxuqq0BM15a3EaWvuD+O5WAY7KM
	xFhrHbADAILDhYNHuDh9reYCJZxBih1ulQ==
X-Google-Smtp-Source: APXvYqxNfSN8sjVZ/mKpSK5MLkNKPrYCSIbyoXPU+LB6WI9rkqYwtTaHRx9XIqdWm4E0qLhj9VwY1w==
X-Received: by 2002:a25:8c9:: with SMTP id 192mr3011940ybi.328.1576694726747; 
	Wed, 18 Dec 2019 10:45:26 -0800 (PST)
Received: from localhost ([2605:a601:a638:2c00:6f:be90:be23:5580])
	by smtp.gmail.com with ESMTPSA id n1sm1348979ywe.78.2019.12.18.10.45.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Dec 2019 10:45:26 -0800 (PST)
From: Jon Mason <jdmason@kudzu.us>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Dec 2019 13:45:25 -0500
Message-Id: <20191218184525.27246-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] bitbake: layerindex: use branch when specified
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
X-List-Received-Date: Wed, 18 Dec 2019 18:45:26 -0000
Content-Transfer-Encoding: 8bit

When currently specified, the branch is used to verify the versioning of
the meta layer, but the master branch is checked out.  This change
allows for the branch to be specified.  Now it is easy to specify all
of the meta layers being added are of the same version, without having
to do it in each individual git tree.  Also, it will error if there are
branches without a matching version.  Finally, this allows for meta
layer git trees without a master branch.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 bitbake/lib/bblayers/layerindex.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
index 57cd9027f6..55029e0482 100644
--- a/bitbake/lib/bblayers/layerindex.py
+++ b/bitbake/lib/bblayers/layerindex.py
@@ -24,7 +24,7 @@ class LayerIndexPlugin(ActionPlugin):
     This class inherits ActionPlugin to get do_add_layer.
     """
 
-    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
+    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer, branch):
         layername = self.get_layer_name(url)
         if os.path.splitext(layername)[1] == '.git':
             layername = os.path.splitext(layername)[0]
@@ -32,7 +32,9 @@ class LayerIndexPlugin(ActionPlugin):
         layerdir = os.path.join(repodir, subdir)
         if not os.path.exists(repodir):
             if fetch_layer:
-                result = subprocess.call(['git', 'clone', url, repodir])
+                if not branch:
+                    branch = "master"
+                result = subprocess.call(['git', 'clone', '-b' , branch, url, repodir])
                 if result:
                     logger.error("Failed to download %s" % url)
                     return None, None, None
@@ -171,7 +173,8 @@ class LayerIndexPlugin(ActionPlugin):
                 subdir, name, layerdir = self.get_fetch_layer(fetchdir,
                                                       layerBranch.layer.vcs_url,
                                                       layerBranch.vcs_subdir,
-                                                      not args.show_only)
+                                                      not args.show_only,
+                                                      args.branch)
                 if not name:
                     # Error already shown
                     return 1
-- 
2.20.1


