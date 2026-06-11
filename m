Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A66CD98D8
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:56 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45067.1781183509251983706
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=pXbChp8I;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef82204c6so4471233f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183508; x=1781788308; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bJTm+x7gsnTZIqc/fMU92sr9KNTqmmtFPtCs2sPVEo=;
        b=pXbChp8IJeGuL22/Qz5KCt0DtG/hC/nB8Jg6FzBW/enxQoIYEBmFhK3HFSlKD4RJXV
         hlcuxwQs0r0kHeAD8k8TDQ5bMZDNuZD2Yxfhjl/YD1/OD4DnR5a1DZsX5IxUE9gnFE9z
         L1B6QJgmYWWOew4Q3d0N+Y0vIZozGc3zDooKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183508; x=1781788308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1bJTm+x7gsnTZIqc/fMU92sr9KNTqmmtFPtCs2sPVEo=;
        b=NsHje1hU5crCHOOA1gRFzgAeU5jbDkfnPXNIJ77M95C0YYIhRJN5o5flNj0WeePWHI
         gmSu61RXg12D75CUmU+IAF+Gmv8EcvovKsEmpooIIkmi4JcazmFpMtiKfiRCrku/gzPt
         o0mbt1GSk9jUg/C8Z+lGUf46AiRJsjwTHCukE1cgXXrT/+vuHxeHAoY9otPDZu4Nj80K
         b5RcM85bHUz9JcabjRHwTIMBxgMyFxEshfXjRrDVBdMEcIKo6iZgYYjeXGkhtzZ/3rAg
         P35EMvSpHyJPap7hGTzU9R9diIW5CWqJ19xUFd69+9TdUAjYUy25VFU0q7fHUzx52t5t
         sCiw==
X-Gm-Message-State: AOJu0Yw5WTflLwJeNhPYwxLMFzFW68ZyEL1thxuJSnuiH/UM+U7gaaSr
	sxC7UZupP8VGOSp0dWMo/gs8OX/GHFA1r5Vo322rwp67kVPJIDMFb+HewYphx8thck5x+GL0cq+
	aDPei
X-Gm-Gg: Acq92OHk3FWC8HmPWLsYtQqvjaEvdMhBUWxhU3jkNvkzKIqEYQpDVqcs4SYMgvash84
	i+JQoCoqV7O7SKtZlRkUXNk0unh73y67BU7qjV5BJ+pgSmNXw7KRMFR6QEgNKJ0/k7yM+VLDxBG
	lfGp4OSGRBLTemBfd2JBqsGJOcnirNwU/pjuPI/2fhDu0dVMF+cX7l87QoonkUtZ1gjfmmTtpnj
	7t29/hH3Yopr++qt8v93a7nxa7Pngmu63/5uJxJ3UHdGfhx7GfzeRXOa/R74UPm78gnS9efT0R2
	Y0N1Ahi8AaN1bN5+C+X4GztyIGeHuiQkX5cjUgKZgnyEQIVpUQ2jWg9QU+ddED3e97h5BU1Y/gS
	0Jj+rodf+koUu4E/NuqNLG0iCfe4koN3c7JiVE05PoQuhMvgafLEn5kw6BnncuhLWpzA+pcVHW8
	8LD6UWl2gTWusrXagNgOsneFEZAtmenCq/LhdkBz3U73487m3Bj64AM3Z0V+x040WR1gXvRqWn2
	FeqW5lfPE92LSMAdyvgCI0jijSE5CIs9MaPSpkLlFbRiZs4cQ==
X-Received: by 2002:a05:6000:2993:10b0:45f:f142:d571 with SMTP id ffacd0b85a97d-46067475b65mr3234677f8f.13.1781183507576;
        Thu, 11 Jun 2026 06:11:47 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:47 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 2/8] bitbake: fix issue with varflag exclusion
Date: Thu, 11 Jun 2026 15:11:24 +0200
Message-ID: <ddb97b7c5e40bf4f375f2dcf46ceb9f36e7b1584.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19662

From: Marcio Henriques <marciohenriques84@gmail.com>

This patch fixes an issue when checking if a varflag
can be safely excluded.

BB_SIGNATURE_EXCLUDE_FLAGS lists variable flags that
can be safely excluded from checksum and dependency
data for keys in the datastore.

When bitbake checks if a varflag must be excluded it
checks if the varflag name is part of the string stored
in BB_SIGNATURE_EXCLUDE_FLAGS.

As an example, if the varflag 'filename' is in
BB_SIGNATURE_EXCLUDE_FLAGS, the varflag 'name'
will also be excluded because the check will return 'True'
when checking if the varflag is part of the string with
the varflags to exclude.

To fix this issue the string from BB_SIGNATURE_EXCLUDE_FLAGS
is converted to a list before checking if a varflag is part of it.

Signed-off-by: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8ab71d0ce302521da6a7e18c887cd85d9a94e8ee)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 5fdcdb04a..b12972c03 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -378,7 +378,7 @@ def generate_dependencies(d, ignored_vars):
     mod_funcs = set(bb.codeparser.modulecode_deps.keys())
     keys = set(key for key in d if not key.startswith("__")) | mod_funcs
     shelldeps = set(key for key in d.getVar("__exportlist", False) if bb.utils.to_boolean(d.getVarFlag(key, "export")) and not bb.utils.to_boolean(d.getVarFlag(key, "unexport")))
-    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
+    varflagsexcl = (d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS') or "").split()
 
     codeparserd = d.createCopy()
     for forced in (d.getVar('BB_HASH_CODEPARSER_VALS') or "").split():

