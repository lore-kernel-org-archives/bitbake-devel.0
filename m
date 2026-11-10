Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1057.1794329456008441105
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2026 08:50:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lab126.com header.s=amazoncorp2 header.b=nMBZy3iY;
 spf=pass (domain: lab126.com, ip: 44.246.77.92, mailfrom: prvs=7673f2358=kpoduval@lab126.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1794329456; x=1825865456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fi2ugG5TcFE7ytlkMSTjqC++duRf6SjOJciSqTTmIEQ=;
  b=nMBZy3iYjgKnv4va+9SwmOKVKcTpfQYFWeK/RPOqvZoUuXJENgSNrK6O
   93ZdSveu+l/VUnrTo68Ih3L8RydIy48fFIhJbURUd2Lv0kJgIy8HIIJXo
   TkmSlJb1ZAx/L957UN6dJCVJJFlHJKgzwrud8KvGMAnowmRE++zdYweQ/
   dFMsaeqpKGENTeczVOsMBX17X6uHnlOOiqslzna+8sm5uaJSVrYlPQNl9
   QPiUXfCox9TvF/O6+hicQh1XFTUEjnSIry0TutnsidzVAdxoSmRBwryzM
   h9DB9ByQc4Ng0uhWO9BTdfZOLqxdqeBN3o7SDUFYySPbH/HCNF24k2QCd
   A==;
X-CSE-ConnectionGUID: P63XA1NMSJytQz8ujOMeOw==
X-CSE-MsgGUID: bWIVEWuiQDqLNIAsQ+gvBg==
X-IronPort-AV: E=Sophos;i="6.27,206,1787011200"; 
   d="scan'208";a="33631807"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 16:50:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:24785]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id d2357355-8b55-4b83-85dd-978c229889bf; Tue, 10 Nov 2026 16:50:54 +0000 (UTC)
X-Farcaster-Flow-ID: d2357355-8b55-4b83-85dd-978c229889bf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 16:50:54 +0000
Received: from u1cb251c9c70150.ant.amazon.com (10.68.99.17) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 16:50:51 +0000
From: <kpoduval@lab126.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Karthik Poduval <kpoduval@lab126.com>, <armccurdy@gmail.com>,
	<richard.purdie@linuxfoundation.org>,
	<stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2] fetch/s3: fetch via boto3 by default, falling back to the AWS CLI
Date: Tue, 10 Nov 2026 08:50:38 -0800
Message-ID: <20261110165039.504722-1-kpoduval@lab126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105012522.878275-1-kpoduval@lab126.com>
References: <20261105012522.878275-1-kpoduval@lab126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: kpoduval@lab126.com
X-Originating-IP: [10.68.99.17]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 16:50:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20414
Content-Type: text/plain; charset="utf-8"

From: Karthik Poduval <kpoduval@lab126.com>

From: Karthik Poduval <kpoduval@lab126.com>

The S3 fetcher shells out to the AWS CLI ("aws s3 cp" / "aws s3 ls") once
per object. For an sstate mirror made of many small objects this is slow:
every invocation pays the Python interpreter + botocore import startup
(~0.5s), re-resolves credentials and configuration, and opens a fresh TLS
connection. Measured against an S3 sstate mirror, "aws s3 ls" costs ~0.9s
per object; with thousands of setscene lookups this dominates wall time.

Fetch with the boto3 SDK in-process instead. A single S3 client is cached
for the lifetime of the (worker) process, so credentials are resolved once
and the HTTPS connection pool stays warm across many fetches
(max_pool_connections raised to 50). On a real build this cut per-object S3
lookups from ~0.9s to ~0.08s warm (~11x) and reduced a core-image-minimal
build from ~20 min to ~9 min with 100% sstate reuse and no fetch errors.

The fetcher is split into two backends sharing a common base class (S3Boto
and S3CLI, both deriving from S3Common); the concrete class is selected once
at import time, preferring boto3 and falling back to the AWS CLI when boto3
is not importable. There is therefore no new hard dependency for existing
users.

Also fix a double-encoding bug exposed by the SDK path: bitbake's mirror
rewriting percent-encodes characters such as ':' in sstate object names (as
%3A). The AWS CLI happened to tolerate this, but boto3 re-encodes the key
when signing, so the object key must be unquoted before the boto3 call or S3
returns 400 Bad Request on every lookup.

Region and profile are resolved from the datastore and then the standard AWS
environment variables, with ~/.aws/config honoured by boto3. Credential
retrieval is retried with exponential backoff and jitter so a transient
credential_process rate limit does not fail a setscene task. head_object
404s (ordinary sstate misses) are logged at debug level; other errors are
surfaced as notes.

This change was developed with AI assistance; the AI-Generated tag below
identifies the tooling used. The author has reviewed, tested and takes
responsibility for the change.

AI-Generated: Kiro, Claude Opus 4.8
Signed-off-by: Karthik Poduval <kpoduval@lab126.com>
---
v2:
- Split the fetcher into an S3Common base with S3Boto and S3CLI backends
  selected once at import time, instead of branching on boto3 availability
  inside each method (per review feedback from Ross Burton).
- Reworded the credential-handling comments to describe the mechanism in
  generic terms (a credential_process profile) rather than naming specific
  credential tooling.
- Built the AWS CLI commands as argument lists, matching the current
  list-based fetcher convention, rather than shell strings.
No change to the boto3 fetch behaviour.

 lib/bb/fetch/s3.py | 227 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 209 insertions(+), 18 deletions(-)

diff --git a/lib/bb/fetch/s3.py b/lib/bb/fetch/s3.py
index ea3dc28fc..4df582a0b 100644
--- a/lib/bb/fetch/s3.py
+++ b/lib/bb/fetch/s3.py
@@ -1,8 +1,23 @@
 """
 BitBake 'Fetch' implementation for Amazon AWS S3.
 
-Class for fetching files from Amazon S3 using the AWS Command Line Interface.
-The aws tool must be correctly installed and configured prior to use.
+Class for fetching files from Amazon S3.
+
+Two backends are provided and one is selected automatically when the module is
+imported:
+
+  S3Boto (preferred)
+      Fetch in-process with the boto3 SDK, talking to S3 over HTTPS natively
+      (no per-object subprocess / AWS CLI startup cost). This is a big win for
+      sstate mirrors, where thousands of small objects are fetched and the AWS
+      CLI's interpreter + config/credential resolution startup dominates wall
+      time. Selected when boto3 is importable.
+
+  S3CLI (fallback)
+      Fetch by shelling out to the AWS CLI ("aws s3 cp" / "aws s3 ls"). This is
+      the original behaviour and requires no extra Python packages; the aws
+      tool must be installed and configured. Selected when boto3 is not
+      importable, so there is no new hard dependency.
 
 """
 
@@ -17,6 +32,8 @@ The aws tool must be correctly installed and configured prior to use.
 
 import os
 import bb
+import time
+import random
 import urllib.request, urllib.parse, urllib.error
 import re
 import shlex
@@ -24,6 +41,13 @@ from bb.fetch import FetchMethod
 from bb.fetch import FetchError
 from bb.fetch import runfetchcmd
 
+try:
+    import boto3
+    import botocore
+except ImportError:
+    boto3 = None
+
+
 def convertToBytes(value, unit):
     value = float(value)
     if (unit == "KiB"):
@@ -60,8 +84,107 @@ class S3ProgressHandler(bb.progress.LineFilterProgressHandler):
         return True
 
 
-class S3(FetchMethod):
-    """Class to fetch urls via 'aws s3'"""
+# Cache a single boto3 S3 client for the lifetime of the (worker) process.
+# Creating a client resolves credentials and config once; reusing it keeps the
+# underlying HTTPS connection pool warm across many small fetches.
+#
+# NOTE: bitbake runs setscene fetches in SEPARATE worker processes, so this
+# cache is per-process, not global to the build. Credentials must come from a
+# source that AUTO-REFRESHES, because a Yocto build runs for hours and any
+# static/temporary credential (e.g. a fixed access key written into
+# ~/.aws/credentials [default]) can EXPIRE partway through -- after which S3
+# returns "400 Bad Request" on every call and all setscene tasks fail.
+#
+# The robust source is a `credential_process` profile: boto3 invokes it on
+# demand and re-vends when the token nears expiry. We therefore resolve
+# AWS_PROFILE from the bitbake datastore (or the environment) and pin it on the
+# session, so the worker uses that auto-refreshing profile instead of a stale
+# static [default]. Set AWS_PROFILE for the build (e.g. via
+# BB_ENV_PASSTHROUGH_ADDITIONS so it survives bitbake's worker env scrubbing)
+# to a profile whose [profile ...] entry in ~/.aws/config uses
+# credential_process.
+#
+# A credential_process helper that caches vended credentials on disk will
+# mostly serve them from that warm cache rather than from its backing service;
+# the backoff below still covers a transient "Rate exceeded" during a
+# cold-cache storm.
+_s3_client = None
+
+def _get_s3_client(d):
+    global _s3_client
+    if _s3_client is None:
+        # Resolve region from the usual env vars; boto3 also honours
+        # ~/.aws/config and AWS_CONFIG_FILE. (S3 handles cross-region HEAD/GET,
+        # so an exact match is not required, but pinning avoids surprises.)
+        region = (d.getVar("AWS_DEFAULT_REGION")
+                  or os.environ.get("AWS_DEFAULT_REGION")
+                  or os.environ.get("AWS_REGION"))
+        # Resolve the AWS profile to use. Pinning it defeats a stale/expired
+        # static [default] in ~/.aws/credentials shadowing the auto-refreshing
+        # credential_process -- the exact cause of mid-build "400 Bad Request"
+        # failures. d.getVar wins so it works even when the env is scrubbed in
+        # a worker; env is the fallback when it is passed through.
+        profile = (d.getVar("AWS_PROFILE")
+                   or os.environ.get("AWS_PROFILE")
+                   or os.environ.get("AWS_DEFAULT_PROFILE"))
+        # Allow more concurrent connections than the default (10) so parallel
+        # fetches within a process share a healthy pool. The 'retries' here
+        # applies to S3 API calls only, NOT to credential resolution.
+        cfg = botocore.config.Config(
+            max_pool_connections=50,
+            retries={"max_attempts": 5, "mode": "standard"},
+        )
+
+        # Credential resolution happens lazily on first API call OR eagerly in
+        # client(); either way a credential_process "Rate exceeded" surfaces as
+        # CredentialRetrievalError. Retry client creation + a cheap credential
+        # resolution with exponential backoff + jitter so a transient
+        # credential-service rate limit does not fail the whole setscene task.
+        attempts = int(d.getVar("S3_CRED_MAX_ATTEMPTS") or 6)
+        last_exc = None
+        for attempt in range(attempts):
+            try:
+                session = boto3.session.Session(profile_name=profile, region_name=region)
+                client = session.client("s3", config=cfg)
+                # Force credential resolution now so we retry it here rather
+                # than failing deep inside a download/head call.
+                creds = session.get_credentials()
+                # One-time-per-worker diagnostic: which credential source won,
+                # the profile, and the region. Tells us whether the worker
+                # picked the auto-refreshing credential_process profile or fell
+                # back to a stale static default.
+                try:
+                    method = getattr(creds, "method", None) if creds else "NONE"
+                    bb.debug(1, "S3 fetcher: credential method=%s profile=%s region=%s"
+                             % (method, profile, client.meta.region_name))
+                except Exception:
+                    pass
+                _s3_client = client
+                break
+            except botocore.exceptions.CredentialRetrievalError as e:
+                last_exc = e
+                if attempt == attempts - 1:
+                    break
+                # Exponential backoff with jitter: 0.5,1,2,4,8s (+/- jitter),
+                # capped. Spreads out many workers refreshing credentials at once.
+                delay = min(2.0 ** attempt * 0.5, 15.0)
+                delay += random.uniform(0, delay / 2.0)
+                bb.note("S3 fetcher: credential retrieval rate-limited "
+                        "(attempt %d/%d), backing off %.1fs: %s"
+                        % (attempt + 1, attempts, delay, e))
+                time.sleep(delay)
+        if _s3_client is None:
+            raise FetchError("S3 fetcher could not obtain AWS credentials after "
+                             "%d attempts. Set AWS_PROFILE to a profile whose "
+                             "~/.aws/config entry uses credential_process (which "
+                             "auto-refreshes), and ensure it is in the bitbake "
+                             "env passthrough. Last error: %s"
+                             % (attempts, last_exc))
+    return _s3_client
+
+
+class S3Common(FetchMethod):
+    """Behaviour shared by the S3 fetcher backends (S3Boto and S3CLI)."""
 
     def supports(self, ud, d):
         """
@@ -80,46 +203,114 @@ class S3(FetchMethod):
 
         ud.localfile = ud.basename
 
-        ud.basecmd = shlex.split(d.getVar("FETCHCMD_s3") or "") or ["aws", "s3"]
-
     def download(self, ud, d):
         """
         Fetch urls
         Assumes localpath was called first
         """
-
-        cmd = ud.basecmd + ['cp', 's3://%s%s' % (ud.host, ud.path), ud.localpath]
-        bb.fetch.check_network_access(d, cmd, ud.url)
-
-        progresshandler = S3ProgressHandler(d)
-        runfetchcmd(cmd, d, False, log=progresshandler)
+        self._fetch(ud, d)
 
         # Additional sanity checks copied from the wget class (although there
-        # are no known issues which mean these are required, treat the aws cli
-        # tool with a little healthy suspicion).
+        # are no known issues which mean these are required, treat the fetch
+        # result with a little healthy suspicion).
 
         if not os.path.exists(ud.localpath):
-            raise FetchError("The aws cp command returned success for s3://%s%s but %s doesn't exist?!" % (ud.host, ud.path, ud.localpath))
+            raise FetchError("The s3 fetch returned success for s3://%s%s but %s doesn't exist?!" % (ud.host, ud.path, ud.localpath))
 
         if os.path.getsize(ud.localpath) == 0:
             os.remove(ud.localpath)
-            raise FetchError("The aws cp command for s3://%s%s resulted in a zero size file?! Deleting and failing since this isn't right." % (ud.host, ud.path))
+            raise FetchError("The s3 fetch for s3://%s%s resulted in a zero size file?! Deleting and failing since this isn't right." % (ud.host, ud.path))
 
         return True
 
+
+class S3Boto(S3Common):
+    """Fetch urls in-process using the boto3 SDK."""
+
+    def _fetch(self, ud, d):
+        client = _get_s3_client(d)
+        # ud.host is the bucket; ud.path starts with "/" so strip it for the
+        # key. ud.path is percent-encoded (bitbake's mirror rewrite encodes the
+        # ':' in sstate names as %3A); boto3 wants the RAW, decoded key and does
+        # its own signing-time encoding, so decode here or S3 returns 400 Bad
+        # Request from the double-encoding.
+        bucket = ud.host
+        key = urllib.parse.unquote(ud.path.lstrip('/'))
+
+        bb.fetch.check_network_access(d, "boto3 get_object s3://%s/%s" % (bucket, key), ud.url)
+
+        try:
+            client.download_file(bucket, key, ud.localpath)
+        except (botocore.exceptions.ClientError, botocore.exceptions.BotoCoreError) as e:
+            raise FetchError("The boto3 download for s3://%s/%s failed: %s" % (bucket, key, e))
+
     def checkstatus(self, fetch, ud, d):
         """
         Check the status of a URL
         """
+        client = _get_s3_client(d)
+        bucket = ud.host
+        # See _fetch: decode the percent-encoded key for boto3.
+        key = urllib.parse.unquote(ud.path.lstrip('/'))
+
+        bb.fetch.check_network_access(d, "boto3 head_object s3://%s/%s" % (bucket, key), ud.url)
+
+        try:
+            client.head_object(Bucket=bucket, Key=key)
+        except botocore.exceptions.ClientError as e:
+            # A 404 is an ordinary sstate miss (object not in the mirror) and is
+            # expected for any task the mirror wasn't populated for -- log it at
+            # debug level only so normal misses don't flood the console. Any
+            # other code (400/403/5xx) is a real problem: surface it as a note.
+            err = e.response.get("Error", {})
+            meta = e.response.get("ResponseMetadata", {})
+            status = meta.get("HTTPStatusCode")
+            detail = ("head_object s3://%s/%s -> code=%s status=%s msg=%r reqid=%s"
+                      % (bucket, key, err.get("Code"), status,
+                         err.get("Message"), meta.get("RequestId")))
+            if status == 404:
+                bb.debug(2, "S3 fetcher: miss (404) s3://%s/%s" % (bucket, key))
+            else:
+                bb.note("S3 fetcher: %s" % detail)
+            raise FetchError("The boto3 head_object for s3://%s/%s failed: %s" % (bucket, key, e))
+        except botocore.exceptions.BotoCoreError as e:
+            raise FetchError("The boto3 head_object for s3://%s/%s failed: %s" % (bucket, key, e))
+        return True
+
+
+class S3CLI(S3Common):
+    """Fetch urls by shelling out to the AWS CLI ('aws s3')."""
+
+    def urldata_init(self, ud, d):
+        super().urldata_init(ud, d)
+        ud.basecmd = shlex.split(d.getVar("FETCHCMD_s3") or "") or ["aws", "s3"]
+
+    def _fetch(self, ud, d):
+        cmd = ud.basecmd + ['cp', 's3://%s%s' % (ud.host, ud.path), ud.localpath]
+        bb.fetch.check_network_access(d, cmd, ud.url)
 
+        progresshandler = S3ProgressHandler(d)
+        runfetchcmd(cmd, d, False, log=progresshandler)
+
+    def checkstatus(self, fetch, ud, d):
+        """
+        Check the status of a URL
+        """
         cmd = ud.basecmd + ['ls', 's3://%s%s' % (ud.host, ud.path)]
         bb.fetch.check_network_access(d, cmd, ud.url)
         output = runfetchcmd(cmd, d)
 
         # "aws s3 ls s3://mybucket/foo" will exit with success even if the file
         # is not found, so check output of the command to confirm success.
-
         if not output:
             raise FetchError("The aws ls command for s3://%s%s gave empty output" % (ud.host, ud.path))
-
         return True
+
+
+# Pick the backend once, at import time: prefer boto3, fall back to the AWS CLI
+# when boto3 is not importable. bb.fetch registers s3.S3, so this selection is
+# transparent to the rest of bitbake.
+if boto3 is not None:
+    S3 = S3Boto
+else:
+    S3 = S3CLI
-- 
2.43.0

