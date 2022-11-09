Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6333C4321E
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 14:30:00 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web09.3947.1668004197424767315
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Nov 2022 06:29:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=PsBVHPS8;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.179, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f179.google.com with SMTP id i3so16822604pfc.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 06:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6himniHtQZwjP++OVwDsJa68gFBfVXk+0BkJEQBHiz8=;
        b=PsBVHPS8+X9gM9HWJPw6kmNlTfC6fsLi1yQNo74fVydRUil8b7YxUwnUgvwkgel+zn
         yMqcRAeszbec2o+uEgqqIVYOaceeeRHzsmaqz3JsV3C8BMqmXR0ea+pKGM2J/2X6+Pdp
         CqIg8dxz6AXBvA8dESuRAFHdyDwgU+l3i+5aZEfCGWMDMBlc7fVdV5r64ctI6l2YKyP0
         d1euikpDgBLG5HlSU/qDLRjF1hQByOEK2ewf8Vt/JSTubl1bG4itT1EbOLAM7bA9SkqN
         1DHPZfNd8c9JD/X9/yw2YI8r+0VELzWtPUIiczcf8bI5HSGYAGRKaZkTSaY1jjOU146z
         6jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6himniHtQZwjP++OVwDsJa68gFBfVXk+0BkJEQBHiz8=;
        b=xcpwjMfz/IrEc1+nc1yJB7MHyI+pjTEjrP/m/LVx1Y4B8hRwWci94KyZ5Q9hp6noRF
         w/dD8TyJjM219dUfFr15ouflggklOpTGZtfM9QA0xk1c0PbbBYfYCioFYmgIUA+X8rbF
         xNgXjlUBu4NE2I2P5KQfH34C2K+BrOXs70ooco1hXmCRCBZyErI4PxDSYhG1o7FtH9Ep
         SAXVblMo4B9r3/4OeFeqEXZ2fwWewwUOu5CiFe3ihleeS8epViG4EmPvnlYAT7gbMvF1
         lDySOdyjISKnpNXQW8zQzrjZVSIzD6ebCdHvszGzmGgWUXpu+IVu71q/3m4Hbhj0wpyH
         nzhw==
X-Gm-Message-State: ACrzQf1oTDOeLdhVfYcK4C9RioDrYYZg4PVBDHcnwG6v5bV3jbiiShw4
	/W8+nfiprEtbehxUnoHSJb/8KAGyemoPS5HU
X-Google-Smtp-Source: AMsMyM61jnZCxNk80UcAwE7RlshT6sdXUPMwtT6neOy3ELZ4KgaER9Dqa2+95YKxBAL5PNSJ3+/97g==
X-Received: by 2002:a63:fc0b:0:b0:46f:87a8:97aa with SMTP id j11-20020a63fc0b000000b0046f87a897aamr51372345pgi.234.1668004196526;
        Wed, 09 Nov 2022 06:29:56 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id nn14-20020a17090b38ce00b00213d28a6dedsm1308611pjb.13.2022.11.09.06.29.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:29:56 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 4/4] bitbake: bitbake-layers: checkout layer(s) branch when clone exists
Date: Wed,  9 Nov 2022 04:29:36 -1000
Message-Id: <42d63b381a60c217145dc2fdba47eaf02c893f3e.1668003926.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668003926.git.steve@sakoman.com>
References: <cover.1668003926.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 14:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14065

From: Mark Asselstine <mark.asselstine@windriver.com>

[YOCTO #7852]

Fixes 'bitbake-layers layerindex-fetch --branch kirkstone meta-arm'
not checking out the branch if the repo is already cloned and on a
different branch.

If a clone of a layer being added already exists check what branch it
is on and if necessary attempt to switch to the given branch. If the
switch fails to happen the git error will be reported. We also warn if
there are uncommitted changes as the changes might go unnoticed and
result in unexpected behaviors.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d2cb388f58a37db2149fad34e4572d954e6e5441)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bblayers/layerindex.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 0ac8fd2e..ba91fac6 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -49,6 +49,31 @@ class LayerIndexPlugin(ActionPlugin):
             else:
                 logger.plain("Repository %s needs to be fetched" % url)
                 return subdir, layername, layerdir
+        elif os.path.exists(repodir) and branch:
+            """
+            If the repo is already cloned, ensure it is on the correct branch,
+            switching branches if necessary and possible.
+            """
+            base_cmd = ['git', '--git-dir=%s/.git' % repodir, '--work-tree=%s' % repodir]
+            cmd = base_cmd + ['branch']
+            completed_proc = subprocess.run(cmd, text=True, capture_output=True)
+            if completed_proc.returncode:
+                logger.error("Unable to validate repo %s (%s)" % (repodir, stderr))
+                return None, None, None
+            else:
+                if branch != completed_proc.stdout[2:-1]:
+                    cmd = base_cmd + ['status', '--short']
+                    completed_proc = subprocess.run(cmd, text=True, capture_output=True)
+                    if completed_proc.stdout.count('\n') != 0:
+                        logger.warning("There are uncommitted changes in repo %s" % repodir)
+                    cmd = base_cmd + ['checkout', branch]
+                    completed_proc = subprocess.run(cmd, text=True, capture_output=True)
+                    if completed_proc.returncode:
+                        # Could be due to original shallow clone on a different branch for example
+                        logger.error("Unable to automatically switch %s to desired branch '%s' (%s)"
+                                     % (repodir, branch, completed_proc.stderr))
+                        return None, None, None
+            return subdir, layername, layerdir
         elif os.path.exists(layerdir):
             return subdir, layername, layerdir
         else:
-- 
2.25.1


