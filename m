Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2BDF9607F8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 20:53:27 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5KKxhis030597; Thu, 20 Jun 2013 21:59:43 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8uj5Ji4HBIQw; Thu, 20 Jun 2013 21:59:43 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5KKxeNF030592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 20 Jun 2013 21:59:41 +0100
Message-ID: <1371761594.20823.244.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 20 Jun 2013 21:53:14 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Ensure variable flags are accounted for in config data hash
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 20 Jun 2013 20:53:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if the flags set against a variable in the base data store
change, it doesn't automatically trigger a reparse when it really
should. For example with the blacklist class setting:

PNBLACKLIST[qemu] = "bar"
PNBLACKLIST[bash] = "foo"

will not trigger a reparse if only one entry is changed and a
blacklisted recipe can still be built.

I did consider using BB_SIGNATURE_EXCLUDE_FLAGS in here however it
doesn't make sense, we want to trigger a reparse when any of the
flags change too (which is different to the sstate signatures which
we wouldn't want to change in those cases).

[YOCTO #4627]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 2fd8ccd..fa7811e 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -738,6 +738,12 @@ class DataSmart(MutableMapping):
             value = d.getVar(key, False) or ""
             data.update({key:value})
 
+            varflags = d.getVarFlags(key)
+            if not varflags:
+                continue
+            for f in varflags:
+                data.update({'%s[%s]' % (key, f):varflags[f]})
+
         for key in ["__BBTASKS", "__BBANONFUNCS", "__BBHANDLERS"]:
             bb_list = d.getVar(key, False) or []
             bb_list.sort()



