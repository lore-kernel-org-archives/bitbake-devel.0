Return-Path: <Markus.Niebel@ew.tq-group.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940EBC27C40
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 08:41:14 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by mx.groups.io with SMTP id smtpd.web11.6461.1692866467074284211
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 01:41:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tq-group.com header.s=key1 header.b=a4No8qBE;
 spf=pass (domain: ew.tq-group.com, ip: 93.104.207.81, mailfrom: markus.niebel@ew.tq-group.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692866467; x=1724402467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kTReOQk4FKrvM6K4zsLaAzj5mRjFikYZ/ZYjawwq5UI=;
  b=a4No8qBEHmooKERxnYJL+NYW4aaKNLccizH8EfOquSiWVN4X585dxyhB
   QeJxiVadHLNAbMrFmEwSLw99cHqkfZJYct5RvMAeKYYe/c3PEWTKozBOo
   pX6VfkakwfNryGygTK0K81wdVN/kBWlcIcy3rUxDmbLJNNJsC9obxtfGt
   6fKVKHTjjg2VqAMCoSwfLv/8BvFMDEniX6vZ7dimcuyLAiUPFmEHD0+7k
   s3mDqs8xlHwKIE7q4q6yZVEYJqzv31gfZ4GscfTVrSLpbzq1DDfHbv4nV
   +z4MFQ8FX6/+JxJ78H7DTJqw9fFmxkCGirLvt3+rHIfeiOURB9Bd9QEbK
   w==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32603428"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Aug 2023 10:41:04 +0200
Received: from NIEBEL-W3.tq-net.de (NIEBEL-W3.tq-net.de [10.123.53.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 51639280075;
	Thu, 24 Aug 2023 10:41:04 +0200 (CEST)
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: bitbake-devel@lists.openembedded.org
Cc: oss@ew.tq-group.com,
	Paulo Neves <ptsneves@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [kirkstone][2.0][PATCH] bitbake-getvar: Add a quiet command line argument
Date: Thu, 24 Aug 2023 10:41:00 +0200
Message-Id: <20230824084100.1822478-1-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 08:41:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14971

From: Paulo Neves <ptsneves@gmail.com>

bitbake-getvar does not have a way to silence bitbake
server's logger and that makes the tool hard to use for
text processing. This is especially true when one wants to
get a bitbake value to be piped to some other utility and
instead we get uncontrolled logging messages or warnings
together with bitbake's variable value.

Example without quiet:
bitbake-getvar --value MACHINE
NOTE: Starting bitbake server...
qemux86-64

With quiet:
bitbake-getvar --value MACHINE --quiet
qemux86-64

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
(cherry picked from commit af354e975d0b4c26d0e91e3c82946b093bc11b45)
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 bin/bitbake-getvar | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 5435a8d7..4a9eb4f3 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -25,6 +25,7 @@ if __name__ == "__main__":
     parser.add_argument('-u', '--unexpand', help='Do not expand the value (with --value)', action="store_true")
     parser.add_argument('-f', '--flag', help='Specify a variable flag to query (with --value)', default=None)
     parser.add_argument('--value', help='Only report the value, no history and no variable name', action="store_true")
+    parser.add_argument('-q', '--quiet', help='Silence bitbake server logging', action="store_true")
     args = parser.parse_args()
 
     if args.unexpand and not args.value:
@@ -35,7 +36,7 @@ if __name__ == "__main__":
         print("--flag only makes sense with --value")
         sys.exit(1)
 
-    with bb.tinfoil.Tinfoil(tracking=True) as tinfoil:
+    with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=2)
             d = tinfoil.parse_recipe(args.recipe)
-- 
2.25.1


