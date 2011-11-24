Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTZxH-0007WA-5Q for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 15:07:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOE0bkF025317
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:00:37 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24750-09 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:00:33 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOE0V2r025310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:00:32 GMT
Message-ID: <1322143237.24143.25.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Nov 2011 14:00:37 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2/local: Don't default to files in DL_DIR for file:// urls
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
X-List-Received-Date: Thu, 24 Nov 2011 14:07:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Defaulting to any file in DL_DIR as the first match for a file:// url
doesn't make much sense and can lead to unexpected results.
    
This patch changes the logic so this is the last fallback location
instead. Whether it should be using DL_DIR at all for this is a
good question but something for another patch.
    
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 2bf92c9..a0ed444 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -50,9 +50,6 @@ class Local(FetchMethod):
         path = url.split("://")[1]
         path = path.split(";")[0]
         newpath = path
-        dldirfile = os.path.join(data.getVar("DL_DIR", d, True), os.path.basename(path))
-        if os.path.exists(dldirfile):
-            return dldirfile
         if path[0] != "/":
             filespath = data.getVar('FILESPATH', d, True)
             if filespath:
@@ -62,6 +59,7 @@ class Local(FetchMethod):
                 if filesdir:
                     newpath = os.path.join(filesdir, path)
         if not os.path.exists(newpath) and path.find("*") == -1:
+            dldirfile = os.path.join(data.getVar("DL_DIR", d, True), os.path.basename(path))
             return dldirfile
         return newpath
 



