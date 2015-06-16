Return-Path: <openembedded-devel@urbanec.net>
X-Greylist: delayed 66145 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 16 Jun 2015 07:16:15 UTC
Received: from mail12.tpgi.com.au (mail12.tpgi.com.au [203.12.160.162])
	by mail.openembedded.org (Postfix) with ESMTP id BFEF97413A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jun 2015 07:16:15 +0000 (UTC)
X-TPG-Junk-Status: Message not scanned
X-TPG-Antivirus: Passed
X-TPG-Abuse: host=60-242-171-118.static.tpgi.com.au; ip=60.242.171.118;
	date=Tue, 16 Jun 2015 17:16:15 +1000
Received: from gw.urbanec.net (60-242-171-118.static.tpgi.com.au
	[60.242.171.118])
	by mail12.tpgi.com.au (envelope-from openembedded-devel@urbanec.net)
	(8.14.3/8.14.3) with ESMTP id t5G7GCMW021338
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jun 2015 17:16:15 +1000
Received: from beep.urbanec.net ([192.168.42.2]) by gw.urbanec.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.85)
	(envelope-from <openembedded-devel@urbanec.net>) id 1Z4l6S-00089X-9J
	for bitbake-devel@lists.openembedded.org;
	Tue, 16 Jun 2015 17:16:12 +1000
Message-ID: <557FCD3B.3010209@urbanec.net>
Date: Tue, 16 Jun 2015 17:16:11 +1000
From: Peter Urbanec <openembedded-devel@urbanec.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: prserv is leaving -wal and -shm files behind
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
X-List-Received-Date: Tue, 16 Jun 2015 07:16:17 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I noticed that prserv is now leaving behind -wal and -shm files. From my 
understanding, this is a symptom of not cleaning up connections to the 
database prior to shutdown.

I tried the following fix and it appears to help:

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 0507485..f50a3fd 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -144,6 +144,7 @@ class PRServer(SimpleXMLRPCServer):
          self.table.sync()
          logger.info("PRServer: stopping...")
          self.server_close()
+        del self.db
          return

      def start(self):


