Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F9CCFA03
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 21:48:28 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3449.1762206499467561847
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 13:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ildl/FUZ;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2913450f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762206497; x=1762811297; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KovOzgqb5A4Ud+CFxbZTZK+TCft+3M1q2c1zuw7qAe8=;
        b=ildl/FUZvqBMK2EvBqPlOqCS6dpzlfsTqg/6z15UDv2SHAXj4qJN+iu1B4pCpD7yFs
         6xRHcBFpbzA8Af8iHlR982lutRCYPNDjUxXlmqkOsMCvgcFU0lwtYeFQMA2Pzr8TNnmO
         FyBfaju+HPlI4NiIhgbZaASjO1C+uISVwx5gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762206497; x=1762811297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KovOzgqb5A4Ud+CFxbZTZK+TCft+3M1q2c1zuw7qAe8=;
        b=Vhvew/F8b5j/NwcBXXSmgXeoPVwI40Pv5LDIWG+k4hv7TeI7e7JTF6kpCR0VhAWNhu
         SwfQmW6CjZuC2N+nAich7oSBe8xs2qEcW3aw3Fs08onNPKKQXyoVyvOmxjLqKx+D4SP+
         2LT4GdiQUfdd1uofRlBTwt5a1RtpznxlXp2x7jbdOBXtHvrg6kQMC3m1as6G9KkKvy7p
         1zV7rtXyuSC3IgjL2W+aRRDufHGrK7H4z3amk0soXRAyw63lAu3hGIlL7mQqd1C7ZUBH
         mVKGfedUfi0o4m4qkJq/epYShN5TvRhw0zuyboYvUN7P0mtAhqrN4jTf/OiI2oPOO/LO
         i1cg==
X-Gm-Message-State: AOJu0YwHO3GKbALFNGCKDiQMzuZOqNn7iwiWyCqgwSXausvMCM7b4Kch
	su+99GBO8iwxFNWCEz0MaC9DCMNSyMg9W7kLjMMqCvVXRD5qCGYFO5uzUuWUHhYjiYI+U8msHcB
	zlVXN/M4=
X-Gm-Gg: ASbGncscSqqP7tICR89B1N+zLN23dw06jwLYWEEtDlyLxdsIkRZNym4EMso7BoapDTW
	KDrwhgGRXO3NubYNAFntitrKz9ls5w5EtHPj/oBdfI0/E4bcP2jbKXn2dHgPgwA7fviW9cOaA8m
	6Cl+ECCydVPMSg5BrWA4Rzv7rzEfTSqcsXthBlVEuDY7XFUnIpFtueHWE+mc0NoIIaFXoUzPF9R
	PCvzyUXCbKgtU7X6gsIORDAZRHdswAi7ftgsnXMaVtFjMm5buxzqj1EZep859OW5Mi2v+apRnAu
	jjiAY7oVQzQjb8M8RkUM0eHrQsHPQ6uDWM+2aHq/UC1XQnUGiQ1L/XgEw9gfVdL22T52JLm+Ufa
	iI/LljIVGhpyOjtt27xP+KYVU3SSiOPFXDBLcXn+YcSJL9bct1AUTxGtlTPHdSLr7hlSJH+7Rsf
	qW8kI8+qt+jvWXed1pDn+Y/17BnCWv547w/ruTWAMbh6wOSrobBMlp5ffkf328cDajIGMy1YfYF
	xKW72XSHHxlPoYw9BjWFwkGohHn0ppe
X-Google-Smtp-Source: AGHT+IG0obl8DLoGflpI102zDD+RxOA0jetSTaoC4wgkRonSX/BXp5fNvpbCo+6/jyJLNfncDGaOBA==
X-Received: by 2002:a05:6000:2890:b0:429:d41b:9fe0 with SMTP id ffacd0b85a97d-429d41ba20bmr4344453f8f.38.1762206497414;
        Mon, 03 Nov 2025 13:48:17 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fd9f6sm899364f8f.42.2025.11.03.13.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 13:48:17 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] bitbake-setup: make "path" optional
Date: Mon,  3 Nov 2025 22:48:04 +0100
Message-Id: <20251103214804.2004903-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 21:48:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18245

From: Yoann Congal <yoann.congal@smile.fr>

Layer names and path are often redundant. Allow users to omit the path
key when it is equal to the layer name by using the layer name as a
default value for its path.

For example, from poky-master.conf.json:
  "bitbake": {
    ...
    "path": "bitbake"
  },
  "openembedded-core": {
    ...
    "path": "openembedded-core"
  },
  "meta-yocto": {
    ...
    "path": "meta-yocto"
  },
  "yocto-docs": {
    ...
    "path": "yocto-docs"
  }

Remove redundant "path" keys from default-registry and tests.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
Note: Now that all "path" keys are removed (because they were all redundant),
we need to ensure the "path" code path is tested by adding a test for
it.
---
 bin/bitbake-setup                                    |  2 +-
 .../configurations/oe-nodistro.conf.json             |  9 +++------
 .../configurations/poky-master.conf.json             | 12 ++++--------
 lib/bb/tests/setup.py                                |  3 +--
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a0426005f..57375e450 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -81,7 +81,7 @@ def checkout_layers(layers, layerdir, d):
     print("Fetching layer/tool repositories into {}".format(layerdir))
     for r_name in layers:
         r_data = layers[r_name]
-        repodir = r_data["path"]
+        repodir = r_data.get("path", r_name)
         repodirs.append(repodir)
 
         r_remote = r_data['git-remote']
diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
index 7619738b1..9cd11a218 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -10,8 +10,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "bitbake"
+            }
         },
         "openembedded-core": {
             "git-remote": {
@@ -22,8 +21,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "openembedded-core"
+            }
         },
         "yocto-docs": {
             "git-remote": {
@@ -34,8 +32,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "yocto-docs"
+            }
         }
     },
     "bitbake-setup": {
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 60531ba02..9b63ea5f0 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -10,8 +10,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "bitbake"
+            }
         },
         "openembedded-core": {
             "git-remote": {
@@ -22,8 +21,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "openembedded-core"
+            }
         },
         "meta-yocto": {
             "git-remote": {
@@ -34,8 +32,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "meta-yocto"
+            }
         },
         "yocto-docs": {
             "git-remote": {
@@ -46,8 +43,7 @@
                 },
                 "branch": "master",
                 "rev": "master"
-            },
-            "path": "yocto-docs"
+            }
         }
     },
     "bitbake-setup": {
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index e320cdf56..85fc24f88 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -100,8 +100,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 },
                 "branch": "%s",
                 "rev": "%s"
-            },
-            "path": "test-repo"
+            }
         }
     },
     "description": "Test configuration",

