Return-Path: <jatedev@gmail.com>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48])
	by mail.openembedded.org (Postfix) with ESMTP id 7C39E761D6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jul 2015 21:32:27 +0000 (UTC)
Received: by oige126 with SMTP id e126so5755291oig.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jul 2015 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=2ufXyKCXKGQk295Lq7dsxDXuH+lGNHd37hFOS2Sx4ws=;
	b=FwjpWfEocTFPEiJZs/U0xOhKI/fv7u+O2kC9y23x2nrHk4KYqYawT4NSdWF5DK2kWo
	mlwoXZ+R+vb1ucj4TbqltUN7pY9rUEbk7Elw2n8Ol2wWYV+ckg7/qSzg2JFks50ECOU9
	LPppNdUWBsCyXcdqYVaPx3PhRogmBOouUc0MuvhL6cQEib0qSLDruwP7O5RxF+QHRsLx
	CrDzFI+MJx3+I9k1ecOLQzaT7VKLcjEbxFAKrOBkIKHyN2DFLjRMSkLl3lEGJlwIjMho
	h2jopYj7DyhVp3gRJ2mlEuSFqjdPYTOJUPqImjXkVdJEl4ebJ70x5l/xks6PIot7m8at
	9fBQ==
MIME-Version: 1.0
X-Received: by 10.182.252.97 with SMTP id zr1mr11593833obc.28.1437687147318;
	Thu, 23 Jul 2015 14:32:27 -0700 (PDT)
Received: by 10.76.156.130 with HTTP; Thu, 23 Jul 2015 14:32:27 -0700 (PDT)
Date: Thu, 23 Jul 2015 17:32:27 -0400
Message-ID: <CAPphmgYfc3xJV2YrbO5HHKvY4aR2sfN1pbC0WzO2bfaWQ-e88g@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v3][1/2] providers.py: Add support for preferred runtime item
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
X-List-Received-Date: Thu, 23 Jul 2015 21:32:27 -0000
Content-Type: multipart/alternative; boundary=001a1134b45ab6fc6a051b919fe1

--001a1134b45ab6fc6a051b919fe1
Content-Type: text/plain; charset=UTF-8

The following changes since commit 7a8f37daa7b42905233c31366915b897886a957a:

  dev-manual: Updates to add Luna support for Eclipse (2015-05-03 11:49:35
+0100)

are available in the git repository at:

  https://jatedev@github.com/jatedev/poky

for you to fetch changes up to 5f248526ae5f15a2e6f3a6da88a96aba976bb28e:

  providers.py: Add support for preferred runtime item (2015-07-23 17:28:31
-0400)

----------------------------------------------------------------
Jate Sujjavanich (1):
      providers.py: Add support for preferred runtime item

 bitbake/lib/bb/providers.py |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 637e1fa..8924df5 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -320,6 +320,16 @@ def filterProvidersRunTime(providers, item, cfgData,
dataCache):
     pns = {}
     for p in eligible:
         pns[dataCache.pkg_fn[p]] = p
+
+    prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % (item), True)
+    if prefervar is not None and prefervar in pns:
+        var = "PREFERRED_PROVIDER_%s = %s" % (item, prefervar)
+        logger.verbose("selecting %s to satisfy runtime %s due to %s",
prefervar, item, var)
+        preferred_vars.append(var)
+        pref = pns[prefervar]
+        eligible.remove(pref)
+        eligible = [pref] + eligible
+        preferred.append(pref)
     for p in eligible:
         pn = dataCache.pkg_fn[p]
         provides = dataCache.pn_provides[pn]

--001a1134b45ab6fc6a051b919fe1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The following changes since commit 7a8f37daa7b42905233c313=
66915b897886a957a:<br><br>=C2=A0 dev-manual: Updates to add Luna support fo=
r Eclipse (2015-05-03 11:49:35 +0100)<br><br>are available in the git repos=
itory at:<br><br>=C2=A0 <a href=3D"https://jatedev@github.com/jatedev/poky"=
>https://jatedev@github.com/jatedev/poky</a> <br><br>for you to fetch chang=
es up to 5f248526ae5f15a2e6f3a6da88a96aba976bb28e:<br><br>=C2=A0 providers.=
py: Add support for preferred runtime item (2015-07-23 17:28:31 -0400)<br><=
br>----------------------------------------------------------------<br>Jate=
 Sujjavanich (1):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 providers.py: Add suppo=
rt for preferred runtime item<br><br>=C2=A0bitbake/lib/bb/providers.py |=C2=
=A0=C2=A0 10 ++++++++++<br>=C2=A01 file changed, 10 insertions(+)<br><br>di=
ff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py<br>ind=
ex 637e1fa..8924df5 100644<br>--- a/bitbake/lib/bb/providers.py<br>+++ b/bi=
tbake/lib/bb/providers.py<br>@@ -320,6 +320,16 @@ def filterProvidersRunTim=
e(providers, item, cfgData, dataCache):<br>=C2=A0=C2=A0=C2=A0=C2=A0 pns =3D=
 {}<br>=C2=A0=C2=A0=C2=A0=C2=A0 for p in eligible:<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 pns[dataCache.pkg_fn[p]] =3D p<br>+<br>+=C2=A0=
=C2=A0=C2=A0 prefervar =3D cfgData.getVar(&#39;PREFERRED_PROVIDER_%s&#39; %=
 (item), True)<br>+=C2=A0=C2=A0=C2=A0 if prefervar is not None and preferva=
r in pns:<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var =3D &quot;PREF=
ERRED_PROVIDER_%s =3D %s&quot; % (item, prefervar)<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 logger.verbose(&quot;selecting %s to satisfy runti=
me %s due to %s&quot;, prefervar, item, var)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 preferred_vars.append(var)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pref =3D pns[prefervar]<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 eligible.remove(pref)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 eligible =3D [pref] + eligible<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 preferred.append(pref)<br>=C2=A0=C2=A0=C2=A0=C2=A0 for p in el=
igible:<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pn =3D dataCach=
e.pkg_fn[p]<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 provides =
=3D dataCache.pn_provides[pn]</div>

--001a1134b45ab6fc6a051b919fe1--
