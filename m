Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AE37672390
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 14:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sAREwvsU013445 for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 14:58:57 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Vby5kT67mPK7 for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 14:58:57 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sAREwiKG013441
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 14:58:55 GMT
Message-ID: <1417100361.15614.14.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 27 Nov 2014 14:59:21 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Allow featureset in error state
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
X-List-Received-Date: Thu, 27 Nov 2014 14:59:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, if an invalid PR service is selected the server will error
with a traceback. This is because its set into the error state and the
setFeature code will then fail since its not in the initial state.

Modifying the featureset in the error state is acceptable, we just need
to ensure we don't trigger a reset, that would happen from whichever
code handles the error.

[YOCTO #6934]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a08c14b..df9a0ca 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -165,13 +165,13 @@ class BBCooker:
 
     def setFeatures(self, features):
         # we only accept a new feature set if we're in state initial, so we can reset without problems
-        if self.state != state.initial:
+        if self.state != state.initial and self.state != state.error:
             raise Exception("Illegal state for feature set change")
         original_featureset = list(self.featureset)
         for feature in features:
             self.featureset.setFeature(feature)
         bb.debug(1, "Features set %s (was %s)" % (original_featureset, list(self.featureset)))
-        if (original_featureset != list(self.featureset)):
+        if (original_featureset != list(self.featureset)) and self.state != state.error:
             self.reset()
 
     def initConfigurationData(self):



