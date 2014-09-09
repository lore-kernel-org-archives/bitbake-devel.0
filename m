Return-Path: <just4tech83@gmail.com>
Received: from mail-qa0-f53.google.com (mail-qa0-f53.google.com
	[209.85.216.53])
	by mail.openembedded.org (Postfix) with ESMTP id 8EC4D7130F;
	Tue,  9 Sep 2014 12:53:23 +0000 (UTC)
Received: by mail-qa0-f53.google.com with SMTP id w8so15702369qac.12
	for <multiple recipients>; Tue, 09 Sep 2014 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=ss1njvrB4ULb7QCD7xNzg/KAnkk/peFNtz5MyZIbEd4=;
	b=QYmen1aBKs/GB77qN7PeuiQSFrMMS3rR+TZUXzGEW+C4jH3+i2aZ+3/L3+zfKLVsdm
	1WdsTy3/JtsFTOAuh0pzQf4ztNhlr2VFx1u/eg1RVg1bB/hBNDsAKexVN85ELFSkhir1
	NMYM62SpWzF7aokZsRQvsm0L2+NhnRnT9P1HoVpBt/EJevRWI/6Jdyb1n5adVoL8hd2G
	vh6202IanKnRKsyBFiFLrzkCr/9AT940dhDZGio4ZlYH72I1h4dE+wKGoSjjtgM+BP1L
	ZyYtSwqEmTv8PZpevrwk4uQeTQplHH0PZbZA2Gy6N9v6pq82ubMnTn3URurac5WE5bwM
	FOtQ==
MIME-Version: 1.0
X-Received: by 10.224.47.67 with SMTP id m3mr4702356qaf.28.1410267204444; Tue,
	09 Sep 2014 05:53:24 -0700 (PDT)
Received: by 10.140.16.144 with HTTP; Tue, 9 Sep 2014 05:53:24 -0700 (PDT)
Received: by 10.140.16.144 with HTTP; Tue, 9 Sep 2014 05:53:24 -0700 (PDT)
Date: Tue, 9 Sep 2014 18:23:24 +0530
Message-ID: <CAD2C2VTOgCMRsq4em2Bd0hQ4Nz2Zq=B2vXezAw7QXQmhkQOsRQ@mail.gmail.com>
From: Bryan <just4tech83@gmail.com>
To: openembedded-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org
Subject: Backporting of latest recipes on oe-classic
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
X-List-Received-Date: Tue, 09 Sep 2014 12:53:25 -0000
Content-Type: multipart/alternative; boundary=001a1134ab00c26b650502a16b4c

--001a1134ab00c26b650502a16b4c
Content-Type: text/plain; charset=UTF-8

Hi,
   We have some queries regarding OE-Classic.
1. Where can we find latest recipes for oe-classic. Does oe-classic is
still get updation for latest package support?

2. How can we compile latest recipes of oe-core on oe-classic and ofcourse
there bitbake version would be different.Basically, we can say we need to
backport the recipe to classic.
e.g. gtk+2.20.1 & above, glibc-2.11.3 & above

3. Does anybody have latest bitbake recipe for ICAClient(Citrix Receiver)
13 version.
Though we have created one but not sure whether it is installing all
components properly.

4. How can we install package like libwebkit or libwebkitgtk 1.0 on
oe-classic.

Thanks in advance
Bryan

--001a1134ab00c26b650502a16b4c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi, <br>
=C2=A0=C2=A0 We have some queries regarding OE-Classic. <br>
1. Where can we find latest recipes for oe-classic. Does oe-classic is stil=
l get updation for latest package support?</p>
<p dir=3D"ltr">2. How can we compile latest recipes of oe-core on oe-classi=
c and ofcourse there bitbake version would be different.Basically, we can s=
ay we need to backport the recipe to classic.<br>
e.g. gtk+2.20.1 &amp; above, glibc-2.11.3 &amp; above</p>
<p dir=3D"ltr">3. Does anybody have latest bitbake recipe for ICAClient(Cit=
rix Receiver) 13 version.<br>
Though we have created one but not sure whether it is installing all compon=
ents properly.</p>
<p dir=3D"ltr">4. How can we install package like libwebkit or libwebkitgtk=
 1.0 on oe-classic. </p>
<p dir=3D"ltr">Thanks in advance <br>
Bryan</p>

--001a1134ab00c26b650502a16b4c--
