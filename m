Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03821CD6E50
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 14:52:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12014.1780066347815754071
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 07:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nA2mdDCw;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so94840075e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066346; x=1780671146; darn=lists.openembedded.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8PNf2LrfQj2v4B7YLf8P7RrZccI21ENBjBgRvEY4kw=;
        b=nA2mdDCwg7toVVY+i/F64i2xUJyy3bv7+aP2krrv6DJOs+BgIj3I6ope4fG6A24gUm
         bQCEPrz6SI+KBwmpSbhgu1d+HBw+jssu2zsjB4pazerwtRgZm+Ex1tR+AHZODFl727L5
         xg1/6PYHsAMcc6kIYyilYoUk18FvPovi4CBA2+XnD1BsNogs2+X6BVm4yUzoHEczSeBC
         1crKsC54n2DqblPszTRNzp09iasefDihMSpbCctmBbyWMy5NMk2MLvnmpVPrBrfwOlyd
         QAH1djoFYNTOxS1J0UZeFg84SQUedAjNr51FomozZyRtRa7g23hdkwtO+uR0aKm3aqmu
         TDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066346; x=1780671146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p8PNf2LrfQj2v4B7YLf8P7RrZccI21ENBjBgRvEY4kw=;
        b=T9j3s2ruQV4YquRLrHncol9gMyX+jF8sySYI8gcX7WNMXOjXE4cowJcShKlTC2YQSK
         dkCNe3Erqt8r1LUejt0NiyA5DsJdpKzRJyQ7ifxbaj2h6iTo6Q45IbbqJioT5sm9T2/r
         xDMHSYn1ae2PDxIpRSAVv3L9LxtbWq/nJPGZp/6cXfrc3rLySLNFvoTBY8oJqorcU15l
         mMdtWoyF0jOzuKexH9aJ8JBtKilA0zmTmU1Mg0jS3fCkErVDpXW+iFdDNVtVkkyd0gzH
         eY47rx9b1tlnRcJUz0dYdxat79+NFOgVA2gWNWdlgg8LVNA3i1D7pimmHPaJq1FM0EFF
         nnFQ==
X-Gm-Message-State: AOJu0YyTBmlt66d6YkolfL98L3UNKx1Mg42KTUSc2L4EvmK6RIdsr2vq
	Ry+4rQFRYjJQnDMzhgRnjsg7KLl5MR/fugdtTvUIgBCnaaZmjgG33qOHfPHLPd5U
X-Gm-Gg: Acq92OGHyS9brRi2rGsCRWSTHNC1ETT8fC+7UaCPHv0KmqwUGSbTHlcuH3rNovcfSQm
	cJyZN/Hmu/OJNmbPfaJQ9BTYwZi4imFYbjkjrfwF0lHYZMhn0F0OEqTyS5ztSuXp0ekon/9Nc7n
	K1PG5HPhc0o0QgQGixIg8pRirGoBiLSw3m9EM4MqE9Sr6T13WGSSmd/U/4uoyNamL2kCA0OiYpf
	CjUgEFpti4Cxdbt6c5/KNO2X4tJxfmRIco39wDOSWGydg7fMCv7+t4sXRGdsAOI3Z2B1QlGmY/6
	7d6xiJJNq/aQC6eB7GeI1ksY2/r+/k+XUS7UrcRTfPkeL8j9ROgO6DoYemEt/Kbjovp7HcclVVX
	Mh7x4uXmAEaizCIFSFNerF+V8+LEtHgajfu5HsuESB/NQDM5ciiViByj+/Dzf6FvQ4o9vFy3wow
	je9D16cYjXUkmSrzWcyZVvN7pg0ytaBORCcRPuofxiQXAKY6MtLr5rLZBRg396SyXtAq6+Vut4R
	+8iUcqwv3JQz1lPzX22vuVYCuOhmKoCkHqFDg==
X-Received: by 2002:a05:600c:6c01:b0:490:5149:a242 with SMTP id 5b1f17b1804b1-4909c0916a3mr41609695e9.5.1780066345842;
        Fri, 29 May 2026 07:52:25 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c13d018sm21199535e9.8.2026.05.29.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:52:24 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 29 May 2026 16:51:38 +0200
Subject: [PATCH 1/2] bitbake-setup: support multiple source override files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
In-Reply-To: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 14:52:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19561

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

The bitbake-setup documentation currently states that:
"The --source-overrides option can be passed multiple times, in which
case the overrides are applied in the order specified in the
command-line."

However, this is not currently true and only the last --source-overrides
argument is actually used.

Allow --source-overrides to be specified more than once and follow the
behaviour set out in the documentation, i.e.: merge override files in
command-line order.

Extend the setup test to exercise two override files through init,
checking that both are applied and that they are applied in order.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 bin/bitbake-setup     | 17 +++++++-------
 lib/bb/tests/setup.py | 61 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 220540f7f9ca..2e234cccaba9 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -636,21 +636,22 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
     return upstream_config
 
 def obtain_overrides(args):
-    overrides = {'sources':{}}
-    if args.source_overrides:
-        overrides = json.load(open(args.source_overrides))
-        overrides_dir = os.path.dirname(os.path.abspath(args.source_overrides))
+    all_overrides = {'sources':{}}
+    for overrides_file in args.source_overrides or []:
+        overrides = json.load(open(overrides_file))
+        overrides_dir = os.path.dirname(os.path.abspath(overrides_file))
         for s,v in overrides['sources'].items():
             local = v.get('local')
             if local:
                 path = os.path.expanduser(local['path'])
                 if not os.path.isabs(path):
-                    overrides['sources'][s]['local']['path'] = os.path.join(overrides_dir, path)
+                    v['local']['path'] = os.path.join(overrides_dir, path)
+            all_overrides['sources'][s] = v
 
     for local_name, local_path in args.use_local_source:
-        overrides['sources'][local_name] = {'local':{'path':os.path.abspath(os.path.expanduser(local_path))}}
+        all_overrides['sources'][local_name] = {'local':{'path':os.path.abspath(os.path.expanduser(local_path))}}
 
-    return overrides
+    return all_overrides
 
 def configure_vscode(setupdir, layerdir, builddir, init_script):
     """
@@ -1257,7 +1258,7 @@ def main():
     parser_init = subparsers.add_parser('init', help='Select a configuration and initialize a setup from it')
     parser_init.add_argument('config', nargs='*', help="path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available choices if command line doesn't completely specify them.")
     parser_init.add_argument('--non-interactive', action='store_true', help='Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.')
-    parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
+    parser_init.add_argument('--source-overrides', action='append', help='Override sources information (repositories/revisions) with values from a local json file.')
     parser_init.add_argument('--setup-dir-name', action='store', help='A custom setup directory name under the top directory.')
     parser_init.add_argument('--skip-selection', action='append', help='Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.')
     parser_init.add_argument('-L', '--use-local-source', default=[], action='append', nargs=2, metavar=('SOURCE_NAME', 'PATH'),
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 638d56d3bb32..d425faa1f6b6 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -180,21 +180,23 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('commit -m "Adding {}"'.format(name), cwd=self.registrypath)
         return json.loads(config)
 
-    def add_json_config_to_registry(self, name, rev, branch):
-        sources = """
-        "test-repo": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "file://%s"
-                    }
-                },
-                "branch": "%s",
-                "rev": "%s"
+    def add_json_config_to_registry(self, name, rev, branch, source_names=("test-repo",)):
+        sources = []
+        for source_name in source_names:
+            sources.append("""
+            "%s": {
+                "git-remote": {
+                    "remotes": {
+                        "origin": {
+                            "uri": "file://%s"
+                        }
+                    },
+                    "branch": "%s",
+                    "rev": "%s"
+                }
             }
-        }
-""" % (self.testrepopath, branch, rev)
-        return self._add_json_config_to_registry_helper(name, sources)
+""" % (source_name, self.testrepopath, branch, rev))
+        return self._add_json_config_to_registry_helper(name, ",\n".join(sources))
 
     def add_local_json_config_to_registry(self, name, path):
         sources = """
@@ -442,11 +444,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             sums_after = _conf_chksum(f"{setuppath}/build/conf")
             self.assertEqual(sums_before, sums_after)
 
-        def _check_local_sources(custom_setup_dir):
+        def _check_local_sources(custom_setup_dir, sources=("test-repo",)):
             custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
-            custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
-            self.assertTrue(os.path.islink(custom_layer_path))
-            self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
+            for source in sources:
+                custom_layer_path = os.path.join(custom_setup_path, 'layers', source)
+                self.assertTrue(os.path.islink(custom_layer_path))
+                self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
             self.config_is_unchanged(custom_setup_path)
 
         def _check_layer_backups(layer_path, expected_backups):
@@ -525,14 +528,32 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             "local": {
                 "path": "."
             }
+        },
+        "test-repo-extra": {
+            "local": {
+                "path": "/does/not/exist"
+            }
+        }
+    }
+}"""
+        second_source_override_content = """
+{
+    "sources": {
+        "test-repo-extra": {
+            "local": {
+                "path": "."
+            }
         }
     }
 }"""
         override_filename = 'source-overrides.json'
+        second_override_filename = 'second-source-overrides.json'
         custom_setup_dir = 'special-setup-dir'
+        self.add_json_config_to_registry('test-config-1.conf.json', branch, branch, ("test-repo", "test-repo-extra"))
         self.add_file_to_testrepo(override_filename, source_override_content)
-        out = self.runbbsetup("init --non-interactive --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), custom_setup_dir))
-        _check_local_sources(custom_setup_dir)
+        self.add_file_to_testrepo(second_override_filename, second_source_override_content)
+        out = self.runbbsetup("init --non-interactive --source-overrides {} --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), os.path.join(self.testrepopath, second_override_filename), custom_setup_dir))
+        _check_local_sources(custom_setup_dir, ("test-repo", "test-repo-extra"))
 
         # same but use command line options to specify local overrides
         custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'

-- 
2.43.0


