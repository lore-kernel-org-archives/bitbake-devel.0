Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB0BCAC5B0
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.52701.1759150599963781742
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xs7Ed1+Y;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-636255b92c9so3514026a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150598; x=1759755398; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3yaHIV3BUBaQPrBuPfnjVaoB0do0RoaArd8zBuUTgA=;
        b=Xs7Ed1+YVoaveaxuZaJ/joh8Rwq0u0sraU63wZjZawx6iurzQjz61R1UFcEN5O3ylC
         fOR0aFzWIGDnInuuT8bUTEInOVSCxsoHyNtLmQahvuSorHuxLcwbJ35xQNtKWPlNHEab
         UH5F8hzijBfi4lEixpWqa3YpVWed0h+XxZWNXwrbYladQ92dj+tzEMzfEqXs9NbXcQtS
         psiIKEJQ3KO4fco1B93+pESisNvBynJ+Jw7K84vZ+aIxKzcogFa+v3U9awgH/0GmA73M
         jQ6YaI1M4kvfIeSOpbl5wvt2m9XYiLTE+WZllhjfcCSpunSdjLk+UMWu9hj3OUxzDG6E
         pXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150598; x=1759755398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3yaHIV3BUBaQPrBuPfnjVaoB0do0RoaArd8zBuUTgA=;
        b=F6ASWkd33gszTsut11m/IclBAt9i8050tykD9JiIe6XK2kCLvS5RjSGjjC3G7eUJwJ
         pwNFgiOP+xjjUtfSDDsWoVt2w8DAU2iDA1LIqEf4Pn+J4PQNFzzksiduszHaO0o3ugkD
         gAcKAWlaSj+q/6KtaseXDiO/ORB479IHwZoBEBsQsAHmxS5w+/FWb0D6O7+al2vmuUx8
         +bUOcu+8/T+vEW/mTodX61pMAKHriNjPaoip+PrLlyp9A2rZM9xWZOkFlrbnu805pK+u
         30bZvH6I1ETCIJHIu+ZNDC5fbI+SuB41fN9fOAtQkP61SCUWCyHXnL4nNx/OcjMo+0tn
         vO4A==
X-Gm-Message-State: AOJu0YzEh151VSTGolSQMZqz6dvzIrmFYtttH3FI2Dwkdc5kvyCRSThw
	2HkvJSxC5lnCvx+wShNlezsneOiPeSmCcm6GsMotz5lhwbenqCLgdnarvt8qig==
X-Gm-Gg: ASbGncsAOKiwBwzLfHp4/PHUB5Kr0EZoSQD3TioYZZCrp9xVjl6kagKixg1Jvjl612m
	Jh4+4JhNMKeuBYqUynTlxmzc08luEH4n8mjLz+VCOMAxiKYng2YAB4szNs2lbwU5W11aapU6PWw
	w90JslMLmLhKrWKWIVUk7HIikNfogEBJf2kcPorojrZwPzlR/7kw7d1pMktfCxinDC9UKWuM3nZ
	+z3D7aSHKcx+zUsV4Mpn6aEX2jkIiJeJfxCTn8ew+95ZOQYrsgUQC3QfajVfZ0/BnTn7OAmBjNQ
	ohGBLJh4daL5e1lcrTf1WnQ1b6+5Wxiv5GHermdQRoeXjh2FFh0l19/nFZFn4PS4Bob7Bchjz9+
	++OZj2sF7iOmdjFl7R+IVOKFIML7psfNZ6NwLh0btsauJrn5+Jlx72RU8KLgXJMPqiPIBzB1BQy
	R4l/9FHqriHmXUy0x0e3nUoyv6tfGgxzdxN0UOU9whhrHNCnmjcc5KpgHHqSzvN/yX9XE+7+VkC
	/bMDyI=
X-Google-Smtp-Source: AGHT+IEkle3Aedn8bDPfM1pY+gT60i1GGrDtnwwhXFWz4lhrlTzQc7O4Vpi2GjatmMtuPbCsPor0UQ==
X-Received: by 2002:a05:6402:274c:b0:634:a992:a2 with SMTP id 4fb4d7f45d1cf-634a99206c6mr14634515a12.1.1759150598194;
        Mon, 29 Sep 2025 05:56:38 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:37 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 09/10] bitbake-setup: add support for specifying branches in repo checkouts
Date: Mon, 29 Sep 2025 14:56:15 +0200
Message-Id: <20250929125616.1751116-9-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18108

From: Alexander Kanavin <alex@linutronix.de>

Previously bitbake-setup was checking out 'detached commits' using
fetcher's nobranch feature, as that is the only option when only a revision is in the config.

Branches are optional, but beneficial, as

- checkout directory will be on a branch, making it easier for users
to understand where they are if they need to make changes (also
bitbake will print branch information instead of saying 'HEAD:sha').

- supply chain security! Enforcing a branch means any specified revision
has to be on it, and no one can sneak in (accidentally or deliberately!)
some dangling commit, or something from their private branch in the same repo.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup                                    | 12 ++++++++++--
 .../configurations/oe-nodistro.conf.json             |  3 +++
 .../configurations/poky-master.conf.json             |  4 ++++
 lib/bb/tests/setup.py                                | 11 ++++++-----
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ce5cd5e65..8ceacada9 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -86,13 +86,17 @@ def checkout_layers(layers, layerdir, d):
 
         r_remote = r_data['git-remote']
         rev = r_remote['rev']
+        branch = r_remote.get('branch', None)
         remotes = r_remote['remotes']
 
         for remote in remotes:
             type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
             print("    {}".format(r_name))
-            fetcher = bb.fetch.Fetch(["{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir)], d)
+            if branch:
+                fetcher = bb.fetch.Fetch(["{};protocol={};rev={};branch={};destsuffix={}".format(fetchuri,type,rev,branch,repodir)], d)
+            else:
+                fetcher = bb.fetch.Fetch(["{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir)], d)
             do_fetch(fetcher, layerdir)
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
@@ -444,12 +448,16 @@ def are_layers_changed(layers, layerdir, d):
 
         r_remote = r_data['git-remote']
         rev = r_remote['rev']
+        branch = r_remote.get('branch', None)
         remotes = r_remote['remotes']
 
         for remote in remotes:
             type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
-            fetcher = bb.fetch.FetchData("{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir), d)
+            if branch:
+                fetcher = bb.fetch.FetchData("{};protocol={};rev={};branch={};destsuffix={}".format(fetchuri,type,rev,branch,repodir), d)
+            else:
+                fetcher = bb.fetch.FetchData("{};protocol={};rev={};nobranch=1;destsuffix={}".format(fetchuri,type,rev,repodir), d)
             upstream_revision = fetcher.method.latest_revision(fetcher, d, 'default')
             rev_parse_result = bb.process.run('git -C {} rev-parse HEAD'.format(os.path.join(layerdir, repodir)))
             local_revision = rev_parse_result[0].strip()
diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
index f4a7492f3..7619738b1 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -8,6 +8,7 @@
                         "uri": "git://git.openembedded.org/bitbake;protocol=https"
                     }
                 },
+                "branch": "master",
                 "rev": "master"
             },
             "path": "bitbake"
@@ -19,6 +20,7 @@
                         "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
                     }
                 },
+                "branch": "master",
                 "rev": "master"
             },
             "path": "openembedded-core"
@@ -30,6 +32,7 @@
                         "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
                     }
                 },
+                "branch": "master",
                 "rev": "master"
             },
             "path": "yocto-docs"
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 227816983..3f1299179 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -8,6 +8,7 @@
                         "uri": "git://git.openembedded.org/bitbake;protocol=https"
                     }
                 },
+                "branch": "master",
                 "rev": "master"
             },
             "path": "bitbake"
@@ -19,6 +20,7 @@
                         "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
                     }
                 },
+                "branch": "master",
                 "rev": "master"
             },
             "path": "openembedded-core"
@@ -30,6 +32,7 @@
                         "uri": "git://git.yoctoproject.org/meta-yocto;protocol=https"
                     }
                 },
+                "branch": "master",
                 "rev": "master"
             },
             "path": "meta-yocto"
@@ -41,6 +44,7 @@
                         "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
                     }
                 },
+                "branch": "master",
                 "rev": "master"
             },
             "path": "yocto-docs"
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index fb2c15f54..329a0c525 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -87,7 +87,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         bbsetup = os.path.abspath(os.path.dirname(__file__) +  "/../../../bin/bitbake-setup")
         return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.path.join(self.tempdir, 'global-config'), cmd))
 
-    def add_json_config_to_registry(self, name, rev):
+    def add_json_config_to_registry(self, name, rev, branch):
         config = """
 {
     "sources": {
@@ -98,6 +98,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                         "uri": "file://%s"
                     }
                 },
+                "branch": "%s",
                 "rev": "%s"
             },
             "path": "test-repo"
@@ -134,7 +135,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     },
     "version": "1.0"
 }
-""" % (self.testrepopath, rev)
+""" % (self.testrepopath, branch, rev)
         os.makedirs(os.path.join(self.registrypath, os.path.dirname(name)), exist_ok=True)
         with open(os.path.join(self.registrypath, name), 'w') as f:
             f.write(config)
@@ -208,12 +209,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.assertNotIn("test-config-1", out[0])
         self.assertNotIn("test-config-2", out[0])
 
-        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', 'master')
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', 'master', 'master')
         out = self.runbbsetup("list")
         self.assertIn("test-config-1", out[0])
         self.assertNotIn("test-config-2", out[0])
 
-        json_2 = self.add_json_config_to_registry('config-2/test-config-2.conf.json', 'master')
+        json_2 = self.add_json_config_to_registry('config-2/test-config-2.conf.json', 'master', 'master')
         out = self.runbbsetup("list --write-json={}".format(os.path.join(self.tempdir, "test-configs.json")))
         self.assertIn("test-config-1", out[0])
         self.assertIn("test-config-2", out[0])
@@ -270,7 +271,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         branch = "another-branch"
         self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
         self.add_file_to_testrepo('test-file', test_file_content)
-        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch)
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
         for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
             buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
             os.environ['BBPATH'] = os.path.join(buildpath, 'build')
-- 
2.39.5


