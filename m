Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F807C433F5
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 20:51:43 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
 [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web12.3881.1643316702538221754
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 12:51:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=NzPXQZNT;
 spf=pass (domain: gmail.com, ip: 209.85.166.53, mailfrom: twoerner@gmail.com)
Received: by mail-io1-f53.google.com with SMTP id n17so5226993iod.4
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OBHCe7p+OuowUN/ra3kRikDzT1XpIXOXU5R58wbm/0=;
        b=NzPXQZNTdsMRqYBdWMg4tCmYp6rgK4U9RTCcdvkRbBC3CoD1SknXlVeAEC3EXG1OPu
         LRkOvDIG4zxEhWRjV0rFwLcJr7N1J9XR0C8aM8cPjl9JwsIA0Z9UeB0GkssQIDx/vI/e
         cDUMUWKiuDsynmCTcKKzP37b/cBvSI+fPVJ/dLCkCjALD/9EK7kKwzJXPO23HS/Bx5jO
         hQc+lvKt/7r/gOfRfNWNeAOSomMknSOI1Xnp6iNBj1aFar/cOy6K2Fdue0YxQ+zgrJW4
         5IlGn377X2wsrACr6EaaAWaU3ALhMpZaJbhDfKSHMu/y2So9ajzJHzEENCauw6nUI8JY
         keLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OBHCe7p+OuowUN/ra3kRikDzT1XpIXOXU5R58wbm/0=;
        b=gsUF7dpbFdI5qWZLjvEppXQOVxKaoz/FANAJNygp4JMzKptWOaeBuHPf+WJicwllXT
         KUrafvCcqNiEKJ06+I4j5qb2qTeqOFE55XRg5xlH08I6BjGErDIjKjRHPO9s1uwA/0iI
         wgu/OpgZXMqPAzFd34PZ8KlK/n94rYUe8NdWiDyl3iNdAyVRKLJNUOlrxA6oE8i7Lu2v
         qBzwA/GGLI/fzdWYNFcziiwIEWbSvKU5sEOQs5x5ywil9AVlFKCqmzokhDS43EKOHUym
         uuobrNcAQ2fw+lqihO7uihhuaNTTiWPfS3+u0FQ1oeUTsJs6DT7z0wCjNntOmmt6CuhH
         aTQg==
X-Gm-Message-State: AOAM531XYo6X60m4knINWVuYZdQxKvMItTr7dAMQ+/07CCoJVMH8lP6M
	IhULwNVQ031YTRjZeO37UHzkYsq9yB0=
X-Google-Smtp-Source: 
 ABdhPJy+NB7L+a8WRcvXasYDyqcGEdW6b/Saz+GdvpjW/Ev/2nPNEb16dgFk0mg4UjWAEWLd0rXsEw==
X-Received: by 2002:a6b:bf81:: with SMTP id
 p123mr3230257iof.171.1643316701664;
        Thu, 27 Jan 2022 12:51:41 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id
 f2sm13152534ilu.79.2022.01.27.12.51.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:51:40 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3] knotty: improve the UI information
Date: Thu, 27 Jan 2022 15:51:38 -0500
Message-Id: <20220127205138.29159-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jan 2022 20:51:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13293

During a build you might end up with bitbake telling you:

	Currently 30 running tasks (2757 of 2757/3476 of 6390)

Which, to me, is really confusing. The forward slash separator and the two
numbers immediately on each side of which are likely to be interpreted as
being one unit (i.e. 2757/3476) but they're not. Also nothing is labeled,
leaving the user to wonder what these numbers are.

Add labels, spaces, etc. to help clarify the information bitbake is trying to
convey. The resulting line would appear as:

	30 running tasks (setscene:2757/2757 tasks:3476/6390)

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v2:
- update the "No currently running tasks" message to "No running tasks"
  (i.e. remove the word "currently") for consistency
- remove the double space between the two sets of values

changes since v1:
- improve the commit message
- remove the redundant word "Currently" in order to help keep the total
  line length manageable for users of 80-column terminals
---
 lib/bb/ui/knotty.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 484545a6..2404d996 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -276,11 +276,11 @@ class TerminalFilter(object):
             print(content)
         else:
             if self.quiet:
-                content = "Running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Running tasks (setscene:%s/%s tasks:%s/%s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             elif not len(activetasks):
-                content = "No currently running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "No running tasks (setscene:%s/%s tasks:%s/%s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             else:
-                content = "Currently %2s running tasks (%s of %s/%s of %s)" % (len(activetasks), self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "%2s running tasks (setscene:%s/%s tasks:%s/%s)" % (len(activetasks), self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
-- 
2.34.1.75.gabe6bb3905


