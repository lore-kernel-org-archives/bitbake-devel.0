Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CFEE6F081
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 10:18:13 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98151.1766485083185026949
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Dec 2025 02:18:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=t/y0WVTX;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-431048c4068so2701323f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 02:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766485081; x=1767089881; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TCkfCCZ9nEfkzPtpUEPMRRhVAly37SgIK5FMbNl/QTs=;
        b=t/y0WVTXKfLQ8aZykWqVp3b1gqyevUPeqbcH8B7OoUAKgUCiLhgJEk+Kwi9RgGQOxI
         NJ7QDLxnQXH8CR/QmLEZUy9v13Gm9k8g/o7YQVHKTrSMr3GfLkMRVql/02Ea0nw/fxKQ
         makK4m52rmlDLDZBvkMDN7DPxHk5WClR1PouY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485081; x=1767089881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCkfCCZ9nEfkzPtpUEPMRRhVAly37SgIK5FMbNl/QTs=;
        b=SGS0Ur9wv/FvEJIOUUjMaeh/yjNVwYSu3m4MJ/lBO8TwZo7JE4fgXtJzUvzLjSJvE0
         WvH3g+uJI39T303OR5x6Qpb2dm97Gt7tO4GPGDCCRM7yA0FZtCmLjHbV/j/vk0y8DUuL
         Pp0ggsRxVRaMC4bxjAS9GBueiJeEpP/oS1xbFjPnb5cRxZRwyIS7cZasrhI6hCbrG4Nv
         YlfNx/pNKOZhHDEuOKwtfarFlsrklDg5HxRm4g+DvRZ2JtxtYkgN0S3lccmhvOoV9B/5
         5SlHA+ix6JS3bVdf4GmE3z+RzF5psv2+TqmGyccWwT5RsxvwRTW1lK86NeHsfjXvV+tx
         Olzg==
X-Gm-Message-State: AOJu0Yxapoc4p0C9T2T9n7qwJ/TlSOITR79fVDKDfLUzZEd9wo21s+oG
	W/UuQ/nUWtHRp2bojCU/74mo26eKzod3oJN4BmEnjmLn/Mtv60XB42pVruO5+UPZDDDwS1rk6wA
	CUI53SbA=
X-Gm-Gg: AY/fxX58LXuSkV5cU5bn+Ja+x/T3rz7/8+0kIUYiUCyjVCiyC/CxafwEsHxgQOeMxFB
	95gTeweR/y8tdY80aHBkZ4oqId87Ve0ACT6MmkdAr0CNVxZ4YIT7lvp4pJy3DiVwEdReRp9kPjf
	cDZ5pMk9g/0pUlqTzrZ6KcZ0amNhjf34v8yswPpto2ormKwinkTpyztYGxAcZ3zi4oNMqSVdh03
	hpUammja2SJqkBkgWEvxeMv9D2xUm5SZbiZV9ppHSdhSpmX+xro0/gBnsG9c5vIONfR+cHoJ4UI
	KJeZXXKoOKkjOZEEaduoOdBN0y9fWrZVcxiU1tY4T4q7/HjFdKKpN/XJ+ZmCsPGPVRj//HPaxuZ
	W8WNJ7gDB/UDamFlZJgyoK7HjyuyyYvBoaJgiGwWMVIu8w8OPxsEgtfFItmcm1Y9Rnh09Pbq9Hh
	8qKC3W3FdCKQqp23E=
X-Google-Smtp-Source: AGHT+IFCzCpAEtPoBs4Ffpm+3dc2Z1tlbSGuKX9xVFhFQZ6L8D1pIG6NhK8eVru0cd1drcH4P/wTjg==
X-Received: by 2002:a05:6000:24c3:b0:431:1c7:f967 with SMTP id ffacd0b85a97d-4324e4172camr18456239f8f.17.1766485081476;
        Tue, 23 Dec 2025 02:18:01 -0800 (PST)
Received: from heaven ([2a01:e0a:25d:d2b0:4eb0:a6f9:d3f9:1686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm27428376f8f.38.2025.12.23.02.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:18:01 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v5 1/4] bitbake-setup: add inline URI
Date: Tue, 23 Dec 2025 11:17:53 +0100
Message-ID: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 10:18:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18643

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

Changes in v5:
- Fix variable mistake in are_layers_changed() function

 bin/bitbake-setup | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 73f734e73..d868d8a11 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -89,14 +89,30 @@ def _write_layer_list(dest, repodirs):
     with open(layers_f, 'w') as f:
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
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
 def checkout_layers(layers, layerdir, d):
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
@@ -600,10 +616,11 @@ def are_layers_changed(layers, layerdir, d):
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
@@ -614,7 +631,7 @@ def are_layers_changed(layers, layerdir, d):
             local_revision = rev_parse_result[0].strip()
             if upstream_revision != local_revision:
                 changed = True
-                logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
+                logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remote, os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
         return changed
 
     changed = False
-- 
2.51.0


