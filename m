Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U66jY-0004ND-Cu for bitbake-devel@lists.openembedded.org;
	Thu, 14 Feb 2013 22:52:49 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1ELgorx013383 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:42:50 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7tPf6Fy9+W3m for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:42:50 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1ELggR1013376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:42:45 GMT
Message-ID: <1360877790.11225.125.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Feb 2013 21:36:30 +0000
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Ensure expansions happen in URL parameters in uri_replace
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
X-List-Received-Date: Thu, 14 Feb 2013 21:52:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

For example, this allows us to specify downloadfilename=PATH in sstate
mirror urls to improve directory structures in DL_DIR when using sstate.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 21f576e..3f5de99 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -214,6 +214,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d):
                         return None
             # Overwrite any specified replacement parameters
             for k in uri_replace_decoded[loc]:
+                for l in replacements:
+                    uri_replace_decoded[loc][k] = uri_replace_decoded[loc][k].replace(l, replacements[l])
                 result_decoded[loc][k] = uri_replace_decoded[loc][k]
         elif (re.match(regexp, uri_decoded[loc])):
             if not uri_replace_decoded[loc]:




