Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1STvy3-0007GR-5J
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 May 2012 16:09:43 +0200
Received: by wgbdr1 with SMTP id dr1so4192599wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2012 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=YP+iLmyFik1QZK+NRNXkGb8PvirosZDghGa2yED8UNM=;
	b=EpXRfz7z0oh+99f234ekEs14VH8dTf4PTerqN0KEcE09d3noTprT7gcPGffktviJJG
	Dcj0LrVITZpawsGJ8gYsYm/ZLDKUuQWaeTnO2gQdFqtJ0agCrh4RWMfgNax+ZnckS+z2
	N7TyRQyqijyme+jmNjljy57Ny1DHpsCM5Ta0RRBJe0yyAQXyGnJNG7PX6AwyWIQ5afJN
	VRM5A+qlaki3kjM9+LEGBeqChgKQNiqz7OJpjqfPs84XoFzRSOB4zq0Vi961GEBeTDH3
	us7X+dubG9J43IDNE1k6QUkOaU8u0gDKei+ORUQLPEQJkkJcKALj3JltkNyvk3QaiJYK
	FgJA==
Received: by 10.216.132.94 with SMTP id n72mr5143992wei.60.1337003984349; Mon,
	14 May 2012 06:59:44 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Mon, 14 May 2012 06:59:24 -0700 (PDT)
In-Reply-To: <a072dd7795f44603322db6583ac748f0418684fd.1336974361.git.liezhi.yang@windriver.com>
References: <cover.1336974361.git.liezhi.yang@windriver.com>
	<a072dd7795f44603322db6583ac748f0418684fd.1336974361.git.liezhi.yang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 14 May 2012 06:59:24 -0700
X-Google-Sender-Auth: yqWalzzenJEf7bmuMespR3OSAXE
Message-ID: <CABcZANnhObRGgJ0gzM+urLRE5gcWmsECFR59P+HpHYPqannh3w@mail.gmail.com>
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
X-List-Received-Date: Mon, 14 May 2012 14:09:43 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2012 at 1:07 AM, Robert Yang <liezhi.yang@windriver.com> wr=
ote:
> =C2=A0 =C2=A0 def popen_read(self, cmd):
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return os.popen("%s 2>/dev/null" % cmd).read=
().strip()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return subprocess.Popen("%s 2>/dev/null" % c=
md, shell=3DTrue, stdout=3Dsubprocess.PIPE).stdout.read().strip()

The 2>/dev/null is irrelevant when we're only inspecting the stdout
anyway. Also, we already have wrappers around Popen for convenience in
the bb.process python module.
--=20
Christopher Larson


