Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
	[209.85.214.49])
	by mail.openembedded.org (Postfix) with ESMTP id 78D8E71BA7
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 09:51:02 +0000 (UTC)
Received: by mail-it0-f49.google.com with SMTP id x2so12279568itf.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jan 2017 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Csvc2K3RX6MBMql9RKOqqf0UbD0pWWo92VWlWAoOU4o=;
	b=Esuv20fYfz//Nx0dVm5T2GKAKJyw+7foevvrb6/K5U43ReKb5vVF6/1M1C2mNuK5bm
	KSBfTEFCUEWcQf3ZA6YuaVOhdtwvDQnIbe89dvgCLaW5mx8qPmvsqD54q2JOMFbs5liB
	vxwuBpR/QDga4DQU4Ycm62Kc3irdamTksQ7V2Ny6d2qiCiHGNBAUSnwhEPONV6n6uBad
	1+15maR12J7kI9+ZmYT2WDgNF7B1cPZ2FB39I+c2FzwQkTN6Q32wbMiD046PnWnRY19E
	3mV2TVx0nBm1lPTPVXkB223HVHVgSrKQePhsMyS3qfcrOEIA3+NReeoy9YXsIvfGDtoi
	VVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Csvc2K3RX6MBMql9RKOqqf0UbD0pWWo92VWlWAoOU4o=;
	b=A35At1ctfedoqQW8Flf9ZBuRezJK4CH59oBp6Pesl5ft7zYjrXdi4jmgHuR3gzUWSE
	sSel9rUm6lubNg+1am39IVa4vUq3HhMxUIP0rlzI6xqo11P1ZV9OrO+vlYjFbfgJ0dXm
	yup2sLcsUx8byRET1200KUJ1NjYaO83eJ5YYyc3McgCvw4+2DtZMJLufSbtgD2NzO2O0
	+wZG1gu1lR1Ej2svQESlIoTCIdBeYdJH72zhRs54FsQZp6tsVtX9tJZUH9XrEs6mPBZ4
	JKBI51QYDNghmsaJwt+3e4xYABJKxwrG4pw4l93VS14N4LgqFX3nZvkb5IzPDfKANKlq
	GIgQ==
X-Gm-Message-State: AIkVDXJkl6xFyzizhknhl2WHWIGHuRsonY7ECoCwgjt2B3G6eXWOYFN3/Hnda8bXOd6/EJZX
X-Received: by 10.36.111.83 with SMTP id x80mr1692067itb.92.1483696262689;
	Fri, 06 Jan 2017 01:51:02 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8F5BD.dip0.t-ipconnect.de.
	[93.232.245.189]) by smtp.gmail.com with ESMTPSA id
	w192sm1171819itw.3.2017.01.06.01.51.01
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 06 Jan 2017 01:51:01 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2017 10:50:47 +0100
Message-Id: <88c860131b153f5b95efb08c219d4dc5f0712f8b.1483696010.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1483696010.git.patrick.ohly@intel.com>
References: <cover.1483696010.git.patrick.ohly@intel.com>
Subject: [PATCH 1/3] recipes: anonymous functions with priorities
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
X-List-Received-Date: Fri, 06 Jan 2017 09:51:03 -0000

The execution order of anonymous functions inside a recipe is
deterministic (executed in the order in which the functions get
parsed), but class authors cannot know in which order classes get
inherited and thus cannot know whether the class functions run before
or after functions in other classes. That is a problem for
rm_work.bbclass, which must add its own task after all other
classes have added theirs.

As an extension of the current syntax, now any function whose name
*starts* with "__anonymous" is considered an anonymous function;
previously, anything with *exactly* that name was an anonymous
function.

In contrast to those which are named just "__anonymous" or have no
name at all, the "__anonymous_<something>" name must be globally
unique and can be used to set a "__anonprio" variable flag for the
function.

The default priority is 100. Functions with higher values run later.

For example, rm_work.bbclass can use this to ensure that it runs
later than other anonymous functions:

python __anonymous_rm_work() {
    bb.build.addtask(....)
}
__anonymous_rm_work[priority] = "1000"

The priorities influence parsing results and thus need to be included
in the base hash. That part was necessary to trigger re-parsing when
modifying the priority in rm_work.bbclass, which gets inherited
globally via INHERIT.

Related-to: [YOCTO #10584]

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/data_smart.py |  3 +++
 lib/bb/parse/ast.py  | 19 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 79d591a..4b1e9fb 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1002,6 +1002,9 @@ class DataSmart(MutableMapping):
                 for i in bb_list:
                     value = d.getVar(i, False) or ""
                     data.update({i:value})
+                    priority = d.getVarFlag(i, '__anonprio', False)
+                    if priority is not None:
+                        data.update({'%s[__anonprio]' % i: priority})
 
         data_str = str([(k, data[k]) for k in sorted(data.keys())])
         return hashlib.md5(data_str.encode("utf-8")).hexdigest()
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 853dda8..6255cc4 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -175,8 +175,15 @@ class MethodNode(AstNode):
     def eval(self, data):
         text = '\n'.join(self.body)
         funcname = self.func_name
-        if self.func_name == "__anonymous":
-            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
+        if self.func_name.startswith("__anonymous"):
+            if self.func_name == "__anonymous":
+                # If truly anonymous, then we have to create a unique name.
+                funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
+            else:
+                # The recipe already has a unique name. Let's use that to ensure
+                # that any flags set for that name (like __anonymous_my_func[priority] = "1000")
+                # can be found later.
+                funcname = self.func_name
             self.python = True
             text = "def %s(d):\n" % (funcname) + text
             bb.methodpool.insert_method(funcname, text, self.filename, self.lineno - len(self.body))
@@ -352,7 +359,13 @@ def finalize(fn, d, variant = None):
     bb.data.expandKeys(d)
     bb.data.update_data(d)
     code = []
-    for funcname in d.getVar("__BBANONFUNCS", False) or []:
+    # Anonymous functions with lower priority get executed first.
+    # sorted() is stable, so for entries with the same priority,
+    # execution is in the order of definition.
+    anonymous = sorted(d.getVar("__BBANONFUNCS", False) or [],
+                       key=lambda f: int(d.getVarFlag(f, '__anonprio', True) or 100))
+    d.setVar("__BBANONFUNCS", anonymous)
+    for funcname in anonymous:
         code.append("%s(d)" % funcname)
     bb.utils.better_exec("\n".join(code), {"d": d})
     bb.data.update_data(d)
-- 
2.1.4


