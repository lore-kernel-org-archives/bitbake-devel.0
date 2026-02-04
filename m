Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12289E95383
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 11:11:07 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18125.1770203459330977826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 03:10:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=y8et/jXf;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee0291921so63526985e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 03:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770203458; x=1770808258; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma03IDftDXbo0wfCkLZCl/1blExcGHl59LCSMF5+ErY=;
        b=y8et/jXfZuNMTRWGnJkr3SJ5AnLJRWNshxvgrgrGUVGtMLkTcZSP969mbrpCqhUoFn
         bv6Yzi9wmN0EzO90dDWaoYWo9vabWATkpwnj2uUdLAZCXZC6ApUsm6FuDHVGyN9FgNmC
         WCdOJZsFhk9V+o9asaZGwqpu7ne4XJNEYhbHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203458; x=1770808258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma03IDftDXbo0wfCkLZCl/1blExcGHl59LCSMF5+ErY=;
        b=lr+XfyDv2Sad+nAt6vAAlfaDYHSjdw83VxhMW01/mL+diHpFuiKd2cgqQb5flmSFCv
         ylLntn1tMNXmlqmSqhn/DrpJziKxxyvnj+3WreT005EMw0mw6wAMRhH27mk9mNbgDbWX
         SFTJ+ae6xr0Y3MQw3vWpSWEr8lo1qDdgj8Chvk6ko1/3qJDJP/Fp3WoWCZIehX3TM55e
         omklHYAZRAZDjk7vhvsHJBRLgKX9kijWq7S8GLh0WV3C5iwt7lozNjoy9Rehxtn8Hmfp
         fo+dOPQDSk9iHUUIxrpN01eiacnUoOGcWE9VdXNV1WDK+oP2xTCbEMhDXL+VSuY9UfLU
         sdtA==
X-Gm-Message-State: AOJu0YzLVpoGy6dUNVYqn/y5Y4GTo/XrBo4uLVJE0m/Z9/k79wxrkytr
	E/oqOc27H7OQlRkKpr8E7EyzyvqoKOKFE/J7Hwv4lw4pontp6NO5wLDKd5krZhi/L+Yfm8KxUcB
	sHLBM
X-Gm-Gg: AZuq6aJ4t/lqTE9jXyAuTH/+PxLE/xDca2jHC1uSSf2PRwselvmHgpVwCEOFCIIsVka
	GwQM6F4hvnXrTyXdOu2pN5wGccZXf6JIVLuCFNQ7Y332ZK1W8bmzT/BGwin0MO1FQVrNhVnaooj
	fTxRj/e64RsQKQlmZnzz7qCtpya8yMd7WW3/iTtz158EL1fTOgmBh7bFtknopokHlOmtIXBoKsq
	ryvq2E3fXOkZF3AH4SzmMwvV6QK6Iq1Tu5+Exaljp938JLbe/08W1fGEnCjXAlTW6MyoKl00ehQ
	hCrqFVllrf3gWYS5084G1BqQcdLPRp6/wwvshjaEKgiWLOcWPZAA+Jyooi+qKnByDVgzSvB29kj
	8BrpzF7APD25Fyy+Lx5JrQHJGEJBu+tkG/sOWZUdT4ChTL9vtOAiJiGRPXsIylBGRynrwjnbUrQ
	OX/UoYZdtE2wurM/Wbp4SL
X-Received: by 2002:a05:600c:848a:b0:480:1a9a:e571 with SMTP id 5b1f17b1804b1-4830e968f26mr38720855e9.22.1770203457528;
        Wed, 04 Feb 2026 03:10:57 -0800 (PST)
Received: from heaven.lan ([2001:861:3080:b0f0:481f:fde1:912:228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fc0a3bbsm28824395e9.1.2026.02.04.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:10:57 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v7 1/4] bitbake-setup: add inline URI
Date: Wed,  4 Feb 2026 12:10:48 +0100
Message-ID: <20260204111051.1444641-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 11:11:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18950

Most of the time, when we describe a remote, a bitbake-setup source looks like this:

"bitbake": {
    "git-remote": {
        "remotes": {
            "origin": {
                "uri": "https://git.openembedded.org/bitbake"
            }
        },
        ...
    }
}

i.e. an URI with the common name 'origin'. Alternatively, we could simplify this, by
using a shorter structure with the property 'uri' only:

"bitbake": {
    "git-remote": {
        "uri": "https://git.openembedded.org/bitbake",
        ...
    }
}

These properties can be used together.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---

Notes:
    Changes in v7:
    - Non-master configuration files in default-registry/configurations/*.conf.json removed

 bin/bitbake-setup | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..f126b1560 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -104,14 +104,30 @@ def add_unique_timestamp_to_path(path):
                 break
     return path_unique
 
+def _get_remotes(r_remote):
+    remotes = []
+
+    if not 'remotes' in r_remote and not 'uri' in r_remote:
+        raise Exception("Expected key(s): 'remotes', 'uri'")
+
+    if 'remotes' in r_remote:
+        for remote in r_remote['remotes']:
+            remotes.append(r_remote['remotes'][remote]['uri'])
+
+    if 'uri' in r_remote:
+        remotes.append(r_remote['uri'])
+
+    return remotes
+
 def checkout_layers(layers, confdir, layerdir, d):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         for remote in remotes:
-            prot,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
+            prot,host,path,user,pswd,params = bb.fetch.decodeurl(remote)
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
             logger.plain("    {}".format(r_name))
             if branch:
@@ -658,10 +674,11 @@ def are_layers_changed(layers, layerdir, d):
         changed = False
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         for remote in remotes:
-            type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
+            type,host,path,user,pswd,params = bb.fetch.decodeurl(remote)
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
             if branch:
                 fetcher = bb.fetch.FetchData("{};protocol={};rev={};branch={};destsuffix={}".format(fetchuri,type,rev,branch,repodir), d)
@@ -672,7 +689,7 @@ def are_layers_changed(layers, layerdir, d):
             local_revision = rev_parse_result[0].strip()
             if upstream_revision != local_revision:
                 changed = True
-                logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
+                logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remote, os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
         return changed
 
     changed = False
-- 
2.51.0


