Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.9101.1627563705604444906
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 06:01:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9F012FF80E;
	Thu, 29 Jul 2021 13:01:43 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: grammar fix for the number of "metadata"
Date: Thu, 29 Jul 2021 15:01:33 +0200
Message-Id: <20210729130133.163787-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9aebdc2ca149587d39cd23628c392423148f22ba.camel@linuxfoundation.org>
References: <9aebdc2ca149587d39cd23628c392423148f22ba.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"metadata" is used both as singular and as plural.
The first change fixes a case in which the verbs have a singular conjugation
but articles that indicate a plural case.

The second change is for consistency with the first one inside
the same paragraph.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index eb140665..64e7305d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -27,11 +27,11 @@ Linux software stacks using a task-oriented approach.
 Conceptually, BitBake is similar to GNU Make in some regards but has
 significant differences:
 
--  BitBake executes tasks according to provided metadata that builds up
+-  BitBake executes tasks according to provided metadata that build up
    the tasks. Metadata is stored in recipe (``.bb``) and related recipe
    "append" (``.bbappend``) files, configuration (``.conf``) and
    underlying include (``.inc``) files, and in class (``.bbclass``)
-   files. The metadata provides BitBake with instructions on what tasks
+   files. The metadata provide BitBake with instructions on what tasks
    to run and the dependencies between those tasks.
 
 -  BitBake includes a fetcher library for obtaining source code from
-- 
2.25.1

