Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXXkm-0004LS-Az for bitbake-devel@lists.openembedded.org;
	Thu, 24 May 2012 15:06:56 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4OCukH1023771
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 13:56:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22920-05 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 13:56:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4OCua1O023764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 13:56:38 +0100
Message-ID: <1337864194.8248.110.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 May 2012 13:56:34 +0100
In-Reply-To: <1337853722.8248.105.camel@ted>
References: <1337853722.8248.105.camel@ted>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH v2] bitbake/cooker: Ensure matchFile returns full pathnames
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
X-List-Received-Date: Thu, 24 May 2012 13:06:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We should always be passing full pathnames around within bitbake. If
a file was referenced as a relative path to the current working
directory, it might not get passed through the abspath call and
hence the cwd would not get added as a prefix.

This change adds a second pass at ensuring we only return absolute paths.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 8ad4922..bafd832 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -985,12 +985,12 @@ class BBCooker:
         """
         Find the .bb files which match the expression in 'buildfile'.
         """
-
         if bf.startswith("/") or bf.startswith("../"):
             bf = os.path.abspath(bf)
         filelist, masked = self.collect_bbfiles()
         try:
             os.stat(bf)
+            bf = os.path.abspath(bf)
             return [bf]
         except OSError:
             regexp = re.compile(bf)




