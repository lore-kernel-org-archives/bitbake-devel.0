Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id AFA2E7391D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 14:07:33 +0000 (UTC)
Received: by pactp5 with SMTP id tp5so20797116pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 07:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=xWaQhWOe2H4hrT80lUM+9UM9s2uzwshhRR92x63+GZc=;
	b=De1i2ZACgwnVFRPZRrr+HUDqCOQL6zaya5V97DypzNBz5glCSlnKygNY8UZ4y1KlLV
	Y4PCvbLVOvEOkFR5GLBz3Unaj9xGr6W89i/nLm6zdodbjMKmZh2IMIEgycCH02uKkDBy
	OG/5mS7qxLYhn/kDkQqB/72417O4bKHvOX+YJJKxIatf86Nrlw8uhNGZz3C2+JXtHN7k
	qivZRlrIaBNSob9/TYZO/Wbth3qqlAM63fsk5tRZ/B5f5FERt/Frx1ke+hi4Mo7uZ181
	HsSAV7m142Z+MQ8tDOLQ9bEkU4LFg1sroIpmww2s0wporpEhuRsObKEGF3lVvQKNH9oJ
	9geg==
X-Gm-Message-State: ALoCoQlLQcBhYEzu/Zs8ZvydbIxnSFLqmbyU7sufO6nnLf1k2+JQJcQEgZoZuw/SW91vUnQasb9b
X-Received: by 10.68.197.201 with SMTP id iw9mr69565158pbc.84.1427810854714;
	Tue, 31 Mar 2015 07:07:34 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	n10sm14109597pdp.18.2015.03.31.07.07.33
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 31 Mar 2015 07:07:33 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 37E5E561EBC; Tue, 31 Mar 2015 15:07:31 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Mar 2015 15:07:30 +0100
Message-Id: <32b405d1e44e310dd1a1d04dff36bac3f5e630a7.1427810520.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4b553dbeff7c7bc536669e7fee7d52f962259ebe.1427810520.git.alexandru.damian@intel.com>
References: <4b553dbeff7c7bc536669e7fee7d52f962259ebe.1427810520.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1427810520.git.alexandru.damian@intel.com>
References: <cover.1427810520.git.alexandru.damian@intel.com>
Subject: [PATCH 4/4] Revert "toaster: machine not searchable in all builds/projects"
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
X-List-Received-Date: Tue, 31 Mar 2015 14:07:33 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This reverts commit 1a86ed8f95649c5f5a3a66984ce36978d93b0e01.

Bug [YOCTO #7334] was incompletly fixed, and the proper fix is
not straightfoward. Consequently we revert the partial fix, as
a incomplete fix is worse than no fix.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index bfb25ee..02cfaf7 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -106,7 +106,7 @@ class BuildRequest(models.Model):
         (REQ_ARCHIVE, "archive"),
     )
 
-    search_allowed_fields = ("brtarget__target", "build__project__name", "build__machine")
+    search_allowed_fields = ("brtarget__target", "build__project__name")
 
     project     = models.ForeignKey(Project)
     build       = models.OneToOneField(Build, null = True)     # TODO: toasterui should set this when Build is created
-- 
1.9.1


