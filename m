Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R1MLB-00021E-O9 for bitbake-devel@lists.openembedded.org;
	Wed, 07 Sep 2011 19:55:13 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p87HnRhU018593 for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Sep 2011 18:49:28 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vuHT39Hwm7Ih for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Sep 2011 18:49:27 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p87HnNVg018584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Sep 2011 18:49:24 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 07 Sep 2011 18:43:20 +0100
Message-ID: <1315417400.13021.20.camel@ted>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Subject: runqueue: Ensure task environment is correct
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
X-List-Received-Date: Wed, 07 Sep 2011 17:55:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This fixes two problems:

a) Variables which were in the parent environment but not set as "export"
   variables in the datastore could end up in the task environment

b) oe.environ.update() can't cope with the generator returned by 
   bb.data.exported_vars()

Whilst the updated code isn't as neat, it does do the expected thing,
sets the environment correctly and stops unwanted values leaking into
the task environment.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 5a4321f..72e6845 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1136,7 +1136,12 @@ class RunQueueExecute:
                 for h in self.rqdata.hash_deps:
                     the_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_deps[h])
 
-                os.environ.update(bb.data.exported_vars(the_data))
+                # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
+                # successfully. We also need to unset anything from the environment which shouldn't be there 
+                exports = bb.data.exported_vars(the_data)
+                bb.utils.empty_environment()
+                for e, v in exports:
+                    os.environ[e] = v
 
                 if quieterrors:
                     the_data.setVarFlag(taskname, "quieterrors", "1")



