Return-Path: <V.Vogelhuber@DigitalEndoscopy.de>
Received: from mxout51.expurgate.net (mxout51.expurgate.net [194.37.255.51])
	by mail.openembedded.org (Postfix) with ESMTP id 934A8609B2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Apr 2014 15:34:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1WfA2w-00014m-Lm for bitbake-devel@lists.openembedded.org;
	Tue, 29 Apr 2014 17:34:14 +0200
Received: from [80.81.19.29] (helo=SRV-MSX01.digitendos.local)
	by relay.expurgate.net with esmtp (Exim 4.80.1)
	(envelope-from <V.Vogelhuber@DigitalEndoscopy.de>)
	id 1WfA2w-0003mp-8P for bitbake-devel@lists.openembedded.org;
	Tue, 29 Apr 2014 17:34:14 +0200
Received: from [192.168.10.111] (192.168.10.111) by SRV-MSX01.digitendos.local
	(192.168.10.14) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Tue, 29 Apr 2014 17:34:11 +0200
Message-ID: <535FC66B.8050802@digitalendoscopy.de>
Date: Tue, 29 Apr 2014 17:34:03 +0200
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Originating-IP: [192.168.10.111]
X-TM-AS-Product-Ver: SMEX-10.1.0.2244-7.500.1017-20662.006
X-TM-AS-Result: No--10.138700-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-purgate-relay-fid: relay-d8919a
X-purgate-sourceid: 1WfA2w-0003mp-8P
X-purgate-Ad: Checked for spam and viruses by eXpurgate(R),
	see www.eleven.de for details.
X-purgate-ID: 151534::1398785654-00007EF9-8E761B7D/0/0
X-purgate: clean
X-purgate-type: clean
X-purgate-relay-bid: relay-230693
Subject: HG Fetch with username and password in url
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
X-List-Received-Date: Tue, 29 Apr 2014 15:34:18 -0000
X-Groupsio-MsgNum: 4695
Content-Type: multipart/mixed; boundary="------------050009030107090304050107"

--------------050009030107090304050107
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Following up a previous patch for mercurial fetcher, I just fixed a 
problem when calling update on a repository with subrepositories enabled.

Attached a patch that fixes this problem


--------------050009030107090304050107
Content-Type: text/x-patch;
	name="0001-fixed-authentication-issues-in-case-of-using-sub-rep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-fixed-authentication-issues-in-case-of-using-sub-rep.pa";
	filename*1="tch"

From caae519a2bd64bf7c729bb26aff344827def47fb Mon Sep 17 00:00:00 2001
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Date: Tue, 29 Apr 2014 15:29:47 +0200
Subject: [PATCH] - fixed authentication issues in case of using sub
 repositories

Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
---
 bitbake/lib/bb/fetch2/hg.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index cf21481..2b56e86 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -120,7 +120,7 @@ class Hg(FetchMethod):
             else:
                 cmd = "%s pull" % (basecmd)
         elif command == "update":
-            cmd = "%s update -C %s" % (basecmd, " ".join(options))
+            cmd = "%s update --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" -C %s" % (basecmd, ud.user, ud.pswd, proto, " ".join(options))
         else:
             raise FetchError("Invalid hg command %s" % command, ud.url)
 
-- 
1.9.1


--------------050009030107090304050107--
