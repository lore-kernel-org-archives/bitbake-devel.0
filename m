Return-Path: <V.Vogelhuber@DigitalEndoscopy.de>
X-Greylist: delayed 1937 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 26 May 2014 07:57:32 UTC
Received: from mxout51.expurgate.net (unknown [194.37.255.51])
	by mail.openembedded.org (Postfix) with ESMTP id 2945F60196
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 May 2014 07:57:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1WopHY-0003Wp-8Q for bitbake-devel@lists.openembedded.org;
	Mon, 26 May 2014 09:25:16 +0200
Received: from [80.81.19.29] (helo=SRV-MSX01.digitendos.local)
	by relay.expurgate.net with esmtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1WopHT-0007X0-Lx for bitbake-devel@lists.openembedded.org;
	Mon, 26 May 2014 09:25:11 +0200
Received: from [192.168.10.111] (192.168.10.111) by SRV-MSX01.digitendos.local
	(192.168.10.14) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Mon, 26 May 2014 09:25:10 +0200
Message-ID: <5382EC56.5090701@digitalendoscopy.de>
Date: Mon, 26 May 2014 09:25:10 +0200
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [192.168.10.111]
X-TM-AS-Product-Ver: SMEX-10.1.0.2244-7.500.1017-20716.002
X-TM-AS-Result: No--16.450300-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-purgate-relay-fid: relay-938205
X-purgate-sourceid: 1WopHT-0007X0-Lx
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R),
	see www.eleven.de for details.
X-purgate-ID: 151534::1401089112-00007EF9-C1152DBE/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-230693
Subject: Fixed missing proto param in hg checkout with user and pw
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
X-List-Received-Date: Mon, 26 May 2014 07:57:34 -0000
X-Groupsio-MsgNum: 4736
Content-Type: multipart/mixed; boundary="------------020807000601000304020306"

--------------020807000601000304020306
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Attached a fix for the former patch when checking out a repository with 
username and password using HG

(Hopefully this is the last time, sorry for not having test my former 
one properly before posting)

Regards,
    Volker

--------------020807000601000304020306
Content-Type: text/x-patch;
	name="0001-fixed-missing-proto-param-for-hg-checkout-with-user-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-fixed-missing-proto-param-for-hg-checkout-with-user-.pa";
	filename*1="tch"

From 5834eb8675c0d0b9e622e2ce9473ec36220dee2a Mon Sep 17 00:00:00 2001
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Date: Mon, 26 May 2014 09:22:03 +0200
Subject: [PATCH 1/1] - fixed missing proto param for hg checkout with user and
 pw

Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
---
 bitbake/lib/bb/fetch2/hg.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 157b1b1..5760fcd 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -111,7 +111,7 @@ class Hg(FetchMethod):
 
         if command == "fetch":
             if ud.user and ud.pswd:
-                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (basecmd, ud.user, ud.pswd, " ".join(options), proto, hgroot, ud.module, ud.module)
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (basecmd, ud.user, ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
             else:
                 cmd = "%s clone %s %s://%s/%s %s" % (basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)	      
         elif command == "pull":
-- 
1.9.1


--------------020807000601000304020306--
