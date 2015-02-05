Return-Path: <gmstima@gmail.com>
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com
	[209.85.217.175])
	by mail.openembedded.org (Postfix) with ESMTP id AE5BD60557
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Feb 2015 12:29:26 +0000 (UTC)
Received: by mail-lb0-f175.google.com with SMTP id n10so2425983lbv.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Feb 2015 04:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=+SQLgJeT7zBgm4F3i6hKow7beIBFDSND0W37aIdc42E=;
	b=spWLEVarunGsgzZPhCG+AVegrsiew2lf/b8tQ6DyFEhRmlu0inPvxgCar0TwgGqmKb
	XYCgl1xZTP4AEx/oI17An32IxivgLdNjlY+hRKqxotPfavTvCR6s44oH2X9/5cZY5snk
	KN0NoYEk3O9/SrEZpVJiI0UQlnrGrVu2aA1PxlqNRrMCnzZ3p+xkCRLDdLfahIaJBQrX
	8tJobe2UUSeY1MWkdtzBSsE32SMrWlNjuYcTmLVklo+GyPaLNL4W08WiMYNEYSnSK3ph
	AqdjNr7Ags8uNl7nY/dD3rQGv166J8rbaGD8/rAAbmp29HtHwR9fsneMZuquRbXIg9PD
	JiHg==
MIME-Version: 1.0
X-Received: by 10.112.224.133 with SMTP id rc5mr3127669lbc.31.1423139366568;
	Thu, 05 Feb 2015 04:29:26 -0800 (PST)
Received: by 10.152.191.139 with HTTP; Thu, 5 Feb 2015 04:29:26 -0800 (PST)
Date: Thu, 5 Feb 2015 14:29:26 +0200
Message-ID: <CAGpdKUKoy9MG_N6zLu54Lnh8TUmvogAQHvWPPrT_FAi6mO4sBg@mail.gmail.com>
From: Roman Savchenko <gmstima@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Specify files to package for subpackages
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
X-List-Received-Date: Thu, 05 Feb 2015 12:29:29 -0000
Content-Type: multipart/alternative; boundary=001a11360522690736050e567499

--001a11360522690736050e567499
Content-Type: text/plain; charset=UTF-8

How can i specify files to package for subpackages in general way,
something like:
FILES_${PN}-*

or

d.setVar("FILES_" + pkg)

--001a11360522690736050e567499
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><div>How can i specify files to package for subpackages in general way, something like:<br>FILES_${PN}-*<br><br></div><div>or<br><br></div><div>d.setVar(&quot;FILES_&quot; + pkg)<br></div></div>

--001a11360522690736050e567499--
