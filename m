Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48739D77897
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 17:24:39 +0000 (UTC)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.640.1769189070501052049
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 09:24:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=PLuzsoa2;
 spf=pass (domain: smile.fr, ip: 209.85.221.68, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43590777e22so1500020f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769189069; x=1769793869; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZR7a6GLkW7V1+r1XxllDy0CCArUN82Ge0HkOFpObsA=;
        b=PLuzsoa2mi72ADyIhSVgEXbYm/kpOM+vOzy8zntDEV4gh4wYXTas49HqlqN3hlvUWs
         2bY5JwB7G+kL8/BjwK2hcEqwCQ/e2uQ2Ii4+jR2N+ET7H4EMHtHp0IZ3bmE/T4yep614
         u8yPwRTtFHx3B4FbA2TSHF4f2LSCVvoo8P6Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189069; x=1769793869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZR7a6GLkW7V1+r1XxllDy0CCArUN82Ge0HkOFpObsA=;
        b=CnDa1nsKGYUb6zlPxto1kre4p6QnZIsA2u4hz70Lv6XnY5WTTiPAWZkYJzc0O9B+gk
         WZbhYLG5ZFAnyJ/LY2jiKXnHHiYtGBQwwjLx2jrnOyb3pdBDQkTSH7t+7LaVCFBVCyji
         QBVvDiA47nz7EjFINfqhe3aJjHb/4tykozbuNFDPEEqvPWkZuHOEmAq02p+Le87rWdaZ
         VJ8HbNZ6S81I++RIJ4AaV9YpXC3+A4kQV//d7GXhWHbRm9yxgqNfW3dFRBj2HvMF2IB5
         m3w3mIoQ0RJuZFcfN8S6JJx4pcqMf6Ig71YZaCGnBHl4/SUahKKFpvxJHLIIw4/uydpE
         8U8A==
X-Gm-Message-State: AOJu0YxOkhXoabtbNuZDHivqJ2cwKr0Huc5pPB6poAaYSt/ErBj2PgZq
	K520tF7+izvi4a3wWsEjKAmKul8Owj/9DmoAS1A/T29+Wjjr0fGZKhcppHqe2PUUuVk1eiSxSKm
	/no1RICWeFw==
X-Gm-Gg: AZuq6aIU7zGS2ES0CKz30FjY2QjGG+QQByyX3IM27DulESy1mopdvnVM1yqiWJxdcN3
	M4TM0XctQhkIeLPBWiNxZhD7HJnyhrdSeAEYz0fQ5QkdRBb7GZVOxErVKHnDf/Sf0iFkrxRaj3Q
	GIBk92YtYeSkwFD7prfaKmNBVUaItIn1ViyY6m7acLnjiFGEmmb7wDNWDMkKZw91mB81yt/tp/S
	9qj11p1nMRjVVMb3viFgNYvQLkr6sjn253G//KbpzZ2lrR9af/UF9sMQekqohuFzDII6iVeQMv4
	G8d9ax4NV8M1ess3noQCvILZsrz7SiQ1cL119E4+wtvUo0HsarV7jOyqv0MkLKOqhEkzAL+lsk2
	80JubxwL5PqGVtHgj4LUvoSlnTuq+qwW0rRU1bOhZm+r5uESzrco4tLFyQaUUjOx51y5N/rFxu7
	/E/TGIf/7ez5ciiSEavtdVx3QaVHqMb7RTupId0cvRgbngZbGX0WEh3aaxctO48dS/tnR+A+E12
	HvHIMj6rdURGjjwEC8PfZPXieouSOo=
X-Received: by 2002:a05:6000:288c:b0:431:a0:7dea with SMTP id ffacd0b85a97d-435b1604d56mr6413746f8f.40.1769189068723;
        Fri, 23 Jan 2026 09:24:28 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715bfsm8664209f8f.22.2026.01.23.09.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:24:28 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v6 4/4] doc/bitbake-setup: document "uri" property
Date: Fri, 23 Jan 2026 18:24:22 +0100
Message-ID: <20260123172422.3304682-4-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
References: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 17:24:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18867

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


