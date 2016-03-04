Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f179.google.com (mail-pf0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 9D523755F8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Mar 2016 16:41:37 +0000 (UTC)
Received: by mail-pf0-f179.google.com with SMTP id 4so38051959pfd.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Mar 2016 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=cfT8s6Na8J4R6eh0bWYhspGMDO9bT3iPD3yDLCcc5aU=;
	b=D6U2mNKIDKPQT/4SbqdoauImAt+kksGwM6BENlEjcyw9a0Tix5fv9vmpSEX7HyvFWT
	S+eU6oGV/Iypnx9PIpZrJflCEYN5t0WohK2lpJS5SsNT13sYOAFiiml5kmm8INBxZ7Rq
	mj2WEFYUy2z/5n6Vlg6A8PhDOuJZIO2x7XLjd0g6k472WeINPQupqixGXzdcSHVCtDRc
	AGGVLC3StIDYAG+e36N01/ZMGeWxAZgSfjMXjLo3MxxdOKtVmru6Khfxk8w1zk9WtPBZ
	i3e1ZkFElGllobsCAC3kbiLjUU5MWxoizLzzj56yihYyJGVZVrBcNW46YiNWKe4a2kpL
	OMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=cfT8s6Na8J4R6eh0bWYhspGMDO9bT3iPD3yDLCcc5aU=;
	b=ZRzrLxXhTgxS0z1aA3ARM9OjEqssnzwSwCr3+CMwHR2/bCfKe3BgRFHFf8PPRZBKqt
	lLCe/3zmzdi4xpZ2GX7MvydeJqLpyoD+EwkX2dsDcM0qAYFM3JzfzfrTccN92IxsP2FD
	dSXnIxTRSjnx/1UWenEoBZX8A5Z3VjzW7pdESfIwrkmRYT/+pZbIcJuUboi7AEfhmP2n
	3RrVYDLGwQnxs7pyDnXdZOLHf8XZ71Fjvr1kIjDsIsAs/hRS9gZH4wVAyGSzatiQkCEU
	w3WI+TUJm6H9D4CUUP71IOIzeQzGVKya4NIH/xVMxg2+CHVbTQ6QI85RbJSjlRwZzK2F
	JZjw==
X-Gm-Message-State: AD7BkJJ9N/sr9b8yEZBqpIg/Ujigju+A6ZI4mFs8RRDFoe8typ0YgPAzaWEdgzwcxihMVV72
X-Received: by 10.98.9.92 with SMTP id e89mr13533115pfd.34.1457109698267;
	Fri, 04 Mar 2016 08:41:38 -0800 (PST)
Received: from dorado.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	kw10sm6711360pab.0.2016.03.04.08.41.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 04 Mar 2016 08:41:37 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Mar 2016 16:41:27 +0000
Message-Id: <1457109687-14699-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH] toaster: fixup dependency excludes for customimage
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
X-List-Received-Date: Fri, 04 Mar 2016 16:41:37 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO #9156]

For a customized image when adding a dependent package X that depends on
dependency package Y, in addition to adding X to appends_set and Y to
includes_set, make sure that Y is no longer in the excludes_set. Y may
have been added to the excludes_set by a prior package removal.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 28b03d3..f3b8d3c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2653,6 +2653,13 @@ if True:
                                            name=dep.depends_on.name)
 
                         recipe.includes_set.add(cust_package)
+                        try:
+                            # when adding the pre-requisite package make sure it's not in the
+                            #   excluded list from a prior removal.
+                            recipe.excludes_set.remove(cust_package)
+                        except Package.DoesNotExist:
+                            #   Don't care if the package had never been excluded
+                            pass
                     except:
                         logger.warning("Could not add package's suggested"
                                        "dependencies to the list")
-- 
2.5.0


