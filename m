Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id 696476011C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jul 2016 15:42:40 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 82CEA124842;
	Mon,  4 Jul 2016 15:34:57 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-123-105-117.us-west-2.compute.internal [10.123.105.117])
	by relay.mailchannels.net (Postfix) with ESMTPA id B9E28123F56;
	Mon,  4 Jul 2016 15:34:56 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Mon, 04 Jul 2016 15:34:57 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467646497060:1259397535
X-MC-Ingress-Time: 1467646497060
Received: from [176.251.41.101] (port=51684 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bK5wH-0007ND-Uh; Mon, 04 Jul 2016 11:37:38 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jul 2016 16:34:46 +0100
Message-Id: <1467646486-3262-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467646486-3262-1-git-send-email-elliot.smith@intel.com>
References: <1467646486-3262-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 2/2] toaster: views Fix most frequently built target in project reporting
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
X-List-Received-Date: Mon, 04 Jul 2016 15:42:42 -0000

From: Michael Wood <michael.g.wood@intel.com>

Clean up and fix the most frequently built targets for the "Most built
recipes" section for the project configuration page.

[YOCTO #9846]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/views.py | 42 +++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index c40273c..2db68bd 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -1404,15 +1404,37 @@ if True:
         pid = prj.id
 
         from collections import Counter
-        freqtargets = []
-        try:
-            btargets = sum(build.target_set.all() for build in Build.objects.filter(project=prj, outcome__lt=Build.IN_PROGRESS))
-            brtargets = sum(br.brtarget_set.all() for br in BuildRequest.objects.filter(project = prj, state = BuildRequest.REQ_FAILED))
-            freqtargets = [x.target for x in btargets] + [x.target for x in brtargets]
-        except TypeError:
-            pass
-        freqtargets = Counter(freqtargets)
-        freqtargets = sorted(freqtargets, key = lambda x: freqtargets[x], reverse=True)
+
+        freqtargets = Counter(Target.objects.filter(
+            Q(build__project=prj),
+            ~Q(build__outcome=Build.IN_PROGRESS)
+        ).order_by("target").values_list("target", flat=True))
+
+        freqtargets = freqtargets.most_common(5)
+
+        # We now have the targets in order of frequency but if there are two
+        # with the same frequency then we need to make sure those are in
+        # alphabetical order without losing the frequency ordering
+
+        tmp = []
+        switch = None
+        for i, freqtartget in enumerate(freqtargets):
+            target, count = freqtartget
+            try:
+                target_next, count_next = freqtargets[i+1]
+                if count == count_next and target > target_next:
+                    switch = target
+                    continue
+            except IndexError:
+                pass
+
+            tmp.append(target)
+
+            if switch:
+                tmp.append(switch)
+                switch = None
+
+        freqtargets = tmp
 
         layers = [{"id": x.layercommit.pk, "orderid": x.pk, "name" : x.layercommit.layer.name,
                    "vcs_url": x.layercommit.layer.vcs_url, "vcs_reference" : x.layercommit.get_vcs_reference(),
@@ -1432,7 +1454,7 @@ if True:
             "layers" : layers,
             "targets" : [{"target" : x.target, "task" : x.task, "pk": x.pk} for x in prj.projecttarget_set.all()],
             "variables": [(x.name, x.value) for x in prj.projectvariable_set.all()],
-            "freqtargets": freqtargets[:5],
+            "freqtargets": freqtargets,
             "releases": [{"id": x.pk, "name": x.name, "description":x.description} for x in Release.objects.all()],
             "project_html": 1,
             "recipesTypeAheadUrl": reverse('xhr_recipestypeahead', args=(prj.pk,)),
-- 
2.7.4


