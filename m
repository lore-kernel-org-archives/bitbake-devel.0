Return-Path: <prvs=1079a6f00b=Jeff.Hatch@multitech.com>
X-Greylist: delayed 595 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 05 Oct 2016 14:08:41 UTC
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
	by mail.openembedded.org (Postfix) with ESMTP id 316A771A57
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Oct 2016 14:08:41 +0000 (UTC)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id
	B7AD782387_7F50717B for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Oct 2016 13:58:47 +0000 (GMT)
Received: from SVMVVWPEXCH10.dc.multitech.prv (unknown [192.168.11.10])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "",
	Issuer "MultiTech Systems Intermediate CA 01" (not verified))
	by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id
	7C28182217_7F50717F for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Oct 2016 13:58:47 +0000 (GMT)
Received: from [192.168.52.75] (192.168.52.75) by
	SVMVVWPEXCH10.dc.multitech.prv (192.168.11.10) with Microsoft SMTP
	Server (TLS) id 14.2.347.0; Wed, 5 Oct 2016 08:58:47 -0500
Message-ID: <1475675870.8940.167.camel@hatchville>
From: Jeff Hatch <jhatch@multitech.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Oct 2016 08:57:50 -0500
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-Originating-IP: [192.168.52.75]
Subject: Not building python socketmodule.c with openssl 1.0.2h
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
X-List-Received-Date: Wed, 05 Oct 2016 14:08:41 -0000
X-Groupsio-MsgNum: 8106
Content-Type: multipart/related; type="multipart/alternative";
	boundary="=-B0TN+barEVEIGjbd91bl"

--=-B0TN+barEVEIGjbd91bl
Content-Type: multipart/alternative; boundary="=-4Eaw8TW5LPjSekQqmdCD"

--=-4Eaw8TW5LPjSekQqmdCD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I am seeing an issue where we upgraded the openssl bitbake recipes to
build and install openssl 1.0.2h in a higher layer than the base
openembedded layer which was building openssl 1.0.1m.  After this was
done, the build of python 2.7.3 stopped building the socketmodule.c and
ssl was not integrated into python.  For example, the httplib object no
longer has a reference for the HTTPSConnection object.  I have spent
some time digging around and cannot find anything that makes sense as to
why this is happening.  Is there anyone that has enough Python knowledge
to know what might be causing this, or has run into this already and
fixed it?

We are a little behind on Yocto (Daisy), but I don't know that that
should be a problem.  

Thank You, 

-- 
Jeff Hatch
Senior Software Engineer


1 (763) 717 - 5574   DIRECT
1 (763) 228 - 3603   MOBILE

2205 Woodale Drive 
Mounds View, MN 55112

www.multitech.com




--=-4Eaw8TW5LPjSekQqmdCD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/4.6.6">
</HEAD>
<BODY>
I am seeing an issue where we upgraded the openssl bitbake recipes to build and install openssl 1.0.2h in a higher layer than the base openembedded layer which was building openssl 1.0.1m.&nbsp; After this was done, the build of python 2.7.3 stopped building the socketmodule.c and ssl was not integrated into python.&nbsp; For example, the httplib object no longer has a reference for the HTTPSConnection object.&nbsp; I have spent some time digging around and cannot find anything that makes sense as to why this is happening.&nbsp; Is there anyone that has enough Python knowledge to know what might be causing this, or has run into this already and fixed it?<BR>
<BR>
We are a little behind on Yocto (Daisy), but I don't know that that should be a problem.&nbsp; <BR>
<BR>
Thank You, <BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Jeff Hatch<BR>
Senior Software Engineer<BR>
<BR>
<IMG SRC="cid:1475675182.8940.158.camel@hatchville" ALIGN="bottom" BORDER="0"><BR>
1 (763) 717 - 5574&nbsp;&nbsp; DIRECT<BR>
1 (763) 228 - 3603&nbsp;&nbsp; MOBILE<BR>
<BR>
2205 Woodale Drive&nbsp;<BR>
Mounds View, MN 55112<BR>
<BR>
<A HREF="http://www.multitech.com/">www.multitech.com</A><BR>
<BR>
<BR>
<BR>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-4Eaw8TW5LPjSekQqmdCD--

--=-B0TN+barEVEIGjbd91bl
Content-ID: <1475675182.8940.158.camel@hatchville>
Content-Disposition: attachment; filename="Mulitech.jpg"
Content-Type: image/jpeg; name="Mulitech.jpg"
Content-Transfer-Encoding: base64

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

--=-B0TN+barEVEIGjbd91bl--
