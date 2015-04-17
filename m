Return-Path: <anders@chargestorm.se>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id 21AFA73D3A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Apr 2015 05:49:49 +0000 (UTC)
Received: by layy10 with SMTP id y10so72384599lay.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 22:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Xys4yBd69I/TDNwBcGx97m+DGck9jdfR3GfbFFANY2k=;
	b=UuWVK8f+Cc3N8ymRuBOEeFGOlztPz6iSORIfiYyEVCgf7Mt2yRznL2XgHOS/RPiZAF
	vLUmN/TjMvEZ+BhSHI0zT4cNFs9/wpwsJAX73zUATf/kwutCc6GgLNq57+E83T/wlnZV
	JaMJDPd/5SNYhbHl79Pl3lxdaCcnC7CyEF7LE1QWQ/DciRucuKisOwaObcPJJe83qEFo
	ABDCglgXDgjRfOoEX5Q7Pn/aWjQNsNqmIZWcBtlPAO89yl2BnS3O1x4RkrCtYayu2NXC
	j9UL/O1XqqTcrQ6GTaDw+jCGWZcxDAN9o8dCpDVXU9hMIVIwi0uZn9vJ6UHnYTEBkJ4H
	EOhg==
X-Gm-Message-State: ALoCoQmPvJNVBcYY8vYmJDSouofOsQfevnGMoQh6/O0NS7Ef2fm5jHoKZFZVaoVMryc74mGbmGrp
X-Received: by 10.152.87.162 with SMTP id az2mr1136523lab.58.1429249789863;
	Thu, 16 Apr 2015 22:49:49 -0700 (PDT)
Received: from localhost (213-64-219-84-no126.business.telia.com.
	[213.64.219.84])
	by mx.google.com with ESMTPSA id 4sm2169278lal.36.2015.04.16.22.49.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 22:49:49 -0700 (PDT)
From: Anders Darander <anders@chargestorm.se>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Apr 2015 07:49:42 +0200
Message-Id: <1429249782-21892-1-git-send-email-anders@chargestorm.se>
X-Mailer: git-send-email 2.1.4
Cc: Anders Darander <anders@chargestorm.se>
Subject: [PATCH] Remove a possible trailing '/' in subpath
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
X-List-Received-Date: Fri, 17 Apr 2015 05:49:50 -0000

If the subpath parameter to the git fetcher ends with a trailing '/',
 bb.utils.prunedir() will be called on '/'...

Fixes [YOCTO #7620].

Signed-off-by: Anders Darander <anders@chargestorm.se>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 44fc271..0fd9bee 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -246,7 +246,7 @@ class Git(FetchMethod):
         subdir = ud.parm.get("subpath", "")
         if subdir != "":
             readpathspec = ":%s" % (subdir)
-            def_destsuffix = "%s/" % os.path.basename(subdir)
+            def_destsuffix = "%s/" % os.path.basename(subdir.rstrip('/'))
         else:
             readpathspec = ""
             def_destsuffix = "git/"
-- 
2.1.4


