Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 170CB737E1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:59:35 +0000 (UTC)
Received: by wiun10 with SMTP id n10so91618210wiu.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=1pOhG8yrgSqmBwr4nEDnAvT1xy/ogAnZk8zlrdcCULw=;
	b=ewHPjDbG9UXYBXV510wBu4H/rjNe/UI9nZvpbIsk/MigcuRpPoyQDRrvg2BAVFLXOg
	GMQaZ5TUKFYwvKg94EiFtSo1Pj7GDLtv/EG7n6p5wsDh9Tz7bVYUnIOY52KpSz5oWN2E
	s6cCLbik998ilD3ouaF4KRoZlIfSezzL0gYtMlEqHHre+uAtlbYpqLNsX6Y1R6vpizpi
	YH8e/7CFGHes+jqMj4WCoTy1rmH3Y9kgiBpwFVk6/qphl09o+6pLr496WFPVd/2PVbdC
	t0Jy0IlHOlIeRp5XyYwNZ3t/g+7qga2BIphbCkIVTi8jtS0nwFAjZ/cqhlTdi4UY5XuT
	FOoQ==
X-Gm-Message-State: ALoCoQlZwck2AFd371w7kx64bqindibvjnd3aYYHBE7awLIX+s1U90ih5bm5k0Ehu/kbSUuRPo08
X-Received: by 10.180.103.231 with SMTP id fz7mr18291968wib.35.1431341976545; 
	Mon, 11 May 2015 03:59:36 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	bm9sm22256935wjc.21.2015.05.11.03.59.35
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:59:35 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E9DCE5603CC; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:36 +0100
Message-Id: <56e10a3a2c8345347bc38e306f4a3093feb2a85f.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 05/11] toaster: fix typo in format string
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
X-List-Received-Date: Mon, 11 May 2015 10:59:36 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed TypeError: not all arguments converted during string formatting

[YOCTO #7618]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index b9bb896..c00c352 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -52,7 +52,7 @@ class ToasterSetting(models.Model):
     value = models.CharField(max_length=255)
 
     def __unicode__(self):
-        return "Setting %s = " % (self.name, self.value)
+        return "Setting %s = %s" % (self.name, self.value)
 
 class ProjectManager(models.Manager):
     def create_project(self, name, release):
-- 
1.9.1


