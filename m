Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5A1C86CC57
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 13:17:56 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DHOIG007754 for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:17:52 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id X-lGZfJDGpWq for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 14:17:52 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DHnjp007771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:17:51 +0100
Message-ID: <1380892665.18603.606.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 Oct 2013 14:17:45 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bin/bitbake: Clear ui-queue when starting a server
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
X-List-Received-Date: Fri, 04 Oct 2013 13:17:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When starting a server we don't want to show the debug event queue which
is reserved for when when errors have occurred. This patch copies the UI
code to ensure the user doesn't see confusing output.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 4d93a35..920c6c4 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -292,6 +292,7 @@ def main():
     if not configParams.remote_server:
         # we start a server with a given configuration
         server = start_server(servermodule, configParams, configuration)
+        bb.event.ui_queue = []
     else:
         # we start a stub server that is actually a XMLRPClient that connects to a real server
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)



