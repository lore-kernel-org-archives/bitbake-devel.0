Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
	by mail.openembedded.org (Postfix) with ESMTP id 51F1F6B2E6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 16:25:14 +0000 (UTC)
Received: by mail-ee0-f47.google.com with SMTP id e51so4422790eek.34
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KFRvteHSOfpaFedTTOcLlL7RHrH3CREb5nfTw/jBrGM=;
	b=VDFMiPnNsVyYGRAX3LmnebF2Sm4gu9ayo9lQ+QEN5hUVJQ9b2cLZ8H062lZp7Ccs/H
	mJjzCF10ljF/Z6qhjI3Vj89AIE/pTqcZcSxhx23Esp3btEYYqio/O8hMNGn+nMmxebtF
	9zFYp7XeMlIPnQ5NuVkDavvM1j/hEozB9gNCigSGaCvfpjYNWLxcKvKryzDVJhHFJwyx
	uWaVPuXutWq2CNy2/7OOFWxT01mXiRBsDPDHEv/5VGtYOv+7z19IAWQj/nIu6pIqUbWY
	NYIqYb8tEDebT1vHIZW9a47zigHTSasEiREPn01bOxLqqq53OdWifwQ8lDouFtec3kbY
	bRQQ==
X-Received: by 10.14.211.69 with SMTP id v45mr2425070eeo.75.1388420715060;
	Mon, 30 Dec 2013 08:25:15 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id 4sm110065709eed.14.2013.12.30.08.25.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 30 Dec 2013 08:25:13 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 30 Dec 2013 17:25:13 +0100
Message-Id: <1388420713-15293-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
References: <CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
Subject: [RFC][WIP][PATCH] runqueue: Don't fail without match found
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
X-List-Received-Date: Mon, 30 Dec 2013 16:25:14 -0000

* WIP, because I haven't checked the reasons why this happens
  I'm using this now only to see which recipes/tasks are failing
  like this

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/runqueue.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 4577236..413b95e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1224,10 +1224,14 @@ class RunQueue:
             if match is None:
                 bb.fatal("Can't find a task we're supposed to have written out? (hash: %s)?" % h)
             matches = {k : v for k, v in matches.iteritems() if h not in k}
-            latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
-            prevh = __find_md5__.search(latestmatch).group(0)
-            output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
-            bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
+            sortedmatches=sorted(matches.keys(), key=lambda f: matches[f])
+            if sortedmatches:
+                latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
+                prevh = __find_md5__.search(latestmatch).group(0)
+                output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
+                bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
+            else:
+                bb.plain("\nTask %s:%s couldn't find any matches for hash %s" % (pn, taskname, h))
              
 
 
-- 
1.8.4.3


