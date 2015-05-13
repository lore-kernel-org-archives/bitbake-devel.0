Return-Path: <jatedev@gmail.com>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id D77607405D;
	Wed, 13 May 2015 22:47:07 +0000 (UTC)
Received: by pdbnk13 with SMTP id nk13so65056046pdb.0;
	Wed, 13 May 2015 15:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=+KR1QIB2s9IzxUdQvo3Jqt6e6/d6hl5o8jn0HvNg2+0=;
	b=TL3o55bJe4lFmuwWzgZ0T/Kndvq+B9v6XbADFxUNXJwTSPwxBL+8wZNlv3kXQmO8Gw
	PbxLAMXM6U/Ru91ZS049H3Jsf60HhiXnEX9Sj/MufnnjTfkzwOq9y7Q+TD9j3yHOGDvk
	kL/gYoDNaD6yqxaF/fDr8A8voXZEyai6DOrQoY81kyU7mX0xFTkiMoVBdV+tk0+9ONmK
	y2cQZvRG2IBOlRfHYWCWw5C/qnIErOTY1ZQsIx2XffXteiLuRVeepaVcDUe2Ki3W/65L
	hjQ0q06FpA27rt6rSUFDFudjWaDdKxvuieq0g/zaJBv+4BGN2xyrbJ2BWuRuMlP2rv6R
	v3Pg==
MIME-Version: 1.0
X-Received: by 10.70.138.38 with SMTP id qn6mr2014246pdb.119.1431557228924;
	Wed, 13 May 2015 15:47:08 -0700 (PDT)
Received: by 10.66.142.201 with HTTP; Wed, 13 May 2015 15:47:08 -0700 (PDT)
Date: Wed, 13 May 2015 18:47:08 -0400
Message-ID: <CAPphmgazTBK9mTYd2wF6wEu8jQ9-H2WH9uC9=F7--RU8v6i-qw@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH v2][1/2] providers.py: Add PREFERRED_RPROVIDER
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
X-List-Received-Date: Wed, 13 May 2015 22:47:10 -0000
Content-Type: multipart/alternative; boundary=001a113640281b142d0515fe64ca

--001a113640281b142d0515fe64ca
Content-Type: text/plain; charset=UTF-8

The following changes since commit 7a8f37daa7b42905233c31366915b897886a957a:

  dev-manual: Updates to add Luna support for Eclipse (2015-05-03 11:49:35
+0100)

are available in the git repository at:

  git://github.com/jatedev/poky.git oe-core-image-rdepend-alt-2

for you to fetch changes up to 55bd8d189f647443b28f988ccfc9eebffaec84d1:

  providers.py: Add PREFERRED_RPROVIDER (2015-05-13 11:29:52 -0400)

----------------------------------------------------------------
Jate Sujjavanich (1):
      providers.py: Add PREFERRED_RPROVIDER

 bitbake/lib/bb/providers.py |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 637e1fa..910a23e 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -323,11 +323,12 @@ def filterProvidersRunTime(providers, item, cfgData,
dataCache):
     for p in eligible:
         pn = dataCache.pkg_fn[p]
         provides = dataCache.pn_provides[pn]
+        provides.append(item)
         for provide in provides:
-            prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide,
True)
-            #logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s)
against %s", provide, prefervar, pns.keys())
+            prefervar = cfgData.getVar('PREFERRED_RPROVIDER_%s' % provide,
True)
+            #logger.debug(1, "checking PREFERRED_RPROVIDER_%s (value %s)
against %s", provide, prefervar, pns.keys())
             if prefervar in pns and pns[prefervar] not in preferred:
-                var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
+                var = "PREFERRED_RPROVIDER_%s = %s" % (provide, prefervar)
                 logger.verbose("selecting %s to satisfy runtime %s due to
%s", prefervar, item, var)
                 preferred_vars.append(var)
                 pref = pns[prefervar]

--001a113640281b142d0515fe64ca
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The following changes since commit 7a8f37daa7b42905233c313=
66915b897886a957a:<br><br>=C2=A0 dev-manual: Updates to add Luna support fo=
r Eclipse (2015-05-03 11:49:35 +0100)<br><br>are available in the git repos=
itory at:<br><br>=C2=A0 git://<a href=3D"http://github.com/jatedev/poky.git=
">github.com/jatedev/poky.git</a> oe-core-image-rdepend-alt-2<br><br>for yo=
u to fetch changes up to 55bd8d189f647443b28f988ccfc9eebffaec84d1:<br><br>=
=C2=A0 providers.py: Add PREFERRED_RPROVIDER (2015-05-13 11:29:52 -0400)<br=
><br>----------------------------------------------------------------<br>Ja=
te Sujjavanich (1):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 providers.py: Add PRE=
FERRED_RPROVIDER<br><br>=C2=A0bitbake/lib/bb/providers.py |=C2=A0=C2=A0=C2=
=A0 7 ++++---<br>=C2=A01 file changed, 4 insertions(+), 3 deletions(-)<br><=
br>diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py<b=
r>index 637e1fa..910a23e 100644<br>--- a/bitbake/lib/bb/providers.py<br>+++=
 b/bitbake/lib/bb/providers.py<br>@@ -323,11 +323,12 @@ def filterProviders=
RunTime(providers, item, cfgData, dataCache):<br>=C2=A0=C2=A0=C2=A0=C2=A0 f=
or p in eligible:<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pn =
=3D dataCache.pkg_fn[p]<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 provides =3D dataCache.pn_provides[pn]<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 provides.append(item)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 for provide in provides:<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefervar =3D cfgData.getVar(&#39;PREFERR=
ED_PROVIDER_%s&#39; % provide, True)<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #logger.debug(1, &quot;checking PREFERRED=
_PROVIDER_%s (value %s) against %s&quot;, provide, prefervar, pns.keys())<b=
r>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefe=
rvar =3D cfgData.getVar(&#39;PREFERRED_RPROVIDER_%s&#39; % provide, True)<b=
r>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #logg=
er.debug(1, &quot;checking PREFERRED_RPROVIDER_%s (value %s) against %s&quo=
t;, provide, prefervar, pns.keys())<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if prefervar in pns and pns[prefervar]=
 not in preferred:<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var =3D &quot;PREFERRED_PROVIDER_%s=
 =3D %s&quot; % (provide, prefervar)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var =3D &quot;PRE=
FERRED_RPROVIDER_%s =3D %s&quot; % (provide, prefervar)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 logger.verbose(&quot;selecting %s to satisfy runtime %s due to %s&qu=
ot;, prefervar, item, var)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 preferred_vars.append(v=
ar)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pref =3D pns[prefervar]<br><br></div>

--001a113640281b142d0515fe64ca--
