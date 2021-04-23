Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web08.1611.1619194049233393046
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 09:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.232, mailfrom: michael.opdenacker@bootlin.com)
Received: from localhost (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id 44EA920000B;
	Fri, 23 Apr 2021 16:07:26 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH RESEND 2/2] doc: bitbake-user-manual: code insertion simplification over two lines
Date: Fri, 23 Apr 2021 18:06:48 +0200
Message-Id: <20210423160648.338561-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423160648.338561-1-michael.opdenacker@bootlin.com>
References: <16788839AA7E13EF.3436@lists.openembedded.org>
 <20210423160648.338561-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies paragraphs ending with a colon and followed
by code insertion.

Automatically substituted through the command:
sed -i -z "s/:\n\s*::/::/g" file.rst

This generates identical HTML output.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 3167ab13..bd1fb4fc 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -232,15 +232,13 @@ Some example URLs are as follows::
 
    Because URL parameters are delimited by semi-colons, this can
    introduce ambiguity when parsing URLs that also contain semi-colons,
-   for example:
-   ::
+   for example::
 
            SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
 
 
    Such URLs should should be modified by replacing semi-colons with '&'
-   characters:
-   ::
+   characters::
 
            SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47"
 
@@ -248,8 +246,7 @@ Some example URLs are as follows::
    In most cases this should work. Treating semi-colons and '&' in
    queries identically is recommended by the World Wide Web Consortium
    (W3C). Note that due to the nature of the URL, you may have to
-   specify the name of the downloaded file as well:
-   ::
+   specify the name of the downloaded file as well::
 
            SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47;downloadfilename=myfile.bz2"
 
-- 
2.25.1

