Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gregperry999@gmail.com>) id 1TVXOS-0007JM-RN
	for bitbake-devel@lists.openembedded.org;
	Tue, 06 Nov 2012 01:51:52 +0100
Received: by mail-oa0-f47.google.com with SMTP id h1so6258099oag.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Nov 2012 16:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=G6wCT8D49bAf/DJOMFKAMUnouyoY2ADX8Wk+Q9y0P14=;
	b=mlN/AfkGHuKGb8YUwVIneGZh5miXPOI6iLSQUaqBy0QUkV5Ehg9qXC5MHFjYHW4Nw5
	xZEVSZreBhUjIxANfiEz3KJvmaQybWdR8YcdYJN2KD4/fskZkVIrF5FvGN1nJUMv2cJ7
	jaKagClB6ahGQqA408HHVre2JBn7qmmlWyuQb7Er1Lu8ZjpCmsWXe8qSCSUYRSjOmEdJ
	zbFNiedpxkgbgannAF/IJdHchi2ziwJKFKx4c9CZFtMwrzBdumI+IybZg7DoG5a9pepo
	uut9WhC6ZZ7jhl1s66PTyuNqRCI3DEHFJIFxGc/HMgdQpHUo2fr7xXq4RkyhwxxC90Jo
	nLxQ==
MIME-Version: 1.0
Received: by 10.60.169.70 with SMTP id ac6mr9502824oec.134.1352162288243; Mon,
	05 Nov 2012 16:38:08 -0800 (PST)
Received: by 10.76.173.232 with HTTP; Mon, 5 Nov 2012 16:38:08 -0800 (PST)
Date: Mon, 5 Nov 2012 19:38:08 -0500
Message-ID: <CA+ZhUHnqOTdCtXMC-y_QtdmH+Gkse80XjDgQnPqUStuBvS2A2g@mail.gmail.com>
From: Greg Perry <gregperry999@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Using bitbake with older kernel revisions
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
X-List-Received-Date: Tue, 06 Nov 2012 00:51:53 -0000
Content-Type: multipart/alternative; boundary=bcaec54b4a38de91da04cdc8d01d

--bcaec54b4a38de91da04cdc8d01d
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Hopefully this is the right mailing list to ask this question, if not I
apologize in advance and ask that you send me to the appropriate mailing
list.

I have a BeagleBone cross compile setup (ARM-based board), and I've
successfully used the OE/bitbake process described at OpenEmbedded.org to
setup of a cross compile toolchain, download source, and build an entire
system plus software from scratch.

However, the kernel revision used is several versions ahead of the patch
branch that I want to integrate (3.2.28), as I want to integrate the
Xenomai RTOS extensions which require kernel version 3.2.21.

Is it possible with OE/bitbake to specify an older kernel revision with
accompanying system to build an older kernel and Angstrom distribution?
 Ideally I would like to regress back to the 3.2.21 kernel release and do a
full build of that Angstrom distribution after applying the Xenomai patches
to the 3.2.21 kernel.

Thanks in advance for your help

--bcaec54b4a38de91da04cdc8d01d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>Hopefully this is the right mailing list to ask t=
his question, if not I apologize in advance and ask that you send me to the=
 appropriate mailing list.</div><div><br></div><div>I have a BeagleBone cro=
ss compile setup (ARM-based board), and I&#39;ve successfully used the OE/b=
itbake process described at OpenEmbedded.org to setup of a cross compile to=
olchain, download source, and build an entire system plus software from scr=
atch.</div>
<div><br></div><div>However, the kernel revision used is several versions a=
head of the patch branch that I want to integrate (3.2.28), as I want to in=
tegrate the Xenomai RTOS extensions which require kernel version 3.2.21.</d=
iv>
<div><br></div><div>Is it possible with OE/bitbake to specify an older kern=
el revision with accompanying system to build an older kernel and Angstrom =
distribution? =A0Ideally I would like to regress back to the 3.2.21 kernel =
release and do a full build of that Angstrom distribution after applying th=
e Xenomai patches to the 3.2.21 kernel.</div>
<div><br></div><div>Thanks in advance for your help</div><div><br></div>

--bcaec54b4a38de91da04cdc8d01d--
