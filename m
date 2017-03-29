Return-Path: <pidge@toganlabs.com>
Received: from egyptian.birch.relay.mailchannels.net
	(egyptian.birch.relay.mailchannels.net [23.83.209.56])
	by mail.openembedded.org (Postfix) with ESMTP id AD4D277BD5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Mar 2017 09:51:23 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 278398A2526
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Mar 2017 09:51:25 +0000 (UTC)
Received: from hp181.hostpapa.com (unknown [100.96.126.101])
	by relay.mailchannels.net (Postfix) with ESMTPA id A1D048A2873
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Mar 2017 09:51:24 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from hp181.hostpapa.com (hp181.hostpapa.com [172.20.66.218])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.37); Wed, 29 Mar 2017 09:51:25 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostpapa|x-authuser|pidge@toganlabs.com
X-MailChannels-Auth-Id: hostpapa
X-Tart-Decisive: 6e94b9856b31f6fb_1490781084893_2421907627
X-MC-Loop-Signature: 1490781084893:3033859526
X-MC-Ingress-Time: 1490781084892
Received: from ns325767.ip-37-187-157.eu ([37.187.157.197]:38355
	helo=ns325767.ovh.net) by hp181.hostpapa.com with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-SHA256:128) (Exim 4.87)
	(envelope-from <pidge@toganlabs.com>)
	id 1ctAGB-000Zb7-Eb; Wed, 29 Mar 2017 11:51:23 +0200
From: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Mar 2017 12:04:06 +0200
Message-Id: <1490781846-2121-1-git-send-email-pidge@toganlabs.com>
X-Mailer: git-send-email 1.9.1
X-OutGoing-Spam-Status: No, score=5.0
X-AuthUser: pidge@toganlabs.com
Subject: [PATCH] s3.py: Remove hardcoded aws
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
X-List-Received-Date: Wed, 29 Mar 2017 09:51:24 -0000

This commit looks to see if FETCHCMD_s3 is set and if not, sets
it.

This is needed because I've use cases where I don't use aws, but
s3cmd (due to license).

Signed-off-by: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
---
 lib/bb/fetch2/s3.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 27993aa..9157c46 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -53,6 +53,8 @@ class S3(FetchMethod):
         else:
             ud.basename = os.path.basename(ud.path)
 
+        ud.basecmd = d.getVar("FETCHCMD_s3", True) or "/usr/bin/env aws s3"
+
         ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
 
     def download(self, ud, d):
@@ -61,7 +63,7 @@ class S3(FetchMethod):
         Assumes localpath was called first
         """
 
-        cmd = 'aws s3 cp s3://%s%s %s' % (ud.host, ud.path, ud.localpath)
+        cmd = '%s cp s3://%s%s %s' % (ud.basecmd, ud.host, ud.path, ud.localpath)
         bb.fetch2.check_network_access(d, cmd, ud.url)
         runfetchcmd(cmd, d)
 
@@ -83,7 +85,7 @@ class S3(FetchMethod):
         Check the status of a URL
         """
 
-        cmd = 'aws s3 ls s3://%s%s' % (ud.host, ud.path)
+        cmd = '%s ls s3://%s%s' % (ud.basecmd, ud.host, ud.path)
         bb.fetch2.check_network_access(d, cmd, ud.url)
         output = runfetchcmd(cmd, d)
 
-- 
1.9.1


