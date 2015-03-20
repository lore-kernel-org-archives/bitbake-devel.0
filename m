Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 8B04F739C9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:38 +0000 (UTC)
Received: by pdbop1 with SMTP id op1so104946301pdb.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=TydRohuNOu4aeXKJcbTB1JRhxixCA3uO5eVdiM0HXGw=;
	b=LEH0qZnX43aFKpIDqcf7+HKJuRb3aWV+9TLz+/IIRBys/TbZw7UTtXKcjqfLC1EUpd
	xQuiGDVlIpyxf2Rlq7TAZTq8EtgB5vlQ61xkNc7YnekpuoWcByOXshsjr6q4MXc61wLe
	/zk8CBpMeP8kOG35psw//sNOVnzijVL9MgLx51k2f944aNQOdGCT/oc2SFMdIwQNgqsP
	N3lU+Xq01DsOPskcOmjl/LaeK1RzBKUPMOYtgBGG9BcE7ErMToY12qWiuf1BJFB4S6Rf
	kepxupSVimeGJYuZZI73IoVjMzxQ1Bi9fsI+SGWOJorBuG+DnJHMY0jhmJcjdJOf/D5D
	SJ6A==
X-Gm-Message-State: ALoCoQnpsSQl9XLQPd8r/iQjQOx2bFQNU5M21hrsdUKoEUMVlS+1qdpskyvCMPmrGBQXZJ6uv6ZU
X-Received: by 10.70.91.201 with SMTP id cg9mr18477210pdb.144.1426847139516;
	Fri, 20 Mar 2015 03:25:39 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v5sm7403364pdc.41.2015.03.20.03.25.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B288B56428F; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:23 +0000
Message-Id: <fd165835b00bd5bd9f603322fc5491dacd6bc4da.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 06/14] toaster: do not throw exception on misconfigured data
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We do not want to throw an exception while handling exceptions
that may print information, so replace the exception throwing
with returning data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index eea98b5..625eb1e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1080,7 +1080,7 @@ class Layer_Version(models.Model):
             return self.branch
         if self.up_branch is not None:
             return self.up_branch.name
-        raise Exception("Cannot determine the vcs_reference for layer version %s" % vars(self))
+        return ("Cannot determine the vcs_reference for layer version %s" % vars(self))
 
     def __unicode__(self):
         return "%d %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
-- 
1.9.1


