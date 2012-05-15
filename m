Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SUJ7s-00075C-TK
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 May 2012 16:53:24 +0200
Received: by werg55 with SMTP id g55so2956715wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2012 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=chpREgzuaivAo+MHfidU/mydh+SHXFiYuSlCksVMlHI=;
	b=aV4YetAoZHrYD/Pdl9oz6vjVHi3IpDKmBrSh0yXKL3lmBW9+H0aGAKXxREMQF96Jty
	zwcxh6yoN8vC0mz7pRebNJ/CCpqQhlAO5WNmK7vsE0Eb+66blaF3/3pbkunrIxyZHMJM
	BKz6v6vU68hK7ACZY6iVrOwX+U9V8MJWycSvYqfnukR2fh/2VAvdTdXDDn3JAKBtNh+x
	JicbYK5qWfcxMRoCSeGrezP8ogT1+W/bfpf1/4kO4xJFuA5uUIlTjeyT3s0GkPK1IWgB
	qME4NO0I9GG49DzZXFoeMSsD7+/85BuJ8qNb1GiF8gg8FEKsPZe+hxsFA5bIGMg33qUV
	dnOQ==
Received: by 10.216.204.217 with SMTP id h67mr7818586weo.68.1337093004728;
	Tue, 15 May 2012 07:43:24 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Tue, 15 May 2012 07:43:04 -0700 (PDT)
In-Reply-To: <6ca7f7e56bdab86c3920182256220077a94fe78d.1337073916.git.liezhi.yang@windriver.com>
References: <cover.1337073916.git.liezhi.yang@windriver.com>
	<6ca7f7e56bdab86c3920182256220077a94fe78d.1337073916.git.liezhi.yang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 15 May 2012 07:43:04 -0700
X-Google-Sender-Auth: ArwqdJmo-k9vTyoA6kbj0sfFsr4
Message-ID: <CABcZANkHOAe0Fx8hG+_5m-z6jLHNV1hKu2vv01T_TsY1u4H6jA@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 2/2] replace os.popen with subprocess.Popen
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
X-List-Received-Date: Tue, 15 May 2012 14:53:25 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2012 at 2:53 AM, Robert Yang <liezhi.yang@windriver.com> wr=
ote:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0p4file =3D os.popen("%s%s changes -m 1 %s" %=
 (p4cmd, p4opt, depot))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0p4file =3D Popen("%s%s changes -m 1 %s" % (p=
4cmd, p4opt, depot)).stdout
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 cset =3D p4file.readline().strip()

When all that's being done is reading the output of the command, I'd
think bb.process.run() would do the job, rather than manually using
Popen, no? Once we require python 2.7, we can use
subprocess.check_output() instead, of course.
--=20
Christopher Larson


