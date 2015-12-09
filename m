Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 380D56612D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 12:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB9C3KCA027041
	for <bitbake-devel@lists.openembedded.org>; Wed, 9 Dec 2015 12:03:20 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PDqxuJh0-PlZ for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 12:03:20 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB9C2wOP027016
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 9 Dec 2015 12:03:19 GMT
Message-ID: <1449662576.29412.19.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 09 Dec 2015 12:02:56 +0000
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] event: Fix subprocess event error traceback failures
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
X-List-Received-Date: Wed, 09 Dec 2015 12:03:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If subprocess raises a CalledProcessError() error, e.g. from a call
like subprocess.check_call("false"), bitbake would try and pass the
object over IPC and fail, leading to an unusual error:

('__init__() takes at least 3 arguments (1 given)', <class 'subprocess.CalledProcessError'>, ())%

To avoid this, we turn the value into a string which prevents the
issues the IPC has trying to deal with the object (for the same reason
we deal with tracebacks here too).

[YOCTO #8752]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/event.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 366bc41..ec25ce7 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -595,6 +595,8 @@ class LogHandler(logging.Handler):
             etype, value, tb = record.exc_info
             if hasattr(tb, 'tb_next'):
                 tb = list(bb.exceptions.extract_traceback(tb, context=3))
+            # Need to turn the value into something the logging system can pickle
+            value = str(value)
             record.bb_exc_info = (etype, value, tb)
             record.exc_info = None
         fire(record, None)



