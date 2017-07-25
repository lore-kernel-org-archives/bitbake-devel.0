Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ECD7F6FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 22:19:29 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6PMJLNa014923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 25 Jul 2017 23:19:22 +0100
Message-ID: <1501021161.22282.138.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andre McCurdy <armccurdy@gmail.com>, Mark Hatle <mark.hatle@windriver.com>
Date: Tue, 25 Jul 2017 23:19:21 +0100
In-Reply-To: <CAJ86T=UW4gzF_CVhVMFdRCJsm3Nc6ETB9Acj=CUDzv96yUDg+g@mail.gmail.com>
References: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
	<1464702613.3814.2.camel@linuxfoundation.org>
	<CAJ86T=Vp41R2c-XboBxv0NRK5FdFhpOE4WE8GpE8rOfbuXCJPA@mail.gmail.com>
	<dbd9a8df-5baa-d4de-ca19-722843d3b3ea@windriver.com>
	<CAJ86T=UW4gzF_CVhVMFdRCJsm3Nc6ETB9Acj=CUDzv96yUDg+g@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 25 Jul 2017 23:19:23 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Fabien Proriol <fabien.proriol@jdsu.com>, fabien.proriolpatch@kazoe.org
Subject: Re: [PATCH] bb.fetch.git: add a way to avoid git protocol, and force http or https mirrors
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 25 Jul 2017 22:19:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-07-25 at 12:30 -0700, Andre McCurdy wrote:
> On Tue, Jul 25, 2017 at 7:43 AM, Mark Hatle <mark.hatle@windriver.com
> > wrote:
> > Won't the following work:
> > 
> > PREMIRRORS_append = " \
> >      git://.*/.* git://HOST/PATH;protocol=https \n \
> >      git://.*/.* git://HOST/PATH;protocol=http \n \
> > "
> Thanks! Yes, that does work. It's the first time I've ever seen HOST
> or PATH being used as mirror replacement patterns. Useful to know.
> 
> Would a patch adding something similar to the default MIRRORS (ie try
> http[s] as a fallback if the git protocol fails) be acceptable in
> upstream oe-core?

Yes, I'd take such a patch. I'd love to have this better documented.

Cheers,

Richard

