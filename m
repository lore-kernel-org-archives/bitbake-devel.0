Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CAC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 11:07:54 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.9161.1742296067572189033
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 04:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E81pfvFQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390f5f48eafso3452391f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742296065; x=1742900865; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tG9hC+gDnXm4SIyWQi6bNG6+PzvzfRyqQTnUDTU5u+A=;
        b=E81pfvFQPWcZNmjP60GsV6t+cUoebHnekvpfikacPWAxdCIomOtTkKTtRG2ZFz7ggD
         Syis8SIeyRovjPI6cUf8W/r9cEruWfxfskDmxovbQxma5Yt0hWdpr3/ZzbtutyaOcsT+
         Xz7lCZ7H7CrAmUK0rkMSqPQPcPXY1GpROm/X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742296065; x=1742900865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tG9hC+gDnXm4SIyWQi6bNG6+PzvzfRyqQTnUDTU5u+A=;
        b=F+itnn4IqSXM5EYkmAR0HtQuQ/Iq5Jgp4AnJ7l6+Pfd0/B1binONd9V5zCYDz6G2py
         ZjnozRZDjzS8HX+nPrYF8PM67jUisybytR5jViRe75W1/u14ty0hrSsbMrYpGgAkcXHk
         aLpAw62krBpkQgOFK+zhcdfeSq1cAoGrrOh7XdWgrLjn9xQEk+HLrFLFDAyHcF85anqk
         WIrWX8C6SvWwZB1PA4NjvnfDoviYait8zdFwxVaQaXBoX8NHxFmGsPbCNER+dqfDdo0L
         oUA1UZCjuEGVcm1UYQgr99w7K3SkVfVDhBbBy/enFlWiwVOMmcKpcSbwMjpfxI+hdx4F
         Ydbw==
X-Gm-Message-State: AOJu0YzWNsqUxWBi7en5IXSJugfXIHkVf8qNPbU9T1I5EQVZbhuU4F2P
	2l6jifEXW92ernKIxF06VNK8JFZVid4RqHcE3uzJ21veEc7TS5u46c/qbtoFv8FD5Zx32m9s+g3
	P
X-Gm-Gg: ASbGncuxd4uk7jq3LCntWv4Yb98/mxW5SGXdGcUmAYoSffsz5Me3y667/xl4t0T6VHS
	/JvLaIVGLdB61TctbrhrePF1Pmc4Ibzq2sCqv0ZkUd6FC4+ejVZeK+SPXaM7mAbJN6Q5I4kq8DO
	fhuvER7CfJNH/DxAFPOQ9F84eaZSYcqJWQoUL8iSuM+CjRzZSlLa+kvfMoIZKJVZem1bPiMoSK5
	iRiOC3NkIy4Pz7NIDL8VTzFmBR8QFnG52B4RfEmfzqcYl94EAzXo7MIDW+ebghf7qtnKfiGxVk2
	WOvK5XL76B9SmtU6eCtaz7S9sjB7CRHpy+jtkLHUWDgdfvT0PSxIbqAP5sznn4JHYjgUM3ENWw=
	=
X-Google-Smtp-Source: AGHT+IG9Ycyk1zkQ8HW6R/I1KF9+TVgd/Va568dyIFjCcfSXJ1rUOV1Z+bGiQFLUTlRAYi9uSRTzaQ==
X-Received: by 2002:adf:9b9d:0:b0:391:492a:c9c2 with SMTP id ffacd0b85a97d-3996b46895bmr2481766f8f.33.1742296065267;
        Tue, 18 Mar 2025 04:07:45 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:791f:f4e7:28a8:7096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975f33sm18210945f8f.58.2025.03.18.04.07.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:07:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/get: Rework tag parameter handling
Date: Tue, 18 Mar 2025 11:07:43 +0000
Message-ID: <20250318110743.3936601-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 11:07:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17451

Currently bitbake disallows tag parameters along with revision parameters.
This isn't great since quite often, we'd like to verify that a given revision
does match some tag. At the same time we don't want to or need to access
the network to verify this, which normally a tag would require.

Rework the code so that tag and revisions can both be specified together.
Verify that any tag specified matches the revision in use at unpack time.

This means we can start requiring people to put tags in git SRC_URIs
when revisions are used, making review a little easier that it isn't
some random revision.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 13 +++++--------
 lib/bb/fetch2/git.py      | 12 ++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5aa67accc3..cfbbce5288 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1248,20 +1248,17 @@ def srcrev_internal_helper(ud, d, name):
         if srcrev and srcrev != "INVALID":
             break
 
-    if 'rev' in ud.parm and 'tag' in ud.parm:
-        raise FetchError("Please specify a ;rev= parameter or a ;tag= parameter in the url %s but not both." % (ud.url))
-
-    if 'rev' in ud.parm or 'tag' in ud.parm:
-        if 'rev' in ud.parm:
-            parmrev = ud.parm['rev']
-        else:
-            parmrev = ud.parm['tag']
+    if 'rev' in ud.parm:
+        parmrev = ud.parm['rev']
         if srcrev == "INVALID" or not srcrev:
             return parmrev
         if srcrev != parmrev:
             raise FetchError("Conflicting revisions (%s from SRCREV and %s from the url) found, please specify one valid value" % (srcrev, parmrev))
         return parmrev
 
+    if 'tag' in ud.parm and (srcrev == "INVALID" or not srcrev):
+        return ud.parm['tag']
+
     if srcrev == "INVALID" or not srcrev:
         raise FetchError("Please set a valid SRCREV for url %s (possible key names are %s, or use a ;rev=X URL parameter)" % (str(attempts), ud.url), ud.url)
     if srcrev == "AUTOINC":
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index a73fb79ac8..53fdc4c3df 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -279,6 +279,10 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
+        if 'tag' in ud.parm:
+            if len(ud.revisions) != 1:
+                raise bb.fetch2.ParameterError("Git fetcher support for multiple tagged revisions not implemented", ud.url)
+
         gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
@@ -747,6 +751,14 @@ class Git(FetchMethod):
         if not source_found:
             raise bb.fetch2.UnpackError("No up to date source found: " + "; ".join(source_error), ud.url)
 
+        # If there is a tag parameter in the url and we also have a fixed srcrev, check the tag
+        # matches the revision
+        if 'tag' in ud.parm and sha1_re.match(ud.revision):
+            output = runfetchcmd("%s rev-list -n 1 %s" % (ud.basecmd, ud.parm['tag']), d, workdir=destdir)
+            output = output.strip()
+            if output != ud.revision:
+                raise bb.fetch2.FetchError("The revision the git tag '%s' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag'], output, ud.revision), ud.url)
+
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=destdir)
 

