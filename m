Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF8ACAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 15:52:58 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.12409.1759420374045552054
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 08:52:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=sQ6tfndd;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso7974435e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759420372; x=1760025172; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjLGOqyoNviah1feTi2LRx4cWsjKeJvzESZRcWo2AAk=;
        b=sQ6tfnddTDdvBmcuymb5Smh4jyhX70/MQ08oi5DRzM9v5zAYlYr7oYbb+KveFiveht
         +EXgwyMiJpq8xQ/1rQzkZ2lUH3iIHgBZfV24fOWGMDu7pKBU6kf7DwNWDzkDnuwyGMs7
         yh3jk7On/JcHZCdjWuV07jYq6/oorzzW8DtJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420372; x=1760025172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjLGOqyoNviah1feTi2LRx4cWsjKeJvzESZRcWo2AAk=;
        b=guf2MFzeUR2py/F0elx46Gc1cvLuVPMo4zNroNLZnhlsMxsaIJqlhwKIpvgp8mZgJu
         +aVRdcla0eOIQmHMFvwXsNSl+MJqvWAZqlcpVdujgAm2SaFEcJhe4LoEtCgLicYzSzrj
         V7YpKWem9LHjmK3/S9p87VTHj5/qloOegVCjy93EywyK0et0HbwVDIiHbfFn3XhBHVM2
         nz4vy3z+QTiTk18ZgcTHu0dfEidkWXa8PrfdYTEtTtdHHIbWMegMhQCDKSrWqnGF1LpY
         09IXGPADhwoDVy/jRVHf9Mb8egxe9YAo6yL8VTdXua8ylHlJ4yvyfD3zuYeQayuoO672
         zOQg==
X-Gm-Message-State: AOJu0YwWls4TshxrdhAGg2YX+5LeAmOrLBHjKh2VTybJtHY4ogjpqR2/
	zzKKqaHy+OrA9GrYKU0ehqWeln3IdQ6fFO1nUYGOPp1wqMfUZ1dlbNSDhFtdedverrjJ0TH5z5R
	5H4sYj9s=
X-Gm-Gg: ASbGncvsCc+nRN8soMPRzj0NyFb6D1wUqdhp+LWrwIVbseOQ/AMhrR0QICTMaKRQCiu
	ggD1p56GYXcRL+6UtsIEJODlnsmVoTL4eVGX+3ToXHmWDF1WTxfr/q8pDMR5ut9MBql4gnlqjqt
	N+HMl7p3ErfY+K8owssPE0I1TihVcwaVvhkdwSWNpsRuujfnU8juJiKtsEos7BbbyxdAY/w9Ia+
	/ZIq/TuQTL2TpDjWHmd/VsO5lxCCOBfudAVDw4os8t4/vDACNouGdcNgtyE1pf3EuMIuEYg4oD2
	8zTIFYvI5oMHwi/NHOXdGmTLTWGA8MlkHOCRVl3CB1+2NG/XcPO5EtxD9ud/rCicRyacmKyLCfL
	8Ew1qw5xU/0DXTyBf10zgqnBJvcCM7q7eCL1UNCpdAqt7MstmKTmvLWRrYJxv6KTDdsmBd/7ZO1
	fjgIRjxf3qV1VaJpCfREJtGKdVdICQIZl98rLsYGOwYY9K/wVlvoWb0g==
X-Google-Smtp-Source: AGHT+IGGZo8HPc2VSsd5TH6iv4zg0GLvTadZ+d/VkWldaa/R4SaeAV5KgtbrZdDB76sn0WdFSVjAXQ==
X-Received: by 2002:a05:600c:8b66:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46e6fcae45bmr11096935e9.5.1759420372224;
        Thu, 02 Oct 2025 08:52:52 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm4121684f8f.26.2025.10.02.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:52:51 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH] bitbake-setup: optionally support JSON5 (e.g. comments) format
Date: Thu,  2 Oct 2025 17:52:10 +0200
Message-Id: <20251002155210.782342-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 15:52:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18123

From: Yoann Congal <yoann.congal@smile.fr>

One major limitation of JSON files is that comments are not supported.
JSON5 (https://json5.org/) is an extension of the current JSON file
format that support comments (among other evolutions).

This patch adds the support of the JSON5 file format when reading
configuration files.

Sadly, no JSON5 support exists in Python stdlib, so we have to install a
module. I chose https://pypi.org/project/json5/ (but
https://pypi.org/project/pyjson5/ may be an alternative).

I took care of only patching reading of the config file, the internal
JSON files of bitbake-setup are still in classic JSON, which mean that
operations that don't need to read the original configuration still work
without a json5 module.

I put an example of a JSON5 config in
default-registry/configurations/poky-master_json5.conf.json
This is poky-master.conf.json translated to JSON5 plus some comments.

To try this:
  python3 -m venv .venv; . .venv/bin/activate # if needed
  pip install json5
  ./bin/bitbake-setup init default-registry/configurations/poky-master_json5.conf.json poky_json5

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup                             |  8 ++
 .../poky-master_json5.conf.json               | 93 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 default-registry/configurations/poky-master_json5.conf.json

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index bb466d85..d1c54269 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -19,6 +19,14 @@ import datetime
 import glob
 import subprocess
 
+try:
+    # Try to import the non-standard json5 module to load JSON files
+    from json5 import load as json5_load
+    json.load = json5_load
+    print("Using json5 to load JSON")
+except ImportError:
+    pass
+
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
 bindir = os.path.abspath(os.path.dirname(__file__))
diff --git a/default-registry/configurations/poky-master_json5.conf.json b/default-registry/configurations/poky-master_json5.conf.json
new file mode 100644
index 00000000..cf447e9a
--- /dev/null
+++ b/default-registry/configurations/poky-master_json5.conf.json
@@ -0,0 +1,93 @@
+{
+    // This file format supports comments
+    description: "Poky - The Yocto Project testing distribution configurations and hardware test platforms",
+// ^           ^ As long as the object keys are compatible with a JS variable name, quotes are optional:
+    //
+    sources: {
+        bitbake: {
+            "git-remote": { // note "git-remote" is not a valid JS variable name because of the dash
+                remotes: {
+                    origin: {
+                        uri: "git://git.openembedded.org/bitbake;protocol=https",
+                    },
+                },
+                branch: "master",
+                rev: "master", // This file format accepts a comma after the last element of lists/objects
+            },
+            path: "bitbake",
+        },
+        "openembedded-core": {
+            "git-remote": {
+                remotes: {
+                    origin: {
+                        uri: "git://git.openembedded.org/openembedded-core;protocol=https",
+                    },
+                },
+                branch: "master",
+                rev: "master",
+            },
+            path: "openembedded-core",
+        },
+        "meta-yocto": {
+            "git-remote": {
+                remotes: {
+                    origin: {
+                        uri: "git://git.yoctoproject.org/meta-yocto;protocol=https",
+                    },
+                },
+                branch: "master",
+                rev: "master",
+            },
+            path: "meta-yocto",
+        },
+        "yocto-docs": {
+            "git-remote": {
+                remotes: {
+                    origin: {
+                        uri: "git://git.yoctoproject.org/yocto-docs;protocol=https",
+                    },
+                },
+                branch: "master",
+                rev: "master",
+            },
+            path: "yocto-docs",
+        },
+    },
+    "bitbake-setup": {
+        configurations: [
+            {
+                name: "poky_json5",
+                description: "Poky - The Yocto Project testing distribution (from a JSON5 config)",
+                "bb-layers": [
+                    "openembedded-core/meta",
+                    "meta-yocto/meta-yocto-bsp",
+                    "meta-yocto/meta-poky",
+                ],
+                "oe-fragments": [
+                    "core/yocto/sstate-mirror-cdn",
+                ],
+                "oe-fragments-one-of": {
+                    machine: {
+                        description: "Target machines",
+                        options: [
+                            "machine/qemux86-64",
+                            "machine/qemuarm64",
+                            "machine/qemuriscv64",
+                            "machine/genericarm64",
+                            "machine/genericx86-64",
+                        ],
+                    },
+                    distro: {
+                        description: "Distribution configuration variants",
+                        options: [
+                            "distro/poky",
+                            "distro/poky-altcfg",
+                            "distro/poky-tiny",
+                        ],
+                    },
+                },
+            },
+        ],
+    },
+    version: "1.0",
+}

