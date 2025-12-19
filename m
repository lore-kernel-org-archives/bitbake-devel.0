Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58BD767F2
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:43:18 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15100.1766144591617085118
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 03:43:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jxi6SeV4;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so11248115e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 03:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766144590; x=1766749390; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=riGC5pNkOfBd8/xW3q2WWIu1zJ70mMg2V3Q1M9KiEQo=;
        b=jxi6SeV4p7dtUjnesPDKlQYkVt09wn+y2MPSoHtWGgSJNUY1ooKywl1UgZjE+6tfEp
         lWqb4sOBTw/e6295H23EYefq0fOh/81/k+agFOkX3vRk7UXtdQfZjXIyU6g/z5FswnS8
         q3+jGOYrGao8anQs8lqjK8FZDt01xhf57nGRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144590; x=1766749390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riGC5pNkOfBd8/xW3q2WWIu1zJ70mMg2V3Q1M9KiEQo=;
        b=pTtEImYtI3SbptmTeyTmWoiADqP6FpIPWTL751Opg5b314ug0+zeSLW5Tn3fH61+Ma
         A5p4/1jQob8u+sBKWMhCaBYc5KUOLNthw9ZX7TfYDvDK4obgUP2MUhxnNdfcop0XwB9X
         501mootCi9Al0mnUu9/ybbp8+3bodSQTbcUxXa3Gj8MW2Yko5qLltQNOnzygs66rjsQr
         C6lCRaFL8Fyiu6CfCs+uvreF788/nnwn3Ic5d3Yif22aOoZlu0Cv2XRAfntH7foIE2f5
         1K3ft7g2RwQMaIOk8IWZioeC/bbrP2CwDPtJMQDITnTauVRrnFMqaNbuxcLiimaY7oXn
         0vsg==
X-Gm-Message-State: AOJu0Yy5SR5yiq0yq2aKvhscEU5NfcY4cjNsJQLkUQY5dn+Q7gbR+qAZ
	UIry+qrvxZpQ6dea/H4FJiSSGPBt8aM+xzZcCjEhwcEJqY8uMSZelErkLKYE4qKzVrxCg2Gp0yN
	gsvS/sCE=
X-Gm-Gg: AY/fxX4/okIQh278f/lt6gofx59oaxu+5tHkzHafP1Ffp0soSzsSM4NBSmiAlUjh4fQ
	G9AuPbbXjcQcjAJWCDOe4mhygwZZFvOmQPeXIr9yBYmYMXcUynzWBxRu5uD0eMyIKESSI5l45aV
	1cPLfdvgT4W1t+XdF4IvnKvO/TukGevLuw6m7vUwZ72jq/ly141+4Rd+P95Yl+dIJwuWSyhKm3F
	N8paRHri6Fc4viJAnXVZsmjMFEsBwVA7ozi2DH80QqGwx0YUBECzZfdMt626JZnwGBRh8vYMtsw
	4eV5UuzQOL4lP+9vOzQ4fXT3wl6olynQVECDEBTmmOgMf+KTPcF+YfFx07jdIKWq4/UyZvl06aO
	/BWTi/L/R7Q2aMgeVGT0UAd0U2db8FaE5f7g5/XvXresh6/pJ9/0oCo7lGcbp86eQMlROkP0csw
	zCDD/k1DUNrVXcJYccngfA/eIW/B59w6cbfbXambRFOd2zLndGktQtih+WrBsz+1anTNeswgZd4
	DFI89hhDzJBjSVPY8I=
X-Google-Smtp-Source: AGHT+IG+/+oyAxyrjsLVLEBxR2ejaIoFcTbxhft55QXHHcizOCYlqphWd0yeog6C1evZfZrzHbhjEw==
X-Received: by 2002:a05:600c:a012:b0:47a:940a:c972 with SMTP id 5b1f17b1804b1-47d1955b72emr20956365e9.4.1766144589818;
        Fri, 19 Dec 2025 03:43:09 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a9687dsm35724665e9.3.2025.12.19.03.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 03:43:09 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v3 1/4] bitbake-setup: add inline URI
Date: Fri, 19 Dec 2025 12:42:55 +0100
Message-ID: <20251219114258.1574787-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 11:43:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18616

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

Changes in v3:
- Use a flat list of remotes, instead of a dictionary
- Add a better description for the 'uri' property
- Update bitbake-user-manual-environment-setup.rst

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


