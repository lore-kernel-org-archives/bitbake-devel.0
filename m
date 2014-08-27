Return-Path: <V.Vogelhuber@DigitalEndoscopy.de>
X-Greylist: delayed 2379 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 27 Aug 2014 11:27:28 UTC
Received: from mxout51.expurgate.net (mxout51.expurgate.net [91.198.224.51])
	by mail.openembedded.org (Postfix) with ESMTP id 2DECF71157
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 11:27:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1XMalZ-0000Cb-JL for bitbake-devel@lists.openembedded.org;
	Wed, 27 Aug 2014 12:47:49 +0200
Received: from [80.81.19.29] (helo=SRV-MSX01.digitendos.local)
	by relay.expurgate.net with esmtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1XMalZ-0007PZ-1f for bitbake-devel@lists.openembedded.org;
	Wed, 27 Aug 2014 12:47:49 +0200
Received: from [192.168.10.111] (192.168.10.111) by SRV-MSX01.digitendos.local
	(192.168.10.14) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Wed, 27 Aug 2014 12:47:47 +0200
Message-ID: <53FDB74E.8000600@digitalendoscopy.de>
Date: Wed, 27 Aug 2014 12:47:42 +0200
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [192.168.10.111]
X-TM-AS-Product-Ver: SMEX-10.1.0.2244-7.500.1018-20910.002
X-TM-AS-Result: No--7.654500-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-purgate-relay-fid: relay-b62ce8
X-purgate-sourceid: 1XMalZ-0007PZ-1f
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R),
	see www.eleven.de for details.
X-purgate-ID: 151534::1409136469-00001D43-B91C73F8/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-f3ed12
Subject: HG clone using subrepositories with username and password in url
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
X-List-Received-Date: Wed, 27 Aug 2014 11:27:36 -0000
X-Groupsio-MsgNum: 5002
Content-Type: multipart/mixed; boundary="------------050709060104050905030107"

--------------050709060104050905030107
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

In case one uses mercurial subrepositories, updating to a specific 
revision may need an additional authentication for the subrepository. So 
the attached patch adds the missing authentication parameters to the hg 
update call.





--------------050709060104050905030107
Content-Type: text/x-patch;
	name="0001-Fixed-authentication-during-update-in-case-of-using-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fixed-authentication-during-update-in-case-of-using-.pa";
	filename*1="tch"

From 45f7226b02e0911f7a612ab208b2139cbd03ec56 Mon Sep 17 00:00:00 2001
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Date: Wed, 27 Aug 2014 12:41:35 +0200
Subject: [PATCH 1/1] Fixed authentication during update in case of using
 subrepositories

Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
---
 bitbake/lib/bb/fetch2/hg.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index cf21481..ab7b5f8 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -120,7 +120,10 @@ class Hg(FetchMethod):
             else:
                 cmd = "%s pull" % (basecmd)
         elif command == "update":
-            cmd = "%s update -C %s" % (basecmd, " ".join(options))
+            if ud.user and ud.pswd:
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (basecmd, ud.user, ud.pswd, proto, " ".join(options))
+            else:
+                cmd = "%s update -C %s" % (basecmd, " ".join(options))
         else:
             raise FetchError("Invalid hg command %s" % command, ud.url)
 
-- 
1.9.1


--------------050709060104050905030107--
