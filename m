Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
	[209.85.166.46])
	by mail.openembedded.org (Postfix) with ESMTP id 00E877BF12;
	Wed, 19 Dec 2018 03:10:44 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id v10so14421116ios.13;
	Tue, 18 Dec 2018 19:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ugPlKwJ8M+KRqfTATVxk05phYi/gUOC99NXc2+6FH7s=;
	b=NkfTr8gVNIhA7x0sX7r9GpD3vDTaIQ75V+fpeZiF824k6FfkK0KJmWsO1KmGqSqsm1
	GmhoxGoIh6/zpnttKUxoc1+3vN0rOj7K/Glbqbhww1wqauqePbi0LS84BOdzwtl4kwel
	KFkkLpaTvdVRUCCHar3Bwsz8qa3kI6id+T0oR8jORp4PQJzK+wNng51Bu5TqJykjfQ05
	SsEgehPSjWRW8mFVmXk7VboYtBQWtORs/bVXYZw2gi+VoT3VBeN0JCd0llrQhcQ9/oHL
	7BftqhBLsGwiL0Njrop1rxqK5tP6jvvp32pBCClsAVvRGZs71O8qXwIxTynFBmU7xd3d
	8snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ugPlKwJ8M+KRqfTATVxk05phYi/gUOC99NXc2+6FH7s=;
	b=UKjVMXLndUkZYHHulHHuChz+Sj9vEwU+Vsd9VwdAJrgCPYE7LoYMm5WgqmC3UrLi7X
	4AB3AMzmojBWWiJnPLU3V0nar74Ha2UigCaomRCfYdSymmcBnagrcPOssFLSIEWrbJsW
	oRgJDzp/joy3PHpp+k7hOMGJJUEg7fCK+xmzHDGfNNdULyPGITh8vc37kEzb3O9CGPeD
	InO8xsmIMrP/FayrxwqO5FKzLUA43YbdNmbv7IyfDMHNAayB5yyoCoxkal8AVkrK5cP7
	mo7MrLOun1LCkcPd2M2fw8p8qN0SdMf+CrhKv7Pgeta27piTodi/KWY7Y0LeEOE6CnS8
	weLw==
X-Gm-Message-State: AA+aEWZFJwyVxWoPKhP19QUs6ffMnLI8GwlA1oK4qpHcN7QwkG2HQSZr
	KUysWklK8AJodjrnkws7uoVCKjFM
X-Google-Smtp-Source: AFSGD/U6QNncRYn2Slpdmk0Zny0HCgz/putBscu4YBNzs+xGKgfrZNOCs2jeeMR53EgsAjJ+ZXluEg==
X-Received: by 2002:a6b:91d4:: with SMTP id
	t203mr16955798iod.267.1545189045577; 
	Tue, 18 Dec 2018 19:10:45 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:45 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:33 -0600
Message-Id: <20181219031033.28045-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219031033.28045-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 8/8] sstate: Implement hash equivalence sstate
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:45 -0000
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
index 41a2f9b7b77..8ffefd68344 100644
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
@@ -634,7 +651,7 @@ def sstate_package(ss, d):
         return
 
     for f in (d.getVar('SSTATECREATEFUNCS') or '').split() + \
-             ['sstate_create_package', 'sstate_sign_package'] + \
+             ['sstate_report_unihash', 'sstate_create_package', 'sstate_sign_package'] + \
              (d.getVar('SSTATEPOSTCREATEFUNCS') or '').split():
         # All hooks should run in SSTATE_BUILDDIR.
         bb.build.exec_func(f, d, (sstatebuild,))
@@ -758,6 +775,73 @@ python sstate_sign_package () {
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
@@ -804,7 +888,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *,
 
         spec, extrapath, tname = getpathcomponents(task, d)
 
-        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + extension)
+        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath + generate_sstatefn(spec, sq_unihash[task], d) + "_" + tname + extension)
 
         if os.path.exists(sstatefile):
             bb.debug(2, "SState: Found valid sstate file %s" % sstatefile)
@@ -866,7 +950,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *,
             if task in ret:
                 continue
             spec, extrapath, tname = getpathcomponents(task, d)
-            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + extension)
+            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_unihash[task], d) + "_" + tname + extension)
             tasklist.append((task, sstatefile))
 
         if tasklist:
@@ -892,12 +976,12 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *,
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
index 18c5a353a2a..503f2452807 100644
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
+        unihash = self.taskhash.get(key)
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
+        self.taskhash[key] = unihash
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
+        cache_unihash = self.taskhash.get(key)
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
2.19.2


