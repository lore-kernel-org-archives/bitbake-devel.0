Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gopikrishnans@pec.edu>) id 1SUanf-0004hE-TI
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 11:45:44 +0200
Received: by bkcjm2 with SMTP id jm2so424083bkc.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 May 2012 02:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type:x-gm-message-state;
	bh=ssS73AuMmqJ4mMDtIi8snRQsa+si8H33GvxgLUwHLsY=;
	b=Bv4Py8ezx16joKWhIqV6mpoh1AzreIp2iLnJdsoFuGtPMSN4W5lxBBWZVVPpNh2zY1
	kkWnNOgdB/t7sT4+wc3cv4oMuTmzSAGdQ17KD1m2oM6yv1wW3PCx13fqU4St/+pOH8UZ
	YL8GSG2e3Td17VxbgESvW+xAmBaUIMr5ZpZnEUaMUrZcNJO1eePbqiUZ9StA6NdRw83P
	squ9fOX/aP8jR+bkFzhCHG5347bb0oMs76MojFnaSgU6K1YoGHlwKGRdi2XgLi2/cqUa
	EbgacS3IcqKjtEHKRsaxVelCJ8aPgrz1aoFxcnM6L4DGSMbcuPi7bzkFON4qBwUWueBB
	WPnQ==
MIME-Version: 1.0
Received: by 10.204.157.23 with SMTP id z23mr885747bkw.71.1337160942602; Wed,
	16 May 2012 02:35:42 -0700 (PDT)
Received: by 10.204.233.80 with HTTP; Wed, 16 May 2012 02:35:42 -0700 (PDT)
In-Reply-To: <e22ec7981521df200e2db535630b666ce6d2731f.1337147194.git.liezhi.yang@windriver.com>
References: <cover.1337147194.git.liezhi.yang@windriver.com>
	<e22ec7981521df200e2db535630b666ce6d2731f.1337147194.git.liezhi.yang@windriver.com>
Date: Wed, 16 May 2012 15:05:42 +0530
Message-ID: <CAOkC3Rb8vTSoSU9H=oboHhH2g6bxwbPQ3GiW2uu+0ZNA_-+Svg@mail.gmail.com>
From: GOPIKRISHNAN S <gopikrishnans@pec.edu>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQns5leCr33em+RlH/J6qSDfFzdgPsRcyWMCIiiwcPuYLCk9d14TtX8Hb6SdFlNCGFkxJ376
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
X-List-Received-Date: Wed, 16 May 2012 09:45:44 -0000
Content-Type: multipart/alternative; boundary=0015175ca850fdc9bd04c0240a51

--0015175ca850fdc9bd04c0240a51
Content-Type: text/plain; charset=ISO-8859-1

Hi,

    I am a newbie in bitbake. I am stuggling with customizing the recipe
script. Whenever i customize
                bindir, sbindir, libexecdir, libdir, datarootdir; My
package build (BB -c build <pkg>) is successful. But when creating rootfs;
(bb -c build devel-image) , I get error opkg can install <pkg>


Reg,
Gopi

--0015175ca850fdc9bd04c0240a51
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>=A0=A0=A0 I am a newbie in bitbake. I am stuggling with customiz=
ing the recipe script. Whenever i customize=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 bindir, sbindir, libexecdir, libdir, datarootdir; My =
package build (BB -c build &lt;pkg&gt;) is successful. But when creating ro=
otfs; (bb -c build devel-image) , I get error opkg can install &lt;pkg&gt;<=
br>
<br><br>Reg,<br>Gopi<br>

--0015175ca850fdc9bd04c0240a51--
