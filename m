Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 66C37780EC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jun 2017 14:57:50 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v5NEvnQ5018519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 23 Jun 2017 15:57:51 +0100
Message-ID: <1498229869.24449.133.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matthew McClintock <msm-oss@mcclintock.net>, akuster808
	<akuster808@gmail.com>
Date: Fri, 23 Jun 2017 15:57:49 +0100
In-Reply-To: <CAEsOVNcKduRtHRP9rd4TjDcy3zw5hqe-FtHHEqvMaW4BmOMLgg@mail.gmail.com>
References: <1496408567-18673-1-git-send-email-richard.purdie@linuxfoundation.org>
	<CAEsOVNfCAwNkq=dnBWgX=0XXbP7510GRx4Ga=EbYf5yr34vdGw@mail.gmail.com>
	<7c5e6653-c5a4-6622-b40f-58f80a238c07@gmail.com>
	<CAEsOVNcKduRtHRP9rd4TjDcy3zw5hqe-FtHHEqvMaW4BmOMLgg@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 23 Jun 2017 15:57:51 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen: Make calc_taskhash match get_taskhash for file checksums
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
X-List-Received-Date: Fri, 23 Jun 2017 14:57:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-06-23 at 09:29 -0500, Matthew McClintock wrote:
> On Thu, Jun 22, 2017 at 5:29 PM, akuster808 <akuster808@gmail.com>
> wrote:
> > On 06/22/2017 02:10 PM, Matthew McClintock wrote:
> > > 
> > > 
> > > Seeing this issue on some older (err, really olderrrr) versions
> > > of
> > > bitbake. How far back could we backport?
> > Technically 1.34, 1.32 and 1.30 (krogoth). How far back is
> > "olderrrr' ?
> I guess I'm seeing this on krogoth so that would be good.

Did backporting the patch fix it? There are a variety of ways you could
hit this error and I want to confirm it was this specific issue you
were hitting...

Cheers,

Richard

