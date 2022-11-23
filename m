Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ACDC433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 00:14:11 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.8158.1669162449981162751
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Nov 2022 16:14:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M/G3OmK2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso2113501wmb.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 22 Nov 2022 16:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VM3mJdkuRc1ur195sYSmFbwTWbeXt828gisHTpxjzWk=;
        b=M/G3OmK27pEsHH6nXdRpoQMuQrTnOyPHQ201/6eoAgovulrKGFXT8KWtzlHSyk9v3+
         19AHn+tE1taB4jOzfhcz1gLbJztHX48JtEQ1Nmr52gOvnPBLa3kMb2PZxO6fdxvTeecT
         fN2DRV4RpEHGSs3gSvEHC/IQ54W+spn/soyWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VM3mJdkuRc1ur195sYSmFbwTWbeXt828gisHTpxjzWk=;
        b=qqVpuDy0eLJcooRhsGYQrERnk3DNZ5a9lY4TG8X8t5u7QA2RCE207zlTStn2AmNXqk
         dA6lAscKAbYnd6hu7bk+FNa0QLp9iud5piTSwptgfGhKaUZF/jr9da9FNPQCvYFRKsUe
         zSu0eNWGi39DW93JcDKQJy2bttydPWLiMTFrHTg1CgPLALxwh94WGB5sF/tLOdwmZFiQ
         E5qczec09Li4MYRLkAKACh72ljvYYifhMHwRHpLGQyD8+gkBzyjYjQhKTygYAB68/NgT
         kBSTwRMkTgo2n+o8IQalnAWMjHP2jfdSLQTUBnaUNrnMUSeLzhw21K2kItpIfwfb6I4k
         8yHw==
X-Gm-Message-State: ANoB5pmbcO7K/fPyx5B8WhB1cOOw6frkyktDm4kYxD2W6UkQG/y1d3TL
	j47G1RgLG4mq8LLyKLgX3zMepAGEvaIKZw==
X-Google-Smtp-Source: AA0mqf7fqila1HMGscfI/5Y5B+Yl2iptOgBeIPDF2YHVqV6rSvcYP0W1FfOH0tn5wmYz2+E7qOAUHA==
X-Received: by 2002:a05:600c:3b04:b0:3cf:6fd8:95a4 with SMTP id m4-20020a05600c3b0400b003cf6fd895a4mr18041066wms.73.1669162447816;
        Tue, 22 Nov 2022 16:14:07 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:978b:ac21:2786:e95b])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003c71358a42dsm431301wmb.18.2022.11.22.16.14.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:14:05 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data/siggen: Switch to use frozensets and optimize
Date: Wed, 23 Nov 2022 00:14:03 +0000
Message-Id: <20221123001403.3696092-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 00:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14099

Python handles frozensets a little more optimally than normal sets. Once we
finish parsing, we don't edit this data so we can convert to them.

To do that, we need to stop changing them so process ignore_deps earlier
then we can freeze the data and keep it frozen.

This has the side effect that we need to be careful to sort the data
in some of the variables when calculating the hashes.

Overall this does seem to show a decent parsing time speed improvement
of 20-25% in a local test but this would be highly setup dependent.

Also ensure the sigdata can handle exported frozenset and make it import
back to them instead of sets.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py   | 14 ++++++--------
 lib/bb/siggen.py |  6 +++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 3a6af325f4..430d444203 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -276,7 +276,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
             value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
-            return deps, value
+            deps -= ignored_vars
+            return frozenset(deps), value
         varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
         vardeps = varflags.get("vardeps")
         exclusions = varflags.get("vardepsexclude", "").split()
@@ -359,12 +360,13 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
 
         deps |= set((vardeps or "").split())
         deps -= set(exclusions)
+        deps -= ignored_vars
     except bb.parse.SkipRecipe:
         raise
     except Exception as e:
         bb.warn("Exception during build_dependencies for %s" % key)
         raise
-    return deps, value
+    return frozenset(deps), value
     #bb.note("Variable %s references %s and calls %s" % (key, str(deps), str(execs)))
     #d.setVarFlag(key, "vardeps", deps)
 
@@ -383,7 +385,7 @@ def generate_dependencies(d, ignored_vars):
         newdeps = deps[task]
         seen = set()
         while newdeps:
-            nextdeps = newdeps - ignored_vars
+            nextdeps = newdeps
             seen |= nextdeps
             newdeps = set()
             for dep in nextdeps:
@@ -407,7 +409,6 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, ignored_vars, fn):
         else:
             data = [data]
 
-        gendeps[task] -= ignored_vars
         newdeps = gendeps[task]
         seen = set()
         while newdeps:
@@ -415,9 +416,6 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, ignored_vars, fn):
             seen |= nextdeps
             newdeps = set()
             for dep in nextdeps:
-                if dep in ignored_vars:
-                    continue
-                gendeps[dep] -= ignored_vars
                 newdeps |= gendeps[dep]
             newdeps -= seen
 
@@ -429,7 +427,7 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, ignored_vars, fn):
                 data.append(str(var))
         k = fn + ":" + task
         basehash[k] = hashlib.sha256("".join(data).encode("utf-8")).hexdigest()
-        taskdeps[task] = alldeps
+        taskdeps[task] = frozenset(seen)
 
     return taskdeps, basehash
 
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 07bb529452..72b906c153 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -25,13 +25,13 @@ hashequiv_logger = logging.getLogger('BitBake.SigGen.HashEquiv')
 
 class SetEncoder(json.JSONEncoder):
     def default(self, obj):
-        if isinstance(obj, set):
+        if isinstance(obj, set) or isinstance(obj, frozenset):
             return dict(_set_object=list(sorted(obj)))
         return json.JSONEncoder.default(self, obj)
 
 def SetDecoder(dct):
     if '_set_object' in dct:
-        return set(dct['_set_object'])
+        return frozenset(dct['_set_object'])
     return dct
 
 def init(d):
@@ -1056,7 +1056,7 @@ def calc_basehash(sigdata):
         basedata = ''
 
     alldeps = sigdata['taskdeps']
-    for dep in alldeps:
+    for dep in sorted(alldeps):
         basedata = basedata + dep
         val = sigdata['varvals'][dep]
         if val is not None:
-- 
2.34.1


