Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Rkf1H-0003jy-I6
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 17:57:55 +0100
Received: by qcqw6 with SMTP id w6so2628912qcq.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jan 2012 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=C739uVJj8ABfdh6Wma8ZbB8IUoIWDuzfUFXe7f+1AwU=;
	b=XIvsh6tqeYd/djy0pglLv9vQkUkI7MRPm1dvdb4uIR/h5viKSHoE6YbABAfhJMfQ5E
	nvMT+OB8gXKq1sEisSKLCEKfumgCsxxG7dfdzttz3D58VlMnwlXyBXnhTOx8oKqyM4zL
	IteuVxq36kTrHUxW+nTCTpBnODvOs10FV/PNI=
Received: by 10.229.76.14 with SMTP id a14mr938901qck.136.1326214225658; Tue,
	10 Jan 2012 08:50:25 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.187.141 with HTTP; Tue, 10 Jan 2012 08:50:04 -0800 (PST)
In-Reply-To: <cover.1326199289.git.liezhi.yang@windriver.com>
References: <cover.1326199289.git.liezhi.yang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 10 Jan 2012 09:50:04 -0700
X-Google-Sender-Auth: 6v12JIGe3Y8HCpKyV3c0u-PhL94
Message-ID: <CABcZANnwzNu85ocF183x2Pa1wiLvWU+FBvybFtKcbyq-QXnJBQ@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] V2 Disk space monitoring
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
X-List-Received-Date: Tue, 10 Jan 2012 16:57:55 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2012 at 5:45 AM, Robert Yang <liezhi.yang@windriver.com> wr=
ote:
> Here are the test info:
> 1) set the following variables in conf/local.conf for testing:
> =C2=A0 BB_DISKMON_DIRS =3D "${TMPDIR} ${DL_DIR} ${SSTATE_DIR} /home/lyang=
1"
> =C2=A0 BB_DISKMON_MINSPACE =3D "200G"
> =C2=A0 BB_DISKMON_MININODES =3D "20M"
> =C2=A0 BB_DISKMON_INTERVAL =3D "30s"
>
> =C2=A0 The TMPDIR, DL_DIR and SSTATE_DIR are in the same disk(/dev/sdb4) =
in
> =C2=A0 my build, so I added another direcotory /home/lyang1 to test the
> =C2=A0 ability of monitoring multi mount points.
>
> 2) bitbake core-image-sato
> =C2=A0 WARNING: The free space of /dev/sdb5 is running low (25.915GB left=
)
> =C2=A0 WARNING: The free inode of /dev/sdb5 is running low (1788.202K lef=
t)
> =C2=A0 WARNING: The free space of /dev/sdb4 is running low (189.309GB lef=
t)
> =C2=A0 WARNING: The free inode of /dev/sdb4 is running low (18005.443K le=
ft)
>
> 3) Aalso have tested about the following items:
> =C2=A0 a) Use ctrl-c to stop the monitor
> =C2=A0 b) The monitor should stop when the build stops
> =C2=A0 c) Test the space unit G, B, K(case in-sensitive) and the time uni=
t
> =C2=A0 =C2=A0 =C2=A0h, m, s(case-sensitive)

I would think it'd be more useful to be able to specify the thresholds
on a per-mountpoint or per-path basis. The space needed by sstate,
downloads, and the rest of the build can be quite different. Further,
the space requirements for DL_DIR and sstate both are dependent upon
the current contents of the directories, as if we already have all our
downloads, the free space there isn't much of a concern..
--=20
Christopher Larson


