Return-Path: <V.Vogelhuber@DigitalEndoscopy.de>
X-Greylist: delayed 1815 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 09 May 2014 08:43:39 UTC
Received: from mxout51.expurgate.net (unknown [91.198.224.51])
	by mail.openembedded.org (Postfix) with ESMTP id 2E3BD60703
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 May 2014 08:43:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1Wifvp-0005xT-6w for bitbake-devel@lists.openembedded.org;
	Fri, 09 May 2014 10:13:25 +0200
Received: from [80.81.19.29] (helo=SRV-MSX01.digitendos.local)
	by relay.expurgate.net with esmtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1Wifvo-0006uR-CY for bitbake-devel@lists.openembedded.org;
	Fri, 09 May 2014 10:13:24 +0200
Received: from [192.168.10.111] (192.168.10.111) by SRV-MSX01.digitendos.local
	(192.168.10.14) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Fri, 9 May 2014 10:13:21 +0200
Message-ID: <536C8E01.5050600@digitalendoscopy.de>
Date: Fri, 9 May 2014 10:12:49 +0200
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [192.168.10.111]
X-TM-AS-Product-Ver: SMEX-10.1.0.2244-7.500.1017-20682.005
X-TM-AS-Result: No--9.899400-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-purgate-relay-fid: relay-9b77e0
X-purgate-sourceid: 1Wifvo-0006uR-CY
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R),
	see www.eleven.de for details.
X-purgate-ID: 151534::1399623204-0000693D-CEC9F03B/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-b62ce8
Subject: HG clone with username and password in url
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
X-List-Received-Date: Fri, 09 May 2014 08:43:42 -0000
X-Groupsio-MsgNum: 4713
Content-Type: multipart/mixed; boundary="------------070806080507080508020707"

--------------070806080507080508020707
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Unfortunately my last patch for the hg fetcher (in dylan's bitbake 
version) with username and password was incomplete.
The following patch hopefully fixes all cases where username and pasword 
authorization may be required.



--------------070806080507080508020707
Content-Type: text/x-patch;
	name="0001-fix-cloning-of-mercurial-repository-with-username-an.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-fix-cloning-of-mercurial-repository-with-username-an.pa";
	filename*1="tch"

From ed81d51a391c39aa42d01bf9ebf00e9f88dd9c90 Mon Sep 17 00:00:00 2001
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Date: Fri, 9 May 2014 10:10:13 +0200
Subject: [PATCH] fix cloning of mercurial repository with username and
 password specified in url

Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
---
 bitbake/lib/bb/fetch2/hg.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index cf21481..8c41d4d 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -110,7 +110,10 @@ class Hg(FetchMethod):
             options.append("-r %s" % ud.revision)
 
         if command == "fetch":
-            cmd = "%s clone %s %s://%s/%s %s" % (basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)
+            if ud.user and ud.pswd:
+                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (basecmd, ud.user, ud.pswd, " ".join(options), proto, hgroot, ud.module, ud.module)
+            else:
+                cmd = "%s clone %s %s://%s/%s %s" % (basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)	      
         elif command == "pull":
             # do not pass options list; limiting pull to rev causes the local
             # repo not to contain it and immediately following "update" command
-- 
1.9.1


--------------070806080507080508020707--
