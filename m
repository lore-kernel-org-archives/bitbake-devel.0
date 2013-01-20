Received: from mail-lb0-f169.google.com ([209.85.217.169])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>)
	id 1Tx1QV-0007iW-5P; Sun, 20 Jan 2013 21:23:36 +0100
Received: by mail-lb0-f169.google.com with SMTP id m4so2693601lbo.28
	for <multiple recipients>; Sun, 20 Jan 2013 12:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=4l9YTa7MXoMZnmwT/0TZpn8PUhm030FUyMsyPvGOobM=;
	b=p1OLM8QVWEwQ43B9xb8n1klBTrcZn45pJpa0AO+a2Gf7pUcWQzanT7ItVlAjuyFkOC
	FedJoRSgp+GbrRGhLsHezH5DcRbrgSuJOotz1ZbaP8sOv8QTyDYePLHTFHINLF+JANrR
	80rf85AhVz2un1BdKS1BmelHSiTAp6Uz8Li8pZXDXNm5vrjUUpOoyD/g29Nx+mNjAuhT
	4dMui1lcc6uH4VWo1Sw/ilMpSnpoXg+cJzOTdetJgAVmaxxz52uQs2Xt1kcqzBmfzeOC
	jW6FnwdRyz1jHpeUWE86VZBwTDxB3z6XjP1nOj+9kAlxlEd1GaffMTmhNRBkj/dghRqS
	v7+g==
X-Received: by 10.152.133.130 with SMTP id pc2mr1118854lab.51.1358712487393;
	Sun, 20 Jan 2013 12:08:07 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Sun, 20 Jan 2013 12:07:47 -0800 (PST)
In-Reply-To: <13c58476de5.2760.0f39ed3bcad52ef2c88c90062b7714dc@gmail.com>
References: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
	<CABcZANkpo5qMnPkL903SQjfkPhwUF-7rK+i5LaqxTFUdqE3H2Q@mail.gmail.com>
	<CAHsH0E_9kaYC0_9rv+zHR8FwxXyU=7vTj2eL85_jJ=uRtb0aSw@mail.gmail.com>
	<13c58476de5.2760.0f39ed3bcad52ef2c88c90062b7714dc@gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 20 Jan 2013 13:07:47 -0700
X-Google-Sender-Auth: OteXTR4ir44bjPO9iPMrWN1YMGM
Message-ID: <CABcZANnOFkS61xKs=ZzeTKFUBa=sYZpR-5jXdzf6oHYhdtpU_Q@mail.gmail.com>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: git address in SRC_URI, doesn't works for me
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
X-List-Received-Date: Sun, 20 Jan 2013 20:23:42 -0000
Content-Type: multipart/alternative; boundary=f46d042dfc8729b81104d3bde756

--f46d042dfc8729b81104d3bde756
Content-Type: text/plain; charset=UTF-8

As I already explained, the url scheme determines the tool to be used.
http:// will call wget. git:// will call git. protocol= controls the
underlying protocol it's fetched over. Not that complex. The alternative
would be to reverse them, meaning you'd have to tell bitbake not to use
wget for a http:// uri. Neither will magically know that a given
http://uri is a git repository.
-- 
Christopher Larson

--f46d042dfc8729b81104d3bde756
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As I already explained, the url scheme determines the tool=
 to be used. http:// will call wget. git:// will call git. protocol=3D cont=
rols the underlying protocol it&#39;s fetched over. Not that complex. The a=
lternative would be to reverse them, meaning you&#39;d have to tell bitbake=
 not to use wget for a http:// uri. Neither will magically know that a give=
n http:// uri is a git repository.<div class=3D"gmail_extra">

-- <br>Christopher Larson</div></div>

--f46d042dfc8729b81104d3bde756--
