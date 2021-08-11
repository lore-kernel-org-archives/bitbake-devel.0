Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web09.13113.1628713174093135735
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Aug 2021 13:19:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.198, mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6C6B3C0003;
	Wed, 11 Aug 2021 20:19:29 +0000 (UTC)
From: "Quentin Schulz" <foss@0leil.net>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Quentin Schulz <foss@0leil.net>
Subject: [PATCH] doc: bitbake-user-manual-execution: remove mention to long-gone BBHASHDEPS variable
Date: Wed, 11 Aug 2021 22:19:12 +0200
Message-Id: <20210811201912.13648-1-foss@0leil.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BBHASHDEPS was removed from bitbake in April 2014, with the following
commit:
92526eadd09d "bitbake-worker: Drop BBHASH variables"

so let's remove mentions from the docs.

Signed-off-by: Quentin Schulz <foss@0leil.net>
---
 doc/bitbake-user-manual/bitbake-user-manual-execution.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index a6ef90db12..6153f36a0f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -578,9 +578,6 @@ the build. This information includes:
 -  ``BB_BASEHASH_``\ *filename:taskname*: The base hashes for each
    dependent task.
 
--  ``BBHASHDEPS_``\ *filename:taskname*: The task dependencies for
-   each task.
-
 -  :term:`BB_TASKHASH`: The hash of the currently running task.
 
 It is worth noting that BitBake's "-S" option lets you debug BitBake's
-- 
2.20.1

