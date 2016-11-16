Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 901F1719F4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 17:22:09 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id a197so253369576wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=qBYZaxlF12jsYfz3ZnDhb83ERYOmFlCtbeM90R/jSpU=;
	b=zqJ2E1Vk201bD66us3j5dG56fZSIy9bVyZYkL2F/EUtk9O4q2Hoom0eouKI4IjyswJ
	EOmGkwLzyV8KKKH4kjC/9AVm/B7G7C+LMVWiSTyXEsVlWS8bOmOcrYZbAVQdtsxb/9yF
	pms2GyfNQr2fEIQh40bt3OzN82o+1dh9z28gPRyCeMLaXVyLWExG+sQBMl6HWAxguXCA
	cRW6USXA5/g2VDp6ewem2ljOB3ZRg+J68IRxKhGID42dDwxRCKP6qAK7R4EfMeyyQu/+
	GTzR7nJuEjMo29bkBtTJgamCaJ2qdjj5Kh8QQOFKdq6g3awXdl/OAlr15N4dVvG1itZr
	pNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=qBYZaxlF12jsYfz3ZnDhb83ERYOmFlCtbeM90R/jSpU=;
	b=ReKxQs3xpz6QGQKEqYVPIsBo5EKXaN9SYhePBGdfaLBIfyzy7T6L4GEescqyGJYQbD
	4JkuAOIPE7azGD4WbXEdBLzi1bkDwnIX5zhPLK6xwSpRcPojrXoVTIKolUZaesOm5Qvz
	F0jnWRqg56fCW+9sjURlUFkc2ir6Fo/2Y7VVLpwRWza9XoXXghM+X+8JtvWnAUEXaCrW
	i5iKZZSuZ0k5HogubthuaAvZy9SBkjDCYtGbWezFqOqg1pbKKi0WPUjqbzUYgqyPakLQ
	kw210kCCMR+wJvGAnXzMD1Jzo/gJnQ4KKmw20mmI0D+0i+0yr0C+Jj57ZmRXj/sQ2vDa
	P1XA==
X-Gm-Message-State: ABUngvcf6/3ls7xa5oV+aCwjJV7p4RUC0iwR9SqBaIaHNjk+Djp+uvKNbdADZvw/++vRoEEK
X-Received: by 10.28.212.131 with SMTP id l125mr10446226wmg.117.1479316929960; 
	Wed, 16 Nov 2016 09:22:09 -0800 (PST)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	w65sm11123677wmd.23.2016.11.16.09.22.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 16 Nov 2016 09:22:09 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 16 Nov 2016 17:22:05 +0000
Message-Id: <1479316925-22066-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] ast: remove BBVERSIONS support
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 16 Nov 2016 17:22:09 -0000

BBVERSIONS is moderately horrible and it doesn't appear to be actually used by
anyone, so remove it to simplify the finalise codepaths.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/parse/ast.py | 67 ---------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index fa83b18..78789d4 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -30,8 +30,6 @@ import itertools
 from bb import methodpool
 from bb.parse import logger
 
-_bbversions_re = re.compile(r"\[(?P<from>[0-9]+)-(?P<to>[0-9]+)\]")
-
 class StatementGroup(list):
     def eval(self, data):
         for statement in self:
@@ -385,27 +383,6 @@ def _create_variants(datastores, names, function, onlyfinalise):
             else:
                 create_variant("%s-%s" % (variant, name), datastores[variant], name)
 
-def _expand_versions(versions):
-    def expand_one(version, start, end):
-        for i in range(start, end + 1):
-            ver = _bbversions_re.sub(str(i), version, 1)
-            yield ver
-
-    versions = iter(versions)
-    while True:
-        try:
-            version = next(versions)
-        except StopIteration:
-            break
-
-        range_ver = _bbversions_re.search(version)
-        if not range_ver:
-            yield version
-        else:
-            newversions = expand_one(version, int(range_ver.group("from")),
-                                     int(range_ver.group("to")))
-            versions = itertools.chain(newversions, versions)
-
 def multi_finalize(fn, d):
     appends = (d.getVar("__BBAPPEND", True) or "").split()
     for append in appends:
@@ -422,50 +399,6 @@ def multi_finalize(fn, d):
         d.setVar("__SKIPPED", e.args[0])
     datastores = {"": safe_d}
 
-    versions = (d.getVar("BBVERSIONS", True) or "").split()
-    if versions:
-        pv = orig_pv = d.getVar("PV", True)
-        baseversions = {}
-
-        def verfunc(ver, d, pv_d = None):
-            if pv_d is None:
-                pv_d = d
-
-            overrides = d.getVar("OVERRIDES", True).split(":")
-            pv_d.setVar("PV", ver)
-            overrides.append(ver)
-            bpv = baseversions.get(ver) or orig_pv
-            pv_d.setVar("BPV", bpv)
-            overrides.append(bpv)
-            d.setVar("OVERRIDES", ":".join(overrides))
-
-        versions = list(_expand_versions(versions))
-        for pos, version in enumerate(list(versions)):
-            try:
-                pv, bpv = version.split(":", 2)
-            except ValueError:
-                pass
-            else:
-                versions[pos] = pv
-                baseversions[pv] = bpv
-
-        if pv in versions and not baseversions.get(pv):
-            versions.remove(pv)
-        else:
-            pv = versions.pop()
-
-            # This is necessary because our existing main datastore
-            # has already been finalized with the old PV, we need one
-            # that's been finalized with the new PV.
-            d = bb.data.createCopy(safe_d)
-            verfunc(pv, d, safe_d)
-            try:
-                finalize(fn, d)
-            except bb.parse.SkipRecipe as e:
-                d.setVar("__SKIPPED", e.args[0])
-
-        _create_variants(datastores, versions, verfunc, onlyfinalise)
-
     extended = d.getVar("BBCLASSEXTEND", True) or ""
     if extended:
         # the following is to support bbextends with arguments, for e.g. multilib
-- 
2.8.1


