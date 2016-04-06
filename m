Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 7B420771CD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:31 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id n3so71351823wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=mxxamK52i9/7SP/uSxePycYzaAPvbcpg5KKkxGpjYSE=;
	b=gwWKQQE70hCpaj8eoASf9eg6A1XAtUbptNo4jsnlx9fQaRS7QVK3CmFnJsDp0Y++DZ
	nJX6+DD61nWxkP4NiR4Hmjm4NDrq4UmHi2NyP9cT7AN4EFFwM1Or7QJUjWMuF+8Wx3gx
	hDi7gxmcVlS6c+2+OCAWhitMX1j+5+tOgRoLvXFCM+fiz8bX/6hU8O3stCARIzf/emLX
	Z5gEvNEuRxDTHUwydM1ko06/1vxdwmo2ES95qiSEGUzeLt9TIZa0zLHKWC8G/+4SR5Qr
	e+RZMx+tGxb7OSnHGeg3UOe6hl8pzmsx4dLhhdw5+7n3jOrzogcZuKIiYeUL4qIbednr
	N0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=mxxamK52i9/7SP/uSxePycYzaAPvbcpg5KKkxGpjYSE=;
	b=FKKhQh6kwml4Rha5TrP9V/PTo/VD2xQKNrEbyw/fa5jnupzIQ09qOCVprBe7MHZNmY
	VdRMQ79Dlfb2soh6nMYUEGUJnJbZk8AuAxP+owqjJKPNmfJ2yxrOV1IXjGV9u547wULd
	suKsLKpouhpXlbBwWDyDbCFRgjfLhE/7YamEA5rYFOVxZP8V3YB/NLRSEzNKpliigBsT
	NrNEX/ho9nVXiylAos97MCmlUsicQfqByrNR50V3p+GjieXNi4rzJmF3kQIHK8UtLTmE
	bZHTibwu+LZnZOmaTPgbIBlOjuK8UtAzRT7/6Yc3LjZc4vme/a31mJYosCCsGqfIjgcU
	Ckcg==
X-Gm-Message-State: AD7BkJLCnNnza7pm/g80DDP6cFsu2GeT9BEx6QBKo3vzzjSutZmDrbbl/aSxXKMU4m6kCGMw
X-Received: by 10.28.127.4 with SMTP id a4mr18866873wmd.76.1459961251928;
	Wed, 06 Apr 2016 09:47:31 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:31 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:36 +0100
Message-Id: <9cdd8604a5058358cceb5b5a34dfc952717edaa5.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 26/38] buildinfohelper: Add handler for cancelling a build
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:31 -0000

When a build is cancelled the build (action) is complete if it has been
caused the request being cancelled then update the build outcome
accordingly.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e4177f2..0ce36b0 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -218,6 +218,15 @@ class ORMWrapper(object):
         assert isinstance(errors, int)
         assert isinstance(warnings, int)
 
+        if build.outcome == Build.CANCELLED:
+            return
+        try:
+            if build.buildrequest.state == BuildRequest.REQ_CANCELLING:
+                return
+        except AttributeError:
+            # We may not have a buildrequest if this is a command line build
+            pass
+
         outcome = Build.SUCCEEDED
         if errors or taskfailures:
             outcome = Build.FAILED
@@ -1407,9 +1416,17 @@ class BuildInfoHelper(object):
         be.lock = BuildEnvironment.LOCK_LOCK
         be.save()
         br = BuildRequest.objects.get(pk = br_id)
+
+        # if we're 'done' because we got cancelled update the build outcome
+        if br.state == BuildRequest.REQ_CANCELLING:
+            logger.info("Build cancelled")
+            br.build.outcome = Build.CANCELLED
+            br.build.save()
+            errorcode = 0
+
         if errorcode == 0:
             # request archival of the project artifacts
-            br.state = BuildRequest.REQ_ARCHIVE
+            br.state = BuildRequest.REQ_COMPLETED
         else:
             br.state = BuildRequest.REQ_FAILED
         br.save()
-- 
2.1.4


