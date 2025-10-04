Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D0CAC5B0
	for <webhook@archiver.kernel.org>; Sat,  4 Oct 2025 15:50:27 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web10.11818.1759593021131492991
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Oct 2025 08:50:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=w0thtCv7;
 spf=pass (domain: smile.fr, ip: 209.85.167.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e03279bfeso4546003e87.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 04 Oct 2025 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759593019; x=1760197819; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2KCLTEaBzQJv9oY+dtx6jPGuLlbDsPOubBiaU369nk=;
        b=w0thtCv7ri0A5o3AfvzGNPIkwN7EWqM4uYa+aKzwAesDbeNPPOT59HZ81zDKnYqKkP
         dy6Tq7mTyfZkarw3Bs25g98MdqruaBpFAUFVj/sOldYpJc/mJ5uFFjX4Ju6853ooDfV5
         Re6ScOCpsk7fBqfGvfa7Zgi5NF6XCjUnt3Qi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759593019; x=1760197819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2KCLTEaBzQJv9oY+dtx6jPGuLlbDsPOubBiaU369nk=;
        b=lXBJ3/957ZFgId9cLwQirmzaQ4lawKIHq6Vd04s8sC198cvwuDDBpCnucVQNLQCw2E
         CR+wVNOOE2QI0SoP2T5RGi/VgYzNeu4zvxrL9He9YQk8RtJ7Cz/ip0VGKvX5Z4G7RVhA
         tNfrunLyBRXhKW6f7sgUwmBS2jsxeHfWhFjIeAn4j6W8T6ATW5FStoYAUKnWL0/a6NZn
         vLfE6oUX6tmLlvp/hVh1WV/rjAw5n4mUyoXHJSP7BF9YzyXUGmPyy4goUq2rYHNyGc1G
         kXikb2Pu2NSd8fw2ssfNX7YhQH70pe7x+7T3zE1qiGPNkem7EdNZ47dgEKp02xG7Azfq
         u7oA==
X-Gm-Message-State: AOJu0Yy3d4hN7oLUeEKr0RUa0q4iq+haIRiANl2byZukmOnwf59P6Hzf
	95yYkW6c4kum/gDn0vwRsm8KEWHIkH7grsDZWUR5tp+1AecgMKnlilk2gVnrSLp4sWGpF8EKiiK
	SG45jd3U=
X-Gm-Gg: ASbGnctKzKhI0V6PAwlFrR7lSEiGAYmUelesj4Pex3LZ/sT+0UzDBxwVA8i2k9r0ZQA
	eKaEkzpBhcxln7GCA4q2sovBigQmKmsu3Nc3rZNsoyydNQK76ki9dg6VmljyQyGj5/5PrfxOOqg
	oXBL7cP/9rkrI7bRLYsOv6clIsuaTm4lkVjKHIqXGGdSumo+fAGzIFzgyxOGUbCj0EdLTwC9i7T
	BUW5gwBYobXcrqyXD/XurPJykeJ37CYcty2r/adOuNtiKWriLtGawmRdcDDDwZKntDrbGKJMPK9
	scHwcNGE6d6l87TQ1/Uy25QobnM1IGPVkmB4lfEDtI+JxZO41cGL+U0Ht72AO7PplqPp6drzghq
	Z58Pa8uSEtkcPjuih8o3yZGwitMyv0pzytxjtq6XOq99nDws222Oq9VAeLv4PYpO0SjA2U+9THF
	0P8swOlUUq2Ox4ixcKp2OGXyv3u9tqKGTRYtE0bMm7+LsUpOmd+n90Lwo=
X-Google-Smtp-Source: AGHT+IHWJehu744XaG32wE+nSH0ZyCbEMuzU3gidst+8Wv4TRpnL0jXwJI/yaxyMa+CP7QADZudFCA==
X-Received: by 2002:ac2:4c06:0:b0:58c:b321:32cb with SMTP id 2adb3069b0e04-58cb32133bemr1474737e87.25.1759593018706;
        Sat, 04 Oct 2025 08:50:18 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa00237ec3c8e80ae4f6.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:237e:c3c8:e80a:e4f6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f46csm2942703e87.49.2025.10.04.08.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 08:50:18 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH] bitbake-setup: preprocess "//" comments
Date: Sat,  4 Oct 2025 17:49:59 +0200
Message-Id: <20251004154959.1743199-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 04 Oct 2025 15:50:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18134

From: Yoann Congal <yoann.congal@smile.fr>

One major limitation of JSON files is that comments are not supported.
One way to support these can be to preprocess JSON files using a custom
JSONDecoder.raw_decode.

I put an example of a commented JSON config in
default-registry/configurations/poky-master_jsonc.conf.json
This is poky-master.conf.json plus some comments.

To try this:
  ./bin/bitbake-setup init default-registry/configurations/poky-master_jsonc.conf.json poky_jsonc

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup                             | 36 ++++++--
 .../poky-master_jsonc.conf.json               | 82 +++++++++++++++++++
 2 files changed, 111 insertions(+), 7 deletions(-)
 create mode 100644 default-registry/configurations/poky-master_jsonc.conf.json

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index e7b95521..62a42c81 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -18,6 +18,28 @@ import configparser
 import datetime
 import glob
 import subprocess
+import re
+
+class JSONComment(json.JSONDecoder):
+    @staticmethod
+    def remove_comments(code: str) -> str:
+        # Remove // comments while preserving those inside strings
+        # This regex matches either quoted strings or // comments
+        pattern = re.compile(r'"(?:[^"\\]|\\.)*"|//.*?(?=\n|$)', re.MULTILINE)
+
+        def replacer(match):
+            # If the match starts with a quote, it's a string - keep it
+            if match.group(0).startswith('"'):
+                return match.group(0)
+            # Otherwise it's a comment - remove it
+            return ''
+
+        return pattern.sub(replacer, code)
+    def raw_decode(self, s, idx):
+        orig_len=len(s)
+        s = JSONComment.remove_comments(s)
+        ret = super().raw_decode(s, idx)
+        return ret[0], orig_len
 
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
@@ -373,20 +395,20 @@ def obtain_config(settings, args, source_overrides, d):
             upstream_config = {'type':'local',
                                'path':os.path.abspath(config_id),
                                'name':get_config_name(config_id),
-                               'data':json.load(open(config_id))
+                               'data':json.load(open(config_id), cls=JSONComment)
                                }
         elif config_id.startswith("http://") or config_id.startswith("https://"):
             print("Reading configuration from network URI\n    {}".format(config_id))
             import urllib.request
             with urllib.request.urlopen(config_id) as f:
-              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
+              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f, cls=JSONComment)}
         else:
             print("Looking up config {} in configuration registry".format(config_id))
             registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
             registry_configs = list_registry(registry_path, with_expired=True)
             if config_id not in registry_configs:
                 raise Exception("Config {} not found in configuration registry, re-run 'init' without parameters to choose from available configurations.".format(config_id))
-            upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+            upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)), cls=JSONComment)}
         expiry_date = upstream_config['data'].get("expires", None)
         if has_expired(expiry_date):
             print("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
@@ -395,7 +417,7 @@ def obtain_config(settings, args, source_overrides, d):
         registry_configs = list_registry(registry_path, with_expired=True)
         config_id = choose_config(registry_configs, args.non_interactive)
         config_parameters = []
-        upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
+        upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)), cls=JSONComment)}
 
     upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
     upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive, args.skip_selection)
@@ -411,7 +433,7 @@ def init_config(settings, args, d):
         progress = event.progress if event.progress > 0 else 0
         print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
 
-    source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
+    source_overrides = json.load(open(args.source_overrides), cls=JSONComment) if args.source_overrides else {'sources':{}}
     upstream_config = obtain_config(settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
@@ -492,7 +514,7 @@ def build_status(settings, args, d, update=False):
     confdir = os.path.join(builddir, "config")
     layerdir = os.path.join(builddir, "layers")
 
-    current_upstream_config = json.load(open(os.path.join(confdir, "config-upstream.json")))
+    current_upstream_config = json.load(open(os.path.join(confdir, "config-upstream.json")), cls=JSONComment)
 
     args.config = current_upstream_config['non-interactive-cmdline-options']
     args.non_interactive = True
@@ -560,7 +582,7 @@ def list_registry(registry_path, with_expired):
         for f in files:
             if f.endswith('.conf.json'):
                 config_name = get_config_name(f)
-                config_data = json.load(open(os.path.join(root, f)))
+                config_data = json.load(open(os.path.join(root, f)), cls=JSONComment)
                 config_desc = config_data["description"]
                 expiry_date = config_data.get("expires", None)
                 if expiry_date:
diff --git a/default-registry/configurations/poky-master_jsonc.conf.json b/default-registry/configurations/poky-master_jsonc.conf.json
new file mode 100644
index 00000000..392200d3
--- /dev/null
+++ b/default-registry/configurations/poky-master_jsonc.conf.json
@@ -0,0 +1,82 @@
+{
+    "description": "config to demonstrate inline comments: This is a \"//test",  // Inline comment (even "this")
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/bitbake;protocol=https" // << this is not cut 
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            },
+            "path": "bitbake"
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            },
+            "path": "openembedded-core"
+        },
+        "meta-yocto": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/meta-yocto;protocol=https"
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            },
+            "path": "meta-yocto"
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            },
+            "path": "yocto-docs"
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                },
+                "distro": {
+                    "description": "Distribution configuration variants",
+                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                }
+            },
+            "configurations": [
+            {
+                "name": "poky_jsonc",
+                "description": "Poky - The Yocto Project testing distribution"
+            },
+            {
+                "name": "poky-with-sstate",
+                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
+                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
+            }
+            ]
+        }
+        ]
+    },
+    "version": "1.0"
+}

