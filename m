Return-Path: <nick.lewis@usa.g4s.com>
X-Greylist: delayed 395 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 08 May 2014 07:45:59 UTC
Received: from mail1.bemta3.messagelabs.com (unknown [195.245.230.170])
	by mail.openembedded.org (Postfix) with ESMTP id 3435460167
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 May 2014 07:45:58 +0000 (UTC)
Received: from [85.158.137.19:45735] by server-10.bemta-3.messagelabs.com id
	CE/BF-16608-DA43B635; Thu, 08 May 2014 07:39:25 +0000
X-Env-Sender: nick.lewis@usa.g4s.com
X-Msg-Ref: server-11.tower-39.messagelabs.com!1399534747!12853673!1
X-Originating-IP: [89.206.228.155]
X-StarScan-Received: 
X-StarScan-Version: 6.11.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11524 invoked from network); 8 May 2014 07:39:07 -0000
Received: from unallocated.star.net.uk (HELO gbtwk10s037.Technology.local)
	(89.206.228.155)
	by server-11.tower-39.messagelabs.com with RC4-SHA encrypted SMTP;
	8 May 2014 07:39:07 -0000
Received: from GBTWK10E001.Technology.local ([10.234.1.29]) by
	gbtwk10s037.Technology.local ([10.234.1.39]) with mapi; Thu, 8 May 2014
	08:39:05 +0100
From: "Lewis, Nick" <nick.lewis@usa.g4s.com>
To: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 8 May 2014 08:39:04 +0100
Thread-Topic: [PATCH] bitbake/fetch2: Fix refetch of local files when they
	are read only
Thread-Index: Ac9qkKrLGXasVljSSveQfBzJNKfNdA==
Message-ID: <AAE0766F5AF36B46BAB7E0EFB92732063397EB4BCC@GBTWK10E001.Technology.local>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Subject: [PATCH] bitbake/fetch2: Fix refetch of local files when they are read only
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
X-List-Received-Date: Thu, 08 May 2014 07:45:59 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From 280ff24f597e5cf663c76fa90250cce229c6aac9 Mon Sep 17 00:00:00 2001
From: Nick Lewis <nick.lewis@usa.g4s.com>
Date: Wed, 7 May 2014 14:02:25 +0100
Subject: [PATCH] Fix refetch of local files when they are read only

Signed-off-by: Nick Lewis <nick.lewis@usa.g4s.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index 5a9c72f..f571fc4 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1251,7 +1251,7 @@ class FetchMethod(object):
                         destdir =3D destdir.strip('/')
                     if destdir !=3D "." and not os.access("%s/%s" % (rootd=
ir, destdir), os.F_OK):
                         os.makedirs("%s/%s" % (rootdir, destdir))
-                    cmd =3D 'cp -pPR %s %s/%s/' % (file, rootdir, destdir)
+                    cmd =3D 'cp -fpPR %s %s/%s/' % (file, rootdir, destdir=
)
                     #cmd =3D 'tar -cf - -C "%d" -ps . | tar -xf - -C "%s/%=
s/"' % (file, rootdir, destdir)
                 else:
                     # The "destdir" handling was specifically done for FIL=
ESPATH
@@ -1261,7 +1261,7 @@ class FetchMethod(object):
                     else:
                        destdir =3D "."
                     bb.utils.mkdirhier("%s/%s" % (rootdir, destdir))
-                    cmd =3D 'cp %s %s/%s/' % (file, rootdir, destdir)
+                    cmd =3D 'cp -f %s %s/%s/' % (file, rootdir, destdir)

         if not cmd:
             return
--
1.9.1


The details of this company are as follows:
G4S Technology Limited, Registered Office: Challenge House, International D=
rive, Tewkesbury, Gloucestershire GL20 8UQ, Registered in England No. 23823=
38.

This communication may contain information which is confidential, personal =
and/or privileged.

It is for the exclusive use of the intended recipient(s).
If you are not the intended recipient(s), please note that any distribution=
, forwarding, copying or use of this communication or the information in it=
 is strictly prohibited.

Any personal views expressed in this e-mail are those of the individual sen=
der and the company does not endorse or accept responsibility for them.

Prior to taking any action based upon this e-mail message, you should seek =
appropriate confirmation of its authenticity.

This e-mail has been scanned for all viruses by MessageLabs.

