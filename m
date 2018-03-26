Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 4592F7855C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Mar 2018 06:46:04 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w2Q6k5jg023687
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Mar 2018 23:46:05 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.201]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0361.001;
	Sun, 25 Mar 2018 23:46:05 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/2] toaster: do not fail on optional
	'custom.xml' file
Thread-Index: AQHTpuK+VzEin17ZPkuyipjoVchevqPiTm9Q
Date: Mon, 26 Mar 2018 06:46:05 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F37F5CAC@ALA-MBD.corp.ad.wrs.com>
References: <cover.1518754951.git.David.Reyna@windriver.com>
	<8b13dce6692fcf4469a117276e5dd6374cc59860.1518754951.git.David.Reyna@windriver.com>
In-Reply-To: <8b13dce6692fcf4469a117276e5dd6374cc59860.1518754951.git.David.Reyna@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.93]
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] toaster: do not fail on optional	'custom.xml' file
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
X-List-Received-Date: Mon, 26 Mar 2018 06:46:05 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of David Reyna
Sent: Thursday, February 15, 2018 8:26 PM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH 1/2] toaster: do not fail on optional 'cust=
om.xml' file

From: David Reyna <David.Reyna@windriver.com>

Explicitly capture and ignore errors when trying to load the optional
'custom.xml' fixture file.

[YOCTO #12554]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/=
lib/toaster/bldcontrol/management/commands/checksettings.py
index 582114a..823c6f1 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -107,7 +107,10 @@ class Command(BaseCommand):
                                 action=3D"ignore",
                                 message=3D"^.*No fixture named.*$")
                             print("Importing custom settings if present")
-                            call_command("loaddata", "custom")
+                            try:
+                                call_command("loaddata", "custom")
+                            except:
+                                print("NOTE: optional fixture 'custom' not=
 found")
=20
                         # we run lsupdates after config update
                         print("\nFetching information from the layer index=
, "
--=20
2.7.4

--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

