Received: from mail-la0-f52.google.com ([209.85.215.52])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Txh9o-0005lc-11
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 17:57:18 +0100
Received: by mail-la0-f52.google.com with SMTP id fs12so683270lab.39
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2013 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=PfVwzPDZkD3UT2ZhtU5GvLVV2d9vAlnTswsNNs0DHC0=;
	b=llu57Zi3W4Eq7uCknKcG/T8FljpIjeY5q2AFD3KGODlgRpF7S84iW21Qen+qa5/lOd
	eSIZ/Vq9j+DDONNmeOi8G75mVTPW51eNucetfmwOqejNL2G/vSjbe91Ih+30HGNkrYVb
	d5erchLjHKSv1sD6dRBXIv6Zf2kOCrNtrrN3UiRzJREGBxQo56wskHhOdWtAxta1AUOz
	Fyk8mX5ls/H4KhG6nXar1B0VywAPK8mBS8iqNvrzyUdhdu2aSQLAu3/Fezh1NMa/97Ow
	+B+VOkaTQJa2SZrRPyCpyUfrDX7bOfOJgows36BCj/uTLV6JGvWB4g446X2qaujh2966
	AZHQ==
X-Received: by 10.152.134.243 with SMTP id pn19mr21813470lab.11.1358872897731; 
	Tue, 22 Jan 2013 08:41:37 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Tue, 22 Jan 2013 08:41:17 -0800 (PST)
In-Reply-To: <CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
References: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
	<CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 22 Jan 2013 09:41:17 -0700
X-Google-Sender-Auth: vQxYCXla6DeBE8kK9-SM7YCrWiU
Message-ID: <CABcZANnyXfaJiX7xqitTUZp9FLoY3yBy_Y7WbrTXtufYmUxUQw@mail.gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Display mode
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
X-List-Received-Date: Tue, 22 Jan 2013 16:57:29 -0000
Content-Type: multipart/alternative; boundary=f46d044272485d3cc504d3e34041

--f46d044272485d3cc504d3e34041
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 22, 2013 at 9:37 AM, Trevor Woerner <twoerner@gmail.com> wrote:

> On Tue, Jan 22, 2013 at 1:20 AM, Trung Hoang <trungiee@gmail.com> wrote:
> > The current git HEAD of bit bake nicely displays the x threads and what
> is happening on them instead of constantly scrolling in detail what is
> exactly happening.
>
> This feature is called "knotty".
>

No, the knotty UI is the default bitbake UI, and has been for years, even
before this feature was added to it. The new display was initially checked
in as 'knotty2' rather than the default knotty, and eventually knotty2 was
merged back into the default knotty UI.
-- 
Christopher Larson

--f46d044272485d3cc504d3e34041
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 22, 2013 at 9:37 AM, Trevor Woerner <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:twoerner@gmail.com" target=3D"_blank">twoerner@gmail.com</a>&g=
t;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Tue, Jan 22, 2013 at 1:=
20 AM, Trung Hoang &lt;<a href=3D"mailto:trungiee@gmail.com">trungiee@gmail=
.com</a>&gt; wrote:<br>


&gt; The current git HEAD of bit bake nicely displays the x threads and wha=
t is happening on them instead of constantly scrolling in detail what is ex=
actly happening.<br>
<br>
</div>This feature is called &quot;knotty&quot;.<br></blockquote><div><br><=
/div><div style>No, the knotty UI is the default bitbake UI, and has been f=
or years, even before this feature was added to it. The new display was ini=
tially checked in as &#39;knotty2&#39; rather than the default knotty, and =
eventually knotty2 was merged back into the default knotty UI.</div>

</div>-- <br>Christopher Larson</div></div>

--f46d044272485d3cc504d3e34041--
