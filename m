Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
	[209.85.166.49])
	by mail.openembedded.org (Postfix) with ESMTP id DEA9D7BB93;
	Fri,  4 Jan 2019 02:42:39 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id l14so28561953ioj.5;
	Thu, 03 Jan 2019 18:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GcYEop0VYoRucYL6y6ObFkeWD/tn022yJ1x+Jnm8Uk8=;
	b=bgXigaMOCYgYv3Uvatl5oNAPJd8NbR37jKqVaJVCfYYygdOn2XCHwL4FngmIoppJ0q
	TtKLBy2vorZjQwldOUBgSXCOPIk8rea3BAFqbEKIwqSy7Bbsu1Nu2GYX2HSUnfVaHySU
	kxP3w4dn1bXHwM6N/n7NTio2xUq06LaKOc/ckxMZY4lDf7sa4DTMmGMDhsoZmaCcxg4/
	KUTj6WKUZxoAbnvEp4aVDoo9dYqqkiovBE/Srm4GthaO/wB/aDTnKvVskIQyk8wz+SJb
	yAD8ALKo2yHtomjrdvfncnHW8WlzgxFPaPYEHQs4GiYNhQqICxW7c6mjP0ZuAbn1nE13
	Qa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=GcYEop0VYoRucYL6y6ObFkeWD/tn022yJ1x+Jnm8Uk8=;
	b=CXgYni7Gewwcl/Y3Hv+kOBeL67roknjgMer6GWqaxP1hnYStBL9VuccIC9QHPTocib
	MediJ+MwhwhexQzPPxu7tS+zbd5p4ONJmf3pn/7Re6Ug1sMPwDXYJKGjqH50DNtX/oCS
	Gy3HBCq5upQQw8jc/JnEQMF+3H4GWsCtPc5N4YUoVF18gSQqOPpn2zXR7wL5NBeh3tUW
	hiJukxxAy+V06i90OzAljUrEALrU1MgLIU+YK+ohOQXBlmB2u0GKl16pPuFmULGZQGOB
	rekQjNShdga7axUS0Ng86xCoBfzV8kGuVsGsWtQYTHLnq/giVEwrzNi6MPlrUBob8AxZ
	i+fQ==
X-Gm-Message-State: AJcUukcEdNhnVvD6n+Mi9CYy2EBiuT9Tq1jA3iTXcS7DmHo7JlFvsSVl
	a81vY5gDjnVqnJIotPEU0TazXbXX
X-Google-Smtp-Source: ALg8bN7F+VMTxlf0FCitID6lMMXCcNzdp4kNscT1OC4JhJ3pELVJYas4OwncPkG4cqfo28ZciqKRig==
X-Received: by 2002:a5e:d503:: with SMTP id e3mr22073122iom.291.1546569760492; 
	Thu, 03 Jan 2019 18:42:40 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id h2sm21864980itk.0.2019.01.03.18.42.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Jan 2019 18:42:39 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  3 Jan 2019 20:42:17 -0600
Message-Id: <20190104024217.3316-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104024217.3316-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20190104024217.3316-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v6 3/3] sstate: Implement hash equivalence sstate
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
X-List-Received-Date: Fri, 04 Jan 2019 02:42:40 -0000
Content-Transfer-Encoding: 8bit

Converts sstate so that it can use a hash equivalence server to
determine if a task really needs to be rebuilt, or if it can be restored
from a different (equivalent) sstate object.

The unique hashes are cached persistently using persist_data. This has
a number of advantages:
 1) Unique hashes can be cached between invocations of bitbake to
    prevent needing to contact the server every time (which is slow)
 2) The value of each tasks unique hash can easily be synchronized
    between different threads, which will be useful if bitbake is
    updated to do on the fly task re-hashing.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 100 +++++++++++++++++++--
 meta/conf/bitbake.conf      |   4 +-
 meta/lib/oe/sstatesig.py    | 167 ++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 9 deletions(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 8f3cd083e85..46dbe7cb96d 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -11,7 +11,7 @@ def generate_sstatefn(spec, hash, d):
 SSTATE_PKGARCH    = "${PACKAGE_ARCH}"
 SSTATE_PKGSPEC    = "sstate:${PN}:${PACKAGE_ARCH}${TARGET_VENDOR}-${TARGET_OS}:${PV}:${PR}:${SSTATE_PKGARCH}:${SSTATE_VERSION}:"
 SSTATE_SWSPEC     = "sstate:${PN}::${PV}:${PR}::${SSTATE_VERSION}:"
-SSTATE_PKGNAME    = "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.getVar('SSTATE_PKGSPEC'), d.getVar('BB_TASKHASH'), d)}"
+SSTATE_PKGNAME    = "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.getVar('SSTATE_PKGSPEC'), d.getVar('BB_UNIHASH'), d)}"
 SSTATE_PKG        = "${SSTATE_DIR}/${SSTATE_PKGNAME}"
 SSTATE_EXTRAPATH   = ""
 SSTATE_EXTRAPATHWILDCARD = ""
@@ -82,6 +82,23 @@ SSTATE_SIG_PASSPHRASE ?= ""
 # Whether to verify the GnUPG signatures when extracting sstate archives
 SSTATE_VERIFY_SIG ?= "0"
 
+SSTATE_HASHEQUIV_METHOD ?= "OEOuthashBasic"
+SSTATE_HASHEQUIV_METHOD[doc] = "The function used to calculate the output hash \
+    for a task, which in turn is used to determine equivalency. \
+    "
+
+SSTATE_HASHEQUIV_SERVER ?= ""
+SSTATE_HASHEQUIV_SERVER[doc] = "The hash equivalence sever. For example, \
+    'http://192.168.0.1:5000'. Do not include a trailing slash \
+    "
+
+SSTATE_HASHEQUIV_REPORT_TASKDATA ?= "0"
+SSTATE_HASHEQUIV_REPORT_TASKDATA[doc] = "Report additional useful data to the \
+    hash equivalency server, such as PN, PV, taskname, etc. This information \
+    is very useful for developers looking at task data, but may leak sensitive \
+    data if the equivalence server is public. \
+    "
+
 python () {
     if bb.data.inherits_class('native', d):
         d.setVar('SSTATE_PKGARCH', d.getVar('BUILD_ARCH', False))
@@ -640,7 +657,7 @@ def sstate_package(ss, d):
         return
 
     for f in (d.getVar('SSTATECREATEFUNCS') or '').split() + \
-             ['sstate_create_package', 'sstate_sign_package'] + \
+             ['sstate_report_unihash', 'sstate_create_package', 'sstate_sign_package'] + \
              (d.getVar('SSTATEPOSTCREATEFUNCS') or '').split():
         # All hooks should run in SSTATE_BUILDDIR.
         bb.build.exec_func(f, d, (sstatebuild,))
@@ -764,6 +781,73 @@ python sstate_sign_package () {
                            d.getVar('SSTATE_SIG_PASSPHRASE'), armor=False)
 }
 
+def OEOuthashBasic(path, sigfile, task, d):
+    import hashlib
+    import stat
+
+    def update_hash(s):
+        s = s.encode('utf-8')
+        h.update(s)
+        if sigfile:
+            sigfile.write(s)
+
+    h = hashlib.sha256()
+    prev_dir = os.getcwd()
+
+    try:
+        os.chdir(path)
+
+        update_hash("OEOuthashBasic\n")
+
+        # It is only currently useful to get equivalent hashes for things that
+        # can be restored from sstate. Since the sstate object is named using
+        # SSTATE_PKGSPEC and the task name, those should be included in the
+        # output hash calculation.
+        update_hash("SSTATE_PKGSPEC=%s\n" % d.getVar('SSTATE_PKGSPEC'))
+        update_hash("task=%s\n" % task)
+
+        for root, dirs, files in os.walk('.', topdown=True):
+            # Sort directories and files to ensure consistent ordering
+            dirs.sort()
+            files.sort()
+
+            for f in files:
+                path = os.path.join(root, f)
+                s = os.lstat(path)
+
+                # Hash file path
+                update_hash(path + '\n')
+
+                # Hash file mode
+                update_hash("\tmode=0x%x\n" % stat.S_IMODE(s.st_mode))
+                update_hash("\ttype=0x%x\n" % stat.S_IFMT(s.st_mode))
+
+                if stat.S_ISBLK(s.st_mode) or stat.S_ISBLK(s.st_mode):
+                    # Hash device major and minor
+                    update_hash("\tdev=%d,%d\n" % (os.major(s.st_rdev), os.minor(s.st_rdev)))
+                elif stat.S_ISLNK(s.st_mode):
+                    # Hash symbolic link
+                    update_hash("\tsymlink=%s\n" % os.readlink(path))
+                else:
+                    fh = hashlib.sha256()
+                    # Hash file contents
+                    with open(path, 'rb') as d:
+                        for chunk in iter(lambda: d.read(4096), b""):
+                            fh.update(chunk)
+                    update_hash("\tdigest=%s\n" % fh.hexdigest())
+    finally:
+        os.chdir(prev_dir)
+
+    return h.hexdigest()
+
+python sstate_report_unihash() {
+    report_unihash = getattr(bb.parse.siggen, 'report_unihash', None)
+
+    if report_unihash:
+        ss = sstate_state_fromvars(d)
+        report_unihash(os.getcwd(), ss['task'], d)
+}
+
 #
 # Shell function to decompress and prepare a package for installation
 # Will be run from within SSTATE_INSTDIR.
@@ -810,7 +894,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *,
 
         spec, extrapath, tname = getpathcomponents(task, d)
 
-        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + extension)
+        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath + generate_sstatefn(spec, sq_unihash[task], d) + "_" + tname + extension)
 
         if os.path.exists(sstatefile):
             bb.debug(2, "SState: Found valid sstate file %s" % sstatefile)
@@ -872,7 +956,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *,
             if task in ret:
                 continue
             spec, extrapath, tname = getpathcomponents(task, d)
-            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + extension)
+            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_unihash[task], d) + "_" + tname + extension)
             tasklist.append((task, sstatefile))
 
         if tasklist:
@@ -898,12 +982,12 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *,
         evdata = {'missed': [], 'found': []};
         for task in missed:
             spec, extrapath, tname = getpathcomponents(task, d)
-            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + ".tgz")
-            evdata['missed'].append( (sq_fn[task], sq_task[task], sq_hash[task], sstatefile ) )
+            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_unihash[task], d) + "_" + tname + ".tgz")
+            evdata['missed'].append( (sq_fn[task], sq_task[task], sq_unihash[task], sstatefile ) )
         for task in ret:
             spec, extrapath, tname = getpathcomponents(task, d)
-            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + ".tgz")
-            evdata['found'].append( (sq_fn[task], sq_task[task], sq_hash[task], sstatefile ) )
+            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_unihash[task], d) + "_" + tname + ".tgz")
+            evdata['found'].append( (sq_fn[task], sq_task[task], sq_unihash[task], sstatefile ) )
         bb.event.fire(bb.event.MetadataEvent("MissedSstate", evdata), d)
 
     # Print some summary statistics about the current task completion and how much sstate
diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index 64800623545..e64ce6a6dab 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -867,7 +867,9 @@ BB_HASHBASE_WHITELIST ?= "TMPDIR FILE PATH PWD BB_TASKHASH BBPATH BBSERVER DL_DI
     STAMPS_DIR PRSERV_DUMPDIR PRSERV_DUMPFILE PRSERV_LOCKDOWN PARALLEL_MAKE \
     CCACHE_DIR EXTERNAL_TOOLCHAIN CCACHE CCACHE_NOHASHDIR LICENSE_PATH SDKPKGSUFFIX \
     WARN_QA ERROR_QA WORKDIR STAMPCLEAN PKGDATA_DIR BUILD_ARCH SSTATE_PKGARCH \
-    BB_WORKERCONTEXT BB_LIMITEDDEPS extend_recipe_sysroot DEPLOY_DIR"
+    BB_WORKERCONTEXT BB_LIMITEDDEPS BB_UNIHASH extend_recipe_sysroot DEPLOY_DIR \
+    SSTATE_HASHEQUIV_METHOD SSTATE_HASHEQUIV_SERVER SSTATE_HASHEQUIV_REPORT_TASKDATA \
+    SSTATE_HASHEQUIV_OWNER"
 BB_HASHCONFIG_WHITELIST ?= "${BB_HASHBASE_WHITELIST} DATE TIME SSH_AGENT_PID \
     SSH_AUTH_SOCK PSEUDO_BUILD BB_ENV_EXTRAWHITE DISABLE_SANITY_CHECKS \
     PARALLEL_MAKE BB_NUMBER_THREADS BB_ORIGENV BB_INVALIDCONF BBINCLUDED \
diff --git a/meta/lib/oe/sstatesig.py b/meta/lib/oe/sstatesig.py
index 18c5a353a2a..059e165c7ab 100644
--- a/meta/lib/oe/sstatesig.py
+++ b/meta/lib/oe/sstatesig.py
@@ -263,10 +263,177 @@ class SignatureGeneratorOEBasicHash(bb.siggen.SignatureGeneratorBasicHash):
         if error_msgs:
             bb.fatal("\n".join(error_msgs))
 
+class SignatureGeneratorOEEquivHash(SignatureGeneratorOEBasicHash):
+    name = "OEEquivHash"
+
+    def init_rundepcheck(self, data):
+        super().init_rundepcheck(data)
+        self.server = data.getVar('SSTATE_HASHEQUIV_SERVER')
+        self.method = data.getVar('SSTATE_HASHEQUIV_METHOD')
+        self.unihashes = bb.persist_data.persist('SSTATESIG_UNIHASH_CACHE_v1_' + self.method, data)
+
+    def get_taskdata(self):
+        return (self.server, self.method) + super().get_taskdata()
+
+    def set_taskdata(self, data):
+        self.server, self.method = data[:2]
+        super().set_taskdata(data[2:])
+
+    def __get_task_unihash_key(self, task):
+        # TODO: The key only *needs* to be the taskhash, the task is just
+        # convenient
+        return '%s:%s' % (task, self.taskhash[task])
+
+    def get_stampfile_hash(self, task):
+        if task in self.taskhash:
+            # If a unique hash is reported, use it as the stampfile hash. This
+            # ensures that if a task won't be re-run if the taskhash changes,
+            # but it would result in the same output hash
+            unihash = self.unihashes.get(self.__get_task_unihash_key(task))
+            if unihash is not None:
+                return unihash
+
+        return super().get_stampfile_hash(task)
+
+    def get_unihash(self, task):
+        import urllib
+        import json
+
+        taskhash = self.taskhash[task]
+
+        key = self.__get_task_unihash_key(task)
+
+        # TODO: This cache can grow unbounded. It probably only needs to keep
+        # for each task
+        unihash = self.unihashes.get(key)
+        if unihash is not None:
+            return unihash
+
+        # In the absence of being able to discover a unique hash from the
+        # server, make it be equivalent to the taskhash. The unique "hash" only
+        # really needs to be a unique string (not even necessarily a hash), but
+        # making it match the taskhash has a few advantages:
+        #
+        # 1) All of the sstate code that assumes hashes can be the same
+        # 2) It provides maximal compatibility with builders that don't use
+        #    an equivalency server
+        # 3) The value is easy for multiple independent builders to derive the
+        #    same unique hash from the same input. This means that if the
+        #    independent builders find the same taskhash, but it isn't reported
+        #    to the server, there is a better chance that they will agree on
+        #    the unique hash.
+        unihash = taskhash
+
+        try:
+            url = '%s/v1/equivalent?%s' % (self.server,
+                    urllib.parse.urlencode({'method': self.method, 'taskhash': self.taskhash[task]}))
+
+            request = urllib.request.Request(url)
+            response = urllib.request.urlopen(request)
+            data = response.read().decode('utf-8')
+
+            json_data = json.loads(data)
+
+            if json_data:
+                unihash = json_data['unihash']
+                # A unique hash equal to the taskhash is not very interesting,
+                # so it is reported it at debug level 2. If they differ, that
+                # is much more interesting, so it is reported at debug level 1
+                bb.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, task, self.server))
+            else:
+                bb.debug(2, 'No reported unihash for %s:%s from %s' % (task, taskhash, self.server))
+        except urllib.error.URLError as e:
+            bb.warn('Failure contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
+        except (KeyError, json.JSONDecodeError) as e:
+            bb.warn('Poorly formatted response from %s: %s' % (self.server, str(e)))
+
+        self.unihashes[key] = unihash
+        return unihash
+
+    def report_unihash(self, path, task, d):
+        import urllib
+        import json
+        import tempfile
+        import base64
+
+        taskhash = d.getVar('BB_TASKHASH')
+        unihash = d.getVar('BB_UNIHASH')
+        report_taskdata = d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
+        tempdir = d.getVar('T')
+        fn = d.getVar('BB_FILENAME')
+        key = fn + '.do_' + task + ':' + taskhash
+
+        # Sanity checks
+        cache_unihash = self.unihashes.get(key)
+        if cache_unihash is None:
+            bb.fatal('%s not in unihash cache. Please report this error' % key)
+
+        if cache_unihash != unihash:
+            bb.fatal("Cache unihash %s doesn't match BB_UNIHASH %s" % (cache_unihash, unihash))
+
+        sigfile = None
+        sigfile_name = "depsig.do_%s.%d" % (task, os.getpid())
+        sigfile_link = "depsig.do_%s" % task
+
+        try:
+            call = self.method + '(path, sigfile, task, d)'
+            sigfile = open(os.path.join(tempdir, sigfile_name), 'w+b')
+            locs = {'path': path, 'sigfile': sigfile, 'task': task, 'd': d}
+
+            outhash = bb.utils.better_eval(call, locs)
+
+            try:
+                url = '%s/v1/equivalent' % self.server
+                task_data = {
+                    'taskhash': taskhash,
+                    'method': self.method,
+                    'outhash': outhash,
+                    'unihash': unihash,
+                    'owner': d.getVar('SSTATE_HASHEQUIV_OWNER')
+                    }
+
+                if report_taskdata:
+                    sigfile.seek(0)
+
+                    task_data['PN'] = d.getVar('PN')
+                    task_data['PV'] = d.getVar('PV')
+                    task_data['PR'] = d.getVar('PR')
+                    task_data['task'] = task
+                    task_data['outhash_siginfo'] = sigfile.read().decode('utf-8')
+
+                headers = {'content-type': 'application/json'}
+
+                request = urllib.request.Request(url, json.dumps(task_data).encode('utf-8'), headers)
+                response = urllib.request.urlopen(request)
+                data = response.read().decode('utf-8')
+
+                json_data = json.loads(data)
+                new_unihash = json_data['unihash']
+
+                if new_unihash != unihash:
+                    bb.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
+                else:
+                    bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
+            except urllib.error.URLError as e:
+                bb.warn('Failure contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
+            except (KeyError, json.JSONDecodeError) as e:
+                bb.warn('Poorly formatted response from %s: %s' % (self.server, str(e)))
+        finally:
+            if sigfile:
+                sigfile.close()
+
+                sigfile_link_path = os.path.join(tempdir, sigfile_link)
+                bb.utils.remove(sigfile_link_path)
+
+                try:
+                    os.symlink(sigfile_name, sigfile_link_path)
+                except OSError:
+                    pass
 
 # Insert these classes into siggen's namespace so it can see and select them
 bb.siggen.SignatureGeneratorOEBasic = SignatureGeneratorOEBasic
 bb.siggen.SignatureGeneratorOEBasicHash = SignatureGeneratorOEBasicHash
+bb.siggen.SignatureGeneratorOEEquivHash = SignatureGeneratorOEEquivHash
 
 
 def find_siginfo(pn, taskname, taskhashlist, d):
-- 
2.20.1


