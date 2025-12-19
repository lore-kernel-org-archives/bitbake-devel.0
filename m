Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72CFD767E0
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:36:28 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14950.1766144180632815615
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 03:36:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=NnsP/Xri;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430fbb6012bso1189828f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 03:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766144179; x=1766748979; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhqWUByAkSvehtTlEpgsFsTVY6wqzyDLwvkVPsuDxf4=;
        b=NnsP/XriF+3Fi9xBQLJWLJ0NbIO+Dnv5Oh0rKOGggmNadM6QR0mx945XSWgGJ+w14n
         CFMFr4t9nNYJ1mDDhlwZ49KZj1rfIF3BEoo2sGExlsTGgWjFb/8hAPIE7VfyYTsecSOl
         tXOe/+sbJaAAYVS3obMsmqXdWJfjmrBPG8kGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144179; x=1766748979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhqWUByAkSvehtTlEpgsFsTVY6wqzyDLwvkVPsuDxf4=;
        b=M+RdXgepikEXVPUrd7Z0DW5i20awKcuKbWU2MJxiSfzoK7qfIbjYkgu3GYG+MqWxLS
         Hho/IkUThpHRDXnu1c2Y7XdBVIc9vmV+g9Ydrc3wcMcjh2Lta++PA8WBEVNa1lz3HL/q
         +ebatIoHZIo71qabWSNo/oTbiki4jICVn/P6W8INvp3MgCF5vpUiATrsfaxazB24kbO5
         9UnLD2RNeAbMzBQF/vkZAr8iJcip8G11yMLEZNQhF5b2ry7fyHN8v6mapdtTI5URgVJl
         urgmW8rjPyZqAQXlt8PGwWwIqpNo+SdgVZhDaHCys366HyiMjzC3SJbkH0Nd6Vcpsoo+
         jedQ==
X-Gm-Message-State: AOJu0YxzXdtH3jQs7pAO6YV8siWGphBKnuWzUMxxRHBvDRHM1ZeyMxyw
	TG45pkaQ03ksfsQG5g8EgDgSv4yr8ki0iu3H1MDKbyT+6p4jh2b8eywALM2QYoejWDaqoho6qAD
	zg4D3dTk=
X-Gm-Gg: AY/fxX4k+BjWsT/mDXVw5t3d3CuvGrBXsrmP+JlUTyy50U/O6kQWv+/4Hei6TSOxySH
	9evONioXc/B/u3u3wYXpiGK5dIF5tpd8udo3lcEooQ1DZ2/fjiwkzb83xT9Elv7F7xxTNI8pJdd
	8lpqGlEJi/sWpebew1om3BaaaEkNurHoWXWN5edtCBxHkeklRB61PlfCW2c8O4bWIDK9WK0XItQ
	XopYbnbF92itspgkVH+siD68wP5GOT5kxrHY4hx02RZ8o1DB8DxEUJzJpB1HHBSe2zKw5qRC/vI
	LQEuxydYqpbq7f4Ox5ePGqnYLwmYsAksur6EOFUnm/+0qib1Gvc9Tbcw3C30dBr4f1x6LSkM9je
	IzGOSW6EXwGhJyMyXOG6bcKzZgQ+vYgE0QroT+4dw0qL/RhM9hQ6SiFNPYoCetjJiL04XS63PL+
	ZLJAZGF5Z7b+psISeoatfT1683ksOf/hdEYR8HbIu8Cygb5y2lTACrINBNaWrNATRBpV8dA6jQa
	TztQxE4BiZbifvuJDg=
X-Google-Smtp-Source: AGHT+IFcpYcap0Ilb3DXpbz8RjFUgSLi1t02CzxVuUHh/8jVz4BKwoq47tdfdtU3LKecWibWUsHhKg==
X-Received: by 2002:a05:6000:2892:b0:429:d170:b3ac with SMTP id ffacd0b85a97d-4324e4c714cmr2681088f8f.13.1766144178990;
        Fri, 19 Dec 2025 03:36:18 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm4549810f8f.4.2025.12.19.03.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 03:36:18 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v3 1/2] oe-setup-layers: support inline URI
Date: Fri, 19 Dec 2025 12:36:14 +0100
Message-ID: <20251219113615.1573842-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 11:36:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18614

Most of the time, when we describe a remote, the layer data (also used by
the script bitbake-setup) looks like this:

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
        "uri": "https://git.openembedded.org/bitbake

",
        ...
    }
}

These properties can be used together.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---

Changes in v3:
- Use a more pythonic way to increment an integer

 scripts/oe-setup-layers | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/scripts/oe-setup-layers b/scripts/oe-setup-layers
index 31cb963251..5ab7d8be96 100755
--- a/scripts/oe-setup-layers
+++ b/scripts/oe-setup-layers
@@ -60,6 +60,35 @@ def _write_layer_list(dest, repodirs):
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
+            if not 'origin' in r_remote['remotes']:
+                r_name = 'origin'
+            else:
+                import itertools
+                for i in itertools.count(start=1):
+                    if not 'origin-{}'.format(i) in r_remote['remotes']:
+                        break
+
+                r_name = 'origin-{}'.format(i)
+        else:
+            r_name = 'origin'
+
+        remotes.update({r_name: {'uri': r_remote['uri']}})
+
+    return remotes
+
 def _do_checkout(args, json):
     repos = json['sources']
     repodirs = []
@@ -80,7 +109,8 @@ def _do_checkout(args, json):
         if not desc:
             desc = rev[:10]
         branch = r_remote['branch']
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         print('\nSetting up source {}, revision {}, branch {}'.format(r_name, desc, branch))
         if not _is_repo_git_repo(repodir):
-- 
2.51.0


