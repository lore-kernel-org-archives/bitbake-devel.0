Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA58FE95386
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 11:11:16 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18131.1770203470893609900
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 03:11:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=msTHMLKQ;
 spf=pass (domain: smile.fr, ip: 209.85.128.65, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4806bf03573so33199455e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 03:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770203469; x=1770808269; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZR7a6GLkW7V1+r1XxllDy0CCArUN82Ge0HkOFpObsA=;
        b=msTHMLKQAfYpCAOAD5GRAKvEON7bwt7aLGbtOygckEhbtK5li/pxx4SupJJE5hkIqX
         4+gpK+go1GtGVC2fTAAE3EhRLXchxqT+JZS9pG/5OXy0bgCoeZW9VY1ase6WCHHry1U3
         m6i1/VcS4LBaBKQAvXXnwfkKFBWtg+uVK3C7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203469; x=1770808269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZR7a6GLkW7V1+r1XxllDy0CCArUN82Ge0HkOFpObsA=;
        b=BqIYv8j1q94SuMaTyTEpBh0OPfvaoAIGGuDtId+O7/9h0AV4sNlLYCjJXtjPiRINe4
         XNBIEAIoYvmqwORYT67loFUhE7Ne6ZhkZ7VBZDoeb1OD3vFL6xd4wZRO4eE2woNQFSyB
         97yca4fVrUE8du+A5QXub2vRcY8tQ+KfAt1+Xi19aabAULlJzfWIb88RbiiSpSbWCr+l
         6OTVbqtim+O/hQc69ojQUTsmDaEBsuLNjQOa6zhTnLxX6mmU0sUummHXDX9gSw1aGB0g
         jk4fRYn1szr7/vC1mUseiBWHPTyByBKt5M5A6Rl01uCRdRHVdj6Zpsy+/4wAcd7q/bSi
         bpWw==
X-Gm-Message-State: AOJu0YzIk4Ssc9sKWI/xA4FMfvPwiBZeyUgB4BpvAArKtrpG+A0efjBS
	xRykYFx5EScMhjUjRToD8Hb+XqJp1rPI+oDYaPx2N+WONxzvRRZXcoyXUDMeEQW/yQ0GILAvCLE
	FsJzdVrY=
X-Gm-Gg: AZuq6aJPWEn/xB7wEnX2OZPVekfM1yefBoCfhaup1lK8jO5VbPBM0dtK0aEegSGpcN4
	QO7swkUeR18MRAkuDGTB+YQU07+oofJtcAewmvmL4OA69225+vUCO64k3umKxJ9FtiA+l14pu8R
	pdncPQhNp1Jj9ZGk75s19SbEPBwKTwtI2c+KQQbWUtliL2nmPcrcGeZvMKkqAG1r5uZro2n+tNW
	uUTOmHfjr0vGZgE6f4y3cynEBpCKb4YvMjHaVpFjYjqRam6Q8XcU1FG9DRs7v08+JvcokNvbayQ
	RVIybuWmzw6pslqd4NJUcQgCSJEza0xZ/LbeSlJhJjQrERxWVj+w0wpfW46TwKkat9X8rb0hoyM
	wAXpc/O8lGUqGnWEzMPMlsTzOpL6PaqpVu4k39KAO5CjpToioICRncCU8bJWSOvVBlr9Y5UgTr7
	7jYKj+rwOiY+LdZWQFSlHw
X-Received: by 2002:a05:600c:a03:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-4830e991bf6mr32653165e9.29.1770203469191;
        Wed, 04 Feb 2026 03:11:09 -0800 (PST)
Received: from heaven.lan ([2001:861:3080:b0f0:481f:fde1:912:228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fc0a3bbsm28824395e9.1.2026.02.04.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:11:08 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v7 4/4] doc/bitbake-setup: document "uri" property
Date: Wed,  4 Feb 2026 12:10:51 +0100
Message-ID: <20260204111051.1444641-4-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204111051.1444641-1-corentin.guillevic@smile.fr>
References: <20260204111051.1444641-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 11:11:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18953

The property 'uri' is a simplification of the property 'remotes'. It is
used to provide only one URI.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../bitbake-user-manual-environment-setup.rst | 42 ++++++++++++++++---
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 3b6a73fd8..d20ddcaea 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -673,11 +673,7 @@ They contain the following sections:
          "sources": {
              "bitbake": {
                  "git-remote": {
-                     "remotes": {
-                         "origin": {
-                             "uri": "https://git.openembedded.org/bitbake"
-                         }
-                     },
+                     "uri": "https://git.openembedded.org/bitbake",
                      "branch": "master",
                      "rev": "master"
                  },
@@ -714,10 +710,38 @@ They contain the following sections:
 
       ``git-remote`` entries are specified with the following options:
 
-      -  ``remotes`` (**required**): a dictionary of git remote names, each containing a ``uri`` property
+      -  ``remotes`` (*optional*): a dictionary of git remote names, each containing a ``uri`` property
          with a URI that follows the git URI syntax. See https://git-scm.com/docs/git-clone#_git_urls
          and https://git-scm.com/docs/git-remote for more information.
 
+         This structure is useful if you want to provide several remotes. Please
+         note that each URI will be cloned, but only the the last treated one
+         will be used in the unpacked source.
+
+         Example:
+
+         .. code-block:: json
+            :force:
+
+            {
+               "sources": {
+                   "bitbake": {
+                       "git-remote": {
+                           "remotes": {
+                               "origin": {
+                                   "uri": "https://git.openembedded.org/bitbake"
+                               },
+                               "contrib": {
+                                   "uri": "https://git.openembedded.org/bitbake-contrib"
+                               }
+                           },
+                           "branch": "master",
+                           "rev": "master"
+                       },
+                       "path": "bitbake"
+                   }
+               }
+            }
       -  ``rev`` (**required**): the revision to checkout. Can be the name of the
          branch to checkout on the latest revision of the specified ``branch``.
 
@@ -728,6 +752,12 @@ They contain the following sections:
       -  ``branch`` (**required**): the Git branch, used to check that the
          specified ``rev`` is indeed on that branch.
 
+      -  ``uri`` (*optional*): a URI that follows the git URI syntax. You can replace
+         the ``remotes`` structure if only one URI is provided. Despite this, ``uri``
+         and ``remotes`` can still be used together.
+
+         See https://git-scm.com/docs/git-clone#_git_urls for more information.
+
    -  ``local`` (*optional*): specifies a path on local disk that should be symlinked
       to under ``layers/``. This is useful for local development, where some layer
       or other component used in a build is managed separately, but should still be
-- 
2.51.0


