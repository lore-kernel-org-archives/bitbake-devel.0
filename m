Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1S0bRa-0006B2-9n
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 17:22:58 +0100
Received: by qadz30 with SMTP id z30so7825322qad.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2012 08:14:36 -0800 (PST)
Received-SPF: pass (google.com: domain of kergoth@gmail.com designates
	10.229.77.15 as permitted sender) client-ip=10.229.77.15; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of kergoth@gmail.com
	designates 10.229.77.15 as permitted sender)
	smtp.mail=kergoth@gmail.com;
	dkim=pass header.i=kergoth@gmail.com
Received: from mr.google.com ([10.229.77.15])
	by 10.229.77.15 with SMTP id e15mr1525067qck.66.1330013676529 (num_hops
	= 1); Thu, 23 Feb 2012 08:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=ygx0+ainf6MSgCHQFYoBIxnfmZhbhG/9VWeow+x//Jw=;
	b=DAIcR3Y/umV1REhabOcVnl3HNqaC6omSMqWbOivtMGrNMe1GVYrZ4sfNS82pAehAZT
	k7yOcR5FjISbkZPUgi2IRa0XDKOBK/BTzIu03u9Wd9rHFXSziTSOd5zXwnLr7Cr3hTYS
	d5jUc5MLUdHbcf1iMySQC2Z2fCE04M/yKPuec=
Received: by 10.229.77.15 with SMTP id e15mr1295224qck.66.1330013676419; Thu,
	23 Feb 2012 08:14:36 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.224.145 with HTTP; Thu, 23 Feb 2012 08:14:16 -0800 (PST)
In-Reply-To: <e22cf3ce86bd3e323c67f0b905b2211efdd334a2.1330011581.git.paul.eggleton@linux.intel.com>
References: <cover.1330011581.git.paul.eggleton@linux.intel.com>
	<e22cf3ce86bd3e323c67f0b905b2211efdd334a2.1330011581.git.paul.eggleton@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 23 Feb 2012 09:14:16 -0700
X-Google-Sender-Auth: Roukb_rthKLJYzlQrWwVsfbjNbU
Message-ID: <CABcZAN=Q2TqdGABOxHGD1=wfR5Z03-bFjiZJ9EbAhimj8tqV7A@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: fix parse errors not being reported
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
X-List-Received-Date: Thu, 23 Feb 2012 16:22:58 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2012 at 8:42 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as exc:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0etype, value, tb =3D sys.exc_i=
nfo()
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error('Unable to parse =
%s', value.recipe,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 exc_info=3D(etype, value, exc.traceback))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.error('Error during par=
sing %s: %s\n%s' % (exc.recipe, str(exc), ''.join(bb.exceptions.format_extr=
acted(exc.traceback, limit=3D5))))

This seems odd to me. Is the UI not displaying the traceback when sent
to it via the exc_info? Half the point of coming up with the new
traceback format which is pickleable was to allow us to do exception
formatting in the UI.
--=20
Christopher Larson


