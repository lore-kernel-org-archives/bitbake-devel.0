Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2561B6067D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Mar 2016 17:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2SH4ClY010835; Mon, 28 Mar 2016 18:04:12 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AHE8lNiWuMFY; Mon, 28 Mar 2016 18:04:12 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2SH4AuW010831
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Mar 2016 18:04:11 +0100
Message-ID: <1459184650.21672.5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 28 Mar 2016 18:04:10 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Igor Stoppa <igor.stoppa@intel.com>
Subject: [PATCH] cookerdata: Improve handling of ParseError
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
X-List-Received-Date: Mon, 28 Mar 2016 17:04:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If local.conf contains an invalid line, e.g.:

 APPEND += " igor"

(note the leading space) then nasty tracebacks are shown which confuse the
user. Change so the parse error is simply shown without a traceback, improving
the user experience.

[YOCTO #9332]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 9f40674..c5fdf66 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -182,7 +182,7 @@ def catch_parse_error(func):
             parselog.critical(traceback.format_exc())
             parselog.critical("Unable to parse %s: %s" % (fn, exc))
             sys.exit(1)
-        except (bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
+        except bb.data_smart.ExpansionError as exc:
             import traceback
 
             bbdir = os.path.dirname(__file__) + os.sep
@@ -193,6 +193,8 @@ def catch_parse_error(func):
                 if not fn.startswith(bbdir):
                     break
             parselog.critical("Unable to parse %s", fn, exc_info=(exc_class, exc, tb))
+        except bb.parse.ParseError as exc:
+            parselog.critical(str(exc))
             sys.exit(1)
     return wrapped
 



