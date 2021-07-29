Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web12.9832.1627567258982885523
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 07:00:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 765A1FF814;
	Thu, 29 Jul 2021 14:00:57 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Quentin Schulz <foss@0leil.net>
Subject: [PATCH v3] doc: bitbake-user-manual: grammar fix for the number of "metadata"
Date: Thu, 29 Jul 2021 16:00:51 +0200
Message-Id: <20210729140051.165306-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <169647C17DBB9BB3.13113@lists.openembedded.org>
References: <169647C17DBB9BB3.13113@lists.openembedded.org>
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
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index eb140665..01ca28ee 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -27,8 +27,8 @@ Linux software stacks using a task-oriented approach.
 Conceptually, BitBake is similar to GNU Make in some regards but has
 significant differences:
 
--  BitBake executes tasks according to provided metadata that builds up
-   the tasks. Metadata is stored in recipe (``.bb``) and related recipe
+-  BitBake executes tasks according to the provided metadata that builds up
+   the tasks. The metadata is stored in recipe (``.bb``) and related recipe
    "append" (``.bbappend``) files, configuration (``.conf``) and
    underlying include (``.inc``) files, and in class (``.bbclass``)
    files. The metadata provides BitBake with instructions on what tasks
-- 
2.25.1

