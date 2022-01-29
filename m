Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C4AC433F5
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:44 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.1520.1643423382741682585
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=cWtzl+M9;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423383;
  x=1674959383;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ifav73bE8eM6sRyEyNBdHSpsk5MccARjqUD2JH2VpGQ=;
  b=cWtzl+M9SMx9jfD/MxgcKogKHxuSuZvp/EqCeKk+yK1OevBD5vGt2IDr
   u/AL/FgbqmXv8FeCMwqpiBMn5NmNrvlOgLf5uoISqOU232QXD1dbqTZeP
   wGnbjXQs/f1XqzCSg6MHDQKsWYmRE7HGHSqC7f3pHL4ws8Ptmo5PrusYI
   bjHhsRTvp8y7h8gi6BNPGNvNql9TUy/cSZI6ewk0ezXYygZH6UCCz2Rh5
   iyqKEn2qm0Yq0Jk2ud5LBzCYh33nIv7SAOi6wOWwQXki+wjjSgcDO+izY
   54w3xhlNi6SQiwr3XmNUDgL1pSxYi4VvI19l5FdZZoQkxITO967T8dLBH
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/9] bitbake-user-manual: Remove unnecessary \n from a
 PREMIRRORS example
Date: Sat, 29 Jan 2022 03:29:31 +0100
Message-ID: <20220129022939.19329-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Jan 2022 02:29:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13294

Since commit 044fb04d (fetch2: Allow whitespace only mirror entries)
there is no need to separate the entries in PREMIRRORS with "\n".

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 .../bitbake-user-manual-ref-variables.rst                 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 1bb55fc501..9d1828c3ba 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1179,10 +1179,10 @@ overview of their function and contents.
       your configuration::
 
          PREMIRRORS:prepend = "\
-         git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-         ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-         http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-         https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
+         git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \
+         ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \
+         http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \
+         https://.*/.* http://downloads.yoctoproject.org/mirror/sources/"
 
       These changes cause the build system to intercept Git, FTP, HTTP, and
       HTTPS requests and direct them to the ``http://`` sources mirror. You can

