Return-Path: <bnousilal@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id E21D060853
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Aug 2016 06:37:28 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id c199so13113784oig.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jul 2016 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=lM7zb5HO7xfVmvcubPAc7Um6tIQKa/cOa0lHmVPR3dU=;
	b=bx92yIIDr8ADJeJNBhOKU8pgVKpKoFubvOSYSHALAKr2Vd9lkPo0cmX+pKUGUjYikO
	pFTqZri5Z6EbzgOkkxfS1QNCdSjcqRUGCTvvkUox34J+qtR1uQhou18/lfFgsNEVAYPT
	ox10sFVphbIdCEVfW3JStmQdc/7VkCUXM8fbouDAlRVqvnz7m0xFyVuhDzBYMZrql8bb
	UOaYlqs7kO3QoAwuznq3k6a/0PXGzPkoxW7t5jikHwT/TkA5Q84xnUtZtijEAtJv9qpG
	z/tj0cmGjft+AxoPQL6tWQeCtY0uinyc6tqmF+j2krfiO80h/ATSweJJ6txynxgzx1DU
	0VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=lM7zb5HO7xfVmvcubPAc7Um6tIQKa/cOa0lHmVPR3dU=;
	b=YciSD6XBTdFuKLP7UlUGc+5WZM/fJIo5uX0rOaNeH7xnYIXZYazol4j7Juo6sf6kov
	WQz7EAxk0Y8Jwo8TZSaZPBdL4wsHkRkQEnc4LjQJFlXyw5r39fnNylzxsNcIXAa0I2AZ
	h4zswKnQaQo1LIGLwXK6nDLHqmwjFZ4PWM70o+F8fkbSfCIWWMcw82uOSggITRld4cVO
	0wxKMV1iuaSQC7Jf7mPrDv6GhelrIKEEOABunHoZ0aU2/ZEuv6Mzf0l1540HqkOooSfd
	SszLjcOARgVRN0qkE4sNY3FAND7kVjpBFoLsZe1LLmsXdf3S2jzkyzU45DsBS8RSGpuA
	EZYQ==
X-Gm-Message-State: AEkooutx37a9kVj20+IHqOYHEoeJmnE1cwKeah/z8tWWgGcqa9J289RbkkRfrz5rKNNmp41i9gaMFI8BYK3YuQ==
X-Received: by 10.202.81.211 with SMTP id f202mr31956380oib.173.1470033448705; 
	Sun, 31 Jul 2016 23:37:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.42.168 with HTTP; Sun, 31 Jul 2016 23:37:28 -0700 (PDT)
From: nousi <bnousilal@gmail.com>
Date: Mon, 1 Aug 2016 12:07:28 +0530
Message-ID: <CAJ5vXcTv6PRkV+oo=eENiTLf9mOQwaxStCMbyn2w6o_SzRiisw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake cleanall nousi-linux
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
X-List-Received-Date: Mon, 01 Aug 2016 06:37:29 -0000
Content-Type: multipart/alternative; boundary=001a113b05c684a4dd0538fcd574

--001a113b05c684a4dd0538fcd574
Content-Type: text/plain; charset=UTF-8

Hi All,

I have set STAGING_KERNEL_DIR in "local.inc file" and when I issue
"bitbake cleanall nosi-linux " it is removing all the source code from
STAGING_KERNEL_DIR location.

Please, let me know the process to clean the kernel source code which is
under the build directory tree?
-- 


*Thanks & Regards,B.Nousilal,*

--001a113b05c684a4dd0538fcd574
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I have set STAGING_KERNEL_DIR i=
n &quot;local.inc file&quot; and when I issue &quot;bitbake=C2=A0cleanall=
=C2=A0nosi-linux &quot; it is removing all the source code from STAGING_KER=
NEL_DIR location.</div><div><br></div><div>Please, let me know the process =
to clean the kernel source code which is under the build directory tree?</d=
iv><div>-- <br><div class=3D"gmail_signature"><i style=3D"color:rgb(51,51,2=
55)"><font style=3D"font-family:arial,helvetica,sans-serif" size=3D"2">Than=
ks &amp; Regards,<br>B.Nousilal,<br></font></i><br></div>
</div></div>

--001a113b05c684a4dd0538fcd574--
