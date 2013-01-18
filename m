Received: from mail-la0-f52.google.com ([209.85.215.52])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TwKBn-00062R-Qp
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 23:13:34 +0100
Received: by mail-la0-f52.google.com with SMTP id ee20so2280135lab.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2013 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=zAKdX9/c9OqEViPBZLSnwEFsJifoVMApHPyV3nSl97s=;
	b=Gov1gn/yMbS1IdT823H8oTcDKbj+PWeZG0Xo4Zbp0t3idxy0VEWrkiDR+ppxUm0+2T
	2vxwWt0LrlPySTR1iQSELKTu//+Kbbt9XY7r1j13k7gDL2MOjVs/o7QTExuc1tnp7wRa
	6sQyrrTZDQOMhagjhLT73NbbU71LFjx0HzDmxGJlUYsm1uXRVNVS8PtGPFsZwWy65h3i
	k/P4He4UBXv/MDuQ5rz07wrzt7H8hnOTVDHgmQGi7TOXEHGPshFxlbImBscRLvS2c7+S
	xQiQbEmHrPlCz3JcJUPJKR05pt9pBSuRQiBUNNwmIpXGCBXFTO3fUnzpJll3l/t2byZT
	Rnbg==
X-Received: by 10.152.144.103 with SMTP id sl7mr9864026lab.23.1358546286851;
	Fri, 18 Jan 2013 13:58:06 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Fri, 18 Jan 2013 13:57:45 -0800 (PST)
In-Reply-To: <CAHUNapQHDYC7g4aJnPH5U784rywtX1AnwVkbY9e1RJrB5mPszg@mail.gmail.com>
References: <CAHUNapQHDYC7g4aJnPH5U784rywtX1AnwVkbY9e1RJrB5mPszg@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 18 Jan 2013 14:57:45 -0700
X-Google-Sender-Auth: xkQzdcnIPh6SXm7iO1QaTr_S6RA
Message-ID: <CABcZANmiBe2hkn0s98j729wiEwicLRYuKtoL3NThEojKxE2tCw@mail.gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: task override
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
X-List-Received-Date: Fri, 18 Jan 2013 22:14:06 -0000
Content-Type: multipart/alternative; boundary=e89a8f22bec1d6b4e004d39734ce

--e89a8f22bec1d6b4e004d39734ce
Content-Type: text/plain; charset=UTF-8

On Fri, Jan 18, 2013 at 11:03 AM, Trevor Woerner <twoerner@gmail.com> wrote:

> such that when the build is run, all tasks are run, and when it comes
> time for the "do_rootfs" task, mine is run (which does nothing,
> essentially skipping the whole task) and the build continues.
>

Just override do_rootfs in your 'myimg' recipe and call it done.

Beyond that, a directory isn't a layer. You have to have conf/layer.conf
and add the layer to bblayers.conf for bitbake to see it as a layer.
-- 
Christopher Larson

--e89a8f22bec1d6b4e004d39734ce
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><div class="gmail_extra"><br><div class="gmail_quote">On Fri, Jan 18, 2013 at 11:03 AM, Trevor Woerner <span dir="ltr">&lt;<a href="mailto:twoerner@gmail.com" target="_blank">twoerner@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=":139">such that when the build is run, all tasks are run, and when it comes<br>
time for the &quot;do_rootfs&quot; task, mine is run (which does nothing,<br>
essentially skipping the whole task) and the build continues.<br></div></blockquote></div><br>Just override do_rootfs in your &#39;myimg&#39; recipe and call it done.</div><div class="gmail_extra"><br></div><div class="gmail_extra">

Beyond that, a directory isn&#39;t a layer. You have to have conf/layer.conf and add the layer to bblayers.conf for bitbake to see it as a layer.<br>-- <br>Christopher Larson</div></div>

--e89a8f22bec1d6b4e004d39734ce--
