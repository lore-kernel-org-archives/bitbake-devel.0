Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB80D7879A
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:13:10 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20251.1766160782173400084
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 08:13:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=mUGdDWQw;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477aa218f20so12953345e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766160780; x=1766765580; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjRy5tZso9UuF28Ax1i5OBiNUaO/2m5T6L/sZvQuwQg=;
        b=mUGdDWQwsL4ZrenCy0bFUR9awfmJoMAvpSaZVu10DYqU4IcKpSlxdSNTvDsq4b1JAK
         P0tyq6prQ6K2uImlf0jVyiJdfU33DH0g0N+85BsnADv6duxWv/T8McbxHlNvcxo2kV/6
         R4gL7bBvK8TsqV1YSIWLEJwa/BbTulq2dsN+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160780; x=1766765580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjRy5tZso9UuF28Ax1i5OBiNUaO/2m5T6L/sZvQuwQg=;
        b=vLZ+l75dolnXGYpbidCJeEWnykVbv17sGaKXyhlRdH+wH5JNMq5L+jHqUlLStunPnO
         /xrJWiPvVQ/yqHi85eWE5TyM+a8y35bpf5PCtpIaOfKlKdUi1cVePOsC1ka4bk5+4Ezs
         o7nKZInIkSxbGxGzg9ycAuAzzCxSBmOJkUHiBndjsC0N4lst+s+iqBqUgzxxEqCZK9wO
         jF7zQ/yuhgEDYhlNFr3vP2CrvUhCc6niiSDZ6pC/ABafslfJ+FRYK0Yk7L1v9s+TauDD
         El8rnlECNS5tRExZdgiZFEs9YEo3B37P2LM+7Yq6bspDUihFMc+LEV6aoJCYo8hqUIFS
         Eriw==
X-Gm-Message-State: AOJu0YyLaCLtsAoTwecmTrAa3FO9ImAqoA9FSU/4yNbMPZejFSGyY6Do
	0cYeExKF+3LbzgSj40rMRC5ExP98H0cJdfkUNCg9JuvBmCHuFa0PHgDrrhFS0MFRTmjggtTPL/Y
	qUZ1DPHQ=
X-Gm-Gg: AY/fxX7WDMgJi7h8FQR6LLei+c60Sl0MMze6Na2spV0MBInl/HalR7uxESurD++mil8
	9l1QkGNSAC/JGqbGPxUuGGuj3zmrXDDevU30G4vGvTtEPIyL9A1P5m7j75I826dQz+gxPvdPfcT
	UsNg6hymjEkJhwlQY5iRGlGomCpBe5G69622eaDqRcJf4EsiGkTwLqUQPqtQ0L0EGOxdy+77rdZ
	XnNiJ649hA1wUdcdemBYKLs3u95VRu6x4dXF+TT/wHrlNPHnWnHEylb4cyulb9JGik1SUrIzt0h
	W+QzvPSt+Lqn6IWusLX5FQ28uzZ2ttjClIqQzzpB3tPeNvCvLXiwIWe+r+3GY5zZ5cQE+bplsDz
	TsO692EhCB9GMBwV03HoHC2L0QA2zQokE93d3yPKKnYk+U50P6feitjPahXp5BGLlpDKzgFEKwJ
	2aMl3QeIYxi9qHpQAIFzYcjqq0y+AoWgmHrrLUZqilJ7BXz1JURMWaj/WN4FaFnpKV2oSi0KiKI
	0FOlJIHi6LE9HHOttE=
X-Google-Smtp-Source: AGHT+IFBQChDBj02LKcwNek1D6j22t3xkieustZjTGb7irWQDWmmvaVt9+eFzxHOKlFMKbTAd9JW+w==
X-Received: by 2002:a05:600c:154b:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-47d1958e7b9mr32151735e9.35.1766160780516;
        Fri, 19 Dec 2025 08:13:00 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm105391065e9.7.2025.12.19.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:13:00 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v4 1/4] bitbake-setup: add inline URI
Date: Fri, 19 Dec 2025 17:12:52 +0100
Message-ID: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 16:13:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18624

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

Changes in v4:
- Fix a wrong indentation in the file bitbake-user-manual-environment-setup.rst

 bin/bitbake-setup | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 73f734e73..809077518 100755
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
@@ -600,7 +616,8 @@ def are_layers_changed(layers, layerdir, d):
         changed = False
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         for remote in remotes:
             type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
-- 
2.51.0


