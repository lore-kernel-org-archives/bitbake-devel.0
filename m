Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1DFD41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 10:33:14 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45577.1765794787379678252
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 02:33:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=n9iPckui;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso1950581f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 02:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765794786; x=1766399586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jI8zbPhJVqxKiIVeSxHLW16yjqAKC2884edymMtS3M4=;
        b=n9iPckuius15MYhMqr6g/PZwSgdfN75/mLEgWMLuUunC2W0rj3/JEUSN+QL+XQuQO1
         00GO9fo//p3K6w3U4WAaF6Gns1d7gibdkAEe8TjLGMk3RWisQ4y0Y1Du3pdQw5/CW9LJ
         RhXZZcKTxPrsTvQn6aq24YfGm1JWPLy+ZHVgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765794786; x=1766399586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI8zbPhJVqxKiIVeSxHLW16yjqAKC2884edymMtS3M4=;
        b=Hcl5KFx+3+oST8qqiDkGyelEPjtZ0JfbZwJXpsDXc2iKSGm1l16UZGuwvs6BU/wZMF
         u63xy7ubuHrfnb95mj2mta/Oy+GOofz1qiaB2oCPk8Nb1KLQcT6q2nkfun7LxLl10XJz
         1RXlMiZ1fs1Rs9tE0i2/XZfCzNwdszemLNMa6BjSH81jTaLVPQEJuImDBidcq7xlF523
         5ellXouUeDvKUxyJ2RzRfbDURo6qPFiNeZgUIIHLhwcKpN1Z0PtCqZ25CtIwwJqnSflz
         PNaadUONdMZsRKJ4K77IZ7f0VKBEN/XVPxI8TxMdVI1FSNK9zhQPUBBvjjd4dLjDspry
         gfcA==
X-Gm-Message-State: AOJu0YzZFJBAryWus1ZdryJJZQDN9ll8LquJbistRvDFntAnJaUMBnmd
	iBVItCu2RO6FvQot5tcgVWko+qOaZF2/DgFCWDV2+r074xjPj/3n25a0sLT7dbpglz8JyCcuN7v
	SBufqMhI=
X-Gm-Gg: AY/fxX5F9G91D1n6Duviep3zIsfltQcM7xDv9L4jBSRjodGdGYAPuVQ4IkEIOJHTsKh
	kB6FnEcptsTNkk8tjlx2QlnR7vc1dsEUrWKoCwLAQQ/7xJ/emcc6lnP2Gon+khtwgBzgojA7BLp
	Hvri/bWB64H+FJzTjmUHLdx9FwiVwhQlWHP0iFWGk52lozQ0V2kyi+nNTK5inteMWI19YAQIwbR
	fH070yS0r422k0fy0dzy3cQnmWUba4bObOMKkgfBIuEcTC7txiNg4pmOJj0WQXcxBDAahhsNlit
	GjwztUrVP/epO3dTuw0jsru8BQWT/3QjRd+D8m3W9V2TahXfqNrYE1qk0YbiJ10XQC8hUlNZCnh
	onXsH5rhkT70Iwd7CAghI3w45sEYRT+hdL4gJB+CZgQPP5aUb+u4kJ5ePocs06Au6DZVh388hHJ
	bemR04/Eko1IToZWjQULottOQgrLMoeIWvwWD/awNTuHBXbQBuNtgRs8xE+I2fwP+60tJRU7PCf
	gmg379jK7UkGE+beXA=
X-Google-Smtp-Source: AGHT+IGnOM3dW7A3qkCBBNEuM69fAlS9hxkUCbaf/w8kLQ6CaO3hEaIqni4O6br11kInLVFG1Br+xQ==
X-Received: by 2002:a05:6000:2311:b0:430:ff0c:35f9 with SMTP id ffacd0b85a97d-430ff0c37damr1780701f8f.48.1765794784284;
        Mon, 15 Dec 2025 02:33:04 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85d1esm28676257f8f.26.2025.12.15.02.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:33:03 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v2 1/3] bitbake-setup: add inline URI
Date: Mon, 15 Dec 2025 11:32:54 +0100
Message-ID: <20251215103256.902711-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 10:33:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18584

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

Changes in v2:
- The keys are complementary, rather than mutually exclusive
- Updated configurations in default-registry/configurations/

 bin/bitbake-setup | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b1d751899..c97e63479 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -89,6 +89,33 @@ def _write_layer_list(dest, repodirs):
     with open(layers_f, 'w') as f:
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
+def _get_remotes(r_remote):
+    remotes = {}
+
+    if not 'remotes' in r_remote and not 'uri' in r_remote:
+        raise Exception("Expected key(s): 'remotes', 'uri'")
+
+    if 'remotes' in r_remote:
+        remotes = r_remote['remotes'].copy()
+
+    if 'uri' in r_remote:
+        r_name = ''
+
+        if 'remotes' in r_remote:
+            if not 'bitbake-setup-uri' in r_remote['remotes']:
+                r_name = 'bitbake-setup-uri'
+            else:
+                idx = 1
+                while 'bitbake-setup-uri_{}'.format(idx) in r_remote['remotes']:
+                    idx += 1
+                r_name = 'bitbake-setup-uri_{}'.format(idx)
+        else:
+            r_name = 'bitbake-setup-uri'
+
+        remotes.update({r_name: {'uri': r_remote['uri']}})
+
+    return remotes
+
 def checkout_layers(layers, layerdir, d):
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
@@ -102,7 +129,8 @@ def checkout_layers(layers, layerdir, d):
         r_remote = r_data['git-remote']
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         for remote in remotes:
             prot,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
@@ -571,7 +599,8 @@ def are_layers_changed(layers, layerdir, d):
         r_remote = r_data['git-remote']
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         for remote in remotes:
             type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
-- 
2.51.0


