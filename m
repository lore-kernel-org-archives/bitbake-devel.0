Received: from exchsrvr.syntech-fuelmaster.com ([199.44.250.2]
	helo=courier.syntech-fuelmaster.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Jate.Sujjavanich@myfuelmaster.com>)
	id 1TEL5u-0001fR-7M
	for bitbake-devel@lists.linuxtogo.org; Wed, 19 Sep 2012 16:17:38 +0200
Received: from Courier.syntech.org ([fe80::f1e9:ec58:2caf:f234]) by
	Courier.syntech.org ([fe80::f1e9:ec58:2caf:f234%14]) with mapi;
	Wed, 19 Sep 2012 10:04:56 -0400
From: Jate Sujjavanich <Jate.Sujjavanich@myfuelmaster.com>
To: "'bitbake-devel@lists.linuxtogo.org'" <bitbake-devel@lists.linuxtogo.org>
Date: Wed, 19 Sep 2012 10:04:55 -0400
Thread-Topic: [PATCH] cvs fetcher
Thread-Index: Ac2VuoJpiYkDyd1uTm+1Ij0UNYcZeQ==
Message-ID: <6C2434209962DC46B88345CA85C334A20183E5A9859A@Courier.syntech.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-vipre-scanned: 790BA34400333E790BA491
acceptlanguage: en-US
MIME-Version: 1.0
Subject: [PATCH] cvs fetcher
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
X-List-Received-Date: Wed, 19 Sep 2012 14:17:38 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

While using a newer bitbake, I ran into some issues with a recipe that has =
a cvs SRC_URI. This patch fixes it, and I wanted to submit it for further r=
eview.


The localdata variable was removed but is required later in the download
function.
Add an extra space so that cvscmd's parameter is separated from the
command.
Signed-off-by: Jate Sujjavanich <jate.sujjavanich@myfuelmaster.com>
----------------------------- lib/bb/fetch2/cvs.py ------------------------=
----
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 6a948c4..5249d85 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -111,8 +111,10 @@
         if ud.tag:
             options.append("-r %s" % ud.tag)
=20
+        localdata =3D data.createCopy(d)
+       =20
         cvsbasecmd =3D d.getVar("FETCHCMD_cvs", True)
-        cvscmd =3D cvsbasecmd + "'-d" + cvsroot + "' co " + " ".join(optio=
ns) + " " + ud.module
+        cvscmd =3D cvsbasecmd + " " + "'-d" + cvsroot + "' co " + " ".join=
(options) + " " + ud.module
         cvsupdatecmd =3D cvsbasecmd + "'-d" + cvsroot + "' update -d -P " =
+ " ".join(options)
=20
         if cvs_rsh:


