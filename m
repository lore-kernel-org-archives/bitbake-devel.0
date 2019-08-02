Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
	[209.85.128.43])
	by mail.openembedded.org (Postfix) with ESMTP id 2EFC979B57
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:51 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id a15so68345351wmj.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7qNMBGMqpfqEqNI6dMI8CoGHMVn4w3g2/CnZlmpoTOc=;
	b=RGTAKE9ytc1OdZ/6aZxwYVbztKNiiMfLySSHRnvUH9czSDPnwztIpGYhT5C5kGMDLq
	ndMJub0HqLLM0sRiKtKZXa3uwxPa4PKviX4eJBL6RIRcOrL8nEMRZUPSjRggIpqz2rJr
	uBc2YrqPLwO/GZwu1QJrxuuE8hDK2YRytTTqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7qNMBGMqpfqEqNI6dMI8CoGHMVn4w3g2/CnZlmpoTOc=;
	b=t/P9JoYKTSNNcEQoeDXQ+aGqw8tA1oMYNm44Tcjv/p6+7HtGKJQt7qcWOPy9gm13KJ
	eJBTC9X+w8uVfCFuMyRTYhxKLLbvmCfDcTMihVqkmYX7bOn+TaajBGb6H4Epp9moA0D0
	Re5G+k0bhxK9SW9fjMj5vgPADfd/3xabGmTaecQDNDXqTpf1dMQ39Bq/31TxC7dO0Th7
	i6zO5lbMudD/wxU72uCwuMurAEqkbKHmgrHJtgPn2LVCKMdBxD//5AypLcEiHl/vFjLo
	lKnV9eRsMN8/e8nSD2+JXhVWM36iLLoKboPysQwz2lZwls3wsmAV2gFMMeRkjjNf2KRf
	FgmQ==
X-Gm-Message-State: APjAAAXuN+4wGzU3iA2pKAumXbwWlMYBXvTVzjpQ7YanSG+yg7FxQZoM
	w1YrwH0GGCBFvebqDl/l0FmDs+BxYLo=
X-Google-Smtp-Source: APXvYqyMg9tijMG9+SCTzvDacEvMKN3FxXUxxBfl7BWzlyqSBgQ/U9GZXdOlLPHJQ7mUzg+i73PFAQ==
X-Received: by 2002:a05:600c:225a:: with SMTP id
	a26mr5198523wmm.81.1564759251370; 
	Fri, 02 Aug 2019 08:20:51 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:34 +0100
Message-Id: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 01/16] siggen: Import unihash code from OE-Core
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:51 -0000
Content-Transfer-Encoding: 8bit

This code is closely tied with the hash server in bitbake and also means
we can't relibably test the hashserv runqueue functionality without OE
metadata. Moving this to bitbake as a MixIn class makes most sense
and encourages code collaboration and reuse as well as enabling easier
and more accurate testing of the APIs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 163 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 6a729f3b1e..0105fa7251 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -354,6 +354,169 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
         bb.note("Tainting hash to force rebuild of task %s, %s" % (fn, task))
         bb.build.write_taint(task, d, fn)
 
+class SignatureGeneratorUniHashMixIn(object):
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
+        import importlib
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
+            sigfile = open(os.path.join(tempdir, sigfile_name), 'w+b')
+
+            locs = {'path': path, 'sigfile': sigfile, 'task': task, 'd': d}
+
+            (module, method) = self.method.rsplit('.', 1)
+            locs['method'] = getattr(importlib.import_module(module), method)
+
+            outhash = bb.utils.better_eval('method(path, sigfile, task, d)', locs)
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
+
 def dump_this_task(outfile, d):
     import bb.parse
     fn = d.getVar("BB_FILENAME")
-- 
2.20.1


