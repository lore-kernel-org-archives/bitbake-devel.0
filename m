Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 36D956FFA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Dec 2015 10:56:58 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-FEM-02.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp 
	id 1a7LNi-00057w-UX from Awais_Belal@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Fri, 11 Dec 2015 02:56:59 -0800
Received: from EU-MBX-02.mgc.mentorg.com ([169.254.3.69]) by
	SVR-IES-FEM-02.mgc.mentorg.com ([137.202.0.106]) with mapi id
	14.03.0224.002; Fri, 11 Dec 2015 10:56:58 +0000
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath
	when	calling orig method
Thread-Index: AQHRM3y08+4MlEYbfkOT+uu7MQrMUp7FnhLh
Date: Fri, 11 Dec 2015 10:56:57 +0000
Message-ID: <2021B186DC632746BD5A3CE32F12BD280119AA60C3@EU-MBX-02.mgc.mentorg.com>
References: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
In-Reply-To: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.202.0.68]
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: fetch: use orig localpath when	calling orig method
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
X-List-Received-Date: Fri, 11 Dec 2015 10:56:59 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This applies to 1.28 as well and otherwise broken builds are seen where the=
 git tarball from source mirror is outdated.=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: bitbake-devel-bounces@lists.openembedded.org [bitbake-devel-bounces@l=
ists.openembedded.org] on behalf of Belal, Awais=0A=
Sent: Thursday, December 10, 2015 11:57 PM=0A=
To: bitbake-devel@lists.openembedded.org=0A=
Subject: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath when   =
     calling orig method=0A=
=0A=
From: Christopher Larson <chris_larson@mentor.com>=0A=
=0A=
When a mirror tarball is fetched, the original fetch method is called, whic=
h=0A=
unpacks the mirror tarball. After the original method is called, it checks =
the=0A=
localpath of the mirror tarball rather than the clone path, which isn't ide=
al,=0A=
particularly if the mirror tarball was removed due to being out of date. We=
=0A=
know the original fetch method will do what it needs to do to get its conte=
nt=0A=
in the form it needs from the mirror tarball, so we can use its localpath=
=0A=
instead.=0A=
=0A=
Signed-off-by: Christopher Larson <chris_larson@mentor.com>=0A=
Signed-off-by: Awais Belal <awais_belal@mentor.com>=0A=
---=0A=
 lib/bb/fetch2/__init__.py | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py=0A=
index d66a212..68ebf8b 100644=0A=
--- a/lib/bb/fetch2/__init__.py=0A=
+++ b/lib/bb/fetch2/__init__.py=0A=
@@ -955,7 +955,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D Fal=
se):=0A=
                 origud.method.download(origud, ld)=0A=
                 if hasattr(origud.method,"build_mirror_data"):=0A=
                     origud.method.build_mirror_data(origud, ld)=0A=
-            return ud.localpath=0A=
+            return origud.localpath=0A=
         # Otherwise the result is a local file:// and we symlink to it=0A=
         if not os.path.exists(origud.localpath):=0A=
             if os.path.islink(origud.localpath):=0A=
--=0A=
1.9.1=0A=
=0A=
--=0A=
_______________________________________________=0A=
bitbake-devel mailing list=0A=
bitbake-devel@lists.openembedded.org=0A=
http://lists.openembedded.org/mailman/listinfo/bitbake-devel=0A=

