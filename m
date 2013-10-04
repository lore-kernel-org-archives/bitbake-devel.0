Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8BD4A6CC57
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 13:25:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DP1Pe008233 for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:25:01 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vcU81hnHRQ_S for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 14:25:01 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DOt0F008225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:24:57 +0100
Message-ID: <1380893090.18603.607.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 Oct 2013 14:24:50 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bin/bitbake: Clarify server error message
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
X-List-Received-Date: Fri, 04 Oct 2013 13:25:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Getting an error message about --remote-server being set when really
BBSERVER was is confusing, clarify the message.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 920c6c4..88893f8 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -262,8 +262,8 @@ def main():
         if not configParams.bind:
             sys.exit("FATAL: The '--server-only' option requires a name/address to bind to with the -B option.\n")
         if configParams.remote_server:
-            sys.exit("FATAL: The '--server-only' option conflicts with the '--remote-server' option. %s\n" % 
-                ("Please check your BBSERVER environment" if "BBSERVER" in os.environ else "" ))
+            sys.exit("FATAL: The '--server-only' option conflicts with %s.\n" % 
+                ("the BBSERVER environment variable" if "BBSERVER" in os.environ else "the '--remote-server' option" ))
 
     if configParams.bind and configParams.servertype != "xmlrpc":
         sys.exit("FATAL: If '-B' or '--bind' is defined, we must set the servertype as 'xmlrpc'.\n")



