Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 74B9D71044
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 13:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RDuT5t001837 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:56:29 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BkQcJGQJA9KL for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:56:29 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RDuNmb001833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:56:24 +0100
Message-ID: <1409147785.5772.51.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Aug 2014 14:56:25 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] utils: Improve profile log processing
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
X-List-Received-Date: Wed, 27 Aug 2014 13:56:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This stream redirection of stdout is horrible. pstats takes a stream argument
so lets use that instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 7d37a74..670e592 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -862,21 +862,16 @@ def nonblockingfd(fd):
     fcntl.fcntl(fd, fcntl.F_SETFL, fcntl.fcntl(fd, fcntl.F_GETFL) | os.O_NONBLOCK)
 
 def process_profilelog(fn):
-    # Redirect stdout to capture profile information
     pout = open(fn + '.processed', 'w')
-    so = sys.stdout.fileno()
-    orig_so = os.dup(sys.stdout.fileno())
-    os.dup2(pout.fileno(), so)
    
     import pstats
-    p = pstats.Stats(fn)
+    p = pstats.Stats(fn, stream=pout)
     p.sort_stats('time')
     p.print_stats()
     p.print_callers()
     p.sort_stats('cumulative')
     p.print_stats()
 
-    os.dup2(orig_so, so)
     pout.flush()
     pout.close()  
 



