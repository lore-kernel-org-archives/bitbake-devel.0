Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0D71A605BB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Feb 2016 15:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u19F9muf022453
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Feb 2016 15:09:48 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NNnxaicS-RdY for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Feb 2016 15:09:48 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u19F9jq7022447
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Feb 2016 15:09:46 GMT
Message-ID: <1455030585.16142.79.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 09 Feb 2016 15:09:45 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] utils: Drop datastore function inspection during exception
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
X-List-Received-Date: Tue, 09 Feb 2016 15:09:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When we use functions from the data store, they now have correct line number
and filename information. This function would attempt to correct line numbers
which doesn't need correcting, leading to misleading messages to the user.
Therefore remove this code as being obsoleted.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 9730b51..3f33e84 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -363,15 +363,6 @@ def _print_exception(t, value, tb, realfile, text, context):
                         error.extend(_print_trace(text, tbextract[level+1][1]))
                 except:
                     error.append(tbformat[level+1])
-            elif "d" in context and tbextract[level+1][2]:
-                # Try and find the code in the datastore based on the functionname
-                d = context["d"]
-                functionname = tbextract[level+1][2]
-                text = d.getVar(functionname, True)
-                if text:
-                    error.extend(_print_trace(text.split('\n'), tbextract[level+1][1]))
-                else:
-                    error.append(tbformat[level+1])
             else:
                 error.append(tbformat[level+1])
             nexttb = tb.tb_next



