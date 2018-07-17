Return-Path: <sherif.e.mousa@gmail.com>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
	[209.85.218.51])
	by mail.openembedded.org (Postfix) with ESMTP id 11496789ED
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 13:57:15 +0000 (UTC)
Received: by mail-oi0-f51.google.com with SMTP id d189-v6so2161101oib.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=ZnSDjvh995NIZewFh+4YuySxV1lCKM/zE/EPogis7iM=;
	b=HB73fsLOhl73CpLPUGoOn8hgiJ5c1shBzXD30vylkJBQ4hH6TuDQXG7YX4bjUzXQLr
	JDeVoRhTOeIsHy1J9QWWMNvwISTkVs7lR7cWS89fQcqA40V6dwDaNsFEo86uZ9SIPdje
	8eLOy4M9sKfg5wD85gwPmtiOVqan0Q8jEVYeN82K7F/z2desLKeD0cGZQIvH6mzO00BU
	ClGP5RXJlDVadl6u2GAYXXwnt7THU/gqr7XPAP1/MgztkTG23Bey4Ye2TY576XchJqEI
	72JrLbi65bfVKLWPKVTaj6BMKapbFNc55ONWCPq3RzLtro0avELS9ImiNWF2XVeTuASC
	JBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=ZnSDjvh995NIZewFh+4YuySxV1lCKM/zE/EPogis7iM=;
	b=HuyJFwZwnV3YH2QueElPKQq2Pycw1OOjThxzBGeKcE1PxJGUiJ3OjZq+lZ0Rpo+44N
	cmtCFnTo0e0aWaSdojOEEMMpY9PuB4A5t/gQr1QAOu6l/DEo/Mr+2/jddcMMGf2vFbI9
	Wl2NCaASZkukU3XDYGs5Ltn50unmpacV06APWBYn9e46zLMOs7Y+po0PnT+9W5dSz2px
	EnQXEPAmFG92/ybQ+mZHaTb4fhYBfcqFAP3GeFtP5VX32XArtVqdSXhdkiaaypXVlp3F
	7yao//eKiQXkheLRdUCOTEjGr7vAKS8FW1NGfR5YAcD3rFcIOs1Uqnb5gHCD0eCz+a/w
	l0iw==
X-Gm-Message-State: AOUpUlEjTaPUszfVOCPUIyRhK9wXelJMCIml7oUVlV1fF4D0oky2wlnE
	7p8zq/451t5kYAiF7Wf+0qWI/aztfKHKPhEJy9bM9ClA
X-Google-Smtp-Source: AAOMgpfvPpVPfOj8NvQ5LF6K8MlMINmRcqcJE9EJ9BMSJhcfy4ajfb8gQ9sUsb/3RQS25sy11AyF9+3eujhth6zTYOQ=
X-Received: by 2002:aca:190d:: with SMTP id
	l13-v6mr1897040oii.216.1531835836556; 
	Tue, 17 Jul 2018 06:57:16 -0700 (PDT)
MIME-Version: 1.0
From: Sherif Mousa <sherif.e.mousa@gmail.com>
Date: Tue, 17 Jul 2018 13:56:04 +0000
Message-ID: <CAMqo94KK+Rjr-2O03PPPw0gWm1suj5JFYHW9xbguYfo9H16Ahg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Thu, 19 Jul 2018 22:01:22 +0000
Subject: Implement function to be executed before ending each bitbake session
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
X-List-Received-Date: Tue, 17 Jul 2018 13:57:16 -0000
Content-Type: multipart/alternative; boundary="000000000000e46bf705713252ba"

--000000000000e46bf705713252ba
Content-Type: text/plain; charset="UTF-8"

Hi,

Is it possible to setup a function to be executed at the end of each
bitbake-session execution, just before calling sys.exit(ret) , but without
patching the original bitbake script "poky/bitbake/bin/bitbake" ?
Is there a way to do this from a recipe (event handler, ....) ?

Regards,
Sherif

--000000000000e46bf705713252ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Is it possible to setup a function =
to be executed at the end of each bitbake-session execution, just before ca=
lling sys.exit(ret) , but without patching the original bitbake script &quo=
t;poky/bitbake/bin/bitbake&quot; ?</div><div>Is there a way to do this from=
 a recipe (event handler, ....) ?<br clear=3D"all"><div><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><br></div><div dir=3D=
"ltr">Regards,<br>Sherif<br></div></div></div></div></div></div></div></div=
></div></div></div></div></div>

--000000000000e46bf705713252ba--
