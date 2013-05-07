Received: from mail-qc0-f182.google.com ([209.85.216.182])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <zaifupb@gmail.com>) id 1UZq73-0007IR-PL
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 May 2013 00:11:58 +0200
Received: by mail-qc0-f182.google.com with SMTP id c10so607537qcz.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 May 2013 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to
	:content-type; bh=KHrNooCxToxpYpgze4DvQluQLvKySlodX+gfDHbmPzw=;
	b=T/JWhP+WuijFPhJNCxGDl4PLaEhUVen+NWByFDBDqwDLGvortGpIQOpwMDRvueIbO4
	zB9ZXoRgzhdd4BSm+FJ9/ZlqZ3Pv74VYB8gr4BNSSlMD75k0B1guyqWIjXrbga1ZzwTb
	+u2rrD2WB5H6seWD6WyjjV7G4d8etcMWIjQByQps49C+/k7vBdQqba2jCsTszwzF7CWb
	FkjVXmHdBqYe29UIedELDIMkaMn6eCCuvT6Pn7cDLfnW5nL0ItA3Xn6pW6xLdhCFidli
	ho/LQ9Nz+xnm4QfdeMI0IuogQ+biXURrk5itCKyD8nF6rNA9T3uq49LuDhjBvw1d5Hfp
	/2Aw==
MIME-Version: 1.0
X-Received: by 10.224.51.7 with SMTP id b7mr3041582qag.8.1367963635765; Tue,
	07 May 2013 14:53:55 -0700 (PDT)
Received: by 10.229.164.76 with HTTP; Tue, 7 May 2013 14:53:55 -0700 (PDT)
Date: Tue, 7 May 2013 23:53:55 +0200
Message-ID: <CABx0rKGE9gyT_wUVEZ3gHJVpD+VB8oWEg2WkpJmJ74GM5qjt4g@mail.gmail.com>
From: Zaif upb <zaifupb@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Building Custom Images- Need help
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
X-List-Received-Date: Tue, 07 May 2013 22:11:58 -0000
Content-Type: multipart/alternative; boundary=047d7beb9dce939f3a04dc27da38

--047d7beb9dce939f3a04dc27da38
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I am newbie for Yocto project, please help me.

 I would like to know the process of making custom image for gumstix. I
have been through this
http://www.yoctoproject.org/docs/1.4/dev-manual/dev-manual.html#usingpoky-extend-addpkg
manual but things are not clear yet.

I can successfully build *gumstix-console-image. *I need to integrate
Gstreamer and OpenCV libraries into that image. I do not know how to
proceed.

I edited *gumstix-console-image*.bb file according to  Streaming video with
Gumstix<http://www.jumpnowtek.com/?option=com_content&view=article&id=81:gumstix-dsp-gstreamer&catid=35:gumstix&Itemid=67>as
mentioned here for Gstreamer. It breaks badly.

Any Idea how can I integrate them in my Image?

Thank You for your Help.

Regards,
Zaifupb

--047d7beb9dce939f3a04dc27da38
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hi all,<br><br></div>I =
am newbie for Yocto project, please help me.<br><br>=A0I would like to know=
 the process of making custom image for gumstix. I have been through this=
=A0 <a href=3D"http://www.yoctoproject.org/docs/1.4/dev-manual/dev-manual.h=
tml#usingpoky-extend-addpkg" target=3D"_blank">http://www.yoctoproject.org/=
docs/1.4/dev-manual/dev-manual.html#usingpoky-extend-addpkg</a>=A0 manual b=
ut things are not clear yet.<br>


<br></div>I can successfully build <i>gumstix-console-image. </i>I need to =
integrate Gstreamer and OpenCV libraries into that image. I do not know how=
 to proceed. <br><br></div>I edited <i>gumstix-console-image</i>.bb file ac=
cording to=A0=A0<a href=3D"http://www.jumpnowtek.com/?option=3Dcom_content&=
amp;view=3Darticle&amp;id=3D81:gumstix-dsp-gstreamer&amp;catid=3D35:gumstix=
&amp;Itemid=3D67" target=3D"_blank">Streaming video with Gumstix</a> as men=
tioned here for Gstreamer. It breaks badly.<br>


<br></div>Any Idea how can I integrate them in my Image?<br><br></div>Thank=
 You for your Help.<br><br></div>Regards,<br></div>Zaifupb</div>

--047d7beb9dce939f3a04dc27da38--
