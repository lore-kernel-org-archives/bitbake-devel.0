Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1TjF8W-0003ej-FU
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Dec 2012 21:12:04 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so2111245lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Dec 2012 11:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=4l3zbsUQ1YmbSmTrNBmZqu5tg5lPyDoboyjsRk+/ZI0=;
	b=vOj5/5EfQweRaLPA4Z4XIr0znEdFW3qqcSctql6g63eahL+ysRQe0pENEyk+ehXZEm
	4C0TJPneuDWF5jXhd3Z0EkuF2QDM0J07joWA3WaJT8cyF/IeJfa1XAegyKj+hVnC8aKL
	Dr3dxBjI0t2w7Gouu7SypNY9m23EASC/MHlT3NxT3zfRmFx2iIX0MHaUw9qAC02u7yYA
	0HEt5CDw900NN5AC9s9KZYvnRgp5JTGBT4tcMCf5P5oDMlAOtXbgFRubxTcDrrQIcE9k
	LsWvLuVo1OM4tQ3sqfdjft9s2FsZQ7J0MzqmoduOAYW3WULb6n5XQN4ZNC3zLBPMIOaL
	UO7A==
MIME-Version: 1.0
Received: by 10.152.162.1 with SMTP id xw1mr519720lab.3.1355428649224; Thu, 13
	Dec 2012 11:57:29 -0800 (PST)
Received: by 10.112.101.135 with HTTP; Thu, 13 Dec 2012 11:57:29 -0800 (PST)
In-Reply-To: <20121212184156.GA743@gmail.com>
References: <20121212184156.GA743@gmail.com>
Date: Thu, 13 Dec 2012 14:57:29 -0500
Message-ID: <CAHUNapTLC4rNkq3iEZjKdLJNY0Tmgx4m+W2hy0npuWy+gPKnrQ@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: =?ISO-8859-1?Q?Eren_T=FCrkay?= <eren@hambedded.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Thu, 13 Dec 2012 20:12:04 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 1:42 PM, Eren T=FCrkay <eren@hambedded.org> wrote:
>  " .bb and .bbclass
> -au BufNewFile,BufRead *.b{b,bclass}    set filetype=3Dbitbake
> +au BufNewFile,BufRead *.b{b,bappend,bclass}    set filetype=3Dbitbake


Don't forget to update the comment too :-)


