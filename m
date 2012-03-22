Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1SAoA2-0005dC-Ps
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 20:59:02 +0100
Received: by lagw12 with SMTP id w12so1937704lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Mar 2012 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=CvK+V874kE6nLJqNVwyBPzt4ikCQWt4oSh5RHrz3ukQ=;
	b=FRoUJ30cJ9cVGZX4qcV1cFREaF/TXy8m6yagepzYpvStQ8+BqkKu+wLQJZm50H+9Z+
	NCr3RUbiF1PxG9C+OSJdB2N0xGb3mOw3i6lZBfyVZvU0Cyr9PHoq7ioz6/7xPDefWZFT
	4LSfqvjaiDhGReVv85fU0jNoZ+VaJsvL0tPxxoX1R14qUzD2abN/3/rHrs1T9jnNzKPf
	EbP3dmUxepEsNbICpnlrqVz5pAnqJHv9qs/Vl45GHfq8OO1TVIv5g2wM0kzcYMmhcxeM
	QhlS+uUNJyCnn/uYafAV6L+0UgAth/jwXLpx+pZHrsTdplX9aSeALA4C0QYd+3oUrdjQ
	zb0Q==
Received: by 10.152.102.145 with SMTP id fo17mr6805715lab.2.1332445807505;
	Thu, 22 Mar 2012 12:50:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.2.71 with HTTP; Thu, 22 Mar 2012 12:49:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1203221528190.20343@oneiric>
References: <alpine.DEB.2.02.1203221528190.20343@oneiric>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 22 Mar 2012 12:49:37 -0700
Message-ID: <CAMKF1spQnc3+x31Uxz4gkwy39tbSkL_MNoSjYGka1kN6iq8p3g@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: is "BB_NUMBER_THREAD" a typo?
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
X-List-Received-Date: Thu, 22 Mar 2012 19:59:02 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2012 at 12:29 PM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
>
> =C2=A0is there really a separate BB_NUMBER_THREAD variable, or should tha=
t
> be BB_NUMBER_THREADS?

seems a typo from looks of it. Submit a bug or patch whatever you prefer.


