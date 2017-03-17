Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com
	[209.85.214.45])
	by mail.openembedded.org (Postfix) with ESMTP id 878B477635
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Mar 2017 09:20:30 +0000 (UTC)
Received: by mail-it0-f45.google.com with SMTP id m27so16458387iti.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Mar 2017 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=Ipbm8f2k5HNp16WqNc6eD+cPh6NnXbT/orRXp0hY27k=;
	b=LX2d0wKBlIcWAryLyvHtRJhVoMfPihqz8n51CAEB1PUSdvGN3jB3G/ThOWfK1tQ4pz
	bc7/mP4tnk8HatSoskHEGxOtmDJN+TEakewbwVkGZMt78rWSxYESUPWoeSQYW4kv/TNw
	NGgtR8LWBuoXXOtQ06IepVH8SeoggI+wB1m8UyilaCXfe+EZl47+FTNdbz4scQJ58mCy
	kHkSlZwTkZZYDooy6Vh+LdOAhK1E9BdKTXBiLlHey8nlGCLWzv2ak14PRm49pyVQSiIb
	lnkdxPTtUA0GA5FVJMKj6a4q6GuCp6uIYbdZcCw1xc4CL5enDMqvwXSvRkFr4sXdlUv2
	fLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Ipbm8f2k5HNp16WqNc6eD+cPh6NnXbT/orRXp0hY27k=;
	b=Z7m2ycYP3LA3u0H1L36C35nu2KBCE9tYxedkjnKYDojisoGfvk7mTNxk1NrMrWKAby
	AXaP+y8rvdMymRZ5s/gA4RpmodbXiBmzlC23BHowXgr4pVQ1JpqPwIB8cr7nrPl9KsfD
	wlaqmb2D+aX9skSMiFlBbMcEpaBXyFfSG3srr7l9fAGpMq69tMZ6wS/CAP6nIzcREQYK
	2qTK3GYTFgJ/gHtPcnse+BLa9q0n1G9AXe2iWl2KLWXFR7T1MAJJsvCKmGMjuZwOTxL6
	llu3pKYkOw3HVd/2jLKeXewVAJ8p/1Yr61BHf6XRDL2JsS0xkboG9FeYBPMYFnwKUbse
	mUKQ==
X-Gm-Message-State: AFeK/H1Q+BJQwJ94Dgc3ucf0o0A7CFxQDU18H87Hm9b19vu/CTOT+5DRtlimb65WXJGYsq2U
X-Received: by 10.107.186.67 with SMTP id k64mr16245476iof.28.1489742431496;
	Fri, 17 Mar 2017 02:20:31 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8C17C.dip0.t-ipconnect.de.
	[93.232.193.124])
	by smtp.gmail.com with ESMTPSA id 10sm828876itm.12.2017.03.17.02.20.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 17 Mar 2017 02:20:29 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Mar 2017 10:20:23 +0100
Message-Id: <20170317092023.10640-1-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] taskdata.py: include more information in error message about broken task depends
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
X-List-Received-Date: Fri, 17 Mar 2017 09:20:31 -0000

This is what was reported when variable expansion in the 'depends'
varflag of a task was broken:

   ERROR: Error for .../refkit-image-common.bb, dependency ${@ does not contain exactly one ':' character.
    Task 'depends' should be specified in the form 'packagename:task'

It's not clear which task had this broken 'depends' and while one can
guess that variable expansion failed, the full expression isn't
printed either.

This is more useful:

   ERROR: Error for .../refkit-image-common.bb:do_stage_swupd_inputs[depends], dependency ${@ in '      virtual/fakeroot-native:do_populate_sysroot     ${@ ' '.join(['bundle-refkit-image-common-%s:do_swupd_list_bundle' % x for x in '${SWUPD_BUNDLES}'.split()]) } ' does not contain exactly one ':' character.
    Task 'depends' should be specified in the form 'packagename:task'

The 'depends' part gets repeated intentionally, to ensure that it doesn't get overlooked.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/taskdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 1f3b24c8..8c96a562 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -97,7 +97,7 @@ class TaskData:
                     if dep:
                         parts = dep.split(":")
                         if len(parts) != 2:
-                            bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain exactly one ':' character.\n Task '%s' should be specified in the form 'packagename:task'" % (fn, dep, dep_name))
+                            bb.msg.fatal("TaskData", "Error for %s:%s[%s], dependency %s in '%s' does not contain exactly one ':' character.\n Task '%s' should be specified in the form 'packagename:task'" % (fn, task, dep_name, dep, task_deps[dep_name][task], dep_name))
                         ids.append((parts[0], parts[1]))
                         seen(parts[0])
                 depends.extend(ids)
-- 
2.11.0


