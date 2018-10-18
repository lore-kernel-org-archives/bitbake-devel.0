Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 557D279B13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 09:22:53 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id y16so32833060wrw.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=TXIFJiDjHfBv+VjvwXfyiY1IkLyuAGNDYUxZBo8Pu2w=;
	b=eEyO/dbvZyGRQyfc3DPoH4K0B0gy9LVxJAIwThjtKU/4jksNkLSKaw8GJTthmTen24
	CpOXYyZsDkdBpm5+SOBrVopAXYPBN1YmNp1bAUziOCVnovkW2IGcq+xi3GKM/hQrndtb
	REqjQHsVPsY0zfkL85ctORTU/fzAEAMVgT2m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=TXIFJiDjHfBv+VjvwXfyiY1IkLyuAGNDYUxZBo8Pu2w=;
	b=hI0E5xLs9q/rSA26Nzycmda7NLTv9nc3g9gOHRiJFM7Q/8YBxfzsIXjmUZMDwGiyLB
	EBLBJ1Lz5CSlhhPKAwqlB4lvZehY6hWC46YXUNa9b4c7FJm+Aej1SBcVKqAOsBbHZKkf
	HEIk5BTjhWAUvdMTsVDtI5r4lkuZ1vcV9HJ6jrp9FhvBD5jIGWQsLfNSa/TxeWpfm8vH
	78MV0sxjBxAVfhV2obLp3ihhxjE/TavdoCbgt86dMvIQZVUYSAislUAewcQZzsLeU6wC
	SQZQDgQdczbuisFEe5u/1w2dm42LLOk65wsJBKCIWQcprtEytFrf+5mgihSSeiZZbC/1
	mUdQ==
X-Gm-Message-State: ABuFfojryWQhRo13II7BlpiBVBYli3qwDj73BzblRWsDPonC/ETrWMoY
	xXZkm0xWn4nK2mmgg1qxN+uDUdjJJk8=
X-Google-Smtp-Source: ACcGV634wHVTcfVepBA60Zsgl86lfOwFo5qHx24NERRpQEugJabYbcAs/jSznmeTNLxn5GG0fgd1BA==
X-Received: by 2002:adf:8103:: with SMTP id
	3-v6mr26928592wrm.106.1539854573369; 
	Thu, 18 Oct 2018 02:22:53 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x17-v6sm17666494wrs.84.2018.10.18.02.22.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 02:22:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2018 10:22:44 +0100
Message-Id: <20181018092246.1445-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 5/7] bitbake: data: Ensure task checksums account for remove data
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
X-List-Received-Date: Thu, 18 Oct 2018 09:22:53 -0000

Currently remove operations are not being accounted for in the task
checksums. This is a fairly serious oversight and needs to be fixed.

To do so, we need internal data from getVarFlag combined with the
expanded variable data so that only "active" remove operators are
accounted for in the task checksum. We can get this from the new
optional removes attribute in the returned parser object.

The code can then use the data on active remove operators to account
for the removals in task checksum but only when the removal is active.

We have to be careful here not to reference any expanded data since this
may for example contain build paths. This means we can only map back
and reference the unsplit (and hence unexpanded) remove string which may
expand to multiple removal values.

[YOCTO #12913]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py       | 12 ++++++++++++
 lib/bb/data_smart.py | 27 ++++++++++++++++++---------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index e2700077c3..fde4cba6bb 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -307,6 +307,14 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 return newvalue
             return value + newvalue
 
+        def handle_remove(value, deps, removes, d):
+            for r in sorted(removes):
+                r2 = d.expandWithRefs(r, None)
+                value += "\n_remove of %s" % r
+                deps |= r2.references
+                deps = deps | (keys & r2.execs)
+            return value
+
         if "vardepvalue" in varflags:
             value = varflags.get("vardepvalue")
         elif varflags.get("func"):
@@ -327,6 +335,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 deps = deps | parsedvar.references
                 deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
                 value = handle_contains(value, parsedvar.contains, d)
+                if hasattr(parsedvar, "removes"):
+                    value = handle_remove(value, deps, parsedvar.removes, d)
             if vardeps is None:
                 parser.log.flush()
             if "prefuncs" in varflags:
@@ -340,6 +350,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             value = handle_contains(value, parser.contains, d)
+            if hasattr(parser, "removes"):
+                value = handle_remove(value, deps, parser.removes, d)
 
         if "vardepvalueexclude" in varflags:
             exclude = varflags.get("vardepvalueexclude")
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4ad0567c9a..8c4c6a9a32 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -805,7 +805,7 @@ class DataSmart(MutableMapping):
             value = parser.value
 
         if value and flag == "_content" and local_var is not None and "_remove" in local_var and not parsing:
-            removes = []
+            removes = {}
             self.need_overrides()
             for (r, o) in local_var["_remove"]:
                 match = True
@@ -814,14 +814,23 @@ class DataSmart(MutableMapping):
                         if not o2 in self.overrides:
                             match = False                            
                 if match:
-                    removes.extend(self.expand(r).split())
-
-            if removes:
-                filtered = filter(lambda v: v not in removes,
-                                  __whitespace_split__.split(value))
-                value = "".join(filtered)
-                if parser:
-                    parser.value = value
+                    removes[r] = self.expand(r).split()
+
+            if removes and parser:
+                parser.removes = set()
+                val = ""
+                for v in __whitespace_split__.split(parser.value):
+                    skip = False
+                    for r in removes:
+                        if v in removes[r]:
+                            parser.removes.add(r)
+                            skip = True
+                    if skip:
+                        continue
+                    val = val + v
+                parser.value = val
+                if expand:
+                    value = parser.value
 
         if parser:
             self.expand_cache[cachename] = parser
-- 
2.17.1


