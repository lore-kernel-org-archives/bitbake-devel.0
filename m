Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S0Dpo-0004V0-59
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 16:10:24 +0100
Received: by eekd41 with SMTP id d41so10839eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Feb 2012 07:02:03 -0800 (PST)
Received-SPF: pass (google.com: domain of martin.jansa@gmail.com designates
	10.14.183.130 as permitted sender) client-ip=10.14.183.130; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of martin.jansa@gmail.com
	designates 10.14.183.130 as permitted sender)
	smtp.mail=martin.jansa@gmail.com;
	dkim=pass header.i=martin.jansa@gmail.com
Received: from mr.google.com ([10.14.183.130])
	by 10.14.183.130 with SMTP id q2mr1986875eem.101.1329922923974
	(num_hops = 1); Wed, 22 Feb 2012 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
	bh=fRald4A5HEadZ51KsJ6FHzGp/a7DZX9mXAK4d214lSA=;
	b=M+B7t9waVbJNGlMtIIHiEiMgheDg9YKdrCFjosi1CgDOcLa/7Vc3UtegYKk9JcCNfc
	z6jYzOoqyuXEaiPA6G1iXHkK06i0oRi4D0V45Ebb3FLQiVtknUYQIB4aIhTuik8UgN6S
	Mw/pblkjU7eVGJwfojL3QoX5GF/DxkAYcrcSY=
Received: by 10.14.183.130 with SMTP id q2mr1625415eem.101.1329922923698;
	Wed, 22 Feb 2012 07:02:03 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id y14sm74120613eef.10.2012.02.22.07.02.01
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 22 Feb 2012 07:02:02 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Feb 2012 16:01:59 +0100
Message-Id: <1329922919-29294-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1329921469.20261.158.camel@ted>
References: <1329921469.20261.158.camel@ted>
Subject: [PATCH] siggen: compare runtaskdeps dictionary even when they have the same size
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 Feb 2012 15:10:24 -0000

* otherwise it reports lots of changed checksums just because it compares different tasks

  notice linux-libc-headers_3.1.bb.do_package_write:
  Task dependency hash changed from 42acced29debf54d598802474c5e9cbb to f438a54f995df77620d0727d6f4b4ce5 (for linux-libc-headers_3.1.bb.do_package_write and linux-gta04_git.bb.do_deploy)
  Task dependency hash changed from 61f8babe1d10c6e7fb1423112bb04e1e to 1b3e21ff106ecfcb7ddf76a1e29537bb (for linux-nokia900-meego_git.bb.do_deploy and linux-gta04_git.bb.do_package_write)
  Task dependency hash changed from 512f9d6686d760b318d8b11c8b589226 to 42acced29debf54d598802474c5e9cbb (for linux-nokia900-meego_git.bb.do_package_write and linux-libc-headers_3.1.bb.do_package_write)
  Task dependency hash changed from 153e91dfd1d2053fda7b98cc08d4b802 to 92a293bdd8ed234932b87a66025038c5 (for systemd-serialgetty.bb.do_package_write and systemd-serialgetty.bb.do_package_write)
  Task dependency hash changed from 730abebf9954794bb440c2f3239f79fe to 413eaebaff27a2fd16f5cf68c1f4ff17 (for systemd_git.bb.do_package_write and systemd_git.bb.do_package_write)

  with this patch:
  Dependency on task linux-nokia900-meego_git.bb.do_package_write was added
  Dependency on task linux-nokia900-meego_git.bb.do_deploy was added
  Dependency on task linux-gta04_git.bb.do_deploy was removed
  Dependency on task linux-gta04_git.bb.do_package_write was removed
  Hash for dependent task systemd_git.bb.do_package_write changed from 730abebf9954794bb440c2f3239f79fe to 413eaebaff27a2fd16f5cf68c1f4ff17
  Hash for dependent task systemd-serialgetty.bb.do_package_write changed from 153e91dfd1d2053fda7b98cc08d4b802 to 92a293bdd8ed234932b87a66025038c5

* added test if there is different task with same hash then we don't
  show it as added/removed dependency, because bitbake doesn't care

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/siggen.py |   47 ++++++++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f31d66a..5621e1b 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -292,27 +292,32 @@ def compare_sigfiles(a, b):
             print "Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep])
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
-            a = clean_basepaths(a_data['runtaskhashes'])
-            b = clean_basepaths(b_data['runtaskhashes'])
-            changed, added, removed = dict_diff(a, b)
-            if added:
-                for dep in added:
-                    print "Dependency on task %s was added" % (dep)
-            if removed:
-                for dep in removed:
-                    print "Dependency on task %s was removed" % (dep)
-            if changed:
-                for dep in changed:
-                    print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
-        else:
-            for i in range(len(a_data['runtaskdeps'])):
-                aent = a_data['runtaskdeps'][i]
-                bent = b_data['runtaskdeps'][i]
-                aname = clean_basepath(aent)
-                bname = clean_basepath(bent)
-                if a_data['runtaskhashes'][aent] != b_data['runtaskhashes'][bent]:
-                    print "Task dependency hash changed from %s to %s (for %s and %s)" % (a_data['runtaskhashes'][aent], b_data['runtaskhashes'][bent], aname, bname)
+        a = clean_basepaths(a_data['runtaskhashes'])
+        b = clean_basepaths(b_data['runtaskhashes'])
+        changed, added, removed = dict_diff(a, b)
+        if added:
+            for dep in added:
+	        bdep_found = False
+	        if removed:
+		    for bdep in removed:
+		    	if a[dep] == b[bdep]:
+			   #print "Dependency on task %s was replaced by %s with same hash" % (dep, bdep)
+			   bdep_found = True
+		if not bdep_found:
+                    print "Dependency on task %s was added with hash %s" % (dep, a[dep])
+        if removed:
+            for dep in removed:
+	        adep_found = False
+	        if added:
+		    for adep in added:
+		    	if a[adep] == b[dep]:
+			   #print "Dependency on task %s was replaced by %s with same hash" % (adep, dep)
+			   adep_found = True
+		if not adep_found:
+                   print "Dependency on task %s was removed with hash %s" % (dep, b[dep])
+        if changed:
+            for dep in changed:
+                print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
 
 def dump_sigfile(a):
     p1 = pickle.Unpickler(file(a, "rb"))
-- 
1.7.8.4



