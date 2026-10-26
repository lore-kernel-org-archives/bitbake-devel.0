Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33009.1792974067489116964
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Oct 2026 17:21:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UQmeUokc;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e987a2ba0cso15391415ad.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 Oct 2026 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792974067; x=1793578867; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=inRszRBblaM+stFs7Pp3Dq8zIEesuB6TObzbr5l0xxM=;
        b=UQmeUokcmhfQYPB/LYLkquU9p614xT98za7qSXJzOsIPlB4ri1cYQX1EnKQW6uvu20
         O6tYtJPQw6ltQVs2gEGUt8i4gRC67pA7orlcKl0pL4rpmZXU3N2MeRRNaaAfB9y+MWgt
         lGSy10VHmDh1C40wN6nQY3Mpe5EXUr2QoFxnIobkdxcIYIamMrr9/WdfiPXwMiL8eEUA
         Y3zNWgMpMWtbcR1hcbTs6Wd0aMm8tE1NcOM+AgdHz/7m/zcivVu7q/CGbxgyrTW1OMVG
         TSKSTpFgCUzttAkutBQQd+KTgthgboPg15OmDykfM86d7+b0H39fW70+FIc5C+9BF3jv
         Zzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792974067; x=1793578867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=inRszRBblaM+stFs7Pp3Dq8zIEesuB6TObzbr5l0xxM=;
        b=HjEowJiSebqhvEBVzcWmYS5rD4GmGjjD+cBpapfYWZ+hoy70liilFNysP0uTLYzfFu
         316PZLvJICJbSCN9ZIPQxl4ITlstYW198gtLKK9CVuF6ws4PiuaG3Xd3pPVkoq/iOEB2
         KXUF6Dw4VoPXg5cTkXZmEhxdEJMhZiGy2VkfRvnjOFf1Xhbt2I/XCzKBr9KP76F2C+zU
         bWdAh40ESF8NvPmcym3mJ5gBcMU0OfVgvSts+TWVqUkZo69E9o7SyqjPsHfYZnRH5Qzp
         mCfeoZJY1AeiESSqnjhI759CvaPFJxi4EC7IYZgDSyzIg+iZIQ7t4QFmqzewfzOWbjzi
         MWcQ==
X-Gm-Message-State: AFq9FYK5Bdj6yJ/lJGDHeUQPpN6xor5DWn0G944sdQ6gi1W2V4ogKP1p
	ha/v6QT4CYKyAH0LoWuZsnMJajToQpXNnkpVm8WLPG7iksbGrvOHb06SdZ/LlfQG
X-Gm-Gg: AYBFou3y8MJu7ap/eWX7ToOMXRG6Bc+zP1lnGtsB1ouSifBkkvXDpZCGaRClH2sQISh
	/sJVIjF1W3U72WuiA1nXr9sedf8nli+dugTx9jqzLrPdNI485cJMEq8wZnv86M6fc/A4t/HIZ4q
	9sn+e2xUXcMi3Pb/Dz3E3q7oOEpYNF8/34Ygm2sN26ivLuJnIRN0VUZpq/DD1K6xwi9zglzDibU
	CIcqcqSiS8GNXY4ZENG/kwW2K9i43UA80tzfAI/IDN54YQlPIUzxLO+OKVeG/n9yelnYmFJPxjC
	4K1wVtrapAIdp6vOJf3w71/ET8MCkAr6Nyx5/1Jeu70UUIt+0JCkT+Q+8Kauv2SVPMhyUJ9nFlK
	wM+pfK3Bc4PkjJki8P3DDZrP329xEg76I4WeJJXn9UAIcYeTMhqADg5fhy2mnO+msdKrCcImNGR
	IbHxps0sdCORnuCPPenPEXMo0wXbLeyDkaT7Ly8sCvmw/8B0b3kyxDG1Fy/Lajl/dWJe00txCbC
	sPvMfz2qmR+6P/B6acc255f+QimDCO77/6al8jOeu0zs6sfVr5KUs9saD54LjwFPtKVjK/tFx9Y
	GpKfQfF3mJiF
X-Received: by 2002:a17:902:ea12:b0:2e9:87a2:b4f8 with SMTP id d9443c01a7336-2ea9c83f108mr42350395ad.29.1792974066759;
        Sun, 25 Oct 2026 17:21:06 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14c296sm9358475ad.30.2026.10.25.17.21.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 17:21:05 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v2 2/2] cookerdata: error on duplicate BBPATH entries
Date: Sun, 25 Oct 2026 17:20:48 -0700
Message-ID: <20261026002048.86208-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019020422.14365-1-tim.orling@konsulko.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 26 Oct 2026 00:21:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20381
Content-Type: text/plain; charset="utf-8"

A directory listed more than once in BBPATH makes include_all apply the
same file repeatedly. Fail once the layer configuration is parsed, so
the error points at the configuration rather than surfacing later as
duplicate inclusion warnings. Paths are compared after resolving them,
and empty entries are ignored.

Tested with bitbake-selftest and an oe-core tinfoil config parse.

Suggested-by: Richard Purdie <richard.purdie@linuxfoundation.org>
AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/bb/cookerdata.py  | 12 ++++++++++++
 lib/bb/tests/parse.py | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index d65e3c974..87310af7c 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -482,6 +482,18 @@ class CookerDataBuilder(object):
                         " invoked bitbake from the wrong directory?")
             bb.fatal(msg)
 
+        # A directory listed more than once in BBPATH is a configuration
+        # error, e.g. a layer in both the BBPATH env var and BBLAYERS. Compare
+        # resolved paths so "dir" and "dir/" or a symlink to it also match, and
+        # ignore the empty entries left by stray colons
+        entries = {}
+        for p in data.getVar("BBPATH").split(":"):
+            if p:
+                entries.setdefault(os.path.realpath(p), []).append(p)
+        duplicates = [" ".join(paths) for paths in entries.values() if len(paths) > 1]
+        if duplicates:
+            bb.fatal("BBPATH contains duplicate entries:\n    %s\nCheck the BBPATH environment variable, bblayers.conf and the layer.conf files." % "\n    ".join(duplicates))
+
         if not data.getVar("TOPDIR"):
             data.setVar("TOPDIR", os.path.abspath(os.getcwd()))
         if not data.getVar("BB_CACHEDIR"):
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index cd8f02388..90a63e7dc 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -531,6 +531,33 @@ EXTRA_OECONF:append = " foobar"
             self.assertEqual(d.getVar("EXTRA_OECONF"), " foo bar")
             self.assertEqual(logs.output, ["WARNING:BitBake.Parsing:parse done"])
 
+    def test_duplicate_bbpath(self):
+        # A directory listed more than once in BBPATH is fatal
+        bbpath = os.path.realpath(os.path.join(os.path.dirname(__file__), "parse-tests"))
+        with tempfile.TemporaryDirectory(prefix="parsetest") as builddir:
+            def run_bitbake(entries):
+                env = os.environ.copy()
+                env["BBPATH"] = ":".join(entries)
+                env["BB_ENV_PASSTHROUGH_ADDITIONS"] = "TOPDIR"
+                env["TOPDIR"] = builddir
+                return subprocess.run(["bitbake", "-e"], env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True, cwd=builddir)
+
+            link = os.path.join(builddir, "link")
+            os.symlink(bbpath, link)
+
+            # The same directory spelled the same, with a trailing slash or
+            # through a symlink is a duplicate
+            for dup in (bbpath, bbpath + "/", link):
+                with self.subTest(dup=dup):
+                    result = run_bitbake([bbpath, dup])
+                    self.assertNotEqual(result.returncode, 0)
+                    self.assertIn("BBPATH contains duplicate entries:\n    %s %s\n" % (bbpath, dup), result.stdout)
+
+            # Empty entries from stray colons are not duplicates
+            result = run_bitbake(["", bbpath, "", ""])
+            self.assertEqual(result.returncode, 0, result.stdout)
+            self.assertNotIn("BBPATH contains duplicate entries", result.stdout)
+
     def test_file_variables(self):
         # Tests the values of FILE and __BB_RECIPE_FILE in different
         # combinations of bbappends, includes, and inherits
-- 
2.56.0

