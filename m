Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U7ZpH-0007Go-C6 for bitbake-devel@lists.openembedded.org;
	Tue, 19 Feb 2013 00:08:59 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1IMx5NF028031 for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Feb 2013 22:59:06 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id g50KoWMvVkZU for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Feb 2013 22:59:05 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1IMwvMc028023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Feb 2013 22:59:03 GMT
Message-ID: <1361193511.5927.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Feb 2013 13:18:31 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.6.3-1 
Subject: [PATCH] runqueue.py: Ensure export flag is set for fakeroot environment variables
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 18 Feb 2013 23:09:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This means the variables show up in the shell execution "run" files since
its useful to know what the fakeroot environment is and how to set it up
manually.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/runqueue.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1bbe791..58a3ce7 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1139,6 +1139,7 @@ class RunQueueExecute:
                 for e in fakeenv:
                     os.environ[e] = fakeenv[e]
                     the_data.setVar(e, fakeenv[e])
+                    the_data.setVarFlag(e, 'export', "1")
 
                 if quieterrors:
                     the_data.setVarFlag(taskname, "quieterrors", "1")




