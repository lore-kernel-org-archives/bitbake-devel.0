Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id EDAF978EC3;
	Thu,  9 Aug 2018 22:10:55 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id v26-v6so6087563iog.5;
	Thu, 09 Aug 2018 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=UjPZI0BMHOrH0OCVd/TMC2sazgJHkiqTpju5i6Xa1jg=;
	b=Fr/mSA7OP8vUeDj+nYzPkvDeZyd2dqzXFltXwkifKJxTkRdUxQaynK2o4AJPXocUKt
	TqzlZazqqZXnmuhCX7khcwsNhRdE+McGZ1NLknqvaLw0fC0vNgMpvoSx0N+Ht/t0ATh/
	QVuwKEVUfd8Kzy4adBPZh1ghd4rDe8T0s3i7HMy3r/vsp0OG38yw7t15oHt7iBugi7pp
	KQ0aSyJrGx7LGWdqWlUQLD7k6I5RJhqBraBcg5nYVnpysEaz/0+Fbe6CMxacUy11mpXO
	q7Ayf75+OZ7LxZtOTe6Z7p//CqAR/fcgo66U1C2uIrUvqD+Cru0n6UaXRMji9Jjxm8Rl
	b6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=UjPZI0BMHOrH0OCVd/TMC2sazgJHkiqTpju5i6Xa1jg=;
	b=XHPNLzA1t4DE6q6CrAvliT6bPwlUfnJNiNXdacGzlzI3nulnp1KKuZxFZKj19CCa5H
	PRSR+EXzlTabgbo7llT9fgH8tO7HHbII+ZyiKv3EWQMDhVVmQTFLhs89je2VpGtfWpng
	+vxB/zkbaXuaq5VfPchkewKzhpcsA2E4ZJmXlaI7HoYVmUSvEI7BW5/4XoyY8f0JZv1P
	4dXQdl3Ea+YHS082hRYWEisEM9vXT1VFEYmUqlEWtcKpTJ6kDlOMjOYNR5S35vqxLIUP
	tq9EkVy7ROd/SKn+qKiZX27QBuIxTs5RXYNNVA1zJIDGye6PFCOmmtzDbBbekAcJNTyb
	tjsQ==
X-Gm-Message-State: AOUpUlFGfzAWOl3j46PpFFrbeAIbZA+ttj66UBkeSVtf0HZtSpIhdnfl
	Kp7pwbQnYUrupI5XkX1ZA9eGIiEG
X-Google-Smtp-Source: AA+uWPwaUQe5w7xmoGkFG0ayCyDDZCyuJD0TgZY9+4nte9iYO4kxT3sABHMbfWemALUNTlJOE/HWXw==
X-Received: by 2002:a5e:9b14:: with SMTP id
	j20-v6mr3473234iok.193.1533852656870; 
	Thu, 09 Aug 2018 15:10:56 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:40 -0500
Message-Id: <20180809220840.26697-17-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 16/16] sstate: Implement hash equivalence sstate
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:56 -0000

Converts sstate so that it can use a hash equivalence server to
determine if a task really needs to be rebuilt, or if it can be restored
from a different (equivalent) sstate object.

The dependency IDs are cached persistently using persist_data. This has
a number of advantages:
 1) Dependency IDs can be cached between invocations of bitbake to
    prevent needing to contact the server every time (which is slow)
 2) The value of each tasks dependency ID can easily be synchronized
    between different threads, which will be useful if bitbake is
    updated to do on the fly task re-hashing.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 100 ++++++++++++++++++++--
 meta/conf/bitbake.conf      |   4 +-
 meta/lib/oe/sstatesig.py    | 166 ++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+), 9 deletions(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 28a64315b60..e956bd40b25 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -11,7 +11,7 @@ def generate_sstatefn(spec, hash, d):
 SSTATE_PKGARCH    = "${PACKAGE_ARCH}"
 SSTATE_PKGSPEC    = "sstate:${PN}:${PACKAGE_ARCH}${TARGET_VENDOR}-${TARGET_OS}:${PV}:${PR}:${SSTATE_PKGARCH}:${SSTATE_VERSION}:"
 SSTATE_SWSPEC     = "sstate:${PN}::${PV}:${PR}::${SSTATE_VERSION}:"
-SSTATE_PKGNAME    = "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.getVar('SSTATE_PKGSPEC'), d.getVar('BB_TASKHASH'), d)}"
+SSTATE_PKGNAME    = "${SSTATE_EXTRAPATH}${@generate_sstatefn(d.getVar('SSTATE_PKGSPEC'), d.getVar('BB_DEPID'), d)}"
 SSTATE_PKG        = "${SSTATE_DIR}/${SSTATE_PKGNAME}"
 SSTATE_EXTRAPATH   = ""
 SSTATE_EXTRAPATHWILDCARD = ""
@@ -75,6 +75,23 @@ SSTATE_SIG_PASSPHRASE ?= ""
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
@@ -626,7 +643,7 @@ def sstate_package(ss, d):
         return
 
     for f in (d.getVar('SSTATECREATEFUNCS') or '').split() + \
-             ['sstate_create_package', 'sstate_sign_package'] + \
+             ['sstate_report_depid', 'sstate_create_package', 'sstate_sign_package'] + \
              (d.getVar('SSTATEPOSTCREATEFUNCS') or '').split():
         # All hooks should run in SSTATE_BUILDDIR.
         bb.build.exec_func(f, d, (sstatebuild,))
@@ -750,6 +767,73 @@ python sstate_sign_package () {
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
+    h = hashlib.sha1()
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
+                    fh = hashlib.sha1()
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
+python sstate_report_depid() {
+    report_depid = getattr(bb.parse.siggen, 'report_depid', None)
+
+    if report_depid:
+        ss = sstate_state_fromvars(d)
+        report_depid(os.getcwd(), ss['task'], d)
+}
+
 #
 # Shell function to decompress and prepare a package for installation
 # Will be run from within SSTATE_INSTDIR.
@@ -796,7 +880,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=
 
         spec, extrapath, tname = getpathcomponents(task, d)
 
-        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + extension)
+        sstatefile = d.expand("${SSTATE_DIR}/" + extrapath + generate_sstatefn(spec, sq_depid[task], d) + "_" + tname + extension)
 
         if os.path.exists(sstatefile):
             bb.debug(2, "SState: Found valid sstate file %s" % sstatefile)
@@ -858,7 +942,7 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=
             if task in ret:
                 continue
             spec, extrapath, tname = getpathcomponents(task, d)
-            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + extension)
+            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_depid[task], d) + "_" + tname + extension)
             tasklist.append((task, sstatefile))
 
         if tasklist:
@@ -884,12 +968,12 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=
         evdata = {'missed': [], 'found': []};
         for task in missed:
             spec, extrapath, tname = getpathcomponents(task, d)
-            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + ".tgz")
-            evdata['missed'].append( (sq_fn[task], sq_task[task], sq_hash[task], sstatefile ) )
+            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_depid[task], d) + "_" + tname + ".tgz")
+            evdata['missed'].append( (sq_fn[task], sq_task[task], sq_depid[task], sstatefile ) )
         for task in ret:
             spec, extrapath, tname = getpathcomponents(task, d)
-            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_hash[task], d) + "_" + tname + ".tgz")
-            evdata['found'].append( (sq_fn[task], sq_task[task], sq_hash[task], sstatefile ) )
+            sstatefile = d.expand(extrapath + generate_sstatefn(spec, sq_depid[task], d) + "_" + tname + ".tgz")
+            evdata['found'].append( (sq_fn[task], sq_task[task], sq_depid[task], sstatefile ) )
         bb.event.fire(bb.event.MetadataEvent("MissedSstate", evdata), d)
 
     # Print some summary statistics about the current task completion and how much sstate
diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index f68954c511e..6c5cad60b83 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -865,7 +865,9 @@ BB_HASHBASE_WHITELIST ?= "TMPDIR FILE PATH PWD BB_TASKHASH BBPATH BBSERVER DL_DI
     STAMPS_DIR PRSERV_DUMPDIR PRSERV_DUMPFILE PRSERV_LOCKDOWN PARALLEL_MAKE \
     CCACHE_DIR EXTERNAL_TOOLCHAIN CCACHE CCACHE_NOHASHDIR LICENSE_PATH SDKPKGSUFFIX \
     WARN_QA ERROR_QA WORKDIR STAMPCLEAN PKGDATA_DIR BUILD_ARCH SSTATE_PKGARCH \
-    BB_WORKERCONTEXT BB_LIMITEDDEPS extend_recipe_sysroot DEPLOY_DIR"
+    BB_WORKERCONTEXT BB_LIMITEDDEPS BB_DEPID extend_recipe_sysroot DEPLOY_DIR \
+    SSTATE_HASHEQUIV_METHOD SSTATE_HASHEQUIV_SERVER SSTATE_HASHEQUIV_REPORT_TASKDATA \
+    SSTATE_HASHEQUIV_OWNER"
 BB_HASHCONFIG_WHITELIST ?= "${BB_HASHBASE_WHITELIST} DATE TIME SSH_AGENT_PID \
     SSH_AUTH_SOCK PSEUDO_BUILD BB_ENV_EXTRAWHITE DISABLE_SANITY_CHECKS \
     PARALLEL_MAKE BB_NUMBER_THREADS BB_ORIGENV BB_INVALIDCONF BBINCLUDED \
diff --git a/meta/lib/oe/sstatesig.py b/meta/lib/oe/sstatesig.py
index 18c5a353a2a..7f75de3279f 100644
--- a/meta/lib/oe/sstatesig.py
+++ b/meta/lib/oe/sstatesig.py
@@ -263,10 +263,176 @@ class SignatureGeneratorOEBasicHash(bb.siggen.SignatureGeneratorBasicHash):
         if error_msgs:
             bb.fatal("\n".join(error_msgs))
 
+class SignatureGeneratorOEEquivHash(SignatureGeneratorOEBasicHash):
+    name = "OEEquivHash"
+
+    def init_rundepcheck(self, data):
+        super().init_rundepcheck(data)
+        self.server = data.getVar('SSTATE_HASHEQUIV_SERVER')
+        self.method = data.getVar('SSTATE_HASHEQUIV_METHOD')
+        self.depids = bb.persist_data.persist('SSTATESIG_DEPID_CACHE_v1_' + self.method, data)
+
+    def get_taskdata(self):
+        return (self.server, self.method) + super().get_taskdata()
+
+    def set_taskdata(self, data):
+        self.server, self.method = data[:2]
+        super().set_taskdata(data[2:])
+
+    def __get_task_depid_key(self, task):
+        # TODO: The key only *needs* to be the taskhash, the task is just
+        # convenient
+        return '%s:%s' % (task, self.taskhash[task])
+
+    def get_stampfile_hash(self, task):
+        if task in self.taskhash:
+            # If a depid is reported, use it as the stampfile hash. This
+            # ensures that if a task won't be re-run if the taskhash changes,
+            # but it would result in the same output hash
+            depid = self.depids.get(self.__get_task_depid_key(task))
+            if depid is not None:
+                return depid
+
+        return super().get_stampfile_hash(task)
+
+    def get_depid(self, task):
+        import urllib
+        import json
+
+        taskhash = self.taskhash[task]
+
+        key = self.__get_task_depid_key(task)
+
+        # TODO: This cache can grow unbounded. It probably only needs to keep
+        # for each task
+        depid = self.depids.get(key)
+        if depid is not None:
+            return depid
+
+        # In the absence of being able to discover a dependency ID from the
+        # server, make it be equivalent to the taskhash. The dependency ID only
+        # really needs to be a unique string (not even necessarily a hash), but
+        # making it match the taskhash has a few advantages:
+        #
+        # 1) All of the sstate code that assumes hashes can be the same
+        # 2) It provides maximal compatibility with builders that don't use
+        #    an equivalency server
+        # 3) The value is easy for multiple independent builders to derive the
+        #    same depid from the same input. This means that if the independent
+        #    builders find the same taskhash, but it isn't reported to the server,
+        #    there is a better chance that they will agree on the dependency ID.
+        depid = taskhash
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
+                depid = json_data['depid']
+                # Dependency ID equal to the taskhash is not very interesting,
+                # so it is reported it at debug level 2. If they differ, that
+                # is much more interesting, so it is reported at debug level 1
+                bb.debug((1, 2)[depid == taskhash], 'Found depid %s in place of %s for %s from %s' % (depid, taskhash, task, self.server))
+            else:
+                bb.debug(2, 'No reported dependency ID for %s:%s from %s' % (task, taskhash, self.server))
+        except urllib.error.URLError as e:
+            bb.warn('Failure contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
+        except (KeyError, json.JSONDecodeError) as e:
+            bb.warn('Poorly formatted response from %s: %s' % (self.server, str(e)))
+
+        self.depids[key] = depid
+        return depid
+
+    def report_depid(self, path, task, d):
+        import urllib
+        import json
+        import tempfile
+        import base64
+
+        taskhash = d.getVar('BB_TASKHASH')
+        depid = d.getVar('BB_DEPID')
+        report_taskdata = d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
+        tempdir = d.getVar('T')
+        fn = d.getVar('BB_FILENAME')
+        key = fn + '.do_' + task + ':' + taskhash
+
+        # Sanity checks
+        cache_depid = self.depids.get(key)
+        if cache_depid is None:
+            bb.fatal('%s not in depid cache. Please report this error' % key)
+
+        if cache_depid != depid:
+            bb.fatal("Cache depid %s doesn't match BB_DEPID %s" % (cache_depid, depid))
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
+                    'depid': depid,
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
+                new_depid = json_data['depid']
+
+                if new_depid != depid:
+                    bb.debug(1, 'Task %s depid changed %s -> %s by server %s' % (taskhash, depid, new_depid, self.server))
+                else:
+                    bb.debug(1, 'Reported task %s as depid %s to %s' % (taskhash, depid, self.server))
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
2.17.1


