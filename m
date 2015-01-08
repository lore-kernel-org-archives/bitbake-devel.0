Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 75A89609B2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 13:15:18 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id lf10so11739738pab.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 Jan 2015 05:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=yTNfMN8BkPnJ3+Moj0Hweu2b4bXghuXadx3bdRon7So=;
	b=Lx81Q89yomaalHvInYxDH8y0BwsLHdrzJTrPGvblDr06oFAkP3Q2Kf1ZbLSuycMJjB
	m4YebMG0p1Hle1uezMgicq99vEDGoPsACSEXXgpaRByp6nRswoi08Aji3qMommUFbu66
	EQUQMgJzAuqz1OSbyKSakvjRjRgQ+/+BTsVUs94uYagO8zbmkmb5KXcb7la+7qj7KTAU
	8sENP66n5y/gNy63t+ETHZ8IQmVEyyna7WjF7CLAnlp8CsQtLl79SA6VURbmCgnHNiZl
	r8S5ycyy+kBwbs6BxXMq9AafvlA/YkecIbHnUExLn38O157ajLC1W57pp6jzrQiSQMAZ
	zhwA==
X-Gm-Message-State: ALoCoQnder5TEovslF4jvFwDYGQm/CacrrTbYm43L85MjDbz7LcK4SM2IS97FXl15o9LdFnTZCZu
X-Received: by 10.68.220.201 with SMTP id py9mr14886200pbc.33.1420722919449;
	Thu, 08 Jan 2015 05:15:19 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id r1sm4510067pdp.83.2015.01.08.05.15.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 Jan 2015 05:15:18 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 098AC5622F7; Thu,  8 Jan 2015 13:15:16 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Jan 2015 13:15:11 +0000
Message-Id: <21a82ed8c37c56e4ca0ee4b39e250711efd47ba5.1420722767.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
References: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1420722767.git.alexandru.damian@intel.com>
References: <cover.1420722767.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/5] toaster: write pre-read conf file for build variables
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
X-List-Received-Date: Thu, 08 Jan 2015 13:15:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We change the setting of variables from directly injection
into the set-up cooker to writing a conf file that is pre-read
on bitbake server startup. This is needed because the injection
can only happen after the variable set is parsed, and the variables
already inferred, so setting up variables happens too late.

[YOCTO #7045]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                             | 6 +++++-
 lib/toaster/bldcontrol/bbcontroller.py                  | 5 +++++
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 5 +----
 lib/toaster/orm/models.py                               | 1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 7511012..6969bf7 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -251,7 +251,11 @@ case $CMD in
             return 4
         fi
         unset BBSERVER
-        bitbake --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
+        PREREAD=""
+        if [ -e conf/toaster-pre.conf ]; then
+                PREREAD="--read conf/toaster-pre.conf"
+        fi
+        bitbake $PREREAD --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
         if [ $? -ne 0 ]; then
             start_success=0
             echo "Bitbake server start failed"
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 7c27fe1..102606e 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -135,6 +135,11 @@ class BuildEnvironmentController(object):
         bblayerconffile.write("# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
         bblayerconffile.close()
 
+    def writePreConfFile(self, variable_list):
+        prefilepath = os.path.join(self.be.builddir, "conf/toaster-pre.conf")
+        with open(prefilepath, "w") as prefile:
+            for i in variable_list:
+                prefile.write("%s=\"%s\"\n" % (i.name, i.value))
 
 
     def startBBServer(self, brbe):
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 56c989c..bdce6ee 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -53,14 +53,11 @@ class Command(NoArgsCommand):
 
             # set up the buid environment with the needed layers
             bec.setLayers(br.brbitbake_set.all(), br.brlayer_set.all())
+            bec.writePreConfFile(br.brvariable_set.all())
 
             # get the bb server running with the build req id and build env id
             bbctrl = bec.getBBController("%d:%d" % (br.pk, bec.be.pk))
 
-            # set the build configuration
-            for variable in br.brvariable_set.all():
-                bbctrl.setVariable(variable.name, variable.value)
-
             # trigger the build command
             task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, br.brtarget_set.all()))
             if len(task) == 0:
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 46b704c..6fbbeed 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -529,6 +529,7 @@ class Recipe_Dependency(models.Model):
 
 
 class Machine(models.Model):
+    search_allowed_fields = ["name", "description"]
     layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this machine
     up_id = models.IntegerField(null = True, default = None)                      # id of entry in the source
     up_date = models.DateTimeField(null = True, default = None)
-- 
1.9.1


