Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SSGYz-0002v6-MR
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 May 2012 01:44:57 +0200
Received: by obhx4 with SMTP id x4so1079534obh.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 May 2012 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=dEYi2+9KzdfPHoTI89Cypkf72jhMQHZmu6I7DSKhDxI=;
	b=PF7mds3pqtbJ7Bh5gTTogasHl8WTZnfWyde0PgrTixr+esNVnk0WdBDPqp3DG9x3BH
	vO+BzgE1aNHOxQIwFjhenYqBmYdOIfcCgoORcEioNDM5WgFNyP05YD6nyJIETVFr1EAM
	oBmagQzfo7m+ajsW5J+VygaMCdfcxAj+PsEYi12K/QFe3JmbQHF705ZpnJhg4eUw2T2/
	SeqooCLiF91crbHcuzp2RGZvb/7zQldHr4W6C3Ng3wZoe6BbF8TTg5qR/aW4Yngf03/y
	7Tw95064FOjEOlVLpLSDSNMUv/GCSfaKGk3kpHWSmoBIPAi1KLa2SSq8h0DBXs+uOslI
	Dgvg==
Received: by 10.60.22.234 with SMTP id h10mr2877586oef.54.1336606503990;
	Wed, 09 May 2012 16:35:03 -0700 (PDT)
Received: from localhost.localdomain (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id s8sm3522309oec.1.2012.05.09.16.35.02
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 09 May 2012 16:35:03 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 May 2012 18:35:48 -0500
Message-Id: <1336606548-2482-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.7.7
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] runqueue: drop unnecessary keys() in runqueue_process_waitpid
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 09 May 2012 23:44:57 -0000

From: Christopher Larson <chris_larson@mentor.com>

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/runqueue.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8828e4a..462c685 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1064,7 +1064,7 @@ class RunQueueExecute:
         del self.build_pipes[pid]
 
         # self.build_stamps[pid] may not exist when use shared work directory.
-        if pid in self.build_stamps.keys():
+        if pid in self.build_stamps:
             del self.build_stamps[pid]
 
         if status != 0:
-- 
1.7.7



