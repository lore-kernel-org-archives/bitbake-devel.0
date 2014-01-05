Return-Path: <andrei@gherzan.ro>
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
	by mail.openembedded.org (Postfix) with ESMTP id 13DE260CF1
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  5 Jan 2014 01:53:35 +0000 (UTC)
Received: by mail-ee0-f46.google.com with SMTP id d49so7131251eek.5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 04 Jan 2014 17:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=E0DOsGz3ZjCyyKfhvsRg/4e0miv7GkxoQj8Xz4EbcFA=;
	b=Zs4dNrCCd9lS9veXXP+IcvukGpXdmhewHP0fpjEfDbkm149dD4AlK9WS9YmrisBjtr
	SVdZxHmIBA6EkRzzjJtGUX53+xBhKCx+nlgVZbKDWdiXFn2PUhCoSYeV17XA9SSBN8BQ
	0a8WsEK5Ky8UyKzFx0QH5TBuAm1mm0zSzuuaUZywhd3HVzFu9cbj13OVvFzNoc5z6uCg
	qYXQKk4WvG+o6G0sYvr7YTL75EZoZur4G3graOoh2Mnojgt1Xp98fQVNJvKNaITDNBve
	pmzdsgaZx3qqAJBjihKpPB82auq5060okk9+nzO/BLOAy4GEBuI2Em2L4t91jTOWr86N
	1N6g==
X-Gm-Message-State: ALoCoQnnyZCOPcF9yrijq/cf1zvxe+55Ie/TMye/l/dGMyGWtRq3XEt1RccLA/prGvm9eH1cLGBY
X-Received: by 10.14.5.194 with SMTP id 42mr262545eel.100.1388886816747;
	Sat, 04 Jan 2014 17:53:36 -0800 (PST)
Received: from localhost.localdomain (5-13-221-193.residential.rdsnet.ro.
	[5.13.221.193])
	by mx.google.com with ESMTPSA id v1sm158114336eef.9.2014.01.04.17.53.35
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 Jan 2014 17:53:36 -0800 (PST)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  5 Jan 2014 03:53:28 +0200
Message-Id: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
X-Mailer: git-send-email 1.8.1.4
Subject: [PATCH] bitbake: bb.fetch2.git: Fix _latest_revision function while using tags
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
X-List-Received-Date: Sun, 05 Jan 2014 01:53:36 -0000

When getting the revision we must take into consideration if the name we are
looking for is a tag and in that case we need the dereferenced commit ID in
order to check for it existance in a specific branch.

So first search for the reference^{} commit ID and only if that returns nothing
get the name as it is.

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/git.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index b4b9368..1584232 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -318,9 +318,13 @@ class Git(FetchMethod):
               (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
-        output = runfetchcmd(cmd, d, True)
+        # Maybe the ref is a tag so try to dereference it first
+        output = runfetchcmd(cmd + '^{}', d, True)
         if not output:
-            raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
+            # Dereference gave nothing so try to get it as it is
+            output = runfetchcmd(cmd, d, True)
+            if not output:
+                raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
         return output.split()[0]
 
     def _build_revision(self, ud, d, name):
-- 
1.8.1.4


