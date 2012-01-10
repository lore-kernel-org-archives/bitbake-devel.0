Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Rkhtm-0001mf-KU
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 21:02:22 +0100
Received: by qadb17 with SMTP id b17so1974906qad.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jan 2012 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=/nvr6vPW+NXKNtJBbQRdPvvWOUTiL4hKWTkBS1KltSE=;
	b=WC0WDp+JcWqVJ5a0oKLtz+cMgbGuYFL9IrUEsR94niL1VM0er5M6RYD/No29fR+mcq
	XOt5IFGejnszspBHKjucy29nuUFLD9unW4B1ZRYLrZQ1jaAkxXnaEARn2tUb9u0Vp5yN
	sOUsdOqgtq1v59NK3Kr6Bp5GeV62RI4Dbemk0=
Received: by 10.224.175.2 with SMTP id v2mr26676353qaz.69.1326225293369; Tue,
	10 Jan 2012 11:54:53 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.187.141 with HTTP; Tue, 10 Jan 2012 11:54:31 -0800 (PST)
In-Reply-To: <1326217869.23315.5.camel@ted>
References: <cover.1326199289.git.liezhi.yang@windriver.com>
	<bb164b343a162cee39a0ba2f76a7ffb906bc5381.1326199289.git.liezhi.yang@windriver.com>
	<1326217869.23315.5.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 10 Jan 2012 12:54:31 -0700
X-Google-Sender-Auth: RKUrUil-TpLZvuZNhtSVcYxg67I
Message-ID: <CABcZANk8VKTJai7XMKCf=xUh-Sbr_VJqZEK0zAvfNMP_8CdYbg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] V2 Disk space monitoring
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
X-List-Received-Date: Tue, 10 Jan 2012 20:02:22 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2012 at 10:51 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Tue, 2012-01-10 at 20:45 +0800, Robert Yang wrote:
>> * Problems:
>>
>> =C2=A0 1) The disk space monitor is running in a sub process of
>> =C2=A0 =C2=A0 =C2=A0bin/bitbake, so it can't use the same logger as bitb=
ake(or I don't
>> =C2=A0 =C2=A0 =C2=A0know how to use it, I've tried to use the logger.war=
n('some
>> =C2=A0 =C2=A0 =C2=A0information'), but it would print nothing in the sub=
process),
>> =C2=A0 =C2=A0 =C2=A0another solution maybe use an independent logger in =
the subprocess,
>> =C2=A0 =C2=A0 =C2=A0but it seems that it doesn't worth because of the tw=
o reasons:
>> =C2=A0 =C2=A0 =C2=A0a) The logger of bin/bitbake can't control the monit=
or's
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 independent logger

If the monitor spawns from the bitbake server process, then it can
send log messages to the standard bitbake UI process, and it wouldn't
need its own log handling.
--=20
Christopher Larson


