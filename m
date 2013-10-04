Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id DB36160FA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 13:15:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DF0e7007655 for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:15:00 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mZEYWuJvY6k9 for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 14:14:59 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DEvHd007652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:14:58 +0100
Message-ID: <1380892492.18603.601.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 Oct 2013 14:14:52 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bin/bitbake: Catch establish connection log messages
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
X-List-Received-Date: Fri, 04 Oct 2013 13:15:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If for example you try "bitbake -m" with an invalid BBSERVER, error
messages are not dsplayed. This change ensures logging is in place
to catch and display such errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 222dabd..21a6c81 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -297,8 +297,6 @@ def main():
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
         server.saveConnectionDetails(configParams.remote_server)
 
-    logger.removeHandler(handler)
-
     if not configParams.server_only:
         # Collect the feature set for the UI
         featureset = getattr(ui_module, "featureSet", [])
@@ -310,6 +308,8 @@ def main():
         for k in cleanedvars:
             os.environ[k] = cleanedvars[k]
 
+        logger.removeHandler(handler)
+
         try:
             return ui_module.main(server_connection.connection, server_connection.events, configParams)
         finally:



