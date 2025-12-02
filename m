Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C8ED11703
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 16:04:15 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.835.1764691455173823055
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 08:04:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=MXilwWZf;
 spf=pass (domain: smile.fr, ip: 209.85.221.67, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42e2e671521so1797696f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 08:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764691453; x=1765296253; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LtcNJionilhgokYadb+8BcN61e/HbQTNOutrJEL2BgQ=;
        b=MXilwWZfFIgLrJJBLtyCRcSRp1aDZ+BjfQS78JwHW+JZRuRGeuwZQbtCB098TAY+hN
         r5LP/ka8Mx9WAEiKvbl4owbunTJPZBazJvQBO/29sBbYyVfE0076KtfMLxr1AEdSdfts
         3mlbR9YjiNWdpyrQlcK2C11XY1qCgpQljKXwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691453; x=1765296253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtcNJionilhgokYadb+8BcN61e/HbQTNOutrJEL2BgQ=;
        b=uxDj8w89O8qDt9SUEtnzMgJcJoAnCAiMNma7YWXB6nJQ4kRd0mDsbva68JZIMCBsLu
         /CddnedmeATOPaRZdDOzOMkb642mAHXlm795Rymt6ppZlCcXTM3UBRZ6aDMdDzwFjQAI
         Sd/Toln2t0QPpTDVCuRV3kOc5K6mF9EiDWuByopEk+eNggIMOE02i/l7DEjYaTXPlruF
         uCeUtE8T07yt35eISDbQYTN0g1xAqs0oOXQRuyfPjLQZsPsyhotiVgyd/zgLoR5SYSku
         3js9itNCseprQa8lfpl7uR9Arh3RZR/SOnlTvhwtdCs1hoi/W9pw+aEDtra9m1XOLEF3
         nqzA==
X-Gm-Message-State: AOJu0Yx6Wuv5Gx9PQ8ldmYhthhTquv+fhfVDUvAKW5LC5XfN/vzTqolc
	HxBOEQkwc5opVLuBH4sY7wJ5OP2PLQ6va88NOoOcZ2ftJEGQ8AAfMFBRF+r0jQ+CD3+IoVVgMuA
	nVS5jeh09S1Aw
X-Gm-Gg: ASbGncvuKLXDnDoAAiq6vyRcLf5JrNn7fOuYVVSJRaP/w5FhKq/yaVBut37vx6m8rhP
	1QfbtL5NdX8Q7Os1sNKlTv0mYT2cpv5IuUGFfCxKmkYlJ7WjcAmLo7+vZwSTME5xgqfAQU5UsvL
	u6NQm7bksEO7XeGxHf38f0iQdcJkHNUBfLqZ+kRgmRRIC4sOA6HQtJSkPEKZdfn6pYM9HkNvxu8
	sVjd1thPQUlj+vfoqYpfpISgrtFFEEIIX15bmaFSp0CVVKKS8IyNDHYrQwcwNOa37fetB0Yh4iF
	guCLr7crCCpqofUYer6QMHFmEIFyiE+PrTf19CwiNnzFraJCx10tppqyIF8UaYMq7erstPBPG3a
	dGD/oBN2ZNr6RA0EfdOB+RrWUmjPCbPW9QtuxI3aoQtZ0soiRY1j3mV897vm5hqYD5Pv9GPhfDq
	imov4o6XkBeIhnpgGbAZ/cvi7d/w/SYF+B
X-Google-Smtp-Source: AGHT+IGkgdbE5SIlgW1Xh1yv97aVNziFTWoOQztdRSg0Y2qV/Wo67O6kW0MuIPvLjMEdTyKeZX/ZYw==
X-Received: by 2002:a05:6000:1845:b0:429:92d8:3371 with SMTP id ffacd0b85a97d-42e0f1fd01fmr33377188f8f.11.1764691453335;
        Tue, 02 Dec 2025 08:04:13 -0800 (PST)
Received: from heaven.lan ([2001:861:3080:b0f0:3dbf:6e88:6b4c:feb7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a396sm33461990f8f.22.2025.12.02.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:04:13 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH 1/2] bitbake-setup: add inline URI
Date: Tue,  2 Dec 2025 17:04:01 +0100
Message-ID: <20251202160402.819060-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 16:04:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18507

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

'uri' and 'remote' are then mutually exclusive.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 bin/bitbake-setup | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 75be90940..390918d32 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -89,6 +89,14 @@ def _write_layer_list(dest, repodirs):
     with open(layers_f, 'w') as f:
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
+def _handle_uri_shortcut(r_remote):
+    if 'remotes' in r_remote and 'uri' in r_remote:
+        raise Exception("Keys 'remotes' and 'uri' are mutually exclusive")
+
+    if 'uri' in r_remote:
+        r_remote['remotes'] = {'origin': {'uri': r_remote['uri']}}
+        del r_remote['uri']
+
 def checkout_layers(layers, layerdir, d):
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
@@ -102,6 +110,9 @@ def checkout_layers(layers, layerdir, d):
         r_remote = r_data['git-remote']
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
+
+        _handle_uri_shortcut(r_remote)
+
         remotes = r_remote['remotes']
 
         for remote in remotes:
@@ -571,6 +582,9 @@ def are_layers_changed(layers, layerdir, d):
         r_remote = r_data['git-remote']
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
+
+        _handle_uri_shortcut(r_remote)
+
         remotes = r_remote['remotes']
 
         for remote in remotes:
-- 
2.49.0


