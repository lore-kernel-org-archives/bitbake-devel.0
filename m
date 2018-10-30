Return-Path: <madhu1313b@gmail.com>
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
	[209.85.160.173])
	by mail.openembedded.org (Postfix) with ESMTP id 1AFC8745EF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Oct 2018 05:49:50 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id z20-v6so12149983qti.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=MF5X5mWLDhAgb0XUZX6x4Is1HRJcoKAtBAgiNwcRZbc=;
	b=Gtxfwhm1LgkaVw+P/LMv3EfT1ZD4iYcEezB1j/1S6zh3ta2n6TaFDuqOQqA18C8GmV
	zJxgCFTFIMYPCjpizx8D6qiDO118TzAbFNM8pXYM2t3MCGOqX8fG6R9R7sTEJVMCMsEK
	hpNiJvszgccMJ7Y29W6KDYNZGd6sNKsqSwLe7+Fpy3ElRV21Q4MkvBrIzhB+I2Ogzn39
	ofGdFOL6GGR+WSTi3I7Q9L8Gg2LcDpJjV5dFYKjU+mokqmxpjJTeEuB8Ptu1LiEYHJ6i
	cn+SHhWfbPZj0DGDYT0GVZ9ijU57NirUORxMo9uyxgDW0IGn9I6AmKed6F/suIyPMwfv
	7c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=MF5X5mWLDhAgb0XUZX6x4Is1HRJcoKAtBAgiNwcRZbc=;
	b=XNIqCeJvJvSArjHlVPYx8roijImANTh3A8aLAO/hlBubD37FYyi0CxMqGuMqD6DUbk
	RUIwRiUS12fm5dPPO1AlvsLu122Wdvk4TwjH/UkP6nZh3NVRjlpKmzZf3hbOOnAx+df7
	2EeM4CrwfTTpgejyqmTPNKGwXThQJSIHrPxAyGTtnBZL7SjPvqKelkD8+Enw66t9QtZI
	NWbNPHq6ciUFAGe9M+VxURR4N/AIdVqytwIuJtnygRHCZ+YLbA6xFHgp+3PZa1H77MjE
	TwzqIqSWJdfHHTnO3yHWOsrpmupUIAayMwMwC+T5SaczzNxwdrt6R2UQ6L6YuFG046UD
	f96g==
X-Gm-Message-State: AGRZ1gJ6utBwBRHazHDanSqeT5kaK3kF80cx7+z6tytS95LE+zP+hk4c
	Pa0TRmMlNYEEIpsRXI+8OJUxhN8NEJhacM9yMVb53A==
X-Google-Smtp-Source: AJdET5e8ZDwM/jCCvfhBVvTcnrIJ4747/y5IdH7Qbtph9tHCatBiKOChSFltKtBNbsGWW+y0P2a7a/ZMQ0bV6UaNaBc=
X-Received: by 2002:aed:3024:: with SMTP id 33-v6mr1087798qte.29.1540878591939;
	Mon, 29 Oct 2018 22:49:51 -0700 (PDT)
MIME-Version: 1.0
From: Madhu B <madhu1313b@gmail.com>
Date: Tue, 30 Oct 2018 11:19:40 +0530
Message-ID: <CAH5YvUu49bAofSQRq+tS66MjbmOWFRoE5uYqMDqQY3NO78gnOg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Tue, 30 Oct 2018 13:59:13 +0000
Subject: How to add an image file to a meta layer using bbappend file
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
X-List-Received-Date: Tue, 30 Oct 2018 05:49:51 -0000
Content-Type: multipart/alternative; boundary="0000000000001d58d805796bc11f"

--0000000000001d58d805796bc11f
Content-Type: text/plain; charset="UTF-8"

Hi all,
         I want know, how to copy an image file to a meta layer's source
code using *.bbappend file(Without git commit). Is there any way to do that?

Regards,
-Madhu.

--0000000000001d58d805796bc11f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 I want know, how to copy an image file to a meta layer&#39;=
s source code using *.bbappend file(Without git commit). Is there any way t=
o do that?</div><div><br></div><div>Regards,</div><div>-Madhu.<br></div></d=
iv>

--0000000000001d58d805796bc11f--
