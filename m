Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 69D317316D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0TB761Z017002 for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:07:06 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id n869PbnzCsFG for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:07:06 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0TB72lq016998
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 11:07:03 GMT
Message-ID: <1454065622.10340.62.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 29 Jan 2016 11:07:02 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] utils: Add ability to change the process name
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
X-List-Received-Date: Fri, 29 Jan 2016 11:07:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Being able to tell the bitbake processes apart is useful for debugging.
Add a helper function which allows this without making it a hard 
dependency. Errors are ignored, this is just nice to have.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 9a3efb2..ae10213 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1395,3 +1395,14 @@ def ioprio_set(who, cls, value):
             raise ValueError("Unable to set ioprio, syscall returned %s" % rc)
     else:
         bb.warn("Unable to set IO Prio for arch %s" % _unamearch)
+
+def set_process_name(name):
+    from ctypes import cdll, byref, create_string_buffer
+    # This is nice to have for debugging, not essential
+    try:
+        libc = cdll.LoadLibrary('libc.so.6')
+        buff = create_string_buffer(len(name)+1)
+        buff.value = name
+        libc.prctl(15, byref(buff), 0, 0, 0)
+    except:
+        pass



