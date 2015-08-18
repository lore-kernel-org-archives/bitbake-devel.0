Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 1438A60043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:06 +0000 (UTC)
Received: by wijp15 with SMTP id p15so105167643wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=fNSrHYt4nXpuQTudYNmY7xWK4kwAUz48BiXtfiJEng0=;
	b=KUW3FAXxWU6qajw0+koVx3ua85EklfpKrRy9kyaG9+1AaiTjx7uy0OUJZocjs5+zU0
	RcrunlsLEMnEPeCOYR0YdDOESOsm6NBN3Br4D9YrcQCqUwUM2k3M5Q3ZSbRBnufXgf+I
	4RNz2LXoZTR29NDE1eiG1peYFx56sZPEjslHP6Y6JYXHvdqDrzAOmO640ga6oVcAFpId
	+tozRSXg4/0r05P1IL3PuqynIOLvcJ8VaLDYRIAw3DkEphS92ocSJvgyirtNA3Odxq3K
	i21z22AyMcgcpbhDnfgqrT2248Q+hvW5X8T3ntxbpIHLc1NT+MwZ3BsoXIEIKpJrci1x
	1vjQ==
X-Gm-Message-State: ALoCoQkpqgNZB7eSKosPW2HblhxnJnfE33sEswLDlNPzsWJk2EUb/GkzJ+Y5hp/SBBZ9QxAJzlGI
X-Received: by 10.180.20.48 with SMTP id k16mr46259977wie.56.1439915346715;
	Tue, 18 Aug 2015 09:29:06 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.05
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:06 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:49 +0100
Message-Id: <d0adedf2a95aeffbd38e7e807d7b22f2aeaae778.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 03/14] bitbake: toaster: checksettings: fix TEMPLATECONF detection
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Improving the TEMPLATECONF detection by verifying the return
code and dumping extra debug information in case of exception.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 2978db2..83b4f28 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -166,7 +166,12 @@ class Command(NoArgsCommand):
                     for dirname in self._recursive_list_directories(be.sourcedir,2):
                         if os.path.exists(os.path.join(dirname, ".templateconf")):
                             import subprocess
-                            conffilepath, error = subprocess.Popen('bash -c ". '+os.path.join(dirname, ".templateconf")+'; echo \"\$TEMPLATECONF\""', shell=True, stdout=subprocess.PIPE).communicate()
+                            proc = subprocess.Popen('bash -c ". '+os.path.join(dirname, ".templateconf")+'; echo \"\$TEMPLATECONF\""', shell=True, stdout=subprocess.PIPE)
+                            conffilepath, stderroroutput = proc.communicate()
+                            proc.wait()
+                            if proc.returncode != 0:
+                                raise Exception("Failed to source TEMPLATECONF: %s" % stderroroutput)
+
                             conffilepath = os.path.join(conffilepath.strip(), "toasterconf.json")
                             candidatefilepath = os.path.join(dirname, conffilepath)
                             if "toaster_cloned" in candidatefilepath:
@@ -195,6 +200,7 @@ class Command(NoArgsCommand):
                                     return is_changed
                         except Exception as e:
                             print "Failure while trying to import the toaster config file: %s" % e
+                            traceback.print_exc(e)
                     else:
                         print "\n Toaster could not find a configuration file. You need to configure Toaster manually using the web interface, or create a configuration file and use\n  bitbake/lib/toaster/managepy.py loadconf [filename]\n command to load it. You can use https://wiki.yoctoproject.org/wiki/File:Toasterconf.json.txt.patch as a starting point."
 
-- 
2.1.4


