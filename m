Return-Path: <alexandru.damian@intel.com>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
	[209.85.218.54])
	by mail.openembedded.org (Postfix) with ESMTP id B12F56017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2015 15:56:35 +0000 (UTC)
Received: by oifu20 with SMTP id u20so18283195oif.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Mar 2015 07:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-type;
	bh=d7UhumPJn6sqbdau6ketoPTgTvFy1iIlnCDpc2ZfyPs=;
	b=HTl2MWrEFRu3EGRZsaaeeOriagO/1EradRgd3XQD+Lhois/XMqTY7mseWKfDMzpbPF
	7KnxiBsj6trsd1v9A1RiUbIVTAKMmP1IVL0YO+/7FwC7f9DJEAY8cRfuRJi8Lei3HxFw
	C5XY84bRaCXRrbqX9OrfXlW9Vwok1bafs234VRE4yqDaa9ZV/zGyB8eclepj0lbqwWI8
	FUt+Hjp1sH13GJ1tYty86B0zq64I2YnQRHhcqSKOGY0GU48xIzU0UaRs0OjBXLhIXbAs
	Rpe9mNro/mxnC+zMOw/p3NezIU/IMQTdcmSYSRDxUcaFWVDmnwIBGEA51SalPdzySyes
	D92A==
X-Gm-Message-State: ALoCoQlk0y8VM9mV/FBOWsl/kjtUMLmtCcKh6A+AnlrklPFkuBPvTWBAI+f4uTl7oLoFemOenrPN
X-Received: by 10.202.58.8 with SMTP id h8mr10868779oia.93.1425657397061; Fri,
	06 Mar 2015 07:56:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.131.135 with HTTP; Fri, 6 Mar 2015 07:56:16 -0800 (PST)
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Fri, 6 Mar 2015 15:56:16 +0000
Message-ID: <CAJ2CSBuBpV9ZAei94pT2=oqxnA2J4tfAkvatwDRpzjxaxTOZgQ@mail.gmail.com>
To: "toaster@yoctoproject.org" <toaster@yoctoproject.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [review-request] bitbake patches for improving handling with toaster
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
X-List-Received-Date: Fri, 06 Mar 2015 15:56:37 -0000
Content-Type: multipart/alternative; boundary=001a113cd866b93b130510a0ba50

--001a113cd866b93b130510a0ba50
Content-Type: text/plain; charset=UTF-8

Hello,

I've pushed a set of bitbake patches that improve toaster operations.

The changes are:

* fix for https://bugzilla.yoctoproject.org/show_bug.cgi?id=7316  - log all
file change notifications that happen during a build in an idle function,
and update the cache during initial build setup for all changed files; this
allows bitbake to process a large number of notifications

* fix for https://bugzilla.yoctoproject.org/show_bug.cgi?id=7398 - the
"xmlrpc" server should delete offending idle functions that raise errors
instead of ignoring errors; the "process" server already does this

* deleted old GUI test data and render tests in-operable due to changes in
the database structure that were not followed by updating tests/database
fixtures; it's better to have no data than to have bad data

* improved handling of client connection processing, reducing the number of
situation where a server is rendered in-accessible by a client



The patch set is here:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=adamian/20150305_review

Can you please review, and pull if ok ?



-- 
Alex Damian
Yocto Project
SSG / OTC

--001a113cd866b93b130510a0ba50
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,<br><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:tahoma,sans-serif">I&#39;ve pushed a set of bitbake patches that impr=
ove toaster operations.<br><br></div><div class=3D"gmail_default" style=3D"=
font-family:tahoma,sans-serif">The changes are:<br><br></div><div class=3D"=
gmail_default" style=3D"font-family:tahoma,sans-serif">* fix for <a href=3D=
"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D7316">https://bugzilla=
.yoctoproject.org/show_bug.cgi?id=3D7316</a>=C2=A0 - log all file change no=
tifications that happen during a build in an idle function, and update the =
cache during initial build setup for all changed files; this allows bitbake=
 to process a large number of notifications<br><br></div><div class=3D"gmai=
l_default" style=3D"font-family:tahoma,sans-serif">* fix for <a href=3D"htt=
ps://bugzilla.yoctoproject.org/show_bug.cgi?id=3D7398">https://bugzilla.yoc=
toproject.org/show_bug.cgi?id=3D7398</a> - the &quot;xmlrpc&quot; server sh=
ould delete offending idle functions that raise errors instead of ignoring =
errors; the &quot;process&quot; server already does this<br><br></div><div =
class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">* deleted o=
ld GUI test data and render tests in-operable due to changes in the databas=
e structure that were not followed by updating tests/database fixtures; it&=
#39;s better to have no data than to have bad data<br><br></div><div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">* improved handl=
ing of client connection processing, reducing the number of situation where=
 a server is rendered in-accessible by a client<br><br><br></div><div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">The patch se=
t is here:<br><br><a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky=
-contrib/log/?h=3Dadamian/20150305_review">http://git.yoctoproject.org/cgit=
/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150305_review</a><br><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Can you =
please review, and pull if ok ?<br><br><br clear=3D"all"></div><br>-- <br><=
div class=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Projec=
t<br></div><div>SSG / OTC=C2=A0</div></div></div>
</div>

--001a113cd866b93b130510a0ba50--
