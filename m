Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web08.21058.1612710123677792361
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Feb 2021 07:02:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=E+iyWiZz;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: schnitzeltony@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id u14so10768839wmq.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 07 Feb 2021 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGiRaOYdP6d5BYYUdYrr2f3uk/Mp9wsPB3aTlBNJuGc=;
        b=E+iyWiZzwVxCnyhWjIwqaDZcg8aravB7YKvR9GXGCfWu2OVLqtgyPnHfQ/Rqp5Ehyv
         ej8pu9WjduXunqpQrCZNlYEoCdcSLrIAjcZPIdhHZX9bQfXOgEK8SfYrL+8Vn+Xwta2I
         YHoZV07+EJ/WZR6s/2aWMri/T2vEU3JgA8e9f9vPBRgcS4cl28DOFiZ5EAHO0BdsemEr
         hBrG5JpqBTggY3pLZ+Sev+VDwfZKmV2YY+Hbg/6T4zroIQJ3E6LecRuZRfkNXdiZAtIT
         H74QdR/pm0k2gD78OMt4Fb8acqhwFaqDjK2AByH4MTtNeRBD//EwO6DJid1ELwjGKZoh
         1n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGiRaOYdP6d5BYYUdYrr2f3uk/Mp9wsPB3aTlBNJuGc=;
        b=JraFMXNszhsknmS0M6RuU6zC0JcrKWHeJg8yY0Vj46buvP9JV0EHwngQ/n/o2IrbdS
         Fu/37Yc94U8PY3msCRVRMPEYLswTCrTlcu3vgQSub1DHR/kZyiJi19w8/MyShDILRIza
         F59qvGRk2HH/i7ev6GJwvQa1YU5zUkeh12bajcUChQuXapY0WVJVK6N+oGcaAy6sWe5R
         JIhJweMXyT9m6Q6JYo+f9N/mmhvlb9s3p7G+fa11k+yq3t1LKd+52boU5OW3kaGZ5oEf
         FpxNUKugUvJDxVINmIAIrYOyqoDyo7zYJlPQifPD5hQs1KwBdqqnAnept8cKxNmNcCfM
         yWRw==
X-Gm-Message-State: AOAM5335YW0Yef7nOCMFlELAuWd+aMN2+hYiusnohelfE7leGqyP78tK
	gB7gQLvzrbCKDp1hjd80VIJTpNWEvvQ=
X-Google-Smtp-Source: ABdhPJxQ5QvUTCE0sCWNUARfRD2aqaPN1Z8Cljz7Ye7/plWPP922tCGE8z5w4Nh6dWZbN171/OOm4A==
X-Received: by 2002:a05:600c:4242:: with SMTP id r2mr2785783wmm.109.1612710122240;
        Sun, 07 Feb 2021 07:02:02 -0800 (PST)
Return-Path: <schnitzeltony@gmail.com>
Received: from superandy.speedport.ip (p200300f07f44b13017fa725760fbfa73.dip0.t-ipconnect.de. [2003:f0:7f44:b130:17fa:7257:60fb:fa73])
        by smtp.gmail.com with ESMTPSA id 9sm24229114wra.80.2021.02.07.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:02:01 -0800 (PST)
From: =?UTF-8?B?QW5kcmVhcyBNw7xsbGVy?= <schnitzeltony@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com,
	randy.macleod@windriver.com,
	ross.burton@arm.com
Subject: [RFC-cargo-fetcher 3/3] Add a fetcher for cargo crates
Date: Sun,  7 Feb 2021 16:01:47 +0100
Message-Id: <20210207150147.31011-4-schnitzeltony@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210207150147.31011-1-schnitzeltony@gmail.com>
References: <20210207150147.31011-1-schnitzeltony@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Parse Cargo.lock, download crates and generate cargo cache as 'cargo fetch'
would do.

Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
---
 lib/bb/fetch2/__init__.py  |   2 +
 lib/bb/fetch2/cratelock.py | 268 +++++++++++++++++++++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 lib/bb/fetch2/cratelock.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8f535b61..43c07a58 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1909,6 +1909,7 @@ from . import clearcase
 from . import npm
 from . import npmsw
 from . import crateindex
+from . import cratelock
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1929,3 +1930,4 @@ methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
 methods.append(npmsw.NpmShrinkWrap())
 methods.append(crateindex.CrateIndex())
+methods.append(cratelock.CrateLock())
diff --git a/lib/bb/fetch2/cratelock.py b/lib/bb/fetch2/cratelock.py
new file mode 100644
index 00000000..19f71363
--- /dev/null
+++ b/lib/bb/fetch2/cratelock.py
@@ -0,0 +1,268 @@
+"""
+BitBake 'Fetch' cratelock implementation
+
+cratelock downloads crates based upon information found in Cargo.lock (or any
+other file with Cargo.lock toml format). It mimics cargo fetch so all further
+calls of cargo can be done as:
+
+export CARGO_HOME="${DL_DIR}/cargo"
+export CARGO_TARGET_DIR="${B}"
+cargo build --frozen
+
+The crate-fetch part can be found in cratelock.py.
+
+SRC_URI = "cratelock://Cargo.lock"
+
+Supported SRC_URI options are:
+
+- destsuffix
+    Specifies the directory to install Cargo lock (default: ${S}).
+- cargoindexhash
+    Cargo generates hash from download location of index [1]. So as long
+    as we use the official index at github.com/rust-lang/crates.io-index
+    the hash can be considered constant: 'github.com-1ecc6299db9ec823'
+    which is used as default when not set.
+    [1] https://gitlab.com/kornelski/LTS/-/blob/master/src/hash.rs
+
+"""
+
+# Copyright (C) 2021 Andreas Müller
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import collections
+import errno
+import os
+import re
+import shlex
+import tempfile
+import json
+import toml
+import bb
+import subprocess
+from bb.fetch2 import Fetch
+from bb.fetch2 import FetchError
+from bb.fetch2 import FetchMethod
+from bb.fetch2 import UnpackError
+from bb.fetch2 import MissingParameterError
+from bb.fetch2 import ParameterError
+from bb.fetch2 import URI
+from bb.fetch2 import runfetchcmd
+from bb.fetch2 import subprocess_setup
+from . import git
+
+import toml # see toml/README for further details
+#import pytoml as toml
+
+class CrateLock(FetchMethod):
+    """Class to fetch all crates from a Cargo.lock file"""
+
+    def supports(self, ud, d):
+        """Check if a given url can be fetched with cratelock"""
+        return ud.type in ["cratelock"]
+
+    def urldata_init(self, ud, d):
+        """Init cratelock specific variables within url data"""
+
+        def _append_crate(crate_dict):
+            name = crate_dict["name"]
+            version = crate_dict["version"]
+            source = crate_dict["source"]
+            sourcelist = source.split('+')
+            # fetch from standard registry
+            if len(sourcelist) == 2 and \
+                    "registry" in sourcelist and \
+                    "https://github.com/rust-lang/crates.io-index" in sourcelist:
+                checksum = crate_dict["checksum"]
+                # Crate cache part 1:
+                # Fetch crate from crates.io directly into cargo cache
+                localfile = os.path.join('cargo/registry/cache', ud.cargoindexhash, '%s-%s.crate' % (name, version))
+                uri = URI('https://crates.io/api/v1/crates/%s/%s/download' % (name, version))
+                uri.params["downloadfilename"] = localfile
+                uri.params["sha256sum"] = checksum
+                url = str(uri)
+
+                localpath = os.path.join(d.getVar("DL_DIR"), localfile)
+                ud.crates.append({
+                    "name": name,
+                    "version": version,
+                    "url": url,
+                    "localpath": localpath
+                })
+            else:
+                raise Exception("Unsupported crate download type for %s" % name)
+
+        # Get the 'cratelock' parameter
+        ud.cratelock_file = re.sub(r"^cratelock://", "", ud.url.split(";")[0])
+
+        # get cargoindexhash param or set default for
+        # github.com/rust-lang/crates.io-index
+        ud.cargoindexhash = ud.parm.get("cargoindexhash")
+        if ud.cargoindexhash == None:
+            ud.cargoindexhash = 'github.com-1ecc6299db9ec823'
+
+        # parse cratelock for crates to download
+        ud.crates = []
+        ud.crates_ignored = [] # for debug
+        try:
+            with open(ud.cratelock_file, 'r') as file:
+                toml_string = file.read()
+            toml_dict = toml.loads(toml_string)
+            if not "package" in toml_dict:
+                raise Exception("No 'package' found")
+            # Add the crates we need
+            for crate_dict in toml_dict["package"]:
+                if not "name" in crate_dict or not "version" in crate_dict:
+                    raise Exception("Missing mandatory entries in %s" % json.dumps(crate_dict))
+                # Notes:
+                # * In Cargo.lock dependency entries without 'source' are in-tree
+                #   and must be ignored on fetch/unpack
+                # * 1. It seems the 'dependency' list is an information for cargo to
+                #      build crates in correct order.
+                #   2. All crates are contained in Cargo.lock
+                #   => For fetch/unpack we can ignore 'dependency' and don't need to
+                #      walk down
+                if not "source" in crate_dict:
+                    ud.crates_ignored.append({
+                        "name": crate_dict["name"],
+                        "version": crate_dict["version"]
+                    })
+                else:
+                    _append_crate(crate_dict)
+
+        except Exception as e:
+            raise ParameterError("Invalid cratelock file: %s" % str(e), ud.url)
+
+        # Much of the following was stolen from npmsw.py
+
+        # Avoid conflicts between the environment data and:
+        # - the proxy url revision
+        # - the proxy url checksum
+        data = bb.data.createCopy(d)
+        data.delVar("SRCREV")
+        data.delVarFlags("SRC_URI")
+
+        # This fetcher resolves multiple URIs from a Cargo.lock file and then
+        # forwards it to a proxy fetcher. The management of the donestamp file,
+        # the lockfile and the checksums are forwarded to the proxy fetcher.
+        ud.proxy = Fetch([crate["url"] for crate in ud.crates], data)
+ 
+        # keep done/lock-file out of cargo's cache to avoid confusion
+        ud.bbcachepath = os.path.join(d.getVar("DL_DIR"), 'cargo/bb', ud.cargoindexhash)
+        for proxy_url in ud.proxy.urls:
+            proxy_ud = ud.proxy.ud[proxy_url]
+            basename = os.path.basename(proxy_ud.localpath) # ?? proxy_ud.basename does not work here
+            proxy_ud.donestamp = os.path.join(ud.bbcachepath, basename + '.done')
+            proxy_ud.lockfile = os.path.join(ud.bbcachepath, basename + '.lock')
+
+        ud.needdonestamp = False
+
+    @staticmethod
+    def _foreach_proxy_method(ud, handle):
+        returns = []
+        for proxy_url in ud.proxy.urls:
+            proxy_ud = ud.proxy.ud[proxy_url]
+            proxy_d = ud.proxy.d
+            proxy_ud.setup_localpath(proxy_d)
+            returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+        return returns
+
+    def verify_donestamp(self, ud, d):
+        """Verify the donestamp file"""
+        def _handle(m, ud, d):
+            return m.verify_donestamp(ud, d)
+        return all(self._foreach_proxy_method(ud, _handle))
+
+    def update_donestamp(self, ud, d):
+        """Update the donestamp file"""
+        def _handle(m, ud, d):
+            m.update_donestamp(ud, d)
+        self._foreach_proxy_method(ud, _handle)
+
+    def need_update(self, ud, d):
+        """Force a fetch, even if localpath exists ?"""
+        def _handle(m, ud, d):
+            return m.need_update(ud, d)
+        return all(self._foreach_proxy_method(ud, _handle))
+
+    def try_mirrors(self, fetch, ud, d, mirrors):
+        """Try to use a mirror"""
+        def _handle(m, ud, d):
+            return m.try_mirrors(fetch, ud, d, mirrors)
+        return all(self._foreach_proxy_method(ud, _handle))
+
+    def _crate_src_basepath(self, cargoindexhash, d):
+        return os.path.join(d.getVar("DL_DIR"), 'cargo/registry/src', cargoindexhash)
+
+    def _crate_src_path(self, cargoindexhash, crate, d):
+        return os.path.join(d.getVar("DL_DIR"), 'cargo/registry/src', cargoindexhash, '%s-%s' % (crate['name'], crate['version']))
+
+    def download(self, ud, d):
+        """Fetch url"""
+        ud.proxy.download()
+        # Crate cache part 2:
+        # cached sources
+        basepath = self._crate_src_basepath(ud.cargoindexhash, d)
+        if not os.path.exists(basepath):
+            bb.utils.mkdirhier(basepath)
+        for crate in ud.crates:
+            sourcepath = crate['localpath']
+            targetpath = self._crate_src_path(ud.cargoindexhash, crate, d)
+
+            lockfile = os.path.join(ud.bbcachepath, crate['name'] + '-' + crate['version'] + '-src.lock')
+            lf = bb.utils.lockfile(lockfile)
+            try:
+                if not os.path.exists(targetpath):
+                    cmd = 'tar xz --no-same-owner -f %s' % sourcepath
+                    bb.note("Unpacking %s to %s/" % (sourcepath, basepath))
+                    ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=basepath)
+                    if ret != 0:
+                        raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
+            finally:
+                bb.utils.unlockfile(lf)
+      
+    def unpack(self, ud, rootdir, d):
+        """ Unpack Cargo.lock """
+        lock_forcargo_build = ud.cratelock_file.endswith('Cargo.lock')
+        if lock_forcargo_build:
+            destdir = d.getVar("S")
+        else:
+            destdir = rootdir
+        destsuffix = ud.parm.get("destsuffix")
+        if destsuffix:
+            destdir = os.path.join(rootdir, destsuffix)
+        targetfile = os.path.join(destdir, os.path.basename(ud.cratelock_file))
+
+        # Compare our Cargo.lock with the one shipped by project's sources
+        # and spawn a warning in case they are not same
+        if lock_forcargo_build and os.path.exists(targetfile):
+            with open(ud.cratelock_file, 'r') as file:
+                toml_string = file.read()
+            dict_cargo_lock_bb = toml.loads(toml_string)
+            with open(targetfile, 'r') as file:
+                toml_string = file.read()
+            dict_cargo_lock_shipped = toml.loads(toml_string)
+            if dict_cargo_lock_bb != dict_cargo_lock_shipped:
+                bb.warn("Recipe's Cargo.lock requires update because it has different content than project's Cargo.lock - see %s" % targetfile)
+                # We keep project's Cargo.lock and copy recipe's to WORKDIR so
+                # close to each other - jsut makes it a bit easier to check
+                targetfile = os.path.join(rootdir, os.path.basename(ud.cratelock_file))
+        bb.utils.copyfile(ud.cratelock_file, targetfile)
+        return True
+        
+    def clean(self, ud, d):
+        """Clean any existing full or partial download"""
+        ud.proxy.clean()
+
+        # Clean cached sources
+        for crate in ud.crates:
+            srcpath = self._crate_src_path(ud.cargoindexhash, crate, d)
+            if os.path.exists(srcpath):
+                bb.utils.remove(srcpath, True)
+
+    def done(self, ud, d):
+        """Is the download done ?"""
+        def _handle(m, ud, d):
+            return m.done(ud, d)
+        return all(self._foreach_proxy_method(ud, _handle))
-- 
2.26.2

