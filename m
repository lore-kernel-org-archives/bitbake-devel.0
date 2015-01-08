Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 6D4B072A3C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 13:15:26 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id eu11so11699897pac.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 Jan 2015 05:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=PgW3airNRgthkd2PJpl0vrEnNJTtH7GCJcKPwlUnJkw=;
	b=B4rQsomPxXprr5lAz6vtMO48JyEneKo+YwOsDArWQDtU8+otil2CMHcM7YizkRaT1Q
	rHXtemSCax0+HymzX0CO5RzK2s+21S3vPru4LsB6fSiyao3/YfDnBhB4rraLgrWzky73
	Em8VYC2A9Y8gTnr3GblgkJr0IRUm6iXvj6tjSd4wYxVrUlBk8VFyPXIXFLQL1rrLN8hW
	C1wbbZOXD4VvGi0ptM9KNYIcqLtLk27P65mohcP87bKpqDvomN/PZKHSC9WuOPOggwXL
	00d5PkB1HXHDPucW86mWDQAHARz6xeZkJ2kvkbwzXbBtYGK/0tpjuUV0Q12wwCUFli/3
	/brw==
X-Gm-Message-State: ALoCoQluPKDxurcTojBoE+O18BZlniMABdLqE29k7pxcVOhT+t9xQ4O/xblzl9N3fn2WiRwj5/Fk
X-Received: by 10.68.162.130 with SMTP id ya2mr14572110pbb.113.1420722926933; 
	Thu, 08 Jan 2015 05:15:26 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id pg6sm4445847pbb.96.2015.01.08.05.15.25
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 Jan 2015 05:15:26 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0CB1756232E; Thu,  8 Jan 2015 13:15:16 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Jan 2015 13:15:13 +0000
Message-Id: <5687529e179ccc0bbfb80a769daff0224349ae16.1420722767.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
References: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1420722767.git.alexandru.damian@intel.com>
References: <cover.1420722767.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/5] toaster: branch name priority resolution
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
X-List-Received-Date: Thu, 08 Jan 2015 13:15:29 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding a Layer_Version function that gets back the
branch name that should be used/displayed for finding the
targeted git branch name.

Change the commit id to use the branch name instead of the
last-updated commit hash from the layer source.

[YOCTO #7031]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 6fbbeed..5eff955 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -740,7 +740,7 @@ class LayerIndexLayerSource(LayerSource):
             lv.up_date = lbi['updated']
             lv.up_branch = Branch.objects.get(layer_source = self, up_id = lbi['branch'])
             lv.branch = lbi['actual_branch']
-            lv.commit = lbi['vcs_last_rev']
+            lv.commit = lbi['actual_branch']
             lv.dirpath = lbi['vcs_subdir']
             lv.save()
 
@@ -960,6 +960,12 @@ class Layer_Version(models.Model):
                 key = lambda x: _get_ls_priority(x.layer_source),
                 reverse = True)
 
+    def get_vcs_reference(self):
+        if self.commit is not None and len(self.commit) > 0:
+            return self.commit
+        if self.branch is not None and len(self.branch) > 0:
+            return self.branch
+        return self.up_branch.name
 
     def __unicode__(self):
         return  str(self.layer) + " (" + self.commit +")"
-- 
1.9.1


