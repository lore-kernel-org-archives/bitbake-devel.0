Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 02B8D6FFA1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 11:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2VBl7m7007113 for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 12:47:20 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GlzwIB40rT_T for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 12:47:20 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2VBlDmh007125
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 12:47:14 +0100
Message-ID: <1459424833.21672.64.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 31 Mar 2016 12:47:13 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: Don't limit traceback lengths to arbitrary values
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
X-List-Received-Date: Thu, 31 Mar 2016 11:47:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There appears to have been a lot of copy and pasting of the code
which prints tracebacks upon failure and limits the stack trace to
5 entries. This obscures the real error and is very confusing to the user
it look me an age to work out why some tracebacks weren't useful.

This patch removes the limit, making tracebacks much more useful for
debugging.

[YOCTO #9230]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index fb13044..d47a669 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -1068,5 +1068,5 @@ if __name__ == "__main__":
     except Exception:
         ret = 1
         import traceback
-        traceback.print_exc(5)
+        traceback.print_exc()
     sys.exit(ret)
diff --git a/bitbake/bin/bitbake-prserv b/bitbake/bin/bitbake-prserv
index a8d7acb..0382144 100755
--- a/bitbake/bin/bitbake-prserv
+++ b/bitbake/bin/bitbake-prserv
@@ -50,6 +50,6 @@ if __name__ == "__main__":
     except Exception:
         ret = 1
         import traceback
-        traceback.print_exc(5)
+        traceback.print_exc()
     sys.exit(ret)
 
diff --git a/bitbake/bin/image-writer b/bitbake/bin/image-writer
index 7d71167..e30ab45 100755
--- a/bitbake/bin/image-writer
+++ b/bitbake/bin/image-writer
@@ -119,4 +119,4 @@ if __name__ == '__main__':
         gtk.main()
     except Exception:
         import traceback
-        traceback.print_exc(3)
+        traceback.print_exc()
diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
index 2b312cb..754636f 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
@@ -146,7 +146,7 @@ if __name__ == "__main__":
     except:
         ret = 1
         import traceback
-        traceback.print_exc(5)
+        traceback.print_exc()
     finally:
         if os.getenv('TOASTER_SUITE'):
             del os.environ['TOASTER_SUITE']



