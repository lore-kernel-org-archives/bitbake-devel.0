Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SWYqM-0001iH-P6
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 22:04:38 +0200
Received: by wgbdr1 with SMTP id dr1so4677165wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=mjLCzm8CzlbTSc5Rxg4Ys6z2b8z3DCHFusUfhaCspBs=;
	b=Erl7egaPT908BAiI7D2rw4jSP5WKmopmvrRzfCScm7CJJsO15bapvXrErYuEnhtuBa
	ifw8EjuFSgy9MyXFAoIHTdRkXONoajsgiT4tH8MqfQGq1iXnAkSVvy/uSXVDhLayTr/1
	hOh3g+gPF4SEnh9tzkDkqOgGtfBQIY5JIkXBFF6XwWuB4H5U27CC5oPhWFMUBx5RlX5X
	eH7YlTjtStc60AHDBHGVWfj6uQWLdG3+fP/hLVBrePanFveYJCm4EKI2pxV4HhvhffXG
	mxQrPfWlei+EnX1s1Q7p094VzMb9yLOOG90j4uAm4RDPJgJuHenCsrhOJUGnWnq3ZzVh
	FVAA==
Received: by 10.216.132.75 with SMTP id n53mr13792660wei.51.1337630070891;
	Mon, 21 May 2012 12:54:30 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Mon, 21 May 2012 12:54:10 -0700 (PDT)
In-Reply-To: <cover.1337612802.git.peter.seebach@windriver.com>
References: <cover.1337612802.git.peter.seebach@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 21 May 2012 12:54:10 -0700
X-Google-Sender-Auth: mH9TIQ4IIbhQg0gNs10VZRE22xw
Message-ID: <CABcZANkcJQsc2Up1umRX1ek3m+waB-Pq3cFYOCQb3A+4Uh0RNw@mail.gmail.com>
To: Peter Seebach <peter.seebach@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: v2 [PATCH 0/2] data_smart.py: Track inclusions and assignments
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
X-List-Received-Date: Mon, 21 May 2012 20:04:38 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 8:10 AM, Peter Seebach
<peter.seebach@windriver.com> wrote:
> This revised patch now uses Python's traceback facility to assign
> meaningful locations (file and function, rather than line) to operations
> which weren't specified, and correspondingly does not specify file and
> line when the file name would have been the python code making the
> assignment; this makes the patch smaller and the output more meaningful.
>
> As before, this is a patch to add tracking showing when and how variables
> got their values, and which configuration files were included from which
> other configuration files.
>
> The following changes since commit 39adb5741d9eee0879d3181be505400dffc608=
04:
> =C2=A0Andrei Gherzan (1):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bb/fetch2/__init__.py: Don't try to compute ch=
ecksums for directories

While these still aren't the prettiest, I think they're a lot cleaner
than they were, and given the obvious value, I think we should
consider merging them. Richard, thoughts?
--=20
Christopher Larson


