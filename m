Return-Path: <jatedev@gmail.com>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
	[209.85.192.42])
	by mail.openembedded.org (Postfix) with ESMTP id EBF4D73F49;
	Thu,  7 May 2015 23:50:44 +0000 (UTC)
Received: by qgfi89 with SMTP id i89so29250708qgf.1;
	Thu, 07 May 2015 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:cc:content-type;
	bh=SFEyRBOBRCp9z2La6qEPNFLcbEi0OV2qKdJuWRZKHVY=;
	b=kkiA8PyxRMGx4AYqAaviYzeptOIVu9uWLTxE2VyHElooIZACzWMGanzfhydCA2oNtX
	NJYQp+XHY3jAxeW4Js+ty7v7FdFZVxEKRgUL+gpoA6IU/RPISdNXgdMw3H6+npcLGcg3
	rdNZj+58TqtQa+td7JuudaCVUELl3xHKp/an7g1U4Gdp9V5+Hs7s3xPKQFt4Vpr3V4/e
	Vwfp2jJA1qBzB+oeNnjDCf8rac5WvqE7z2jy5FDQMCbg1YjRbSdbiepenJZCa4oJKP8+
	nx0x8XGzzco0Ke+MSeEHUTurULRsQOOpiHkoQT4u/gpRSPq9uVvosnaxHpE2DXq2qGmn
	qQMg==
MIME-Version: 1.0
X-Received: by 10.140.29.133 with SMTP id b5mr1515162qgb.3.1431042645643; Thu,
	07 May 2015 16:50:45 -0700 (PDT)
Received: by 10.140.102.74 with HTTP; Thu, 7 May 2015 16:50:45 -0700 (PDT)
Date: Thu, 7 May 2015 19:50:45 -0400
Message-ID: <CAPphmgbAjPc1U4+bUtpyTe+LMJmxSJ_1P5Go6_W_K6X3nPnfMA@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: openembedded-core@lists.openembedded.org
Subject: [1/2] providers.py: Add package name to PREFERRED_PROVIDER search
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
X-List-Received-Date: Thu, 07 May 2015 23:50:46 -0000
Content-Type: multipart/alternative; boundary=001a113aa40c8d56880515869481

--001a113aa40c8d56880515869481
Content-Type: text/plain; charset=UTF-8

Add rootfs_process_preferred_providers to image.bbclass. In PACKAGE_INSTALL,
this substitutes the requested package with the provider. Change regex in
RpmRootfs._log_check_error to allow log message about PREFERRED_PROVIDER.

Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
----
The following changes since commit 7a8f37daa7b42905233c31366915b897886a957a:

  dev-manual: Updates to add Luna support for Eclipse (2015-05-03 11:49:35
+0100)

are available in the git repository at:

  git://github.com/jatedev/poky.git preferred-provider-runtime

for you to fetch changes up to efe5b0940a6abc7348d8c60c456d93f5de8dda89:

  providers.py: Add package name to PREFERRED_PROVIDER search (2015-05-07
19:07:18 -0400)

----------------------------------------------------------------
Jate Sujjavanich (1):
      providers.py: Add package name to PREFERRED_PROVIDER search

 bitbake/lib/bb/providers.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 637e1fa..b6c294e 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -323,6 +323,7 @@ def filterProvidersRunTime(providers, item, cfgData,
dataCache):
     for p in eligible:
         pn = dataCache.pkg_fn[p]
         provides = dataCache.pn_provides[pn]
+        provides.append(item)
         for provide in provides:
             prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide,
True)
             #logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s)
against %s", provide, prefervar, pns.keys())

--001a113aa40c8d56880515869481
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Add rootfs_process_preferred_providers to image.bbclass. I=
n PACKAGE_INSTALL,<br>this substitutes the requested package with the provi=
der. Change regex in<br>RpmRootfs._log_check_error to allow log message abo=
ut PREFERRED_PROVIDER.<br><br>Signed-off-by: Jate Sujjavanich &lt;<a href=
=3D"mailto:jatedev@gmail.com">jatedev@gmail.com</a>&gt;<br>----<br>The foll=
owing changes since commit 7a8f37daa7b42905233c31366915b897886a957a:<br><br=
>=C2=A0 dev-manual: Updates to add Luna support for Eclipse (2015-05-03 11:=
49:35 +0100)<br><br>are available in the git repository at:<br><br>=C2=A0 g=
it://<a href=3D"http://github.com/jatedev/poky.git">github.com/jatedev/poky=
.git</a> preferred-provider-runtime<br><br>for you to fetch changes up to e=
fe5b0940a6abc7348d8c60c456d93f5de8dda89:<br><br>=C2=A0 providers.py: Add pa=
ckage name to PREFERRED_PROVIDER search (2015-05-07 19:07:18 -0400)<br><br>=
----------------------------------------------------------------<br>Jate Su=
jjavanich (1):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 providers.py: Add package =
name to PREFERRED_PROVIDER search<br><br>=C2=A0bitbake/lib/bb/providers.py =
|=C2=A0=C2=A0=C2=A0 1 +<br>=C2=A01 file changed, 1 insertion(+)<br><br>diff=
 --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py<br>index=
 637e1fa..b6c294e 100644<br>--- a/bitbake/lib/bb/providers.py<br>+++ b/bitb=
ake/lib/bb/providers.py<br>@@ -323,6 +323,7 @@ def filterProvidersRunTime(p=
roviders, item, cfgData, dataCache):<br>=C2=A0=C2=A0=C2=A0=C2=A0 for p in e=
ligible:<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pn =3D dataCac=
he.pkg_fn[p]<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 provides =
=3D dataCache.pn_provides[pn]<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 provides.append(item)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 for provide in provides:<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefervar =3D cfgData.getVar(&#39;PREFERRED_=
PROVIDER_%s&#39; % provide, True)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #logger.debug(1, &quot;checking PREFER=
RED_PROVIDER_%s (value %s) against %s&quot;, provide, prefervar, pns.keys()=
)<br><br></div>

--001a113aa40c8d56880515869481--
