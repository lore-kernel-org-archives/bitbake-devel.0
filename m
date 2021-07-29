Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web09.9222.1627564402567918695
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 06:13:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7959224000B;
	Thu, 29 Jul 2021 13:13:20 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Quentin Schulz <foss@0leil.net>
Subject: [PATCH v2] doc: bitbake-user-manual: grammar fix for the number of "metadata"
Date: Thu, 29 Jul 2021 15:13:11 +0200
Message-Id: <20210729131311.164092-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16964500F28F0291.7588@lists.openembedded.org>
References: <16964500F28F0291.7588@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"metadata" is used both as singular and as plural.
The first change fixes a case in which the verb has a singular conjugation
but absence of article indicates a plural case.

The second and third changes are for consistency with the first one inside
the same paragraph.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reviewed-by: Quentin Schulz <foss@0leil.net>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index eb140665..55effc35 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -27,11 +27,11 @@ Linux software stacks using a task-oriented approach.
 Conceptually, BitBake is similar to GNU Make in some regards but has
 significant differences:
 
--  BitBake executes tasks according to provided metadata that builds up
-   the tasks. Metadata is stored in recipe (``.bb``) and related recipe
+-  BitBake executes tasks according to provided metadata that build up
+   the tasks. Metadata are stored in recipe (``.bb``) and related recipe
    "append" (``.bbappend``) files, configuration (``.conf``) and
    underlying include (``.inc``) files, and in class (``.bbclass``)
-   files. The metadata provides BitBake with instructions on what tasks
+   files. The metadata provide BitBake with instructions on what tasks
    to run and the dependencies between those tasks.
 
 -  BitBake includes a fetcher library for obtaining source code from
-- 
2.25.1

