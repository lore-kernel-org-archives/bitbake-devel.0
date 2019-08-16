Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 66DE27F327
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 16:16:41 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c3so2054827wrd.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=pGRsWhZw2HSCnDJBOQVhN0Dwm2p0T52PBYfA21omQh0=;
	b=PJAcaT8INL+GH8jXt9KCG+K7SOQlbP57MACtUyq/cARz0Azp9tJ0Jd+oQrrcrUq0fo
	lHVrKA1OOecV1iG59t+1kpcPNg7XYfs/bMv5rabLKOx0u0psA+3Ly94leU3BskyfMSed
	BctD+8FumE//zTti23Wd1HtYbXLvYdHUL4WWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pGRsWhZw2HSCnDJBOQVhN0Dwm2p0T52PBYfA21omQh0=;
	b=W/cTgm9KFlE8P9+FK6eOeMxQimS5kD6v5ef187Vfwpmg4bfkgdjGsH/Rk4ALGPzsCy
	wQD+FLaYbzSWeUv4sba93LYnWoh3rrDqSBAcqPQC78uIR6mh6mW4Cbzm8ptevjwAjF0H
	2+fJTn2kAyXrGXPgM4etP3WaaL39PUZ3zGLg/+OuDuDehew8Mdyag6LmaDeSZwQzdBx6
	S9UwVit9SvNyV/CGhho+Ijc0ByxbEXp7ChnOMEH4aFyrYbefWN0ZheiG1z1/H775U1pj
	cVcEji/ptB5ml1yN6WttwC8B3VWrsxfEsM71ZpOTPD/8nIbR5CpW10UJw1oVb3fHth/i
	BZpg==
X-Gm-Message-State: APjAAAUZuxyHGnCsO0mzE3eHL20Hopq78GcuFOV1O/cpnYWGjDhRAg9C
	jMOFUm763SROLANhumO4hwo4DE7gvJ0Pgw==
X-Google-Smtp-Source: APXvYqzYRAKjzp5yo+4JqXW6VPK+T8MA7M7tYCjTe7DFXSilqYlqX23cnjETgscf/1qvprX/zp0f6A==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr11763010wrq.321.1565972201991;
	Fri, 16 Aug 2019 09:16:41 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t8sm13108148wra.73.2019.08.16.09.16.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 09:16:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 17:16:37 +0100
Message-Id: <20190816161637.25781-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816161637.25781-1-richard.purdie@linuxfoundation.org>
References: <20190816161637.25781-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/3] runqueue: Optimise build_taskdepdata slightly
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
X-List-Received-Date: Fri, 16 Aug 2019 16:16:42 -0000
Content-Transfer-Encoding: 8bit

Rather than repeatedly calling mc_from_tid() do this in the parent,
removing around a million function calls. Takes time spent in this
function from 40s to 36s.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a98ccddd09..4f69578e46 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2160,12 +2160,11 @@ class RunQueueExecute:
 
         return True
 
-    def filtermcdeps(self, task, deps):
+    def filtermcdeps(self, task, mc, deps):
         ret = set()
-        mainmc = mc_from_tid(task)
         for dep in deps:
-            mc = mc_from_tid(dep)
-            if mc != mainmc:
+            thismc = mc_from_tid(dep)
+            if thismc != mc:
                 continue
             ret.add(dep)
         return ret
@@ -2174,9 +2173,10 @@ class RunQueueExecute:
     # as most code can't handle them
     def build_taskdepdata(self, task):
         taskdepdata = {}
+        mc = mc_from_tid(task)
         next = self.rqdata.runtaskentries[task].depends.copy()
         next.add(task)
-        next = self.filtermcdeps(task, next)
+        next = self.filtermcdeps(task, mc, next)
         while next:
             additional = []
             for revdep in next:
@@ -2186,7 +2186,7 @@ class RunQueueExecute:
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
                 unihash = self.rqdata.runtaskentries[revdep].unihash
-                deps = self.filtermcdeps(task, deps)
+                deps = self.filtermcdeps(task, mc, deps)
                 taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
-- 
2.20.1


