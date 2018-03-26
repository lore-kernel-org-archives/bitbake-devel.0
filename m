Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A18D1785B8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Mar 2018 06:46:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w2Q6kBoE023693
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Mar 2018 23:46:11 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.201]) by
	ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0361.001;
	Sun, 25 Mar 2018 23:46:11 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] Toaster: fix shutdown and extra
	threads
Thread-Index: AQHTpuK/XOKudaV2NE+M6/3BDq7sVqPiTnUA
Date: Mon, 26 Mar 2018 06:46:11 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F37F5CB7@ALA-MBD.corp.ad.wrs.com>
References: <cover.1518754951.git.David.Reyna@windriver.com>
	<1db9c3b241a7371239ecb7a3bbf5a84868cdd7ef.1518754951.git.David.Reyna@windriver.com>
In-Reply-To: <1db9c3b241a7371239ecb7a3bbf5a84868cdd7ef.1518754951.git.David.Reyna@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.93]
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] Toaster: fix shutdown and extra threads
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
X-List-Received-Date: Mon, 26 Mar 2018 06:46:10 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of David Reyna
Sent: Thursday, February 15, 2018 8:26 PM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH 2/2] Toaster: fix shutdown and extra thread=
s

From: David Reyna <David.Reyna@windriver.com>

Fix typo in shutdown code to kill threads when "kill -0" is not enough.
Use the '--noreload' flag for 'runserver' so that there are no extra and un=
accounted threads.

[YOCTO #12555]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 4036f0a..ed365ee 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -68,7 +68,7 @@ webserverKillAll()
         if [ -f ${pidfile} ]; then
             pid=3D`cat ${pidfile}`
             while kill -0 $pid 2>/dev/null; do
-                kill -SIGTERM -$pid 2>/dev/null
+                kill -SIGTERM $pid 2>/dev/null
                 sleep 1
             done
             rm  ${pidfile}
@@ -91,7 +91,7 @@ webserverStartAll()
=20
     echo "Starting webserver..."
=20
-    $MANAGE runserver "$ADDR_PORT" \
+    $MANAGE runserver --noreload "$ADDR_PORT" \
            </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
            & echo $! >${BUILDDIR}/.toastermain.pid
=20
--
2.7.4

--
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

