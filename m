Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id 074BF7F4CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Oct 2019 13:22:34 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id b136so4918328iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Oct 2019 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3uIxvxYNl/QjM6Qp0ajvxDHCNbg+zxgc6Tke3bW68Ho=;
	b=Xd+55K4TqjTMcC8rcr07n6h0Wirs6NXQ444fiM2829rq3rc0RIIwYTc4mBknRPYT8J
	Emo1hlKVARs4A6ye5B6c3azm2S6yxEeFGBgmyFgJVpqNOKIVYZ7ipYO+X4c43ZoIxRt2
	CCNTQ0HED4jdIK9N878rQu03AGq1iuF5ItQylzQ7I2cNvs2YRes5W4wpEiw87opLLEo6
	wATgB3/qvbzQtqv1RG615fC9jX6Sbxj2oF/dI9elt6jeO3Kyk8qMKixwSJe0InyM7PiW
	j++RQAB5x9wVXBhfrgSabvRWz5wOoUszOCvKAFgmDzYJnJjyNr4MO2EbXZTZ5jUvXOo6
	D+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3uIxvxYNl/QjM6Qp0ajvxDHCNbg+zxgc6Tke3bW68Ho=;
	b=WQNeTN1AkM1dWOsnqbzKoe188HZ+CtYcucuu3eqedBHrGtSMa8V84t4cxAvaosxpXI
	C5RAMsIxFnADMAbxl1foYGKPKmZQXXedfdoH4WyAPZgpLv1/d0VLHfRbpab348X4+xy0
	2H5yxWyfbpftU8l7wHmr/erWJ7+yIAwtFLRCaHvAEjdrsZY7CpgldFYm9cmpEZWmuffM
	fcp4W1ZhYjCbmGENeMgrjuBjO1EWfaVD7Hgj4w01v+WiJ1EUcj4QZW0W1PT9k4SoGk1r
	znR0KOCkjOBnrxCXAa2R861DwJiBrjD0tAgVxkWBFmsUGJMJTfdpfN8gUHBcVHKzP8Pl
	uJhQ==
X-Gm-Message-State: APjAAAWiOFxnzvzb9/y83xLLRkJVfT+WJcmb3MY9u2ASldUZ9nnAoS9A
	4MGmxsEqKq2QXG6YMADG/FoYfdH8
X-Google-Smtp-Source: APXvYqytMLj/9/lWZjvjOBhvpVK4u1fl/V8KHrshpQVEVUINvQnJ+DmDjnirj0xFMB42tyucib4/5w==
X-Received: by 2002:a5d:8946:: with SMTP id b6mr2963669iot.191.1570627355482; 
	Wed, 09 Oct 2019 06:22:35 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id f23sm840388ioc.36.2019.10.09.06.22.34
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 09 Oct 2019 06:22:34 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Oct 2019 08:22:26 -0500
Message-Id: <20191009132226.1808-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] siggen: Include unihash and taskhash in sigdata
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
X-List-Received-Date: Wed, 09 Oct 2019 13:22:35 -0000
Content-Transfer-Encoding: 8bit

Captures the unihash and the taskhash when generating the signature
data. The taskhash doesn't actually factor into the signature
calculation, but it is very useful to know what it was for debugging
purposes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index a4bb1ff7fbe..67be1d6c795 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -294,7 +294,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[tid]]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
-                data['runtaskhashes'][dep] = self.get_unihash(dep)
+                data['runtaskhashes'][dep] = {'taskhash': self.taskhash[dep], 'unihash': self.get_unihash(dep)}
             data['taskhash'] = self.taskhash[tid]
             data['unihash'] = self.get_unihash(tid)
 
@@ -773,8 +773,10 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
             for idx, task in enumerate(a_data['runtaskdeps']):
                 a = a_data['runtaskdeps'][idx]
                 b = b_data['runtaskdeps'][idx]
-                if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b] and not collapsed:
-                    changed.append("%s with hash %s\n changed to\n%s with hash %s" % (clean_basepath(a), a_data['runtaskhashes'][a], clean_basepath(b), b_data['runtaskhashes'][b]))
+                if a_data['runtaskhashes'][a]['unihash'] != b_data['runtaskhashes'][b]['unihash'] and not collapsed:
+                    changed.append("%s with hash %s (taskhash %s)\n changed to\n%s with hash %s (taskhash %s)" % (
+                                   clean_basepath(a), a_data['runtaskhashes'][a]['unihash'], a_data['runtaskhashes'][a]['taskhash'],
+                                   clean_basepath(b), b_data['runtaskhashes'][b]['unihash'], b_data['runtaskhashes'][b]['taskhash']))
 
         if changed:
             clean_a = clean_basepaths_list(a_data['runtaskdeps'])
@@ -795,25 +797,27 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
                 bdep_found = False
                 if removed:
                     for bdep in removed:
-                        if b[dep] == a[bdep]:
+                        if b[dep]['unihash'] == a[bdep]['unihash']:
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (dep, bdep))
                             bdep_found = True
                 if not bdep_found:
-                    output.append(color_format("{color_title}Dependency on task %s was added{color_default} with hash %s") % (clean_basepath(dep), b[dep]))
+                    output.append(color_format("{color_title}Dependency on task %s was added{color_default} with hash %s (taskhash %s)") % (
+                                               clean_basepath(dep), b[dep]['unihash'], b[dep]['taskhash']))
         if removed:
             for dep in removed:
                 adep_found = False
                 if added:
                     for adep in added:
-                        if b[adep] == a[dep]:
+                        if b[adep]['unihash'] == a[dep]['unihash']:
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (adep, dep))
                             adep_found = True
                 if not adep_found:
-                    output.append(color_format("{color_title}Dependency on task %s was removed{color_default} with hash %s") % (clean_basepath(dep), a[dep]))
+                    output.append(color_format("{color_title}Dependency on task %s was removed{color_default} with hash %s (taskhash %s") % (
+                                               clean_basepath(dep), a[dep]['unihash'], a[dep]['taskhash']))
         if changed:
             for dep in changed:
                 if not collapsed:
-                    output.append(color_format("{color_title}Hash for dependent task %s changed{color_default} from %s to %s") % (clean_basepath(dep), a[dep], b[dep]))
+                    output.append(color_format("{color_title}Hash for dependent task %s changed{color_default} from %s to %s") % (clean_basepath(dep), a[dep]['unihash'], b[dep]['unihash']))
                 if callable(recursecb):
                     recout = recursecb(dep, a[dep], b[dep])
                     if recout:
@@ -856,7 +860,7 @@ def calc_taskhash(sigdata):
     data = sigdata['basehash']
 
     for dep in sigdata['runtaskdeps']:
-        data = data + sigdata['runtaskhashes'][dep]
+        data = data + sigdata['runtaskhashes'][dep]['unihash']
 
     for c in sigdata['file_checksum_values']:
         if c[1]:
@@ -900,7 +904,7 @@ def dump_sigfile(a):
 
     if 'runtaskhashes' in a_data:
         for dep in a_data['runtaskhashes']:
-            output.append("Hash for dependent task %s is %s" % (dep, a_data['runtaskhashes'][dep]))
+            output.append("Hash for dependent task %s is %s (taskhash %s)" % (dep, a_data['runtaskhashes'][dep]['unihash'], a_data['runtaskhashes'][dep]['taskhash']))
 
     if 'taint' in a_data:
         if a_data['taint'].startswith('nostamp:'):
-- 
2.21.0


