Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TKd3S-0004lh-QO
	for bitbake-devel@lists.openembedded.org;
	Sun, 07 Oct 2012 00:41:06 +0200
Received: by mail-lb0-f175.google.com with SMTP id y2so1982178lbk.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 06 Oct 2012 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=w+ICjHLke6S9WM3jwhZfv4xTQ2ryI6I5txdVAMGKIoA=;
	b=qvU9zAtc/JBHDib4jSRtuZtQGfLONO2pxOYOiGYmsQkYhqfnHXHyyQ+bGHX04JxXUK
	+SJ4cTN0h7r08cEvUS10/uFwH1lCnMcRnItZ7Qz2OjJ1boJZvrzGTD/2om28FxOWpeo+
	ZXqLldbWbBH4VyhQXFDVox04gM2ufvbdIGmf+Gg7pwj4rHOoipqtFdLpCrYkwyVgXFQU
	i5B/WyKq+UqL2ITugGP9mXMRlOkvgfgBFJ2+LYBcJw2vk09fHWQhjp22JtyKXvuM183I
	b3+p6joQp7pbNDTKBxPGV/+tyUKruSVK+es96brnLoOyGWeWo2jlqrmQUlM7CXOE+h/j
	KOlw==
Received: by 10.112.46.7 with SMTP id r7mr5139131lbm.73.1349562482559; Sat, 06
	Oct 2012 15:28:02 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.19.2 with HTTP; Sat, 6 Oct 2012 15:27:42 -0700 (PDT)
In-Reply-To: <1349267277-1380-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1349267277-1380-1-git-send-email-paul.eggleton@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sat, 6 Oct 2012 15:27:42 -0700
X-Google-Sender-Auth: 20KpuX3PB_pMGzzLvTOsEbxtBd0
Message-ID: <CABcZAN=FnKvxMDB_WHVdAXFz66RMXWtV-9yhHc7D=NpfY=VmMA@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: raise an exception if user specifies protocol=git with http://
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
X-List-Received-Date: Sat, 06 Oct 2012 22:41:06 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Oct 3, 2012 at 5:27 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> It is a common mistake to use http:// and protocol=git when attempting
> to fetch from a git repository using the http protocol; if this is
> detected then throw an error explaining that you need to use git:// with
> protocol=http instead.
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>


Perhaps this should check the protocol= value against the protocols
supported by wget (ftp, http, https, etc), if the parameter is passed,
rather than hardcoding the exceptions.
-- 
Christopher Larson


