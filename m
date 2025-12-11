Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3575CD41D49
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 14:26:03 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10383.1765463154378585448
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Dec 2025 06:25:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IFz0XD1n;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2e167067so83036f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 06:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765463153; x=1766067953; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O9Rvpki8CMgDmlN4SGe59s60bGzoCEMd5NZviUfpBc=;
        b=IFz0XD1n7wpU0R6uwglQReOBp+/2tA/YB6URyQM27wJOZf76kacsSJkZl6mv8gw7J8
         wvpDnkPXZCoVo3FttFFhV+p0Z7JyZpud0TNPtp0qJ6mSCIQ2ogmucOUgqQeMr4ICyoCg
         q+f3Z2obTn7lqtcytLAsikRHpVzKTze2ms3NMvYMz/n7E0n1R3dkd16dQR4bBlovH6N7
         Kc5alNPC7SbnkxdSS2khC1Hpvp73xj6ISL41wYJErriumW+jvDivK/1JIwjtgjqjh9dS
         taRPJUK7khpUuUdSNMHRb2wTpvrq5aXOpxusLlrmGk3QQrCN25dq8qfqdajseOETGFsz
         2jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765463153; x=1766067953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6O9Rvpki8CMgDmlN4SGe59s60bGzoCEMd5NZviUfpBc=;
        b=o8DPAuFKoPlkqwszejh3SY0iQh3vwpmKO3WTtnnvPYbH+L6YMlsgsFtvj1JmdZRor8
         yaNAzG1sdkRPPkZFdi0MpXlEeIcIqd8KGHjOMt5ZPDLXEAWPEtxjXCFuZRxiNwgyd1xZ
         Zn6VYQ3DyuDedVQJX4Wb8+Fo2vvYYWLj45rw9cV5TpIUHYm8hRyzahmEawg5joNpjyBT
         ERbxIt566ZlGR6IMPmlg+vI8jA6XryByktlkaoXWLDYFxi43GCBGFd2ylVFvquuQk1dc
         5LsMBxMwC6ZjD+6zFvcB8c0ElBmJRJPeq/HwzbgG93p2S4hAnQSZWsFV0j1zJCTRAkld
         Eo/w==
X-Gm-Message-State: AOJu0YzWGuo4LwFziRm6OcAlsEr4EhZ7TTr8sbfFSPY/MSnbPVJRwVwb
	NsoYA04RZ6Ytpi/EuDwI3mrc+zLIiG4dY65FqePMVpeTuRkoiJQaAbY2TprQ7w==
X-Gm-Gg: AY/fxX5iIdQeloCnDJ3mTexh0zWgkih66KcvMqI2BRnJa4oU2wV0f97YRsaJ4KdMI0r
	QKoSCc+73FeshyzZI4LaOgSTBT00oRZJlXZJJ9hRVZh9YImkNy3khQQV1HL2r9lyA/LHHk6qVW/
	YrSfwoudk13aRTUysqddQMPXQzOkEo8WtYNMcp9qqObbEE1s4rqt7/qkeZyJVvJtLrj/Jyr3pom
	LSLi6S9GumdpF9sT9L+4jUz6KZxjz8jCWn0QUuTEPrgcOft6m1ALo3FfupIxzgssvDt4cZwVbdN
	RSb/tH1qBFr93T0jF8ZCnLp3Lv3fAw657xAEcQA2RQgoJeIw3K6MP7/GJI5vcEYlgm4NDWe/xPO
	2ZPJFcvSUbUXHosp38jCFmxHs744OJJptigmH3a+jGf77KESPutMnuz8oEDClWcBv4T0oGrxagG
	BkxTfmkUt2douPatGOv5kSpHivE2HU8hvKwGvEwgupNSN1eMHyvWBUJAdsLA==
X-Google-Smtp-Source: AGHT+IHvuNeLLuoj+i8KgzC+NzFy0nwIf1tAt/G/TjMTOWetW96CsX5p/JoTss6HcUzKpjXv/tHQWA==
X-Received: by 2002:a05:6000:240a:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42fa3b1aad4mr6947964f8f.53.1765463152526;
        Thu, 11 Dec 2025 06:25:52 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a70394sm6214200f8f.14.2025.12.11.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 06:25:52 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/4] bitbake-setup: implement symlinking local sources into builds
Date: Thu, 11 Dec 2025 15:25:32 +0100
Message-ID: <20251211142532.983960-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211142532.983960-1-alex.kanavin@gmail.com>
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18570

From: Alexander Kanavin <alex@linutronix.de>

The feature and the use case were proposed here:
https://lists.openembedded.org/g/bitbake-devel/message/18373

The implementation extends the schema with a 'local' source type,
and simply symlinks them into the setup directory during 'init'.
'status' or 'update' do not consider or modify the symlinks.

The overrides support is extended to add a command line 'shortcut'
for overriding sources with a local path, and massaging relative or
~-containing paths as appropriate.

Documentation is extended to describe the local sources and show
examples. The json properties for sources are also grouped correctly to show
what is git-specific, what is local-specific and what is common.

Tests are extended to cover a few things that weren't previously tested:
source overrides, custom setup directory names, and tests for local
sources are added as well.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup                             | 29 ++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 50 +++++++++++++++++--
 lib/bb/tests/setup.py                         | 28 +++++++++++
 setup-schema/layers.schema.json               | 14 ++++++
 4 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 1f83b1b2a..30c5c44f7 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -109,6 +109,10 @@ def checkout_layers(layers, layerdir, d):
             revision = urldata.revision
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
 
+    def _symlink_local(src, dst):
+        print("Making a symbolic link {} pointing to {}".format(dst, src))
+        os.symlink(src, dst)
+
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
     oesetupbuild = None
@@ -121,6 +125,9 @@ def checkout_layers(layers, layerdir, d):
         r_remote = r_data.get('git-remote')
         if r_remote:
             _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
+        local = r_data.get('local')
+        if local:
+            _symlink_local(os.path.expanduser(local["path"]), os.path.join(layerdir,repodir))
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
@@ -485,6 +492,24 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
     upstream_config['skip-selection'] = args.skip_selection
     return upstream_config
 
+def obtain_overrides(args):
+    overrides = {'sources':{}}
+    if args.source_overrides:
+        overrides = json.load(open(args.source_overrides))
+        overrides_dir = os.path.dirname(os.path.abspath(args.source_overrides))
+        for s,v in overrides['sources'].items():
+            local = v.get('local')
+            if local:
+                path = os.path.expanduser(local['path'])
+                if not os.path.isabs(path):
+                    overrides['sources'][s]['local']['path'] = os.path.join(overrides_dir, path)
+
+    for local_name, local_path in args.use_local_source:
+        overrides['sources'][local_name] = {'local':{'path':os.path.abspath(os.path.expanduser(local_path))}}
+
+    return overrides
+
+
 def init_config(top_dir, settings, args):
     create_siteconf(top_dir, args.non_interactive, settings)
 
@@ -495,7 +520,7 @@ def init_config(top_dir, settings, args):
         progress = event.progress if event.progress > 0 else 0
         print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
 
-    source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
+    source_overrides = obtain_overrides(args)
     upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
@@ -904,6 +929,8 @@ def main():
     parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
     parser_init.add_argument('--setup-dir-name', action='store', help='A custom setup directory name under the top directory.')
     parser_init.add_argument('--skip-selection', action='append', help='Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.')
+    parser_init.add_argument('-L', '--use-local-source', default=[], action='append', nargs=2, metavar=('SOURCE_NAME', 'PATH'),
+                        help='Symlink local source into a build, instead of getting it as prescribed by a configuration (useful for local development).')
     parser_init.set_defaults(func=init_config)
 
     parser_status = subparsers.add_parser('status', help='Check if the setup needs to be synchronized with configuration')
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 12b29241f..4d3585f09 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -317,6 +317,17 @@ In addition, the command can take the following arguments:
 -  ``--skip-selection``: can be used to skip some of the choices
    (which may result in an incomplete :term:`Setup`!)
 
+-  ``-L`` or ``--use-local-source``: instead of getting a source as prescribed in
+   a configuration, symlink it into a :term:`Setup` from a path on local disk. This
+   is useful for local development where that particular source directory is managed
+   separately, and bitbake-setup will include it in a build but will not otherwise
+   touch or modify it. This option can be specified multiple times to specify multiple
+   local sources.
+
+   The option can be seen as a command line shortcut to providing an override file
+   with a ``local`` source in it. See the :ref:`ref-bbsetup-source-overrides` section
+   for more information on source overrides
+
 ``bitbake-setup init`` Examples
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -649,7 +660,8 @@ They contain the following sections:
           "description": "OpenEmbedded - 'nodistro' basic configuration"
       }
 
--  ``sources`` (*optional*): Git repositories to fetch.
+-  ``sources`` (*optional*): sources, such as git repositories that should be provided
+   under ``layers/`` directory of a :term:`Setup`.
 
    Example:
 
@@ -669,12 +681,31 @@ They contain the following sections:
                      "rev": "master"
                  },
                  "path": "bitbake"
+             },
+             "openembedded-core": {
+                 "local": {
+                     "path": "~/path/to/local/openembedded-core"
+                 }
              }
          }
       }
 
    Sources can be specified with the following options:
 
+   -  ``path`` (*optional*): where the source is extracted, relative to the
+      ``layers/`` directory of a :term:`Setup`. If unspecified, the name of the
+      source is used.
+
+   -  ``git-remote`` (*optional*): specifies URI, branch and revision of a git
+      repository to fetch from.
+
+   -  ``local`` (*optional*): specifies a path on local disk that should be symlinked
+      to under ``layers\``. This is useful for local development, where some layer
+      or other component used in a build is managed separately, but should still be
+      available for bitbake-setup driven builds.
+
+   ``git-remote`` entries are specified with the following options:
+
    -  ``uri`` (**required**): a URI that follows the git URI syntax.
       See https://git-scm.com/docs/git-clone#_git_urls for more information.
 
@@ -688,9 +719,13 @@ They contain the following sections:
    -  ``branch`` (**required**): the Git branch, used to check that the
       specified ``rev`` is indeed on that branch.
 
-   -  ``path`` (*optional*): where the source is extracted, relative to the
-      ``layers/`` directory of a :term:`Setup`. If unspecified, the name of the
-      source is used.
+   ``local`` entries are specified with the following options:
+
+   -  ``path`` (**required**): the path on local disk where the externally
+      managed source tree is. ``~`` and ``~user`` are expanded to that user's home
+      directory. Paths in configuration files must be absolute (after possible
+      ~ expansion), paths in override files can be relative to the directory where
+      the override file is.
 
 -  ``expires`` (*optional*): Expiration date of the configuration. This date
    should be in :wikipedia:`ISO 8601 <ISO_8601>` format (``YYYY-MM-DDTHH:MM:SS``).
@@ -868,7 +903,7 @@ The ``--source-overrides`` option can be passed multiple times, in which case th
 overrides are applied in the order specified in the command-line.
 
 Here is an example file that overrides the branch of the BitBake repository to
-"master-next":
+"master-next", and provides openembedded-core as a symlink to a path on local disk:
 
 .. code-block:: json
 
@@ -885,6 +920,11 @@ Here is an example file that overrides the branch of the BitBake repository to
                    },
                    "rev": "master-next"
                }
+           },
+           "openembedded-core": {
+               "local": {
+                   "path": "~/path/to/local/openembedded-core"
+               }
            }
        },
        "version": "1.0"
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 8b6d8bce6..933178c84 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -320,6 +320,34 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 out = self.runbbsetup("update --update-bb-conf='yes'")
                 self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
 
+        # check source overrides, local sources provided with symlinks, and custom setup dir name
+        source_override_content = """
+{
+    "sources": {
+        "test-repo": {
+            "local": {
+                "path": "."
+            }
+        }
+    }
+}"""
+        override_filename = 'source-overrides.json'
+        custom_setup_dir = 'special-setup-dir'
+        self.add_file_to_testrepo(override_filename, source_override_content)
+        out = self.runbbsetup("init --non-interactive --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), custom_setup_dir))
+        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
+        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
+        self.assertTrue(os.path.islink(custom_layer_path))
+        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
+
+        # same but use command line options to specify local overrides
+        custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
+        out = self.runbbsetup("init --non-interactive -L test-repo {} --setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_setup_dir))
+        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
+        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
+        self.assertTrue(os.path.islink(custom_layer_path))
+        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
+
         # install buildtools
         out = self.runbbsetup("install-buildtools")
         self.assertIn("Buildtools installed into", out[0])
diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 9a0b4ed61..1a0255435 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -65,6 +65,20 @@
                                 }}
                             }
                         }
+                    },
+                    "local": {
+                        "description": "A local directory that should be made available for builds via symlinking",
+                        "type": "object",
+                        "additionalProperties": false,
+                        "required": [
+                            "path"
+                        ],
+                        "properties": {
+                            "path": {
+                                "description": "The path to the directory",
+                                "type": "string"
+                            }
+                        }
                     }
                 }
             }
-- 
2.47.3


